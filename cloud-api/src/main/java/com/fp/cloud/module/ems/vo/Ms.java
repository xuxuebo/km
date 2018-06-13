package com.fp.cloud.module.ems.vo;

import java.util.Map;

/**
 * 考试消息设置（MessageSetting）
 *
 * @author Created by zhangyang on 2016/11/14.
 */
public class Ms {
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
    Map<String, Boolean> eMsg;
    /**
     * 考试作废
     */
    Map<String, Boolean> caMsg;
    /**
     * 考试移除人员通知
     */
    Map<String, Boolean> reMsg;
    /**
     * 考试结束时间变更
     */
    Map<String, Boolean> eeMsg;
    /**
     * 发布成绩通知
     */
    Map<String, Boolean> pmMsg;
    /**
     * 补考通知
     */
    Map<String, Boolean> muMsg;

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

    public Map<String, Boolean> getMuMsg() {
        return muMsg;
    }

    public void setMuMsg(Map<String, Boolean> muMsg) {
        this.muMsg = muMsg;
    }
}
