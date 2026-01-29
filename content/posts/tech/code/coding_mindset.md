+++
title = 'Coding_mindset'
date = 2026-01-14T16:01:23+08:00
draft = false
slug = "08f85a9"
description = ""
summary = ""
tags = [ "代码", "开发" ]
categories = [ "code" ]
cover = ""
author = "MapleScraps"

+++

# 代码编程思维

#### 模块化架构设计 - 逻辑层
> A. **配置层 (Config Layer)**
> 使用 YAML 或 JSON 文件定义规则，而不是将路径死代码
>
> - 定义输入输出路径
> - 定义列名映射（例如：将“姓名”映射为变量 user_name）
> > - 坚决反对在代码中直接写死路径（如 **df = pd.read_excel("C:/Users/Desktop/data.xlsx")**）
> > - 遵循“**开闭原则**” **(Open-Closed Principle)** = 强调对扩展开放，对修改关闭
> > - **配置** 和 **代码**分离
---
> B. **校验层 (Validation Layer)**
> 这是最重要的一步。手动输入最怕格式错误（如日期格式不对、手机号缺位）
>
> - 逻辑检查：非空校验、重复项检查、数值范围检查
> - 反馈机制：如果数据不合格，程序应生成一个“错误报告.xlsx”，高亮标出哪一行哪一列有问题
>
---
> C. **转换层 (Transformation Layer)**
> - 利用 Python 的并行处理能力（如果数据量巨大）
> - 清洗空格、统一日期格式、自动计算汇总值
>
---
> D. **输出层 (Output Layer)**
> - 支持样式美化（自动调整列宽、冻结首行、添加表格边框），让同事拿到的成品直接就能用作汇报

---

解耦 Decoupling = **减少系统不同组件或模块之间的相互依赖，使它们能更独立地运行和演化**





