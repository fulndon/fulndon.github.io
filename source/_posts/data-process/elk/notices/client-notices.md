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

# 合理利用连接资源
避免重复创建连接，考虑使用连接池