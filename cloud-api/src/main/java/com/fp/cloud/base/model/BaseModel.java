package com.fp.cloud.base.model;

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
    public static final String _id = "id";
    public static final String _corpCode = "corpCode";
    public static final String _createBy = "createBy";
    public static final String _updateBy = "updateBy";
    public static final String _createTime = "createTime";
    public static final String _updateTime = "updateTime";
    public static final String _point = ".";

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

    public enum FromType {
        MOBILE("手机端"), PC("PC端");
        private String text;

        FromType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

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

    /**
     * 操作类型
     */
    @Transient
    private OptType optType;

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

    public OptType getOptType() {
        return optType;
    }

    public void setOptType(OptType optType) {
        this.optType = optType;
    }
}