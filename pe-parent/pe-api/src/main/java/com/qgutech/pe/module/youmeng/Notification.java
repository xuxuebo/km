package com.qgutech.pe.module.youmeng;

import java.util.Map;

/**
 * 自定义包装类
 * @author: xiaolong@hf
 * @since: 2018/5/9 10:30
 */
public class Notification {
    public enum MessageType{
        EXAMRELEASE{public String getValue(){return "examrelease";}},//启用考试通知
        EXAMNOTICE{public String getValue(){return "EXAMNOTICE";}},///考试前半小时通知
        EXAMMAKEUP{public String getValue(){return "EXAMMAKEUP";}},//补考通知
        SCORERELEASE{public String getValue(){return "SCORERELEASE";}};//成绩


        public abstract String getValue();
    }
    /**
     * 自定义通知栏提示文字
     */
    private String ticker;
    /**
     * 标题
     */
    private String title;
    /**
     * 文字描述
     */
    private String text;
    /**
     * alias
     */
    private String alias;
    /**
     * alias_type
     */
    private String alias_type;

    /**
     * 消息描述
     */
    private String description;
    /**
     * 自定义类型
     */
    private Map<String,String> msgMap;


    public MessageType getMessageType() {
        return messageType;
    }

    public void setMessageType(MessageType messageType) {
        this.messageType = messageType;
    }

    private MessageType messageType;

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    /**
     * 发送时间
     */

    private String startTime;


    private AndroidNotification.DisplayType displayType;

    public AndroidNotification.DisplayType getDisplayType() {
        return displayType;
    }

    public void setDisplayType(AndroidNotification.DisplayType displayType) {
        this.displayType = displayType;
    }

    /**
     *点击消息后的操作；
     * 必填，值可以为:
     *   "go_app": 打开应用
     *   "go_url": 跳转到URL
     *   "go_activity": 打开特定的activity

     *   "go_custom": 用户自定义内容。

     */
    private AndroidNotification.AfterOpenAction afterOpenAction;

    public AndroidNotification.AfterOpenAction getAfterOpenAction() {
        return afterOpenAction;
    }

    public void setAfterOpenAction(AndroidNotification.AfterOpenAction afterOpenAction) {
        this.afterOpenAction = afterOpenAction;
    }

    public String getTicker() {
        return ticker;
    }

    public void setTicker(String ticker) {
        this.ticker = ticker;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public String getAlias_type() {
        return alias_type;
    }

    public void setAlias_type(String alias_type) {
        this.alias_type = alias_type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Map<String, String> getMsgMap() {
        return msgMap;
    }

    public void setMsgMap(Map<String, String> msgMap) {
        this.msgMap = msgMap;
    }


}
