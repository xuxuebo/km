package com.fp.cloud.module.ems.vo;

import com.fp.cloud.module.ems.model.UserExamRecord;

import java.util.List;

/**
 * 手机端展示试题信息
 */
public class Pic {

    /**
     * 题号
     */
    private Integer n;

    /**
     * 题目类型
     */
    private Integer t;

    /**
     * 题目数量
     */
    private Integer ic;

    /**
     * 总分
     */
    private Double tm;

    /**
     * 该题分数
     */
    private Double m;

    /**
     * 题干
     */
    private String ct;

    /**
     * 移动端题干
     */
    private Ioa ioa;

    /**
     * 选项内容
     */
    private List<String> ios;

    /**
     * 选项内容
     */
    private List<Ioa> ioas;


    /**
     * 学员答题记录
     */
    private UserExamRecord uer;

    /**
     * 解析
     */
    private String ep;

    /**
     * 正确答案
     */
    private String right;

    public Integer getN() {
        return n;
    }

    public void setN(Integer n) {
        this.n = n;
    }

    public Integer getT() {
        return t;
    }

    public void setT(Integer t) {
        this.t = t;
    }

    public Integer getIc() {
        return ic;
    }

    public void setIc(Integer ic) {
        this.ic = ic;
    }

    public Double getTm() {
        return tm;
    }

    public void setTm(Double tm) {
        this.tm = tm;
    }

    public Double getM() {
        return m;
    }

    public void setM(Double m) {
        this.m = m;
    }

    public String getCt() {
        return ct;
    }

    public void setCt(String ct) {
        this.ct = ct;
    }

    public List<String> getIos() {
        return ios;
    }

    public void setIos(List<String> ios) {
        this.ios = ios;
    }

    public UserExamRecord getUer() {
        return uer;
    }

    public void setUer(UserExamRecord uer) {
        this.uer = uer;
    }

    public String getEp() {
        return ep;
    }

    public void setEp(String ep) {
        this.ep = ep;
    }

    public String getRight() {
        return right;
    }

    public void setRight(String right) {
        this.right = right;
    }

    public List<Ioa> getIoas() {
        return ioas;
    }

    public void setIoas(List<Ioa> ioas) {
        this.ioas = ioas;
    }

    public Ioa getIoa() {
        return ioa;
    }

    public void setIoa(Ioa ioa) {
        this.ioa = ioa;
    }
}
