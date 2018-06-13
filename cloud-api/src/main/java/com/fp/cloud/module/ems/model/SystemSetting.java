package com.fp.cloud.module.ems.model;


import com.fp.cloud.base.model.BaseModel;

import javax.persistence.*;

/**
 * 系统消息设置实体类
 *
 * @author wangxiaolong@hf at 2017年8月1日15:21:52
 */
@Entity
@Table(name = "t_pe_system_setting", indexes = {
        @Index(name = "i_pe_system_setting_createBy", columnList = "createBy")
})
public class SystemSetting extends BaseModel {
    public static final String _systemType = "systemType";
    public static final String _message = "message";
    public static final String _openAppMsg = "openAppMsg";

    public enum SystemType {
        EXAM("考试设置"), USER("用户设置"),APPMSG("APP消息设置");
        private String text;

        SystemType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 考试消息设置
     */
    @Column(name = "message")
    private String message;

    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private SystemType systemType;

    @Column(name= "open_app_msg")
    private boolean openAppMsg;




    public boolean isOpenAppMsg() {
        return openAppMsg;
    }

    public void setOpenAppMsg(boolean openAppMsg) {
        this.openAppMsg = openAppMsg;
    }


    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public SystemType getSystemType() {
        return systemType;
    }

    public void setSystemType(SystemType systemType) {
        this.systemType = systemType;
    }

}
