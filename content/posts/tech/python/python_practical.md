+++
title = 'Python Practical'
date = 2025-10-16T14:22:00+08:00
draft = false
slug = "e985480"
description = ""
summary = ""
tags = [ "技术", "开发" ]
categories = [ "tech" ]
cover = ""
author = "MapleScraps"

+++

# Python Manage

Extremely fast Python package and project manager, written in Rust.

## Highlight
- 🚀 A single tool to replace pip, pip-tools, pipx, poetry, pyenv, twine, virtualenv, and more.  
- ⚡️ 10-100x faster than pip.  
- 🗂️ Provides comprehensive project management, with a universal lockfile.  
- ❇️ Runs scripts, with support for inline dependency metadata.  
- 🐍 Installs and manages Python versions.  
- 🛠️ Runs and installs tools published as Python packages.  
- 🔩 Includes a pip-compatible interface for a performance boost with a familiar CLI.  
- 🏢 Supports Cargo-style workspaces for scalable projects.  
- 💾 Disk-space efficient, with a global cache for dependency deduplication.  
- ⏬ Installable without Rust or Python via curl or pip.  
- 🖥️ Supports macOS, Linux, and Windows.  

## Installation ( Windows )
Install uv with our official standalone installer:
>```powershell
> powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
>```
>
Request a specific version by including it in the URL:
>```powershell
> powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/0.9.3/install.ps1 | iex"
>```
>

> [!TIP]
>
> The installation script may be inspected before use:
>
> ```powershell
> powershell -c "irm https://astral.sh/uv/install.ps1 | more"
> ```
> 


## Installation ( Linux Ubuntu )
uv provides a standalone installer to download and install uv:  
Use curl to download the script and execute it with sh:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

If your system doesn't have curl, you can use wget:
```bash
wget -qO- https://astral.sh/uv/install.sh | sh
```

Request a specific version by including it in the URL:
```bash
curl -LsSf https://astral.sh/uv/0.9.3/install.sh | sh
```

> [!TIP]
>
> The installation script may be inspected before use:
>
> ```powershell
> curl -LsSf https://astral.sh/uv/install.sh | less
> ```



## Code Practical

#### UVX Project

这篇用最简单的话，手把手说明：用 `uv` 管理 Python 项目与依赖，用 `uvx` 运行工具和打包；怎样初始化项目、创建并激活虚拟环境、安装第三方库、打包分发给团队，以及团队如何快速安装。

重要区分：
- `uv`：项目依赖管理/安装/运行（替代 pip、加速安装），还能自动创建本地虚拟环境（`.venv`）。
- `uvx`：像 pipx 一样“隔离运行工具”，也可直接调用打包工具。

#### 1. 用 uv init 初始化最简项目
- 在新目录中初始化：
```bash
mkdir myproj && cd myproj
uv init
```
- `uv init` 会生成最小的 `pyproject.toml`（PEP 621），你可按需修改项目名、作者、Python 版本等。
- 补充推荐的 src 布局与示例代码：
```
src/
  myproj/
    __init__.py
    app.py
tests/
  test_app.py
```
- 示例代码：
```python
# src/myproj/app.py
def hello(name: str) -> str:
    return f"Hello, {name}!"

if __name__ == "__main__":
    print(hello("World"))
```
- 创建并安装依赖与虚拟环境：
```bash
uv sync
```
- 运行代码：
```bash
uv run python src/myproj/app.py
```

#### 2. 创建与激活虚拟环境（两种方式）
- 用 `uv` 自动管理（推荐）：
  - 在项目根执行 `uv sync`，`uv` 会自动创建本地虚拟环境 `.venv` 并安装依赖。
  - 运行代码时无需手动激活：
    ```bash
    uv sync
    uv run python src/myproj/app.py
    ```
- 手动创建与激活（标准 venv）：
  - 创建：`python -m venv .venv`
  - 激活：
    - Windows（PowerShell）：`./.venv/Scripts/Activate.ps1`
    - Windows（cmd）：`\.venv\Scripts\activate`
    - macOS/Linux（bash/zsh）：`source .venv/bin/activate`
  - 退出：`deactivate`
  - 激活后安装依赖可用：
    ```bash
    uv pip install -r requirements.txt  # 或 uv add/sync
    ```

#### 3. 安装第三方库（用 uv 管理依赖）
- 安装 `uv`（见《UVX》文档）并确认：`uv --version`。
- 在项目根目录执行：
```bash
# 添加运行时依赖（写入 pyproject.toml 并安装）
uv add requests

# 添加开发依赖（只在开发/测试用）
uv add -D ruff black pytest

# 安装/同步所有依赖（根据 pyproject 与锁定文件）
uv sync
```
- 运行代码（不污染系统环境）：
```bash
uv run python src/myproj/app.py
```

#### 4. 使用 uvx 运行工具（不改动项目依赖）
- 隔离运行常用工具（首次会解析并缓存）：
```bash
uvx ruff --version
uvx black --help
uvx pyright --version
```
- 指定 Python 版本运行：
```bash
uvx --python 3.12 ruff --version
```
- 从 URL/Git/本地路径来源运行某工具：
```bash
uvx --from https://github.com/httpie/cli http --version
uvx --from ./ some-local-cli
```

#### 5. 打包项目（生成 sdist 和 wheel）
- 最简单方法：用 `build` 工具（通过 uvx 运行）：
```bash
uvx build
# 产物在 dist/ 目录： .tar.gz（sdist）和 .whl（wheel）
```
- 如需发布到 PyPI，可结合 `twine`：
```bash
uvx twine upload dist/*
```

#### 6. 团队协作：如何快速安装项目依赖
- 方式 A（推荐，用 uv）：
```bash
# 团队成员安装 uv 后，在项目根目录执行：
uv sync
# 一次性安装 pyproject.toml 声明的所有依赖（含锁定版本）
```
- 方式 B（requirements.txt 方案）：
```bash
# 维护 requirements.txt 后，团队成员可执行：
uv pip install -r requirements.txt
```
- 项目本地可编辑安装（开发场景）：
```bash
uv pip install -e .
```

#### 7. 最常用命令速查（一屏足够）
- 虚拟环境：`uv sync` 自动创建/使用 `.venv`；或 `python -m venv .venv` + 激活。
- 依赖管理：
  - 添加运行时依赖：`uv add <pkg>`
  - 添加开发依赖：`uv add -D <pkg>`
  - 安装/同步：`uv sync`
- 运行代码：`uv run python <script>`
- 运行工具（隔离）：`uvx <tool> [args]`
- 指定版本/来源：
  - `uvx "tool==x.y"`、`uvx --python 3.12 <tool>`
  - `uvx --from <url|git|path> <tool>`
- 打包：`uvx build`（产物在 `dist/`）
- 发布：`uvx twine upload dist/*`

#### 8. 容易踩雷的地方（简明版）
- 混用 `pip` 与 `uv`：尽量统一用 `uv` 管理，避免环境不一致。
- PATH 未生效：安装后终端不识别 `uv/uvx`，重启终端或手动加 PATH。
- Python 版本不匹配：用 `uvx --python X.Y` 明确工具的运行版本。
- 锁定版本一致性：团队应共享锁定文件（如 `uv.lock`），用 `uv sync` 安装确保一致。
- 打包失败：检查 `pyproject.toml` 的 `[build-system]` 是否配置正确；源代码需可被发现（src 布局、包名对应）。
- 入口点名称：运行的是工具的入口点，不一定与包名相同（如 `httpie` 的命令是 `http`）。
- 使用 `uv` 创建项目，在IDE环境不建议直接运行python终端，最好使用 `uv run < script.py >` 最不容易报错。或者：

  - #### 修改 VS Code 的解释器设置 (如果你在使用 VS Code)

    从截图看你可能是在 VS Code 的终端里操作。VS Code 的“运行”按钮有时会记住旧的解释器路径。

    1. 按下快捷键 `Ctrl + Shift + P`。
    2. 输入并选择 **"Python: Select Interpreter"**。
    3. 找到并选择带有 **`./venv`** 或 **`uv`** 标记的那一个。
    4. 重新打开一个终端运行程序。

#### 9. 一个从零到发布的最小流程
```bash
# 1) 创建结构并写 pyproject.toml
# 2) 管理依赖
uv add requests
uv add -D ruff black pytest
uv sync

# 3) 开发与检查
uv run python src/myproj/app.py
uvx ruff check .
uvx black .
pytest  # 或 uvx pytest

# 4) 打包与发布
uvx build
uvx twine upload dist/*
```