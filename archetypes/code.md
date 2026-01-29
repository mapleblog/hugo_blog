+++
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
date = {{ .Date }}
draft = false
slug = "{{ substr .File.UniqueID 0 7 }}"
description = ""
summary = ""
tags = [ "代码", "开发" ]
categories = [ "code" ]
cover = ""
author = "{{ .Site.Params.defaultAuthor | default "MapleScraps" }}"

+++

# {{ replace .File.ContentBaseName "-" " " | title }}

## 代码相关

