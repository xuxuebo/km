package com.qgutech.km.base.vo;

import java.util.Date;

/**
 * 负责接收webSocket 参数值
 *
 * @author LiYanCheng@HF
 * @since 2016年12月7日09:05:52
 */
public class SocketVo {

    /**
     * 试题类型
     */
    public enum Status {
        DOING("进行中"), SUBMIT("提交试卷"), INVALID("失效"), FORCESUBMIT("强制提交"), EXAM_OVER("考试结束");
        private final String text;

        Status(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 别名KEY
     */
    private String key;

    /**
     * 别名value
     */
    private String value;

    /**
     * 提交状态
     */
    private Status status;

    /**
     * 标志
     */
    private String flag;

    /**
     * 考试时间
     */
    private Date et;

    /**
     * 时间
     */
    private Date nt;

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public Date getEt() {
        return et;
    }

    public void setEt(Date et) {
        this.et = et;
    }

    public Date getNt() {
        return nt;
    }

    public void setNt(Date nt) {
        this.nt = nt;
    }
}
