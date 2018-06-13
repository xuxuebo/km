package com.fp.cloud.module.uc.model;

import com.fp.cloud.base.model.BaseModel;

import javax.persistence.*;

/**
 * user position rel
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年9月12日10:37:40
 */
@Entity
@Table(name = "t_uc_user_position",
        uniqueConstraints = {@UniqueConstraint(name = "u_uc_user_position_user_position",
                columnNames = {"user_id", "position_id"})},
        indexes = {
                @Index(name = "i_uc_user_position_corpCode", columnList = "corpCode"),
                @Index(name = "i_uc_user_position_positionId", columnList = "position_id")})
public class UserPosition extends BaseModel {

    public static final String _position = "position.id";
    public static final String _positionName = "position.positionName";
    public static final String _positionAlias = "position";
    public static final String _user = "user.id";

    /**
     * 用户
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    /**
     * 角色
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "position_id", nullable = false)
    private Position position;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Position getPosition() {
        return position;
    }

    public void setPosition(Position position) {
        this.position = position;
    }
}
