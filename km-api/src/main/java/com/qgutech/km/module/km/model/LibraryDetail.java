package com.qgutech.km.module.km.model;

import com.qgutech.km.base.model.BaseModel;

import javax.persistence.*;

/**
 * 智慧云库详细信息实体
 *
 * @author TangFD@HF
 * @since 2018-7-31
 */
@Entity
@Table(name = "t_km_library_detail", indexes = {@Index(name = "i_km_library_detail_corpCode", columnList = "corpCode")})
public class LibraryDetail extends BaseModel {

    public static String CHARGE_IDS = "chargeIds";
    public static String FACE_ID = "faceId";
    public static String FACE_NAME = "faceName";
    public static String SUMMARY = "summary";
    public static String LIBRARY_ID = "libraryId";

    /**
     * 负责人Ids，逗号分隔
     */
    @Column(length = 1300)
    private String chargeIds;

    /**
     * 封面Id
     */
    @Column(length = 32)
    private String faceId;

    /**
     * 封面名称
     */
    @Column(length = 200)
    private String faceName;

    /**
     * 简介
     */
    @Column
    private String summary;

    @Column
    private String libraryId;

    @Transient
    private String chargeName;
    @Transient
    private String facePath;

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getFaceId() {
        return faceId;
    }

    public void setFaceId(String faceId) {
        this.faceId = faceId;
    }

    public String getChargeIds() {
        return chargeIds;
    }

    public void setChargeIds(String chargeIds) {
        this.chargeIds = chargeIds;
    }

    public void setChargeName(String chargeName) {
        this.chargeName = chargeName;
    }

    public String getChargeName() {
        return chargeName;
    }

    public String getFaceName() {
        return faceName;
    }

    public void setFaceName(String faceName) {
        this.faceName = faceName;
    }

    public void setFacePath(String facePath) {
        this.facePath = facePath;
    }

    public String getFacePath() {
        return facePath;
    }

    public String getLibraryId() {
        return libraryId;
    }

    public void setLibraryId(String libraryId) {
        this.libraryId = libraryId;
    }
}
