package com.fp.cloud.base.service;

import com.alibaba.fastjson.JSON;
import com.fp.cloud.base.ExecutionContext;
import com.fp.cloud.base.model.Category;
import com.fp.cloud.base.model.Page;
import com.fp.cloud.base.redis.PeRedisClient;
import com.fp.cloud.constant.PeConstant;
import com.fp.cloud.module.uc.model.*;
import com.fp.cloud.module.uc.service.OrganizeService;
import com.fp.cloud.module.uc.service.UserService;
import com.fp.cloud.utils.*;
import com.fp.cloud.base.model.CorpInfo;
import com.fp.cloud.base.model.PageParam;
import com.fp.cloud.base.redis.PeJedisCommands;
import com.fp.cloud.constant.RedisKey;
import com.fp.cloud.module.uc.model.*;
import com.fp.cloud.module.uc.service.AuthorityService;
import com.fp.cloud.utils.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.hibernate.criterion.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

@Service("corpService")
public class CorpServiceImpl extends BaseServiceImpl<CorpInfo> implements CorpService {

    @Resource
    private UserService userService;
    @Resource
    private CategoryService categoryService;
    @Resource
    private OrganizeService organizeService;
    @Resource
    private AuthorityService authorityService;
    @Resource
    private CorpService corpService;

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public String save(CorpInfo corpInfo) {
        if (corpInfo == null || StringUtils.isBlank(corpInfo.getCorpCode()) || corpInfo.getFromAppType() == null
                || StringUtils.isBlank(corpInfo.getCorpName()) || StringUtils.isBlank(corpInfo.getDomainName())) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        CorpInfo dataCorpInfo = checkCorpCode(corpInfo.getCorpCode());
        if (dataCorpInfo != null) {
            throw new PeException("企业ID已经存在，请重新输入");
        }

        dataCorpInfo = checkDomainName(corpInfo.getDomainName());
        if (dataCorpInfo != null) {
            throw new PeException("企业域名已经存在，请重新输入");
        }

        corpInfo.setCorpStatus(CorpInfo.CorpStatus.DRAFT);
        if (corpInfo.getStartTime() == null) {
            corpInfo.setStartTime(new Date());
        }

        if (corpInfo.getEndTime() != null) {
            corpInfo.setEndTime(PeDateUtils.getEndDate(corpInfo.getEndTime()));
            if (new Date().after(corpInfo.getEndTime())) {
                throw new PeException("结束时间不合法，请重新输入");
            }
        }

        return super.save(corpInfo);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<CorpInfo> search(PageParam pageParam, CorpInfo corpInfo) {
        PeUtils.validPage(pageParam);
        Conjunction conjunction = Restrictions.conjunction();
        conjunction.add(Restrictions.ne(CorpInfo._corpStatus, CorpInfo.CorpStatus.DELETE));
        if (corpInfo != null) {
            if (StringUtils.isNotBlank(corpInfo.getCreateBy())) {
                List<String> userIds = userService.listUserId(corpInfo.getCreateBy());
                if (CollectionUtils.isEmpty(userIds)) {
                    return new Page<>();
                }

                conjunction.add(Restrictions.in(CorpInfo._createBy, userIds));
            }

            if (StringUtils.isNotBlank(corpInfo.getCorpName())) {
                String corpName = corpInfo.getCorpName().trim();
                Disjunction disjunction = Restrictions.disjunction();
                disjunction.add(Restrictions.like(CorpInfo._corpCode, corpName, MatchMode.ANYWHERE));
                disjunction.add(Restrictions.like(CorpInfo._corpName, corpName, MatchMode.ANYWHERE));
                conjunction.add(disjunction);
            }

            if (CollectionUtils.isNotEmpty(corpInfo.getStatuses())) {
                Disjunction disjunction = Restrictions.disjunction();
                if (corpInfo.getStatuses().contains(CorpInfo.CorpStatus.OVER)) {
                    disjunction.add(Restrictions.and(
                            Restrictions.eq(CorpInfo._corpStatus, CorpInfo.CorpStatus.ENABLE),
                            Restrictions.le(CorpInfo._endTime, new Date())
                    ));
                }

                disjunction.add(Restrictions.in(CorpInfo._corpStatus, corpInfo.getStatuses()));
                conjunction.add(disjunction);
            }
        }

        Page<CorpInfo> page = search(pageParam, conjunction, new Order[]{Order.desc(CorpInfo._updateTime)},
                CorpInfo._corpName, CorpInfo._corpCode, CorpInfo._createBy, CorpInfo._concurrentNum, CorpInfo._createTime,
                CorpInfo._registerNum, CorpInfo._endTime, CorpInfo._corpStatus, CorpInfo._id, CorpInfo._fromAppType , CorpInfo._version);
        if (CollectionUtils.isEmpty(page.getRows())) {
            return new Page<>();
        }

        List<String> createUserIds = page.getRows().stream().map(CorpInfo::getCreateBy).collect(Collectors.toList());
        List<String> corpCodes = page.getRows().stream().filter(corp -> !CorpInfo.CorpStatus.DRAFT.equals(corp.getCorpStatus()))
                .map(CorpInfo::getCorpCode).collect(Collectors.toList());
        Map<String, User> userMap = userService.findUserInfo(createUserIds);
        Map<String, Long> countMap = new HashMap<>(0);
        if (CollectionUtils.isNotEmpty(corpCodes)) {
            countMap = userService.findCount(corpCodes);
        }

        for (CorpInfo corp : page.getRows()) {
            corp.setCreateUser(userMap.get(corp.getCreateBy()));
            corp.setUsedNum(PeNumberUtils.transformLong(countMap.get(corp.getCorpCode())));
            if (corp.getEndTime() == null) {
                continue;
            }

            if (CorpInfo.CorpStatus.ENABLE.equals(corp.getCorpStatus()) && new Date().after(corp.getEndTime())) {
//                corp.setCorpStatus(CorpInfo.CorpStatus.OVER);
                corp.setVersion(CorpInfo.CorpVersion.FREE);
                corp.setEndTime(null);
            }

        }

        return page;
    }

    @Override
    @Transactional(readOnly = true)
    public CorpInfo checkCorpCode(String corpCode) {
        if (StringUtils.isBlank(corpCode)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        return getByFieldNameAndValue(CorpInfo._corpCode, corpCode, CorpInfo._id);
    }

    @Override
    @Transactional(readOnly = true)
    public CorpInfo checkDomainName(String domainName) {
        if (StringUtils.isBlank(domainName)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        return getByFieldNameAndValue(CorpInfo._domainName, domainName, CorpInfo._id);
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
    public void update(CorpInfo corpInfo) {
        if (corpInfo == null || StringUtils.isBlank(corpInfo.getId())
                || StringUtils.isBlank(corpInfo.getCorpName()) || StringUtils.isBlank(corpInfo.getDomainName())) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }


        CorpInfo dataCorpInfo = checkDomainName(corpInfo.getDomainName());
        if (dataCorpInfo != null && !dataCorpInfo.getId().equals(corpInfo.getId())) {
            throw new PeException("企业域名已经存在，请重新输入");
        }

        dataCorpInfo = get(corpInfo.getId(), CorpInfo._corpCode, CorpInfo._domainName, CorpInfo._corpStatus);
        if (CorpInfo.CorpStatus.ENABLE.equals(dataCorpInfo.getCorpStatus())) {
            PeRedisClient.getCommonJedis().del(RedisKey.CORP_INFO_DOMAIN + dataCorpInfo.getDomainName());
            PeRedisClient.getCommonJedis().del(RedisKey.CORP_INFO_CODE + dataCorpInfo.getCorpCode());
        }

        update(corpInfo, CorpInfo._corpName, CorpInfo._domainName, CorpInfo._endTime, CorpInfo._registerNum,
                CorpInfo._concurrentNum, CorpInfo._address, CorpInfo._contacts, CorpInfo._messageStatus, CorpInfo._contactsMobile,
                CorpInfo._comments, CorpInfo._email, CorpInfo._industry, CorpInfo._payApps, CorpInfo._fromAppType,CorpInfo._version);
        if (CorpInfo.CorpStatus.ENABLE.equals(dataCorpInfo.getCorpStatus())) {
            dataCorpInfo.setDomainName(corpInfo.getDomainName());
            dataCorpInfo.setEndTime(corpInfo.getEndTime());
            dataCorpInfo.setConcurrentNum(corpInfo.getConcurrentNum());
            dataCorpInfo.setRegisterNum(corpInfo.getRegisterNum());
            dataCorpInfo.setMessageStatus(corpInfo.getMessageStatus());
            dataCorpInfo.setPayApps(corpInfo.getPayApps());
            dataCorpInfo.setFromAppType(corpInfo.getFromAppType());
            storageRedis(dataCorpInfo);
        }
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
    public void enableCorp(String corpId) {
        if (StringUtils.isBlank(corpId)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        CorpInfo corpInfo = get(corpId, CorpInfo._corpCode, CorpInfo._domainName, CorpInfo._endTime,
                CorpInfo._concurrentNum, CorpInfo._registerNum, CorpInfo._corpStatus);
        if (corpInfo == null) {
            throw new IllegalArgumentException("CorpInfo is not existed!");
        }

        update(corpId, CorpInfo._corpStatus, CorpInfo.CorpStatus.ENABLE);
        if (CorpInfo.CorpStatus.DRAFT.equals(corpInfo.getCorpStatus())) {
            //    final String corpCode = ExecutionContext.getCorpCode();
            final String corpCode = corpInfo.getCorpCode();
            ExecutionContext.setCorpCode(corpInfo.getCorpCode());
            String roleId = initDataBase(corpInfo.getCorpCode());
            initUserInfo(corpCode, roleId);
            ExecutionContext.setCorpCode(corpCode);
        }

        storageRedis(corpInfo);
    }

    private void initUserInfo(String corpCode, String roleId) {
        //初始化部门
        Organize organize = new Organize();
        organize.setIdPath(PeConstant.STAR);
        organize.setShowOrder(NumberUtils.FLOAT_ONE);
        organize.setOrganizeName("全部");
        organize.setDefault(Boolean.TRUE);
        organize.setOrganizeStatus(Organize.OrganizeStatus.ENABLE);
        organize.setCorpCode(corpCode);
        baseService.save(organize);

        Organize childOrganize = new Organize();
        childOrganize.setParentId(organize.getId());
        childOrganize.setOrganizeName("其他");
        childOrganize.setDefault(Boolean.TRUE);
        childOrganize.setCorpCode(corpCode);
        organizeService.save(childOrganize);

        User user = new User();
        user.setLoginName(PeConstant.ADMIN);
        user.setUserName("系统管理员");
        user.setSexType(User.SexType.SECRECY);
        user.setRoleId(roleId);
        user.setCorpCode(corpCode);
        user.setOrganize(childOrganize);
        userService.save(user);
    }

    private String initDataBase(String corpCode) {
        //初始化类别信息
        List<Category> categories = new ArrayList<>(4);
        Category ibCategory = new Category();
        ibCategory.setCategoryType(Category.CategoryEnumType.ITEM_BANK);
        ibCategory.setCategoryName("全部");
        ibCategory.setCategoryStatus(Category.CategoryStatus.ENABLE);
        ibCategory.setDefault(Boolean.TRUE);
        ibCategory.setIdPath(PeConstant.STAR);
        ibCategory.setCorpCode(corpCode);
        ibCategory.setShowOrder(NumberUtils.FLOAT_ONE);
        categories.add(ibCategory);

        Category paperCategory = new Category();
        paperCategory.setCategoryType(Category.CategoryEnumType.PAPER);
        paperCategory.setCategoryName("全部");
        paperCategory.setCategoryStatus(Category.CategoryStatus.ENABLE);
        paperCategory.setDefault(Boolean.TRUE);
        paperCategory.setIdPath(PeConstant.STAR);
        paperCategory.setCorpCode(corpCode);
        paperCategory.setShowOrder(NumberUtils.FLOAT_ONE);
        categories.add(paperCategory);

        Category positionCategory = new Category();
        positionCategory.setCategoryType(Category.CategoryEnumType.POSITION);
        positionCategory.setCategoryName("全部");
        positionCategory.setCategoryStatus(Category.CategoryStatus.ENABLE);
        positionCategory.setDefault(Boolean.TRUE);
        positionCategory.setIdPath(PeConstant.STAR);
        positionCategory.setCorpCode(corpCode);
        positionCategory.setShowOrder(NumberUtils.FLOAT_ONE);
        categories.add(positionCategory);

        Category knowledgeCategory = new Category();
        knowledgeCategory.setCategoryType(Category.CategoryEnumType.KNOWLEDGE);
        knowledgeCategory.setCategoryName("全部");
        knowledgeCategory.setCategoryStatus(Category.CategoryStatus.ENABLE);
        knowledgeCategory.setDefault(Boolean.TRUE);
        knowledgeCategory.setIdPath(PeConstant.STAR);
        knowledgeCategory.setCorpCode(corpCode);
        knowledgeCategory.setShowOrder(NumberUtils.FLOAT_ONE);
        categories.add(knowledgeCategory);
        categoryService.batchSave(categories);

        Category category = new Category();
        category.setCategoryType(Category.CategoryEnumType.PAPER);
        category.setCategoryName("未分类");
        category.setCategoryStatus(Category.CategoryStatus.ENABLE);
        category.setDefault(Boolean.TRUE);
        category.setParentId(paperCategory.getId());
        category.setCorpCode(corpCode);
        categoryService.save(category);
        //初始化角色
        Role role = new Role();
        role.setCorpCode(corpCode);
        role.setComments("拥有系统所有功能权限的管理");
        role.setRoleName("系统管理员");
        role.setDefault(Boolean.TRUE);
        baseService.save(role);


        Authority authority = authorityService.get(PeConstant.DEFAULT_CORP_CODE, "ALL");
        RoleAuthority roleAuthority = new RoleAuthority();
        roleAuthority.setAuthority(authority);
        roleAuthority.setCorpCode(corpCode);
        roleAuthority.setRole(role);
        baseService.save(roleAuthority);
        return role.getId();
    }

    @Override
    public void storageRedis(CorpInfo corpInfo) {
        if (corpInfo == null || StringUtils.isBlank(corpInfo.getCorpCode())
                || StringUtils.isBlank(corpInfo.getDomainName())) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        PeJedisCommands commonJedis = PeRedisClient.getCommonJedis();
        commonJedis.setex(RedisKey.CORP_INFO_DOMAIN + corpInfo.getDomainName(), 30 * 60, corpInfo.getCorpCode());
        commonJedis.setex(RedisKey.CORP_INFO_CODE + corpInfo.getCorpCode(), 30 * 60, JSON.toJSONString(corpInfo));
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
    public String storeElnToRedis(String corpCode, String loginName) {
        if (StringUtils.isBlank(corpCode) || StringUtils.isBlank(loginName)) {
            throw new IllegalArgumentException("Parameters are not valid!");
        }
        CorpInfo corpInfo = getByCode(corpCode);
        if (corpInfo == null || !CorpInfo.CorpStatus.ENABLE.equals(corpInfo.getCorpStatus())) {
            throw new IllegalArgumentException("CorpInfo is null or corpStatus is not avaliable!");
        }
        Conjunction conjunction = Restrictions.conjunction();
        conjunction.add(Restrictions.eq(User._corpCode, corpCode));
        conjunction.add(Restrictions.eq(User._loginName, loginName));
        conjunction.add(Restrictions.eq(User._status, User.UserStatus.ENABLE));
        User user = userService.getByCriterion(conjunction);
        if (user == null) {
            throw new IllegalArgumentException("user is not avaliable!");
        }

        PeJedisCommands commonJedis = PeRedisClient.getCommonJedis();
        String redisKey = UUIDGenerator.uuid();
        commonJedis.setex(redisKey, 60 * 5, user.getCorpCode() + PeConstant.REDIS_DIVISION + user.getId());
        return redisKey;

    }

    @Override
    @Transactional(readOnly = true)
    public CorpInfo getByDomain(String domain) {
        if (StringUtils.isBlank(domain)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        PeJedisCommands commonJedis = PeRedisClient.getCommonJedis();
        String corpCode = commonJedis.get(RedisKey.CORP_INFO_DOMAIN + domain);
        if (StringUtils.isNotBlank(corpCode)) {
            String infoString = commonJedis.get(RedisKey.CORP_INFO_CODE + corpCode);
            if (StringUtils.isNotBlank(infoString)) {
                CorpInfo corpInfo = JSON.parseObject(infoString, CorpInfo.class);
                if (corpInfo.getEndTime() != null && new Date().after(corpInfo.getEndTime())) {
                    commonJedis.del(RedisKey.CORP_INFO_DOMAIN + domain);
                    commonJedis.del(RedisKey.CORP_INFO_CODE + corpCode);
                     corpInfo.setVersion(CorpInfo.CorpVersion.FREE);
                     corpInfo.setEndTime(null);
                     corpService.update(corpInfo);
                }

                return corpInfo;
            }

            commonJedis.del(RedisKey.CORP_INFO_DOMAIN + domain);
        }

        Conjunction conjunction = Restrictions.conjunction();
        conjunction.add(Restrictions.eq(CorpInfo._domainName, domain));
        conjunction.add(Restrictions.eq(CorpInfo._corpStatus, CorpInfo.CorpStatus.ENABLE));
        CorpInfo corpInfo = getByCriterion(conjunction, CorpInfo._corpCode, CorpInfo._domainName,
                CorpInfo._endTime, CorpInfo._concurrentNum, CorpInfo._registerNum,CorpInfo._version);
        if (corpInfo == null) {
            return null;
        }

        if (corpInfo.getEndTime() == null || new Date().before(corpInfo.getEndTime())) {
            storageRedis(corpInfo);
        }

        return corpInfo;
    }

    @Override
    @Transactional(readOnly = true)
    public CorpInfo getByCode(String corpCode) {
        if (StringUtils.isBlank(corpCode)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

//        PeJedisCommands commonJedis = PeRedisClient.getCommonJedis();
//        String infoString = commonJedis.get(RedisKey.CORP_INFO_CODE + corpCode);
//        if (StringUtils.isNotBlank(infoString)) {
//            CorpInfo corpInfo = JSON.parseObject(infoString, CorpInfo.class);
//            if (corpInfo.getEndTime() != null && new Date().after(corpInfo.getEndTime())) {
//                commonJedis.del(RedisKey.CORP_INFO_DOMAIN + corpInfo.getDomainName());
//                commonJedis.del(RedisKey.CORP_INFO_CODE + corpCode);
//            }
//
//            return corpInfo;
//        }

        Conjunction conjunction = Restrictions.conjunction();
        conjunction.add(Restrictions.eq(CorpInfo._corpCode, corpCode));
        conjunction.add(Restrictions.eq(CorpInfo._corpStatus, CorpInfo.CorpStatus.ENABLE));
        CorpInfo corpInfo = getByCriterion(conjunction);
        if (corpInfo == null) {
            return null;
        }

//        if (corpInfo.getEndTime() == null || new Date().before(corpInfo.getEndTime())) {
//            storageRedis(corpInfo);
//        }

        return corpInfo;
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public void disableCorp(String corpId) {
        if (StringUtils.isBlank(corpId)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        CorpInfo corpInfo = get(corpId, CorpInfo._corpCode, CorpInfo._domainName, CorpInfo._corpStatus);
        if (CorpInfo.CorpStatus.ENABLE.equals(corpInfo.getCorpStatus())) {
            PeRedisClient.getCommonJedis().del(RedisKey.CORP_INFO_DOMAIN + corpInfo.getDomainName());
            PeRedisClient.getCommonJedis().del(RedisKey.CORP_INFO_CODE + corpInfo.getCorpCode());
        }

        update(corpId, CorpInfo._corpStatus, CorpInfo.CorpStatus.DISABLE);
    }

    @Override
    @Transactional(readOnly = true)
    public Boolean checkMessage() {
        if (StringUtils.isBlank(ExecutionContext.getCorpCode())) {
            throw new IllegalArgumentException("The parameter is not valid!");
        }

        CorpInfo corpInfo = getByCode(ExecutionContext.getCorpCode());
        if (corpInfo.getMessageStatus() == null || CorpInfo.MessageStatus.CLOSE.equals(corpInfo.getMessageStatus())) {
            return false;
        }

        return CorpInfo.MessageStatus.OPEN.equals(corpInfo.getMessageStatus());

    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public String autoOpenCorp(CorpInfo corpInfo) {
        save(corpInfo);
        enableCorp(corpInfo.getId());
        return corpInfo.getId();
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
    public String openCorpForElp(CorpInfo corpInfo) {
        if (corpInfo == null || StringUtils.isBlank(corpInfo.getId())) {
            throw new IllegalArgumentException("Parameters are not valid!");
        }

        CorpInfo dbCorpInfo = get(corpInfo.getId());
        if (dbCorpInfo == null) {
            throw new IllegalArgumentException("CorpInfo doesn't exist!");
        }

        ExecutionContext.setUserId(PeConstant.ADMIN);
        ExecutionContext.setCorpCode(dbCorpInfo.getCorpCode());
        initDataBase(dbCorpInfo.getCorpCode());
        userService.syncUserForElp(dbCorpInfo.getCorpCode());
        update(dbCorpInfo.getId(), CorpInfo._corpStatus, CorpInfo.CorpStatus.ENABLE);
        dbCorpInfo.setCorpStatus(CorpInfo.CorpStatus.ENABLE);
        storageRedis(dbCorpInfo);
        return corpInfo.getId();

    }
}
