package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.module.ems.vo.Jua;
import com.qgutech.pe.module.uc.model.User;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Map;

/**
 * 评卷记录表
 *
 * @author LiYanCheng@HF
 * @since 2016年12月2日09:54:16
 */
@Entity
@Table(name = "t_ems_judge_user_record", indexes = {
        @Index(name = "i_ems_judge_user_record_examId", columnList = "exam_id"),
        @Index(name = "i_ems_judge_user_record_referId", columnList = "referId"),
        @Index(name = "i_ems_judge_user_record_userId", columnList = "user_id"),
        @Index(name = "i_ems_judge_user_record_makeUserId", columnList = "make_user_id"),
        @Index(name = "i_ems_judge_user_record_resultDetailId", columnList = "result_detail_id")
})
public class JudgeUserRecord extends BaseModel {

    public static final String _markUser = "markUser.id";
    public static final String _markUserName = "markUser.userName";
    public static final String _user = "user.id";
    public static final String _exam = "exam.id";
    public static final String _judgeType = "judgeType";
    public static final String _referId = "referId";
    public static final String _score = "score";
    public static final String _season = "season";
    public static final String _approvalType = "approvalType";
    public static final String _markDetail = "markDetail";
    public static final String _examResultDetail = "examResultDetail.id";


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
     * 审批类型
     */
    public enum ApprovalType {
        MARK("评卷"), REVIEW("复评");
        private String text;

        ApprovalType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 评卷人
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "make_user_id", nullable = false)
    private User markUser;

    /**
     * 最后一次考试ID
     */
    @JoinColumn(name = "result_detail_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private ExamResultDetail examResultDetail;

    /**
     * 学员
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    /**
     * 考试
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "exam_id", nullable = false)
    private Exam exam;

    /**
     * 评卷类型
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private JudgeType judgeType;

    /**
     * 类型ID
     */
    @Column(length = 32, nullable = false)
    private String referId;

    /**
     * 评卷分数
     */
    @Column
    private Double score;

    /**
     * 理由
     */
    @Column(length = 50)
    private String season;

    /**
     * 审批类型
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private ApprovalType approvalType;

    @Type(type = "com.qgutech.pe.utils.CompressType", parameters = {
            @org.hibernate.annotations.Parameter(name = "clazzName",
                    value = "com.qgutech.pe.module.ems.vo.Jua")})
    @Column(name = "mark_detail")
    private Jua markDetail;

    @Transient
    private Map<String, Double> markScoreMap;

    public User getMarkUser() {
        return markUser;
    }

    public void setMarkUser(User markUser) {
        this.markUser = markUser;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public JudgeType getJudgeType() {
        return judgeType;
    }

    public void setJudgeType(JudgeType judgeType) {
        this.judgeType = judgeType;
    }

    public String getReferId() {
        return referId;
    }

    public void setReferId(String referId) {
        this.referId = referId;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public String getSeason() {
        return season;
    }

    public void setSeason(String season) {
        this.season = season;
    }

    public Exam getExam() {
        return exam;
    }

    public void setExam(Exam exam) {
        this.exam = exam;
    }

    public ApprovalType getApprovalType() {
        return approvalType;
    }

    public void setApprovalType(ApprovalType approvalType) {
        this.approvalType = approvalType;
    }

    public Map<String, Double> getMarkScoreMap() {
        return markScoreMap;
    }

    public void setMarkScoreMap(Map<String, Double> markScoreMap) {
        this.markScoreMap = markScoreMap;
    }

    public Jua getMarkDetail() {
        return markDetail;
    }

    public void setMarkDetail(Jua markDetail) {
        this.markDetail = markDetail;
    }

    public ExamResultDetail getExamResultDetail() {
        return examResultDetail;
    }

    public void setExamResultDetail(ExamResultDetail examResultDetail) {
        this.examResultDetail = examResultDetail;
    }
}
