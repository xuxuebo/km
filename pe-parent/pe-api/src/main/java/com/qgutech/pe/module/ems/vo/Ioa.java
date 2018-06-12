package com.qgutech.pe.module.ems.vo;

import com.alibaba.fastjson.annotation.JSONField;

import java.util.List;

/**
 * Created by jianbolin on 2018/5/31.
 */
public class Ioa {

    /**
     * 选项内容
     */
    private String ct;

    private List<Mm> mobileModels;


    public List<Mm> getMobileModels() {
        return mobileModels;
    }

    public void setMobileModels(List<Mm> mobileModels) {
        this.mobileModels = mobileModels;
    }

    public String getCt() {
        return ct;
    }

    public void setCt(String ct) {
        this.ct = ct;
    }

    @Override
    public String toString() {
        return "Ioa{" +
                "ct='" + ct + '\'' +
                ", mobileModels=" + mobileModels +
                '}';
    }
}
