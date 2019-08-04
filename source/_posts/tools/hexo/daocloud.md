---
title: 自动化布署
categories: [工具,hexo]
domainimg: ohbudtted.bkt.clouddn.com
lang: tools/hexo
date: 2019-08-04 14:00:20
tags:
---
# 描述
代码提交后触发daocloud上的流程：构建-布署
# 准备
* 生成密钥

```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

```
