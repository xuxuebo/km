package com.qgutech.pe.module.ems.vo;

import com.qgutech.pe.module.ems.model.ExamSetting;

/**
 * 评卷设置 judgeSetting
 *
 * @author Created by zhangyang on 2016/11/14.
 */
public class Js {
    /**
     * 评卷模式
     */
    private ExamSetting.JudgeType jt;

    /**
     * 是否允许评卷人查看考生信息（姓名、用户名、工号、手机号） viewInfo
     */
    private Boolean vi = false;

    public ExamSetting.JudgeType getJt() {
        return jt;
    }

    public void setJt(ExamSetting.JudgeType jt) {
        this.jt = jt;
    }

    public Boolean getVi() {
        return vi;
    }

    public void setVi(Boolean vi) {
        this.vi = vi;
    }
}
