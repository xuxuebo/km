package com.qgutech.pe.module.uc.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.base.model.Category;
import com.qgutech.pe.module.ems.model.*;
import com.qgutech.pe.module.exercise.model.ExerciseUser;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * user domain
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年2月23日17:03:00
 */
@Entity
@Table(name = "t_uc_user", indexes = {
        @Index(name = "i_uc_user_corpCode", columnList = "corpCode"),
        @Index(name = "i_uc_user_organizeId", columnList = "organize_id"),
        @Index(name = "i_uc_user_employeeCode", columnList = "employeeCode")})
public class User extends BaseModel {

    public static final String _userName = "userName";
    public static final String _status = "status";
    public static final String _employeeCode = "employeeCode";
    public static final String _email = "email";
    public static final String _organize = "organize.id";
    public static final String _organizeAlias = "organize";
    public static final String _organizeName = "organize.organizeName";
    public static final String _idCard = "idCard";
    public static final String _sexType = "sexType";
    public static final String _address = "address";
    public static final String _loginName = "loginName";
    public static final String _mobile = "mobile";
    public static final String _entryTime = "entryTime";
    public static final String _password = "password";
    public static final String _faceFileId = "faceFileId";
    public static final String _facePath = "facePath";
    public static final String _faceFileName = "faceFileName";
    public static final String _userAlias = "user";
    public static final String _userPositionAlias = "userPositions";
    public static final String _userRoleAlias = "userRoles";
    public static final String _roleType = "roleType";
    public static final String _templateAuthAlias = "paperTemplateAuths";
    public static final String _emailVerify = "emailVerify";
    public static final String _mobileVerify = "mobileVerify";
    public static final String _examUserAlias = "examUsers";
    public static final String _mockExamUsers = "mockExamUsers";
    public static final String _judgeUserAlas = "judgeUsers";
    public static final String _examAuthAlias = "examAuths";
    public static final String _examMonitorAlias = "examMonitors";
    public static final String _examResultAlias = "examResults";
    public static final String _exerciseUserAlias = "exerciseUsers";

    /**
     * 用户性别类型
     */
    public enum SexType {
        MALE("男"), FEMALE("女"), SECRECY("保密");
        private final String text;

        private SexType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 账户状态
     */
    public enum UserStatus {
        ENABLE("启用"), FORBIDDEN("冻结"), DELETED("删除");

        private final String text;

        private UserStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum RoleType {
        USER("学员"), ADMIN("管理员");

        private final String text;

        private RoleType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 登录名称
     */
    @Column(nullable = false, length = 50)
    private String loginName;

    /**
     * 登录密码
     */
    @Column(nullable = false, length = 50)
    private String password;

    /**
     * 姓名
     */
    @Column(nullable = false, length = 50)
    private String userName;

    /**
     * 工号
     */
    @Column(length = 20)
    private String employeeCode;


    /**
     * 用户状态
     */
    @Column(nullable = false, length = 20)
    @Enumerated(EnumType.STRING)
    private UserStatus status;

    /**
     * 手机号码
     */
    @Column(length = 20)
    private String mobile;

    /**
     * 邮箱是否被验证
     */
    @Column
    private Boolean mobileVerify = false;

    /**
     * 邮箱
     */
    @Column(length = 100)
    private String email;

    /**
     * 邮箱是否被验证
     */
    @Column
    private Boolean emailVerify = false;

    /**
     * 身份证
     */
    @Column(length = 50)
    private String idCard;

    /**
     * 性别
     */
    @Column(length = 20)
    @Enumerated(EnumType.STRING)
    private SexType sexType;

    /**
     * 入职时间
     */
    @Column
    @Temporal(TemporalType.DATE)
    private Date entryTime;

    /**
     * 地址
     */
    @Column(length = 1300)
    private String address;

    /**
     * 头像
     */
    @Column(length = 32)
    private String faceFileId;

    /**
     * 裁剪图名称
     */
    @Column(length = 200)
    private String faceFileName;

    /**
     * 是否为admin
     */
    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private RoleType roleType;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "organize_id", nullable = false)
    private Organize organize;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
    @Fetch(FetchMode.SUBSELECT)
    private List<UserPosition> userPositions;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
    @Fetch(FetchMode.SUBSELECT)
    private List<UserRole> userRoles;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
    @Fetch(FetchMode.SUBSELECT)
    private List<PaperTemplateAuth> paperTemplateAuths;

    @OneToMany(fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    @JoinColumn(name = "referId")
    private List<ExamUser> examUsers;

    @OneToMany(fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    @JoinColumn(name = "referId")
    private List<MockExamUser> mockExamUsers;


    @OneToMany(fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    @JoinColumn(name = "referId")
    private List<ExerciseUser> exerciseUsers;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
    @Fetch(FetchMode.SUBSELECT)
    private List<JudgeUser> judgeUsers;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
    @Fetch(FetchMode.SUBSELECT)
    private List<ExamAuth> examAuths;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
    @Fetch(FetchMode.SUBSELECT)
    private List<ExamMonitor> examMonitors;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
    @Fetch(FetchMode.SUBSELECT)
    private List<ExamResult> examResults;

    /**********************************************
     *              非持久化字段                    *
     **********************************************/

    /**
     * 关键字搜索
     */
    @Transient
    private String keyword;

    /**
     * 角色查询条件
     */
    @Transient
    private String roleId;

    /**
     * 岗位查询条件
     */
    @Transient
    private String positionId;

    /**
     * 多个岗位名称以,分割
     */
    @Transient
    private String positionName;

    /**
     * 角色集合
     */
    @Transient
    private List<Role> roles;

    @Transient
    private List<String> roleIds;

    @Transient
    private List<Position> positions;

    /**
     * 状态查询条件
     */
    @Transient
    private List<UserStatus> userStatusList;

    /**
     * 用户的验证码
     */
    @Transient
    private String verifyCode;

    /**
     * 新的密码
     */
    @Transient
    private String newPassword;

    /**
     * 是否强制登录
     */
    @Transient
    private boolean forceLogin = false;

    @Transient
    private String facePath;

    /**
     * 登录IP
     */
    @Transient
    private String ip;

    /**
     * 部门名称
     */
    @Transient
    private String organizeName;

    /**
     * 人员是创建者
     */
    @Transient
    private Boolean createUser;

    /**
     * 是否记住密码
     */
    @Transient
    private boolean rememberPwd;

    /**
     * 禁止删除
     */
    @Transient
    private boolean disableDelete;

    /**
     * 岗位类别
     */
    @Transient
    private String positionCategoryName;

    /**
     * 原密码
     */
    @Transient
    private String sourcePwd;

    /**
     * 准考证号
     */
    @Transient
    private String ticket;

    /**
     * 考试ID
     */
    @Transient
    private String examId;

    /**
     * sessionId
     */
    @Transient
    private String sessionId;
    /**
     * 导入新建岗位类别
     */
    @Transient
    private Category positionCategory;

    @Transient
    private String organizeId;

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public Category getPositionCategory() {
        return positionCategory;
    }

    public void setPositionCategory(Category positionCategory) {
        this.positionCategory = positionCategory;
    }

    /**
     * 监控录像封面路径
     */
    @Transient
    private String coverPath;

    public List<ExamAuth> getExamAuths() {
        return examAuths;
    }

    public void setExamAuths(List<ExamAuth> examAuths) {
        this.examAuths = examAuths;
    }

    public List<PaperTemplateAuth> getPaperTemplateAuths() {
        return paperTemplateAuths;
    }

    public List<JudgeUser> getJudgeUsers() {
        return judgeUsers;
    }

    public void setJudgeUsers(List<JudgeUser> judgeUsers) {
        this.judgeUsers = judgeUsers;
    }

    public void setPaperTemplateAuths(List<PaperTemplateAuth> paperTemplateAuths) {
        this.paperTemplateAuths = paperTemplateAuths;
    }

    public List<ExamUser> getExamUsers() {
        return examUsers;
    }

    public void setExamUsers(List<ExamUser> examUsers) {
        this.examUsers = examUsers;
    }

    public List<String> getRoleIds() {
        return roleIds;
    }

    public void setRoleIds(List<String> roleIds) {
        this.roleIds = roleIds;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public boolean isForceLogin() {
        return forceLogin;
    }

    public void setForceLogin(boolean forceLogin) {
        this.forceLogin = forceLogin;
    }

    public Boolean getMobileVerify() {
        return mobileVerify;
    }

    public void setMobileVerify(Boolean mobileVerify) {
        this.mobileVerify = mobileVerify;
    }

    public Boolean getEmailVerify() {
        return emailVerify;
    }

    public void setEmailVerify(Boolean emailVerify) {
        this.emailVerify = emailVerify;
    }

    public String getVerifyCode() {
        return verifyCode;
    }

    public void setVerifyCode(String verifyCode) {
        this.verifyCode = verifyCode;
    }

    public List<UserStatus> getUserStatusList() {
        return userStatusList;
    }

    public void setUserStatusList(List<UserStatus> userStatusList) {
        this.userStatusList = userStatusList;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmployeeCode() {
        return employeeCode;
    }

    public void setEmployeeCode(String employeeCode) {
        this.employeeCode = employeeCode;
    }

    public UserStatus getStatus() {
        return status;
    }

    public void setStatus(UserStatus status) {
        this.status = status;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public SexType getSexType() {
        return sexType;
    }

    public void setSexType(SexType sexType) {
        this.sexType = sexType;
    }

    public Organize getOrganize() {
        return organize;
    }

    public void setOrganize(Organize organize) {
        this.organize = organize;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public Date getEntryTime() {
        return entryTime;
    }

    public void setEntryTime(Date entryTime) {
        this.entryTime = entryTime;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getFaceFileName() {
        return faceFileName;
    }

    public void setFaceFileName(String faceFileName) {
        this.faceFileName = faceFileName;
    }

    public String getFaceFileId() {
        return faceFileId;
    }

    public void setFaceFileId(String faceFileId) {
        this.faceFileId = faceFileId;
    }

    public RoleType getRoleType() {
        return roleType;
    }

    public void setRoleType(RoleType roleType) {
        this.roleType = roleType;
    }

    public List<UserPosition> getUserPositions() {
        return userPositions;
    }

    public void setUserPositions(List<UserPosition> userPositions) {
        this.userPositions = userPositions;
    }

    public List<UserRole> getUserRoles() {
        return userRoles;
    }

    public void setUserRoles(List<UserRole> userRoles) {
        this.userRoles = userRoles;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getPositionId() {
        return positionId;
    }

    public void setPositionId(String positionId) {
        this.positionId = positionId;
    }

    public String getPositionName() {
        return positionName;
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    public List<Position> getPositions() {
        return positions;
    }

    public void setPositions(List<Position> positions) {
        this.positions = positions;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getFacePath() {
        return facePath;
    }

    public void setFacePath(String facePath) {
        this.facePath = facePath;
    }

    public String getOrganizeName() {
        return organizeName;
    }

    public void setOrganizeName(String organizeName) {
        this.organizeName = organizeName;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    public Boolean getCreateUser() {
        return createUser;
    }

    public void setCreateUser(Boolean createUser) {
        this.createUser = createUser;
    }

    public List<ExamMonitor> getExamMonitors() {
        return examMonitors;
    }

    public void setExamMonitors(List<ExamMonitor> examMonitors) {
        this.examMonitors = examMonitors;
    }

    public boolean isRememberPwd() {
        return rememberPwd;
    }

    public void setRememberPwd(boolean rememberPwd) {
        this.rememberPwd = rememberPwd;
    }

    public List<ExerciseUser> getExerciseUsers() {
        return exerciseUsers;
    }

    public boolean isDisableDelete() {
        return disableDelete;
    }

    public void setDisableDelete(boolean disableDelete) {
        this.disableDelete = disableDelete;
    }

    public String getPositionCategoryName() {
        return positionCategoryName;
    }

    public void setPositionCategoryName(String positionCategoryName) {
        this.positionCategoryName = positionCategoryName;
    }

    public String getSourcePwd() {
        return sourcePwd;
    }

    public void setSourcePwd(String sourcePwd) {
        this.sourcePwd = sourcePwd;
    }

    public List<ExamResult> getExamResults() {
        return examResults;
    }

    public void setExamResults(List<ExamResult> examResults) {
        this.examResults = examResults;
    }

    public String getTicket() {
        return ticket;
    }

    public void setTicket(String ticket) {
        this.ticket = ticket;
    }

    public String getExamId() {
        return examId;
    }

    public void setExamId(String examId) {
        this.examId = examId;
    }

    public String getCoverPath() {
        return coverPath;
    }

    public void setCoverPath(String coverPath) {
        this.coverPath = coverPath;
    }

    public List<MockExamUser> getMockExamUsers() {
        return mockExamUsers;
    }

    public void setMockExamUsers(List<MockExamUser> mockExamUsers) {
        this.mockExamUsers = mockExamUsers;
    }

    public void setExerciseUsers(List<ExerciseUser> exerciseUsers) {
        this.exerciseUsers = exerciseUsers;
    }

    public String getOrganizeId() {
        return organizeId;
    }

    public void setOrganizeId(String organizeId) {
        this.organizeId = organizeId;
    }


}

