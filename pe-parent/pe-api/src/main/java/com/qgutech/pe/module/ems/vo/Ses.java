package com.qgutech.pe.module.ems.vo;

import java.util.Map;

/**
 * 考试消息的系统设置
 *
 * @author wangxiaolong@HF at 2017年8月1日14:35:22
 */
public class Ses {
    /**
     * <p>
     * key:
     * 站内信 -> M

     * 电子邮件 -> S
     * 手机短信 -> E
     */
    /**
     * 考试通知
     */
    private Map<String, Boolean> eMsg;
    /**
     * 考试作废通知
     */
    private Map<String, Boolean> caMsg;
    /**
     * 考试移除人员通知
     */
    private Map<String, Boolean> reMsg;
    /**
     * 违纪通知
     */
    private Map<String, Boolean> bpMsg;
    /**
     * 强制交卷通知
     */
    private Map<String, Boolean> fsMsg;
    /**
     * 考试提醒通知
     */
    private Map<String, Boolean> rmMsg;
    /**
     * 考试结束时间变更通知
     */
    private Map<String, Boolean> eeMsg;

    /**
     * 发布成绩通知
     */
    private Map<String, Boolean> pmMsg;
    /**
     * 补考通知
     */
    private Map<String, Boolean> muMsg;

    public Map<String, Boolean> getMuMsg() {
        return muMsg;
    }

    public void setMuMsg(Map<String, Boolean> muMsg) {
        this.muMsg = muMsg;
    }

    public Map<String, Boolean> geteMsg() {
        return eMsg;
    }

    public void seteMsg(Map<String, Boolean> eMsg) {
        this.eMsg = eMsg;
    }

    public Map<String, Boolean> getCaMsg() {
        return caMsg;
    }

    public void setCaMsg(Map<String, Boolean> caMsg) {
        this.caMsg = caMsg;
    }

    public Map<String, Boolean> getReMsg() {
        return reMsg;
    }

    public void setReMsg(Map<String, Boolean> reMsg) {
        this.reMsg = reMsg;
    }

    public Map<String, Boolean> getEeMsg() {
        return eeMsg;
    }

    public void setEeMsg(Map<String, Boolean> eeMsg) {
        this.eeMsg = eeMsg;
    }

    public Map<String, Boolean> getPmMsg() {
        return pmMsg;
    }

    public void setPmMsg(Map<String, Boolean> pmMsg) {
        this.pmMsg = pmMsg;
    }

    public Map<String, Boolean> getRmMsg() {
        return rmMsg;
    }

    public void setRmMsg(Map<String, Boolean> rmMsg) {
        this.rmMsg = rmMsg;
    }

    public Map<String, Boolean> getBpMsg() {
        return bpMsg;
    }

    public void setBpMsg(Map<String, Boolean> bpMsg) {
        this.bpMsg = bpMsg;
    }

    public Map<String, Boolean> getFsMsg() {
        return fsMsg;
    }

    public void setFsMsg(Map<String, Boolean> fsMsg) {
        this.fsMsg = fsMsg;
    }


}
