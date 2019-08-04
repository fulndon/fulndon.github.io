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
# 相关操作
* 生成密钥

```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
将公钥放置在对应的项目的Deploy keys中

```
* 在根目录下新建[Dockerfile](#Dockerfile)文件
* 在根目录下新建.daocloud文件夹,有以下内容
 - id_rsa              
 - [known_hosts](#known-hosts)
 - [ssh_config](#ssh-config)
* daocloud操作
	* 新建项目，关联对应的源代码，如xx.github.io，会生成镜像
	* 在镜像仓库标签页设置对应镜像
		* 设置页：勾选打包镜像存为latest标签，便于下面的布署任务执行
		* 流程定义页：右下角点击在线编辑yml-替换成这里的内容[daocloud.yml](#daocloud.yml)
		* 点击构建任务复制镜像发布地址、设置触发条件
		* 点击布署任务设制镜像地址、依赖条件

# known_hosts
你本地生成的文件就行C:\Users\MSI-PC\.ssh
说是通过ssh -T git@github.com这个命令生成的，（输入yes）

# ssh_config
```
Host fulndon.github.com
HostName github.com
User fulndon
IdentityFile ~/.ssh/id_rsa
IdentitiesOnly true
PreferredAuthentications true
```

# Dockerfile
```
 # Dockerfile
 FROM node:latest
 MAINTAINER fulndon <fulndon@qq.com>

 # 安装git、ssh等基本工具
 RUN apt-get update && apt-get install -y git ssh-client ca-certificates --no-install-recommends && rm -r /var/lib/apt/lists/*

 # 设置时区，不知道为什么？
 RUN echo "Asia/Shanghai" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
 # 只安装Hexo命令行工具，其他依赖项根据项目package.json在持续集成过程中安装
 RUN npm install hexo-cli -g  --registry=https://registry.npm.taobao.org

 EXPOSE 4000
```

# daocloud.yml

注意修改xx
```
version: 3
image: CentOs:7.1.1503
stages:
- build
- deploy
布署任务:
  stage: deploy
  only:
    branches:
    - xx你的分支
  pull_request: false
  dependencies:
  - 构建任务
  before_script:
  - mkdir ~/.ssh
  - mv .daocloud/id_rsa ~/.ssh/id_rsa
  - mv .daocloud/ssh_config ~/.ssh/config
  - mv .daocloud/known_hosts ~/.ssh/known_hosts
  - chmod 600 ~/.ssh/id_rsa
  - chmod 600 ~/.ssh/config
  - chmod 600 ~/.ssh/known_hosts
  - eval $(ssh-agent)
  - ssh-add ~/.ssh/id_rsa
  - rm -rf .daocloud
  - git config --global user.name "xx"
  - git config --global user.email "xx@qq.com"
  image: xxxxxxxxxx:latest  你自己的镜像
  install:
  - npm install  --registry=https://registry.npm.taobao.org
  script:
  - hexo clean
  - hexo g
  - hexo d
  - rm -rf ~/.ssh/
构建任务:
  stage: build
  job_type: image_build
  only:
    branches:
    - hexo
  build_dir: /
  cache: false
  dockerfile_path: /Dockerfile

```