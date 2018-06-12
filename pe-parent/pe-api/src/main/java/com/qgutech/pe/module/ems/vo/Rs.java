package com.qgutech.pe.module.ems.vo;

import com.qgutech.pe.module.ems.model.ExamSetting;

/**
 * 考试排行设置 RankSetting
 *
 * @author Created by zhangyang on 2016/11/14.
 */
public class Rs {
    /**
     * 排行显示 rankShowType
     */
    private ExamSetting.RankShowType rst;

    /**
     * 显示排行人数 rankShowNum；
     */
    private Integer rsn = 10;

    /**
     * 排行发布
     */
    private ExamSetting.ShowRankType sht;

    public ExamSetting.RankShowType getRst() {
        return rst;
    }

    public void setRst(ExamSetting.RankShowType rst) {
        this.rst = rst;
    }

    public Integer getRsn() {
        return rsn;
    }

    public void setRsn(Integer rsn) {
        this.rsn = rsn;
    }

    public ExamSetting.ShowRankType getSht() {
        return sht;
    }

    public void setSht(ExamSetting.ShowRankType sht) {
        this.sht = sht;
    }
}
