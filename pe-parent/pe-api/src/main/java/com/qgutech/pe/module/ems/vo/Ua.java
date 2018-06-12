package com.qgutech.pe.module.ems.vo;

/**
 * 学员答题详情
 */
public class Ua {

    private Integer n;

    /**
     * 是否标记
     */
    private boolean m;

    /**
     * 学员答案
     */
    private String a;

    public boolean isM() {
        return m;
    }

    public void setM(boolean m) {
        this.m = m;
    }

    public String getA() {
        return a;
    }

    public void setA(String a) {
        this.a = a;
    }

    public Integer getN() {
        return n;
    }

    public void setN(Integer n) {
        this.n = n;
    }
}
