package com.fp.cloud.module.ems.vo;

import com.alibaba.fastjson.annotation.JSONField;

import java.util.Date;

/**
 * 学员进入考试记录
 */
public class Ug {
    /**
     * 进入开始时间
     */
    private Date s;

    /**
     * 最后一次更新时间
     */
    private Date e;

    /**
     * 不序列化
     */
    @JSONField(serialize = false)
    private Ur.Type t;

    public Date getS() {
        return s;
    }

    public void setS(Date s) {
        this.s = s;
    }

    public Date getE() {
        return e;
    }

    public void setE(Date e) {
        this.e = e;
    }

    public Ur.Type getT() {
        return t;
    }

    public void setT(Ur.Type t) {
        this.t = t;
    }
}
