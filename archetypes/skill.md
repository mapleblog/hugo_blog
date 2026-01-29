+++
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
date = {{ .Date }}
draft = true
slug = "{{ substr .File.UniqueID 0 7 }}"
description = ""
summary = ""
tags = [ "技术", "开发" ]
categories = [ "tech" ]
cover = ""
author = "{{ .Site.Params.defaultAuthor | default "MapleScraps" }}"
+++

# {{ replace .File.ContentBaseName "-" " " | title }}

## 技术背景

简要介绍相关技术背景和问题场景...