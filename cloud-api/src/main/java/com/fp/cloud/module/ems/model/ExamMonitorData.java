package com.fp.cloud.module.ems.model;

import com.fp.cloud.base.model.BaseModel;
import com.fp.cloud.module.uc.model.User;

import javax.persistence.*;
import java.util.Date;

/**
 * 考试批次监控数据实体类
 *
 * @author Create by wangxl 2017年7月17日08:51:06
 */
@Entity
@Table(name = "t_ems_exam_monitor_data", indexes = {
        @Index(name = "i_ems_exam_monitor_data_arrangeId", columnList = "arrange_id"),
        @Index(name = "i_ems_exam_monitor_data_fileId", columnList = "fileId"),
        @Index(name = "i_ems_exam_monitor_data_examId", columnList = "exam_id"),
        @Index(name = "i_ems_exam_monitor_data_proctorUserId", columnList = "proctor_user_id")})

public class ExamMonitorData extends BaseModel {
    public static final String _examArrange = "examArrange.id";
    public static final String _exam = "exam.id";
    public static final String _proctorUser = "proctorUser.id";
    public static final String _fileId = "fileId";
    public static final String _dataType = "dataType";
    public static final String _message = "message";
    public static final String _comment = "comment";
    public static final String _startTime = "startTime";
    public static final String _duration = "duration";
    public static final String _coverId = "coverId";

    public enum DataType {
        VIDEO("监控视频"), PRINTIMAGE("截屏"), MESSAGE("消息"), RECORD_COVER("录像封面");
        private String text;

        DataType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 所属批次
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "arrange_id")
    private ExamArrange examArrange;

    /**
     * 所属考试
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "exam_id")
    private Exam exam;

    /**
     * 文件ID
     */
    @Column(length = 32)
    private String fileId;

    /**
     * 监考员
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "proctor_user_id")
    private User proctorUser;

    /**
     * 消息
     */
    @Column(length = 500)
    private String message;

    /**
     * 截屏备注
     */
    @Column(length = 500)
    private String comment;

    /**
     * 类型
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private DataType dataType;

    /**
     * 视频开始时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column
    private Date startTime;

    /**
     * 视频录像时间 秒
     */
    @Column
    private Long duration;

    /**
     * 封面ID
     */
    @Column(length = 32)
    private String coverId;

    /**
     * 文件路径
     */
    @Transient
    private String filePath;

    /**
     * 封面路径
     */
    @Transient
    private String coverPath;

    /**
     * 文件名称
     */
    @Transient
    private String fileName;

    /**
     * 创建人信息
     */
    @Transient
    private User createUser;

    public DataType getDataType() {
        return dataType;
    }

    public void setDataType(DataType dataType) {
        this.dataType = dataType;
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

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

    public User getProctorUser() {
        return proctorUser;
    }

    public void setProctorUser(User proctorUser) {
        this.proctorUser = proctorUser;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Long getDuration() {
        return duration;
    }

    public void setDuration(Long duration) {
        this.duration = duration;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getCoverId() {
        return coverId;
    }

    public void setCoverId(String coverId) {
        this.coverId = coverId;
    }

    public String getCoverPath() {
        return coverPath;
    }

    public void setCoverPath(String coverPath) {
        this.coverPath = coverPath;
    }

    public User getCreateUser() {
        return createUser;
    }

    public void setCreateUser(User createUser) {
        this.createUser = createUser;
    }
}
