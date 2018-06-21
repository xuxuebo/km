package com.qgutech.km.module.uc.service;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.module.uc.model.Role;
import com.qgutech.km.module.uc.model.User;
import com.qgutech.km.module.uc.model.UserRole;
import com.qgutech.km.utils.PeUtils;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.module.uc.model.Position;
import com.qgutech.km.utils.PeException;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author Created by zhangyang on 2016/10/29.
 */
@Service("userRoleService")
public class UserRoleServiceImpl extends BaseServiceImpl<UserRole> implements UserRoleService {
    @Resource
    private RoleService roleService;
    @Resource
    private UserService userService;
    @Resource
    private UserRedisService userRedisService;
    @Resource
    private UserPositionService userPositionService;

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int deleteByUserId(String userId) {
        if (StringUtils.isBlank(userId)) {
            throw new PeException("UserId is blank!");
        }

        return delete(Restrictions.and(
                Restrictions.eq(UserRole._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.eq(UserRole._user, userId)
        ));
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public Page<User> searchByRoleId(String roleId, PageParam pageParam) {
        Assert.hasText(roleId, "roleId is null when searchByRoleId");
        PeUtils.validPage(pageParam);

        Condition condition = criteria -> {
            criteria.createAlias(UserRole._userAlias, UserRole._userAlias);
            String userAlias = UserRole._userAlias + PeConstant.POINT;
            criteria.add(Restrictions.eq(UserRole._corpCode, ExecutionContext.getCorpCode()));
            criteria.add(Restrictions.eq(UserRole._role, roleId));
            criteria.add(Restrictions.ne(userAlias + User._loginName, PeConstant.ADMIN));
            criteria.add(Restrictions.eq(userAlias + User._status, User.UserStatus.ENABLE));
        };

        Page<UserRole> rolePage = search(pageParam, condition, Order.desc(UserRole._createTime));
        if (rolePage.getTotal() <= 0) {
            return new Page<>(0);
        }

        //查询用户的岗位
        List<UserRole> rows = rolePage.getRows();
        List<String> userIds = rows.stream().map(userRole -> userRole.getUser().getId()).collect(Collectors.toList());
        Map<String, List<Position>> positionMap = userPositionService.findByUserId(userIds);
        for (UserRole userRole : rows) {
            List<Position> positions = positionMap.get(userRole.getUser().getId());
            if (CollectionUtils.isEmpty(positions)) {
                continue;
            }

            String positionName = "";
            for (int i = 0; i < positions.size(); i++) {
                positionName += positions.get(i).getPositionName();
                if (i != (positions.size() - 1)) {
                    positionName += ",";
                }
            }

            userRole.getUser().setPositionName(positionName);
        }

        return PeUtils.convertPage(rolePage, UserRole._userAlias);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<Role> listByUserId(String userId) {
        Assert.hasText(userId, "userId is null when listByUserId");

        List<String> roleIds = listFieldValueByFieldNameAndValue(UserRole._user, userId,
                new Order[]{Order.desc(UserRole._createTime)}, UserRole._role);
        if (CollectionUtils.isEmpty(roleIds)) {
            return new ArrayList<>(0);
        }

        return roleService.listByIds(roleIds);
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
    public int deleteSpecialRoleByUserId(String userId, List<String> roleIds) {
        Assert.hasText(userId, "userId is null when deleteSpecialRoleByUserId");
        Assert.notEmpty(roleIds, "roleIds is empty when deleteSpecialRoleByUserId");

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.eq(UserRole._user, userId));
        conjunction.add(Restrictions.in(UserRole._role, roleIds));
        int rowCount = delete(conjunction);
        processUserRole(Collections.singletonList(userId));
        return rowCount;
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int deleteByRoleId(String roleId) {
        Assert.hasText(roleId, "roleId is null when deleteByRoleId");

        List<String> userIds = listFieldValueByFieldNameAndValue(UserRole._role, roleId, UserRole._user);
        if (CollectionUtils.isEmpty(userIds)) {
            return NumberUtils.INTEGER_ZERO;
        }

        int rowCount = delete(Restrictions.conjunction()
                .add(Restrictions.eq(UserRole._role, roleId))
                .add(Restrictions.eq(UserRole._corpCode, ExecutionContext.getCorpCode())));
        processUserRole(userIds);
        return rowCount;
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int deleteSpecialUsersByRoleId(String roleId, List<String> userIds) {
        Assert.hasText(roleId, "roleId can not be empty when deleteSpecialUsersByRoleId");
        Assert.notEmpty(userIds, "userIds can not be empty when deleteSpecialUsersByRoleId");

        int rowCount = delete(Restrictions.conjunction()
                .add(Restrictions.eq(UserRole._role, roleId))
                .add(Restrictions.eq(UserRole._corpCode, ExecutionContext.getCorpCode()))
                .add(Restrictions.in(UserRole._user, userIds)));
        processUserRole(userIds);
        return rowCount;
    }

    private void processUserRole(List<String> userIds) {
        List<UserRole> userRoles = listByCriterion(Restrictions.in(UserRole._user, userIds));
        if (CollectionUtils.isEmpty(userRoles)) {
            userService.update(userIds, User._roleType, User.RoleType.USER);
            userIds.forEach(userId -> userRedisService.removeAdmin(userId));
            return;
        }

        List<String> adminUserIds = userRoles.stream().map(userRole -> userRole.getUser().getId())
                .collect(Collectors.toList());
        List<String> userIdDatas=new ArrayList<>(userIds.size());
        userIdDatas.addAll(userIds);
        userIdDatas.removeAll(adminUserIds);
        if (CollectionUtils.isEmpty(userIdDatas)) {
            return;
        }

        userService.update(userIds, User._roleType, User.RoleType.USER);
        userIds.forEach(userId -> userRedisService.removeAdmin(userId));
    }


    @Override
    @SuppressWarnings("unchecked")
    @Transactional(readOnly = true)
    public Page<User> searchAdmin(User user, PageParam pageParam) {
        PeUtils.validPage(pageParam);
        return getUserPage(user, null, pageParam);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<User> searchAdminByCondition(User user, List<String> excludeUserIds, PageParam pageParam) {
        PeUtils.validPage(pageParam);
        return getUserPage(user, excludeUserIds, pageParam);
    }

    private Page<User> getUserPage(User user, List<String> excludeUserIds, PageParam pageParam) {
        PeUtils.validPage(pageParam);
        Criteria criteria = createCriteria();
        criteria.createAlias(UserRole._userAlias, UserRole._userAlias);
        String userAlias = UserRole._userAlias + PeConstant.POINT;
        criteria.add(Restrictions.eq(UserRole._corpCode, ExecutionContext.getCorpCode()));
        criteria.add(Restrictions.eq(userAlias + User._corpCode, ExecutionContext.getCorpCode()));
        criteria.add(Restrictions.eq(userAlias + User._status, User.UserStatus.ENABLE));
        criteria.add(Restrictions.ne(userAlias + User._loginName, PeConstant.ADMIN));
        if (user != null) {
            if (StringUtils.isNotBlank(user.getKeyword())) {
                criteria.add(Restrictions.or(Restrictions.eq(userAlias + User._mobile, user.getKeyword().trim()),
                        Restrictions.eq(userAlias + User._email, user.getKeyword().trim()),
                        Restrictions.like(userAlias + User._loginName, user.getKeyword().trim(), MatchMode.ANYWHERE),
                        Restrictions.like(userAlias + User._userName, user.getKeyword().trim(), MatchMode.ANYWHERE)));
            }

            if (user.getOrganize() != null && StringUtils.isNotBlank(user.getOrganize().getId())) {
                criteria.add(Restrictions.eq(userAlias + User._organize, user.getOrganize().getId()));
            }
        }

        if (CollectionUtils.isNotEmpty(excludeUserIds)) {
            criteria.add(Restrictions.not(Restrictions.in(userAlias + User._id, new HashSet<String>(excludeUserIds))));
        }

        criteria.setProjection(Projections.groupProperty(UserRole._user));
        List<String> userIds = criteria.list();
        if (CollectionUtils.isEmpty(userIds)) {
            return new Page<>();
        }

        return userService.search(pageParam, Restrictions.in(User._id, userIds),
                new Order[]{Order.desc(User._createTime)}, User._id, User._userName, User._loginName);
    }

    @Override
    @SuppressWarnings("unchecked")
    @Transactional(readOnly = true)
    public Map<String, List<Role>> findRolesByUserIds(List<String> userIds) {
        Assert.notEmpty(userIds, "userIds can not be empty when findRolesByUserIds");

        Criteria criteria = createCriteria();
        criteria.createAlias(UserRole._roleAlias, UserRole._roleAlias)
                .add(Restrictions.eq(UserRole._corpCode, ExecutionContext.getCorpCode()))
                .add(Restrictions.in(UserRole._user, userIds));
        List<UserRole> result = criteria.list();
        if (CollectionUtils.isEmpty(result)) {
            return new HashMap<>(0);
        }

        Map<String, List<Role>> userRoleMap = new HashMap<>();
        for (UserRole userRole : result) {
            List<Role> roles = userRoleMap.get(userRole.getUser().getId());
            if (CollectionUtils.isEmpty(roles)) {
                roles = new ArrayList<>();
            }

            roles.add(userRole.getRole());
            userRoleMap.put(userRole.getUser().getId(), roles);
        }

        return userRoleMap;
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public List<String> save(List<UserRole> userRoles) {
        if (CollectionUtils.isEmpty(userRoles)) {
            throw new IllegalArgumentException("UserRole list is empty！");
        }

        List<String> userRoleIds = super.batchSave(userRoles);
        List<String> userIds = userRoles.stream().map(userRole -> userRole.getUser().getId())
                .collect(Collectors.toList());
        userService.update(userIds, User._roleType, User.RoleType.ADMIN);
        userIds.forEach(userId -> userRedisService.saveAdmin(userId));
        return userRoleIds;
    }

    @Override
    @Transactional(readOnly = true)
    public Boolean checkSystemRole(String userId) {
        if (StringUtils.isBlank(userId)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        List<String> roleIds = listFieldValueByCriterion(getConjunction().add(Restrictions.eq(UserRole._user, userId)),
                UserRole._role);
        if (CollectionUtils.isEmpty(roleIds)) {
            return Boolean.FALSE;
        }

        String systemId = roleService.getSystemId();
        return roleIds.contains(systemId);
    }
}
