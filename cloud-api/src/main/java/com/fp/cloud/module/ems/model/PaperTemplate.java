package com.fp.cloud.module.ems.model;

import com.fp.cloud.base.model.BaseModel;
import com.fp.cloud.base.model.Category;
import com.fp.cloud.module.uc.model.User;
import com.fp.cloud.module.ems.vo.Sr;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * @author Created by zhangyang on 2016/10/19.
 */
@Entity
@Table(name = "t_ems_paper_template", indexes = {
        @Index(name = "i_ems_paper_template_corpCode", columnList = "corpCode"),
        @Index(name = "i_ems_paper_template_createBy", columnList = "createBy")},
        uniqueConstraints = {
                @UniqueConstraint(name = "u_ems_paper_template_paperCode", columnNames = {"corpCode", "paperCode"})
        })
public class PaperTemplate extends BaseModel {
    public static final String _paperCode = "paperCode";
    public static final String _paperName = "paperName";
    public static final String _paperType = "paperType";
    public static final String _paperStatus = "paperStatus";
    public static final String _security = "security";
    public static final String _category = "category.id";
    public static final String _categoryName = "category.categoryName";
    public static final String _categoryAlias = "category";
    public static final String _sr = "sr";
    public static final String _templatesAuthAlias = "templatesAuths";

    public enum PaperType {
        FIXED("固定"), RANDOM("随机");
        private final String text;

        PaperType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum PaperStatus {
        ENABLE("启用"), DISABLE("停用"), DRAFT("草稿"), DELETE("删除");
        private final String text;

        PaperStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 试卷编号
     */
    @Column(length = 50, nullable = false)
    private String paperCode;

    /**
     * 试卷名称
     */
    @Column(length = 50, nullable = false)
    private String paperName;

    /**
     * 试卷类型
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private PaperType paperType;

    /**
     * 试卷状态
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private PaperStatus paperStatus;

    /**
     * 是否绝密
     */
    @Column
    private Boolean security;

    /**
     * 类别
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private Category category;

    /**
     * 组卷策略
     */
    @Type(type = "com.fp.cloud.utils.JsonType", parameters = {
            @org.hibernate.annotations.Parameter(name = "clazzName",
                    value = "Sr")})
    @Column(name = "strategy", length = 500)
    private Sr sr;

    /**
     * 模板权限关联
     */
    @OneToMany(mappedBy = "paperTemplate", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    private List<PaperTemplateAuth> templatesAuths;

    /***************************************************
     * 非持久化字段                     *
     ***************************************************/

    /**
     * 必考题集合
     */
    @Transient
    private List<Item> items;

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

    /**
     * 能否被管理
     */
    @Transient
    private boolean canEdit;

    /**
     * 用户信息
     */
    @Transient
    private User user;

    @Transient
    private String createDate;

    @Transient
    private String queryStatus;

    @Transient
    private String srJson;

    /**
     * 试题总数
     */
    @Transient
    private Long itemCount;

    /**
     * 试卷编辑
     */
    @Transient
    private boolean templateEdit;

    @Transient
    private Boolean continueEnable;

    //查询试卷类型
    @Transient
    private String queryType;

    //绝密情况
    @Transient
    private String querySecurity;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<PaperTemplateAuth> getTemplatesAuths() {
        return templatesAuths;
    }

    public void setTemplatesAuths(List<PaperTemplateAuth> templatesAuths) {
        this.templatesAuths = templatesAuths;
    }

    public boolean isCanEdit() {
        return canEdit;
    }

    public void setCanEdit(boolean canEdit) {
        this.canEdit = canEdit;
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

    public String getPaperCode() {
        return paperCode;
    }

    public void setPaperCode(String paperCode) {
        this.paperCode = paperCode;
    }

    public String getPaperName() {
        return paperName;
    }

    public void setPaperName(String paperName) {
        this.paperName = paperName;
    }

    public PaperType getPaperType() {
        return paperType;
    }

    public void setPaperType(PaperType paperType) {
        this.paperType = paperType;
    }

    public PaperStatus getPaperStatus() {
        return paperStatus;
    }

    public void setPaperStatus(PaperStatus paperStatus) {
        this.paperStatus = paperStatus;
    }

    public Boolean getSecurity() {
        return security;
    }

    public void setSecurity(Boolean security) {
        this.security = security;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Sr getSr() {
        return sr;
    }

    public void setSr(Sr sr) {
        this.sr = sr;
    }

    public List<Item> getItems() {
        return items;
    }

    public void setItems(List<Item> items) {
        this.items = items;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getQueryStatus() {
        return queryStatus;
    }

    public void setQueryStatus(String queryStatus) {
        this.queryStatus = queryStatus;
    }

    public String getSrJson() {
        return srJson;
    }

    public void setSrJson(String srJson) {
        this.srJson = srJson;
    }

    public Long getItemCount() {
        return itemCount;
    }

    public void setItemCount(Long itemCount) {
        this.itemCount = itemCount;
    }

    public boolean isTemplateEdit() {
        return templateEdit;
    }

    public void setTemplateEdit(boolean templateEdit) {
        this.templateEdit = templateEdit;
    }

    public Boolean getContinueEnable() {
        return continueEnable;
    }

    public void setContinueEnable(Boolean continueEnable) {
        this.continueEnable = continueEnable;
    }

    public String getQueryType() {
        return queryType;
    }

    public void setQueryType(String queryType) {
        this.queryType = queryType;
    }

    public String getQuerySecurity() {
        return querySecurity;
    }

    public void setQuerySecurity(String querySecurity) {
        this.querySecurity = querySecurity;
    }
}
