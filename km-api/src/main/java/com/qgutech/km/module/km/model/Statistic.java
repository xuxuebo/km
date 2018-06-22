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
}
