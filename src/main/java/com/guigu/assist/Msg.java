package com.guigu.assist;

import java.util.HashMap;
import java.util.Map;

public class Msg {
    //flag=0:fail    flag=1:success
    private int flag;
    private String msg;
    private Map<String,Object> m=new HashMap<>();

    public static Msg success(){
        Msg msg=new Msg();
        msg.setFlag(1);
        msg.setMsg("处理成功");
        return msg;
    }

    public static Msg fail(){
        Msg msg=new Msg();
        msg.setFlag(0);
        msg.setMsg("处理失败");
        return msg;
    }
    //支持链式操作
    public Msg add(String s,Object obj){
        this.getM().put(s,obj);
        return this;
    }

    public int getFlag() {
        return flag;
    }

    public void setFlag(int flag) {
        this.flag = flag;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getM() {
        return m;
    }

    public void setM(Map<String, Object> m) {
        this.m = m;
    }
}
