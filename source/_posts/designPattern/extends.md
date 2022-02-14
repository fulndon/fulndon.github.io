---
title: extends
categories:
- 艺术
- designPattern
domainimg: ohbudtted.bkt.clouddn.com
lang: designPattern
date: 2018-05-15 07:36:49
tags:
---
# 方法的执行
父类声明的类只会执行，实例重现父类的方法，父类和基类拥有的方法。
重写：方法名和参数名<span style="color:red">完全相同</span>，反回结果与不大于父类视为重写，参数有继承关系也不是重写。
<span style="color:red">方法同名，子类参数作用域小于父类（不美好的方法，抵制出现）会出现以假乱真，子类实例被父类声明后，调不到子类实例的方法，消失了</span>
例：药房拿药，大人吃2片，小孩吃1片，小孩替大人去拿药会拿到2片大人的药量
<span style="color:red">允许出现的情况</span>
例：大人小孩玩小孩游戏，小孩可以和大人玩，也可以和小孩玩，大人只和小孩玩，子类参数大于父类参数
<span style="color:red">
重写：方法名和参数名完全相同视为重写，会执行子类方法。参数若有继承，也不算是重写，子类参数作用域缩小时只有子类句柄调用才可执行。重写的方法返回结果可以缩小，放大会报错（同名，同种参数)</span>
<!-- more -->
```
package basic.test;

/**
 * Created by MSI-PC on 2018/5/14.
 */
class RootMan{
    public void supper(){
        System.out.println("super");
    }
    //和小孩玩游戏
    public Child playChildGame(Child child){
        System.out.println("super_game_child");
        return null;
    }
    //获取药量
    public Parent getDrug(RootMan parent){
        System.out.println("root_6片药");
        return null;
    }
    public RootMan talk(Parent parent){
        System.out.println("parent_"+this.getClass());
        return null;
    }
}
abstract class Parent extends  RootMan{
    public Parent() {
        System.out.println("parent");
    }
    //@Override 报错 不是重写
    public RootMan getDrug(Parent parent){
        System.out.println("parent_4片药");
        return null;
    }
    @Override
    public Parent talk(Parent parent){
        System.out.println("parent_"+this.getClass());
        return null;
    }
    public Child talkParaSmall(Child parent){
        System.out.println("test_child"+this.getClass());
        return null;
    }
}
public class Child extends Parent {
    Child(){
        System.out.println("child");
    }

    //@Override 不是重写加此标识会报错 只有自己类的句柄会调用
    public RootMan getDrug(Child child){
        System.out.println("test_child:1片药");
        return null;
    }
    //@Override
    public Parent talkParaSmall(RootMan parent){
        System.out.println("test_child"+this.getClass());
        return null;
    }
    //对小孩来说，大人就是父母  不是重写
    public RootMan playChildGame(Parent parent){
        System.out.println("test_child");
        return null;
    }
    @Override//真正的重写 返回参数虽不同但也算是 返回结果不能扩大
    public Child talk(Parent parent){
        System.out.println("test_child"+this.getClass());
        return null;
    }

    public static void main(String[] args) {
        //子类实例
        RootMan rootMan = new RootMan();
        Parent parent = new Child();
        Child child = new Child();//小参数
        parent.getDrug(child);//要拿小孩的药量，经果拿到了大人的药量
        parent.getDrug(parent);
        parent.playChildGame(child);//执行的方法从基类开始选择
       // parent.playChildGame(parent); 报错 因为parent是子类特有的方法
        child.talkParaSmall(child);//子类句柄调用 子类方法
        parent.talk(parent);//假大人执行重写的子类方法
        child.talk(parent);//子类方法
    }
}


```
