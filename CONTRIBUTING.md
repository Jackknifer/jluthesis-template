# Contributing

感谢你帮助改进这个吉林大学本科毕业论文 LaTeX 模板。

本仓库的 `README.md` 主要面向模板使用者，本文档主要面向贡献者和维护者，用于说明问题反馈、代码修改、同步流程和公开发布时的注意事项。

## 1. 适合提交什么

- 模板编译失败、路径错误、字体错误、编码错误。
- 封面、目录、摘要、参考文献等排版与学校要求的明显偏差。
- `README.md`、FAQ、示例内容不准确或不清晰。
- GitHub 协作流程、Issue / PR 模板、发布说明等维护文档改进。

## 2. 如何反馈问题

推荐优先使用仓库内的 GitHub Issue 模板：

- `Bug Report`：记录编译失败、样式错误、字体缺失、路径问题。
- `Documentation Task`：记录 README、FAQ、示例和说明文档更新。

提交问题时，尽量补充以下信息：

- 操作系统与编辑器。
- 使用的编译链，例如 `XeLaTeX -> BibTeX -> XeLaTeX x2`。
- 触发问题的文件。
- 报错日志、截图或最小复现步骤。

## 3. 提交修改前的检查

1. 修改前先运行 `git status`，确认工作区状态。
2. 完成修改后，至少用推荐编译链验证一次模板能正常产出 PDF。
3. 如果改动影响使用方式、目录结构或行为，请同步更新 `README.md`。
4. 如果改动适合被记录为对外可见变化，请同步更新 `CHANGELOG.md`。
5. 使用 `git add <文件名>` 显式暂存准备提交的文件，再执行同步脚本：

```powershell
powershell -ExecutionPolicy Bypass -File "scripts/sync_project_to_github.ps1" -Message "你的提交说明"
```

如果你确认当前所有改动都应该一起提交，再显式使用：

```powershell
powershell -ExecutionPolicy Bypass -File "scripts/sync_project_to_github.ps1" -StageAll -Message "你的提交说明"
```

更完整的同步细节见 `docs/GITHUB_SYNC.md`。

## 4. 公开仓库注意事项

在把内容同步到 GitHub 之前，请先确认这些文件是否适合公开分发：

- 不要提交带真实签字、学号、手机号等个人信息的材料。
- 不要提交纯本地调试产物、缓存文件或临时输出。
- 如果仓库包含字体、学校官方文档、校徽校名图片等第三方资产，请先确认是否具有再分发权限。
- 如果某个文件只适合本地使用，不适合公开仓库，优先改成 README 说明“由使用者自行补充”。

## 5. 维护者资料

以下文件更偏维护者视角，适合在需要时配合阅读：

- `PROJECT_MANAGEMENT.md`：项目目标、任务分层、里程碑与维护流程。
- `docs/GITHUB_SYNC.md`：GitHub 连接状态、推荐同步流程、冲突处理方式。
- `CHANGELOG.md`：版本变更记录。

## 6. 版本发布

如果需要做正式发布，推荐按下面顺序执行：

1. 确认工作区干净，且模板已通过最终编译验证。
2. 将本次对外变化整理到 `CHANGELOG.md`。
3. 合并或推送最终提交到 `main`。
4. 创建注释标签，例如 `v0.1.0`。
5. 在 GitHub 上创建同名 Release，并把版本说明与 `CHANGELOG.md` 对齐。
