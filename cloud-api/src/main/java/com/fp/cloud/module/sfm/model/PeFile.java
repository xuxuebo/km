package com.fp.cloud.module.sfm.model;


import com.fp.cloud.base.model.BaseModel;

import javax.persistence.*;

/**
 * file domain
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年9月12日10:53:01
 */
@Entity
@Table(name = "t_pe_file", indexes = {@Index(name = "i_pes_file_corpCode", columnList = "corpCode")})
public class PeFile extends BaseModel {

    /**
     * 文件常量
     */
    public static final String IMAGE_NAME = "o";
    public static final String _fileName = "fileName";
    public static final String _fsType = "fsType";
    public static final String _templateType = "templateType";
    public static final String _processorType = "processorType";
    public static final String _referId = "referId";
    public static final String _fileSize = "fileSize";
    public static final String _suffix = "suffix";

    public enum FsType {
        COMMON("公用功能", "common"), TEMPLATE("上传下载模板", "template"), VIDEOTAPE("监控", "videotape"), PHOTOGRAPH("学生答卷拍照", "photograph");

        private String description;

        private String text;

        private FsType(String description, String text) {
            this.text = text;
            this.description = description;
        }

        public String getText() {
            return text;
        }

        public String getDescription() {
            return description;
        }
    }

    public enum ProcessorType {
        VIDEO("视频", "video"), AUDIO("音频", "audio"), IMAGE("图片", "image"), PRINT_IMAGE("截屏", "image"), FILE("文件", "file");

        private String description;

        private String text;

        private ProcessorType(String description, String text) {
            this.text = text;
            this.description = description;
        }

        public String getText() {
            return text;
        }

        public String getDescription() {
            return description;
        }
    }

    public enum TemplateType {
        USER("用户模板", "user"), ITEM("试题模板", "item"), EXAM("考试模板", "exam");

        private String description;

        private String text;

        private TemplateType(String description, String text) {
            this.text = text;
            this.description = description;
        }

        public String getText() {
            return text;
        }

        public String getDescription() {
            return description;
        }
    }


    /**
     * 功能类型
     */
    @Column(nullable = false, length = 20)
    @Enumerated(EnumType.STRING)
    private FsType fsType;

    /**
     * 模板类型
     */
    @Column(nullable = false, length = 20)
    @Enumerated(EnumType.STRING)
    private TemplateType templateType;

    /**
     * 文件类型
     */
    @Column(nullable = false, length = 20)
    @Enumerated(EnumType.STRING)
    private ProcessorType processorType;

    /**
     * 文件名称
     */
    @Column(length = 50)
    private String fileName;

    /**
     * 文件大小
     */
    @Column
    private Long fileSize;

    /**
     * 文件后缀名
     */
    @Column(length = 20)
    private String suffix;

    /**
     * 关联ID
     */
    @Column(length = 32)
    private String referId;

    /**
     * 文件路径
     */
    @Transient
    private String filePath;
    @Transient
    private String examId;
    @Transient
    private String arrangeId;


    public FsType getFsType() {
        return fsType;
    }

    public void setFsType(FsType fsType) {
        this.fsType = fsType;
    }

    public TemplateType getTemplateType() {
        return templateType;
    }

    public void setTemplateType(TemplateType templateType) {
        this.templateType = templateType;
    }

    public ProcessorType getProcessorType() {
        return processorType;
    }

    public String getExamId() {
        return examId;
    }

    public void setExamId(String examId) {
        this.examId = examId;
    }

    public String getArrangeId() {
        return arrangeId;
    }

    public void setArrangeId(String arrangeId) {
        this.arrangeId = arrangeId;
    }

    public void setProcessorType(ProcessorType processorType) {
        this.processorType = processorType;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Long getFileSize() {
        return fileSize;
    }

    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }

    public String getSuffix() {
        return suffix;
    }

    public void setSuffix(String suffix) {
        this.suffix = suffix;
    }

    public String getReferId() {
        return referId;
    }

    public void setReferId(String referId) {
        this.referId = referId;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
}
