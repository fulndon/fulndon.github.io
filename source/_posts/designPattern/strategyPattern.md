---
title: strategyPattern
categories: designPattern
domainimg: ohbudtted.bkt.clouddn.com
lang: designPattern
date: 2018-05-14 07:46:42
tags:
---
# 策略模式
定义了算法族，分别封装每个算法，让他们之间可以相互替换，相对于客户来说，其变化是透明的
角色：包装类（放策略) 策略实例  策略抽像
例子：加法还是减法
<!-- more -->	
```
//策略抽像
public abstract class Calculator {
    public abstract int exec(int a,int b);
    public static void main(String[] args) {
        Container container = new Container(1);
        int result = container.exec(1,2);
        System.out.println(result);
    }
}
//两个策略
public class ADD extends Calculator {
    @Override
    public int exec(int a, int b) {
        return a+b;
    }
}
class SUB extends Calculator{
    @Override
    public int exec(int a, int b) {
        return a-b;
    }
}
//策略容器
public class Container {
    private Calculator calculator;
    public Container(int calculatorType){
        if(calculatorType == 0){
            this.calculator = new SUB();
        }else {
            this.calculator = new ADD();
        }
    }
    public int exec(int a,int b){
      return calculator.exec(a,b);
    }
}
```
# 策略枚举
```
public enum CalculatorContainer {
    ADD("+"){//相当于SUB extends 当前枚举类
        @Override
        public int exec(int a, int b) {
            return a+b;
        }
    },
    SUB("-"){//相当于SUB extends 当前枚举类
        @Override
        public int exec(int a, int b) {
            return a-b;
        }
    };
    String result = "";
    private CalculatorContainer(String result){
       // this.result = result;
    }
    public abstract int exec(int a,int b);

    public static void main(String[] args) {
      int c =  CalculatorContainer.ADD.exec(1,2);
        System.out.println(c);
    }
}

```

