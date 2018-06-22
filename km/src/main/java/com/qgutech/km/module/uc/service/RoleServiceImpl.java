package com.qgutech.km.module.uc.service;

import com.qgutech.km.module.uc.model.Authority;
import com.qgutech.km.module.uc.model.Role;
import com.qgutech.km.module.uc.model.SessionContext;
import com.qgutech.km.utils.PeUtils;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.module.uc.model.RoleAuthority;
import com.qgutech.km.utils.PeException;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.hibernate.criterion.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Created by zhangyang on 2016/10/31.
 */
@Service("roleService")
public class RoleServiceImpl extends BaseServiceImpl<Role> implements RoleService {
    @Resource
    private RoleAuthorityService roleAuthorityService;
    @Resource
    private UserRoleService userRoleService;

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public Role getById(String roleId) {
        Assert.hasText(roleId, "roleId can not be empty when getById");

        Role role = get(roleId);
        List<Authority> authorities = roleAuthorityService.listByRoleId(roleId);
        role.setAuthorities(authorities);
        return role;
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public String save(Role role) {
        Assert.notNull(role, "role is null when roleService save");

        boolean b = checkName(role);
        if (b) {
            throw new PeException("role.name.exist");
        }

        String roleId = super.save(role);
        if (CollectionUtils.isEmpty(role.getAuthorities())) {
            return roleId;
        }

        role.setId(roleId);
        List<RoleAuthority> roleAuthorities = new ArrayList<>();
        for (Authority authority : role.getAuthorities()) {
            RoleAuthority roleAuthority = new RoleAuthority();
            roleAuthority.setAuthority(authority);
            roleAuthority.setRole(role);
            roleAuthorities.add(roleAuthority);
        }

        roleAuthorityService.batchSave(roleAuthorities);
        return roleId;
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public boolean checkName(Role role) {
        Assert.notNull(role, "role is null when checkName from roleService");

        if (StringUtils.isBlank(role.getRoleName())) {//角色名不能为空
            throw new PeException("role.name.not.empty");
        }

        if (role.getRoleName().length() > 10) {//角色名称超过10字符
            throw new PeException("role.name.length.maxLimit");
        }

        return exist(Restrictions.conjunction()
                .add(Restrictions.eq(Role._roleName, role.getRoleName()))
                .add(Restrictions.eq(Role.CORP_CODE, ExecutionContext.getCorpCode()))
        );
    }

    public RoleServiceImpl() {
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int update(Role role) {
        if (role == null || StringUtils.isBlank(role.getId()) || CollectionUtils.isEmpty(role.getAuthorities())) {
            throw new PeException("role.primary.not.exist");
        }

        roleAuthorityService.delete(Restrictions.conjunction()
                .add(Restrictions.eq(RoleAuthority._roleId, role.getId()))
                .add(Restrictions.eq(RoleAuthority.CORP_CODE, ExecutionContext.getCorpCode())));
        List<RoleAuthority> roleAuthorities = new ArrayList<>();
        for (Authority authority : role.getAuthorities()) {
            RoleAuthority roleAuthority = new RoleAuthority();
            roleAuthority.setRole(role);
            roleAuthority.setAuthority(authority);
            roleAuthorities.add(roleAuthority);
        }

        update(role, Role._roleName, Role._comments);
        if (CollectionUtils.isNotEmpty(roleAuthorities)) {
            roleAuthorityService.batchSave(roleAuthorities);
        }

        return NumberUtils.INTEGER_ONE;
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public Page<Role> search(Role condition, PageParam pageParam) {
        PeUtils.validPage(pageParam);
        if (condition == null) {
            condition = new Role();
        }

        Junction junction = Restrictions.conjunction()
                .add(Restrictions.eq(Role.CORP_CODE, ExecutionContext.getCorpCode()));
        //是否有角色名称
        if (!SessionContext.get().isSuperAdmin()) {
            String roleId = getSystemId();
            junction.add(Restrictions.ne(Role.ID, roleId));
        }

        if (StringUtils.isNotBlank(condition.getRoleName())) {
            junction.add(Restrictions.like(Role._roleName, condition.getRoleName(), MatchMode.ANYWHERE));
        }

        Page<Role> page = search(pageParam, junction, Order.desc(Role.UPDATE_TIME));
        if (CollectionUtils.isEmpty(page.getRows())) {
            return new Page<>();
        }

        String defaultSystemId = getSystemId();
        for (Role role : page.getRows()) {
            if (defaultSystemId.equals(role.getId())) {
                role.setCanEdit(false);
                break;
            }
        }

        return page;
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int delete(String roleId) {
        Assert.hasText(roleId, "roleId is empty when delete from roleService");

        userRoleService.deleteByRoleId(roleId);
        roleAuthorityService.deleteByRoleId(roleId);
        return super.delete(roleId);
    }

    @Override
    @Transactional(readOnly = true)
    public String getSystemId() {
        Conjunction conjunction = new Conjunction();
        conjunction.add(Restrictions.eq(Role._roleName, "系统管理员"));
        conjunction.add(Restrictions.eq(Role._isDefault, Boolean.TRUE));
        conjunction.add(Restrictions.eq(Role.CORP_CODE, ExecutionContext.getCorpCode()));
        return getFieldValueByCriterion(conjunction, Role.ID);
    }

}
