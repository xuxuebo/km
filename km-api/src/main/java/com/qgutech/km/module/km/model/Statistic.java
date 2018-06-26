package com.qgutech.km.module.km.model;

import com.qgutech.km.base.model.BaseModel;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

/**
 * Created by Administrator on 2018/6/22.
 */
@Entity
@Table(name = "t_km_statistic", indexes = {@Index(name = "i_km_statistic", columnList = "corpCode"),
            @Index(name = "i_km_statistic", columnList = "shareId")})
public class Statistic extends BaseModel {

    public static String SHARE_ID = "shareId";

    /**
     * 共享主键
     */
    @Column(nullable = false, length = 50)
    private String shareId;

    /**
     * 浏览次数
     */
    @Column(nullable = false)
    private Integer viewCount;

    /**
     * 下载次数
     */
    @Column(nullable = false)
    private Integer downloadCount;

    /**
     * 复制次数
     */
    @Column(nullable = false)
    private Integer copyCount;


    public Statistic() {
    }

    public Statistic(String shareId, Integer viewCount, Integer downloadCount, Integer copyCount) {
        this.shareId = shareId;
        this.viewCount = viewCount;
        this.downloadCount = downloadCount;
        this.copyCount = copyCount;
    }

    public String getShareId() {
        return shareId;
    }

    public void setShareId(String shareId) {
        this.shareId = shareId;
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
}
