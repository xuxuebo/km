package com.qgutech.km.module.uc.controller;

import com.alibaba.fastjson.JSON;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.controller.BaseController;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.redis.PeRedisClient;
import com.qgutech.km.base.service.CorpService;
import com.qgutech.km.base.service.I18nService;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.base.vo.PeTreeNode;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.constant.RedisKey;
import com.qgutech.km.doc.uc.UserDoc;
import com.qgutech.km.module.im.domain.ImReceiver;
import com.qgutech.km.module.im.domain.ImTemplate;
import com.qgutech.km.module.im.service.MsgSendService;
import com.qgutech.km.module.sfm.model.PeFile;
import com.qgutech.km.module.sfm.service.FileServerService;
import com.qgutech.km.module.uc.model.*;
import com.qgutech.km.module.uc.service.*;
import com.qgutech.km.utils.Base64;
import com.qgutech.km.utils.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Restrictions;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.*;

//import com.qgutech.km.module.ems.service.SystemSettingService;
//import com.qgutech.km.module.ems.vo.Us;

/**
 * 用户管理控制层
 *
 * @author Created by zhangyang on 2016/11/2.
 */
@Controller
@RequestMapping("uc/user")
public class UserController extends BaseController {

    @Resource
    private UserService userService;
    @Resource
    private OrganizeService organizeService;
    @Resource
    private I18nService i18nService;
    @Resource
    private RoleService roleService;
    @Resource
    private FileServerService fileServerService;
    @Resource
    private UserPositionService userPositionService;
    @Resource
    private UserRedisService userRedisService;
    @Resource
    private ThreadPoolTaskExecutor taskExecutor;
    //    @Resource
//    private SystemSettingService systemSettingService;
    @Resource
    private CorpService corpService;

    @RequestMapping("manage/initPage")
    public String initPage(Model model) {
        Organize organize = organizeService.getRoot();
        model.addAttribute(User._organizeAlias, organize);
        List<Role> roles = roleService.listByCriterion(Restrictions.eq(Role.CORP_CODE, ExecutionContext.getCorpCode()),
                Role.ID, Role._roleName);
        model.addAttribute("roles", roles);
        model.addAttribute("myUserId", ExecutionContext.getUserId());
        return "uc/user/userManage";
    }

    @ResponseBody
    @RequestMapping("manage/listRoleTree")
    public List<PeTreeNode> listRoleTree() {
        Conjunction conjunction = Restrictions.conjunction();
        conjunction.add(Restrictions.eq(Role.CORP_CODE, ExecutionContext.getCorpCode()));
        if (!SessionContext.get().isSuperAdmin()) {
            String roleId = roleService.getSystemId();
            conjunction.add(Restrictions.ne(Role.ID, roleId));
        }

        List<Role> roles = roleService.listByCriterion(conjunction, Role.ID, Role._roleName);
        if (CollectionUtils.isEmpty(roles)) {
            return new ArrayList<>(0);
        }

        List<PeTreeNode> treeNodes = new ArrayList<>(roles.size());
        roles.forEach(role -> {
            PeTreeNode treeNode = new PeTreeNode();
            treeNode.setId(role.getId());
            treeNode.setName(role.getRoleName());
            treeNode.setParent(true);
            treeNodes.add(treeNode);
        });

        return treeNodes;
    }

    /**
     * 部门类别树的展示
     */
    @ResponseBody
    @RequestMapping("manage/listTree")
    public List<PeTreeNode> listTree() {
        return organizeService.listTreeNode();
    }

    /**
     * 部门类别树包含人员信息
     */
    @ResponseBody
    @RequestMapping("/listOrgTreeAndUsers")
    public List<PeTreeNode> listOrgTreeAndUsers() {
        return organizeService.listTreeNodeAndUsers();
    }

    /**
     * 分页查询
     */
    @ResponseBody
    @RequestMapping("manage/search")
    public Page<User> search(PageParam pageParam, User user) {
        if (user == null) {
            user = new User();
        }

        return userService.search(user, pageParam);
    }

    /**
     * 冻结人员
     */
    @ResponseBody
    @RequestMapping("manage/freeze")
    public JsonResult freeze(User user) {
        return updateStatus(user, User.UserStatus.FORBIDDEN);
    }

    /**
     * 激活人员
     */
    @ResponseBody
    @RequestMapping("manage/enable")
    public JsonResult enable(User user) {
        return updateStatus(user, User.UserStatus.ENABLE);
    }

    /**
     * 删除人员
     */
    @ResponseBody
    @RequestMapping("manage/delete")
    public JsonResult delete(User user) {
        return updateStatus(user, User.UserStatus.DELETED);
    }

    /**
     * 修改密码
     */
    @ResponseBody
    @RequestMapping("resetPassword")
    public JsonResult resetPassword(String oldPassword, String newPassword) {
        try {
            userService.updatePwd(newPassword, oldPassword, ExecutionContext.getUserId());
            return new JsonResult(true, JsonResult.SUCCESS);
        } catch (PeException e) {
            return new JsonResult(false, e.getMessage());
        }
    }

    /**
     * 绑定邮箱
     */
    @ResponseBody
    @RequestMapping("bindEmail")
    public JsonResult bindEmail(String password, String email, HttpServletRequest request) {
        if (StringUtils.isBlank(password) || StringUtils.isBlank(email)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        password = MD5Generator.getHexMD5(password);
        if (StringUtils.isBlank(password)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }
        User user = userService.getByEmail(email);
        if (user != null && user.getId().equals(ExecutionContext.getUserId())) {
            return new JsonResult(false, i18nService.getI18nValue("email.old.new.wrong"));
        }
        if ((user != null && !User.UserStatus.DELETED.equals(user.getStatus()))) {
            return new JsonResult(false, i18nService.getI18nValue("error.email.exist"));
        }
        User userData = userRedisService.get(ExecutionContext.getUserId());
        StringBuffer url = request.getRequestURL();
        String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).append("/").toString();
        String accountLink = tempContextUrl + "pe/login/bindEmail?email=" + email;
        if (StringUtils.isBlank(password)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }
        if (password.equals(userData.getPassword())) {
            String templateName = ImTemplate.BIND_EMAIL;
            String expiredTime = PropertiesUtils.getConfigProp().getProperty("verifyCode.time.email");
            Map<String, Object> dataMap = new HashMap<>();
            dataMap.put("ACCOUNT_NAME", userData.getUserName());
            dataMap.put("ACCOUNT_LINK", accountLink);
            MsgSendService.sendEmailMsg(templateName, i18nService.getI18nValue("bind.email"), Collections.singletonList(new ImReceiver(null, email, userData.getUserName())), dataMap, true);
            PeRedisClient.getCommonJedis().setex(RedisKey.UC_BIND_Email + userData.getId() + email, PeNumberUtils.transformInt(expiredTime), email);
            return new JsonResult(true, JsonResult.SUCCESS);
        }

        return new JsonResult(false, "密码错误");
    }

    /**
     * 绑定手机号——生成验证码
     */
    @ResponseBody
    @RequestMapping("sendMobileCode")
    public JsonResult bindMobileCode(String mobile) {
        if (StringUtils.isBlank(mobile)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        User user = userService.getByMobile(mobile);
        if (user != null && mobile.equals(user.getMobile())) {
            return new JsonResult(false, i18nService.getI18nValue("mobile.old.new.wrong"));
        }

        if (user != null && !User.UserStatus.DELETED.equals(user.getStatus())) {
            return new JsonResult(false, i18nService.getI18nValue("error.mobile.exist"));
        }

        sendVerifyCode(mobile);
        return new JsonResult(true, JsonResult.SUCCESS);
    }


    /**
     * 验证验证码
     */
    @ResponseBody
    @RequestMapping("checkIdentityCode")
    private JsonResult<User> checkIdentityCode(User user) {
        if (user == null || StringUtils.isBlank(user.getMobile()) || StringUtils.isBlank(user.getVerifyCode())) {
            throw new IllegalArgumentException("Checking info is illegal!");
        }

        JsonResult<User> jsonResult = checkPwd(user.getPassword());
        if (!jsonResult.isSuccess()) {
            return jsonResult;
        }

        return super.bindMobile(user.getMobile(), user.getVerifyCode());
    }

    @ResponseBody
    @RequestMapping("client/checkLoginVerifyCode")
    private JsonResult checkLoginVerifyCode(String mobile, String verifyCode) {
        return super.bindMobile(mobile, verifyCode);
    }

    /**
     * 重置密码
     */
    @ResponseBody
    @RequestMapping("manage/resetPsw")
    public JsonResult resetPsw(User user) {
        if (user == null || StringUtils.isBlank(user.getId()) || StringUtils.isBlank(user.getPassword())) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }
        String password = user.getPassword();
        user.setPassword(Aes.aesDecrypt(password));
        userService.updatePwd(Arrays.asList(user.getId().split(PeConstant.COMMA)), user.getPassword());
        final Map<String, String> contextMap = ExecutionContext.getContextMap();
        String corpCode = ExecutionContext.getCorpCode();
        taskExecutor.submit(() -> {
            ExecutionContext.setContextMap(contextMap);
            ExecutionContext.setCorpCode(corpCode);
        });

        return new JsonResult(true, i18nService.getI18nValue("update.success"));
    }

    private void sendManagerUpdatePwd(List<String> userIds, String password, Map<String, Boolean> messageSettingMap, Boolean messageSetting) {
        if (StringUtils.isBlank(password) || CollectionUtils.isEmpty(userIds)) {
            throw new PeException("Checking info is illegal");
        }

        List<User> users = userService.list(userIds);
        if (CollectionUtils.isNotEmpty(users)) {
            List<ImReceiver> imReceivers = new ArrayList<>(users.size());
            List<String> mobiles = new ArrayList<>(users.size());
            for (User user : users) {
                if (StringUtils.isNotBlank(user.getEmail())) {
                    imReceivers.add(new ImReceiver(user.getEmail(), user.getUserName()));
                }
                if (StringUtils.isNotBlank(user.getMobile())) {
                    mobiles.add(user.getMobile());
                }
            }

            String msgTem = ImTemplate.MANAGER_UPDATE_PASSWORD;
            Map<String, Object> mapData = new HashMap<>(1);
            mapData.put("PASSWORD", password);
            if (CollectionUtils.isNotEmpty(imReceivers) && messageSettingMap.get("S") != null) {
                MsgSendService.sendEmailMsg(msgTem, i18nService.getI18nValue("manager.update.password"),
                        imReceivers, mapData, true);
            }

            if (CollectionUtils.isNotEmpty(mobiles) && messageSettingMap.get("E") != null && messageSetting) {
                MsgSendService.sendSmsMsg(msgTem, mobiles, mapData, true);
            }

            if (messageSettingMap.get("M") != null) {
                MsgSendService.sendMessageMsg(msgTem, userIds, mapData);
            }
        }
    }

    @RequestMapping("manage/initEditPage")
    public String initEditPage(String userId, String organizeId, Model model) {
        if (StringUtils.isBlank(userId)) {
            User user = new User();
            Organize organize = organizeService.getByCriterion(Restrictions.and(
                    Restrictions.isNotNull(Organize._parentId),
                    Restrictions.eq(Organize.ID, organizeId)), Organize.ID, Organize._organizeName);
            user.setOrganize(organize);
            model.addAttribute(User._userAlias, user);
            return "uc/user/addUser";
        }

        User user = userService.get(userId);
        model.addAttribute(User._userAlias, user);
        if (CollectionUtils.isEmpty(user.getRoles()) || SessionContext.get().isSuperAdmin()) {
            return "uc/user/addUser";
        }

        String systemRoleId = roleService.getSystemId();
        user.getRoles().removeIf(role -> systemRoleId.equals(role.getId()));
        return "uc/user/addUser";
    }

    @ResponseBody
    @RequestMapping("manage/checkLoginName")
    public JsonResult<User> checkLoginName(String loginName, String userId) {
        User user = userService.getByLoginName(loginName);
        if (user == null || user.getId().equals(userId)) {
            return new JsonResult<>(true, JsonResult.SUCCESS);
        }

        return new JsonResult<>(false, JsonResult.FAILED);
    }

    @ResponseBody
    @RequestMapping("manage/checkMobile")
    public JsonResult<User> checkMobile(String mobile, String userId) {
        User user = userService.getByMobile(mobile);
        if (user == null || user.getId().equals(userId)) {
            return new JsonResult<>(true, JsonResult.SUCCESS);
        }

        return new JsonResult<>(false, JsonResult.FAILED);
    }
//
//    @ResponseBody
//    @RequestMapping("client/checkMyMobile")
//    public JsonResult<User> checkMyMobile(String mobile) {
//        return super.checkMyMobile(mobile);
//    }
//
//    @ResponseBody
//    @RequestMapping("client/bindLoginMobile")
//    public JsonResult<User> bindLoginMobile(String mobile) {
//        return super.bindLoginMobile(mobile);
//    }

    @ResponseBody
    @RequestMapping("manage/checkEmail")
    public JsonResult<User> checkEmail(String email, String userId) {
        User user = userService.getByEmail(email);
        if (user == null || user.getId().equals(userId)) {
            return new JsonResult<>(true, JsonResult.SUCCESS);
        }

        return new JsonResult<>(false, JsonResult.FAILED);
    }

    @ResponseBody
    @RequestMapping("manage/checkIdCard")
    public JsonResult<User> checkIdCard(String idCard, String userId) {
        User user = userService.getByIdCard(idCard);
        if (user == null || user.getId().equals(userId)) {
            return new JsonResult<>(true, JsonResult.SUCCESS);
        }

        return new JsonResult<>(false, JsonResult.FAILED);
    }

    @ResponseBody
    @RequestMapping("manage/updateOrganize")
    public JsonResult<User> updateOrganize(String userId, String organizeId) {
        try {
            userService.updateOrganize(JSON.parseArray(userId, String.class), organizeId);
            return new JsonResult<>(true, JsonResult.SUCCESS);
        } catch (PeException ex) {
            return new JsonResult<>(false, ex.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping("manage/updatePosition")
    public JsonResult<User> updatePosition(String userId, String positionId) {
        try {
            userService.updatePosition(JSON.parseArray(userId, String.class), JSON.parseArray(positionId, String.class));
            return new JsonResult<>(true, JsonResult.SUCCESS);
        } catch (PeException ex) {
            return new JsonResult<>(false, ex.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping("manage/saveUser")
    public JsonResult<User> saveUser(User user) {
        try {
            if (StringUtils.isBlank(user.getId())) {
                userService.save(user);
            } else {
                userService.update(user);
            }

            return new JsonResult<>(true, JsonResult.SUCCESS);
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }

    }

    @RequestMapping("client/initCutHeadPage")
    public String initCutHeadPage(Model model, String userId) {
        if (StringUtils.isBlank(userId)) {
            return "uc/user/cutHead";
        }

        User user = userService.get(userId, User._faceFileId, User._faceFileName);
        if (StringUtils.isBlank(user.getFaceFileId())) {
            return "uc/user/cutHead";
        }

        model.addAttribute("faceFileId", user.getFaceFileId());
        String sourceUrl = userService.getFacePath(user.getFaceFileId(), user.getFaceFileName());
        if (StringUtils.isBlank(sourceUrl)) {
            return "uc/user/cutHead";
        }

        model.addAttribute("sourceUrl", sourceUrl);
        model.addAttribute("targetUrl", sourceUrl);
        return "uc/user/cutHead";
    }

    @RequestMapping("client/initUserHeadPage")
    public String initUserHead(Model model, String userId) {
        model.addAttribute("userId", userId);
        User user = userService.get(userId, User._faceFileId, User._faceFileName);
        if (StringUtils.isBlank(user.getFaceFileId())) {
            return "uc/user/userCutHead";
        }

        model.addAttribute("faceFileId", user.getFaceFileId());
        String sourceUrl = userService.getFacePath(user.getFaceFileId(), user.getFaceFileName());
        if (StringUtils.isBlank(sourceUrl)) {
            return "uc/user/userCutHead";
        }

        model.addAttribute("sourceUrl", sourceUrl);
        model.addAttribute("targetUrl", sourceUrl);
        return "uc/user/userCutHead";
    }

    @ResponseBody
    @RequestMapping("client/reviseFace")
    public JsonResult reviseFace(User user) {
        if (user == null || StringUtils.isBlank(user.getFaceFileId()) || StringUtils.isBlank(user.getFaceFileName()) ||
                StringUtils.isBlank(user.getId())) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        userService.update(user, User._faceFileId, User._faceFileName);
        userRedisService.updateUserFace(user.getId(), user.getFaceFileId(), user.getFaceFileName());
        return new JsonResult(true, i18nService.getI18nValue("update.success"));
    }

    /**
     * 查看用户详情
     */
    @RequestMapping("manage/initViewUserPage")
    public String initViewUserPage(String id, Model model) {
        User user = userService.get(id);
        String positionName = userPositionService.getPositionByUserId(id);
        if (StringUtils.isNotBlank(positionName)) {
            user.setPositionName(positionName);
        }

        model.addAttribute(User._userAlias, user);
        return "uc/user/viewUserDetail";
    }

    private JsonResult updateStatus(User user, User.UserStatus userStatus) {
        if (user == null || StringUtils.isBlank(user.getId()) || userStatus == null) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }
        userService.updateStatus(Arrays.asList(user.getId().split(PeConstant.COMMA)), userStatus);
        final Map<String, String> contextMap = ExecutionContext.getContextMap();
        final String corpCode = ExecutionContext.getCorpCode();
        taskExecutor.submit(() -> {
            ExecutionContext.setContextMap(contextMap);
            ExecutionContext.setCorpCode(corpCode);
            Boolean messageSetting = corpService.checkMessage();
//            SystemSetting systemSetting = systemSettingService.getByCorp(SystemSetting.SystemType.USER);
//            if (systemSetting == null || StringUtils.isBlank(systemSetting.getMessage())) {
//                return;
//            }
//
//            Us us = JSON.parseObject(systemSetting.getMessage(), Us.class);
//            if (User.UserStatus.FORBIDDEN.equals(userStatus) && us.getFrMsg() != null) {
//                String messageTemplate = ImTemplate.FORBIDDEN_USER;
//                String subject = i18nService.getI18nValue("login.user.forbidden");
//                sendManagerUpdateStatus(Arrays.asList(user.getId().split(PeConstant.COMMA)), userStatus, messageTemplate, subject, us.getFrMsg(), messageSetting);
//                return;
//            }
//
//            if (User.UserStatus.ENABLE.equals(userStatus) && us.getAcMsg() != null) {
//                String messageTemplate = ImTemplate.ENABLE_USER;
//                String subject = i18nService.getI18nValue("login.user.enable");
//                sendManagerUpdateStatus(Arrays.asList(user.getId().split(PeConstant.COMMA)), userStatus, messageTemplate, subject, us.getAcMsg(), messageSetting);
//            }
        });


        return new JsonResult(true, i18nService.getI18nValue("update.success"));
    }

    private void sendManagerUpdateStatus(List<String> userIds, User.UserStatus userStatus, String messageTemplate,
                                         String subject, Map<String, Boolean> messageMap, Boolean messageSetting) {
        if (CollectionUtils.isEmpty(userIds) || userStatus == null) {
            throw new PeException("Checking info is illegal");
        }

        List<User> users = userService.list(userIds);
        if (CollectionUtils.isNotEmpty(users)) {
            List<ImReceiver> imReceivers = new ArrayList<>(users.size());
            List<String> mobiles = new ArrayList<>(users.size());
            for (User user : users) {
                if (StringUtils.isNotBlank(user.getEmail())) {
                    imReceivers.add(new ImReceiver(user.getEmail(), user.getUserName()));
                }
                if (StringUtils.isNotBlank(user.getMobile())) {
                    mobiles.add(user.getMobile());
                }
            }

            Map<String, Object> mapData = new HashMap<>(1);
            if (CollectionUtils.isNotEmpty(mobiles) && messageMap.get("E") != null && messageSetting) {
                MsgSendService.sendSmsMsg(messageTemplate, mobiles, mapData, true);
            }

            if (CollectionUtils.isNotEmpty(imReceivers) && messageMap.get("S") != null) {
                MsgSendService.sendEmailMsg(messageTemplate, subject, imReceivers, mapData, true);
            }

            if (messageMap.get("M") != null) {
                MsgSendService.sendMessageMsg(messageTemplate, userIds, mapData);
            }

        }
    }

    @RequestMapping("manage/exportUser")
    public void exportUser(User user, HttpServletResponse response, HttpServletRequest request) {
        if (user == null) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        if (StringUtils.isBlank(user.getId())) {
            List<User> users = userService.getAllUser();
            if (CollectionUtils.isNotEmpty(users)) {
                downUserExcel(users, response, request);
            }

        } else {
            List<User> users = userService.list(Arrays.asList(user.getId().split(PeConstant.COMMA)));
            if (CollectionUtils.isNotEmpty(users)) {
                downUserExcel(users, response, request);
            }
        }
    }

    private void downUserExcel(List<User> users, HttpServletResponse response, HttpServletRequest request) {
        try {
            FileInputStream inputStream = new FileInputStream(request.getSession().getServletContext().getRealPath("") + "/template/exportUser.xls");
            POIFSFileSystem ps = new POIFSFileSystem(inputStream);
            HSSFWorkbook workbook = new HSSFWorkbook(ps);
            HSSFSheet sheet = workbook.getSheetAt(0);
            int lastRowNum = sheet.getLastRowNum();
            for (User user : users) {
                HSSFRow row = sheet.createRow(lastRowNum + 1);
                row.createCell(0).setCellValue(user.getUserName());
                row.createCell(1).setCellValue(user.getLoginName());
                row.createCell(2).setCellValue(user.getEmployeeCode());
                row.createCell(3).setCellValue(user.getMobile());
                if (user.getEntryTime() != null) {
                    row.createCell(4).setCellValue(PeDateUtils.format(user.getEntryTime(),
                            PeDateUtils.FORMAT_YYYY_MM_DD));
                }
                if (User.UserStatus.ENABLE.equals(user.getStatus())) {
                    row.createCell(5).setCellValue("激活");
                } else {
                    row.createCell(5).setCellValue("冻结");
                }

                row.createCell(6).setCellValue(user.getEmail());
                row.createCell(7).setCellValue(user.getOrganizeName());
                List<Position> positions = userPositionService.listByUserId(user.getId());
                StringBuilder stringBuilder = new StringBuilder();
                if (CollectionUtils.isNotEmpty(positions)) {
                    for (int index = 0; index < positions.size(); index++) {
                        stringBuilder.append(positions.get(index).getCategoryName());
                        if (index != (positions.size() - 1)) {
                            stringBuilder.append(PeConstant.COMMA);
                        }
                    }

                    row.createCell(8).setCellValue(stringBuilder.toString());
                }

                String positionName = userPositionService.getPositionByUserId(user.getId());
                row.createCell(9).setCellValue(positionName);
                row.createCell(10).setCellValue(user.getIdCard());
                if (User.SexType.FEMALE.equals(user.getSexType())) {
                    row.createCell(11).setCellValue("女");
                } else if (User.SexType.MALE.equals(user.getSexType())) {
                    row.createCell(11).setCellValue("男");
                } else {
                    row.createCell(11).setCellValue("保密");
                }

                row.createCell(12).setCellValue(user.getAddress());
                lastRowNum++;
            }

            response.reset();
            response.setCharacterEncoding("utf-8");
            response.setContentType("multipart/form-data");
            response.setHeader("Content-Disposition", "attachment;fileName=User.xls");
            OutputStream out = response.getOutputStream();
            out.flush();
            workbook.write(out);
            inputStream.close();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据部门id列表查询
     */
    @ResponseBody
    @RequestMapping("manage/searchByOrganize")
    public Page<User> searchByOrganize(Organize organize, PageParam pageParam) {
        return userService.searchByOrganize(organize, pageParam);
    }

    @RequestMapping("manage/openDownload")
    public String importUser() {
        return "uc/user/userImport";
    }

    @ResponseBody
    @RequestMapping("manage/importUser")
    public JsonResult<String> importUser(@RequestParam(value = "importUserFile", required = false) MultipartFile multipartFile,
                                         HttpServletRequest request, HttpServletResponse response) {
        if (multipartFile.isEmpty()) {
            return new JsonResult<>(false, JsonResult.FAILED);
        }

        try {
            InputStream inputStream = multipartFile.getInputStream();
            return UserDoc.newInstance().importUser(inputStream, request, response);
        } catch (IOException e) {
            LOG.error(e);
            return new JsonResult<>(false, e.getMessage());
        }
    }


    @RequestMapping("manage/downloadErrorTemplate")
    public void downloadErrorTemplate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String storagePath = fileServerService.getTemplatePath(PeFile.TemplateType.ITEM, PeFile.ProcessorType.FILE);
        storagePath += PeConstant.ERROR + PeConstant.BACKSLASH + ExecutionContext.getUserId() + PeConstant.BACKSLASH + "errorUserImport.xls";
        storagePath = PropertiesUtils.getEnvProp().getProperty("file.upload.path") + PeConstant.BACKSLASH + storagePath;
        ExcelUtils.exportExcel(request, response, storagePath, "errorTemplate");
    }

    @RequestMapping("manage/downloadUserTemplate")
    public void downloadUserTemplate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String path = request.getSession().getServletContext().getRealPath("") + "/template/UserTemplate.xls";
        ExcelUtils.exportExcel(request, response, path, "人员导入模板");
    }

    @ResponseBody
    @RequestMapping("client/checkLogin")
    public String checkLogin() {
        return JsonResult.SUCCESS;
    }

}
