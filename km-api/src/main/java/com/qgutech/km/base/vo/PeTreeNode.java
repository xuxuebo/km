package com.qgutech.km.base.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * 用于树形结构的节点实体类
 *
 * @author Created by zhangyang on 2016/10/13.
 */
public class PeTreeNode {
    /**
     * 节点保存的关联主键Id
     */
    private String id;

    /**
     * 父节点ID
     */
    private String pId;

    /**
     * 节点需要显示或者存储的文本信息
     */
    private String name;

    /**
     * 是否可以编辑
     */
    private boolean canEdit = true;
    private String type = "ORG";

    /**
     * 是否在其他批次已经选中了
     *
     * @return
     */
    public boolean ishasSelected() {
        return ishasSelected;
    }

    public void setIshasSelected(boolean ishasSelected) {
        this.ishasSelected = ishasSelected;
    }

    private boolean ishasSelected;

    /**
     * 是否是父节点
     */
    private Boolean isParent;

    /**
     * 角色管理中的复选框是否被选中
     */
    private Boolean checked;

    /**
     * 角色管理中的复选框是否被选中
     */
    private Boolean selected;

    /**
     * 类别树展开
     */
    private Boolean open;


    /**
     * 节点数据
     */
    private List<PeTreeNode> nodeData;

    public Boolean getOpen() {
        return open;
    }

    public void setOpen(Boolean open) {
        this.open = open;
    }

    public Boolean getChecked() {
        return checked;
    }

    public void setChecked(Boolean checked) {
        this.checked = checked;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getpId() {
        return pId;
    }

    public void setpId(String pId) {
        this.pId = pId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getParent() {
        return isParent;
    }

    public void setParent(Boolean parent) {
        isParent = parent;
    }

    public Boolean getSelected() {
        return selected;
    }

    public void setSelected(Boolean selected) {
        this.selected = selected;
    }

    public List<PeTreeNode> getNodeData() {
        return nodeData;
    }

    public void setNodeData(List<PeTreeNode> nodeData) {
        this.nodeData = nodeData;
    }

    public boolean isCanEdit() {
        return canEdit;
    }

    public void setCanEdit(boolean canEdit) {
        this.canEdit = canEdit;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }
}
