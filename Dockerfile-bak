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