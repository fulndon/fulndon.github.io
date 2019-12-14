---
title: 分支管理
domainimg: ohbudtted.bkt.clouddn.com
lang: tools\git
date: 2019-12-14 16:00:36
tags:
categories: [工具,git]
---
#查看本地分支，当前所在分支以 * 标出
$ git branch

#查看所有分支
$ git branch -avv

#基于当前分支创建一个新分支
$ git branch <branch name>

#基于存在的分支创建一个新分支
$ git branch <branch name> <exist branch>

#基于远程分支创建一个新分支
git branch <branch name> origin/master

#基于提交创建一个新分支
$ git branch <branch name> <commit id>

#基于标签创建一个新分支
$ git branch <branch name> <tag name>

#删除分支
$ git branch -d {dev}

#切换分支
$ git checkout <branch name>

#合并分支
$ git merge <merge target>

#解决冲突，如果因冲突导致自动合并失败，此时 status 为mergeing 状态.
#需要手动修改后重新提交（commit） 

# 列出已经存在的远程仓库
$ git remote

# 列出远程仓库的详细信息，在别名后面列出URL地址
$ git remote -v

#添加远程仓库地址
$ git remote add origin http:xxx.xxx

#删除指定名称的远程仓库origin
$ git remote remove origin 

#把本地仓库的提交推送到远程仓库
#上传新分支至远程
$ git push --set-upstream origin master 
$ git push -u origin master

#将本地分支与远程建立关联
$ git branch --track --set-upstream-to=origin/test test