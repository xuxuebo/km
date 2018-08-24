package com.qgutech.km.doc.uc;

import com.qgutech.km.module.sfm.service.FileServerService;
import com.qgutech.km.module.uc.service.UserService;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.module.sfm.model.PeFile;
import com.qgutech.km.module.uc.model.User;
import com.qgutech.km.utils.*;
import com.qgutech.km.utils.*;
import com.qgutech.km.utils.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

/**
 * 用户相关文档读取类
 *
 * @author LiYanCheng@HF
 * @since 2017年3月28日10:46:24
 */
public class UserDoc {

    private static final Log LOG = LogFactory.getLog(UserDoc.class);

    private UserDoc() {
    }

    public static UserDoc newInstance() {
        return new UserDoc();
    }

    /**
     * 导入人员
     */
    public JsonResult<String> importUser(InputStream inputStream, HttpServletRequest request, HttpServletResponse response) {
        Workbook workbook = null;
        Sheet sheet = null;
        CellStyle errorStyle = null;
        Map<String, String> errorMap = new HashMap<>();
        try {
            workbook = WorkbookFactory.create(inputStream);
            sheet = workbook.getSheetAt(0);
            Font font = ExcelUtils.createFont(workbook, Font.COLOR_RED, (short) 10);
            errorStyle = ExcelUtils.createCellStyle(workbook, font);
            int lastRowNumRows = sheet.getLastRowNum();
            if (lastRowNumRows < 6) {
                createErrorExcel(6, "内容为空", sheet, workbook, errorStyle);
                return new JsonResult<>(false, "学员导入出错!请下载导入模板，重新导入！");
            }

            List<User> users = checkImportUser(sheet, errorMap);
            if (MapUtils.isNotEmpty(errorMap)) {
                createErrorExcel(errorMap, sheet, workbook, errorStyle);
                return new JsonResult<>(false, "学员导入出错!请下载导入模板，重新导入！");
            }

            if (CollectionUtils.isEmpty(users)) {
                ExcelUtils.createRow(sheet, 6, "内容为空", errorStyle);
                ExcelUtils.exportExcel(request, response, "错误反馈文档");
                workbook.write(response.getOutputStream());
                return new JsonResult<>(false, "学员导入出错!请下载导入模板，重新导入！");
            }

            checkUserInfo(users, errorMap);
            if (MapUtils.isNotEmpty(errorMap)) {
                createErrorExcel(errorMap, sheet, workbook, errorStyle);
                return new JsonResult<>(false, "学员导入出错!请下载导入模板，重新导入！");
            }

            UserService userService = SpringContextHolder.getBean("userService");
            userService.batchSaveUser(users);
        } catch (Exception e) {
            LOG.error(e.getMessage());
            e.printStackTrace();
            try {
                if (workbook != null) {
                    createErrorExcel(6, e.getMessage(), sheet, workbook, errorStyle);
                    return new JsonResult<>(false, "学员导入出错!请下载导入模板，重新导入！");
                }

            } catch (IOException e1) {
                LOG.error(e1);
            }

            LOG.error(e);
        }

        return new JsonResult<>(true, JsonResult.SUCCESS);
    }

    private void checkUserInfo(List<User> users, Map<String, String> errorMap) {
        List<String> loginNames = new ArrayList<>(users.size());
        List<String> mobiles = new ArrayList<>(users.size());
        List<String> emails = new ArrayList<>(users.size());
        List<String> employeeCodes = new ArrayList<>(users.size());
        List<String> idCards = new ArrayList<>(users.size());
        Date nowDate = PeDateUtils.parse(new Date(), PeDateUtils.FORMAT_YYYY_MM_DD_HH_MM_SS);

        for (User user : users) {
            loginNames.add(user.getLoginName());
            if (StringUtils.isNotBlank(user.getMobile())) {
                mobiles.add(user.getMobile());
            }

            if (StringUtils.isNotBlank(user.getEmail())) {
                emails.add(user.getEmail());
            }

            if (StringUtils.isNotBlank(user.getEmployeeCode())) {
                employeeCodes.add(user.getEmployeeCode());
            }

            if (StringUtils.isNotBlank(user.getIdCard())) {
                idCards.add(user.getIdCard());
            }

            user.setRoleType(User.RoleType.USER);
            nowDate = DateUtils.addMilliseconds(nowDate, 1);
            user.setCreateTime(nowDate);
            user.setUpdateTime(nowDate);
        }

        UserService userService = SpringContextHolder.getBean("userService");
        Map<String, Boolean> emailMap = new HashMap<>(0);
        if (CollectionUtils.isNotEmpty(emails)) {
            emailMap = userService.findEmail(emails);
        }

        Map<String, Boolean> loginNameMap = new HashMap<>(0);
        if (CollectionUtils.isNotEmpty(loginNames)) {
            loginNameMap = userService.findLogin(loginNames);
        }

        Map<String, Boolean> idCardMap = new HashMap<>(0);
        if (CollectionUtils.isNotEmpty(idCards)) {
            idCardMap = userService.findIdCard(idCards);
        }

        Map<String, Boolean> mobileMap = new HashMap<>(0);
        if (CollectionUtils.isNotEmpty(mobiles)) {
            mobileMap = userService.findMobile(mobiles);
        }

        Map<String, Boolean> employeeCodeMap = new HashMap<>(0);
        if (CollectionUtils.isNotEmpty(employeeCodes)) {
            employeeCodeMap = userService.findEmployeeCode(new ArrayList<>(employeeCodes));
        }

        int startRow = 6;
        for (int index = 0; index < users.size(); index++) {
            User user = users.get(index);
            Boolean exist = loginNameMap.get(user.getLoginName());
            if (BooleanUtils.isTrue(exist)) {
                errorMap.put((startRow + index) + PeConstant.COMMA + 1, "第2列用户名已存在！");
            }

            exist = emailMap.get(user.getEmail());
            if (BooleanUtils.isTrue(exist)) {
                errorMap.put((startRow + index) + PeConstant.COMMA + 5, "第6列邮箱已存在！");
            }


            exist = mobileMap.get(user.getMobile());
            if (BooleanUtils.isTrue(exist)) {
                errorMap.put((startRow + index) + PeConstant.COMMA + 4, "第5列手机号已存在！");
            }

            exist = employeeCodeMap.get(user.getEmployeeCode());
            if (BooleanUtils.isTrue(exist)) {
                errorMap.put((startRow + index) + PeConstant.COMMA + 3, "第4列工号已存在！");
            }

            exist = idCardMap.get(user.getIdCard());
            if (BooleanUtils.isTrue(exist)) {
                errorMap.put((startRow + index) + PeConstant.COMMA + 10, "第11列身份证号已存在！");
            }
        }
    }

    private List<User> checkImportUser(Sheet sheet, Map<String, String> errorMap) {
        List<User> users = new ArrayList<>(sheet.getLastRowNum() - 6);
        Set<String> loginNames = new HashSet<>(sheet.getLastRowNum() - 6);
        Set<String> mobiles = new HashSet<>(sheet.getLastRowNum() - 6);
        Set<String> emails = new HashSet<>(sheet.getLastRowNum() - 6);
        Set<String> employeeCodes = new HashSet<>(sheet.getLastRowNum() - 6);
        Set<String> idCards = new HashSet<>(sheet.getLastRowNum() - 6);
        for (int rowNum = 6; rowNum <= sheet.getLastRowNum(); rowNum++) {
            Row row = sheet.getRow(rowNum);
            if (row == null) {
                continue;
            }

            //姓名
            User user = new User();
            String userName = ExcelUtils.getStringValue(row.getCell(0));
            if (StringUtils.isBlank(userName)) {
                errorMap.put(rowNum + PeConstant.COMMA + 0, "第1列姓名不能为空！");
            } else {
                user.setUserName(userName);
            }

            //用户名
            String loginName = ExcelUtils.getStringValue(row.getCell(1));
            if (StringUtils.isBlank(loginName)) {
                errorMap.put(rowNum + PeConstant.COMMA + 1, "第2列用户名不能为空！");
            } else if (loginNames.contains(loginName)) {
                errorMap.put(rowNum + PeConstant.COMMA + 1, "第2列用户名重复！");
            } else {
                user.setLoginName(loginName);
                loginNames.add(loginName);
            }

            //密码
            String passWord = ExcelUtils.getStringValue(row.getCell(2));
            if (StringUtils.isNotBlank(passWord)) {
                if (passWord.length() < 6) {
                    errorMap.put(rowNum + PeConstant.COMMA + 2, "第3列密码至少6位！");
                }

            } else {
                passWord = PropertiesUtils.getConfigProp().getProperty("default.user.password");
            }

            user.setPassword(passWord);
            //工号
            String employeeCode = ExcelUtils.getStringValue(row.getCell(3));
            if (StringUtils.isNotBlank(employeeCode)) {
                if (employeeCode.length() > 20) {
                    errorMap.put(rowNum + PeConstant.COMMA + 3, "第4列工号长度最多20位！");
                } else if (employeeCodes.contains(employeeCode)) {
                    errorMap.put(rowNum + PeConstant.COMMA + 3, "第4列工号重复！");
                } else {
                    user.setEmployeeCode(employeeCode);
                    employeeCodes.add(employeeCode);
                }

            }

            //手机号
            String mobile = ExcelUtils.getStringValue(row.getCell(4));
            if (StringUtils.isNotBlank(mobile)) {
                Boolean result = RegularUtils.checkMobile(mobile);
                if (!result) {
                    errorMap.put(rowNum + PeConstant.COMMA + 4, "第5列手机号格式不正确！");
                } else if (mobiles.contains(mobile)) {
                    errorMap.put(rowNum + PeConstant.COMMA + 4, "第5列手机号重复！");
                } else {
                    user.setMobile(mobile);
                    mobiles.add(mobile);
                }

            }

            //邮箱
            String email = ExcelUtils.getStringValue(row.getCell(5));
            if (StringUtils.isNotBlank(email)) {
                Boolean result = RegularUtils.checkEmail(email);
                if (!result) {
                    errorMap.put(rowNum + PeConstant.COMMA + 5, "第6列邮箱格式不正确！");
                } else if (emails.contains(email)) {
                    errorMap.put(rowNum + PeConstant.COMMA + 5, "第6列邮箱重复！");
                } else {
                    user.setEmail(email);
                    emails.add(email);
                }
            }
            //部门
            String organizeName = ExcelUtils.getStringValue(row.getCell(6));
            if (StringUtils.isNotBlank(organizeName)) {
                organizeName = ExcelUtils.replaceBlank(organizeName);
                boolean checkName = checkNameLength(organizeName,50);
                if (checkName) {
                    errorMap.put(rowNum + PeConstant.COMMA + 6, "第7列部门名称超过50个字符！");
                }

                String rootOrganizeName = StringUtils.substringBefore(organizeName, PeConstant.POINT);
                if (rootOrganizeName.equals("全部")) {
                    user.setOrganizeName(organizeName);
                } else {
                    errorMap.put(rowNum + PeConstant.COMMA + 6, "第7列部门名称填写不正确");
                }
            } else {
                errorMap.put(rowNum + PeConstant.COMMA + 6, "第7列部门信息不能为空");
            }
            //岗位类别
            String positionCategoryName = ExcelUtils.getStringValue(row.getCell(7));
            //岗位名称
            String positionName = ExcelUtils.getStringValue(row.getCell(8));
            if (StringUtils.isNotBlank(positionCategoryName)) {
                positionCategoryName = ExcelUtils.replaceBlank(positionCategoryName);
                boolean checkName = checkNameLength(positionCategoryName,30);
                if (checkName) {
                    errorMap.put(rowNum + PeConstant.COMMA + 7, "第8列岗位类别名称超过30个字符！");
                }

                if (StringUtils.isBlank(positionName)) {
                    errorMap.put(rowNum + PeConstant.COMMA + 8, "第9列岗位名称不可为空！");
                } else {
                    user.setPositionCategoryName(positionCategoryName);
                }
            }


            if (StringUtils.isNotBlank(positionName)) {
                positionName = ExcelUtils.replaceBlank(positionName);
                boolean checkName = checkNameLength(positionName,50);
                if (checkName) {
                    errorMap.put(rowNum + PeConstant.COMMA + 8, "第9列岗位名称超过50个字符！");
                }

                if (StringUtils.isBlank(user.getPositionCategoryName())) {
                    errorMap.put(rowNum + PeConstant.COMMA + 7, "第8列岗位类别不可为空！");
                } else {
                    user.setPositionName(positionName);
                }

            }

            //入职时间
            String entryTimeStr = ExcelUtils.getStringValue(row.getCell(9));
            if (StringUtils.isNotBlank(entryTimeStr)) {
                Date entryTime = PeDateUtils.parse(entryTimeStr, PeDateUtils.FORMAT_YYYY_MM_DD);
                if (entryTime == null) {
                    errorMap.put(rowNum + PeConstant.COMMA + 9, "第10列入职时间格式有误！");
                } else {
                    user.setEntryTime(entryTime);
                }
            }

            String idCard = ExcelUtils.getStringValue(row.getCell(10));
            if (StringUtils.isNotBlank(idCard)) {
                Boolean result = RegularUtils.checkIdCard(idCard);
                if (!result) {
                    errorMap.put(rowNum + PeConstant.COMMA + 10, "第11列身份证格式不正确！");
                } else if (idCards.contains(idCard)) {
                    errorMap.put(rowNum + PeConstant.COMMA + 4, "第11列身份证重复！");
                } else {
                    user.setIdCard(idCard);
                    idCards.add(idCard);
                }

            }

            String sex = ExcelUtils.getStringValue(row.getCell(11));
            if (StringUtils.isBlank(sex)) {
                user.setSexType(User.SexType.SECRECY);
            } else if ("男".equals(sex.trim())) {
                user.setSexType(User.SexType.MALE);
            } else if ("女".equals(sex.trim())) {
                user.setSexType(User.SexType.FEMALE);
            } else {
                errorMap.put(rowNum + PeConstant.COMMA + 11, "第12列性别格式不正确！");
            }

            String address = ExcelUtils.getStringValue(row.getCell(12));
            user.setAddress(address);
            users.add(user);
        }

        return users;
    }

    private boolean checkNameLength(String namePath,Integer limitNum) {
        String[] orgNames = namePath.split("\\.");
        if (ArrayUtils.isEmpty(orgNames)) {
            return false;
        }

        for (String orgName : orgNames) {
            if (orgName.length() > limitNum) {
                return true;
            }
        }

        return false;
    }

    private void createErrorExcel(int rowNum, String message, Sheet sheet, Workbook workbook, CellStyle errorStyle) throws IOException {
        CellStyle backCellStyle = ExcelUtils.createCellStyle(workbook);
        backCellStyle.setFillForegroundColor(IndexedColors.GOLD.getIndex());
        backCellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
        Row row = sheet.getRow(rowNum);
        if (row == null) {
            row = sheet.createRow(rowNum);
        }

        int laseCellNum = 0;
        if (row.getLastCellNum() > 0) {
            laseCellNum = row.getLastCellNum();
        }

        Cell messageCell = row.createCell(laseCellNum);
        messageCell.setCellStyle(errorStyle);
        messageCell.setCellValue(message);
        makeErrorFile(workbook);
    }


    private void createErrorExcel(Map<String, String> errorMap, Sheet sheet, Workbook workbook, CellStyle errorStyle) throws IOException {
        CellStyle backCellStyle = ExcelUtils.createCellStyle(workbook);
        backCellStyle.setFillForegroundColor(IndexedColors.GOLD.getIndex());
        backCellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
        for (String rowscolums : errorMap.keySet()) {
            String[] rowAndColum = rowscolums.split(PeConstant.COMMA);
            Row row = sheet.getRow(Integer.parseInt(rowAndColum[0]));
            if (row == null) {
                row = sheet.createRow(Integer.parseInt(rowAndColum[0]));
            }

            Cell erroCell = row.getCell(Integer.parseInt(rowAndColum[1]));
            if (erroCell == null) {
                erroCell = row.createCell(Integer.parseInt(rowAndColum[1]));
            }

            erroCell.setCellStyle(errorStyle);
            Cell messageCell = row.createCell(row.getLastCellNum());
            messageCell.setCellStyle(errorStyle);
            messageCell.setCellValue(errorMap.get(rowscolums));
        }

        makeErrorFile(workbook);
    }


    private void makeErrorFile(Workbook workbook) throws IOException {
        FileServerService fileServerService = SpringContextHolder.getBean("fileServerService");
        String storagePath = fileServerService.getTemplatePath(PeFile.TemplateType.ITEM, PeFile.ProcessorType.FILE);
        storagePath += PeConstant.ERROR + PeConstant.BACKSLASH + ExecutionContext.getUserId() + PeConstant.BACKSLASH + "errorUserImport.xls";
        storagePath = PropertiesUtils.getEnvProp().getProperty("file.upload.path") + PeConstant.BACKSLASH + storagePath;
        ExcelUtils.makeErrorFile(workbook, storagePath);
    }
}
