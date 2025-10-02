+++
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
date = {{ .Date }}
draft = false
slug = "{{ substr .File.UniqueID 0 7 }}"
description = ""
summary = ""
tags = [ "技术" ]
categories = [ "博客" ]
cover = ""
author = "{{ .Site.Params.defaultAuthor | default "MapleScraps" }}"
# hidden = true
# searchable = true
# searchKeywords = [""]
+++

# {{ replace .File.ContentBaseName "-" " " | title }}

在这里开始写您的文章内容...

## 主要内容

1. 第一点
2. 第二点
3. 第三点

## 总结

文章总结...