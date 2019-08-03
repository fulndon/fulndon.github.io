# Why Blog
## 为什么写博客
>1、给自己找点事做，感情可能掌控不了，但是我们有可能掌控自己。

>2、好记生不如烂笔头。

>3、安静的环境，私人的空间。

## 关于博客主题
* 博客中的<a target="_blank" href="https://yelog.org/2017/03/24/3-hexo-shortcuts/">快捷键</a>
```
s/S	全屏/取消全屏
w/W	打开/关闭文章目录
j/J	向下滑动
k/K	向上滑动
gg/GG	到最顶端
shift+G/g	到最下端
```
* <a target="_blank" href="https://yelog.org/2017/03/23/3-hexo-instruction/">主题说明</a>
* 如何在模块中读取站点或主题配置文件https://hexo.io/docs/variables  
主题config文件<%= theme.toc.open %>  
站点config文件<%= config.title %>

## 文章置顶 
* node_modules/hexo-generator-index/lib/generator.js
```
'use strict';
var pagination = require('hexo-pagination');
module.exports = function(locals){
  var config = this.config;
  var posts = locals.posts;
    posts.data = posts.data.sort(function(a, b) {
        if(a.top && b.top) { // 两篇文章top都有定义
            if(a.top == b.top) return b.date - a.date; // 若top值一样则按照文章日期降序排
            else return b.top - a.top; // 否则按照top值降序排
        }
        else if(a.top && !b.top) { // 以下是只有一篇文章top有定义，那么将有top的排在前面（这里用异或操作居然不行233）
            return -1;
        }
        else if(!a.top && b.top) {
            return 1;
        }
        else return b.date - a.date; // 都没定义按照文章日期降序排
    });
  var paginationDir = config.pagination_dir || 'page';
  return pagination('', posts, {
    perPage: config.index_generator.per_page,
    layout: ['index', 'archive'],
    format: paginationDir + '/%d/',
    data: {
      __index: true
    }
  });
};
```
* 给置顶的文件加上top参数
```
 ---
title: artCoding
categories: artCoding
domainimg: ohbudtted.bkt.clouddn.com
lang: codingGuideline
date: 2018-05-12 08:45:24
top: 1
tags:
 ---
```

## 博客平台
这个博客通过 <a target="_blank" href="https://hexo.io/">[Hexo]</a>生成，部署在<a target="_blank" href="https://pages.github.com/"> [GitHub Pages]</a>
主题 <a target="_blank" href="https://github.com/yelog/hexo-theme-3-hexo"> [3-hexo]</a> 已经在github上开源

主要功能：
- 搜索支持文章标题、标签(#标签)、作者(@作者)
- pad/手机等移动端适配
- 页面全局快捷键 <a href='http://yelog.org/2017/03/24/3-hexo-shortcuts/'>3-hexo快捷键说明</a>
