package com.qgutech.pe.module.ems.vo;

import com.alibaba.fastjson.annotation.JSONField;

import java.util.List;

/**
 * 试题内容
 */
public class Ic {

    /**
     * 试题答案
     */
    private String a;

    /**
     * 题干
     */
    private String ct;

    /**
     * 是否正确,判断和判断改错题答案
     */
    private Boolean t;

    /**
     * 试题解析
     */
    private String ep;

    /**
     * 试题选项
     */
    private List<Io> ios;

    /**
     * 题干图片路径 不序列化
     */
    @JSONField(serialize = false)
    private List<String> ctImgUrls;

    /**
     * 试题解析图片路径 不序列化
     */
    @JSONField(serialize = false)
    private List<String> epImgUrls;

    /**
     * 折合分
     */
    private Double m;

    /**
     * 试题分值
     */
    private Double rm;

    /**
     * 试题ID
     */
    private String id;

    /**
     * 排序序号
     */
    private Integer no;

    @JSONField(serialize = false)
    private String itemType;

    public String getA() {
        return a;
    }

    public void setA(String a) {
        this.a = a;
    }

    public String getCt() {
        return ct;
    }

    public void setCt(String ct) {
        this.ct = ct;
    }

    public List<Io> getIos() {
        return ios;
    }

    public void setIos(List<Io> ios) {
        this.ios = ios;
    }

    public String getEp() {
        return ep;
    }

    public void setEp(String ep) {
        this.ep = ep;
    }

    public Boolean getT() {
        return t;
    }

    public void setT(Boolean t) {
        this.t = t;
    }

    public List<String> getCtImgUrls() {
        return ctImgUrls;
    }

    public void setCtImgUrls(List<String> ctImgUrls) {
        this.ctImgUrls = ctImgUrls;
    }

    public List<String> getEpImgUrls() {
        return epImgUrls;
    }

    public void setEpImgUrls(List<String> epImgUrls) {
        this.epImgUrls = epImgUrls;
    }

    public Double getM() {
        return m;
    }

    public void setM(Double m) {
        this.m = m;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getItemType() {
        return itemType;
    }

    public void setItemType(String itemType) {
        this.itemType = itemType;
    }

    public Integer getNo() {
        return no;
    }

    public void setNo(Integer no) {
        this.no = no;
    }

    public Double getRm() {
        return rm;
    }

    public void setRm(Double rm) {
        this.rm = rm;
    }
}