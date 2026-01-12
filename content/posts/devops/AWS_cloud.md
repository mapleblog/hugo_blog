+++
title = 'AWS_cloud'
date = 2025-12-28T20:27:57+08:00
draft = false
slug = "b9ef132"
description = ""
summary = ""
tags = [ "技术", "开发" ]
categories = [ "tech" ]
cover = ""
author = "MapleScraps"
+++

# AWS_cloud

## AWS account
> :one: 创建 aws root 账号，用于创建 IAM 账号
> {{< figure src="/images/create_root_account.png"  class="w-75 ma0" >}}
> :two: 选择 Sign in using root user email
> {{< figure src="/images/IAM login.png"  class="w-75 ma0" >}}
> :three: 输入 root 账号邮箱登录
> {{< figure src="/images/root_login.png"  class="w-75 ma0" >}}
> :four: 点击左上角菜单栏  >  Security, Identity & Compliance > IAM 创建别名
> {{< figure src="/images/create_alias.png"  class="w-75 ma0" >}}
> :five: 开通编程和控制台权限, 登录 root 用户 > Users > username_name > Security Credential > Access key > select other
> {{< figure src="/images/open_permission_1.png"  class="w-75 ma0" >}}
> {{< figure src="/images/open_permission_2.png"  class="w-75 ma0" >}}
> {{< figure src="/images/open_permission_3.png"  class="w-75 ma0" >}}
> {{< figure src="/images/open_permission_4.png"  class="w-75 ma0" >}}
> {{< figure src="/images/open_permission_5.png"  class="w-75 ma0" >}}

## Create EC2 Instance
> **第一步：进入启动向导**  
> :one: 登录 AWS 管理控制台  
> :two: 在搜索栏输入 EC2 并进入服务  
> :three: 点击橙色按钮 “启动实例” (Launch instance)  
>
> ---
>
> **第二步：配置基础信息**  
> :one: 名称和标签：在“名称”框里输入实例的名字（例如：My-Web-Server）  
> :two: **操作系统 (AMI)：**  
> - 在“应用程序和操作系统映像”下，选择 Amazon Linux 2023  
> - 确保它标记了 “符合免费套餐条件” (Free tier eligible)  
> 
> :three: **实例类型：**  
> - 通常默认是 `t2.micro` 或 `t3.micro`（视区域而定）。这也是免费套餐支持的规格
> 
> ---
>
> **第三步：设置登录凭证与网络**  
> :one: 密钥对 (Key pair)：  
> - 点击 “创建新密钥对”  
> - 输入名称，选择 `.pem`（如果你用 Mac/Linux/OpenSSH）或 .ppk（如果你用老版 PuTTY）  
> - 重要： 下载后务必保存好，这是你登录机器的唯一凭证，弄丢了很难找回  
>
> :two: **网络设置：**  
> - 默认会为你创建一个安全组  
> - 勾选 “允许来自以下的 SSH 流量”（为了你能远程登录）  
> - 如果你想做网页服务器，可以勾选 “允许来自互联网的 HTTP 流量”  
> 
> ---
>
> **第四步：存储与启动**  
> :one: **配置存储：**
>
> - 默认通常是 8GiB。免费套餐用户最多可以免费使用 30GiB 的通用型 (SSD) 存储  
>
> :two: **启动实例：**  
> - 点击右侧面板底部的 “启动实例” (Launch instance)  
>
> ---
> 
## Systems Manager (SSM) login
##### 第一步：为 EC2 实例配置 IAM 角色  
> :one: EC2 默认没有权限与 SSM 服务通信，你需要给它一个“身份证”  
> :two: 打开 **IAM 控制台**  
> :three: 点击 **角色 (Roles)** -> **创建角色 (Create role)**  
> :four: 选择 **AWS 服务**，并在**服务下拉列表中选择 EC2**  
> :five: 在**权限策略**搜索框中输入：**AmazonSSMManagedInstanceCore**，勾选该策略  
> :six: 给角色起个名字（例如：EC2-SSM-Role），点击创建  
> :seven: 回到 **EC2 控制台**，**勾选你的实例 -> 操作 (Actions) -> 安全 (Security) -> 修改 IAM 角色**，选择你刚刚创建的 **EC2-SSM-Role**  
> 

##### 第二步：检查安全组 (Security Group)
> 使用 SSM 登录的一个巨大优势是：你可以关闭安全组中的所有入站规则  
> - SSM Agent 是从实例内部“主动”连接到 AWS 服务端的（Outbound）  
> - 只要你的实例能访问互联网（通过 NAT 网关或公网 IP），你就不需要在安全组里开启 22 端口。这极大地降低了被暴力破解的风险  
> 

##### 第三步：如何执行登录
> **方法 A：直接通过 AWS 控制台（最快）**  
> :one: 在 EC2 实例列表勾选你的实例  
> :two: 点击右上角的 连接 (Connect)  
> :three: 选择 Session Manager 选项卡，点击 连接  
> :four: 你将直接在浏览器中获得一个终端  
> 

> **方法 B：通过本地命令行（体验最好）**  
> :one: 安装 AWS CLI 并配置好你的 Access Key  
> :two: 安装插件：下载并安装 Session Manager Plugin  
> :three: 运行命令：  
> ```bash
> # 使用实例 ID 登录（推荐）
> aws ssm start-session --target i-0123456789abcdef0
> ```
>> **注意事项**  
>> - 网络通畅：如果你的实例在私有子网（Private Subnet）且没有 NAT 网关，SSM 会失效。这种情况下需要配置 VPC Endpoints  
>> - 操作系统：Amazon Linux 2/2023 默认自带 Agent。如果是 Ubuntu 或 Windows，可能需要手动安装 amazon-ssm-agent  
>> 

## Improve RAM of Instance
##### 核心步骤：更改实例类型
> **注意：** 更改实例类型需要停止实例，这会导致几分钟的业务中断  
> :one: 停止实例：  
>
> - 在 EC2 控制台勾选该实例  
> - 点击 **实例状态 (Instance state)** -> **停止实例 (Stop instance)  **
> - 等待状态变为 “**已停止 (Stopped)**”   
>
> :two: 更改规格：  
> - 点击 **操作 (Actions)** -> **实例设置 (Instance settings)** -> **更改实例类型 (Change instance type)**  
> - 在下拉菜单中选择一个内存大于 4GB 的类型  
> - **推荐：** `t3.medium (4GB)` 或 `t3.large (8GB)`  
> - 如果对计算性能要求高，可以选 `c5.large (4GB)`；如果对内存要求极高，选 `r5.large (16GB)`  
>
> :three: 启动实例：  
> - 点击 **保存**  
> - 再次点击 **实例状态** -> **启动实例 (Start instance)**  
> 

## Create ssh .pem
> **独立创建密钥对（推荐方式）**
> :one: 登录 EC2 控制台。
> :two: 在左侧导航栏中，下拉找到 网络与安全 (Network & Security)，点击 密钥对 (Key Pairs)。
> :three: 点击右上角的橙色按钮 创建密钥对 (Create key pair)。
> :four: 配置参数：
>
> - 名称：输入一个好记的名字（如 `my-ubuntu-key`）
> - 密钥对类型：选择 `RSA`（最通用）
> - 私钥文件格式：
> > -  如果你使用 Mac、Linux 或 Windows 10/11 的 终端 (SSH)：选择 `.pem`
> > -  如果你使用老版本的 PuTTY：选择 `.ppk`
>
> :five: 点击 创建密钥对
> :six: **关键动作：**浏览器会自动下载一个文件。请立即将其保存到安全的地方！
> - **注意：** AWS 不会保存这个私钥文件。如果你现在不下载或弄丢了，以后无法重新下载，只能重新创建。
> 

## 在本地电脑访问aws**
> **方法 一**  
> :one: 将 `ssh aws.pem` 文件拷贝到 `cd $env:USERPROFILE\.ssh`  
> :two: 执行 `ssh -i "C:\users\windows\.ssh\ed25519" ubuntu@13.456.789.10`  
> 
> **方法 二**  
> :one: 在本地电脑创建 ssh keygen   
> - ssh-keygen -t ed25519 -C "email@example.com"  
> - ssh-keygen -t rsa -b 4096 -C "your_email@example.com"  
> 
> :two: 将本地电脑公钥 .pub 添加到 aws ubuntu 的 `~/.ssh/authorized_keys`  
> :three: 验证链接 `ssh -T ubuntu@12.345.678.90`  
> :four: 开始访问 `ssh -i "~\.ssh\密钥文件" ubuntu@12.345.678.90`  
> 
> **安全组配置** 
> - 将对方的 **Public_IP** 添加到 **ssh 安全组** 来限制指定的网络可以访问 aws
> 

