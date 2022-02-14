---
title: prototypePattern
tags: designPattern
categories: 
- 艺术
- designPattern
domainimg: ohbudtted.bkt.clouddn.com
lang: designPattern
date: 2018-05-06 11:20:52
---
# 原型模式
原型模式就是使用对象的克隆的方法。clone()方法复制的是复杂对象的引用，包装类型的数据是复制的值
<!-- more -->
```
public class Prototype implements Cloneable{
    private Integer ref = 3;
    private int i = 2;
    private ArrayList<String> str = new ArrayList<String>();
    @Override
    protected Object clone() throws CloneNotSupportedException {
        Prototype o = (Prototype) super.clone();
        o.str = (ArrayList<String>)this.str.clone();
        return o;
    }

    public static void main(String[] args) {
        Prototype p = new Prototype();
        p.str.add("1");
        try {
           Prototype t = (Prototype) p.clone();
           t.ref = Integer.valueOf(2);
           t.str.add("clone");
            System.out.println(p.ref+p.str.toString());
            System.out.println(t.ref);
        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
        }
    }
```
# 中介者模式
中介公司就是中介者  还有个同事的角色 
当多个对象间有复杂的业务逻辑时，可将此逻辑交由中介处理
```
//抽像基类 通过get set方式注入多个同事
public abstract class Mediator {
    protected ConcreteColleague concreteColleague;
    protected ConcreteColleague concreteColleagueTwo;
    abstract void signAggremeng();//到店签合同
    abstract void seeLicense();//看营业执照
}
//处理业务逻辑
public class ConcreteMediator extends Mediator {
    @Override
    void signAggremeng() {//同事方法
        super.concreteColleague.talk();
    }
    void seeLicense(){
        System.out.println("看营业执照");
    }
}
```

```
public abstract class Colleague {
    protected Mediator mediator;//同事必须有中介

    public Colleague(Mediator mediator) {
        this.mediator = mediator;
    }
}
public class ConcreteColleague extends Colleague {
    public ConcreteColleague(Mediator mediator) {
        super(mediator);
    }
    //同事私有
    public void talk(){
        System.out.println("商讨");
    }
    //委拖中介处理
    public void trust(){
        mediator.seeLicense();
    }
}

```