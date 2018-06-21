package com.qgutech.km.base.model;

import com.qgutech.km.module.uc.model.User;

import javax.persistence.*;

@Entity
@Table(name = "t_pe_message", indexes = {
        @Index(name = "i_pe_message_corpCode", columnList = "corpCode"),
        @Index(name = "i_pe_message_userId", columnList = "user_id")})
public class Message extends BaseModel {
    public static final String _createTime = "createTime";
    public static final String _content = "content";
    public static final String _user = "user.id";
    public static final String _read = "read";
    public static final String _userAlias = "user";
    public static final String _updateTime = "updateTime";

    /**
     * 站内信内容
     */
    @Column(length = 1300, nullable = false)
    private String content;

    /**
     * 学员
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    /**
     * 是否已读
     */
    @Column(name = "is_read")
    private boolean read;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public boolean isRead() {
        return read;
    }

    public void setRead(boolean read) {
        this.read = read;
    }
}
