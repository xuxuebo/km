package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.module.exercise.model.Exercise;
import com.qgutech.pe.module.exercise.model.ExerciseItem;
import com.qgutech.pe.module.uc.model.User;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 试题实体
 *
 * @since 2016年09月14日10:16:39
 */
@Entity
@Table(name = "t_ems_item", indexes = {
        @Index(name = "i_ems_item_blankId", columnList = "bank_id"),
        @Index(name = "i_ems_item_detailId", columnList = "detail_id"),
        @Index(name = "i_ems_item_itemCode", columnList = "itemCode"),
        @Index(name = "i_ems_item_createBy", columnList = "createBy")},
        uniqueConstraints = {
                @UniqueConstraint(name = "u_ems_item_itemCode", columnNames = {"corpCode", "itemCode"})
        })
public class Item extends BaseModel {
    public static final String _itemBank = "itemBank.id";
    public static final String _itemBankAlias = "itemBank";
    public static final String _itemBankName = "itemBank.bankName";
    public static final String _itemCode = "itemCode";
    public static final String _mark = "mark";
    public static final String _type = "type";
    public static final String _level = "level";
    public static final String _status = "status";
    public static final String _expireDate = "expireDate";
    public static final String _languageType = "languageType";
    public static final String _security = "security";
    public static final String _scoreSettingType = "scoreSettingType";
    public static final String _scoreRate = "scoreRate";
    public static final String _itemDetail = "itemDetail.id";
    public static final String _itemDetailIcs = "itemDetail.ics";
    public static final String _stemOutline = "stemOutline";
    public static final String _knowledgeItemAlias = "knowledgeItems";
    public static final String _itemAlias = "item";
    public static final String _icAlias = "ic";
    public static final String _paperTemplateItemAlisa = "paperTemplateItems";
    public static final String _userExamRecordAlisa = "userExamRecords";
    public static final String _attributeType = "attributeType";
    public static final String _exerciseItemAlisa = "exerciseItems";

    /**
     * 试题类型
     */
    public enum ItemType {
        SINGLE_SELECTION("单选题"), MULTI_SELECTION("多选题"), INDEFINITE_SELECTION("不定项选择"),
        JUDGMENT("判断题"), FILL("填空题"), QUESTIONS("问答题");
        private final String text;

        ItemType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }


    /**
     * 试题难度
     */
    public enum ItemLevel {
        SIMPLE("简单"), RELATIVELY_SIMPLE("较简单"), MEDIUM("中等"), MORE_DIFFICULT("较难"), DIFFICULT("困难");
        private final String text;

        ItemLevel(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 试题的属性
     */
    public enum AttributeType {
        EXAM("考试"), EXERCISE("练习"), EXAMEXERCISE("考试和练习");
        private final String text;

        AttributeType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 试题状态
     */
    public enum ItemStatus {
        DRAFT("草稿"), ENABLE("启用"), DISABLE("停用"), DELETE("彻底删除");

        private final String text;

        ItemStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 语言属性的类型
     */
    public enum LanguageType {
        CHINESE("中文"), ENGLISH("英文"), TRADITIONAL_CHINESE("繁体中文"), JAPANESE("日文"), KOREAN("韩语");
        private final String text;

        LanguageType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 考试设置
     */
    public enum ScoreSettingType {
        ALL("全部分值"), PART("部分分值");
        private final String text;

        ScoreSettingType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 所属题库
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bank_id", nullable = false)
    private ItemBank itemBank;

    /**
     * 试题编号
     */
    @Column(length = 50, nullable = false)
    private String itemCode;

    /**
     * 试题分数
     */
    @Column(nullable = false)
    private Double mark;

    /**
     * 试题类型
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private ItemType type;

    /**
     * 试题难度
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private ItemLevel level;

    /**
     * 试题状态
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private ItemStatus status;
    /**
     * 试题属性
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private AttributeType attributeType;
    /**
     * 自动过期日期
     */
    @Temporal(TemporalType.DATE)
    @Column(nullable = false)
    private Date expireDate;

    /**
     * 语言属性
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private LanguageType languageType;

    /**
     * 是否是绝密试题
     */
    @Column(nullable = false)
    private Boolean security = false;

    /**
     * 得分设置,用于多选题选中部分选项的得分
     */
    @Column(length = 20)
    private ScoreSettingType scoreSettingType;

    /**
     * 如果选择得分设置中的选中部分,需要设置得分率
     */
    @Column
    private Double scoreRate = 0.5;

    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "detail_id", nullable = false, unique = true)
    private ItemDetail itemDetail;

    /**
     * 取题干前五十字
     */
    @Column(nullable = false, length = 50)
    private String stemOutline;

    /**
     * 知识点题库关联关系
     */
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "item")
    @Fetch(FetchMode.SUBSELECT)
    private List<KnowledgeItem> knowledgeItems;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "item")
    @Fetch(FetchMode.SUBSELECT)
    private List<PaperTemplateItem> paperTemplateItems;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "item")
    @Fetch(FetchMode.SUBSELECT)
    private List<ExerciseItem> exerciseItems;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "item")
    @Fetch(FetchMode.SUBSELECT)
    private List<UserExamRecord> userExamRecords;
    /***************************************************
     *                  非持久化字段                     *
     ***************************************************/

    /**
     * 用户对象
     */
    @Transient
    private User user;

    /**
     * 关键字查询,可能是试题内容,试题编号或者是出题人姓名
     */
    @Transient
    private String keyword;

    /**
     * 是否可以被编辑权限
     */
    @Transient
    private boolean canEdit;

    /**
     * 查询状态条件
     */
    @Transient
    private String queryStatus;

    /**
     * 查询条件试题类型
     */
    @Transient
    private String queryType;

    /**
     * 题库名称
     */
    @Transient
    private String bankName;

    /**
     * 知识点
     */
    @Transient
    private String knowledge;

    /**
     * 查询开始时间
     */
    @Transient
    private Date queryStartTime;

    /**
     * 查询结束时间
     */
    @Transient
    private Date queryEndTime;

    @Transient
    private List<Knowledge> knowledges;

    /**
     * 是否为必考题
     */
    @Transient
    private Boolean must;

    /**
     * 查看全部试题，绝密试题，非绝密试题 ALL,SECURITY,NOT_SECURITY
     */
    @Transient
    private String securityQuery;

    /**
     *学员的答案是否正确
     *
     */
    @Transient
    private boolean correct;

    /**
     *
     */


    /**
     * 评卷人名称
     */
    @Transient
    private String judgeUserName;

    /*
    *练习的试题顺序
    */
    @Transient
    private Integer showOrder;
    /**
     * 练习统计，错误的人次
     */
    @Transient
    private Long wrongCount;

    /**
     * 练习统计，正确的人次
     */
    @Transient
    private Long rightCount;

    /**
     * 练习统计 正确率
     */
    @Transient
    private Double accuracy;


    public String getQueryType() {
        return queryType;
    }

    public void setQueryType(String queryType) {
        this.queryType = queryType;
    }

    public Integer getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(Integer showOrder) {
        this.showOrder = showOrder;
    }

    public String getJudgeUserName() {
        return judgeUserName;
    }

    public void setJudgeUserName(String judgeUserName) {
        this.judgeUserName = judgeUserName;
    }

    public List<PaperTemplateItem> getPaperTemplateItems() {
        return paperTemplateItems;
    }

    public void setPaperTemplateItems(List<PaperTemplateItem> paperTemplateItems) {
        this.paperTemplateItems = paperTemplateItems;
    }

    public Long getRightCount() {
        return rightCount;
    }

    public void setRightCount(Long rightCount) {
        this.rightCount = rightCount;
    }

    public Long getWrongCount() {
        return wrongCount;
    }

    public void setWrongCount(Long wrongCount) {
        this.wrongCount = wrongCount;
    }

    public Double getAccuracy() {
        return accuracy;
    }

    public void setAccuracy(Double accuracy) {
        this.accuracy = accuracy;
    }

    public List<ExerciseItem> getExerciseItems() {
        return exerciseItems;
    }

    public void setExerciseItems(List<ExerciseItem> exerciseItems) {
        this.exerciseItems = exerciseItems;
    }

    public String getSecurityQuery() {
        return securityQuery;
    }

    public void setSecurityQuery(String securityQuery) {
        this.securityQuery = securityQuery;
    }

    public boolean isCorrect() {
        return correct;
    }

    public void setCorrect(boolean correct) {
        this.correct = correct;
    }

    public Date getQueryStartTime() {
        return queryStartTime;
    }

    public void setQueryStartTime(Date queryStartTime) {
        this.queryStartTime = queryStartTime;
    }

    public Date getQueryEndTime() {
        return queryEndTime;
    }

    public void setQueryEndTime(Date queryEndTime) {
        this.queryEndTime = queryEndTime;
    }

    public ItemBank getItemBank() {
        return itemBank;
    }

    public void setItemBank(ItemBank itemBank) {
        this.itemBank = itemBank;
    }

    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    public ItemType getType() {
        return type;
    }

    public void setType(ItemType type) {
        this.type = type;
    }

    public ItemLevel getLevel() {
        return level;
    }

    public void setLevel(ItemLevel level) {
        this.level = level;
    }

    public ItemStatus getStatus() {
        return status;
    }

    public void setStatus(ItemStatus status) {
        this.status = status;
    }

    public Date getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }

    public LanguageType getLanguageType() {
        return languageType;
    }

    public void setLanguageType(LanguageType languageType) {
        this.languageType = languageType;
    }

    public String getKnowledge() {
        return knowledge;
    }

    public void setKnowledge(String knowledge) {
        this.knowledge = knowledge;
    }

    public Boolean getSecurity() {
        return security;
    }

    public void setSecurity(Boolean security) {
        this.security = security;
    }

    public ScoreSettingType getScoreSettingType() {
        return scoreSettingType;
    }

    public void setScoreSettingType(ScoreSettingType scoreSettingType) {
        this.scoreSettingType = scoreSettingType;
    }

    public Double getScoreRate() {
        return scoreRate;
    }

    public void setScoreRate(Double scoreRate) {
        this.scoreRate = scoreRate;
    }

    public void setMark(Double mark) {
        this.mark = mark;
    }

    public Double getMark() {
        return mark;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public boolean isCanEdit() {
        return canEdit;
    }

    public void setCanEdit(boolean canEdit) {
        this.canEdit = canEdit;
    }

    public String getQueryStatus() {
        return queryStatus;
    }

    public void setQueryStatus(String queryStatus) {
        this.queryStatus = queryStatus;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public ItemDetail getItemDetail() {
        return itemDetail;
    }

    public void setItemDetail(ItemDetail itemDetail) {
        this.itemDetail = itemDetail;
    }

    public String getStemOutline() {
        return stemOutline;
    }

    public void setStemOutline(String stemOutline) {
        this.stemOutline = stemOutline;
    }

    public List<KnowledgeItem> getKnowledgeItems() {
        return knowledgeItems;
    }

    public void setKnowledgeItems(List<KnowledgeItem> knowledgeItems) {
        this.knowledgeItems = knowledgeItems;
    }

    public List<Knowledge> getKnowledges() {
        return knowledges;
    }

    public void setKnowledges(List<Knowledge> knowledges) {
        this.knowledges = knowledges;
    }

    public Boolean getMust() {
        return must;
    }

    public void setMust(Boolean must) {
        this.must = must;
    }

    public AttributeType getAttributeType() {
        return attributeType;
    }

    public void setAttributeType(AttributeType attributeType) {
        this.attributeType = attributeType;
    }

    public static List<ItemType> listSubjectiveType() {
        List<ItemType> itemTypes = new ArrayList<ItemType>(2);
        itemTypes.add(ItemType.QUESTIONS);
        itemTypes.add(ItemType.FILL);
        return itemTypes;
    }

    public static List<ItemType> listObjectiveType() {
        List<ItemType> itemTypes = new ArrayList<ItemType>(3);
        itemTypes.add(ItemType.INDEFINITE_SELECTION);
        itemTypes.add(ItemType.SINGLE_SELECTION);
        itemTypes.add(ItemType.MULTI_SELECTION);
        itemTypes.add(ItemType.JUDGMENT);
        return itemTypes;
    }

    public List<UserExamRecord> getUserExamRecords() {
        return userExamRecords;
    }

    public void setUserExamRecords(List<UserExamRecord> userExamRecords) {
        this.userExamRecords = userExamRecords;
    }
}