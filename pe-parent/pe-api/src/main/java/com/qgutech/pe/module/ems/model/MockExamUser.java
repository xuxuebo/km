package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.module.uc.model.Organize;

import javax.persistence.*;

/**
 * 模拟考试关联实体类
 *
 * @author xiaolong
 * @since wangxiaolong
 */
@Entity
@Table(name = "t_ems_mock_exam_user", indexes = {
        @Index(name = "i_ems_exam_user_examId", columnList = "mock_exam_id"),
        @Index(name = "i_ems_exam_user_corpCode", columnList = "corpCode")
})
public class MockExamUser extends BaseModel {
    public static final String _exam = "exam.id";
    public static final String _referType = "referType";
    public static final String _referId = "referId";
    public static final String _showOrder = "showOrder";
    public static final String _examAlias = "mockExam";

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

    /**
     * 考试
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "mock_exam_id", nullable = false)
    private MockExam exam;

    public MockExam getExam() {
        return exam;
    }

    public void setExam(MockExam exam) {
        this.exam = exam;
    }

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

    @Transient
    private Organize organize;


    public ExamUserType getReferType() {
        return referType;
    }

    public void setReferType(ExamUserType referType) {
        this.referType = referType;
    }

    public double getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(double showOrder) {
        this.showOrder = showOrder;
    }

    public Organize getOrganize() {
        return organize;
    }

    public void setOrganize(Organize organize) {
        this.organize = organize;
    }

    public String getReferId() {
        return referId;
    }


    public void setReferId(String referId) {
        this.referId = referId;
    }
}
