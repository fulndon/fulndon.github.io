---
title: chainPattern
categories: 
- 编程的艺术
- designPattern
domainimg: ohbudtted.bkt.clouddn.com
lang: designPattern
date: 2018-05-09 22:43:45
tags:
---
# 责任链模式
所有处理者站在一条线上，处理自己能处理的东东
含有指向下一个处理者的句柄
体检者拿着体检单去各个科室体检
<!-- more -->
## 各个科室组成的责任链 及 用户体检
```
public class ChainMain {
    //返回一个链的第一个元素 所有的处理者形成一个链
    public static Handler getChainHandlerFirst(){
        Handler handler = new EyeCheckHandler();
        Handler handlerHeavy = new HeavyCheckHandler();
        Handler handlerMouth = new MouthCheckHandler();

        handler.setNextHanler(handlerHeavy);
        handlerHeavy.setNextHanler(handlerMouth);
        return handler;
    }

    public static void main(String[] args) {
        Handler handler = getChainHandlerFirst();
        //用户请求
        Request request = new Request();
        request.setCheckMoudel(Constants.CHECK_TYPE);//体检的类别 请求内容决定了哪些handler可以处理
        handler.handleReport(request);//开始处理请求
        System.out.println("体检报告："+request.getCheckReport());//输出体检报告
    }
}
public class Constants {
    public static String EYE_CHECK = ",1,";
    public static String MOUTH_CHECK = ",2,";
    public static String HEAVY_CHECK = ",3,";
    //体检的类别
    public static String CHECK_TYPE = EYE_CHECK+MOUTH_CHECK;
}
```
## 请求
各个处理者需要处理的内容和响应
```
public class Request {
    private String checkMoudel;//体检模式
    private StringBuilder checkReport = new StringBuilder();//体检报告


    public StringBuilder getCheckReport() {
        return checkReport;
    }

    public String getCheckMoudel() {
        return checkMoudel;
    }

    public void setCheckMoudel(String checkMoudel) {
        this.checkMoudel = checkMoudel;
    }
}

```


## 处理者抽像
自己能处理的级别 下一个处理者 处理业务逻辑
自己的逻辑走完，将请求交给下一个处理者
```
public abstract class Handler {
    private Handler nextHanler;//需要继续将报告单传给下一个科室填写

    protected abstract String checkHealth();//当前科室进行诊治
    protected abstract String currentType();//当前科室是负责哪一块的

    public final String handleReport(Request request){
        StringBuilder report = request.getCheckReport();
        String requestContent = request.getCheckMoudel();
        if(requestContent.contains(currentType())){
            report.append(checkHealth()).append("\n");//可以处理者可以处理该请求
        }
        if(nextHanler != null){//将请求交给下一个处理者
            nextHanler.handleReport(request);
        }
        return  report.toString();
    }
    public final void setNextHanler(Handler nextHanler){
        this.nextHanler = nextHanler;
    }
}

```
## 链上的所有处理者
每个处理者都有一个标识，说明自己能否进行业务处理
以及本职工作
```
public class EyeCheckHandler extends Handler {
    @Override
    protected String checkHealth() {
        System.out.println("视力检测中");
        return "eye is not good ";
    }
    @Override
    protected String currentType() {
        System.out.println("我是眼科的");
        return Constants.EYE_CHECK;
    }
}
class HeavyCheckHandler extends Handler{
    @Override
    protected String checkHealth() {
        System.out.println("体重检测中");
        return "heavy is better";
    }
    @Override
    protected String currentType() {
        System.out.println("我是测体重的");
        return Constants.HEAVY_CHECK;
    }
}
class MouthCheckHandler extends Handler{

    @Override
    protected String checkHealth() {
        System.out.println("口腔检测中");
        return "mouth is ok ";
    }
    @Override
    protected String currentType() {
        System.out.println("我是测口腔的");
        return Constants.MOUTH_CHECK;
    }
}

```