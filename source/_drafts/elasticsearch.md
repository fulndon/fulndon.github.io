---
title: elasticsearch
domainimg: ohbudtted.bkt.clouddn.com
lang: ELK
date: 2018-08-06 09:39:30
tags:
categories: 
 - 数据
 - ELK
 - notices
---
# 安装
## 将下载好的文件由windows上传至linux
```
Administrator@fulndon MINGW64 /f/pakage
$ scp ./*  fulndon@192.168.56.128:/home/fulndon/soft
```
<!-- more -->
## 要求jdk 版本：1.8
[jdk1.8下载](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
```
[root@rabbit fulndon]# mkdir /usr/java
[root@rabbit fulndon]# tar -zxvf soft/jdk-8u181-linux-x64.tar.gz 
[root@rabbit fulndon]# mv jdk1.8.0_181/ /usr/java/
```
环境变量
```
[root@rabbit fulndon]# vim /etc/profile
```
加入以下参数后，<span color="red"> source /etc/profile</span> 使配置生效
java -version 验证
```
export JAVA_HOME=/usr/java/jdk1.8.0_181
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib:$CLASSPATH
export JAVA_PATH=${JAVA_HOME}/bin:${JRE_HOME}/bin
export PATH=$PATH:${JAVA_PATH}
```