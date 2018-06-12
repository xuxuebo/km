package com.qgutech.pe.module.ems.vo;

/**
 * 防舞弊设置 preventFraudSetting
 *
 * @author Created by zhangyang on 2016/11/14.
 */
public class Ps {

    /**
     * 是否开启考场监控
     */
    private Boolean om;

    /**
     * 进入考试时需要短信验证身份 smsVerify
     */
    private Boolean sv;

    /**
     * 开启实时摄像抓拍的功能 RealTimeCapture
     */
    private Boolean rc;

    /**
     * 启用全屏模式 fullScreen
     */
    private Boolean fs;

    /**
     * 启用切屏检测 cutScreen
     */
    private Boolean cs;

    /**
     * 切屏次数 cutScreenNum；
     */
    private Integer csN;

    /**
     * 考试页面不操作检测 noOperate
     */
    private Boolean no;

    /**
     * 不操作的时间 noOperateDate
     */
    private Integer noD;

    /**
     * 迟到检测 late；
     */
    private Boolean lt;

    /**
     * 迟到检测时间
     */
    private Integer ltD;

    /**
     * 答卷时间少于bsD分钟，禁止交卷 banSubmit
     */
    private Boolean bs;

    /**
     * 禁止交卷时间 banSubmitDate
     */
    private Integer bsD;

    /**
     * 生成试卷时打乱相同题型下的试题的顺序 randomItem
     */
    private Boolean ri;

    public Boolean getSv() {
        return sv;
    }

    public void setSv(Boolean sv) {
        this.sv = sv;
    }

    public Boolean getRc() {
        return rc;
    }

    public void setRc(Boolean rc) {
        this.rc = rc;
    }

    public Boolean getFs() {
        return fs;
    }

    public void setFs(Boolean fs) {
        this.fs = fs;
    }

    public Boolean getCs() {
        return cs;
    }

    public void setCs(Boolean cs) {
        this.cs = cs;
    }

    public Integer getCsN() {
        return csN;
    }

    public void setCsN(Integer csN) {
        this.csN = csN;
    }

    public Boolean getNo() {
        return no;
    }

    public void setNo(Boolean no) {
        this.no = no;
    }

    public Integer getNoD() {
        return noD;
    }

    public void setNoD(Integer noD) {
        this.noD = noD;
    }

    public Boolean getLt() {
        return lt;
    }

    public void setLt(Boolean lt) {
        this.lt = lt;
    }

    public Integer getLtD() {
        return ltD;
    }

    public void setLtD(Integer ltD) {
        this.ltD = ltD;
    }

    public Boolean getBs() {
        return bs;
    }

    public void setBs(Boolean bs) {
        this.bs = bs;
    }

    public Integer getBsD() {
        return bsD;
    }

    public void setBsD(Integer bsD) {
        this.bsD = bsD;
    }

    public Boolean getRi() {
        return ri;
    }

    public void setRi(Boolean ri) {
        this.ri = ri;
    }

    public Boolean getOm() {
        return om;
    }

    public void setOm(Boolean om) {
        this.om = om;
    }
}
