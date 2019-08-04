---
title: git
lang: git
date: 2017-05-06 18:00:35
tags:
categories: [工具,git]
imgdomain:
---
# 简单解绍
git 是一个分布式管理控制系统，多人完成项目时，每个人的本地仓库的项目代码和服务器一样。即本地一个仓库，服务器一个仓库.
[Git中文教程](https://git-scm.com/book/zh/v2)
<!-- more-->
## git 对待数据的方式
对项目进行了一次变更后，git会对当前项目状态做一次快照。当然没有修改的文件，git不会重新存诸，只是建立一个索引指向原先的文件。
![快照流](http://ohbudtted.bkt.clouddn.com/git/git_snapshot.png)
## 相关术语
### 三种状态和三种区域
提交：代码提交至本地仓库、对应于git仓库
修改：、对应于工作目录
暂存：相当于给代码打上标记，表示要提交到仓库中、对应于暂存区域，该区域是一个文件保存了，下次提交时的文件列表信息。
### gitignore
1. 所有空行或者以 ＃ 开头的行都会被 Git 忽略
2. 可以使用标准的 glob 模式匹配
3. 匹配模式可以以（/）开头防止递归
4. 以（/ )结尾，指定目录
5. 模式前加！，表示指定相反文件
```
所谓的 glob 模式是指 shell 所使用的简化了的正则表达式。 星号（*）匹配零个或多个任意字符；[abc] 匹配任何一个列在方括号中的字符（这个例子要么匹配一个 a，要么匹配一个 b，要么匹配一个 c）；问号（?）只匹配一个任意字符；如果在方括号中使用短划线分隔两个字符，表示所有在这两个字符范围内的都可以匹配（比如 [0-9] 表示匹配所有 0 到 9 的数字）。 使用两个星号（*) 表示匹配任意中间目录，比如`a/**/z` 可以匹配 a/z, a/b/z 或 `a/b/c/z`等
```
# 命令
## init
### 设置身份标识
```
//去掉 --global，表示只针对当前用户 
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```
### 设置文本编辑器emacs
```
$ git config --global core.editor emacs
```
## 常用命令
暂存前，看看文件改动了什么，可以使用git diff 命令
git diff --cached 查看已经暂存起来的变化
git log -p -2  -p，用来显示每次提交的内容差异。 你也可以加上 -2 来仅显示最近两次提交
git log --pretty=oneline  
git log --pretty=format:"%h - %an, %ar : %s"
```
Administrator@fulndon MINGW64 /h/blog/hexo (hexo)
$ git log --pretty=oneline
d0f7caea2373e7ee2dcf592a39dbcaee7b2cf86c git 自定义命令
10299cbba62197d3e133cc3ea83595be92498649 love page
5ac558b6574c58a183442ee6cfa0c37efb8b949b qshell upload

$ git log --pretty=format:"%h - %an, %ar : %s"
d0f7cae - fulndon, 7 days ago : git 自定义命令
10299cb - fulndon, 7 days ago : love page

```

