package com.qgutech.pe.module.ems.vo;

import com.qgutech.pe.module.ems.model.ExamSetting;

import java.util.Date;
import java.util.Map;

/**
 * 成绩设置 ScoreSetting
 *
 * @author Created by zhangyang on 2016/11/14.
 */
public class Ss {
    /**
     * 成绩设置的类型
     */
    private ExamSetting.ScoreType st;

    /**
     * 折算后分数 convertMark
     */
    private Double cm = 0D;

    /**
     * 及格线 passRate
     */
    private Integer pr = 0;

    /**
     * 成绩发布类型
     */
    private ExamSetting.ScorePublishType spt;

    /**
     * 手动发布中是否定时发布 timerPublish
     */
    private Boolean tp = false;

    /**
     * 发布时间
     */
    private Date pd;

    /**
     * 科目折算权重 subjectRate
     */
    private Map<String, Double> sr;

    /**
     * 多选题判分规则
     */
    private ExamSetting.MultiScoreType mst;

    public ExamSetting.ScoreType getSt() {
        return st;
    }

    public void setSt(ExamSetting.ScoreType st) {
        this.st = st;
    }

    public Double getCm() {
        return cm;
    }

    public void setCm(Double cm) {
        this.cm = cm;
    }

    public Integer getPr() {
        return pr;
    }

    public void setPr(Integer pr) {
        this.pr = pr;
    }

    public ExamSetting.ScorePublishType getSpt() {
        return spt;
    }

    public void setSpt(ExamSetting.ScorePublishType spt) {
        this.spt = spt;
    }

    public Boolean getTp() {
        return tp;
    }

    public void setTp(Boolean tp) {
        this.tp = tp;
    }

    public Date getPd() {
        return pd;
    }

    public void setPd(Date pd) {
        this.pd = pd;
    }

    public Map<String, Double> getSr() {
        return sr;
    }

    public void setSr(Map<String, Double> sr) {
        this.sr = sr;
    }

    public ExamSetting.MultiScoreType getMst() {
        return mst;
    }

    public void setMst(ExamSetting.MultiScoreType mst) {
        this.mst = mst;
    }
}
