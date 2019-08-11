---
title: git常用命令
categories: [工具,git]
domainimg: ohbudtted.bkt.clouddn.com
lang: tools
date: 2019-08-04 11:19:48
tags:
---
# 常用命令
* git remote -v 查看仓库地址
* git remote add xx xxx@xx.git 添加仓库地址
* git config remote.xx.url xx@xx.git 配置仓库地址更改
* Git reset --hard uuid 放弃本地更改，强制更新，如果已经提交使用soft
* git checkout 切换分支 git branch列出分支列表

# 查看文件的更改内容
* 已提交的文件
```
git log 查看提交记录复制commit id
git show commit id 查看对应文件的变更内容
```
* 未执行git add 命令
```
git status 查看更改的文件
git diff 更改的文件
```
* 已执行 git add 命令
```
git status 查看更改的文件
git diff --cached themes/3-hexo/_config.yml
```

# 某个文件或文件夹git不能识别

```
git rm --cached folder
git add folder
```
