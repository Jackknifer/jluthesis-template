# 吉林大学本科毕业论文（设计）LaTeX 模板

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![LaTeX](https://img.shields.io/badge/Language-LaTeX-blue.svg)](https://www.latex-project.org/)
[![Overleaf](https://img.shields.io/badge/Overleaf-Support-green.svg)](https://www.overleaf.com/)

## 📖 项目简介

本项目提供了一套**开箱即用**的吉林大学本科毕业论文 LaTeX 模板。

本模板严格按照学校发布的《吉林大学本科毕业论文（设计）撰写要求、书写格式及封面》进行配置，确保格式规范，让同学们专注于论文内容的写作。

---

## 📋 格式标准与实现细节

本模板主要由 `jluthesis.cls` (样式定义) 和 `jluthesis.cfg` (用户配置) 两个核心文件驱动。以下是详细的实现细节与标准对照。

### 1. 封面与承诺书

- **实现方式**: 封面由 LaTeX 代码自动生成 (见 `jluthesis.cls` 中的 `\makecover` 命令)。
- **配置方法**: 所有封面信息（题目、姓名、学号等）均在 `jluthesis.cfg` 中配置，实现了**内容与格式分离**。
- **承诺书**: 采用 `pdfpages` 宏包插入扫描版 PDF (`docs/commitment.pdf`)，确保法律效力。
- **行距控制**: 封面行距可复写 `\linespread` 进行调整 (默认 1.2-1.6倍)。

### 2. 版面与页面设置

- **页面设置**: 使用 `geometry` 宏包，统一设置为 `margin=1in` (约 2.54cm)，符合 A4 标准。
- **页码编排**:
  - 前置部分 (摘要/目录) 用罗马数字 (I, II...)。
  - 主体部分 (引言起) 用阿拉伯数字 (1, 2...)。
  - 位置：页脚右下角 (`\fancyfoot[R]`)。

### 3. 字体与字号

| 项目               | 要求            | 本模板实现                                                          |
| :----------------- | :-------------- | :------------------------------------------------------------------ |
| **中文字体** | 宋体、黑体      | 严格遵循国标，使用 `SimSun.ttc` (宋体) 和 `SimHei.ttf` (黑体)。 |
| **英文字体** | Times New Roman | 配合 `xeCJK` 使用标准字体，保证跨平台兼容。                       |
| **正文**     | 小四号          | `\zihao{-4}` (宋体)。                                             |
| **一级标题** | 三号黑体        | `\zihao{3}`，居中。                                               |
| **二级标题** | 四号黑体        | `\zihao{4}`，左对齐。                                             |
| **封面标题** | 小初号          | `\zihao{-0}` (约 36pt)，宋体加粗。                                |

### 4. 目录

- **标题**: “目录”二字为三号黑体，居中。
- **内容**: 一律使用四号宋体 (`\zihao{4}\songti`)。
- **缩进**: 一级标题顶格 -> 二级缩进1汉字 -> 三级缩进2汉字。
- **连接**: 章、节、条与页码之间均用“......”连接。

### 5. 中、英文摘要

- **标题**: “摘要”/“Abstract” 居中，三号黑体/加粗。
- **正文**: 宋体 (SimSun)，小四号，行距 1.4倍。
- **关键词**: “**关键词：**” 加粗顶格，内容另起一行，首行缩进2字符 (采用全角冒号 `：`)。
- **目录状态**: 不出现在目录中。

### 6. 参考文献

- **标准**: GB/T 7714-2015 顺序编码制。
- **实现**: 使用 `gbt7714` 宏包 + BibTeX (`references.bib`) 管理。
- **编译链**: `XeLaTeX -> BibTeX -> XeLaTeX x2`。

---

## 📂 项目结构说明

请务必保持以下目录结构，**不要随意删除或移动文件夹**，否则编译会报错。

```text
thesis-template/
├── docs/                   # [核心] 文档文件夹 (存放承诺书 commitment.pdf)
├── fonts/                  # [核心] 字体文件夹 (SimSun.TTC, SimHei.TTF)
├── images/                 # [资源] 图片文件夹 (存放论文插图)
├── jluthesis.cfg           # [配置] 论文基本信息配置文件 (题目、姓名、导师等)
├── jluthesis.cls           # [核心] 样式文件 (定义页眉、标题、格式等核心逻辑)
├── main.tex                # [入口] 论文主文件 (在此编写正文)
├── mcode.sty               # [插件] 代码高亮宏包
├── references.bib          # [数据] 参考文献数据库
└── README.md               # [文档] 本说明文件
```

---

## 🛠️ 字体配置说明

关于 **fonts 文件夹** 与 **系统安装字体** 的区别：

1. **推荐方式 (本模板默认)**：使用 `fonts/` 文件夹。

   * **配置代码**: `\newCJKfontfamily{\heiti}[Path=fonts/, AutoFakeBold={1.7}]{SimHei.TTF}`
   * **优点**: **便携性**。无论在 Windows, Mac 还是 Overleaf，只要项目里有这个文件夹，字体就一定正确。
   * **要求**: 必须将 `SimSun.ttc` 和 `SimHei.ttf` 放入 `fonts/` 文件夹。
2. **替代方式**: 使用系统安装字体（需本地安装对应字体）。

   * **配置代码**: 注释掉 `[Path=fonts/, ...]` 部分，直接使用 `\setCJKmainfont{SimSun}`。
   * **缺点**: 依赖操作系统。如果系统（如 Mac）无此字体，编译会报错。
   * **结论**: **强烈建议保持默认设置**，以确保最稳定的编译效果。

---

## 🛠️ 环境准备与编辑器推荐

你可以选择**本地安装**（推荐长期使用）或**在线编辑**（Overleaf，推荐不想安装软件的同学）。

### 方案一：在线编辑 (Overleaf)

1. **打包项目**: 将本模板的所有文件（包括 `fonts/`, `images/` 等）打成一个 `.zip` 压缩包。
2. **上传**: 登录 [Overleaf](https://www.overleaf.com/)，点击 "New Project (创建新项目)" -> "Upload Project (上传项目)"，上传刚才的压缩包。
3. **设置编译器 (关键)**:
   - 点击左下角的 "设置" 按钮。
   - 将 "Compiler (编译器)" 设置为 **XeLaTeX** (否则中文会乱码)。
   - 点击 "Recompile (重新编译)" 即可预览。

### 方案二：本地安装 (TeX Live + 编辑器）

#### 1. 安装 TeX 发行版

推荐安装 **TeX Live** (Windows/Linux) 或 **MacTeX** (macOS)。此步骤耗时较长，请耐心等待。

- **下载地址**: [吉林大学开源镜像站](https://mirrors.jlu.edu.cn/CTAN/systems/texlive/Images/) (下载其中的 `texlive.iso` 即可)

#### 2. 安装编辑器与配置

你可以根据个人习惯选择编辑器。

**选项 A：Visual Studio Code (现代化，推荐)**

推荐使用 **Visual Studio Code** 或 Google 的 **Antigravity IDE**。

- **Antigravity IDE**: Google 推出的集成 AI 模型的现代化 IDE，基于 VS Code 构建，内置强大的 AI 辅助编程功能。
- **Visual Studio Code**: 经典的轻量级编辑器。
  - 插件推荐: `LaTeX Workshop`。
  - **配置教程**: 关于 VS Code + LaTeX Workshop 的详细配置，请参考知乎大佬 **Ali-loner** 的文章：
    👉 **[Visual Studio Code (vscode)配置LaTeX - Ali-loner的文章 - 知乎](https://zhuanlan.zhihu.com/p/166523064)**
  - **编译方式 (重要)**: 请在侧边栏 "TeX" 面板中选择 recipe **`XeLaTeX -> BibTeX -> XeLaTeX x2`** 进行编译，以确保参考文献正确生成。

**选项 B：TeXstudio (专为 LaTeX 设计，适合新手)**

如果你不想折腾插件配置，可以使用 TeXstudio，它开箱即用，对新手非常友好。

- **下载地址**: [TeXstudio 官网](https://www.texstudio.org/)
- **保姆级教程**: 推荐参考知乎大佬**无为**的文章，详细讲解了 TeX Live + TeXstudio 的安装与配置：
  👉 **[2025 最新LaTeX【texlive+TeXstudio】安装保姆教程 - 无为的文章 - 知乎](https://zhuanlan.zhihu.com/p/1921310237857648721)**

> **TeXstudio 简易配置指南**:
>
> 1. 安装完 TeX Live 后，安装并打开 TeXstudio。
> 2. 点击菜单栏 `Options (选项)` -> `Configure TeXstudio (设置 TeXstudio)`。
> 3. 在左侧选择 `Build (构建)`，将 `Default Compiler (默认编译器)` 修改为 **XeLaTeX** (关键步骤，否则中文不显示)。
> 4. 点击 `OK (确定)` 保存。

---

## 📝 写作指南

本模板已为你搭好骨架，你只需要在 `main.tex` 中填充内容。

### 1. 封面与基本信息

本模板采用**自动生成封面**的方式，无需 Word 制作。

1. **填写信息**: 打开项目根目录下的 `jluthesis.cfg` 文件，按需填写以下信息：
   * 论文题目 (中文 & 英文)
   * 作者信息 (姓名、学号、班级、专业、学院)
   * 导师信息 (姓名、职称)
   * 日期
2. **生成封面**: 编译 `main.tex` 时，`\makecover` 命令会读取配置自动生成标准封面。
3. **承诺书**:
   * 请将学校下发的《承诺书》打印、签字、扫描。
   * 将扫描后的 PDF 文件命名为 `commitment.pdf`。
   * 放入项目的 `docs/` 文件夹中。
   * 模板会自动将其插入到封面之后。

### 2. 摘要与关键词

- **中文摘要**: 在 `main.tex` 中搜索 `中文摘要`，修改该部分文字。
- **英文摘要**: 在 `main.tex` 中搜索 `Abstract`，修改英文内容。
- **关键词**: 在摘要下方，找到 `\textbf{关键词:}`，在后面填写关键词，用分号分隔。

### 3. 目录

- 目录是**自动生成**的，不要手动去写。
- **更新目录**: 每次修改章节标题后，目录可能不会立即更新。请连续编译 2 次（VS Code 通常会自动处理），目录就会刷新。

### 4. 正文章节

使用以下命令来组织你的论文结构。这会自动处理编号（如 1.1, 1.1.1）和字体大小（三号、四号等）。

```latex
% 一级标题 (章)
\section{引言}  

% 二级标题 (节)
\subsection{研究背景}   

% 三级标题 (小节)
\subsubsection{具体分析}  
```

### 5. 插入图片

1. 将图片文件放入 `images/` 文件夹。
2. 使用 `figure` 环境插入：

```latex
\begin{figure}[H] % [H] 表示"Here", 强制图片固定在当前位置, 不自动浮动
    \centering    % 图片居中
    % width=0.8\textwidth 表示图片宽度占页面宽度的 80%
    \includegraphics[width=0.8\textwidth]{images/example.jpg} 
    \caption{这是图片标题} % 自动生成 "图 1.1 这是图片标题"
    \label{fig:example}  % 设置标签, 用于在文中引用
\end{figure}
```

- **文中引用**: 使用 `如图 \ref{fig:example} 所示`，编译后会自动变成“如图 1.1 所示”。

### 6. 插入表格 (三线表)

学校通常要求使用“三线表”（顶部和底部线粗，中间线细）。

```latex
\begin{table}[H]
    \centering
    \caption{这是表格标题}
    \label{tab:data}
    \begin{tabular}{ccc} % ccc 表示三列都居中, l=left, r=right
        \toprule  % 顶粗线
        列1名称 & 列2名称 & 列3名称 \\
        \midrule  % 中细线
        数据A & 数据B & 数据C \\
        数据D & 数据E & 数据F \\
        \bottomrule % 底粗线
    \end{tabular}
\end{table}
```

### 7. 数学公式

- **行内公式**: 夹在文字中间的公式，使用两个美元符号 `$...$`。
  - 例如: `$E = mc^2$`。
- **独立公式** (自动编号): 使用 `equation` 环境。

```latex
\begin{equation}
    f(x) = \frac{1}{\sqrt{2\pi}\sigma} e^{-\frac{(x-\mu)^2}{2\sigma^2}}
    \label{eq:gauss} % 标签, 用于引用
\end{equation}
```

- **文中引用**: `如公式 \ref{eq:gauss} 所示`。

### 8. 插入代码

本模板集成了 `mcode.sty`（基于强大的 `listings` 宏包），专门用于插入代码，支持语法高亮、自动行号和边框。

#### (1) 基本用法 (代码环境)

直接在文档中编写代码：

```latex
\begin{lstlisting}
% 这里写你的代码
import numpy as np
print("Hello World")
\end{lstlisting}
```

#### (2) 进阶用法

- **指定语言**: 默认配置为 MATLAB 风格高亮。如果要插入 Python、C++ 等其他语言，请指定 `language` 参数：

```latex
\begin{lstlisting}[language=Python]
def foo():
    return "bar"
\end{lstlisting}
```

- **行内代码**: 在正文中插入代码片段，使用 `\mcode{...}` 命令：

```latex
我们在函数 \mcode{main()} 中调用了...
```

- **导入外部文件**: 如果代码太长，建议放在单独的文件中（如 `code/script.py`），然后导入：

```latex
\lstinputlisting[language=Python]{code/script.py}
\lstinputlisting{filename}
```

- **配置**: 模板默认开启了代码边框和行号。如果需要修改（如去掉行号），请查阅 `mcode.sty` 文件中的注释进行调整。

### 9. 参考文献

本模板使用 **BibTeX** 管理参考文献，并配合 `gbt7714` 宏包自动生成符合国标（GB/T 7714-2015）的格式。

**使用步骤**:

1. **准备数据**:
   * 在 Google Scholar、百度学术或知网搜索文献。
   * 点击“引用” -> “BibTeX” -> 复制内容。
   * 将复制的内容粘贴到项目根目录下的 `references.bib` 文件中。
2. **在文中引用**:
   * 找到你刚才粘贴的 BibTeX 条目第一行的大括号后面的标识符 (Key)，例如 `@article{jiang2025robust, ...}` 中的 `jiang2025robust`。
   * 在 `main.tex` 正文需要引用的地方使用 `\cite{jiang2025robust}`。
3. **编译**:
   * 通常编辑器会自动处理。如果引用显示为 `[?]`，请尝试重新编译 1-2 次。

**示例**:

```latex
% 在 main.tex 中
根据张三等人的研究 \cite{zhang2025robust} ...

% 编译后效果
根据姜亚蕾等人的研究 [1] ...
```

> **注意**: 不要直接要在 `main.tex` 里手动写 `\bibitem`，所有的文献都应该放在 `references.bib` 里统一管理。

---

## ⚙️ 进阶定制 (修改格式)

如果你需要调整格式以满足特殊需求，请参考以下指南。

### 1. 修改页边距

- **位置**: `jluthesis.cls` 文件。
- **修改**: 找到 `\RequirePackage[margin=1in]{geometry}`，修改数值（如 `margin=2.5cm`）。

### 2. 修改行距

- **封面**: 在 `jluthesis.cls` 中找到 `\makecover` 定义下的 `\linespread{...}`。
- **正文**: 在 `jluthesis.cls` 或 `main.tex` 中添加 `\linespread{数值}`。

### 3. 修改字体 (从文件 vs 系统字体)

模板默认使用 `fonts/` 文件夹下的字体文件，这样在不同电脑上（包括 Overleaf）效果一致。
如果你想**使用系统安装的字体**（例如你电脑上已经安装了华文行楷等特殊字体）：

1. **注释掉**带 `Path=fonts/` 的那行代码。
2. **使用**系统字体名：

```latex
% \setCJKmainfont{SimSun} % 直接使用系统宋体
% \newCJKfontfamily{\kaiti}{KaiTi} % 定义楷体
```

### 4. 修改页眉页脚

本模板使用 `fancyhdr` 宏包。

```latex
\fancypagestyle{yemei}{
    \fancyhf{} % 清空
    \fancyhead[C]{...} % C=Center, L=Left, R=Right
    \fancyfoot[C]{\thepage} % 页脚页码
}
```

### 5. 目录显示深度

如果你希望目录显示到三级标题（例如 1.1.1），请修改：

```latex
\setcounter{tocdepth}{3} % 2=显示到subsection, 3=显示到subsubsection
```

---

## ❓ 常见问题

**Q1: 为什么编译后生成了一堆 `.aux`, `.log`, `.out` 文件？**
A: 这些是 LaTeX 编译过程中产生的辅助文件，用于记录交叉引用、目录等信息。**不要手动删除它们**，否则目录和引用会消失。

- **清理方法**: VS Code 插件通常提供了 "Clean up auxiliary files" 功能。
- **关于 main.tex 的位置**: 建议初学者将 `main.tex` 放在根目录，而不是单独文件夹。因为 LaTeX 引用图片和字体时默认基于当前文件路径，如果移动 `main.tex`，所有 `images/` 和 `fonts/` 的路径都需要修改（变成 `../images/`），这会增加出错的风险。

**Q2: 编译报错 "File `docs/commitment.pdf' not found"？**

A: 这是因为缺少承诺书文件。请将你的承诺书 PDF 命名为 `commitment.pdf` 并放入 `docs/` 文件夹。如果不暂时不需要承诺书，可以在 `main.tex` 中注释掉 `\includepdf{docs/commitment.pdf}`。

**Q3: 中文全是乱码或者是方框？**
A:

- 确保文件是以 **UTF-8** 编码打开的（VS Code 右下角会显示编码）。
- 确保你正确配置了字体（见“字体配置”一节），并且用的是 **XeLaTeX** 编译器。

**Q4: Overleaf 上编译超时 (Time out)？**
A: 你的图片可能太大了，或者代码有无限循环错误。检查日志 (Logs)。

---

## ⚠️ 声明

本模板是一个简单可用的吉林大学本科学士学位论文 LaTeX 模板，旨在帮助同学们减轻毕业论文撰写过程中的排版工作量。

**关于作者**：本项目由**吉林大学数学学院**一名大四学生制作。由于个人水平有限，时间仓促，模板中难免存在错误或疏漏，恳请各位朋友批评指正。同时也是“抛砖引玉”，欢迎更多校友制作出更优秀的模板丰富吉大的开源资源！

**❗️ 重要提示（必读）：**

1. **非官方版本**：截止目前，**吉林大学及数学学院**官方仅提供了毕业论文撰写要求，**并未**发布、授权或认证过任何 LaTeX 模板。
2. **仅供参考**：本模板是作者对照《吉林大学本科毕业论文（设计）撰写要求》制作的。但这毕竟是个人实现，**不保证**完全符合所有审查老师的个人喜好或学院的临时变动。
3. **使用须知**：具体是否使用本模板，请各位同学根据自身情况及导师要求**自行定夺**。如果在使用过程中遇到格式问题，请以学校发布的官方要求为准进行调整。

随时倾听各位朋友的批评与教导！提前对发现缺陷并反馈的朋友报以诚挚的谢意！

---

## 📜 许可证

本项目采用 MIT 许可证开源。遵循吉林大学学位论文规范。
