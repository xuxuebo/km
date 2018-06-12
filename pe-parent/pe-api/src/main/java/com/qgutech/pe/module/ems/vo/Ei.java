package com.qgutech.pe.module.ems.vo;

import com.qgutech.pe.module.ems.model.Exam;
import com.qgutech.pe.module.ems.model.ExamArrange;

import java.util.Date;

/**
 * 考试相关信息
 *
 * @author LiYanCheng@HF
 * @since 2016年12月3日18:30:27
 */
public class Ei {

    /**
     * 考试开始时间
     */
    private Date s;

    /**
     * 考试结束时间
     */
    private Date e;

    /**
     * 准考证号
     */
    private String tk;

    /**
     * 状态
     */
    private Exam.ExamStatus status;

    public Date getS() {
        return s;
    }

    public void setS(Date s) {
        this.s = s;
    }

    public Date getE() {
        return e;
    }

    public void setE(Date e) {
        this.e = e;
    }

    public String getTk() {
        return tk;
    }

    public void setTk(String tk) {
        this.tk = tk;
    }

    public Exam.ExamStatus getStatus() {
        return status;
    }

    public void setStatus(Exam.ExamStatus status) {
        this.status = status;
    }
}
