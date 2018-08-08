package com.qgutech.km.base.model;

import com.qgutech.km.module.uc.model.User;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "t_pe_corp_info", indexes = {
        @Index(name = "i_pe_corp_info_code", columnList = "corpCode")})
public class CorpInfo extends BaseModel {

    public static final String _corpName = "corpName";
    public static final String _concurrentNum = "concurrentNum";
    public static final String _registerNum = "registerNum";
    public static final String _startTime = "startTime";
    public static final String _endTime = "endTime";
    public static final String _corpStatus = "corpStatus";
    public static final String _domainName = "domainName";
    public static final String _address = "address";
    public static final String _contacts = "contacts";
    public static final String _contactsMobile = "contactsMobile";
    public static final String _comments = "comments";
    public static final String _email = "email";
    public static final String _industry = "industry";
    public static final String _messageStatus = "messageStatus";
    public static final String _payApps = "payApps";
    public static final String _fromAppType = "fromAppType";
    public static final String _version = "version";

    public enum CorpStatus {
        ENABLE("启用"), DISABLE("停用"), DRAFT("草稿"), DELETE("删除"), OVER("已到期");
        private String text;

        CorpStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum CorpVersion {
        FREE("免费版"), ENTERPRISE("企业版"), DEPLOY("部署");
        private String text;

        CorpVersion(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum PayApps {
        REMOTEMONITOR("远程监控"), APPLICATION("报名"),
        CERTIFICATE("证书"), EXAMROOM("考场"), TICKET("准考证");
        private String text;

        PayApps(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum MessageStatus {
        OPEN("开启"), CLOSE("关闭");
        private String text;

        MessageStatus(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum FromAppType {
        PE("智慧云"), ELP("ELP");
        private String text;

        FromAppType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 功能名称
     */
    @Column(nullable = false, length = 200)
    private String corpName;

    /**
     * 最大并发数
     */
    @Column
    private long concurrentNum;


    /**
     * 最大注册数
     */
    @Column
    private long registerNum;

    /**
     * 开始日期
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false)
    private Date startTime;

    /**
     * 消息设置
     */
    @Column(nullable = false, length = 20)
    @Enumerated(EnumType.STRING)
    private MessageStatus messageStatus;

    /**
     * 来源类型
     */
    @Column(length = 20)
    @Enumerated(EnumType.STRING)
    private FromAppType fromAppType;

    @Column(length = 200)
    private String payApps;

    public String getPayApps() {
        return payApps;
    }

    public void setPayApps(String payApps) {
        this.payApps = payApps;
    }

    /**
     * 结束日期
     */
    @Temporal(TemporalType.TIMESTAMP)
    private Date endTime;

    /**
     * 状态
     */
    @Column(nullable = false, length = 20)
    @Enumerated(EnumType.STRING)
    private CorpStatus corpStatus;

    /**
     * 域名
     */
    @Column(length = 200, nullable = false)
    private String domainName;

    /**
     * 公司地址
     */
    @Column(length = 200)
    private String address;

    /**
     * 联系人
     */
    @Column(length = 20)
    private String contacts;

    /**
     * 联系人电话
     */
    @Column(length = 20)
    private String contactsMobile;

    /**
     * 联系人职位
     */
    @Column(length = 20)
    private String contactsPosition;

    /**
     * 备注
     */
    @Column(length = 1300)
    private String comments;

    /**
     * 邮箱
     */
    @Column(length = 200)
    private String email;

    /**
     * 所属行业
     */
    @Column(length = 200)
    private String industry;

    @Column(length = 20)
    @Enumerated(EnumType.STRING)
    private CorpVersion version;

    /**
     * 已经使用的账号
     */
    @Transient
    private long usedNum;

    /**
     * 创建人信息
     */
    @Transient
    private User createUser;

    /**
     * 状态集合
     */
    @Transient
    private List<CorpStatus> statuses;

    public CorpVersion getVersion() {
        return version;
    }

    public void setVersion(CorpVersion version) {
        this.version = version;
    }

    public MessageStatus getMessageStatus() {
        return messageStatus;
    }

    public void setMessageStatus(MessageStatus messageStatus) {
        this.messageStatus = messageStatus;
    }

    public String getCorpName() {
        return corpName;
    }

    public void setCorpName(String corpName) {
        this.corpName = corpName;
    }

    public long getConcurrentNum() {
        return concurrentNum;
    }

    public void setConcurrentNum(long concurrentNum) {
        this.concurrentNum = concurrentNum;
    }

    public long getRegisterNum() {
        return registerNum;
    }

    public void setRegisterNum(long registerNum) {
        this.registerNum = registerNum;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public CorpStatus getCorpStatus() {
        return corpStatus;
    }

    public void setCorpStatus(CorpStatus corpStatus) {
        this.corpStatus = corpStatus;
    }

    public String getDomainName() {
        return domainName;
    }

    public void setDomainName(String domainName) {
        this.domainName = domainName;
    }

    public long getUsedNum() {
        return usedNum;
    }

    public void setUsedNum(long usedNum) {
        this.usedNum = usedNum;
    }

    public User getCreateUser() {
        return createUser;
    }

    public void setCreateUser(User createUser) {
        this.createUser = createUser;
    }

    public List<CorpStatus> getStatuses() {
        return statuses;
    }

    public void setStatuses(List<CorpStatus> statuses) {
        this.statuses = statuses;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContacts() {
        return contacts;
    }

    public void setContacts(String contacts) {
        this.contacts = contacts;
    }

    public String getContactsMobile() {
        return contactsMobile;
    }

    public void setContactsMobile(String contactsMobile) {
        this.contactsMobile = contactsMobile;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public String getContactsPosition() {
        return contactsPosition;
    }

    public void setContactsPosition(String contactsPosition) {
        this.contactsPosition = contactsPosition;
    }

    public FromAppType getFromAppType() {
        return fromAppType;
    }

    public void setFromAppType(FromAppType fromAppType) {
        this.fromAppType = fromAppType;
    }
}
