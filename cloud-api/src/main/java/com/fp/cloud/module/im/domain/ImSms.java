package com.fp.cloud.module.im.domain;

/**
 * 短信消息
 */
public class ImSms {

    //手机号
    private String mobile;
    //内容
    private String content;
    //短信模版id
    private String templateId;
    //错误信息
    private String errorInfo;

    public ImSms() {

    }

    public ImSms(String mobile, String content, String templateId) {
        this.mobile = mobile;
        this.content = content;
        this.templateId = templateId;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTemplateId() {
        return templateId;
    }

    public void setTemplateId(String templateId) {
        this.templateId = templateId;
    }

    public String getErrorInfo() {
        return errorInfo;
    }

    public void setErrorInfo(String errorInfo) {
        this.errorInfo = errorInfo;
    }

    @Override
    public String toString() {
        return "ImSms{" +
                "mobile='" + this.mobile + '\'' +
                ", content='" + this.content + '\'' +
                ", templateId='" + this.templateId + '\'' +
                ", errorInfo='" + this.errorInfo + '\'' +
                '}';
    }
}
