package com.qgutech.km.module.km.model;

import com.qgutech.km.base.model.BaseModel;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

/**
 * 积分规则实体
 *
 * @author TangFD@HF
 * @since 2018-8-21
 */

@Entity
@Table(name = "t_km_score_rule", indexes = {@Index(name = "i_km_score_rule_corpCode", columnList = "corpCode")})
public class ScoreRule extends BaseModel {
    public static String CODE = "code";
    public static String NAME = "name";
    public static String SCORE = "score";

    /**
     * 规则编号
     */
    @Column(nullable = false, length = 100)
    private String code;

    /**
     * 规则名称
     */
    @Column(nullable = false, length = 200)
    private String name;

    /**
     * 积分值
     */
    @Column
    private int score;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
