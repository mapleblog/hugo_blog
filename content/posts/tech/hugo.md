+++
title = 'Hugo'
date = 2025-10-01T14:24:33+08:00
draft = false
slug = "3fadbfd"
description = ""
summary = ""
tags = [ "博客" ]
categories = [ "tech" ]
cover = ""
author = "MapleScraps"
+++

# Hugo

这是一篇关于Hugo博客的技术文章，主要介绍Hugo的使用方法和配置

> [!NOTE]+ 知识点:
>
> - 博客根目录 指的是在博客文件夹内, 包含所有博客文章、配置文件、主题文件等
> - .yaml 和 .toml 都是配置文件格式, 用于配置博客的参数和外观, 推荐使用 .toml 格式, 因为它更简洁和易读

## 第一步
> [!IMPORTANT]+ 前提条件
> 在还没开始配置Hugo之前，确保已经**安装**以下的软件:
> - [Go](https://go.dev/)
> - [Git](https://git-scm.com/downloads)

## 第二步
> **下载** 最新版本Hugo & Hugo主题:
> - [Hugo](https://gohugo.io/installation/windows/) ( 目前最新版本 >= v0.150.1 )
> - [Hugo 主题](https://themes.gohugo.io/) ( 本人使用hugo-narrow )

## 第三步
> - 选择你想要保存的路径, 点击右键 -> 选择Open Git Bash here,新建一个文件夹, 用于存放Hugo博客的文件
```git
mkdir C:\<blog_name>

example:
mkdir C:\hugo
```

## 第四步
> - 进入已经创建的文件夹
```git
cd C:\hugo
```
## 第五步
> - 初始化Hugo博客
```git
hugo new site .
```
## 第六步
> 下载 hugo-narrow 主题
```git
git submodule add https://github.com/hugo-narrow/hugo-narrow.git themes/hugo-narrow
```
## 第七步
> 配置 hugo-narrow 主题
```git
# 跳转到下载好的hugo-narrow主题的exampleSite文件夹, 复制hugo.yaml文件到hugo_blog文件夹
cp C:\hugo\hugo_blog\themes\hugo-narrow\exampleSite\hugo.yaml .\hugo.yaml
```
## 第八步
> 转换 .yaml 语法为 .toml:
[yaml to toml](https://transform.tools/yaml-to-toml)

> 1. **编辑 hugo.yaml 文件**, 拷贝粘贴转换好的.toml语法, 替换原有的.yaml语法
> 2. 删除根目录下**原本**的 hugo.toml / hugo.yaml 文件
> 2. 重命名 **hugo.yaml** 为 **hugo.toml**

## 第九步
> 启动 hugo 服务
> - hugo server ( 默认端口为 1313 )
> - 打开浏览器, 访问 `http://localhost:1313/` 查看Hugo博客的效果
> - 如果需要指定端口号, 可以在启动命令中添加 `-p <port>` 参数
> - 例如: `hugo server -p 8080`
> - 然后在浏览器中访问 `http://localhost:8080/`

## 常用命令
> 1. hugo new content `posts/xxxx.md` ( 创建新文章 )
> 2. hugo new site `<site_name>` ( 创建新博客 )
> 3. hugo server -p <port> -D ( 启动 hugo 服务, 包含草稿文章 )
> 4. hugo build ( 生成静态文件 )
