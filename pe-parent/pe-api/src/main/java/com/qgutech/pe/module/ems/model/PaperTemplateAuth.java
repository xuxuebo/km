package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.module.uc.model.User;

import javax.persistence.*;

/**
 * 试卷模板权限表
 */
@Entity
@Table(name = "t_ems_paper_template_auth", indexes = {
        @Index(name = "t_ems_paper_template_auth_corpCode", columnList = "corpCode"),
        @Index(name = "t_ems_paper_template_auth_userId", columnList = "user_id"),
        @Index(name = "t_ems_paper_template_auth_templateId", columnList = "template_id")
})
public class PaperTemplateAuth extends BaseModel {

    public static final String _paperTemplate = "paperTemplate.id";
    public static final String _user = "user.id";
    public static final String _userName = "user.userName";
    public static final String _userLoginName = "user.loginName";
    public static final String _userCreateTime = "user.createTime";
    //配置别名
    public static final String _templateAlisa = "paperTemplate";

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "template_id", nullable = false)
    private PaperTemplate paperTemplate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    /**
     * 试卷模板创建人
     */
    @Transient
    private Boolean createTemplate;

    /**
     * 是否选中显示
     */
    @Transient
    private Boolean selected;

    /**
     * 是否可以删除
     */
    @Transient
    private boolean canDelete = true;

    public PaperTemplate getPaperTemplate() {
        return paperTemplate;
    }

    public void setPaperTemplate(PaperTemplate paperTemplate) {
        this.paperTemplate = paperTemplate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Boolean getCreateTemplate() {
        return createTemplate;
    }

    public void setCreateTemplate(Boolean createTemplate) {
        this.createTemplate = createTemplate;
    }

    public Boolean getSelected() {
        return selected;
    }

    public void setSelected(Boolean selected) {
        this.selected = selected;
    }

    public boolean isCanDelete() {
        return canDelete;
    }

    public void setCanDelete(boolean canDelete) {
        this.canDelete = canDelete;
    }
}
