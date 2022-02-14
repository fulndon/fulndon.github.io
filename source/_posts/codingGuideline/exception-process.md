---
layout: exception_process
title: exception_process
lang: codingGuideline
categories: 
- 艺术
- artCoding
date: 2019-08-02 20:58:02
tags: design
---
# 1、捕获异常后，禁止直接 return
* 若是抛出，则不要重复打印日志信息
* 若是不抛出,打印出日志信息
* 无论是传递错误信息，还是日志打印，一定要带上堆栈信息，如 new ServiceException('xxxx',e);

# 2、尽量捕获特定异常，即自定义异常
```
一、运行时异常
代码无法处理，程序停止，即时throw掉，调用方不捕获也可以编译通过，如a方法只能处理int类型的数据，结果传进来一个汉字，就可以声明运行时异常。
二、检查异常
代码可以针对异常进行处理

```
# 3、不要在finally块中抛出异常
finally块中抛出的异常会覆盖本方法中抛出的异常
```
    public static void throwRuntimeException(){//运行时异常方法不用处理，即不抛出，不报错
        try{
            throw new RuntimeException("xx");
        }finally {
            throw new RuntimeException("finally_throwRuntimeException");
        }
    }
    public static void throwCheckedException(){//检查异常，需要程序去处理
        try{
            throw new CheckedException("xx");
        }catch (CheckedException e){
            throw new CheckedException("CheckedException");
        }finally{
            throw new RuntimeException("finally_throwCheckedException");//注释掉这块代码，catch块中checked异常会报错，
        }
    }
```
如下没有业务异常xx
```
java.lang.RuntimeException: finally_throwCheckedException
	at org.pentaho.di.trans.steps.elasticsearchbulk.util.Constants.throwCheckedException(Constants.java:129)
	at org.pentaho.di.trans.steps.elasticsearchbulk.util.Constants.main(Constants.java:134)
Exception in thread "main" java.lang.RuntimeException: finally_throwRuntimeException
	at org.pentaho.di.trans.steps.elasticsearchbulk.util.Constants.throwRuntimeException(Constants.java:120)
	at org.pentaho.di.trans.steps.elasticsearchbulk.util.Constants.main(Constants.java:138)
```
# 4、抛出异常时不要使用 e.printStackTrace();
应带上有用的上下文信息，注释

# 5、尽早捕获异常，传递异常发生时的上下文信息

# 6、捕获异常后注意对资源的清理

# 7、不要使用异常来控制程序流程

# 8、及早校验用户的输入
