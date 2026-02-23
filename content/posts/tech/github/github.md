+++
title = 'Github'
date = 2025-10-14T19:43:39+08:00
draft = false
slug = "81f9b3e"
description = ""
summary = ""
tags = [ "技术", "开发" ]
categories = [ "tech" ]
cover = ""
author = "MapleScraps"

+++

# Github

## Github 安装
> Github 是基于云的代码托管平台，它使用 Git 进行版本控制，帮助开发者存储、管理和共享代码
> - 下载 + 安装 [点击此链接](https://git-scm.com/downloads)

> [!NOTE]+ **Github 流程** :
>
>> **工作区 (Working Directory)**
>> - 位置： 就是你打开的那个 **项目文件夹**。你看到的所有文件，包括代码、图片、配置文件等等，都属于工作区
>> - 状态： 当你在文件中进行修改时，这些修改都处于“未追踪”或“已修改”状态
> 
>> **暂存区 (Staging Area / Index)**
>> - 位置： 在项目根目录下的 **隐藏文件夹 .git/** 中的一个 **名为 index 的文件**
>> - 功能： 它充当工作区和储存区之间的“缓冲站”。你使用 *git add* 命令将工作区中你想要的修改精准地加入暂存区。只有被加入到暂存区的修改，才会包含在你的下一个 commit 中
>
>> **储存区 (Local Repository / Git Directory)**
>> - 位置： 也是在项目 **根目录下的隐藏文件夹 .git/** 中，主要内容 **存储在 .git/objects** 文件夹里
>> - 功能： 这是 Git 的核心数据库。当你执行 *git commit* 时，暂存区中的快照会被永久地记录为历史版本，并存储在储存区中
>> 

## SSH密钥设置
> :one: 检查现有的 SSH 密钥
> 在创建新密钥之前，先看看你的电脑是否已经有一对密钥了。
> 打开终端（Terminal / PowerShell / Git Bash），输入：
> ```bash
> ls -al ~/.ssh
> ```
> - 如果你看到类似 id_ed25519.pub 或 id_rsa.pub 的文件，说明你已有密钥
> - 如果没有该文件夹，或者文件夹为空，请继续下一步
>
> :two: 生成新的 SSH 密钥
> 我们推荐使用 Ed25519 算法，因为它更安全且性能更好
> 在终端输入以下命令（将邮箱替换为你自己的 GitHub 邮箱）:
> ```bash
> ssh-keygen -t ed25519 -C "your_email@example.com"
> ```
> - Enter file in which to save the key: 直接回车（按默认路径保存）
> - Enter passphrase: 建议直接回车（不设密码），或者设置一个你记得住的短语
>
> :three: 将 SSH 密钥添加到 GitHub 账户
> 你需要把生成的“公钥”告诉 GitHub
> > :one: 复制公钥内容：
> > - Windows (PowerShell): `cat ~/.ssh/id_ed25519.pub | clip`
> > - Mac: `pbcopy < ~/.ssh/id_ed25519.pub`
> > - Linux: `cat ~/.ssh/id_ed25519.pub` (手动复制打印出来的文本)
> > :two: 在 GitHub 上设置：
> > - 登录 GitHub，点击右上角头像 -> **Settings**
> > - 在左侧栏找到 **SSH and GPG keys**
> > - 点击右上角的 **New SSH key**
> > - **Title**: 给这台设备起个名字（如 "My Laptop"）
> > - **Key**: 将刚才复制的内容粘贴进去，点击 **Add SSH key**
> :four: 测试连接
> 回到终端，输入以下命令测试是否配置成功：
> ```bash
> ssh -T git@github.com
> ```
> - 如果系统提示 `Are you sure you want to continue connecting (yes/no/[fingerprint])?`，输入 **yes** 并回车  
> 如果看到如下字样，说明配置成功：
> > Hi [Username]! You've successfully authenticated, but GitHub does not provide shell access.  
>
> :five: 修改本地仓库的远程地址 (可选)
> 如果你现有的本地项目是通过 HTTPS (https://...) 克隆的，你需要将其改为 SSH 地址才能使用密钥  
> 在你的项目目录下执行：
> ```bash
> # 查看当前远程地址
> git remote -v
> 
> # 修改为 SSH 地址（将 [user/repo] 替换为你的路径）
> git remote set-url origin git@github.com:[user/repo].git
> ```
> ---
> **常见问题排查**
> |现象|解决方法|
> |---|---|
> |Permission denied (publickey)|检查公钥是否准确复制到了 GitHub，或确认本地 SSH Agent 是否启动|
> |Connection timed out|可能是网络防火墙拦截了 22 端口，可以尝试配置 SSH 使用 443 端口|
>
> 




## *工作区 ( Working Directory ) 常用命令*

> - `git add < files >` 将文件保存到暂存区
> - `git config --global --add safe.directory` 拷贝到其他设备，需要在新设备添加此配置
> - `git tag v1.0.0` 创建标签
> - `git commit -m`` 将暂存区文件提交到储存区
> - `git checkout -b < branch >` 如果本地没有该分支，会自动创建并跟踪对应的远程分支
> - `git switch -c < branch >`
> - `git ls - files` 列出所有在 Git 仓库中被追踪的文件路径（相对于项目根目录）
> - `git rm -r --cached < public >` 告诉 Git 停止追踪 public 目录中的所有文件, 但不删除本地的文件
>
> > 🈯 **git restore** 用于撤销 *工作区* 和 *暂存区* 的更改   
> > - ✅ `git restore < files >`  指定工作区的文件，恢复到暂存区或上一次提交的状态  
> > - 目标： 工作区  
> > - 源头： 暂存区 (Staging Area)  
> > - ✅ `git restore --staged < file >` 将文件从暂存区移回工作区，但保留你在工作区的本地修改  
> > - 目标： 暂存区  `--->`  Git 会将暂存区中 <file> 的记录，恢复到 HEAD (上一次提交) 中的版本 ]  
> > - 源头： 工作区 `--->` 完全不受影响
>
> > - `git clone < http.git > own_directory`
> > - `git clone -b < branch > < repo_url >`
> > - `git clone -b develope --single-branch < 你的仓库URL >`
>
> > - `git log --stat` 显示提交后的信息
> > - `git log -p -2` 显示最新两个log信息
> > - `git log -2` 显示最新两个log信息
> > - `git log --graph --oneline` 以图线和一行显示
>
> > 🈯 如果在错误分支下修改文件，想要将所有已经修改转移到正确的分支：
> > - `git stash` 需要保存修改但不想提交时, 还原修改使用 `git stash [ pop/apply ]`
> > - `git stash save "Solving login page issue"` 添加一个描述，方便以后查找
> > - `git stash list` 查看修改保存多个记录
> > - `git stash pop` 恢复最近一次修改记录，并从列表中移除它
> > - `git stash pop stash@{2}` 恢复指定的修改保存记录后，从列表中删除
> > - `git stash apply stash@{1}` 恢复指定的修改保存记录，依然保留在列表中以备后用
> > - `git stash drop stash@{0}` 删除指定修改保存记录
> > - `git stash clear` 一次性删除所有的 git stash 修改保存记录
> > - `git stash --include-untracked 暂时存放一些未跟踪的文件，以便日后恢复
`
>
> > - `git clean < file_name > -f` 可以删除新创建但不曾提交过的文件
> > - `git clean -n --dry-run` 模拟删除不曾提交/追踪过的文件
> > - `git clean < folder_name > -nd` 模拟删除不曾提交/追踪过的文件夹
> > - `git clean < folder_name > -fd` 确认删除文件夹
> > - `git clean -fd` 清理工作区中所有未追踪的文件
>

## *暂存区 ( Staging Area ) 常用命令*

> - `git add -p` 显示确认窗口
> - `git restore --staged < changed_file >` 只从暂存区移除
> 
>> - `git diff --staged` 显示暂存区最后一次状态
>> - `git diff` 比较工作文件 和 暂存区文件的差异
>> - `git diff <commit1> <commit2>` 比较2个提交的差异
>> - `git diff --cached` 查看已经 git add 但未提交的更改
>> - `git diff <commit> HEAD` 查看指定提交和当前分支最新提交的差异
>> - `git diff <commit>` 显示该提交与当前工作区的差异
> 

## *储存区 ( Local Repository ) 常用命令*

> - `git rm` 删除在储存区的文件
> - `git mv` 重命名在储存区的文件
> - `git commit -a -m` 将文件提交到储存区，跳过暂存区
> - `git commit --amend` 修改提交后的错误信息，或者遗漏添加文件（会替换原本的 commit，然后重新创建生成SHA）不建议在多人协作的共享分支上使用
> 
>> 🈯 **git reset** 撤销已经提交的命令  [ 重置历史（本地操作）]
>> - `git reset --hard HEAD~1` 撤销最后一次的提交后，删除工作和暂存区后期的修改
>> - `git revert HEAD` 不删除提交，而是生成一个“相反”的提交，
>> - `git reset --soft HEAD~1` 撤销上次提交，但保留工作区和暂存区的修改。  
>> ⭕ 历史记录被重置，但你的代码文件和 git add 记录都还在。你只需重新 git commit。  
>> - `git reset --mixed HEAD~1` 撤销上次提交，并清除暂存区（git add 记录）。   
>> ⭕ 历史记录被重置，本地修改保留在工作区（未暂存）。这是 git reset 的默认模式。   
>> - `git reset --hard HEAD~1` 彻底删除上次提交，并清除所有本地修改和暂存区。  
>> ⭕ 这是一个毁灭性命令，本地修改会永久丢失。  
>> 
>> 🈯 **git revert** 不删除历史，创建新的提交，新提交内容是撤销指定提交所引入的更改   
>> 
>> 1️⃣ **反转最新的一个提交 (HEAD)**  
>> 如果你最近提交了一个错误，但这个错误已经被推送到远程，这是最常见的用法：
>> ```bash
>> git revert HEAD
>> ```
>> - 效果： 创建一个新的提交，该提交的内容是撤销当前分支上最新一次提交（HEAD）所引入的所有更改。   
>>
>> 2️⃣ **反转指定的单个提交**  
>> 如果你想撤销历史中某个特定的、较旧的提交，你需要找到它的提交哈希（Commit Hash/ID）。  
>> ```bash
>> git revert < 提交 ID >
>> # 示例：git revert a1b2c3d4e5f6
>> ```
>> - 效果： 创建一个新提交，专门用来撤销 ID 为 a1b2c3d4e5f6 的提交引入的更改。
>> 
>> 3️⃣ **反转一系列连续的提交**  
>> 如果你想撤销从一个旧提交到最新提交之间的所有提交（但不包括最新的提交本身），可以使用范围。
>> ```bash
>> git revert <旧提交 ID>^..HEAD
>> # 示例：git revert b2c3d4e^..HEAD
>> ```
>> **符号解释：**
>> -  `b2c3d4e^` 表示提交 `b2c3d4e` 之前的那个提交（即从 `b2c3d4e` 开始）。
>> - `..HEAD` 表示到当前最新提交结束。
>> 
>> 4️⃣ **反转但暂不提交 (-n 或 --no-commit)**  
>> 如果你想将反转的更改应用到你的工作区和暂存区，但想在提交之前进行一些调整，可以使用 `-n` 选项。
>> ```bash
>> git revert < 提交 ID > --no-commit
>> ```
>> - 效果： Git 会将反转后的代码放在你的工作区和暂存区，让你有机会检查或修改代码，然后你需要手动执行 git commit 来完成反转操作。  
>> 
>

## *分支 ( Branch ) 常用命令*

> - `git branch` 显示分支列表
> - `git branch -a` 显示本地 和 远程分支
> - `git branch -r`  只显示远程分支
> - `git branch -M main` 将当前分支的名称强制重命名为 main ( 用于远程空仓库，第一次在本地提交到远程仓库， 因为在本地git init 默认是master )
> - `git branch  < new-branch >` 创建新分支
> - `git branch -d < current-branch >` 删除某个分支，包括master/main分支？
> - `git branch -D < current-branch >` 强制删除某个分支
> - `git checkout -b < new-branch >` 创建新分支，然后指针到新分支
> - `git checkout < other-branch >` 指针到存在的分支，也自动对应到远程分支
> > - `git merge --abort` 用于merge conflict，取消合并
>> 使用 `git branch -vv` 可以看到以下讯息：指针的分支，是否和远程仓库分支一样 
>> 
>> 	test   5ab7ba3 [origin/test] Create a new file for result record purpose
>
>> - git merge 将主分支 <---- 其他分支进行文件合并
>> 
>>  	`git chekout main/master`
>>  
>> 	`git merge [ sub-branches ]`

## *远程仓库 ( Remote Repository ) 常用命令*

> - `git clone` 克隆github远程储存库某个项目到本地
> -` git pull` 从远程储存库更新 ( git fetch )+ 合并 ( git merge )到本地目录
> - `git push origin main` 从本地的快照上传文件到远程储存库 ( 新分支在执行推送到远程仓库，会自动创建 ) 
>> - `git remote -v`
>> - `git remote show origin` 显示当前连接的远程仓库
>> - `git remote add origin < git@github.com:you/project.git >` 添加远程仓库 （ 属于自己的远程仓库 ）
>> - `git remote add upstream < http://github.com/[git-username] >` 添加上游 （ fork别人的github仓库 ）
>> - `git remote set-url origin < git@github.com:you/project.git >` 修改远程地址
>> - `git remote remove origin` 删除远程仓库连接
> 
> - `git fetch` 将远程仓库别人更新的提交，复制到本地远程分支，就可以看到别人提交什么，但不会合并   
> - `git log origin/main` 查看main分支最新的状态  
> 	💥 `git log origin/main --online --graph` 以树状显示分支状态   
> 	💥`git fetch origin optimize:optimize` 本地没有该远程分支，可以直接把它 origin/optimize 拉到本地 optimize 并切换过去
		git remote update 获取远程分支所有的内容，但不会自动合并到本地分支
>
> - `git push -u origin < 分支名 >` 将本地< 分支名 >分支推送代码到origin 远程仓库, -u 默认为当前的远程仓库
> - `git push --set-upstream origin` 等于 git push -u origin < branch >
> - `git push --delete origin < 远程仓库分支 >`  删除远程分支
> - `git pull --rebase origin main` 将其他同事推送更新，同步到本地，然后将自己的新推送放在最后
> - `git log origin/master`
> - `git push -u origin < 分支名 >` 将本地 < 分支名 > 分支推送代码到origin 远程仓库, -u 默认为当前的远程仓库
> - `git push --set-upstream origin` 等于 git push -u origin < branch >
> - `git push --delete origin < 远程仓库分支 >`  删除远程分支
> - `git pull --rebase origin main` 将其他同事推送更新，同步到本地，然后将自己的新推送放在最后
> - `git rebase --continue` 
> - `git merge origin/master` 合并后，必须执行推送到远程仓库
>
> > - `git rebase < target-branch >` 把我在其他分支提交，重新放在 main/master 后面继续排队走
>
> > ```markdown
> > [ 真实环境例子 ]
> > main:          A --- B --- C --- F
> >                             \
> > feature:                     D  --- E <--- 我拉的分支
>
> >```
> >```markdown
> >
> > # 1. 确保在 dev 上执行 rebase 成功
> > git checkout dev
> > git rebase main 
> > 
> > # 2. 切换到 main
> > git checkout main  <-- (这步会切换指针)
> > 
> > # 3. 执行快速合并
> > git merge dev
> > 
> > [ 使用 git rebase ]
> > main:          A --- B --- C --- F
> >                                   \
> > feature:                           D  --- E <--- 将我分支所有提交排在main最后继续开发
> >```
> >

> [!TIP]+ 技巧
>> ## 💢 提交相同信息过于繁琐 
>> **方法一：** 使用 `git commit --amend` 合并提交信息，会打开编辑器允许修改上一次提交内容  
>> - 针对同一逻辑任务的修改 + 连续多次提交的 + 还没打算推送到远程仓库  
>> 
>> ##### 📌 Amend 工作流  
>> ###### 1️⃣ 第一次修改并提交：  
>> ```bash
>> git commit -m "Feature: 正在开发登录模块 (WIP)"
>> ```
>> 
>> 2️⃣ 第二次修改、第三次修改（继续在同一个任务上）： 你修改了文件，并再次 git add。然后，使用 --amend 来替换上一次的提交，而不是创建一个新提交。
>> ```bash
>> git add .
>> git commit -a --amend --no-edit	# 复用最后一次提交信息，跳过编辑直接完成
>> git commit -a --no-edit	   # 沿用上次的提交信息创建新的提交ID，创建一个全新的提交 ID，历史线性向前推进
>> git commit -a --amend   # 替换掉上一个提交ID, 创建新提交ID, 历史被修改，发生“倒退”
>> ```
>> - `--amend`：复用上一个提交信息，可以进行编辑  [ 销毁旧提交ID，生成新提交ID ]，  
>> 必须使用 `git push --force-with-lease` 强制推送（非快进式）。  
>> - `--no-edit`：复用上一个提交的提交信息，跳过编辑  [ 不销毁旧提交ID，追加生成新提交ID ]
>> 
>> **结果**： 历史记录中只会保留一个提交，它包含了你所有的修改，并且提交信息是你第一次输入的那个。   
>> 
>>> ##### 👿 后遗症： 🔍 错误原因：重写了历史  
>>> 当执行 `git commit --amend --no-edit` 时  
>>> - 你 **销毁了 **本地的旧提交 ID。  
>>> - 你 **创建了** 一个全新的、修正后的提交 ID。  
>>> - 你本地的 `dev` 分支指针指向了这个新的 ID。  
>>> 
>>> 然而，你的远程仓库 `origin/dev` 仍然指向那个 旧的提交 ID。  
>>> 当尝试 `git push` 时，Git 发现：  
>>> - 本地 `dev` 指向 **新 ID**。  
>>> - 远程 `dev` 指向 **旧 ID**。  
>>> - Git 无法通过简单的 **快进（Fast-Forward）** 方式来更新远程，因为它看起来就像你**尝试用一个不相关的提交去取代远程的历史**，所以它安全地拒绝了你的推送。  
>>> 
>>> **✅ 解决方案：**  
>>> 🚨 强制推送命令
>>> ```bash
>>> git push origin dev --force
>>> ```
>>> 或者使用更安全的版本：
>>> ```bash
>>> git push origin dev --force-with-lease
>>> ```
>>> 为什么推荐 `--force-with-lease`？  
>>> - `--force`：会无条件覆盖远程分支的历史。如果你的队友在你修正历史期间向远程推送了新的提交，`--force` 会默默地删除掉你队友的提交！  
>>> - `--force-with-lease`：这是更安全的选择。它只会在远程分支在你上次拉取或推送之后 没有发生变化 的情况下才执行强制推送。如果远程在你不知情的情况下被更新了，它会拒绝推送，从而保护你队友的工作。
>>>   
>>> ##### 🧰 其他设备 `git pull` 方式'
>>> ##### 方案一：如果本地分支上没有未推送的工作（最常见情况）
>>> 如果只是让本地分支完全匹配远程的新历史，这是最简单的方法：
>>> ```bash
>>> git fetch                   	   # 获取远程的所有新历史，但不合并或修改本地分支
>>> git reset --hard origin/<分支名>    # 强制将本地分支指针和工作目录重置为远程的最新状态 
>>> ```
>>> **解释：** `git fetch` 拿到新的历史（即 `A'`），然后 `git reset --hard` 丢弃本地旧的 `A`，直接指向并采用 `A'`  
>>> 
>>> ##### 方案二：如果本地分支上有基于旧提交的未推送工作
>>> 如果他们在你 `amend` 之前，基于旧的提交 `A` 已经创建了新的提交 `B`，那么他们需要将这个本地工作 `B` 重新应用到新的远程提交 `A'` 之上  
>>> ```bash
>>> git fetch                   # 获取远程的新历史 A'
>>> git rebase origin/<分支名>    # 将本地的未推送提交（如 B）
>>>                           # 重新应用到远程分支的新历史（A'）之上
>>>```
>>> **解释：** `git rebase` 会将他们的本地提交（`B`）“剪切”下来，然后将新的远程历史（`A'`）“粘贴”在前面，再将本地提交（`B`）“重新应用”上去，最终历史变为 `A'` -> `B'`。
>>> 
>

> [!TIP]+ 其难杂症
>
> ## 💢 在第二台设备使用 *git pull origin dev* 子分支，成功拉取但是文件不是最新版本  
> > ##### 🔍 原因一：你当前不在 dev 分支上  
> > 尽管你执行了 `git pull origin dev`，但 Git 默认是将远程的 `origin/dev` 拉取到你的 本地 dev 分支。如果你的工作区当前检出的是 main 或其他分支，那么你眼前的代码就不会变动。  
> > ##### 解决办法：确认和切换分支
> > 1️⃣ 检查当前分支：
> > ```bash
> > git branch	#（当前分支前会有一个 * 号。）
>
> > ```
> > 2️⃣ 切换到 dev 分支：
> > ```bash
> > git checkout dev
> > ```
>
> > 3️⃣ 再次拉取（确保万无一失）：
> > ```bash
> > git pull origin dev
> > ```
>
> > ##### 🔍 原因二：pull 时的本地合并问题  >>
> > git pull 实际上是两个命令的组合：git fetch（拉取远程数据）和 git merge（将拉取到的数据合并到当前分支）。  
> > ##### 解决办法：清理并强制更新
> > 1️⃣ 检查工作区状态：
> > ```bash
> > git status	# （查看是否有未提交的更改或冲突。）
> > ```
> > 2️⃣ 强制重置： 如果你确定本地的更改不重要，你想让本地分支完全匹配远程分支，可以使用 reset 命令将本地 dev 强制重置到远程的最新状态。  
> > ```bash
> > # 切换到 dev 分支
> > git checkout dev
>
> > # 强制丢弃本地所有更改，并将本地分支指针指向远程分支的最新提交
> > git reset --hard origin/dev
> > git stash 
>
> > ⚠️ 注意： 
> > git reset --hard 会永久丢弃你在本地 dev 上所有未提交或未推送的更改。>> 请确保你真的不需要这些更改。
> > ```
>
> > ######  🔍 原因三：Untracked 或 Ignored 文件干扰
> > 如果你在项目中使用构建工具，一些旧的编译产物或缓存文件可能仍然存在于你的工作区，并让你误以为代码不是最新的。  
> > ##### 解决办法：清理工作区  
> > 1️⃣ 执行 Dry Run 检查 (强烈推荐)：  
> >
> > ```bash
> > git clean -nfd		# （查看哪些文件会被删除。）
> > ```
> > 2️⃣ 执行清理：
> > ```bash
> > git clean -fd		# （-f 强制执行，-d 删除未追踪的文件夹。）（-f 强制执行，-d 删除未追踪的文件夹。）
> > ```