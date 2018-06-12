package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;
import org.hibernate.annotations.Table;

import javax.persistence.*;

/**
 * 模拟考试设置
 *
 * @author xiaol  2017年3月20日10:36:58
 */
@Entity
@javax.persistence.Table(name = "t_ems_mock_exam_setting", indexes = {
        @Index(name = "i_ems_mock_exam_setting_examId", columnList = "mock_exam_id"),
        @Index(name = "i_ems_mock_exam_setting_createBy", columnList = "createBy")
},
        uniqueConstraints = {
                @UniqueConstraint(name = "u_ems_exam_examId", columnNames = {"corpCode", "mock_exam_id"})
        })
public class MockExamSetting extends BaseModel {
    public static final String _mockExam = "exam.id";
    public static final String _usableRange = "usableRange";
    public static final String _scoreSetting = "scoreSetting";
    public static final String _answerlimit = "answerlimit";
    public static final String _examLength = "examLength";
    public static final String _passRate = "passRate";

    //模拟考试限制使用范围
    public enum UsableRange {
        ALL("公开可用"),
        LIMIT("指定考生可用");
        private String text;

        public String getText() {
            return text;
        }

        UsableRange(String text) {
            this.text = text;
        }
    }

    //分数设置
    public enum ScoreSetting {
        FULLMARK("满分100"),
        ORIGINAL("试卷原分数");
        private String text;

        public String getText() {
            return text;
        }

        ScoreSetting(String text) {
            this.text = text;
        }
    }

    /**
     * 考试信息对象
     */
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "mock_exam_id", nullable = false)
    private MockExam exam;

    /**
     * 使用范围设置
     */
    @Column(length = 20)
    @Enumerated(EnumType.STRING)
    private UsableRange usableRange;


    /**
     * 模拟试卷分数设置
     */
    @Column(length = 20)
    @Enumerated(EnumType.STRING)
    private ScoreSetting scoreSetting;


    /**
     * 答案是否可见设置
     */
    @Column(nullable = false)
    private boolean answerlimit;

    /**
     * 考试时长
     */
    @Column
    private Integer examLength;

    @Column(nullable = false)
    private Integer passRate;

    public Integer getPassRate() {
        return passRate;
    }

    public void setPassRate(Integer passRate) {
        this.passRate = passRate;
    }

    public boolean isAnswerlimit() {

        return answerlimit;
    }

    public void setAnswerlimit(boolean answerlimit) {
        this.answerlimit = answerlimit;
    }

    public MockExam getExam() {
        return exam;
    }

    public void setExam(MockExam exam) {
        this.exam = exam;
    }

    public UsableRange getUsableRange() {
        return usableRange;
    }

    public void setUsableRange(UsableRange usableRange) {
        this.usableRange = usableRange;
    }

    public ScoreSetting getScoreSetting() {
        return scoreSetting;
    }

    public void setScoreSetting(ScoreSetting scoreSetting) {
        this.scoreSetting = scoreSetting;
    }

    public Integer getExamLength() {
        return examLength;
    }

    public void setExamLength(Integer examLength) {
        this.examLength = examLength;
    }


}
