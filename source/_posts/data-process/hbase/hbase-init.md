---
title: hbase初识
categories:
  - 数据
  - hbase
domainimg: ohbudtted.bkt.clouddn.com
date: 2019-08-10 11:51:21
tags:
---
# hbase是什么 
bsae 是[hadoop database](https://hbase.apache.org/)，一个分布式的，高容量、可扩展的，面向列的nosql大数据存储数据库。
* 可靠性：提供wal和replication机制，前者保证写入时数据不会丢失，后者即为副本，集群异常时，数据扔可用
* 面向列：一行中的数据，如果某一行为null，不会占用存诸空间
* 扩展性：在不停止现有服务的前提下，可以随时添加或减少节点
* 高容量：单表可以有百亿行，百万列

#核心功能模块
客户端client、协调服务模块ZooKeeper、主节点Hmaster、Region节点RegionServer
## 客户端
使用hbase的RPC机制与Hmaster(管理类)和HRegionServer(数据读写类)进行通信
## zookeeper
* 保证集群中只有一个活跃的Hmaster节点
* 存储所有的region的寻址入口
* 实时监控regionServer,并将其状态通知给hmaster
* 存储hbase元数据信息

## master
 表和region的管理工作
## regionServer
负责用户的IO请求，向HDFS文件系统中读写数据
* 它管理了一系列的HRegion,对应了table中的一个region。
* HRegion由多个HStore组成，一个HStore对应了表中的一个列簇
* HStore由两部分组成，MemStore StoreFile
* MemStore是Stored Memory Buffer ,用户写数时，会先将数据写入其中，满了后会flush形成一个StoreFile
* StoreFile文件数到阈值后会触发合并操作(多个合并成一个--进行更新和删除操作)--单个文件大小达到某一阈值触发当前region的split操作，生成两个子Region会初Hmaster分配到相应的regionServer上。
### HLog
每个HRegionServer都有一个，每次用户写入MemStore中时也会写一份数据到这个文件中
* 定期滚动刷新-删除已持久化到StoreFile中的数据
* HRegionServer意外终止后，HMaster通过zookeeper感知到
	* 首先将HLog中不同region的数据拆分到相应的region目录下
	* 然后将失效的region重新分配给HRegionServer,这些server加载region时会发现有历史的HLog处理，会将其中的数据放至MemStore,然的flush到storeFiles完成数据恢复。

# 数据模型
hbase中的数据也是按表区分。表中的每一行由行键和列簇中的列组成，行键类似于id。表中的行是按照ROWKEY行键来排序的。
## 逻辑模型
hbase表中的数据是三维的，x-列名，y-rowkey   z-时间戳。即表中每一个单元格都有不同时间段的值默认展示最近的值
* 表中的每一行可以有不同的列，创建表时可以不用指定列的类型，即每一行所涉及的列可以不同
* 表中每一行的行键都是唯一的。
* 列名：列簇前缀:修饰符

## 物理模型
一个列簇的数据会被同一个region管理，物理上存放在一起