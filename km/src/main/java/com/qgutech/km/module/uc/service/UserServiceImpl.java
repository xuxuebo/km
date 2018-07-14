package com.qgutech.km.module.uc.service;

import com.alibaba.fastjson.JSON;
import com.qgutech.km.base.model.Category;
import com.qgutech.km.base.service.*;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.im.service.MsgSendService;
import com.qgutech.km.module.km.model.Library;
import com.qgutech.km.module.km.service.LibraryService;
import com.qgutech.km.module.sfm.service.FileServerService;
import com.qgutech.km.module.uc.model.*;
import com.qgutech.km.utils.*;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.CorpInfo;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.module.im.domain.ImReceiver;
import com.qgutech.km.module.im.domain.ImTemplate;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.*;
import org.hibernate.sql.JoinType;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

/**
 * user service impl
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月17日13:01:44
 */
@Service("userService")
public class UserServiceImpl extends BaseServiceImpl<User> implements UserService {

    @Resource
    private UserPositionService userPositionService;
    @Resource
    private UserRedisService userRedisService;
    @Resource
    private OrganizeService organizeService;
    @Resource
    private I18nService i18nService;
    @Resource
    private UserRoleService userRoleService;
    @Resource
    private SessionService sessionService;
    @Resource
    private UserService userService;
    @Resource
    private ThreadPoolTaskExecutor taskExecutor;
    @Resource
    private CorpService corpService;
    @Resource
    private RoleService roleService;
    @Resource
    private FileServerService fileServerService;
    @Resource
    private PositionService positionService;
    @Resource
    private CategoryService categoryService;
    @Resource
    private LibraryService libraryService;

    @Override
    @Transactional(readOnly = true)
    public List<String> listUserId(String keyword) {
        if (StringUtils.isBlank(keyword)) {
            throw new PeException("UserName is blank!");
        }

        Conjunction conjunction = Restrictions.conjunction();
        conjunction.add(Restrictions.eq(User._roleType, User.RoleType.ADMIN));
        conjunction.add(Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()));
        Disjunction disjunction = Restrictions.disjunction();
        disjunction.add(Restrictions.like(User._userName, keyword, MatchMode.ANYWHERE));
        disjunction.add(Restrictions.like(User._loginName, keyword, MatchMode.ANYWHERE));
        disjunction.add(Restrictions.like(User._employeeCode, keyword, MatchMode.ANYWHERE));
        disjunction.add(Restrictions.like(User._mobile, keyword, MatchMode.ANYWHERE));
        conjunction.add(disjunction);
        conjunction.add(Restrictions.ne(User._status, User.UserStatus.DELETED));
        return listFieldValueByCriterion(conjunction, User.ID);
    }


    @Override
    @Transactional(readOnly = true)
    public List<String> listUserId(String keyword, User.RoleType roleType) {
        Assert.hasText(keyword, "Keyword can not be empty when listUserIdByKey");
        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()));
        Disjunction disjunction = Restrictions.disjunction();
        disjunction.add(Restrictions.like(User._userName, keyword, MatchMode.ANYWHERE));
        disjunction.add(Restrictions.like(User._loginName, keyword, MatchMode.ANYWHERE));
        disjunction.add(Restrictions.eq(User._employeeCode, keyword));
        disjunction.add(Restrictions.eq(User._mobile, keyword));
        conjunction.add(disjunction);
        if (roleType != null) {
            conjunction.add(Restrictions.eq(User._roleType, roleType));
        }

        conjunction.add(Restrictions.ne(User._status, User.UserStatus.DELETED));
        return listFieldValueByCriterion(conjunction, User.ID);
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, User> find(List<String> userIds) {
        if (CollectionUtils.isEmpty(userIds)) {
            throw new PeException("UserId list is empty!");
        }

        Criterion criterion = Restrictions.and(
                Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.in(User.ID, userIds));
        List<User> users = listByCriterion(criterion);
        if (CollectionUtils.isEmpty(users)) {
            return new HashMap<>(0);
        }

        Map<String, User> userMap = new HashMap<>(users.size());
        for (User user : users) {
            userMap.put(user.getId(), user);
        }

        return userMap;
    }

    @Override
    @Transactional(readOnly = true)
    public Page<User> search(User user, PageParam pageParam) {
        PeUtils.validPage(pageParam);
        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()));
        if (user == null) {
            Page<User> page = search(pageParam, conjunction, Order.desc(User.CREATE_TIME));
            packageUser(page.getRows());
            return page;
        }

        conjunction.add(Restrictions.ne(User._loginName, PeConstant.ADMIN));
        if (StringUtils.isNotBlank(user.getKeyword())) {
            conjunction.add(Restrictions.or(
                    Restrictions.like(User._userName, user.getKeyword().trim(), MatchMode.ANYWHERE),
                    Restrictions.like(User._loginName, user.getKeyword().trim(), MatchMode.ANYWHERE),
                    Restrictions.like(User._employeeCode, user.getKeyword().trim(), MatchMode.ANYWHERE),
                    Restrictions.like(User._mobile, user.getKeyword().trim(), MatchMode.ANYWHERE)));
        }

        if (user.getOrganize() != null && StringUtils.isNotBlank(user.getOrganize().getId())) {
            //是否查询子类别
            List<String> organizeIds = new ArrayList<>();
            organizeIds.add(user.getOrganize().getId());
            if (user.getOrganize().isInclude()) {
                List<String> childOrganizeIds = organizeService.listOrganizeId(user.getOrganize().getId());
                if (CollectionUtils.isNotEmpty(childOrganizeIds)) {
                    organizeIds.addAll(childOrganizeIds);
                }
            }

            conjunction.add(Restrictions.in(User._organize, organizeIds));
        }

        //用户状态查询
        if (CollectionUtils.isNotEmpty(user.getUserStatusList())) {
            conjunction.add(Restrictions.in(User._status, user.getUserStatusList()));
        } else {
            conjunction.add(Restrictions.in(User._status, new Object[]{User.UserStatus.ENABLE, User.UserStatus.FORBIDDEN}));
        }

        if (user.getSexType() != null) {
            conjunction.add(Restrictions.eq(User._sexType, user.getSexType()));
        }

        if (StringUtils.isNotBlank(user.getUserName())) {
            conjunction.add(Restrictions.like(User._userName, user.getUserName().trim(), MatchMode.ANYWHERE));
        }

        if (StringUtils.isNotBlank(user.getLoginName())) {
            conjunction.add(Restrictions.like(User._loginName, user.getLoginName().trim(), MatchMode.ANYWHERE));
        }

        if (StringUtils.isNotBlank(user.getEmployeeCode())) {
            conjunction.add(Restrictions.like(User._employeeCode, user.getEmployeeCode().trim(), MatchMode.ANYWHERE));
        }

        if (StringUtils.isNotBlank(user.getIdCard())) {
            conjunction.add(Restrictions.like(User._idCard, user.getIdCard().trim(), MatchMode.ANYWHERE));
        }

        if (StringUtils.isNotBlank(user.getMobile())) {
            conjunction.add(Restrictions.like(User._mobile, user.getMobile().trim(), MatchMode.ANYWHERE));
        }

        if (StringUtils.isNotBlank(user.getEmail())) {
            conjunction.add(Restrictions.like(User._email, user.getEmail().trim(), MatchMode.ANYWHERE));
        }

        if (user.getEntryTime() != null) {
            conjunction.add(Restrictions.eq(User._entryTime, user.getEntryTime()));
        }

        Condition condition = criteria -> {
            criteria.add(conjunction);
            if (StringUtils.isNotBlank(user.getRoleId())) {
                criteria.createAlias(User._userRoleAlias, User._userRoleAlias);
                String userRoleAlias = User._userRoleAlias + PeConstant.POINT;
                criteria.add(Restrictions.eq(userRoleAlias + UserRole._role, user.getRoleId()));
            }

            if (StringUtils.isNotBlank(user.getPositionId())) {
                criteria.createAlias(User._userPositionAlias, User._userPositionAlias);
                String userPositionAlias = User._userPositionAlias + PeConstant.POINT;
                criteria.add(Restrictions.eq(userPositionAlias + UserPosition._position, user.getPositionId()));
            }

        };

        Page<User> page = search(pageParam, condition, Order.desc(User.CREATE_TIME));
        packageUser(page.getRows());
        return page;
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> list(User user, List<String> userIds) {
        if (CollectionUtils.isEmpty(userIds)) {
            throw new IllegalArgumentException("UserId list is empty!");
        }

        Conjunction conjunction = Restrictions.conjunction();
        conjunction.add(Restrictions.in(User.ID, userIds));
        if (user == null) {
            return listByCriterion(conjunction, User.ID);
        }

        if (StringUtils.isNotBlank(user.getKeyword())) {
            Disjunction disjunction = Restrictions.disjunction();
            disjunction.add(Restrictions.like(User._userName, user.getKeyword().trim(), MatchMode.ANYWHERE));
            disjunction.add(Restrictions.like(User._loginName, user.getKeyword().trim(), MatchMode.ANYWHERE));
            disjunction.add(Restrictions.like(User._mobile, user.getKeyword().trim(), MatchMode.ANYWHERE));
            disjunction.add(Restrictions.like(User._employeeCode, user.getKeyword().trim(), MatchMode.ANYWHERE));
            conjunction.add(disjunction);
        }

        if (user.getOrganize() != null && StringUtils.isNotBlank(user.getOrganize().getId())) {
            conjunction.add(Restrictions.eq(User._organize, user.getOrganize().getId()));
        }

        Criteria criteria = createCriteria();
        criteria.add(conjunction);
        if (StringUtils.isNotBlank(user.getPositionId())) {
            criteria.createAlias(User._userPositionAlias, User._userPositionAlias);
            String userPositionAlias = User._userPositionAlias + PeConstant.POINT;
            criteria.add(Restrictions.eq(userPositionAlias + UserPosition._position, user.getPositionId()));
        }

        if (CollectionUtils.isNotEmpty(user.getUserStatusList())) {
            criteria.add(Restrictions.in(User._status, user.getUserStatusList()));
        }

        return listByCriteria(criteria, User.ID);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<User> list(List<String> userIds) {
        if (CollectionUtils.isEmpty(userIds)) {
            throw new PeException("userIds is empty");
        }

        Conjunction conjunction = Restrictions.conjunction();
        conjunction.add(Restrictions.in(User.ID, userIds));
        conjunction.add(Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()));
        List<User> users = listByCriterion(conjunction);
        if (CollectionUtils.isEmpty(users)) {
            return new ArrayList<>(0);
        }
        Map<String, Organize> organizeMap = organizeService.findAll();
        if (MapUtils.isNotEmpty(organizeMap)) {
            for (User user : users) {
                if (user.getOrganize() != null) {
                    Organize organize = organizeMap.get(user.getOrganize().getId());
                    user.setOrganizeName(organize.getOrganizeName());
                }
            }
        }

        return users;
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<User> getAllUser() {
        Conjunction conjunction = Restrictions.conjunction();
        conjunction.add(Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()));
        conjunction.add(Restrictions.ne(User._status, User.UserStatus.DELETED));
        List<User> users = listByCriterion(conjunction);
        Map<String, Organize> organizeMap = organizeService.findAll();
        if (MapUtils.isNotEmpty(organizeMap)) {
            for (User user : users) {
                if (user.getOrganize() != null) {
                    Organize organize = organizeMap.get(user.getOrganize().getId());
                    user.setOrganizeName(organize.getOrganizeName());
                }
            }
        }
        return users;
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int updateStatus(List<String> userIds, User.UserStatus userStatus) {
        if (CollectionUtils.isEmpty(userIds) || userStatus == null) {
            throw new PeException("UserId list is empty or userStatus is null!");
        }

        update(userIds, User._status, userStatus);
        if (User.UserStatus.DELETED.equals(userStatus) || User.UserStatus.FORBIDDEN.equals(userStatus)) {
            userRedisService.remove(userIds);
            return userIds.size();
        }

        List<User> users = listByIds(userIds, User.ID, User._mobile, User._email, User._employeeCode, User._loginName,
                User._faceFileId, User._idCard, User._userName, User._organize, User._organizeName, User._faceFileName,
                User._status, User._password, User._roleType);
        if (CollectionUtils.isEmpty(users)) {
            return userIds.size();
        }

        List<String> faceIds = users.stream().filter(user -> StringUtils.isNotBlank(user.getFaceFileId())).
                map(User::getFaceFileId).collect(Collectors.toList());
        if (CollectionUtils.isEmpty(faceIds)) {
            userRedisService.save(users);
            return userIds.size();
        }

        Map<String, String> faceMap = fileServerService.findFilePath(faceIds);
        if (MapUtils.isEmpty(faceMap)) {
            userRedisService.save(users);
            return userIds.size();
        }

        users.stream().filter(user -> StringUtils.isNotBlank(user.getFaceFileId()) && faceMap.containsKey(user.getFaceFileId())).forEach(user -> {
            String facePath = faceMap.get(user.getFaceFileId());
            facePath = StringUtils.substringBeforeLast(facePath, PeConstant.BACKSLASH) + PeConstant.BACKSLASH + user.getFaceFileName();
            user.setFacePath(facePath);
        });

        userRedisService.save(users);
        return userIds.size();
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int updatePwd(List<String> userIds, String newPwd) {
        if (CollectionUtils.isEmpty(userIds) || StringUtils.isBlank(newPwd)) {
            throw new PeException("UserId list is empty or newPwd is blank!");
        }

        newPwd = MD5Generator.getHexMD5(newPwd);
        update(userIds, User._password, newPwd);
        userRedisService.updatePwd(userIds, newPwd);
        return userIds.size();
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int updateOrganize(List<String> userIds, String organizeId) {
        if (CollectionUtils.isEmpty(userIds) || StringUtils.isBlank(organizeId)) {
            throw new IllegalArgumentException("UserId list is empty or organizeId is blank!");
        }

        update(userIds, User._organize, organizeId);
        Organize organize = organizeService.get(organizeId, Organize.ID, Organize._organizeName);
        userRedisService.updateOrganize(userIds, organize);
        return userIds.size();
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int updatePosition(List<String> userIds, List<String> positionIds) {
        if (CollectionUtils.isEmpty(userIds) || CollectionUtils.isEmpty(positionIds)) {
            throw new PeException("UserId list or positionId list is empty!");
        }

        userPositionService.deleteByUserId(userIds);
        List<UserPosition> userPositions = new ArrayList<>(userIds.size() * positionIds.size());
        for (String userId : userIds) {
            User user = new User();
            user.setId(userId);
            for (String positionId : positionIds) {
                UserPosition userPosition = new UserPosition();
                userPosition.setUser(user);
                Position position = new Position();
                position.setId(positionId);
                userPosition.setPosition(position);
                userPositions.add(userPosition);
            }
        }

        userPositionService.batchSave(userPositions);
        return userPositions.size();
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int updateRole(String userId, List<String> roleIds) {
        if (StringUtils.isBlank(userId) || CollectionUtils.isEmpty(roleIds)) {
            throw new PeException("UserId is blank or roleId list is empty!");
        }

        userRoleService.deleteByUserId(userId);
        List<UserRole> userRoles = new ArrayList<>(roleIds.size());
        User user = new User();
        user.setId(userId);
        for (String roleId : roleIds) {
            UserRole userRole = new UserRole();
            userRole.setUser(user);
            Role role = new Role();
            role.setId(roleId);
            userRole.setRole(role);
            userRoles.add(userRole);
        }

        userRoleService.batchSave(userRoles);
        return userRoles.size();
    }

    private void packageUser(List<User> users) {
        if (CollectionUtils.isEmpty(users)) {
            return;
        }

        List<String> userIds = new ArrayList<>(users.size());
        List<String> organizeIds = new ArrayList<>(users.size());
        for (User user : users) {
            userIds.add(user.getId());
            if (user.getOrganize() != null) {
                organizeIds.add(user.getOrganize().getId());
            }

            if (user.getId().equals(ExecutionContext.getUserId())) {
                user.setDisableDelete(true);
            }
        }

        Map<String, Organize> organizeMap = organizeService.find(organizeIds);
        if (MapUtils.isNotEmpty(organizeMap)) {
            for (User user : users) {
                if (user.getOrganize() != null) {
                    Organize organize = organizeMap.get(user.getOrganize().getId());
                    user.setOrganizeName(organize.getOrganizeName());
                }
            }
        }

        Map<String, List<Position>> positionMap = userPositionService.findByUserId(userIds);
        if (MapUtils.isEmpty(positionMap)) {
            return;
        }

        setPositionName(users, positionMap);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean checkOrganizeUser(String organizeId) {
        if (StringUtils.isBlank(organizeId)) {
            throw new PeException("OrganizeId is null!");
        }

        List<String> organizeIds = organizeService.listOrganizeId(organizeId);
        if (CollectionUtils.isEmpty(organizeIds)) {
            throw new PeException("OrganizeIds is null!");
        }

        Criterion criterion = Restrictions.and(
                Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.in(User._organize, organizeIds),
                Restrictions.ne(User._status, User.UserStatus.DELETED)
        );

        return exist(criterion);
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public String save(User user) {
        checkUser(user);
        CorpInfo corpInfo = corpService.getByCode(ExecutionContext.getCorpCode());
        if (corpInfo == null) {
            throw new IllegalArgumentException("Corp info is not existed!");
        }

        if (corpInfo.getRegisterNum() > 0) {
            Long count = getRegisterNum();
            if (PeNumberUtils.transformLong(count) >= corpInfo.getRegisterNum()) {
                throw new PeException("注册人数已经达到上线");
            }
        }

        String password = user.getPassword();
        if (StringUtils.isBlank(password)) {
            password = PropertiesUtils.getConfigProp().getProperty("default.user.password");
        }

        if (user.getOrganize() == null || StringUtils.isBlank(user.getOrganize().getId())) {
            Organize organize = organizeService.getDefault();
            user.setOrganize(organize);
        }

        if (StringUtils.isNotBlank(user.getEmail())) {
            user.setEmailVerify(true);
        }

        if (StringUtils.isNotBlank(user.getMobile())) {
            user.setMobileVerify(true);
        }

        Organize organize = organizeService.get(user.getOrganize().getId(), Organize.ID, Organize._organizeName);
        user.setOrganize(organize);
        user.setPassword(MD5Generator.getHexMD5(password));
        user.setStatus(User.UserStatus.ENABLE);
        if (StringUtils.isNotBlank(user.getRoleId())) {
            user.setRoleType(User.RoleType.ADMIN);
            super.save(user);
            List<String> roleIds = new ArrayList<>();
            CollectionUtils.addAll(roleIds, user.getRoleId().split(PeConstant.COMMA));
            updateRole(user.getId(), roleIds);
        } else {
            user.setRoleType(User.RoleType.USER);
            super.save(user);
        }

        userRedisService.save(user);
        final String expressPwd = password;
        final Map<String, String> contextMap = ExecutionContext.getContextMap();
        taskExecutor.submit(() -> {
            ExecutionContext.setContextMap(contextMap);


        });

        if (StringUtils.isBlank(user.getPositionId())) {
            return user.getId();
        }

        List<String> positionIds = new ArrayList<>();
        CollectionUtils.addAll(positionIds, user.getPositionId().split(PeConstant.COMMA));
        updatePosition(Collections.singletonList(user.getId()), positionIds);
        return user.getId();
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public List<String> save(List<User> users) {
        if (CollectionUtils.isEmpty(users)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        for (User user : users) {
            checkUser(user);
            String password = user.getPassword();
            if (StringUtils.isBlank(password)) {
                password = PropertiesUtils.getConfigProp().getProperty("default.user.password");
            }

            user.setSourcePwd(password);
            user.setPassword(MD5Generator.getHexMD5(password));
            user.setStatus(User.UserStatus.ENABLE);
            if (StringUtils.isNotBlank(user.getEmail())) {
                user.setEmailVerify(true);
            }

            if (StringUtils.isNotBlank(user.getMobile())) {
                user.setMobileVerify(true);
            }

            if (user.getOrganize() == null || StringUtils.isBlank(user.getOrganize().getId())) {
                Organize organize = organizeService.getDefault();
                user.setOrganize(organize);
            }

            if (null == user.getRoleType()) {
                user.setRoleType(User.RoleType.USER);
            }
        }

        CorpInfo corpInfo = corpService.getByCode(ExecutionContext.getCorpCode());
        if (corpInfo == null) {
            throw new IllegalArgumentException("Corp info is not existed!");
        }

        if (corpInfo.getRegisterNum() > 0) {
            Long count = getRegisterNum();
            if ((PeNumberUtils.transformLong(count) + users.size()) >= corpInfo.getRegisterNum()) {
                throw new PeException("注册人数已经达到上线");
            }
        }

        super.batchSave(users);
        List<UserPosition> userPositions = new ArrayList<>();
        for (User user : users) {
            if (StringUtils.isBlank(user.getPositionId())) {
                continue;
            }

            UserPosition userPosition = new UserPosition();
            userPosition.setUser(user);
            Position position = new Position();
            position.setId(user.getPositionId());
            userPosition.setPosition(position);
            userPositions.add(userPosition);
        }

        if (CollectionUtils.isNotEmpty(userPositions)) {
            userPositionService.batchSave(userPositions);
        }

        userRedisService.save(users);
        final Map<String, String> contextMap = ExecutionContext.getContextMap();
        taskExecutor.submit((Runnable) () -> {
            ExecutionContext.setContextMap(contextMap);
          
        });

        return users.stream().map(User::getId).collect(Collectors.toList());
    }

    private void saveUserSendMsg(User user, String password, Map<String, Boolean> messageMap, Boolean smsSetting) {
        String msgTem = ImTemplate.NEW_BUILT_USER;
        Map<String, Object> mapData = new HashMap<>(3);
        mapData.put("LOGIN_NAME", user.getLoginName());
        mapData.put("PASSWORD", password);
        mapData.put("LINK", PeConstant.HTTP_PREFIX + ExecutionContext.getServerName());
        if (StringUtils.isNotBlank(user.getEmail()) && BooleanUtils.isTrue(messageMap.get("S"))) {
            MsgSendService.sendEmailMsg(msgTem, i18nService.getI18nValue("new.built.user"),
                    Collections.singletonList(new ImReceiver(user.getEmail(), user.getLoginName())), mapData, true);
        }

        if (StringUtils.isNotBlank(user.getMobile()) && BooleanUtils.isTrue(messageMap.get("E")) && smsSetting) {
            msgTem = ImTemplate.New_BUIlT_USER_MOBILE;
            MsgSendService.sendSmsMsg(msgTem, Collections.singletonList(user.getMobile()), mapData, true);
        }

        if (messageMap.get("M") != null) {
            MsgSendService.sendMessageMsg(msgTem, user.getId(), mapData);
        }

    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int update(User user) {
        checkUser(user);
        if (StringUtils.isBlank(user.getId())) {
            throw new PeException("User parameter is illegal!");
        }

        packageSystemRole(user);
        if (StringUtils.isNotBlank(user.getRoleId())) {
            user.setRoleType(User.RoleType.ADMIN);
            List<String> roleIds = new ArrayList<>();
            CollectionUtils.addAll(roleIds, user.getRoleId().split(PeConstant.COMMA));
            updateRole(user.getId(), roleIds);
        } else {
            userRoleService.deleteByUserId(user.getId());
            user.setRoleType(User.RoleType.USER);
        }

        update(user, User._userName, User._loginName, User._employeeCode, User._mobile, User._email, User._faceFileName,
                User._organize, User._idCard, User._sexType, User._address, User._faceFileId, User._roleType, User._entryTime);
        if (user.getOrganize() != null && StringUtils.isNotBlank(user.getOrganize().getId())) {
            Organize organize = organizeService.get(user.getOrganize().getId(), Organize.ID, Organize._organizeName);
            user.setOrganize(organize);
        }

        userRedisService.save(get(user.getId()));
        if (StringUtils.isBlank(user.getPositionId())) {
            userPositionService.deleteByUserId(Collections.singletonList(user.getId()));
            return NumberUtils.INTEGER_ONE;
        }

        List<String> positionIds = new ArrayList<>();
        CollectionUtils.addAll(positionIds, user.getPositionId().split(PeConstant.COMMA));
        updatePosition(Collections.singletonList(user.getId()), positionIds);
        return NumberUtils.INTEGER_ONE;
    }

    private void packageSystemRole(User user) {
        if (SessionContext.get().isSuperAdmin()) {
            return;
        }

        String systemRoleId = roleService.getSystemId();
        List<Role> roles = userRoleService.listByUserId(user.getId());
        if (CollectionUtils.isEmpty(roles)) {
            return;
        }

        for (Role role : roles) {
            if (role.getId().equals(systemRoleId)) {
                if (StringUtils.isNotBlank(user.getRoleId())) {
                    user.setRoleId(user.getRoleId() + PeConstant.COMMA + systemRoleId);
                } else {
                    user.setRoleId(systemRoleId);
                }

                break;
            }
        }
    }

    @Override
    @Transactional(readOnly = true)
    public User getByMobile(String mobile) {
        if (StringUtils.isBlank(mobile)) {
            throw new PeException("Mobile is blank!");
        }

        return getByCriterion(Restrictions.and(
                Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(User._mobile, mobile.trim()),
                Restrictions.ne(User._status, User.UserStatus.DELETED)), User.ID);
    }

    @Override
    @Transactional(readOnly = true)
    public User getByEmail(String email) {
        if (StringUtils.isBlank(email)) {
            throw new PeException("Email is blank!");
        }

        return getByCriterion(Restrictions.and(
                Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(User._email, email.trim()),
                Restrictions.ne(User._status, User.UserStatus.DELETED)), User.UPDATE_BY, User._emailVerify, User.ID, User._status);
    }

    @Override
    @Transactional(readOnly = true)
    public User getByLoginName(String loginName) {
        if (StringUtils.isBlank(loginName)) {
            throw new PeException("LoginName is blank!");
        }

        return getByCriterion(Restrictions.and(
                Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(User._loginName, loginName.trim()),
                Restrictions.ne(User._status, User.UserStatus.DELETED)), User.ID);
    }

    @Override
    @Transactional(readOnly = true)
    public User getByIdCard(String idCard) {
        if (StringUtils.isBlank(idCard)) {
            throw new PeException("IdCard is blank!");
        }

        return getByCriterion(Restrictions.and(
                Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(User._idCard, idCard.trim()),
                Restrictions.ne(User._status, User.UserStatus.DELETED)), User.ID);
    }

    @Override
    @Transactional(readOnly = true)
    public User get(String userId) {
        if (StringUtils.isBlank(userId)) {
            throw new PeException("UserId is blank!");
        }

        User user = get(userId, User.ID, User._employeeCode, User._mobile, User._loginName, User._entryTime,
                User._email, User._userName, User._password, User._faceFileId, User._password, User._faceFileName,
                User._idCard, User._organize, User._organizeName, User._status, User._roleType, User._sexType, User._address);
        if (user == null) {
            throw new PeException("User is not existed!");
        }

        List<Role> roles = userRoleService.listByUserId(userId);
        user.setRoles(roles);
        List<Position> positions = userPositionService.listByUserId(userId);
        user.setPositions(positions);
        if (user.getOrganize() != null && StringUtils.isNotBlank(user.getOrganize().getId())) {
            Organize organize = organizeService.get(user.getOrganize().getId(), Organize.ID, Organize._organizeName);
            user.setOrganize(organize);
        }

        if (StringUtils.isBlank(user.getFaceFileId())) {
            return user;
        }

        String facePath = getFacePath(user.getFaceFileId(), user.getFaceFileName());
        user.setFacePath(facePath);
        return user;
    }

    @Override
    @Transactional(readOnly = true)
    public User getByAccount(String account) {
        if (StringUtils.isBlank(account)) {
            throw new IllegalArgumentException("Account is null!");
        }

        Criterion criterion = Restrictions.and(
                Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.or(
                        Restrictions.eq(User._loginName, account),
                        Restrictions.eq(User._email, account),
                        Restrictions.eq(User._mobile, account)),
                Restrictions.ne(User._status, User.UserStatus.DELETED));
        User user = getByCriterion(criterion, User.ID, User._employeeCode, User._mobile, User._loginName,
                User._email, User._userName, User._password, User._faceFileId, User._faceFileName,
                User._idCard, User._organize, User._organizeName, User._status, User._roleType);
        if (user == null || StringUtils.isBlank(user.getFaceFileId())) {
            return user;
        }

        String facePath = getFacePath(user.getFaceFileId(), user.getFaceFileName());
        user.setFacePath(facePath);
        return user;
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, User> findUserInfo(List<String> userIds) {
        if (CollectionUtils.isEmpty(userIds)) {
            throw new IllegalArgumentException("UserIds is empty!");
        }

        List<User> users = listByIds(userIds, User.ID, User._userName, User._mobile, User._loginName, User._employeeCode,
                User._email, User._status, User._organizeAlias + PeConstant.POINT + Organize._organizeName);
        if (CollectionUtils.isEmpty(users)) {
            return new HashMap<>(0);
        }

        Map<String, List<Position>> userPositionMap = userPositionService.findByUserId(userIds);
        if (MapUtils.isNotEmpty(userPositionMap)) {
            setPositionName(users, userPositionMap);
        }

        Map<String, User> usersMap = new HashMap<>(userIds.size());
        for (User user : users) {
            usersMap.put(user.getId(), user);
        }

        return usersMap;
    }


    @Override
    @Transactional(readOnly = true)
    public Page<User> searchWaitUserByRoleId(String roleId, User user, PageParam pageParam) {
        Assert.hasText(roleId, "roleId can not be empty when searchWaitUserByRoleId");
        if (user == null || user.getOrganize() == null || StringUtils.isBlank(user.getOrganize().getId())) {
            throw new PeException("organizeId can not be empty");
        }

        String userRoleAlisa = User._userRoleAlias + PeConstant.POINT;
        return search(pageParam, criteria -> {
            //包含子类别
            List<String> organizeIds = new ArrayList<>();
            organizeIds.add(user.getOrganize().getId());
            if (user.getOrganize().isInclude()) {
                List<String> listOrganizeId = organizeService.listOrganizeId(user.getOrganize().getId());
                if (CollectionUtils.isNotEmpty(listOrganizeId)) {
                    organizeIds.addAll(listOrganizeId);
                }
            }

            criteria.createAlias(User._userRoleAlias, User._userRoleAlias, JoinType.LEFT_OUTER_JOIN,
                    Restrictions.conjunction()
                            .add(Restrictions.eq(userRoleAlisa + UserRole._role, roleId)))
                    .add(Restrictions.in(User._organize, organizeIds))
                    .add(Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()))
                    .add(Restrictions.eq(User._status, User.UserStatus.ENABLE))
                    .add(Restrictions.isNull(userRoleAlisa + UserRole.CORP_CODE));

            //关键字不为空
            if (StringUtils.isNotBlank(user.getKeyword())) {
                Junction junction = Restrictions.disjunction()
                        .add(Restrictions.like(User._userName, user.getKeyword().trim(), MatchMode.ANYWHERE))
                        .add(Restrictions.eq(User._mobile, user.getKeyword()))
                        .add(Restrictions.eq(User._employeeCode, user.getKeyword()))
                        .add(Restrictions.eq(User._loginName, user.getKeyword()));
                criteria.add(junction);
            }
        }, Order.desc(User.CREATE_TIME));
    }

    @Override
    @SuppressWarnings("unchecked")
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public Page<User> searchUserRoleByCondition(User condition, PageParam pageParam) {
        PeUtils.validPage(pageParam);
        if (condition == null) {
            condition = new User();
        }

        String userRoleAlias = User._userRoleAlias + PeConstant.POINT;
        String userPositionAlias = User._userPositionAlias + PeConstant.POINT;
        Criteria criteria = createCriteria();
        criteria.createAlias(User._userRoleAlias, User._userRoleAlias);
        criteria.add(Restrictions.ne(User._loginName, PeConstant.ADMIN));
        //查询岗位
        if (StringUtils.isNotBlank(condition.getPositionId())) {
            criteria.createAlias(User._userPositionAlias, User._userPositionAlias);
        }

        Junction junction = Restrictions.conjunction()
                .add(Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()));
        junction.add(Restrictions.eq(User._roleType, User.RoleType.ADMIN));
        //用户名,姓名,工号,手机号
        if (StringUtils.isNotBlank(condition.getKeyword())) {
            String keyword = condition.getKeyword();
            junction.add(Restrictions.disjunction()
                    .add(Restrictions.like(User._loginName, keyword, MatchMode.ANYWHERE))
                    .add(Restrictions.like(User._userName, keyword, MatchMode.ANYWHERE))
                    .add(Restrictions.like(User._employeeCode, keyword, MatchMode.ANYWHERE))
                    .add(Restrictions.like(User._mobile, keyword, MatchMode.ANYWHERE)));
        }

        //用户名查询
        if (StringUtils.isNotBlank(condition.getLoginName())) {
            junction.add(Restrictions.like(User._loginName, condition.getLoginName(), MatchMode.ANYWHERE));
        }

        //姓名查询
        if (StringUtils.isNotBlank(condition.getUserName())) {
            junction.add(Restrictions.like(User._userName, condition.getUserName(), MatchMode.ANYWHERE));
        }

        //手机号查询
        if (StringUtils.isNotBlank(condition.getMobile())) {
            junction.add(Restrictions.like(User._mobile, condition.getMobile(), MatchMode.ANYWHERE));
        }

        //工号查询
        if (StringUtils.isNotBlank(condition.getEmployeeCode())) {
            junction.add(Restrictions.like(User._employeeCode, condition.getEmployeeCode(), MatchMode.ANYWHERE));
        }

        //状态查询
        if (CollectionUtils.isNotEmpty(condition.getUserStatusList())) {
            junction.add(Restrictions.in(User._status, condition.getUserStatusList()));
        } else {
            junction.add(Restrictions.in(User._status, new Object[]{User.UserStatus.ENABLE, User.UserStatus.FORBIDDEN}));
        }

        //岗位查询
        if (StringUtils.isNotBlank(condition.getPositionId())) {
            junction.add(Restrictions.eq(userPositionAlias + UserPosition._position, condition.getPositionId()));
        }

        //部门查询
        if (condition.getOrganize() != null && StringUtils.isNotBlank(condition.getOrganize().getId())) {
            List<String> orgIds = organizeService.listOrganizeId(condition.getOrganize().getId());
            junction.add(Restrictions.in(User._organize, orgIds));
        }

        //所属角色
        if (CollectionUtils.isNotEmpty(condition.getRoleIds())) {
            junction.add(Restrictions.in(userRoleAlias + UserRole._role, condition.getRoleIds()));
        }

        criteria.add(junction);
        criteria.setProjection(Projections.projectionList()
                .add(Projections.max(userRoleAlias + UserRole.UPDATE_TIME), "ype")
                .add(Projections.groupProperty(userRoleAlias + UserRole._user)))
                .addOrder(Order.desc("ype"));
        List list = criteria.list();
        if (CollectionUtils.isEmpty(list)) {
            return new Page<>(0);
        }

        Page<User> page = new Page<>();
        page.setTotal(list.size());
        //判断是否有值
        page.setPage(pageParam.getPage());
        page.setPageSize(pageParam.getPageSize());
        criteria.setFirstResult(pageParam.getStart())
                .setMaxResults(pageParam.getPageSize());
        List<Object[]> result = criteria.list();
        List<String> userIds = result.stream().map(objects -> (String) objects[1]).collect(Collectors.toList());
        //查询用户信息
        Map<String, User> userInfo = findUserInfo(userIds);
        //查询用户角色
        Map<String, List<Role>> userRoleMap = userRoleService.findRolesByUserIds(userIds);
        //有效排序
        List<User> users = new ArrayList<>();
        for (String userId : userIds) {
            User user = userInfo.get(userId);
            user.setRoles(userRoleMap.get(userId));
            users.add(user);
        }

        page.setRows(users);
        return page;
    }

    @Override
    @Transactional(readOnly = true)
    public Page<User> searchByOrganize(Organize organize, PageParam pageParam) {
        PeUtils.validPage(pageParam);
        if (organize == null || StringUtils.isBlank(organize.getId())) {
            return new Page<>();
        }

        String organizeId = organize.getId();
        Criterion criterion = Restrictions.and(
                Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(User._organize, organizeId),
                Restrictions.ne(User._status, User.UserStatus.DELETED),
                Restrictions.ne(User._status, User.UserStatus.FORBIDDEN));

        Page<User> page = search(pageParam, criterion, new Order[]{Order.desc(User.CREATE_TIME)}, User._userName, User._loginName, User._employeeCode, User._mobile
                , User.ID);
        List<User> users = page.getRows();
        if (CollectionUtils.isEmpty(users)) {
            return new Page<>();
        }

        List<String> userIds = users.stream().map(User::getId).collect(Collectors.toList());
        Map<String, List<Position>> userPositionMap = userPositionService.findByUserId(userIds);
        if (MapUtils.isNotEmpty(userPositionMap)) {
            setPositionName(users, userPositionMap);
        }

        return page;
    }

    @Override
    @Transactional(readOnly = true)
    public Boolean checkSid(String sid, String sign) {
        if (StringUtils.isBlank(sid) || StringUtils.isBlank(sign)) {
            return false;
        }

        SessionContext sessionContext = sessionService.loadBySessionId(sid);
        if (sessionContext == null || StringUtils.isBlank(sessionContext.getUserId())) {
            return false;
        }

        String secretKey = PropertiesUtils.getConfigProp().getProperty("file.server.secret");
        String userSign = sid + PeConstant.DIVIDING_LINE + secretKey;
        return sign.equalsIgnoreCase(MD5Generator.getHexMD5(userSign));
    }
    @Override
    @Transactional(readOnly = true)
    public Boolean checkUserPassWord(String passWord){
        if(StringUtils.isBlank(passWord)){
            throw new IllegalArgumentException("parameter are not valid!");
        }
        passWord = MD5Generator.getHexMD5(passWord);
        User user = userRedisService.get(ExecutionContext.getUserId(), User._password);
        if(user==null){
            throw new IllegalArgumentException("User is not exist!");
        }
        String dbPassWord = user.getPassword();
        if(passWord.equals(dbPassWord)){
            return Boolean.TRUE;
        }
        return Boolean.FALSE;
    }
    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int updatePwd(String newPwd, String oldPwd, String userId) {
        oldPwd = MD5Generator.getHexMD5(oldPwd);
        newPwd = MD5Generator.getHexMD5(newPwd);
        if (StringUtils.isBlank(oldPwd) || StringUtils.isBlank(newPwd) || StringUtils.isBlank(userId)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        User user = userRedisService.get(ExecutionContext.getUserId(), User._password);
        if (user == null) {
            throw new IllegalArgumentException("User is not exist!");
        }

        if (!oldPwd.equalsIgnoreCase(user.getPassword())) {
            throw new PeException(i18nService.getI18nValue("user.old.pwd.wrong"));
        }

        userService.update(user.getId(), User._password, newPwd);
        userRedisService.updatePwd(user.getId(), newPwd);
        return NumberUtils.INTEGER_ONE;
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int updateMobile(String mobile, String userId) {
        if (StringUtils.isBlank(mobile) || StringUtils.isBlank(userId)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        User user = getByMobile(mobile);
        if (user == null) {
            userService.update(userId, User._mobile, mobile);
            userRedisService.updateMobile(userId, mobile);
            return NumberUtils.INTEGER_ONE;
        }

        if (!userId.equals(user.getId())) {
            throw new PeException(i18nService.getI18nValue("error.mobile.exist"));
        }

        return NumberUtils.INTEGER_ZERO;
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, Long> findCount(List<String> corpCodes) {
        if (CollectionUtils.isEmpty(corpCodes)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        Criteria criteria = createCriteria();
        criteria.add(Restrictions.in(User.CORP_CODE, corpCodes));
        criteria.add(Restrictions.ne(User._status, User.UserStatus.DELETED));
        criteria.add(Restrictions.ne(User._loginName, PeConstant.ADMIN));
        ProjectionList projectionList = Projections.projectionList();
        projectionList.add(Projections.groupProperty(User.CORP_CODE));
        projectionList.add(Projections.rowCount());
        criteria.setProjection(projectionList);
        List<Object[]> values = criteria.list();
        if (CollectionUtils.isEmpty(values)) {
            return new HashMap<>(0);
        }

        return values.stream().collect(Collectors.toMap(value -> String.valueOf(value[0]),
                value -> PeNumberUtils.transformLong(value[1])));
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, Boolean> findMobile(List<String> mobiles) {
        if (CollectionUtils.isEmpty(mobiles)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.in(User._mobile, mobiles));
        conjunction.add(Restrictions.ne(User._status, User.UserStatus.DELETED));
        List<String> dataMobiles = listFieldValueByCriterion(conjunction, User._mobile);
        Map<String, Boolean> mobileMap = new HashMap<>(mobiles.size());
        for (String mobile : mobiles) {
            mobileMap.put(mobile, dataMobiles.contains(mobile));
        }

        return mobileMap;
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, Boolean> findLogin(List<String> loginNames) {
        if (CollectionUtils.isEmpty(loginNames)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.in(User._loginName, loginNames));
        conjunction.add(Restrictions.ne(User._status, User.UserStatus.DELETED));
        List<String> dataLoginNames = listFieldValueByCriterion(conjunction, User._loginName);
        Map<String, Boolean> loginNameMap = new HashMap<>(loginNames.size());
        for (String loginName : loginNames) {
            loginNameMap.put(loginName, dataLoginNames.contains(loginName));
        }

        return loginNameMap;
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, Boolean> findEmail(List<String> emails) {
        if (CollectionUtils.isEmpty(emails)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.in(User._email, emails));
        conjunction.add(Restrictions.ne(User._status, User.UserStatus.DELETED));
        List<String> dataEmails = listFieldValueByCriterion(conjunction, User._email);
        Map<String, Boolean> emailMap = new HashMap<>(emails.size());
        for (String email : emails) {
            emailMap.put(email, dataEmails.contains(email));
        }

        return emailMap;
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, Boolean> findEmployeeCode(List<String> employeeCodes) {
        if (CollectionUtils.isEmpty(employeeCodes)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.in(User._employeeCode, employeeCodes));
        conjunction.add(Restrictions.ne(User._status, User.UserStatus.DELETED));
        List<String> dataEmployeeCodes = listFieldValueByCriterion(conjunction, User._employeeCode);
        Map<String, Boolean> employeeCodeMap = new HashMap<>(employeeCodes.size());
        for (String employeeCode : employeeCodes) {
            employeeCodeMap.put(employeeCode, dataEmployeeCodes.contains(employeeCode));
        }

        return employeeCodeMap;
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, Boolean> findIdCard(List<String> idCards) {
        if (CollectionUtils.isEmpty(idCards)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.in(User._idCard, idCards));
        conjunction.add(Restrictions.ne(User._status, User.UserStatus.DELETED));
        List<String> dataIdCards = listFieldValueByCriterion(conjunction, User._idCard);
        Map<String, Boolean> idCardMap = new HashMap<>(idCards.size());
        for (String idCard : dataIdCards) {
            idCardMap.put(idCard, dataIdCards.contains(idCard));
        }

        return idCardMap;
    }

    @Override
    @Transactional(readOnly = true)
    public Long getRegisterNum() {
        Criteria criteria = createCriteria();
        criteria.add(Restrictions.ne(User._status, User.UserStatus.DELETED));
        criteria.add(Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()));
        criteria.add(Restrictions.ne(User._loginName, PeConstant.ADMIN));
        criteria.setProjection(Projections.rowCount());
        return (Long) criteria.uniqueResult();
    }

    @Override
    @Transactional(readOnly = true)
    public String getFacePath(String fileId, String faceName) {
        if (StringUtils.isBlank(fileId)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        String facePath = fileServerService.getFilePath(fileId);
        if (StringUtils.isBlank(facePath)) {
            return StringUtils.EMPTY;
        }

        return StringUtils.substringBeforeLast(facePath, PeConstant.BACKSLASH) + PeConstant.BACKSLASH + faceName;
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, User> findByLogin(List<String> loginNames) {
        if (CollectionUtils.isEmpty(loginNames)) {
            throw new PeException("loginName list is empty!");
        }

        Criterion criterion = Restrictions.and(
                Restrictions.eq(User.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.ne(User._status, User.UserStatus.DELETED),
                Restrictions.in(User._loginName, loginNames));
        List<User> users = listByCriterion(criterion, User.ID, User._loginName, User._status, User._userName);
        if (CollectionUtils.isEmpty(users)) {
            return new HashMap<>(0);
        }

        return users.stream().collect(Collectors.toMap(User::getLoginName, user -> user));
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
    public void batchSaveUser(List<User> users) {
        if (CollectionUtils.isEmpty(users)) {
            throw new IllegalArgumentException("Parameters are not valid!");
        }

        Map<String, Organize> preOrgMap = null;
        List<Organize> organizes = new ArrayList<>();
        List<Position> positions = new ArrayList<>();
        for (User user : users) {
            if (StringUtils.isNotBlank(user.getOrganizeName())) {
                Organize organize = new Organize();
                organizes.add(organize);
                organize.setNamePath(user.getOrganizeName());
            }

            if (StringUtils.isNotBlank(user.getPositionName())) {
                Position position = new Position();
                Category category = new Category();
                category.setNamePath(user.getPositionCategoryName());
                position.setPositionName(user.getPositionName());
                position.setCategory(category);
                position.setCategoryNamePath(user.getPositionCategoryName());
                positions.add(position);
            }
        }

        if (CollectionUtils.isNotEmpty(organizes)) {
            preOrgMap = organizeService.save(organizes);
        }

        if (CollectionUtils.isNotEmpty(positions)) {
            positionService.save(positions);
        }

        for (User user : users) {
            if (MapUtils.isNotEmpty(preOrgMap)) {
                Organize organize = preOrgMap.get(user.getOrganizeName());
                user.setOrganize(organize);
            }
        }

        processUserPosition(positions, users);
        userService.save(users);
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
    public int syncUser(List<User> users) {
        if (CollectionUtils.isEmpty(users)) {
            throw new IllegalArgumentException("User list is empty!");
        }

        List<UserPosition> userPositions = new ArrayList<>(users.size());
        List<UserRole> userRoles = new ArrayList<>(users.size());
        String roleId = roleService.getSystemId();
        Role role = new Role();
        role.setId(roleId);
        for (User user : users) {
            Organize organize = new Organize();
            organize.setId(user.getOrganizeId());
            user.setOrganize(organize);
            //人员岗位信息
            if (StringUtils.isNotEmpty(user.getPositionId())) {
                UserPosition userPosition = new UserPosition();
                Position position = new Position();
                position.setId(user.getPositionId());
                userPosition.setUser(user);
                userPosition.setPosition(position);
                userPositions.add(userPosition);
            }

            if (User.RoleType.USER.equals(user.getRoleType())) {
                continue;
            }

            //人员角色信息信息
            UserRole userRole = new UserRole();
            userRole.setUser(user);
            userRole.setRole(role);
            userRoles.add(userRole);
        }

        Map<String, User> userMap = users.stream().collect(Collectors.toMap(User::getId, user -> user));
        List<String> dbUserIds = listFieldValueByCriterion(Restrictions.in(User.ID, userMap.keySet()), User.ID);
        if (CollectionUtils.isNotEmpty(dbUserIds)) {
            List<User> updateUsers = new ArrayList<>(dbUserIds.size());
            for (String dbUserId : dbUserIds) {
                updateUsers.add(userMap.get(dbUserId));
            }

            update(updateUsers, User._loginName, User._password, User._userName, User._employeeCode,
                    User._status, User._mobile, User._idCard, User._roleType, User._organize);
        }

        List<String> saveUserIds = (List<String>) CollectionUtils.subtract(userMap.keySet(), dbUserIds);
        if (CollectionUtils.isNotEmpty(saveUserIds)) {
            List<Object[]> allValues = new ArrayList<>();
            for (String saveUserId : saveUserIds) {
                User user = userMap.get(saveUserId);
                if (StringUtils.isBlank(user.getPassword())) {
                    String passWordMD5 = MD5Generator.getHexMD5("000000");
                    user.setPassword(passWordMD5);
                }

                Object[] values = {user.getId(), ExecutionContext.getCorpCode(), ExecutionContext.getUserId(), new Date(),
                        ExecutionContext.getUserId(), new Date(), user.getEmail(), user.getEmployeeCode(), user.getIdCard(),
                        user.getLoginName(), user.getMobile(), user.getPassword(), user.getStatus().toString(), user.getUserName(),
                        user.getRoleType().toString(), user.getOrganizeId()};
                allValues.add(values);
            }

            final String addSql = "INSERT INTO T_UC_USER(ID,CORP_CODE,CREATE_BY,CREATE_TIME,UPDATE_BY,UPDATE_TIME,EMAIL," +
                    "EMPLOYEE_CODE,ID_CARD,LOGIN_NAME,MOBILE,PASSWORD,STATUS,USER_NAME,ROLE_TYPE,ORGANIZE_ID) " +
                    "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            baseService.getJdbcTemplate().batchUpdate(addSql, allValues);
        }

    //    Conjunction conjunction = getConjunction();
    //    userRoleService.delete(conjunction);
    //    userPositionService.delete(conjunction);
        if (CollectionUtils.isNotEmpty(userPositions)) {
            userPositionService.batchSave(userPositions);
        }

        if (CollectionUtils.isNotEmpty(userRoles)) {
            userRoleService.batchSave(userRoles);
        }

        for (User user : users) {
            if (User.UserStatus.ENABLE.equals(user.getStatus())) {
                userRedisService.save(user);
            }
        }

        return users.size();
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
    public int syncUserForElp(String corpCode) {
        if (StringUtils.isBlank(corpCode)) {
            throw new IllegalArgumentException("CorpCode is blank!");
        }

        final String organizeUrl = "/v1/pe/pesync/getCorpOrganizes";
        final String positionCategoryUrl = "/v1/pe/pesync/getCorpPositionCategories";
        final String positionUrl = "/v1/pe/pesync/getCorpPositions";
        final String userUrl = "/v1/pe/pesync/getCorpUsers";
        LOG.info("Start sync user info.corpCode 【" + corpCode + "】");
        try {
            ExecutionContext.setCorpCode(corpCode);
            //1、同步部门信息
            processOrganize(organizeUrl, corpCode);
            //2、同步岗位类别信息
            processPositionCategory(positionCategoryUrl, corpCode);
            //3、同步岗位信息
            processPosition(positionUrl, corpCode);
            //4、同步人员信息
            processUser(userUrl, corpCode);
        } catch (RuntimeException e) {
            LOG.error("Sync user info failed.corpCode 【" + corpCode + "】", e);
            throw new RuntimeException(e);
        }

        LOG.info("Sync user info success.corpCode 【" + corpCode + "】");
        return NumberUtils.INTEGER_ZERO;
    }

    /**
     * 封装岗位信息
     */
    private void processUser(String userUrl, String corpCode) {
        Map<String, String> params = PeUtils.packageParam(userUrl);
        int pageNo = 0;
        params.put("corpCode", corpCode);
        params.put("pageSize", PeConstant.MAX_GROUP_PAGE_SIZE + StringUtils.EMPTY);
        params.put("pageNo", pageNo + StringUtils.EMPTY);
        userUrl = PropertiesUtils.getEnvProp().getProperty("interface.elp.sync.domain.name") + userUrl + ".html";
        String userStr = HttpUtils.requestPost(userUrl, params);
        List<User> users = null;
        try {
            if (StringUtils.isBlank(userStr)) {
                return;
            }
            users = JSON.parseArray(userStr, User.class);
        } catch (RuntimeException e) {
            LOG.error(userStr, e);
            throw new RuntimeException(e);
        }

        int count = 0;
        while (CollectionUtils.isNotEmpty(users)) {
            int effectCount = syncUser(users);
            count += effectCount;
            ++pageNo;
            params.put("pageNo", pageNo + StringUtils.EMPTY);
            userStr = HttpUtils.requestPost(userUrl, params);
            try {
                if (StringUtils.isBlank(userStr)) {
                    return;
                }
                users = JSON.parseArray(userStr, User.class);
            } catch (RuntimeException e) {
                LOG.error(userStr, e);
                throw new RuntimeException(e);
            }
        }

        if (count <= 0) {
            throw new IllegalArgumentException("Sync user is failed.user is empty!");
        }
    }

    /**
     * 封装岗位信息
     */
    private void processPosition(String positionUrl, String corpCode) {
        Map<String, String> params = PeUtils.packageParam(positionUrl);
        int pageNo = 0;
        params.put("corpCode", corpCode);
        params.put("pageSize", PeConstant.MAX_GROUP_PAGE_SIZE + StringUtils.EMPTY);
        params.put("pageNo", pageNo + StringUtils.EMPTY);
        positionUrl = PropertiesUtils.getEnvProp().getProperty("interface.elp.sync.domain.name") + positionUrl + ".html";
        String positionStr = HttpUtils.requestPost(positionUrl, params);
        if (StringUtils.isBlank(positionStr)) {
            return;
        }
        List<Position> positions = null;
        try {
            positions = JSON.parseArray(positionStr, Position.class);
        } catch (RuntimeException e) {
            LOG.error(positionStr, e);
            throw new RuntimeException(e);
        }

        int count = 0;
        while (CollectionUtils.isNotEmpty(positions)) {
            int effectCount = positionService.syncPosition(positions);
            count += effectCount;
            ++pageNo;
            params.put("pageNo", pageNo + StringUtils.EMPTY);
            positionStr = HttpUtils.requestPost(positionUrl, params);
            try {
                if (StringUtils.isBlank(positionStr)) {
                    return;
                }
                positions = JSON.parseArray(positionStr, Position.class);
            } catch (RuntimeException e) {
                LOG.error(positionStr, e);
                throw new RuntimeException(e);
            }
        }

        /*if (count <= 0) {
            throw new IllegalArgumentException("Sync organize is failed.organize is empty!");
        }*/
    }

    /**
     * 封装岗位类别信息
     */
    private void processPositionCategory(String positionCategoryUrl, String corpCode) {
        Map<String, String> params = PeUtils.packageParam(positionCategoryUrl);
        int pageNo = 0;
        params.put("corpCode", corpCode);
        params.put("pageSize", PeConstant.MAX_GROUP_PAGE_SIZE + StringUtils.EMPTY);
        params.put("pageNo", pageNo + StringUtils.EMPTY);
        positionCategoryUrl = PropertiesUtils.getEnvProp().getProperty("interface.elp.sync.domain.name") + positionCategoryUrl + ".html";
        String categoryStr = HttpUtils.requestPost(positionCategoryUrl, params);
        if (StringUtils.isBlank(categoryStr)) {
            return;
        }
        List<Category> categories = null;
        try {
            categories = JSON.parseArray(categoryStr, Category.class);
        } catch (RuntimeException e) {
            LOG.error(categoryStr, e);
            throw new RuntimeException(e);
        }

        while (CollectionUtils.isNotEmpty(categories)) {
            positionService.syncCategory(categories);
            ++pageNo;
            params.put("pageNo", pageNo + StringUtils.EMPTY);
            categoryStr = HttpUtils.requestPost(positionCategoryUrl, params);
            try {
                if (StringUtils.isBlank(categoryStr)) {
                    return;
                }
                categories = JSON.parseArray(categoryStr, Category.class);
            } catch (RuntimeException e) {
                LOG.error(categoryStr, e);
                throw new RuntimeException(e);
            }
        }

    }

    /**
     * 封装部门信息
     */
    private void processOrganize(String organizeUrl, String corpCode) {
        Map<String, String> params = PeUtils.packageParam(organizeUrl);
        int pageNo = 0;
        params.put("corpCode", corpCode);
        params.put("pageSize", PeConstant.MAX_GROUP_PAGE_SIZE + StringUtils.EMPTY);
        params.put("pageNo", pageNo + StringUtils.EMPTY);
        organizeUrl = PropertiesUtils.getEnvProp().getProperty("interface.elp.sync.domain.name") + organizeUrl + ".html";
        String organizeStr = HttpUtils.requestPost(organizeUrl, params);
        if(StringUtils.isBlank(organizeStr)){
            return;
        }
        List<Organize> organizes;
        try {
            organizes = JSON.parseArray(organizeStr, Organize.class);
        } catch (RuntimeException e) {
            LOG.error(organizeStr, e);
            throw new RuntimeException(e);
        }

        int count = 0;
        while (CollectionUtils.isNotEmpty(organizes)) {
            for (Organize organize : organizes) {
                if (StringUtils.isEmpty(organize.getParentId())) {
                    organize.setDefault(true);
                }

            }

            int effectCount = organizeService.syncOrganize(organizes);
            count += effectCount;
            ++pageNo;
            params.put("pageNo", pageNo + StringUtils.EMPTY);
            organizeStr = HttpUtils.requestPost(organizeUrl, params);
            try {
                organizes = JSON.parseArray(organizeStr, Organize.class);
            } catch (RuntimeException e) {
                LOG.error(organizeStr, e);
                throw new RuntimeException(e);
            }
        }

        if (count <= 0) {
            throw new IllegalArgumentException("Sync organize is failed.organize list is empty!");
        }

    }


    private void processUserPosition(List<Position> positions, List<User> users) {
        if (CollectionUtils.isEmpty(positions)) {
            return;
        }

        Map<String, String> positionMap = packagePosition(positions);
        if (MapUtils.isEmpty(positionMap)) {
            return;
        }

        for (User user : users) {
            String positionName = user.getPositionName();
            String categoryNamePath = user.getPositionCategoryName();
            if (StringUtils.isBlank(positionName) && StringUtils.isBlank(categoryNamePath)) {
                continue;
            }

            String positionKey = categoryNamePath + PeConstant.POINT + positionName;
            String positionId = positionMap.get(positionKey);
            if (StringUtils.isNotBlank(positionId)) {
                user.setPositionId(positionId);
            }
        }
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public void packageUserPosition(List<User> users) {
        if (CollectionUtils.isEmpty(users)) {
            return;
        }

        List<String> dataUserIds = users.stream().map(User::getId).collect(Collectors.toList());
        Map<String, List<Position>> userPositionMap = userPositionService.findByUserId(dataUserIds);
        if (MapUtils.isEmpty(userPositionMap)) {
            return;
        }

        for (User user : users) {
            List<Position> positions = userPositionMap.get(user.getId());
            if (CollectionUtils.isEmpty(positions)) {
                continue;
            }

            List<String> positionNames = positions.stream().map(Position::getPositionName).
                    collect(Collectors.toList());
            String positionName = StringUtils.join(positionNames, PeConstant.COMMA);
            user.setPositionName(positionName);
        }
    }

    private Map<String, String> packagePosition(List<Position> positions) {
        List<String> positionNames = positions.stream().map(Position::getPositionName).collect(Collectors.toList());
        Map<String, List<Position>> positionNamePathMap = positionService.findNamePath(positionNames);
        if (MapUtils.isEmpty(positionNamePathMap)) {
            return new HashMap<>(0);
        }

        Map<String, String> positionMap = new HashMap<>(positions.size());
        for (Position position : positions) {


            Category category = position.getCategory();
            String positionName = position.getPositionName();
            List<Position> positionList = positionNamePathMap.get(positionName);
            if (StringUtils.isBlank(positionName) || category == null || StringUtils.isBlank(position.getCategoryNamePath())) {
                continue;
            }

            if (CollectionUtils.isEmpty(positionList)) {
                continue;
            }

            for (Position ps : positionList) {
                if (ps.getCategoryNamePath().equals(position.getCategoryNamePath())) {
                    positionMap.put(position.getCategoryNamePath() + PeConstant.POINT + positionName, ps.getId());
                }
            }

        }

        return positionMap;
    }

    /**
     * 批量将用户对应的多岗位的岗位名称以“，”隔开存入user中
     */
    private void setPositionName(List<User> users, Map<String, List<Position>> userPositionMap) {
        for (User user : users) {
            List<Position> positions = userPositionMap.get(user.getId());
            if (CollectionUtils.isEmpty(positions)) {
                continue;
            }

            List<String> positionNames = positions.stream().map(Position::getPositionName).
                    collect(Collectors.toList());
            user.setPositionName(StringUtils.join(positionNames, PeConstant.COMMA));
        }
    }

    private void checkUser(User user) {
        if (user == null || StringUtils.isBlank(user.getUserName()) || StringUtils.isBlank(user.getLoginName())) {
            throw new PeException("User parameter is illegal!");
        }

        if (StringUtils.isNotBlank(user.getMobile())) {
            if (!RegularUtils.checkMobile(user.getMobile().trim())) {
                throw new PeException(i18nService.getI18nValue("error.mobile.input"));
            }

            User dataUser = getByMobile(user.getMobile());
            if ((StringUtils.isBlank(user.getId()) && dataUser != null)
                    || (StringUtils.isNotBlank(user.getId()) && dataUser != null
                    && !dataUser.getId().equals(user.getId()))) {
                throw new PeException(i18nService.getI18nValue("error.mobile.exist"));
            }

        }

        if (StringUtils.isNotBlank(user.getEmail())) {
            if (!RegularUtils.checkEmail(user.getEmail().trim())) {
                throw new PeException(i18nService.getI18nValue("error.email.input"));
            }

            User dataUser = getByEmail(user.getEmail());
            if ((StringUtils.isBlank(user.getId()) && dataUser != null)
                    || (StringUtils.isNotBlank(user.getId()) && dataUser != null
                    && !dataUser.getId().equals(user.getId()))) {
                throw new PeException(i18nService.getI18nValue("error.email.exist"));
            }

        }

        if (StringUtils.isNotBlank(user.getIdCard()) && !RegularUtils.checkIdCard(user.getIdCard().trim())) {
            throw new PeException(i18nService.getI18nValue("error.idCard.input"));
        }

        User dataUser = getByLoginName(user.getLoginName());
        if ((StringUtils.isBlank(user.getId()) && dataUser != null)
                || (StringUtils.isNotBlank(user.getId()) && dataUser != null
                && !dataUser.getId().equals(user.getId()))) {
            throw new PeException(i18nService.getI18nValue("error.loginName.exist"));
        }
    }
}
