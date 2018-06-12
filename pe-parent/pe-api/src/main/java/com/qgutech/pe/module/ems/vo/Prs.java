package com.qgutech.pe.module.ems.vo;

import com.alibaba.fastjson.annotation.JSONField;

import java.util.Date;
import java.util.List;

/**
 * 监控截图信息
 *
 *
 */
public class Prs {
    /*
     *截图
     */

    public List<String> getPrcImgUrls() {
        return prcImgUrls;
    }

    public void setPrcImgUrls(List<String> prcImgUrls) {
        this.prcImgUrls = prcImgUrls;
    }

    public Date getCr() {
        return cr;
    }

    public void setCr(Date cr) {
        this.cr = cr;
    }

    public String getRk() {
        return rk;
    }

    public void setRk(String rk) {
        this.rk = rk;
    }

    @JSONField(serialize = false)
    private List<String> prcImgUrls;
    /**
     * 创建时间
     */
    private Date  cr;
    /*
     *备注信息
     */
    private String rk;
}
