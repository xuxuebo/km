package com.qgutech.pe.module.ems.vo;

import javax.persistence.criteria.Predicate;
import java.util.Map;

/**
 * 新增用户，消息设置
 *
 * @author wangxiaolong@hf  2017年8月1日11:31:18
 */
public class Us {
    /**
     * <p>
     * key:
     * 站内信 -> M
     * 电子邮件 -> S
     * 手机短信 -> E
     */

    /**
     * 新增、导入消息设置
     */
    private Map<String, Boolean> adMsg;
    /**
     * 冻结消息设置
     */

    private Map<String, Boolean> frMsg;
    /**
     * 激活消息设置
     */
    private Map<String, Boolean> acMsg;
    /**
     * 部门调动消息设置
     */
    private Map<String, Boolean> trMsg;
    /**
     * 重置密码消息设置
     */
    private Map<String, Boolean> rsMsg;

    public Map<String, Boolean> getAdMsg() {
        return adMsg;
    }

    public void setAdMsg(Map<String, Boolean> adMsg) {
        this.adMsg = adMsg;
    }

    public Map<String, Boolean> getFrMsg() {
        return frMsg;
    }

    public void setFrMsg(Map<String, Boolean> frMsg) {
        this.frMsg = frMsg;
    }

    public Map<String, Boolean> getAcMsg() {
        return acMsg;
    }

    public void setAcMsg(Map<String, Boolean> acMsg) {
        this.acMsg = acMsg;
    }

    public Map<String, Boolean> getTrMsg() {
        return trMsg;
    }

    public void setTrMsg(Map<String, Boolean> trMsg) {
        this.trMsg = trMsg;
    }

    public Map<String, Boolean> getRsMsg() {
        return rsMsg;
    }

    public void setRsMsg(Map<String, Boolean> rsMsg) {
        this.rsMsg = rsMsg;
    }
}
