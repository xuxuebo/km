package com.fp.cloud.base.service;

import com.fp.cloud.base.model.CorpInfo;
import com.fp.cloud.base.model.Page;
import com.fp.cloud.base.model.PageParam;

/**
 * 公司管理接口
 *
 * @author LiYanCheng
 * @since 2017年3月21日14:16:13
 */

public interface CorpService extends BaseService<CorpInfo> {

    /**
     * 分页展示公司信息
     *
     * @param pageParam 分页条件
     * @param corpInfo  公司信息查询条件
     * @return 分页数据
     * @since 2017年3月21日14:26:40
     */
    Page<CorpInfo> search(PageParam pageParam, CorpInfo corpInfo);

    /**
     * 检测企业ID是否存在
     *
     * @param corpCode 企业ID
     * @since 2017年3月21日17:46:39
     */
    CorpInfo checkCorpCode(String corpCode);

    /**
     * 检测企业域名是否存在
     *
     * @param domainName 企业域名
     * @since 2017年3月21日17:46:39
     */
    CorpInfo checkDomainName(String domainName);

    /**
     * 修改公司信息
     *
     * @param corpInfo 公司信息
     * @since 2017年3月22日09:03:28
     */
    void update(CorpInfo corpInfo);

    /**
     * 启用公司信息并且刷新到redis中
     *
     * @param corpId 公司信息
     */
    void enableCorp(String corpId);

    /**
     * 存储公司信息到redis中
     *
     * @param corpInfo 公司信息
     */
    void storageRedis(CorpInfo corpInfo);

    /**
     * 储存数据到redis当中
     * @param corpCode
     * @param loginName
     */
    String storeElnToRedis(String corpCode,String loginName);
    /**
     * 通过域名获取公司信息
     *
     * @param domain 公司域名
     * @return 公司信息
     * @since 2017年3月22日10:38:45
     */
    CorpInfo getByDomain(String domain);

    /**
     * 通过code获取公司信息
     *
     * @param corpCode 公司CODE
     * @return 公司信息
     * @since 2017年3月22日10:38:45
     */
    CorpInfo getByCode(String corpCode);

    /**
     * 冻结公司信息
     *
     * @param corpId
     */
    void disableCorp(String corpId);

    /**
     * 查询公司短信功能是否开启
     *
     * @return true or false
     */
    Boolean checkMessage();

    /**
     * <p>保存公司信息，自动启用公司</p>
     *
     * @param corpInfo 公司信息，重要字段如下：
     *                 <ul>
     *                 <li>{@linkplain CorpInfo#corpCode 企业ID}</li>
     *                 <li>{@linkplain CorpInfo#corpName 公司名称}</li>
     *                 <li>{@linkplain CorpInfo#concurrentNum 并发数}</li>
     *                 <li>{@linkplain CorpInfo#registerNum 注册数}</li>
     *                 <li>{@linkplain CorpInfo#endTime 使用结束时间}</li>
     *                 <li>{@linkplain CorpInfo#domainName 域名}</li>
     *                 </ul>
     * @return 主键
     */
    String autoOpenCorp(CorpInfo corpInfo);

    /**
     * 开通公司（针对ELP）
     *
     * @param corpInfo 公司信息，重要字段如下：
     *                 <ul>
     *                 <li>{@linkplain CorpInfo#corpCode 企业ID}</li>
     *                 <li>{@linkplain CorpInfo#corpName 公司名称}</li>
     *                 <li>{@linkplain CorpInfo#concurrentNum 并发数}</li>
     *                 <li>{@linkplain CorpInfo#registerNum 注册数}</li>
     *                 <li>{@linkplain CorpInfo#endTime 使用结束时间}</li>
     *                 <li>{@linkplain CorpInfo#domainName 域名}</li>
     *                 </ul>
     * @return 主键
     */
    String openCorpForElp(CorpInfo corpInfo);
}
