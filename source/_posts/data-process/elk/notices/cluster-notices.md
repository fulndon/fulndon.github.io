---
title: cluster-notices
domainimg: ohbudtted.bkt.clouddn.com
lang: data-process\elk\notices
date: 2019-12-12 11:13:52
tags:
categories:
 - 数据
 - ELK
 - notices
---
# 节点闪退
调整分片自动分配及关闭负载均衡，详情如下

```
PUT _cluster/settings
{
  "persistent": {
   "cluster": {
      "routing": {
        "rebalance": {
          "enable": "none"
        },
        "allocation": {
          "node_concurrent_recoveries": "1",//默认是2，1个节点只允许一个出(恢复在其他节点)一个进
          "enable": "new_primaries"  //kibana每天都会生成新的索引
        }
      }
    }
  }
}
//恢复副本
PUT _cluster/settings
{
  "persistent": {
   "cluster": {
      "routing": {
        "allocation": {
          "enable": null
        }
      }
    }
  }
}
//在分片开始恢复时关掉---即监控的Overview界面出现副本恢复的进度时
PUT _cluster/settings
{
  "persistent": {
   "cluster": {
      "routing": {
        "allocation": {
          "enable": "new_primaries"  //kibana每天都会生成新的索引
        }
      }
    }
  }
}
```

# 主分片不分配
需要找到主分片在未脱离集群时所在节点后执行以下命令
详情参见[这里](https://www.elastic.co/guide/en/elasticsearch/reference/6.3/cluster-reroute.html#_forced_allocation_on_unrecoverable_errors)
```
POST _cluster/reroute
{
    "commands": [
        {
            "allocate_stale_primary": {
                "index": "s2-********201908", 
                "shard": 0, 
                "node": "es3", 
                "accept_data_loss": true
            }
        }
    ]
}
```