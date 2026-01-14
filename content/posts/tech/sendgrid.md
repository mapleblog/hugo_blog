+++
title = 'Sendgrid'
date = 2026-01-14T14:48:37+08:00
draft = true
slug = "0a95915"
description = ""
summary = ""
tags = [ "技术", "开发" ]
categories = [ "tech" ]
cover = ""
author = "MapleScraps"
+++

# Sendgrid
> :one: 注册账号 [Twilio Sendgrid](https://www.twilio.com/)
> :two: 创建 **apikey**，在控制界面的 Settings > API Keys > Create API Key
> :three: 创建 **Sender Authentication**，在控制界面 Settings > Sender Authentication 
> :four: 创建 **Email Template**，在控制界面 Email API > Dynamic Templates > Create a Dynamic Template
> 
---

##### 应用 SMTP Configuration
| Email Notification |  |
|---|---|
|SMTP Host| smtp.sendgrid.net|
|SMTP Port|587|
|Username|apikey|
|Password| apikey ( start with SG.xxxx )|
|From Email| noreply@example.com (the email registered in sender authentication)|
|From Name| example |
|To Email | apps@example.com |

