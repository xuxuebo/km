package com.qgutech.pe.module.exercise.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.module.ems.model.Item;
import com.qgutech.pe.module.ems.model.ItemBank;
import com.qgutech.pe.module.ems.model.Knowledge;
import com.qgutech.pe.module.ems.vo.Prc;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * 习题的实体类
 *
 * @author LiYanCheng
 * @since 2017年3月8日17:24:49
 */
@Entity
@Table(name = "t_ems_exercise", indexes = {
        @Index(name = "i_exe_exercise_corpCode", columnList = "corpCode"),
        @Index(name = "i_exe_exercise_createBy", columnList = "createBy")},
        uniqueConstraints = {@UniqueConstraint(name = "i_exe_exercise_exerciseCode", columnNames = {"exerciseCode"})
        })

public class Exercise extends BaseModel {
    public final static String _itemCount = "itemCount";
    public final static String _exerciseCode = "exerciseCode";
    public final static String _exerciseName = "exerciseName";
    public final static String _endTime = "endTime";
    public final static String _status = "status";
    public final static String _applicationScope = "applicationScope";
    public final static String _seeAnswer = "seeAnswer";
    public final static String _exerciseUserAlias = "exerciseUsers";

    public enum ExerciseStatus {
        ENABLE("启用"),
        DISABLE("停用"),
        PROCESS("开始中"),//数据库中不存此状态
        OVER("已结束");
        private final String text;

        ExerciseStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum ApplicationScope {
        ALL("全部可用"), PORTION("部分可用");
        private final String text;

        ApplicationScope(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    @Column(length = 50, nullable = false)
    private String exerciseCode;

    @Column(length = 50, nullable = false)
    private String exerciseName;

    /**
     * 练习的状态
     */

    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private ExerciseStatus status;

    /**
     * 练习使用范围
     */

    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private ApplicationScope applicationScope;

    /**
     * 练习总题数
     */
    @Column
    private int itemCount;

    /**
     * 练习的结束时间
     */

    @Temporal(TemporalType.TIMESTAMP)
    @Column
    private Date endTime;

    @Column(nullable = false)
    private boolean seeAnswer;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "exercise", cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    private List<ExerciseUser> exerciseUsers;

    /**
     *非持久化
     */

    /**
     * 查询的关键字
     */
    @Transient
    private String exerciseKey;

    /**
     * 查询 创建人
     */
    @Transient
    private String createUser;
    /**
     * 查询 练习的状态
     */

    @Transient
    private List<ExerciseStatus> exerciseStatus;

    /**
     * 练习创建时为FALSE判断是否是创建练习
     */
    @Transient
    private String transientCreate;
    /*
    * 练习包含试题的类型
    * */
    @Transient
    private List<Item.ItemType> itemTypes;

    /**
     * 练习包含题库
     */
    @Transient
    private List<ItemBank> itemBanks;

    /**
     * 练习包含知识点
     */
    @Transient
    private List<Knowledge> knowledges;
    /*
    *练习的真正内容
    */

    @Transient
    private Prc exerciseContent;

    /**
     * 知识点集合
     */
    @Transient
    private List<String> knowledgeIds;

    /**
     * 练习的总分
     */

    @Transient
    private Double mark;

    @Transient
    private List<Integer> sns;
    /**
     * 正确率
     */

    @Transient
    private Double accuracy;

    /*
    *完成率
     */
    @Transient
    private Double completionRate;

    @Transient
    private Boolean hasSubmit;
    public Boolean getHasSubmit() {
        return hasSubmit;
    }

    public void setHasSubmit(Boolean hasSubmit) {
        this.hasSubmit = hasSubmit;
    }

    public List<Integer> getSns() {
        return sns;
    }

    public void setSns(List<Integer> sns) {
        this.sns = sns;
    }

    public Double getMark() {
        return mark;
    }

    public void setMark(Double mark) {
        this.mark = mark;
    }

    public Prc getExerciseContent() {
        return exerciseContent;
    }

    public void setExerciseContent(Prc exerciseContent) {
        this.exerciseContent = exerciseContent;
    }

    public List<Item.ItemType> getItemTypes() {
        return itemTypes;
    }

    public void setItemTypes(List<Item.ItemType> itemTypes) {
        this.itemTypes = itemTypes;
    }

    public List<Knowledge> getKnowledges() {
        return knowledges;
    }

    public void setKnowledges(List<Knowledge> knowledges) {
        this.knowledges = knowledges;
    }

    public List<ItemBank> getItemBanks() {
        return itemBanks;
    }

    public void setItemBanks(List<ItemBank> itemBanks) {
        this.itemBanks = itemBanks;
    }

    public int getItemCount() {
        return itemCount;
    }

    public void setItemCount(int itemCount) {
        this.itemCount = itemCount;
    }

    public String getTransientCreate() {
        return transientCreate;
    }

    public void setTransientCreate(String transientCreate) {
        this.transientCreate = transientCreate;
    }

    public String getExerciseCode() {
        return exerciseCode;
    }

    public void setExerciseCode(String exerciseCode) {
        this.exerciseCode = exerciseCode;
    }

    public String getExerciseName() {
        return exerciseName;
    }

    public void setExerciseName(String exerciseName) {
        this.exerciseName = exerciseName;
    }

    public ExerciseStatus getStatus() {
        return status;
    }

    public void setStatus(ExerciseStatus status) {
        this.status = status;
    }

    public ApplicationScope getApplicationScope() {
        return applicationScope;
    }

    public void setApplicationScope(ApplicationScope applicationScope) {
        this.applicationScope = applicationScope;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public boolean isSeeAnswer() {
        return seeAnswer;
    }

    public void setSeeAnswer(boolean seeAnswer) {
        this.seeAnswer = seeAnswer;
    }

    public List<ExerciseUser> getExerciseUsers() {
        return exerciseUsers;
    }

    public void setExerciseUsers(List<ExerciseUser> exerciseUsers) {
        this.exerciseUsers = exerciseUsers;
    }


    public String getCreateUser() {
        return createUser;
    }

    public void setCreateUser(String createUser) {
        this.createUser = createUser;
    }

    public String getExerciseKey() {
        return exerciseKey;
    }

    public void setExerciseKey(String exerciseKey) {
        this.exerciseKey = exerciseKey;
    }

    public List<ExerciseStatus> getExerciseStatus() {
        return exerciseStatus;
    }

    public List<String> getKnowledgeIds() {
        return knowledgeIds;
    }

    public void setKnowledgeIds(List<String> knowledgeIds) {
        this.knowledgeIds = knowledgeIds;
    }

    public void setExerciseStatus(List<ExerciseStatus> exerciseStatus) {
        this.exerciseStatus = exerciseStatus;
    }

    public Double getCompletionRate() {
        return completionRate;
    }

    public void setCompletionRate(Double completionRate) {
        this.completionRate = completionRate;
    }

    public Double getAccuracy() {
        return accuracy;
    }

    public void setAccuracy(Double accuracy) {
        this.accuracy = accuracy;
    }
}
