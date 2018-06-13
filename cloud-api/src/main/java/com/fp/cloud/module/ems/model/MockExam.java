package com.fp.cloud.module.ems.model;


import com.fp.cloud.base.model.BaseModel;
import com.fp.cloud.base.vo.ResultReport;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * 模拟考试实体类
 *
 * @author xialong
 * @since 2017-03-08 15:11:34
 */
@Entity
@Table(name = "t_ems_mock_exam", indexes = {
        @Index(name = "i_ems_exam_templateId", columnList = "template_id"),
        @Index(name = "i_ems_exam_examCode", columnList = "mockCode"),
        @Index(name = "i_ems_exam_createBy", columnList = "createBy"),
        @Index(name = "i_ems_exam_corpCode", columnList = "corpCode")
}
)
public class MockExam extends BaseModel {
    public static final String _examName = "examName";
    public static final String _mockCode = "mockCode";
    public static final String _publishTime = "publishTime";
    public static final String _status = "status";
    public static final String _paperTemplate = "paperTemplate.id";
    public static final String _paperTemplateName = "paperTemplate.paperName";
    public static final String _paperTemplateType = "paperTemplate.paperType";
    public static final String _endTime = "endTime";
    public static final String _referId = "referId";
    public static final String _referName = "referName";
    public static final String _setting = "examSetting.id";
    public static final String _showOrder = "showOrder";
    public static final String _examResultAlias = "examResults";
    public static final String _examAuthAlias = "examAuths";
    public static final String _examSettingAlias = "examSetting";

    public enum ExamStatus {
        ENABLE("启用"),
        DISABLE("停用");
        private String text;

        ExamStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum OptType {
        DELETE("删除"), UPDATE("修改"), ADD("新增"), VIEW("预览");
        private String text;

        OptType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    @Column(length = 100, nullable = false)
    private String examName;

    /**
     * 考试编号
     */
    @Column(length = 50, nullable = false)
    private String mockCode;


    /**
     * 考试的状态
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private ExamStatus status;

    /**
     * 关联的试卷模板
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "template_id")
    private PaperTemplate paperTemplate;


    @OneToMany(fetch = FetchType.LAZY, mappedBy = "mockExam", cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    public List<Paper> papers;

    /**
     * 模拟考试发布时间即开始时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(updatable = false)
    private Date publishTime;

    /**
     * 模拟考试结束时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "end_time")
    private Date endTime;


    ////////
    @Transient
    private List<ExamStatus> examStatus;
    @Transient
    private MockExamResult result;
    @Transient
    private Double totalScore;
    @Transient
    private Double passScore;
    @Transient
    private String isTransient;//是否是第一次保存，t,是，f,不是
    @Transient
    private String userName;

    @Transient
    private MockExamSetting examSetting;

    /**
     * 查询关键字
     */
    @Transient
    private String examKey;

    /**
     * 搜索创建人
     */
    @Transient
    private String createUser;


    @Transient

    private String startTimeStr;

    @Transient
    private List<MockExamUser> users;

    /**
     * 知识点id
     */
    @Transient
    private List<String> knowledgeIds;

    public List<String> getKnowledgeIds() {
        return knowledgeIds;
    }

    public void setKnowledgeIds(List<String> knowledgeIds) {
        this.knowledgeIds = knowledgeIds;
    }

    public List<Knowledge> getKnowledges() {
        return knowledges;
    }

    public void setKnowledges(List<Knowledge> knowledges) {
        this.knowledges = knowledges;
    }

    public ResultReport getResultReport() {
        return resultReport;
    }

    public void setResultReport(ResultReport resultReport) {
        this.resultReport = resultReport;
    }

    /**
     * 知识点集合
     */
    @Transient
    private List<Knowledge> knowledges;

    @Transient
    private ResultReport resultReport;


    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
    public Double getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(Double totalScore) {
        this.totalScore = totalScore;
    }

    public Double getPassScore() {
        return passScore;
    }

    public void setPassScore(Double passScore) {
        this.passScore = passScore;
    }

    public MockExamResult getResult() {
        return result;
    }

    public void setResult(MockExamResult result) {
        this.result = result;
    }

    public List<ExamStatus> getExamStatus() {
        return examStatus;
    }

    public void setExamStatus(List<ExamStatus> examStatus) {
        this.examStatus = examStatus;
    }

    public String getIsTransient() {
        return isTransient;
    }

    public void setIsTransient(String isTransient) {
        this.isTransient = isTransient;
    }


    public List<MockExamUser> getUsers() {
        return users;
    }

    public void setUsers(List<MockExamUser> users) {
        this.users = users;
    }

    public String getEndTimeStr() {
        return endTimeStr;
    }

    public void setEndTimeStr(String endTimeStr) {
        this.endTimeStr = endTimeStr;
    }

    public String getStartTimeStr() {
        return startTimeStr;
    }

    public void setStartTimeStr(String startTimeStr) {
        this.startTimeStr = startTimeStr;
    }

    @Transient
    private String endTimeStr;

    public static String get_mockCode() {
        return _mockCode;
    }

    public String getExamKey() {
        return examKey;
    }

    public void setExamKey(String examKey) {
        this.examKey = examKey;
    }

    public String getCreateUser() {
        return createUser;
    }

    public void setCreateUser(String createUser) {
        this.createUser = createUser;
    }

    public MockExamSetting getExamSetting() {
        return examSetting;
    }

    public void setExamSetting(MockExamSetting examSetting) {
        this.examSetting = examSetting;
    }

    public String getExamName() {
        return examName;
    }

    public void setExamName(String examName) {
        this.examName = examName;
    }

    public static String get_examName() {
        return _examName;
    }

    public String getMockCode() {
        return mockCode;
    }

    public void setMockCode(String mockCode) {
        this.mockCode = mockCode;
    }


    public ExamStatus getStatus() {
        return status;
    }

    public void setStatus(ExamStatus status) {
        this.status = status;
    }

    public PaperTemplate getPaperTemplate() {
        return paperTemplate;
    }

    public void setPaperTemplate(PaperTemplate paperTemplate) {
        this.paperTemplate = paperTemplate;
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }


}
