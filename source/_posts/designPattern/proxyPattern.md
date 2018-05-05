---
title: proxyPattern
categories: designPattern
domainimg: ohbudtted.bkt.clouddn.com
lang: designPattern
date: 2018-05-05 17:39:06
tags: designPattern
---
# 代理模式
也叫做委拖模式。代理类需要关联到实例对象，替其执行方法
## 动态代理
动态代理是在运行阶段指定代理哪一个对象，使用了JDK提供动态代理接口<span style="color:red">InvocationHandler</span>. Proxy.newProxyInstance方法会返回一个代理。
角色：实例对象， 所有实例的包装 代理工具
场景：代理买票 抽出要代理的业务逻辑：要买的火车号 票数 拿票
<!-- more -->
```
public class Client {
    public static void main(String[] args) {
        TicketBuyerBuyer bean =  new TicketBuyerBuyer("张三");//实例
        InvocationHandler invocation = new TicketBuyIH(bean);//wrapper
        Class<?> cls = bean.getClass();
        // 生成代理实例---1 代理目标的类加载器  代理目标的业务动作  代理类要实现的功能
        TicketBuyerService ticketBuyerProxy =
                (TicketBuyerService) Proxy.newProxyInstance(cls.getClassLoader(),cls.getInterfaces(), invocation);
        ticketBuyerProxy.setCarIndex("1");//哪俩火车
        ticketBuyerProxy.setCount(2);//几张票
        ticketBuyerProxy.getCar();//获得火车票
    }
}

```
```
public class TicketBuyIH implements InvocationHandler{
    //被代理的对象
    private Object target;
    public TicketBuyIH(Object target) {
        this.target = target;
    }
    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        //proxy 为每一个target生成的代理对象
        Object result = method.invoke(target,args);
        if(method.getName().equalsIgnoreCase("getCar")){
            System.out.println("买到票了");
        }
        return result;
    }
}
```

```
public class TicketBuyerBuyer implements TicketBuyerService,Serializable
{
    private String carIndex;
    private Integer count;

    public TicketBuyerBuyer(String name) {
        System.out.println(name+"使用了代理");
    }
    @Override
    public void getCar() {
        System.out.println(carIndex+"号车: "+count+"票");
    }
    public void setCarIndex(String carIndex) {
        this.carIndex = carIndex;
    }
    public void setCount(Integer count) {
        this.count = count;
    }
    public String getCarIndex() {
        return carIndex;
    }
    public Integer getCount() {
        return count;
    }
}
```
## 动态代理扩展
动态代理与业务逻辑结合。为便于以后第三方jar包的升级，新建DynamicProxy类，业务动态子类继承此类
```
        TicketBuyer bean =  new TicketBuyer("张三");
        TicketBuyerService ticketBuyerProxy = BuyTicketDynamicProxy.newProxyInstance(bean);
        ticketBuyerProxy.setCarIndex("1");//哪俩火车
        ticketBuyerProxy.setCount(2);//几张票
        ticketBuyerProxy.getCar();//获得火车票
```
```
public class BuyTicketDynamicProxy extends DynamicProxy {
    public static <T> T newProxyInstance(TicketBuyer ticketBuyer){
        InvocationHandler invocation = new TicketBuyIH(ticketBuyer);
        Class<?> cls = ticketBuyer.getClass();
        return newProxyInstance(cls.getClassLoader(),cls.getInterfaces(),invocation);
    }
}
public class DynamicProxy {
    public static <T> T newProxyInstance(ClassLoader loader, Class<?>[] interfaces, InvocationHandler h){
        System.out.println("动态即将代理执行");
        return (T) Proxy.newProxyInstance(loader,interfaces,h);
    }
}

```
# 强制代理
只能通过代理访问
```
        TicketBuyer bean =  new TicketBuyer("张三");
        TicketBuyerService myProxy = bean.getMyProxy();
        myProxy.getCar();
```
```
public class TicketBuyer implements TicketBuyerService,Serializable
{
    private String carIndex;
    private Integer count;
    private boolean forceProxy = true;
    private TicketBuyerService myProxy;
    public boolean forceProxyRun(){
        boolean execute = false;//是否执行其方法
        if(forceProxy && myProxy == null){
            System.out.println("请用代理访问");
        }else if(forceProxy){
            System.out.println("走的强制代理逻辑");
            execute = true;
        }else{
            System.out.println("走的普通代理逻辑");
            execute = true;
        }
        return execute;
    }
    @Override
    public void getCar() {
        if(forceProxyRun()){
            System.out.println(carIndex+"号车: "+count+"票");
        }
    }
}
```
```
public class BuyTicketProxy implements TicketBuyerService {
	//要代理的实例对象
    private TicketBuyerService ticketBuyer;

    public BuyTicketProxy(TicketBuyerService ticketBuyer) {
        this.ticketBuyer = ticketBuyer;
    }
    @Override
    public void getCar() {
        ticketBuyer.getCar();
    }
    @Override
    public void setCount(Integer count) {
        ticketBuyer.setCount(count);
    }
    @Override
    public void setCarIndex(String carIndex) {
        ticketBuyer.setCarIndex(carIndex);
    }
}

```