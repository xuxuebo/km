package com.fp.cloud.module.ems.model;

import com.fp.cloud.base.model.BaseModel;
import com.fp.cloud.module.ems.vo.Prc;
import com.fp.cloud.module.ems.vo.Sr;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.List;

/**
 * 试卷实体类
 *
 * @author Created by zhangyang on 2016/10/19.
 */
@Entity
@Table(name = "t_ems_paper", indexes = {
        @Index(name = "i_ems_paper_template_corpCode", columnList = "corpCode"),
        @Index(name = "i_ems_paper_template_createBy", columnList = "createBy")
})
public class Paper extends BaseModel {
    public static final String _template = "paperTemplate.id";
    public static final String _templateAlias = "paperTemplate";
    public static final String _templateSecurity = "paperTemplate.security";
    public static final String _templateCreateBy = "paperTemplate.createBy";
    public static final String _templateName = "paperTemplate.paperName";
    public static final String _templateType = "paperTemplate.paperType";
    public static final String _itemCount = "itemCount";
    public static final String _mark = "mark";
    public static final String _level = "level";
    public static final String _exam = "exam.id";
    public static final String _examStatus = "exam.status";
    public static final String _examName = "exam.examName";
    public static final String _paperContent = "paperContent";
    public static final String _mockExam = "mockExam.id";
    public static final String _mockExamName = "mockExam.examName";
    public static final String _sr = "sr";

    /**
     * 模板信息
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "paperTemplate_id")
    private PaperTemplate paperTemplate;

    /**
     * 考试信息
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "exam_id")
    private Exam exam;


    /**
     * 模拟考试信息
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "mock_exam_id")

    private MockExam mockExam;

    /**
     * 试卷总题数
     */
    @Column
    private int itemCount;

    /**
     * 试卷分值
     */
    @Column
    private double mark;

    /**
     * 综合难度
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private Item.ItemLevel level;

    /**
     * 试卷内容的JSONB
     */
    @Type(type = "com.fp.cloud.utils.CompressType", parameters = {
            @org.hibernate.annotations.Parameter(name = "clazzName",
                    value = "Prc")})
    @Column(name = "paper_content", nullable = false)
    private Prc paperContent;

    /**
     * 组卷策略
     */
    @Type(type = "com.fp.cloud.utils.JsonType", parameters = {
            @org.hibernate.annotations.Parameter(name = "clazzName",
                    value = "Sr")})
    @Column(name = "paper_strategy", length = 500)
    private Sr sr;

    /***************************************************
     * 非持久化字段                     *
     ***************************************************/

    /**
     * 能否被管理
     */
    @Transient
    private boolean canEdit;

    @Transient
    private ExamSetting examSetting;

    @Transient
    private MockExamSetting mockExamSetting;

    /**
     * 生成试卷套数
     */
    @Transient
    private Integer makeCount;

    @Transient
    private Integer showOrder;

    public MockExam getMockExam() {
        return mockExam;
    }

    public void setMockExam(MockExam mockExam) {
        this.mockExam = mockExam;
    }

    @Transient
    private boolean audio;

    @Transient
    private boolean video;

    @Transient
    private List<String> itemIds;

    public int getItemCount() {
        return itemCount;
    }

    public void setItemCount(int itemCount) {
        this.itemCount = itemCount;
    }

    public double getMark() {
        return mark;
    }

    public void setMark(double mark) {
        this.mark = mark;
    }

    public Item.ItemLevel getLevel() {
        return level;
    }

    public void setLevel(Item.ItemLevel level) {
        this.level = level;
    }

    public PaperTemplate getPaperTemplate() {
        return paperTemplate;
    }

    public void setPaperTemplate(PaperTemplate paperTemplate) {
        this.paperTemplate = paperTemplate;
    }

    public Exam getExam() {
        return exam;
    }

    public void setExam(Exam exam) {
        this.exam = exam;
    }

    public Prc getPaperContent() {
        return paperContent;
    }

    public void setPaperContent(Prc paperContent) {
        this.paperContent = paperContent;
    }

    public boolean isCanEdit() {
        return canEdit;
    }

    public void setCanEdit(boolean canEdit) {
        this.canEdit = canEdit;
    }

    public ExamSetting getExamSetting() {
        return examSetting;
    }

    public void setExamSetting(ExamSetting examSetting) {
        this.examSetting = examSetting;
    }

    public Integer getMakeCount() {
        return makeCount;
    }

    public void setMakeCount(Integer makeCount) {
        this.makeCount = makeCount;
    }

    public boolean isAudio() {
        return audio;
    }

    public void setAudio(boolean audio) {
        this.audio = audio;
    }

    public boolean isVideo() {
        return video;
    }

    public void setVideo(boolean video) {
        this.video = video;
    }

    public Sr getSr() {
        return sr;
    }

    public void setSr(Sr sr) {
        this.sr = sr;
    }

    public List<String> getItemIds() {
        return itemIds;
    }

    public void setItemIds(List<String> itemIds) {
        this.itemIds = itemIds;
    }

    public MockExamSetting getMockExamSetting() {
        return mockExamSetting;
    }

    public void setMockExamSetting(MockExamSetting mockExamSetting) {
        this.mockExamSetting = mockExamSetting;
    }

    public Integer getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(Integer showOrder) {
        this.showOrder = showOrder;
    }
}
