---
title: git存储原理
domainimg: ohbudtted.bkt.clouddn.com
lang: tools\git
date: 2019-12-14 14:03:16
tags:
categories: [工具,git]
---
# 存储对象
tree对象：存储文件所在目录
blob对象：压缩后的文件
commit对象：提交对象
引用对象：指向本地库或远程库的提交位置
# 示例
以一次提交为例：bfd1ec
```
C:\doc\blog\fulndon>git log --pretty=oneline
bfd1ec35db475edb361743fece84b7b0e4efc31f (HEAD -> hexo, origin/hexo, origin/HEAD) cluster recovery
52b2d92266e4bc94565682417d30739ea5b49684 client-notices
```
查看提交对象:含有tree对象引用、parent引用、作者、提交人、注释如下
```
C:\doc\blog\fulndon>git cat-file -p bfd1ec
tree 2e67f1644e184e65df42f00ca68847f53c99b2a6
parent 52b2d92266e4bc94565682417d30739ea5b49684
author fulndon <fulndon@qq.com> 1576132944 +0800
committer fulndon <fulndon@qq.com> 1576132944 +0800

cluster recovery
```
查看树对象内容 2e67f1:上述tree对应的引用uuid
```
C:\doc\blog\fulndon>git cat-file -p 2e67f1
040000 tree 37e9609095ea8b1a1339b147d5732156beae9c4f    .daocloud
100644 blob a9e09fdaddcae298858ae25e9e2f915f0f8303fc    .gitignore
100644 blob 47a5c8b3751409c82122aa567f39cdf2fe031e41    Dockerfile
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391    README.md
100644 blob 029eeb705954841638572f0e869f21e3385b9137    _config.yml
100644 blob 8c47a6e894b59e0a01dcef5c9a93d7b2e9439ea2    daocloud.yml
100644 blob 6465546d831f53613d37ba7e2dc3815a8810428e    img.conf
100644 blob 44c911c3bf89621f28236c3501f062e5b5c08236    imgup.conf
100644 blob e4811dcac52d52872d5a3a8ac3b613932cace95b    package-lock.json
100644 blob 62dd441b5b598093b6d9309919e2368d3ce4d469    package.json
040000 tree ab96d614edf38221ad065be7acc728c913af84fb    scaffolds
040000 tree 882a1c5be44a428cfa102b4c511e73c7e49497d6    source
040000 tree c06aa936d1e5a0ac11c2d33acc761c9d2c26dffb    themes
```
查看文件内容：47a5c  blob对象【Dockerfile文件】
```
C:\doc\blog\fulndon>git cat-file -p 47a5c
 # Dockerfile
 FROM node:latest
 MAINTAINER fulndon <fulndon@qq.com>

 # 安装git、ssh等基本工具
 RUN apt-get update && apt-get install -y git ssh-client ca-certificates --no-install-recommends && rm -r /var/lib/apt/lists/*
```
# 补充
## UUID的生成
以上一节Dockerfile文件为例，commit操作对文件内容进行hash生成
文件内容变后，UUID才会变。Dockerfile-bak和Dockerfile文件只有名称不一样 如下
```
C:\doc\blog\fulndon>git hash-object -w Dockerfile
47a5c8b3751409c82122aa567f39cdf2fe031e41

C:\doc\blog\fulndon>git hash-object -w Dockerfile-bak
47a5c8b3751409c82122aa567f39cdf2fe031e41

//看新的提交增加了bak文件 18364b3b7a4
C:\doc\blog\fulndon>git log
commit 18364b3b7a4115b7fb634d6c6e19b9f53309cea5 (HEAD -> hexo)
Author: fulndon <fulndon@qq.com>
Date:   Sat Dec 14 14:38:24 2019 +0800

//含有上一次提交的引用
C:\doc\blog\fulndon>git cat-file -p 18364b3b7a4
tree 0af02225885b9870ce428f8ecee12d58bd2e2ee8
parent bfd1ec35db475edb361743fece84b7b0e4efc31f
author fulndon <fulndon@qq.com> 1576305504 +0800
committer fulndon <fulndon@qq.com> 1576305504 +0800

uuid hash-object

//会发现此次提交的内容多了一个相同的uuid
C:\doc\blog\fulndon>git cat-file -p 0af022258
040000 tree 37e9609095ea8b1a1339b147d5732156beae9c4f    .daocloud
100644 blob a9e09fdaddcae298858ae25e9e2f915f0f8303fc    .gitignore
100644 blob 47a5c8b3751409c82122aa567f39cdf2fe031e41    Dockerfile
100644 blob 47a5c8b3751409c82122aa567f39cdf2fe031e41    Dockerfile-bak//这里，其他文件和目录因为内容没有变所有uuid不变
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391    README.md
100644 blob 029eeb705954841638572f0e869f21e3385b9137    _config.yml
100644 blob 8c47a6e894b59e0a01dcef5c9a93d7b2e9439ea2    daocloud.yml
100644 blob 6465546d831f53613d37ba7e2dc3815a8810428e    img.conf
100644 blob 44c911c3bf89621f28236c3501f062e5b5c08236    imgup.conf
100644 blob e4811dcac52d52872d5a3a8ac3b613932cace95b    package-lock.json
100644 blob 62dd441b5b598093b6d9309919e2368d3ce4d469    package.json
040000 tree ab96d614edf38221ad065be7acc728c913af84fb    scaffolds
040000 tree b010d532787a06c91b8fc8ea56b17fd7bbb96dad    source
040000 tree c06aa936d1e5a0ac11c2d33acc761c9d2c26dffb    themes
```
## .git 文件夹
详见[这里](https://blog.csdn.net/s646575997/article/details/52143586)
```
├─hooks
├─info 
├─logs //提交日志信息
│  └─refs
│      ├─heads
│      └─remotes
│          └─origin
├─objects //存储对象
│  ├─02 //blob对象的前两位
│  ├─0a
│  ├─info
│  └─pack
└─refs //本地提交、远程提交、标签提交最新的uuid
│   ├─heads
│   ├─remotes
│   │  └─origin
│   └─tags
│ 
├──index //暂存区索引库：含有object库中的所有对象、tree对象  执行add命令时此文件更新了
```