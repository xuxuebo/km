package com.fp.cloud.module.uc.service;

import com.fp.cloud.module.uc.model.Authority;
import com.fp.cloud.module.uc.model.Role;
import com.fp.cloud.base.ExecutionContext;
import com.fp.cloud.base.model.BaseModel;
import com.fp.cloud.base.service.BaseServiceImpl;
import com.fp.cloud.constant.PeConstant;
import com.fp.cloud.module.uc.model.RoleAuthority;
import org.apache.commons.collections.CollectionUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author Created by zhangyang on 2016/10/29.
 */
@Service("roleAuthorityService")
public class RoleAuthorityServiceImpl extends BaseServiceImpl<RoleAuthority> implements RoleAuthorityService {
    @Resource
    private AuthorityService authorityService;
    @Resource
    private UserRoleService userRoleService;

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<Authority> listByRoleId(String roleId) {
        Assert.hasText(roleId, "roleId is null when listByRoleId");

        List<String> authorities =
                listFieldValueByFieldNameAndValue(RoleAuthority._roleId, roleId, RoleAuthority._authority);
        if (CollectionUtils.isEmpty(authorities)) {
            return new ArrayList<>(0);
        }

        return authorityService.listByIds(authorities);
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public void updateByRoleIdAndAuthorityIds(String roleId, List<String> authorityIds) {
        Assert.hasText(roleId, "roleId is empty when updateByRoleIdAndAuthorityIds");
        Assert.notEmpty(authorityIds, "authorityIds is empty when updateByRoleIdAndAuthorityIds");

        //查询角色原先的权限列表
        List<String> oldAuthorityIds
                = listFieldValueByFieldNameAndValue(RoleAuthority._roleId, roleId, RoleAuthority._authority);
        List<String> oldAuthorityIdsCopy = new ArrayList<>(oldAuthorityIds);
        //查出需要删除的
        oldAuthorityIdsCopy.removeAll(authorityIds);
        //需要新增的
        authorityIds.removeAll(oldAuthorityIds);

        delete(Restrictions.conjunction()
                .add(Restrictions.eq(RoleAuthority._roleId, roleId))
                .add(Restrictions.eq(RoleAuthority._corpCode, ExecutionContext.getCorpCode()))
                .add(Restrictions.in(RoleAuthority._authority, oldAuthorityIdsCopy))
        );

        List<RoleAuthority> roleAuthorities = new ArrayList<>();
        for (String authorityId : authorityIds) {
            RoleAuthority roleAuthority = new RoleAuthority();
            Authority authority = new Authority();
            authority.setId(authorityId);
            Role role = new Role();
            role.setId(roleId);
            roleAuthority.setRole(role);
            roleAuthority.setAuthority(authority);
            roleAuthorities.add(roleAuthority);
        }

        batchSave(roleAuthorities);
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int deleteByRoleId(String roleId) {
        return delete(Restrictions.conjunction()
                .add(Restrictions.eq(RoleAuthority._corpCode, ExecutionContext.getCorpCode()))
                .add(Restrictions.eq(RoleAuthority._roleId, roleId)));
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<Authority> listAuthorityByUserId(String userId) {
        Assert.hasText(userId, "userId can not be empty when listAuthorityByUserId");
        List<Role> roles = userRoleService.listByUserId(userId);
        if (CollectionUtils.isEmpty(roles)) {
            return new ArrayList<>(0);
        }

        List<String> roleIds = roles.stream().map(BaseModel::getId).collect(Collectors.toList());
        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.in(RoleAuthority._roleId, roleIds));
        List<RoleAuthority> roleAuthorities = listByCriterion(conjunction, RoleAuthority._authority,
                RoleAuthority._authorityCode);
        if (CollectionUtils.isEmpty(roleAuthorities)) {
            return new ArrayList<>(0);
        }

        for (RoleAuthority roleAuthority : roleAuthorities) {
            Authority authority = roleAuthority.getAuthority();
            if (PeConstant.ALL.equals(authority.getAuthCode())) {
                return roleAuthorities.stream().map(RoleAuthority::getAuthority).collect(Collectors.toList());
            }
        }

        List<String> authorityIds = roleAuthorities.stream().map(roleAuthority ->
                roleAuthority.getAuthority().getId()).collect(Collectors.toList());
        Criterion criterion = Restrictions.in(Authority._id, authorityIds);
        return authorityService.listByCriterion(criterion, Authority._authUrl, Authority._authCode);
    }
}
