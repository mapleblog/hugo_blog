+++
title = 'Hugo_syntax'
date = 2025-10-02T08:21:28+08:00
draft = false
slug = "560e275"
description = ""
summary = ""
tags = [ "技术", "开发" ]
categories = [ "tech" ]
cover = ""
author = "MapleScraps"
+++

# Hugo_syntax

> ## Shortcode 语法结构
> - **{{</* ... */>}} (尖括号)**: 用于 Shortcode 结果不会被 Markdown 处理器再次处理的情况，通常用于插入复杂的 HTML 结构，比> 如> 图片 (figure) 或卡片。 
> - **{{%/* ... */%}} (百分号)**: 用于 Shortcode 结果需要被 Markdown 处理器再次处理的情况。由于 > {{%/* param "" */%}} 的结果通常是文本（如 "red"），Markdown 处理器需要能够将这段文本作为普通内容的一部分来渲染，因此必> 须使用百分号版本。


> ## Picture Shortcode
> - **{{</* figure ... */>}}**: 插入图片或视频，支持 caption、link 等参数。
> - {{</* figure **src="/images/xxx.jpg"** **alt="xxx"** **caption="xxx"** **link="https://xxx"** **class="w-75 ma0"** */>}}
>> 示例 : 
> {{< figure 
  src="/images/universal.jpg" 
  alt="Universal Image" 
  caption="Image description"
  link="https://www.google.com" 
  class="w-75 ma0" 
>}}

> ## Instagram shortcode
> To display an Instagram post with this URL:
>> `https://www.instagram.com/p/CxOWiQNP2MO/`
>
> Include this in your Markdown:
>> ` {{</* instagram CxOWiQNP2MO */>}}`

> ## YouTube shortcode
> To display an Instagram post with this URL:
>> `https://www.youtube.com/watch?v=0RKpf3rK57I`
>
> Include this in your Markdown:
>> ` {{< youtube 0RKpf3rK57I >}}`

> ## HightLight shortcode
>> {{< highlight go "linenos=inline, hl_lines=1-10, style=emacs" >}}
package main

import "fmt"

func main() {
    for i := 0; i < 3; i++ {
        fmt.Println("Value of i:", i)
    }
}
>>{{< /highlight >}}
>>
> You can also use the highlight shortcode for inline code snippets:
>> This is some {{< highlight go "hl_inline=true" >}}fmt.Println("inline"){{< /highlight >}} code.
>>
>>  **{{</* highlight go "hl_inline=true" */>}}** Your_text_highlight **{{</* /highlight */>}}**

> ## QR shortcode
>
> Use the self-closing syntax to pass the text as an argument:
>> {{< qr text="https://gohugo.io" />}}
>
> Or insert the text between the opening and closing tags:
>> {{< qr >}}
https://gohugo.io
>> {{< /qr >}}
>
> To create a QR code containing contact information in the vCard format:
>> {{< qr level="low" scale=2 alt="QR code of vCard for John Smith" >}}
BEGIN:VCARD
VERSION:2.1
N;CHARSET=UTF-8:Smith;John;R.;Dr.;PhD
FN;CHARSET=UTF-8:Dr. John R. Smith, PhD.
ORG;CHARSET=UTF-8:ABC Widgets
TITLE;CHARSET=UTF-8:Vice President Engineering
TEL;TYPE=WORK:+12065550101
EMAIL;TYPE=WORK:jsmith@example.org
END:VCARD
>> {{< /qr >}}

