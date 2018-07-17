---
title: openApp
domainimg: ohbudtted.bkt.clouddn.com
lang: git
date: 2017-05-07 18:45:06
tags: [git,bash环境变量]
categories: git
---
# 概术
通过git bash命令行，打开应用如小书匠
<!--more-->
# 应用打开配置
1，自定义命令**md**.  在任意目录下新建md文件（<span style="color:red">无后缀名</span>），并将其加到系统变量。内容如下：
```bash?linenums
#!/bin/sh
"D:\Program Files (x86)\Story\nw.exe" $1 &
```

2 ， 通用路径配置，向git安装目录下的`etc/profile`文件中添加如下内容
```bash
MDPATH="E:/blog/hexo/source/_posts/"
```
3 ，打开指定位置下的md文件
```bash
md $MDPATH/hexo/test.md
```



