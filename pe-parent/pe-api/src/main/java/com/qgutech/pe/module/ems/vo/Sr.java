package com.qgutech.pe.module.ems.vo;

import java.util.Map;

/**
 * 试卷模板封装的组建策略 Strategy_Rule
 *
 * @author Created by zhangyang on 2016/10/19.
 */
public class Sr {
    /**
     * 模板类型,true:代表简单模板,false:代表复杂模板
     */
    private boolean p;

    /**
     * 是否只使用绝密试卷
     */
    private Boolean t;

    /**
     * 试题类型分布
     * 1:单选题数
     * 2:多选题数
     * 3:不定项选择题数
     * 4:判断题数
     * 5:填空题数
     */
    private Map<Integer, Sc> sm;


    public boolean isP() {
        return p;
    }

    public void setP(boolean p) {
        this.p = p;
    }

    public Map<Integer, Sc> getSm() {
        return sm;
    }

    public void setSm(Map<Integer, Sc> sm) {
        this.sm = sm;
    }

    public Boolean getT() {
        return t;
    }

    public void setT(Boolean t) {
        this.t = t;
    }
}
