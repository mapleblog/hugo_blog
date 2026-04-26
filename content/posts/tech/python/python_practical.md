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



### UV Python .venv 

#### 报错原因分析

1. 你的 `.venv` 曾经是基于 **Python 3.14** 创建的。
2. 这个虚拟环境实际上是一个“指向” `AppData\Roaming\uv\python\...` 路径下原始 Python 文件的快捷方式（符号链接）。
3. **现状：** 那个路径下的 Python 3.14 执行文件消失了，或者路径变了，导致 `.venv` 变成了“空壳”，`uv` 找不到它，所以报了 103 错误。

   

### 排错方法步骤

最简单且最彻底的方法是**删掉旧环境，让 `uv` 重新找/下载 3.14 并重建环境**。请按以下顺序执行命令：

#### 第一步：删除损坏的虚拟环境

在你的项目根目录下（即报错的那个目录下），执行删除命令：

```powershell
# 如果你在 PowerShell
Remove-Item -Recurse -Force .venv

# 如果你在 CMD
rd /s /q .venv
```



#### 第二步：确保 uv 拥有 Python 3.14

让 `uv` 重新下载并安装 3.14 版本（以防它之前下载的不完整）：

```powershell
uv python install 3.14
```



#### 第三步：重新同步项目

执行同步命令，`uv` 会自动根据 `pyproject.toml` 创建全新的 `.venv`：

```powershell
uv sync
```



### 为什么会发生这种情况？

- **手动清理过：** 你可能清理过 `AppData` 下的缓存文件。
- **版本更新：** `uv` 更新了其管理 Python 的存放结构。
- **多版本重叠：** 你之前提到的三个 Python 版本中，可能并没有 3.14，而 `uv` 之前尝试自动下载 3.14 时失败了或被意外中断，留下了一个错误的引用。



### 验证方法

执行完上述操作后，输入以下命令检查：

```powershell
uv run python --version
```



### 解决虚拟环境指向 `AppData` 路径失效（符号链接断开）的问题方案

解决 `uv` 虚拟环境指向 `AppData` 路径失效（符号链接断开）的问题，最“标准”且“正确”的做法并非只是简单的删除，而是通过 **配置管理** 和 **版本锁定** 来确保环境的稳定性。



### 第一层：配置持久化的 Python 版本（防止“找不到”版本）

`uv` 默认会动态寻找符合要求的 Python。如果你的项目必须使用 3.14，你应该在项目根目录创建一个 **版本锁定文件**，这样 `uv` 就会固定去某个路径寻找，而不是每次都尝试重新发现。

**执行命令：**

```bash
uv python pin 3.14
```

- **效果：** 这会在项目根目录生成一个 `.python-version` 文件。
- **好处：** 无论你的系统环境变量怎么变，`uv` 都会优先读取这个文件，确保它寻找的“原始 Python”路径是一致的。

  

### 第二层：强制关联到“本地已安装”的 Python（不使用 uv 管理的版本）

如果你不希望 `uv` 把 Python 下载到 `AppData\Roaming\uv\python`（因为那里的文件容易在清理系统时被删掉），你可以强制 `uv` 使用你手动安装在 C 盘或 D 盘的 Python。

**做法：使用系统路径创建环境**

```bash
# 假设你手动安装的 Python 3.14 在 C:\Python314\python.exe
uv venv --python C:\Python314\python.exe
```

- **正确性：** 这样做产生的 `.venv` 符号链接会指向你的**手动安装目录**。只要你不卸载那个 Python，虚拟环境就永远不会失效。

  

### 第三层：改变链接模式（从“符号链接”改为“复制”）

默认情况下，为了节省空间，`uv` 创建虚拟环境时使用的是 **符号链接 (Symlinks)**。如果原始 Python 文件移动了，虚拟环境就坏了。你可以配置 `uv` 将 Python 核心文件**复制**到虚拟环境中，虽然占用空间稍大（约几十 MB），但极其稳健。

**做法：修改创建环境的模式**

```bash
uv venv --link-mode copy
```

或者在你的 `pyproject.toml` 中通过环境变量持久化此行为。这样即使 `AppData` 下的原始文件消失了，`.venv` 内部的 Python 依然可以运行。



以下是使用 GitHub 协作的完整流程：




------



### 标准项目配置方案 github + uv

#### 第一步：在本地初始化新项目 (电脑 A / 家里)

| **步骤** | **命令**                     | **核心目的**                                              |
| -------- | ---------------------------- | --------------------------------------------------------- |
| **1**    | `git init`                   | 开始版本控制。                                            |
| **2**    | **`uv init`**                | 生成基础配置文件（`pyproject.toml`）。                    |
| **3**    | **`uv python install 3.14`** | **准备引擎**：确保本地有 3.14 的物理文件。                |
| **4**    | **`uv python pin 3.14`**     | **确立标准**：生成 `.python-version` 文件，钉住版本。     |
| **5**    | **配置 `.gitignore`**        | **设置防线**：确保 `.venv/` 和 `.uv/` 不会被传上 GitHub。 |
| **6**    | **`uv add requests`**        | **创建环境**：安装依赖，并自动生成正确的 `.venv`。        |
| **7**    | `git add .`                  | 暂存所有“配方”文件。                                      |
| **8**    | `git commit -m "..."`        | 提交初始版本（含 lock 文件和 pin 文件）。                 |
| **9**    | `git branch -M main`         | 分支命名规范化。                                          |
| **10**   | `git remote add ...`         | 关联 GitHub 远程仓库。                                    |
| **11**   | `git push -u origin main`    | **正式上线**。                                            |

假设你已经有一个项目目录。

1. **初始化 Git 和 uv：**

   ```bash
   git init
   uv python install <python_version>
   uv init
   ```

   

2. **配置 `.gitignore` (最关键一步)：** `uv init` 通常会自动生成一个 `.gitignore` 文件。请确保里面包含以下内容，防止把坏掉的环境传上去：

   ```plaintext
   # --- Python 运行环境 ---
   # 虚拟环境目录（这是你 103 报错的元凶，绝对不要传！）
   .venv/
   
   # --- uv 特有缓存 ---
   # uv 的本地持久化缓存
   .uv/
   
   # --- Python 编译产物 ---
   # 字节码文件，加快运行速度但与机器相关
   __pycache__/
   *.pyc
   *.pyo
   *.pyd
   
   # --- 敏感信息与本地配置 ---
   # 存放数据库密码、API Key 的环境变量文件
   .env
   .env.local
   
   # --- 构建与分发 ---
   # 打包生成的产物
   dist/
   build/
   *.egg-info/
   
   # --- 编辑器配置 (可选，视团队习惯而定) ---
   .vscode/
   .idea/
   .DS_Store
   ```

   *注：如果你希望两台电脑强制使用完全一样的 Python 版本，可以**不**忽略 `.python-version`，将其也上传。*

   

3. **锁定版本并同步：**

   ```bash
   uv python pin 3.14  # 固定版本
   uv add requests     # 安装依赖
   uv sync             # 生成 uv.lock 锁定文件
   ```

   执行 **uv python pin 3.14** 会在项目根目录下创建一个名为 **`.python-version`** 的纯文本文件，里面只写着 `3.14`。

   

4. **提交并推送到 GitHub：** 在 GitHub 上创建一个仓库，然后运行：

   Bash

   ```bash
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin <你的仓库地址>
   git push -u origin main
   ```

   

------



#### 第二步：在另一台设备克隆项目 (电脑 B / 公司)

在公司电脑上，你不再需要手动创建目录或执行 `uv init`。

1. **克隆项目：**

   Bash

   ```bash
   git clone <你的仓库地址>
   cd <项目目录>
   ```

2. **一键重建环境：**

   Bash

   ```bash
   uv sync
   ```

   - **发生了什么：** `uv` 会`uv` 会在幕后自动为你做这三件事：
     1. **扫描：** 它会查看 `pyproject.toml` 或 `.python-version`，发现项目需要 Python 3.14。
     2. **下载（自动执行 install）：** 它检查公司电脑的 `AppData` 目录，发现没有 3.14，于是它会**自动下载并安装** 3.14 到工具链目录中。
     3. **配置：** 它会在项目下创建一个**适合公司电脑路径**的 `.venv`，并把依赖库装好。