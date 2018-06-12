package com.qgutech.pe.module.ems.vo;

import com.qgutech.pe.module.ems.model.ExamSetting;

/**
 * 考试基本设置 examSetting
 *
 * @author Created by zhangyang on 2016/11/14.
 */
public class Es {
    /**
     * 考试时长类型 examLengthType
     */
    private ExamSetting.ExamLengthType elt;

    /**
     * 考试时长 examLength
     */
    private Integer el = 0;

    /**
     * 答题模式 answerType
     */
    private ExamSetting.AnswerType at;

    /**
     * 是否允许修改答案 canEdit
     */
    private Boolean ce = false;

    /**
     * 补考设置类型
     */
    private ExamSetting.MakeUpType mt;

    /**
     * 补考次数 makeupNum
     */
    private Integer mn = 0;

    public ExamSetting.ExamLengthType getElt() {
        return elt;
    }

    public void setElt(ExamSetting.ExamLengthType elt) {
        this.elt = elt;
    }

    public Integer getEl() {
        return el;
    }

    public void setEl(Integer el) {
        this.el = el;
    }

    public ExamSetting.AnswerType getAt() {
        return at;
    }

    public void setAt(ExamSetting.AnswerType at) {
        this.at = at;
    }

    public Boolean getCe() {
        return ce;
    }

    public void setCe(Boolean ce) {
        this.ce = ce;
    }

    public ExamSetting.MakeUpType getMt() {
        return mt;
    }

    public void setMt(ExamSetting.MakeUpType mt) {
        this.mt = mt;
    }

    public Integer getMn() {
        return mn;
    }

    public void setMn(Integer mn) {
        this.mn = mn;
    }
}
