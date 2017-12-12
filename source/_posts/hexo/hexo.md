---
title: hexo config
lang: hexo
categories: hexo
date: 2017-05-06 18:01:03
tags: hexo
---
# 站点配置文件
1，hexo d
```markdown?linenums
deploy: 
  type: git
  repo: git@github.com:fulndon/fulndon.github.io.git
  branch: master
  ```
  <!--more-->
  2，hexo new  test --lang dirname
```markdown
new_post_name: :lang/:title.md # File name of new posts
```

# 主题配置文件
1，本地搜索  安装了hexo-generator-searchdb
```markdown
local_search:
  enable: true
  ```
  
2，头像设置  avatar
   `avatar: http://ohbudtted.bkt.clouddn.com/think.jpg`
   
3，阅读全文  
```markdown
auto_excerpt:
  enable: false  //设成true 开启   
  length: 150
```
也可以在文章中使用如下标签
```markdown
<!--more-->
```
   
   
   # 其他基础命令
   1   密钥生成
   `ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`
   2   分类，标签页生成
`hexo new page  categories`
   3   指定多个标签
```markdown?linenums
tags:
  - tag1
  - tag2 
//  or
tags: [tag1,tag2,tag3]
```

