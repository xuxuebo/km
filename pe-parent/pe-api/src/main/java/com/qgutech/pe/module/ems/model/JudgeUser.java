package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.module.uc.model.User;

import javax.persistence.*;

/**
 * 评卷人员关联实体对象，包含试卷与评卷人关联和试题与评卷人关联及其权重信息
 *
 * @author Created by zhangyang on 2016/11/15.
 */
@Entity
@Table(name = "t_ems_judge_user", indexes = {
        @Index(name = "i_ems_judge_user_examId", columnList = "exam_id"),
        @Index(name = "i_ems_judge_user_itemId", columnList = "referId"),
        @Index(name = "i_ems_judge_user_userId", columnList = "user_id")
})
public class JudgeUser extends BaseModel {
    public static final String _exam = "exam.id";
    public static final String _referType = "referType";
    public static final String _referId = "referId";
    public static final String _user = "user.id";
    public static final String _userName = "user.userName";
    public static final String _userLoginName = "user.loginName";
    public static final String _userCreateTime = "user.createTime";
    public static final String _rate = "rate";
    public static final String _showOrder = "showOrder";

    /**
     * 评卷关联类型
     */
    public enum JudgeType {
        PAPER("试卷"), ITEM("试题");
        private String text;

        JudgeType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 试卷
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "exam_id", nullable = false)
    private Exam exam;

    /**
     * 关联类型
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private JudgeType referType;

    /**
     * 关联Id
     */
    @Column(length = 32, nullable = false)
    private String referId;

    /**
     * 评卷人
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    /**
     * 权重比
     */
    @Column
    private Double rate;

    /**
     * 排序
     */
    @Column
    private Float showOrder;

    @Transient
    private Item item;

    @Transient
    private String judgeUserIds;

    @Transient
    private String markPercent;

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

    public JudgeType getReferType() {
        return referType;
    }

    public void setReferType(JudgeType referType) {
        this.referType = referType;
    }

    public String getReferId() {
        return referId;
    }

    public void setReferId(String referId) {
        this.referId = referId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Double getRate() {
        return rate;
    }

    public void setRate(Double rate) {
        this.rate = rate;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public String getJudgeUserIds() {
        return judgeUserIds;
    }

    public void setJudgeUserIds(String judgeUserIds) {
        this.judgeUserIds = judgeUserIds;
    }

    public String getMarkPercent() {
        return markPercent;
    }

    public void setMarkPercent(String markPercent) {
        this.markPercent = markPercent;
    }
}

