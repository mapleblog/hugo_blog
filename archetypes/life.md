+++
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
date = {{ .Date }}
draft = false
slug = "{{ substr .File.UniqueID 0 7 }}"
description = ""
summary = ""
tags = [ "生活", "感悟" ]
categories = [ "life" ]
cover = ""
author = "{{ .Site.Params.defaultAuthor | default "MapleScraps" }}"
# hidden = true
# searchable = true
# searchKeywords = [""]
+++

# {{ replace .File.ContentBaseName "-" " " | title }}

## 引言

分享一些生活中的感悟和思考...

## 主要内容