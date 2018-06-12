package com.qgutech.pe.module.ems.vo;

import com.alibaba.fastjson.annotation.JSONField;

import java.util.List;

/**
 * 真正的试卷内容对象,Pr为Paper的简写
 *
 * @author Created by zhangyang on 2016/10/19.
 */
public class Pr {
    /**
     * 题目数量
     */
    private Integer ic;

    /**
     * 总分
     */
    private Double tm;

    /**
     * 试题集合
     */
    private List<Ic> ics;

    /**
     * 答题规则
     */
    @JSONField(serialize = false)
    private String answerRule;

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

    public List<Ic> getIcs() {
        return ics;
    }

    public void setIcs(List<Ic> ics) {
        this.ics = ics;
    }

    public String getAnswerRule() {
        return answerRule;
    }

    public void setAnswerRule(String answerRule) {
        this.answerRule = answerRule;
    }
}
