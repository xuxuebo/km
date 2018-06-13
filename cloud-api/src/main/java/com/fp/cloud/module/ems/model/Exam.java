package com.fp.cloud.module.ems.model;

import com.fp.cloud.base.model.BaseModel;
import com.fp.cloud.base.vo.ResultReport;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * 考试管理的实体
 *
 * @author Created by zhangyang on 2016/10/19.
 */
@Entity
@Table(name = "t_ems_exam", indexes = {
        @Index(name = "i_ems_exam_templateId", columnList = "template_id"),
        @Index(name = "i_ems_exam_examCode", columnList = "examCode"),
        @Index(name = "i_ems_exam_createBy", columnList = "createBy"),
        @Index(name = "i_ems_exam_corpCode", columnList = "corpCode"),
        @Index(name = "i_ems_exam_markUpId", columnList = "markUpId")
},
        uniqueConstraints = {
                @UniqueConstraint(name = "u_ems_exam_examCode", columnNames = {"corpCode", "examCode"})
        })
public class Exam extends BaseModel {
    public static final String _examName = "examName";
    public static final String _examCode = "examCode";
    public static final String _examPlain = "examPlain";
    public static final String _examType = "examType";
    public static final String _publishTime = "publishTime";
    public static final String _status = "status";
    public static final String _paperTemplate = "paperTemplate.id";
    public static final String _paperTemplateName = "paperTemplate.paperName";
    public static final String _paperTemplateType = "paperTemplate.paperType";
    public static final String _examArrangeAlias = "examArranges";
    public static final String _subject = "subject";
    public static final String _startTime = "startTime";
    public static final String _endTime = "endTime";
    public static final String _source = "source";
    public static final String _referId = "referId";
    public static final String _referName = "referName";
    public static final String _markUpId = "markUpId";
    public static final String _setting = "setting";
    public static final String _showOrder = "showOrder";
    public static final String _examResultAlias = "examResults";
    public static final String _judgeUserAlias = "judgeUsers";
    public static final String _examAuthAlias = "examAuths";
    public static final String _judgeUserRecordAlias = "judgeUserRecords";
    public static final String _enableTicket = "enableTicket";

    public enum SelectorUserType {
        EXAM_MANAGER("考试管理员"), JUDGE_PAPER_USER("人工评卷,试卷分配评卷人"), JUDGE_ITEM_USER("人工评卷,按试题分配评卷人"),
        EXAMARRANGE_MANAGE("批次考场监考员"), ARRANGE_USER("考试设置添加考生");
        private String text;

        SelectorUserType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum ExamStatus {
        DRAFT("草稿"),
        NO_START("未开始"),//数据库不记录这种状态
        PROCESS("考试中"),
        CANCEL("已作废"),
        OVER("已结束"),
        ENABLE("启用"),
        MARKING("评卷中"),
        DISABLE("停用");
        private String text;

        ExamStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum Source {
        COPY("复制"),
        EXAM_COPY("启用复制"),
        ADD("新建");
        private String text;

        Source(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum ExamType {
        ONLINE("线上考试"), OFFLINE("线下考试"), COMPREHENSIVE("综合考试");
        private String text;

        ExamType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum CopyField {
        PAPER_SETTING("试卷设置"),
        EXAM_USER("考试人员"),
        EXAM_SETTING("考试设置"),
        EXAM_TIME("考试时间");
        private String text;

        CopyField(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum MSGInfos {
        EMAIL_MSG("邮件"),
        INTERNAL_MSG("站内信"),
        MESSAGE_MSG("手机短信");
        private String text;

        MSGInfos(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 考试名称
     */
    @Column(length = 100, nullable = false)
    private String examName;

    /**
     * 考试编号
     */
    @Column(length = 50, nullable = false)
    private String examCode;

    /**
     * 考试说明
     */
    @Column(length = 1300)
    private String examPlain;

    /**
     * 考试类型
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private ExamType examType;

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

    /**
     * 考试发布时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(updatable = false)
    private Date publishTime;

    /**
     * 考试开始时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "start_time")
    private Date startTime;

    /**
     * 考试结束时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "end_time")
    private Date endTime;


    @OneToMany(fetch = FetchType.LAZY, mappedBy = "exam", cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    public List<ExamArrange> examArranges;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "exam", cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    private List<ExamAuth> examAuths;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "exam", cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    public List<ExamResult> examResults;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "exam", cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    private List<JudgeUser> judgeUsers;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "exam", cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    private List<JudgeUserRecord> judgeUserRecords;

    /**
     * 是否是科目考试
     */
    @Column(nullable = false)
    private boolean subject;

    /**
     * 是否启用准考证
     */
    @Column
    private Boolean enableTicket;

    /**
     * 科目来源
     */
    @Column(length = 20)
    @Enumerated(EnumType.STRING)
    private Source source;

    /**
     * 手动补考考试对应的被补考考试ID
     */
    @Column(length = 32)
    private String markUpId;

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
    private List<ExamStatus> examStatus;

    @Transient
    private List<ExamType> examTypes;

    @Transient
    private String startTimeStr;

    @Transient
    private String endTimeStr;

    /**
     * 关键字筛选是否包含“创建人”
     */
    @Transient
    private Boolean includeCreator;

    /**
     * 复制考试的信息
     */
    @Transient
    private List<CopyField> copyFields;

    public String getMsgInfos() {
        return msgInfos;
    }

    public void setMsgInfos(String msgInfos) {
        this.msgInfos = msgInfos;
    }

    /**
     * 学员提醒信息方式
     */
    @Transient
    private String msgInfos;
    /**
     * 考试设置信息
     */
    @Transient
    private ExamSetting examSetting;

    /**
     * 考试时长 单位：分钟
     */
    @Transient
    private long examTimeLength;

    /**
     * 考试结束时长
     */
    @Transient
    private long endTimeLength;

    /**
     * 考试结果
     */
    @Transient
    private ExamResult examResult;

    /**
     * 多个科目
     */
    @Transient
    private List<Exam> subjects;

    /**
     * 系统时间
     */
    @Transient
    private Date systemDate;

    /**
     * 滚动时间 00:00:00
     */
    @Transient
    private String scrollTime;

    /**
     * 科目排序
     */
    @Transient
    private float showOrder;

    /**
     * 试卷信息
     */
    @Transient
    private Paper paper;

    /**
     * 合格分数
     */
    @Transient
    private Double passMark;

    @Transient
    private String referId;

    @Transient
    private String referName;

    /**
     * 剩余时间
     */
    @Transient
    private long residualTime;

    /**
     * 待发布数量
     */
    @Transient
    private long releaseCount;

    /**
     * 待评试卷数
     */
    @Transient
    private long waitPaperCount;

    /**
     * 已评试卷数
     */
    @Transient
    private long markedPaperCount;

    /**
     * 我评的
     */
    @Transient
    private long myMarkedPaperCount;

    /**
     * 总试卷数
     */
    @Transient
    private long paperCount;

    /**
     * 是否需要补考
     */
    @Transient
    private boolean needMarkUp;

    /**
     * 应考人员
     */
    @Transient
    private long testCount;

    /**
     * 通过人员
     */
    @Transient
    private long passCount;

    /**
     * 未通过人员
     */
    @Transient
    private long noPassCount;

    /**
     * 缺考人员
     */
    @Transient
    private long missCount;

    /**
     * 补考次数
     */
    @Transient
    private long examCount;

    /**
     * 评卷中数量
     */
    @Transient
    private long markingCount;

    /**
     * 安排ID集合
     */
    @Transient
    private List<String> arrangeIds;

    /**
     * 知识点集合
     */
    @Transient
    private List<String> knowledgeIds;

    /**
     * 知识点集合
     */
    @Transient
    private List<Knowledge> knowledges;

    @Transient
    private ResultReport resultReport;

    /**
     * 应参加人数
     */
    @Transient
    private long joinNums;

    /**
     * 限制考试
     */
    @Transient
    private boolean limitExam;

    @Transient
    private long joinedNums;

    /**
     * 手机端使用参数信息
     */
    @Transient
    private String message;

    /**
     * 考试时长
     */
    @Transient
    private long examDuration;

    /**
     * 准考证号
     */
    @Transient
    private String ticket;

    /**
     * 是否可以监控
     */
    @Transient
    private boolean canMonitor;

    /**
     * 是否可以编辑
     */
    @Transient
    private boolean canEdit;

    public boolean isCanEdit() {
        return canEdit;
    }

    public void setCanEdit(boolean canEdit) {
        this.canEdit = canEdit;
    }

    public boolean isCanMonitor() {
        return canMonitor;
    }

    public void setCanMonitor(boolean canMonitor) {
        this.canMonitor = canMonitor;
    }

    public String getExamName() {
        return examName;
    }

    public void setExamName(String examName) {
        this.examName = examName;
    }

    public String getExamCode() {
        return examCode;
    }

    public void setExamCode(String examCode) {
        this.examCode = examCode;
    }

    public String getExamPlain() {
        return examPlain;
    }

    public void setExamPlain(String examPlain) {
        this.examPlain = examPlain;
    }

    public ExamType getExamType() {
        return examType;
    }

    public void setExamType(ExamType examType) {
        this.examType = examType;
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

    public List<ExamStatus> getExamStatus() {
        return examStatus;
    }

    public void setExamStatus(List<ExamStatus> examStatus) {
        this.examStatus = examStatus;
    }

    public List<ExamType> getExamTypes() {
        return examTypes;
    }

    public void setExamTypes(List<ExamType> examTypes) {
        this.examTypes = examTypes;
    }

    public List<ExamArrange> getExamArranges() {
        return examArranges;
    }

    public void setExamArranges(List<ExamArrange> examArranges) {
        this.examArranges = examArranges;
    }

    public List<ExamAuth> getExamAuths() {
        return examAuths;
    }

    public void setExamAuths(List<ExamAuth> examAuths) {
        this.examAuths = examAuths;
    }

    public List<ExamResult> getExamResults() {
        return examResults;
    }

    public void setExamResults(List<ExamResult> examResults) {
        this.examResults = examResults;
    }

    public boolean isSubject() {
        return subject;
    }

    public void setSubject(boolean subject) {
        this.subject = subject;
    }

    public Boolean getIncludeCreator() {
        return includeCreator;
    }

    public void setIncludeCreator(Boolean includeCreator) {
        this.includeCreator = includeCreator;
    }

    public List<CopyField> getCopyFields() {
        return copyFields;
    }

    public void setCopyFields(List<CopyField> copyFields) {
        this.copyFields = copyFields;
    }

    public ExamSetting getExamSetting() {
        return examSetting;
    }

    public void setExamSetting(ExamSetting examSetting) {
        this.examSetting = examSetting;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public String getStartTimeStr() {
        return startTimeStr;
    }

    public void setStartTimeStr(String startTimeStr) {
        this.startTimeStr = startTimeStr;
    }

    public String getEndTimeStr() {
        return endTimeStr;
    }

    public void setEndTimeStr(String endTimeStr) {
        this.endTimeStr = endTimeStr;
    }

    public long getExamTimeLength() {
        return examTimeLength;
    }

    public void setExamTimeLength(long examTimeLength) {
        this.examTimeLength = examTimeLength;
    }

    public ExamResult getExamResult() {
        return examResult;
    }

    public void setExamResult(ExamResult examResult) {
        this.examResult = examResult;
    }

    public Source getSource() {
        return source;
    }

    public void setSource(Source source) {
        this.source = source;
    }

    public String getReferId() {
        return referId;
    }

    public void setReferId(String referId) {
        this.referId = referId;
    }

    public List<Exam> getSubjects() {
        return subjects;
    }

    public void setSubjects(List<Exam> subjects) {
        this.subjects = subjects;
    }

    public Date getSystemDate() {
        return systemDate;
    }

    public void setSystemDate(Date systemDate) {
        this.systemDate = systemDate;
    }

    public String getScrollTime() {
        return scrollTime;
    }

    public void setScrollTime(String scrollTime) {
        this.scrollTime = scrollTime;
    }

    public float getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(float showOrder) {
        this.showOrder = showOrder;
    }

    public Paper getPaper() {
        return paper;
    }

    public void setPaper(Paper paper) {
        this.paper = paper;
    }

    public Double getPassMark() {
        return passMark;
    }

    public void setPassMark(Double passMark) {
        this.passMark = passMark;
    }

    public String getMarkUpId() {
        return markUpId;
    }

    public void setMarkUpId(String markUpId) {
        this.markUpId = markUpId;
    }

    public String getReferName() {
        return referName;
    }

    public void setReferName(String referName) {
        this.referName = referName;
    }

    public long getResidualTime() {
        return residualTime;
    }

    public void setResidualTime(long residualTime) {
        this.residualTime = residualTime;
    }

    public long getReleaseCount() {
        return releaseCount;
    }

    public void setReleaseCount(long releaseCount) {
        this.releaseCount = releaseCount;
    }

    public List<JudgeUser> getJudgeUsers() {
        return judgeUsers;
    }

    public void setJudgeUsers(List<JudgeUser> judgeUsers) {
        this.judgeUsers = judgeUsers;
    }

    public long getWaitPaperCount() {
        return waitPaperCount;
    }

    public void setWaitPaperCount(long waitPaperCount) {
        this.waitPaperCount = waitPaperCount;
    }

    public long getMarkedPaperCount() {
        return markedPaperCount;
    }

    public void setMarkedPaperCount(long markedPaperCount) {
        this.markedPaperCount = markedPaperCount;
    }

    public long getPaperCount() {
        return paperCount;
    }

    public void setPaperCount(long paperCount) {
        this.paperCount = paperCount;
    }

    public long getMyMarkedPaperCount() {
        return myMarkedPaperCount;
    }

    public void setMyMarkedPaperCount(long myMarkedPaperCount) {
        this.myMarkedPaperCount = myMarkedPaperCount;
    }

    public List<JudgeUserRecord> getJudgeUserRecords() {
        return judgeUserRecords;
    }

    public void setJudgeUserRecords(List<JudgeUserRecord> judgeUserRecords) {
        this.judgeUserRecords = judgeUserRecords;
    }

    public boolean isNeedMarkUp() {
        return needMarkUp;
    }

    public void setNeedMarkUp(boolean needMarkUp) {
        this.needMarkUp = needMarkUp;
    }

    public long getExamCount() {
        return examCount;
    }

    public void setExamCount(long examCount) {
        this.examCount = examCount;
    }

    public long getMissCount() {
        return missCount;
    }

    public void setMissCount(long missCount) {
        this.missCount = missCount;
    }

    public long getNoPassCount() {
        return noPassCount;
    }

    public void setNoPassCount(long noPassCount) {
        this.noPassCount = noPassCount;
    }

    public long getPassCount() {
        return passCount;
    }

    public void setPassCount(long passCount) {
        this.passCount = passCount;
    }

    public long getTestCount() {
        return testCount;
    }

    public void setTestCount(long testCount) {
        this.testCount = testCount;
    }

    public long getMarkingCount() {
        return markingCount;
    }

    public void setMarkingCount(long markingCount) {
        this.markingCount = markingCount;
    }

    public List<String> getArrangeIds() {
        return arrangeIds;
    }

    public void setArrangeIds(List<String> arrangeIds) {
        this.arrangeIds = arrangeIds;
    }

    public List<String> getKnowledgeIds() {
        return knowledgeIds;
    }

    public void setKnowledgeIds(List<String> knowledgeIds) {
        this.knowledgeIds = knowledgeIds;
    }

    public long getEndTimeLength() {
        return endTimeLength;
    }

    public void setEndTimeLength(long endTimeLength) {
        this.endTimeLength = endTimeLength;
    }

    public ResultReport getResultReport() {
        return resultReport;
    }

    public void setResultReport(ResultReport resultReport) {
        this.resultReport = resultReport;
    }

    public List<Knowledge> getKnowledges() {
        return knowledges;
    }

    public void setKnowledges(List<Knowledge> knowledges) {
        this.knowledges = knowledges;
    }

    public boolean isLimitExam() {
        return limitExam;
    }

    public void setLimitExam(boolean limitExam) {
        this.limitExam = limitExam;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public long getExamDuration() {
        return examDuration;
    }

    public void setExamDuration(long examDuration) {
        this.examDuration = examDuration;
    }

    public long getJoinNums() {
        return joinNums;
    }

    public void setJoinNums(long joinNums) {
        this.joinNums = joinNums;
    }

    public long getJoinedNums() {
        return joinedNums;
    }

    public void setJoinedNums(long joinedNums) {
        this.joinedNums = joinedNums;
    }

    public Boolean getEnableTicket() {
        return enableTicket;
    }

    public void setEnableTicket(Boolean enableTicket) {
        this.enableTicket = enableTicket;
    }

    public String getTicket() {
        return ticket;
    }

    public void setTicket(String ticket) {
        this.ticket = ticket;
    }
}
