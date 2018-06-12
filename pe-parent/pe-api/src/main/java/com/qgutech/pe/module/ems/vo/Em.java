package com.qgutech.pe.module.ems.vo;

import java.util.Date;

/**
 * 定时存储图片信息
 */
public class Em {

    /**
     * 传输时间
     */
    private Date ct;

    /**
     * 图片路径
     */
    private String iu;

    public Date getCt() {
        return ct;
    }

    public void setCt(Date ct) {
        this.ct = ct;
    }

    public String getIu() {
        return iu;
    }

    public void setIu(String iu) {
        this.iu = iu;
    }
}
