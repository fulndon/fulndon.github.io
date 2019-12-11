---
title: mapping-notices
domainimg: ohbudtted.bkt.clouddn.com
lang: data-process/elk/notices
date: 2019-12-06 18:00:49
tags:
categories:
 - 数据
 - ELK
 - notices
---
# 分片数设置
* [分片数分裂](https://www.elastic.co/guide/en/elasticsearch/reference/6.3/indices-split-index.html)
分裂时可以先将副本书调为0(可以加快索引速度)，分配完后，再改回来

 ```
//创建索引时指定
PUT my_source_index
{
    "settings": {
        "index.number_of_shards" : 1,
        "index.number_of_routing_shards" : 200 //总分片数max
    }
}
//扩展分片时执行
PUT /my_source_index/_settings
{
  "settings": {
    "index.blocks.write": true 
  }
}
POST my_source_index/_split/my_target_index
{
  "settings": {
    "index.number_of_shards": 2  //本次扩展后的分片数
  }
}
 ```
* [分片数大小建议](https://www.elastic.co/guide/en/elasticsearch/reference/6.8/scalability.html#it-depends)
建议20G-40G

# 字段类型设置
## 尽量使用[宽表](https://www.elastic.co/guide/en/elasticsearch/reference/6.3/tune-for-search-speed.html#_document_modeling)查询

 ```
 nested嵌套查询慢几倍、父子查询慢成百上千倍
如果关系型结构的子表中查询条件只涉及到单个属性，即子表的一个属性满足就返回，可以用数组
 ```
## 自定义map

```
将多个可搜索字段合并成一个字段：搜索的字段越少，速度越快 
```