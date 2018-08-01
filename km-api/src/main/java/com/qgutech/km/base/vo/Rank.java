package com.qgutech.km.base.vo;

/**
 * 知识库排行
 *
 * @author TangFD@HF 2018/7/31
 */
public class Rank {
    /**
     * 姓名
     */
    private String userName;
    private String userId;
    /**
     * 部门名称
     */
    private String orgName;
    /**
     * 上传文件数
     */
    private int count;
    /**
     * 排名
     */
    private int rank;
    private String facePath;

    public Rank(String userId, int count) {
        this.userId = userId;
        this.count = count;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public void setFacePath(String facePath) {
        this.facePath = facePath;
    }

    public String getFacePath() {
        return facePath;
    }
}
