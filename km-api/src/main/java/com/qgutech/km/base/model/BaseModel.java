package com.qgutech.km.base.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * 所有实体类的父类,包含所有实体的公共属性
 *
 * @author TaoFaDeng@HF
 * @since 2016年07月05日15:46:16
 */
@MappedSuperclass
public class BaseModel {
    public static final String ID = "id";
    public static final String CORP_CODE = "corpCode";
    public static final String CREATE_BY = "createBy";
    public static final String UPDATE_BY = "updateBy";
    public static final String CREATE_TIME = "createTime";
    public static final String UPDATE_TIME = "updateTime";
    public static final String POINT = ".";

    /**
     * 主键
     */
    @Id
    @Column(nullable = false, length = 32)
    @GeneratedValue(generator = "hibernate-uuid")
    @GenericGenerator(name = "hibernate-uuid", strategy = "uuid")
    private String id;

    /**
     * 业务编号
     */
    @Column(length = 50, nullable = false)
    private String corpCode;

    /**
     * 创建人
     */
    @Column(length = 32, nullable = false, updatable = false)
    private String createBy;

    /**
     * 最后更新人
     */
    @Column(length = 32, nullable = false)
    private String updateBy;

    /**
     * 创建时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false, updatable = false)
    private Date createTime;

    /**
     * 最后更新时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false)
    private Date updateTime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCorpCode() {
        return corpCode;
    }

    public void setCorpCode(String corpCode) {
        this.corpCode = corpCode;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}