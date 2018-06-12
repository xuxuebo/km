package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.module.uc.model.User;

import javax.persistence.*;

/**
 * 考试权限实体对象
 *
 * @author Created by zhangyang on 2016/11/15.
 */
@Entity
@Table(name = "t_ems_exam_auth", indexes = {
        @Index(name = "i_ems_exam_auth_examId", columnList = "exam_id"),
        @Index(name = "i_ems_exam_auth_userId", columnList = "user_id"),
        @Index(name = "i_ems_exam_auth_arrangeId", columnList = "arrange_id"),
        @Index(name = "i_ems_exam_auth_createBy", columnList = "createBy"),
        @Index(name = "i_ems_exam_auth_corpCode", columnList = "corpCode")
})
public class ExamAuth extends BaseModel {
    public static final String _exam = "exam.id";
    public static final String _examAlias = "exam";
    public static final String _user = "user.id";
    public static final String _userName = "user.userName";
    public static final String _userLoginName = "user.loginName";
    public static final String _userCreateTime = "user.createTime";
    public static final String _userAlias = "user";
    public static final String _examArrange = "examArrange.id";
    public static final String _referType = "referType";

    /**
     * 指定类型
     */
    public enum ReferType {
        MONITOR_USER("监考员"), EXAM_USER("考试管理员");
        private final String text;

        ReferType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 考试对象
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "exam_id", nullable = false)
    private Exam exam;


    public static String get_exam() {
        return _exam;
    }

    /**
     * 考场对象
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "arrange_id", nullable = true)

    private ExamArrange examArrange;

    /**
     * 管理员
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;



    /**
     * 关联类型
     */
    @Column(length = 20,nullable = true)
    @Enumerated(EnumType.STRING)
    private ReferType referType;

    /**
     * 排序
     */
    @Column
    private Float showOrder;

    /**
     * 试卷模板创建人
     */
    @Transient
    private Boolean createExam;

    public Float getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(Float showOrder) {
        this.showOrder = showOrder;
    }

    public Exam getExam() {
        return exam;
    }

    public void setExam(Exam exam) {
        this.exam = exam;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Boolean getCreateExam() {
        return createExam;
    }

    public void setCreateExam(Boolean createExam) {
        this.createExam = createExam;
    }

    public ReferType getReferType() {
        return referType;
    }

    public void setReferType(ReferType referType) {
        this.referType = referType;
    }

    public ExamArrange getExamArrange() {
        return examArrange;
    }

    public void setExamArrange(ExamArrange examArrange) {
        this.examArrange = examArrange;
    }
}
