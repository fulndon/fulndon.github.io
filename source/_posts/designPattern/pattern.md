---
title: Template
categories: 
- 编程的艺术
- designPattern
domainimg: ohbudtted.bkt.clouddn.com
lang: designPattern
date: 2018-01-14 10:05:42
tags: designPattern
---
设计模式之 10 模板方法模式
===

---
定义一个操作中的算法框架，将一些具体步骤延迟到子类，由子类实现。如，我们出门买东西的步骤。抽像类中有，出门 沟通 付款 拿东西 回家，这些基本方法和包含这些基本方法的模板方法。子类实现基本方法。重点在<span style="color:red">固有的顺序</span>
<!-- more -->
```
public abstract  class BuySthTemplate {
    public abstract void goToOut();
    public abstract void chat();
    public abstract void pay();
    public abstract void gotSth();
    public void buySthTem(){
        this.goToOut();
        this.chat();
        if(needPay()){
            this.pay();
        }
        gotSth();
    }
    protected boolean needPay(){//子类可覆写此方法，以影响固有逻辑
        return true;
    }
}
```



``` 
public class BuySth extends BuySthTemplate {
    @Override
    public void goToOut() {
        System.out.println("A号人出去了");
    }

    @Override
    public void chat() {
        System.out.println("A号人在聊天");
    }

    @Override
    public void pay() {
        System.out.println("A号人付钱了");
    }

    @Override
    public void gotSth() {
        System.out.println("A号人拿到东西了");
    }
    protected boolean needPay(){
        System.out.println("一系列的逻辑判断，不用付钱了");
        return false;
    }

    public static void main(String[] args) {
        BuySth buySth = new BuySth();
        buySth.buySthTem();
    }
}
```
