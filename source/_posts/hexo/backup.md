---
title: backup
domainimg: ohbudtted.bkt.clouddn.com
lang: hexo
date: 2017-05-07 15:43:20
tags:
categories: hexo
---

# 博客备份至github分支
博客根目录执行以下命令
```bash?linenums
git init 
git checkout -b hexo //创建hexo分支，存放博客源码
git add  .  //添加文件
git commit -m "博客备分"
git remote add origin  git@github.com:fulndon/fulndon.github.io.git   //添加远程仓库
git push origin hexo
```