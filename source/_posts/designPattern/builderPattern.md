---
title: builderPattern
domainimg: ohbudtted.bkt.clouddn.com
lang: designPattern
date: 2018-04-11 22:32:14
tags: designPattern
categories: 
- 编程的艺术
- designPattern
---
设计模式之11 建造者模式
===
就是有一个指导者，去创建不同的表示，就像积木可以被摆放成各种形状，摆放的过程叫创建，思想叫建造者。像导演用各种情节出现顺序制造电影
<!-- more -->

```
public class Director {
    private List<String > sequence = new ArrayList<String>();
    private MoveKFBuilder moveKFBuilder = new MoveKFBuilder();
    public MoveKF getMoveKF(){
        sequence.clear();
        ///练功，打架 练功 打架 奇遇 无敌手
        //将这些剧情放进sequence中
        sequence.add("1");
        sequence.add("2");
        moveKFBuilder.setSequence(sequence);
        return (MoveKF)moveKFBuilder.getMove();
    }
    //恐布片，鬼杀人， 灵异事件
    public static void main(String[] args) {
        Director director = new Director();
        Move move = director.getMoveKF();
        move.playMove();
    }
}

```


```
//电影抽像
public abstract class Move {
    private List<String> sequence = new ArrayList<String>();
    //电影中的各种剧情
    protected abstract void insertPreStory();//前言
    protected abstract void insertKillPeople();//杀人
    protected abstract void funStory();
    protected abstract void fightEveryOne();
    final public void playMove(){
        for (int i = 0; i < sequence.size(); i++) {
            String value = sequence.get(i);
            if("1".equals(value)){
                insertPreStory();
            }else if("2".equals(value)){
                insertKillPeople();
            } else if ("3".equals(value)) {
                funStory();
            }
        }
    }
    final public void setSequence(List<String> sequence){
        this.sequence = sequence;
    }
}

```
```
//某一种类型的电影
public class MoveKF extends Move {
    @Override
    protected void insertPreStory() {
        System.out.println("KF式旁白");
    }

    @Override
    protected void insertKillPeople() {
        System.out.println("KF式杀人");
    }

    @Override
    protected void funStory() {
        System.out.println("KF式fun");
    }

    @Override
    protected void fightEveryOne() {
        System.out.println("KF式fight");
    }
}
```
```
//建造者抽像
public abstract class MoveBuilder {
    public abstract void setSequence(List<String> sequence);
    public abstract Move getMove();
}
```

```
public class MoveKFBuilder extends MoveBuilder {
    private MoveKF moveKF = new MoveKF();
    @Override
    public void setSequence(List<String> sequence) {
        moveKF.setSequence(sequence);
    }

    @Override
    public Move getMove() {
        return moveKF;
    }
}
```