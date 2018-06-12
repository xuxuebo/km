package com.qgutech.pe.module.ems.vo;

import com.alibaba.fastjson.annotation.JSONField;

import java.util.List;

/**
 * 选项信息
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月18日17:30:29
 */
public class Io {

    /**
     * 选项内容
     */
    private String ct;

    /**
     * 选项图片路径 不序列化
     */
    @JSONField(serialize = false)
    private List<String> ctImgUrls;

    /**
     * 字母排序 不序列化
     */
    @JSONField(serialize = false)
    private String so;

    /**
     * 是否是正确选项
     */
    private Boolean t;

    public String getCt() {
        return ct;
    }

    public void setCt(String ct) {
        this.ct = ct;
    }

    public Boolean getT() {
        return t;
    }

    public void setT(Boolean t) {
        this.t = t;
    }

    public String getSo() {
        return so;
    }

    public void setSo(String so) {
        this.so = so;
    }

    public List<String> getCtImgUrls() {
        return ctImgUrls;
    }

    public void setCtImgUrls(List<String> ctImgUrls) {
        this.ctImgUrls = ctImgUrls;
    }
}
