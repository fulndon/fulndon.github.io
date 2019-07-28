---
title: decoratorPattern
categories:
- 编程的艺术
- designPattern
domainimg: ohbudtted.bkt.clouddn.com
lang: designPattern
date: 2018-05-11 22:01:25
tags:
---
# 装饰模式
动态地给一个对象添加一些额外的职责。和代类模式类似，装饰模式在于给原有方法添加功能，继承抽像，而代理模式，在于代理所有方法，实现抽像。
给书皮做装饰，写姓名，包书皮
<!-- more -->
```
public class Client {
    public static void main(String[] args) {
        Book book = new MathBook();//拿到一本书
        Decorator writeName = new TagBookDecorator(book);//写上自己的名字
        Decorator clothesBook = new MathBookDecorator(writeName);//包上书皮
        //此刻装饰的对象是tag装饰  这个读书方法属于书皮装饰的方法
        clothesBook.readBook();//读书  先弄的书皮，再写的名字
    }
}
```
# 几个装饰
```
public abstract class Decorator extends Book{
    private Book book = null;
    public Decorator(Book book) {
        this.book = book;
    }
    @Override
    public void readBook() {
        this.book.readBook();
    }
}
class TagBookDecorator extends Decorator{
    private void selfTagPost(){
        System.out.println("贴上自己的标签");
    }

    @Override
    public void readBook() {
        System.out.println("书的侧面写上自己的名字");
        super.readBook();
    }

    public TagBookDecorator(Book book) {
        super(book);
    }
}
class MathBookDecorator extends Decorator{
    private void bookClothes(){
        System.out.println("给数学书包上书皮");
    }
    public MathBookDecorator(Book book) {
        super(book);
    }
    @Override
    public void readBook() {
        bookClothes();//包上书皮再读书
        super.readBook();
    }
}

```
# 装饰对象
```
public abstract class Book {
    public abstract void readBook();
}
class MathBook extends Book{
    @Override
    public void readBook() {
        System.out.println("读数学书");
    }
}
```