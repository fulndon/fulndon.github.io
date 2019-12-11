---
title: client-notices
domainimg: ohbudtted.bkt.clouddn.com
lang: data-process\elk\notices
date: 2019-12-10 16:15:43
tags:
categories:
 - 数据
 - ELK
 - notices
---
# 减少请求频率
请求频烦时，考虑使用bulk请求，减少交互次数

# 减少索引频率
考虑在更新es前进行预处理：将针对同一条记录进行操作的多条请求进行合并
因为es中，即使是文档中的一个字段进行了更新，该文档也会重新索引
方案一、：hbase中汇总数据--hbase协处理器监控某一行记录更新组织报文并同步到kafka---es增量更新
方案二、：表数据--kafka--合并文档并更新至es

# 合理利用连接资源
避免重复创建连接，考虑使用连接池

# 请求集群节点
一个client 实例连接到了[a,b,c]三个节点，第一次请求a节点，第二次请求b节点
RestHighLevelClient类的performRequestAsyncNoCatch方法体内最后一行
 this.performRequestAsync(startTime, this.nextNode(),。。。。入参nextNode()调整了RestClient.NodeTuple<Iterator<Node>>中节点的位置，关键方法如下
```
nextNode()->selectNodes->Collections.rotate(list,int distance)//节点移动
```
