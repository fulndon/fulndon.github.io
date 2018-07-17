---
title: 图片展示相关
lang: hexo
date: 2017-05-07 14:00:25
tags:
      - hexo
      - git
      - qhell
categories: hexo

---
# 概术
在windows系统下　通过git bash命令行向七牛空间上传图片
<!--more-->
# 准备工作
## qshell安装

1 下载 [qshell](https://github.com/qiniu/qshell?ref=developer.qiniu.com)无需安装
2  将下载好的exe文件放在你想放的位置，并将其加入系统变量中（高级环境变量-path）
    ![七牛](http://ohbudtted.bkt.clouddn.com/qniu/init.png)
3   注册[七牛](https://portal.qiniu.com/signup?code=3li7hxkyf6gya)建立存储空间,并去个人面板，个人中心创建密钥
## 图片上传配置

1  密钥设置，打开git bash命令行，输入以下命令
```bash?linenums
qshell account  你自己的ak  你自己的sk    //设置 七牛云中的ak sk
qshell account   //可以查看你设置的ak sk是否正确
```


2  博客根目录下建立img文件夹，imgup.conf分别用于存放上传的图片和配置信息（如下）
  
  ```json?linenums   
     {
    "src_dir"   :   "E:\\blog\\hexo\\img",
    "bucket"     :   "fulndon-blog",
    "log_level"  :   "info",
    "log_stdout" :   true   //会将相关日志输出到控制台，
	}
 ```
   
   
   本次配置结果：图片上传的链接是**域名+图片相对于src_dir的路径** 如 ： 域名/test/init.jpg表示init.jpg图片是src_dir目录下的test文件夹中
 3 图片上传  于博客根目录下执行以下bash命令  2 是线程数， 
```bash?linenums
 qshell qupload 2 imgup.conf
```
其他参数说明，参见
[详细信息](https://developer.qiniu.com/kodo/tools/1302/qshell)
[qupload](https://github.com/qiniu/qshell/blob/master/docs/qupload.md)
