package com.fp.cloud.module.ems.model;

import com.fp.cloud.base.model.BaseModel;
import com.fp.cloud.module.uc.model.User;

import javax.persistence.*;

/**
 * 考试评卷异常信息表
 * Created by limengfan on 2017/7/27.
 */

@Entity
@Table(name = "t_ems_exam_temporary", indexes = {
        @Index(name = "i_ems_exam_temporary_exam_id", columnList = "exam_id"),
        @Index(name = "i_ems_exam_temporary_user_id", columnList = "user_id"),
        @Index(name = "i_ems_exam_temporary_arrange_id", columnList = "arrange_id"),
        @Index(name = "i_ems_exam_temporary_corp_code", columnList = "corpCode")
})
public class ExamTemporary extends BaseModel {

    public static final String _exam = "exam.id";
    public static final String _user = "user.id";
    public static final String _examData = "examData";
    public static final String _examArrange = "examArrange.id";

    /**
     * 学员
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column
    private String examData;

    /**
     * 安排ID
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "arrange_id")
    private ExamArrange examArrange;


    /**
     * 考试ID
     */
    @JoinColumn(name = "exam_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private Exam exam;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getExamData() {
        return examData;
    }

    public void setExamData(String examData) {
        this.examData = examData;
    }

    public ExamArrange getExamArrange() {
        return examArrange;
    }

    public void setExamArrange(ExamArrange examArrange) {
        this.examArrange = examArrange;
    }

    public Exam getExam() {
        return exam;
    }

    public void setExam(Exam exam) {
        this.exam = exam;
    }
}
