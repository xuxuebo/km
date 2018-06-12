package com.qgutech.pe.module.ems.vo;

import com.alibaba.fastjson.annotation.JSONField;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 学员提交答题记录
 *
 * @author LiYanCheng@HF
 * @since 2016年12月3日09:17:483
 */
public class Ur {

    public enum Type {
        DI("考试中"), MI("待评卷"), OVER("自动评卷结束"), NT("未开始"), EO("异常退出");
        private final String text;

        Type(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 考试ID
     */
    private String id;

    /**
     * 客户端提交时间段key
     */
    @JSONField(serialize = false)
    private String cut;

    /**
     * 考试状态
     */
    private Type t;

    /**
     * 交卷时间
     */
    private Date sd;

    /**
     * 学员进入、退出考试时间记录
     */
    private List<Ug> ugs;

    /**
     * 更新时间
     */
    private Date ud;

    /**
     * 试卷ID
     */
    private String pId;

    /**
     * 学生提交答案记录 key 题号 value 答案
     */
    private Map<Integer, Ua> am;

    /**
     * 切屏次数
     */
    private Integer cst;

    /**
     * 答题时长 秒
     */
    private Long al;

    /**
     * 手机验证是否通过
     */
    private Boolean mv;

    /**
     * 环境监测是否通过
     */
    private Boolean ev;

    /**
     * 拍照集合
     */
    private List<Em> ems;

    /**
     * 学生试题以及选项顺序
     */
    private Map<String, List<Ui>> uim;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Type getT() {
        return t;
    }

    public void setT(Type t) {
        this.t = t;
    }

    public Date getSd() {
        return sd;
    }

    public void setSd(Date sd) {
        this.sd = sd;
    }

    public List<Ug> getUgs() {
        return ugs;
    }

    public void setUgs(List<Ug> ugs) {
        this.ugs = ugs;
    }

    public Map<Integer, Ua> getAm() {
        return am;
    }

    public void setAm(Map<Integer, Ua> am) {
        this.am = am;
    }

    public Date getUd() {
        return ud;
    }

    public void setUd(Date ud) {
        this.ud = ud;
    }

    public String getpId() {
        return pId;
    }

    public void setpId(String pId) {
        this.pId = pId;
    }

    public Integer getCst() {
        return cst;
    }

    public void setCst(Integer cst) {
        this.cst = cst;
    }

    public Long getAl() {
        return al;
    }

    public void setAl(Long al) {
        this.al = al;
    }

    public String getCut() {
        return cut;
    }

    public void setCut(String cut) {
        this.cut = cut;
    }

    public Boolean getMv() {
        return mv;
    }

    public void setMv(Boolean mv) {
        this.mv = mv;
    }

    public Boolean getEv() {
        return ev;
    }

    public void setEv(Boolean ev) {
        this.ev = ev;
    }

    public List<Em> getEms() {
        return ems;
    }

    public void setEms(List<Em> ems) {
        this.ems = ems;
    }

    public Map<String, List<Ui>> getUim() {
        return uim;
    }

    public void setUim(Map<String, List<Ui>> uim) {
        this.uim = uim;
    }
}
