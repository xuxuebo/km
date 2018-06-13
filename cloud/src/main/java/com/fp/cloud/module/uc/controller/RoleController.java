package com.fp.cloud.module.uc.controller;

import com.alibaba.fastjson.JSON;
import com.fp.cloud.base.model.BaseModel;
import com.fp.cloud.base.model.Page;
import com.fp.cloud.base.service.I18nService;
import com.fp.cloud.base.vo.JsonResult;
import com.fp.cloud.base.vo.PeTreeNode;
import com.fp.cloud.constant.PeConstant;
import com.fp.cloud.module.uc.model.*;
import com.fp.cloud.module.uc.service.*;
import com.fp.cloud.utils.PeException;
import com.fp.cloud.base.model.PageParam;
import com.fp.cloud.module.uc.model.*;
import com.fp.cloud.module.uc.service.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author Created by zhangyang on 2016/11/3.
 */
@Controller
@RequestMapping("uc/role")
public class RoleController {
    @Resource
    private RoleService roleService;
    @Resource
    private I18nService i18nService;
    @Resource
    private AuthorityService authorityService;
    @Resource
    private OrganizeService organizeService;
    @Resource
    private UserService userService;
    @Resource
    private UserRoleService userRoleService;
    @Resource
    private RoleAuthorityService roleAuthorityService;

    @RequestMapping("manage/initPage")
    public String initPage(Model model) {
        model.addAttribute("superAdmin", SessionContext.get().isSuperAdmin());
        return "uc/role/roleManage";
    }

    @ResponseBody
    @RequestMapping("manage/search")
    public Page<Role> search(Role role, PageParam pageParam) {
        return roleService.search(role, pageParam);
    }


    /**
     * 获取权限树
     */
    @ResponseBody
    @RequestMapping("manage/listAuthTree")
    public List<PeTreeNode> listAuthTree(String roleId) {
        List<Authority> authorities = authorityService.list();
        List<String> selectAuthorityIds = null;
        if (StringUtils.isNotBlank(roleId)) {
            List<Authority> selectAuthorities = roleAuthorityService.listByRoleId(roleId);
            selectAuthorityIds = selectAuthorities.stream().map(BaseModel::getId).collect(Collectors.toList());
        }

        List<PeTreeNode> peTreeNodes = new ArrayList<>();
        for (Authority authority : authorities) {
            PeTreeNode peTreeNode = new PeTreeNode();
            peTreeNode.setId(authority.getId());
            peTreeNode.setpId(authority.getParentId());
            peTreeNode.setParent(true);
            peTreeNode.setName(authority.getAuthName());
            if (CollectionUtils.isNotEmpty(selectAuthorityIds) && selectAuthorityIds.contains(authority.getId())) {
                peTreeNode.setChecked(true);
                peTreeNode.setOpen(true);
                peTreeNode.setIshasSelected(true);
            } else {
                peTreeNode.setChecked(false);
                peTreeNode.setOpen(false);
            }

            if (authority.getIdPath().equals(PeConstant.STAR)) {
                peTreeNode.setOpen(true);
            }

            peTreeNodes.add(peTreeNode);
        }

        return peTreeNodes;
    }

    /**
     * 跳转人员查看的页面
     */
    @RequestMapping("manage/toViewRoleByUser")
    public String viewRoleByUser() {
        return "uc/role/viewRoleByUser";
    }

    /**
     * 按人员查看
     */
    @ResponseBody
    @RequestMapping("manage/searchByUser")
    public Page<User> searchByUser(PageParam pageParam, User user) {
        return userService.searchUserRoleByCondition(user, pageParam);
    }

    /**
     * 查看当前学员的角色
     */
    @ResponseBody
    @RequestMapping("manage/listRolesByUserId")
    public List<Role> listRolesByUserId(String userId) {
        List<Role> roles = userRoleService.listByUserId(userId);
        if (CollectionUtils.isEmpty(roles)) {
            return new ArrayList<>(0);
        }

        String systemId = roleService.getSystemId();
        roles.removeIf(role -> systemId.equals(role.getId()) && !SessionContext.get().isSuperAdmin());
        return roles;
    }

    /**
     * 删除指定人员的指定角色
     */
    @ResponseBody
    @RequestMapping("manage/deleteRolesByUserId")
    public JsonResult deleteRolesByUserId(User user) {
        if (CollectionUtils.isEmpty(user.getRoleIds()) || StringUtils.isBlank(user.getId())) {
            return new JsonResult(true, i18nService.getI18nValue("save.success"));
        }

        try {
            userRoleService.deleteSpecialRoleByUserId(user.getId(), user.getRoleIds());
        } catch (PeException e) {
            return new JsonResult(false, i18nService.getI18nValue("save.fail"));
        }

        return new JsonResult(true, i18nService.getI18nValue("save.success"));
    }

    /**
     * 查看角色详情
     */
    @RequestMapping("manage/roleDetail")
    public String roleDetail(String roleId, Model model) {
        Role role = roleService.get(roleId);
        model.addAttribute("role", role);
        return "uc/role/roleDetail";
    }

    /**
     * 新增一个角色保存
     */
    @ResponseBody
    @RequestMapping("manage/saveRole")
    public JsonResult saveRole(Role role) {
        roleService.save(role);
        return new JsonResult(true, i18nService.getI18nValue("save.success"));
    }

    /**
     * 添加角色
     */
    @RequestMapping("manage/addRole")
    public String addRole() {
        return "uc/role/addRole";
    }

    /**
     * 编辑角色
     */
    @RequestMapping("manage/editRole")
    public String editRole(String roleId, Model model) {
        Role role = roleService.getById(roleId);
        model.addAttribute("role", role);
        model.addAttribute("edit", true);
        return "uc/role/addRole";
    }

    /**
     * 权限设置入口
     */
    @RequestMapping("manage/editAuth")
    public String editAuth(String roleId, Model model) {
        Role role = roleService.getById(roleId);
        model.addAttribute("role", role);
        return "uc/role/roleAuthorityMan";
    }

    /**
     * 成员管理设置入口
     */
    @RequestMapping("manage/memberManage")
    public String memberManage(String roleId, Model model) {
        Organize root = organizeService.getRoot();
        model.addAttribute("organizeId", root.getId());
        model.addAttribute("roleId", roleId);
        model.addAttribute("superAdmin", SessionContext.get().isSuperAdmin());
        String systemId = roleService.getSystemId();
        model.addAttribute("systemRole", systemId.equals(roleId));
        return "uc/role/roleSelector";
    }

    /**
     * 部门的类别树
     */
    @ResponseBody
    @RequestMapping("manage/listOrganizeTree")
    public List<PeTreeNode> listOrganizeTree() {
        return organizeService.listTreeNode();
    }

    /**
     * 查询部门下的角色中未选中的人员
     */
    @ResponseBody
    @RequestMapping("manage/searchWaitUser")
    public Page<User> searchWaitUser(PageParam pageParam, User user, String roleId) {
        Page<User> page = userService.searchWaitUserByRoleId(roleId, user, pageParam);
        page.setPage(pageParam.getPage() - 1);
        page.setPageSize(pageParam.getPageSize());
        return page;
    }

    /**
     * 查询部门下的角色中已经选中的人员
     */
    @ResponseBody
    @RequestMapping("manage/searchSelectUser")
    public Page<User> searchSelectUser(PageParam pageParam, String roleId) {
        Page<User> page = userRoleService.searchByRoleId(roleId, pageParam);
        page.setPage(pageParam.getPage() - 1);
        page.setPageSize(pageParam.getPageSize());
        return page;
    }

    /**
     * 保存角色关联的人员
     */
    @ResponseBody
    @RequestMapping("manage/saveUserRole")
    public JsonResult saveUserRole(Role role, String userIds) {
        if (StringUtils.isBlank(userIds)) {
            return new JsonResult(true, i18nService.getI18nValue("save.success"));
        }

        List<UserRole> userRoles = new ArrayList<>();
        for (String userId : JSON.parseArray(userIds, String.class)) {
            User user = new User();
            user.setId(userId);
            UserRole userRole = new UserRole();
            userRole.setRole(role);
            userRole.setUser(user);
            userRoles.add(userRole);
        }

        try {
            userRoleService.save(userRoles);
        } catch (Exception e) {
            return new JsonResult(false, i18nService.getI18nValue("save.fail"));
        }

        return new JsonResult(true, i18nService.getI18nValue("save.success"));
    }

    /**
     * 删除角色关联的人员
     */
    @ResponseBody
    @RequestMapping("manage/deleteUserRole")
    public JsonResult deleteUserRole(Role role) {
        List<User> users = role.getUsers();
        if (CollectionUtils.isEmpty(users)) {
            return new JsonResult(true, i18nService.getI18nValue("delete.success"));
        }

        List<String> userIds = new ArrayList<>(users.size());
        userIds.addAll(users.stream().map(BaseModel::getId).collect(Collectors.toList()));
        try {
            userRoleService.deleteSpecialUsersByRoleId(role.getId(), userIds);
        } catch (Exception e) {
            return new JsonResult(false, i18nService.getI18nValue("delete.fail"));
        }

        return new JsonResult(true, i18nService.getI18nValue("delete.success"));
    }

    /**
     * 更新角色
     */
    @ResponseBody
    @RequestMapping("manage/updateRole")
    public JsonResult updateRole(Role role) {
        try {
            roleService.update(role);
        } catch (Exception e) {
            return new JsonResult(false, i18nService.getI18nValue("save.fail"));
        }

        return new JsonResult(true, i18nService.getI18nValue("save.success"));
    }

    @ResponseBody
    @RequestMapping("manage/delete")
    public JsonResult delete(Role role) {
        if (role == null) {
            return new JsonResult(false, i18nService.getI18nValue("role.object.not.empty"));
        }

        if (StringUtils.isBlank(role.getId())) {
            return new JsonResult(false, i18nService.getI18nValue("role.primary.not.exist"));
        }

        try {
            roleService.delete(role.getId());
        } catch (Exception e) {
            return new JsonResult(false, i18nService.getI18nValue("delete.fail"));
        }

        return new JsonResult(true, i18nService.getI18nValue("delete.success"));
    }
}
