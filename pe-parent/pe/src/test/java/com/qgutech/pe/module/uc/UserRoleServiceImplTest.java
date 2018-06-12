package com.qgutech.pe.module.uc;

import com.qgutech.pe.base.BaseTests;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.module.uc.model.Role;
import com.qgutech.pe.module.uc.model.User;
import com.qgutech.pe.module.uc.model.UserRole;
import com.qgutech.pe.module.uc.service.RoleService;
import com.qgutech.pe.module.uc.service.UserRoleService;
import org.junit.Test;
import org.springframework.test.annotation.Rollback;

import javax.annotation.Resource;

/**
 * @author Created by zhangyang on 2016/10/31.
 */
public class UserRoleServiceImplTest extends BaseTests {
    @Resource
    private UserRoleService userRoleService;
    @Resource
    private RoleService roleService;

    @Test
    public void testSearchByRoleId() {
        PageParam pageParam = new PageParam();
        pageParam.setPageSize(10);
        userRoleService.searchByRoleId("402881e8581a435901581a4362800000", pageParam);
    }

    @Test
    @Rollback(false)
    public void testInsertRel() {
        UserRole userRole = new UserRole();
        User user = new User();
        user.setId("59614e6e9f2b4049b08c3113c7ac8c7a");
        userRole.setUser(user);
        Role role = new Role();
        role.setId("402881e8581a435901581a4362800000");
        userRole.setRole(role);
        userRoleService.save(userRole);
    }

    @Test
    @Rollback(false)
    public void testInsertRole() {
        Role role = new Role();
        role.setRoleName("角色1");
        role.setComments("角色1");
        role.setAssignType(Role.AssignType.ALL);
        roleService.save(role);
    }

}
