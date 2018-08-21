package com.qgutech.km.module.km.model;

import com.qgutech.km.base.model.BaseModel;

import javax.persistence.*;

/**
 * 积分规则实体
 *
 * @author TangFD@HF
 * @since 2018-8-21
 */

@Entity
@Table(name = "t_km_score_detail", indexes = {@Index(name = "i_km_score_detail_corpCode", columnList = "corpCode")})
public class ScoreDetail extends BaseModel {
    public static String OPT_USER_ID = "optUserId";
    public static String USER_ID = "userId";
    public static String RULE_ID = "ruleId";
    public static String KNOWLEDGE_ID = "knowledgeId";
    public static String SCORE = "score";

    /**
     * 获取积分的人员Id
     */
    @Column(nullable = false, length = 32)
    private String userId;

    /**
     * 规则Id
     */
    @Column(nullable = false, length = 32)
    private String ruleId;

    /**
     * 操作的知识Id
     */
    @Column(nullable = false, length = 32)
    private String knowledgeId;

    /**
     * 操作人员Id
     */
    @Column(nullable = false, length = 32)
    private String optUserId;

    /**
     * 积分值
     */
    @Column
    private int score;

    @Transient
    private String codeAndName;
    @Transient
    private String loginName;
    @Transient
    private String employeeCode;
    @Transient
    private String userName;
    @Transient
    private String organizeName;
    @Transient
    private String ruleName;
    @Transient
    private String knowledgeName;
    @Transient
    private String createTimeStr;

    public String getKnowledgeId() {
        return knowledgeId;
    }

    public void setKnowledgeId(String knowledgeId) {
        this.knowledgeId = knowledgeId;
    }

    public String getRuleId() {
        return ruleId;
    }

    public void setRuleId(String ruleId) {
        this.ruleId = ruleId;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getOptUserId() {
        return optUserId;
    }

    public void setOptUserId(String optUserId) {
        this.optUserId = optUserId;
    }

    public String getCodeAndName() {
        return codeAndName;
    }

    public void setCodeAndName(String codeAndName) {
        this.codeAndName = codeAndName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setEmployeeCode(String employeeCode) {
        this.employeeCode = employeeCode;
    }

    public String getEmployeeCode() {
        return employeeCode;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserName() {
        return userName;
    }

    public void setOrganizeName(String organizeName) {
        this.organizeName = organizeName;
    }

    public String getOrganizeName() {
        return organizeName;
    }

    public void setRuleName(String ruleName) {
        this.ruleName = ruleName;
    }

    public String getRuleName() {
        return ruleName;
    }

    public void setKnowledgeName(String knowledgeName) {
        this.knowledgeName = knowledgeName;
    }

    public String getKnowledgeName() {
        return knowledgeName;
    }

    public void setCreateTimeStr(String createTimeStr) {
        this.createTimeStr = createTimeStr;
    }

    public String getCreateTimeStr() {
        return createTimeStr;
    }
}
