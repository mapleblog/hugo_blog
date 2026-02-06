+++
title = 'Claude Code'
date = 2026-02-02T12:49:14+08:00
draft = false
slug = "832522f"
description = ""
summary = ""
tags = [ "代码", "开发" ]
categories = [ "code" ]
cover = ""
author = "MapleScraps"

+++

# Claude Code
#### Part.1 初始化搭建和配置基础交互

- 安装 Claude Code
- 登录与授权
- 第一个实战问题
- 三种模式详解（默认 / 自动 / 规划）
  - shift + tab
    - 默认模式 =？ for shortcuts
    - 自动模式 = accept edits on
    - 规划模式 = plan mode on



#### Part.2  复杂任务处理与终端控制

- 执行终端命令（Bash）
  - ctrl + g（打开编辑器，编写好后需要保存，然后关闭编辑器）
- 使用规划模式（Plan Mode）
- 跳过所有权限检测（Dangerously-Skip-Permissions）
  - 在终端执行 claude --dangerously-skip-permission（会进入放飞自我模式，所有操作自动完成）

- 后台任务管理（Bakground Tasks）



#### Part.3 多模态与上下文

- 版本滚回（Rewind）
  - /rewind
  - 按两次 esc，选择要回滚的版本
- 图片处理
  - 直接拖拽图片到终端
  - ctrl + c | ctrl + v
- 安装MCP Server（以Figma为例）
  - claude mcp add --transport http figma https://mcp.figma.com/mcp
- 恢复历史会话（Resume）
  - 启动claude code 后，执行 /resume
  - claude -c
- 使用MCP工具还原设计稿
- 上下文压缩与清除
  - /compact 
  - /clear
- 项目及以文件（CLAUE.md）
  - /init
  - /memory



#### Part.4 高级功能扩展与定制

- **Hook**

  - 

- **Agent Skills**

  - **最适合**：
    - 和上下文 **关联大**
    - 对上下文 **影响小**

- **SubAgents**

  - **最适合**：

    - 与上下文 **关联小**

    - 对上下文 影响大

- **Skill** 与 **SubAgent** 的区别

- **Plugin**
  - /plug





