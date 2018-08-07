package com.qgutech.km.module.km.model;

import com.qgutech.km.base.model.BaseModel;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * 智慧云文件实体
 *
 * @author zhaowei
 * @since 2018年06月22日
 */

@Entity
@Table(name = "t_km_knowledge", indexes = {@Index(name = "i_km_knowledge_corpCode", columnList = "corpCode")})
public class Knowledge extends BaseModel {

    public static String FILE_ID = "fileId";
    public static String KNOWLEDGE_NAME = "knowledgeName";

    public static String SHOW_ORDER = "showOrder";

    public static String FOLDER = "folder";

    /**
     * 文件名称
     */
    @Column(nullable = false, length = 100)
    private String knowledgeName;

    /**
     * 文件路径
     */
    @Column(nullable = false, length = 200)
    private String fileId;

    /**
     * 文件大小
     */
    @Column
    private long knowledgeSize;

    /**
     * 文件类型
     */
    @Column(nullable = false, length = 20)
    private String knowledgeType;

    /**
     * 来源文件主键
     */
    @Column(length = 32)
    private String sourceKnowledgeId;

    /**
     * 文件夹主键
     */
    @Column(length = 32)
    private String folder;

    /**
     * 排序
     */
    @Column
    private float showOrder;
    /**
     * 创建时间字符串
     */
    @Transient
    private String createTimeStr;
    /**
     * 浏览次数
     */
    @Transient
    private Integer viewCount;
    /**
     * 下载次数
     */
    @Transient
    private Integer downloadCount;
    /**
     * 复制次数
     */
    @Transient
    private Integer copyCount;
    /**
     * 文件分享有效期
     */
    @Transient
    private String expireTime;
    @Transient
    private String shareId;
    @Transient
    private String tag;
    @Transient
    private String libraryId;
    @Transient
    private Date startDate;
    @Transient
    private Date endDate;
    @Transient
    private String projectLibraryId;
    @Transient
    private String specialtyLibraryId;
    @Transient
    private String referId;
    @Transient
    private String referType;
    @Transient
    private boolean includeChild = true;
    @Transient
    private List<String> userIds;
    @Transient
    private List<String> knowledgeIds;
    @Transient
    private List<String> libraryIds;
    @Transient
    private String userName;

    public boolean isIncludeChild() {
        return includeChild;
    }

    public void setIncludeChild(boolean includeChild) {
        this.includeChild = includeChild;
    }

    public String getProjectLibraryId() {
        return projectLibraryId;
    }

    public void setProjectLibraryId(String projectLibraryId) {
        this.projectLibraryId = projectLibraryId;
    }

    public String getReferId() {
        return referId;
    }

    public void setReferId(String referId) {
        this.referId = referId;
    }

    public String getReferType() {
        return referType;
    }

    public void setReferType(String referType) {
        this.referType = referType;
    }

    public String getSpecialtyLibraryId() {
        return specialtyLibraryId;
    }

    public void setSpecialtyLibraryId(String specialtyLibraryId) {
        this.specialtyLibraryId = specialtyLibraryId;
    }

    public String getKnowledgeName() {
        return knowledgeName;
    }

    public void setKnowledgeName(String knowledgeName) {
        this.knowledgeName = knowledgeName;
    }

    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

    public long getKnowledgeSize() {
        return knowledgeSize;
    }

    public void setKnowledgeSize(long knowledgeSize) {
        this.knowledgeSize = knowledgeSize;
    }

    public String getKnowledgeType() {
        return knowledgeType;
    }

    public void setKnowledgeType(String knowledgeType) {
        this.knowledgeType = knowledgeType;
    }

    public String getSourceKnowledgeId() {
        return sourceKnowledgeId;
    }

    public void setSourceKnowledgeId(String sourceKnowledgeId) {
        this.sourceKnowledgeId = sourceKnowledgeId;
    }

    public String getFolder() {
        return folder;
    }

    public void setFolder(String folder) {
        this.folder = folder;
    }

    public float getShowOrder() {
        return showOrder;
    }

    public void setShowOrder(float showOrder) {
        this.showOrder = showOrder;
    }

    public Knowledge() {
    }

    public Knowledge(String knowledgeName, String fileId, long knowledgeSize, String knowledgeType, String sourceKnowledgeId, String folder, float showOrder) {
        this.knowledgeName = knowledgeName;
        this.fileId = fileId;
        this.knowledgeSize = knowledgeSize;
        this.knowledgeType = knowledgeType;
        this.sourceKnowledgeId = sourceKnowledgeId;
        this.folder = folder;
        this.showOrder = showOrder;
    }

    public String getCreateTimeStr() {
        return createTimeStr;
    }

    public void setCreateTimeStr(String createTimeStr) {
        this.createTimeStr = createTimeStr;
    }

    public Integer getViewCount() {
        return viewCount;
    }

    public void setViewCount(Integer viewCount) {
        this.viewCount = viewCount;
    }

    public Integer getDownloadCount() {
        return downloadCount;
    }

    public void setDownloadCount(Integer downloadCount) {
        this.downloadCount = downloadCount;
    }

    public Integer getCopyCount() {
        return copyCount;
    }

    public void setCopyCount(Integer copyCount) {
        this.copyCount = copyCount;
    }

    public String getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(String expireTime) {
        this.expireTime = expireTime;
    }

    public String getShareId() {
        return shareId;
    }

    public void setShareId(String shareId) {
        this.shareId = shareId;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getLibraryId() {
        return libraryId;
    }

    public void setLibraryId(String libraryId) {
        this.libraryId = libraryId;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public void setUserIds(List<String> userIds) {
        this.userIds = userIds;
    }

    public List<String> getUserIds() {
        return userIds;
    }

    public void setKnowledgeIds(List<String> knowledgeIds) {
        this.knowledgeIds = knowledgeIds;
    }

    public List<String> getKnowledgeIds() {
        return knowledgeIds;
    }

    public void setLibraryIds(List<String> libraryIds) {
        this.libraryIds = libraryIds;
    }

    public List<String> getLibraryIds() {
        return libraryIds;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserName() {
        return userName;
    }
}
