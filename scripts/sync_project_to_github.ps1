[CmdletBinding()]
param(
    [string]$Message = "",
    [switch]$StatusOnly,
    [switch]$SkipFetch,
    [switch]$SkipPush
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Invoke-Git {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    & git @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "git $($Arguments -join ' ') failed with exit code $LASTEXITCODE"
    }
}

function Get-GitOutput {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    $stdoutFile = [System.IO.Path]::GetTempFileName()
    $stderrFile = [System.IO.Path]::GetTempFileName()

    try {
        & git @Arguments 1> $stdoutFile 2> $stderrFile

        $stdout = (Get-Content $stdoutFile -Raw -ErrorAction SilentlyContinue)
        $stderr = (Get-Content $stderrFile -Raw -ErrorAction SilentlyContinue)

        if ($LASTEXITCODE -ne 0) {
            $messageParts = @()
            if (-not [string]::IsNullOrWhiteSpace($stdout)) {
                $messageParts += $stdout.Trim()
            }
            if (-not [string]::IsNullOrWhiteSpace($stderr)) {
                $messageParts += $stderr.Trim()
            }
            throw ($messageParts -join [Environment]::NewLine)
        }

        if ([string]::IsNullOrWhiteSpace($stdout)) {
            return ""
        }

        return $stdout.Trim()
    }
    finally {
        Remove-Item $stdoutFile -Force -ErrorAction SilentlyContinue
        Remove-Item $stderrFile -Force -ErrorAction SilentlyContinue
    }
}

function Test-GitStatePath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    return Test-Path (Join-Path ".git" $Path)
}

$repoRoot = Get-GitOutput -Arguments @("rev-parse", "--show-toplevel")
Set-Location $repoRoot

if ((Test-GitStatePath -Path "MERGE_HEAD") -or
    (Test-GitStatePath -Path "rebase-merge") -or
    (Test-GitStatePath -Path "rebase-apply")) {
    throw "A merge or rebase is already in progress. Finish that flow before running this sync script."
}

$branch = Get-GitOutput -Arguments @("rev-parse", "--abbrev-ref", "HEAD")
$statusText = Get-GitOutput -Arguments @("status", "--porcelain")
$hasChanges = -not [string]::IsNullOrWhiteSpace($statusText)

Write-Host "Repository: $repoRoot"
Write-Host "Branch: $branch"

if ($StatusOnly) {
    Invoke-Git -Arguments @("status", "--short", "--branch")
    exit 0
}

if (-not [string]::IsNullOrWhiteSpace($Message)) {
    if ($hasChanges) {
        Write-Host "Local changes detected. Creating a commit..."
        Invoke-Git -Arguments @("add", "-A")
        Invoke-Git -Arguments @("commit", "-m", $Message)
        $hasChanges = $false
    }
    else {
        Write-Host "No uncommitted changes detected. Skipping commit."
    }
}

if (-not $SkipFetch) {
    Write-Host "Fetching remote updates..."
    Invoke-Git -Arguments @("fetch", "origin")
}

$upstream = ""
try {
    $upstream = Get-GitOutput -Arguments @("rev-parse", "--abbrev-ref", "--symbolic-full-name", "@{u}")
}
catch {
    if ($SkipPush) {
        throw "This branch has no upstream and push was skipped. Set the upstream branch first."
    }

    Write-Host "No upstream branch found. Pushing once to create tracking..."
    Invoke-Git -Arguments @("push", "-u", "origin", $branch)
    Write-Host "Initial push completed."
    Invoke-Git -Arguments @("status", "--short", "--branch")
    exit 0
}

$counts = Get-GitOutput -Arguments @("rev-list", "--left-right", "--count", "HEAD...$upstream")
$parts = $counts -split "\s+"

if ($parts.Count -lt 2) {
    throw "Unable to parse ahead/behind state: $counts"
}

$ahead = [int]$parts[0]
$behind = [int]$parts[1]

Write-Host "Upstream: $upstream"
Write-Host "Ahead: $ahead"
Write-Host "Behind: $behind"

if ($ahead -gt 0 -and $behind -gt 0) {
    throw "Local and remote history have diverged. Resolve the divergence manually before rerunning the script."
}

if ($behind -gt 0) {
    Write-Host "Remote is ahead. Running fast-forward pull..."
    Invoke-Git -Arguments @("pull", "--ff-only", "origin", $branch)
}

$countsAfterPull = Get-GitOutput -Arguments @("rev-list", "--left-right", "--count", "HEAD...$upstream")
$partsAfterPull = $countsAfterPull -split "\s+"
$aheadAfterPull = [int]$partsAfterPull[0]

if (-not $SkipPush) {
    if ($aheadAfterPull -gt 0) {
        Write-Host "Pushing local commits to GitHub..."
        Invoke-Git -Arguments @("push", "origin", $branch)
    }
    else {
        Write-Host "No commits need to be pushed."
    }
}

Write-Host "Sync complete."
Invoke-Git -Arguments @("status", "--short", "--branch")
