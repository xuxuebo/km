package com.fp.cloud.module.ems.model;

import com.fp.cloud.base.model.BaseModel;
import com.fp.cloud.module.uc.model.Organize;

import javax.persistence.*;

/**
 * 考试人员关联实体
 *
 * @author Created by zhangyang on 2016/11/14.
 */
@Entity
@Table(name = "t_ems_exam_user", indexes = {
        @Index(name = "i_ems_exam_user_examId", columnList = "exam_id"),
        @Index(name = "i_ems_exam_user_examArrangeId", columnList = "exam_arrange_id"),
        @Index(name = "i_ems_exam_user_corpCode", columnList = "corpCode")
})
public class ExamUser extends BaseModel {
    public static final String _exam = "exam.id";
    public static final String _examArrange = "examArrange.id";
    public static final String _referType = "referType";
    public static final String _referId = "referId";
    public static final String _showOrder = "showOrder";
    public static final String _examAlias = "exam";
    public static final String _ticket = "ticket";

    /**
     * 考试
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "exam_id", nullable = false)
    private Exam exam;

    /**
     * 考试安排
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "exam_arrange_id")
    private ExamArrange examArrange;

    /**
     * 关联的类型
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private ExamUserType referType;

    /**
     * 关联的类型的Id
     */
    @Column(length = 50, nullable = false)
    private String referId;

    /**
     * 试题排序
     */
    @Column(nullable = false)
    private double showOrder;

    /**
     * 准考号
     */
    @Column(length = 20)
    private String ticket;

    @Transient
    private Organize organize;

    @Transient
    private String loginName;
    @Transient
    private String userName;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public double getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(double showOrder) {
        this.showOrder = showOrder;
    }

    public Exam getExam() {
        return exam;
    }

    public void setExam(Exam exam) {
        this.exam = exam;
    }

    public ExamArrange getExamArrange() {
        return examArrange;
    }

    public void setExamArrange(ExamArrange examArrange) {
        this.examArrange = examArrange;
    }

    public ExamUserType getReferType() {
        return referType;
    }

    public void setReferType(ExamUserType referType) {
        this.referType = referType;
    }

    public String getReferId() {
        return referId;
    }

    public void setReferId(String referId) {
        this.referId = referId;
    }

    public Organize getOrganize() {
        return organize;
    }

    public void setOrganize(Organize organize) {
        this.organize = organize;
    }

    public String getTicket() {
        return ticket;
    }

    public void setTicket(String ticket) {
        this.ticket = ticket;
    }

    /**
     * 考试人员关联类型
     */
    public enum ExamUserType {
        USER("用户"), ORGANIZE("组织"), POSITION("岗位");

        private String text;

        ExamUserType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }
}
