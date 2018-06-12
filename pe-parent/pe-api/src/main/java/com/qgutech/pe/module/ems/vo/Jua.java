package com.qgutech.pe.module.ems.vo;

import java.util.Map;

/**
 * 评卷详情记录（按试卷评卷）
 *
 * @author LiYanCheng@HF
 * @since 2016年12月28日16:31:27
 */
public class Jua {

    /**
     * 折合分数
     */
    private double s;

    /**
     * 真实分数
     */
    private double rs;

    /**
     * 试题信息
     */
    private Map<String, Jua> m;

    public double getS() {
        return s;
    }

    public void setS(double s) {
        this.s = s;
    }

    public double getRs() {
        return rs;
    }

    public void setRs(double rs) {
        this.rs = rs;
    }

    public Map<String, Jua> getM() {
        return m;
    }

    public void setM(Map<String, Jua> m) {
        this.m = m;
    }
}
