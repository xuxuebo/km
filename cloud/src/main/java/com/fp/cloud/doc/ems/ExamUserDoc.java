package com.fp.cloud.doc.ems;

import com.fp.cloud.base.ExecutionContext;
import com.fp.cloud.constant.PeConstant;
import com.fp.cloud.module.ems.model.Exam;
import com.fp.cloud.module.ems.model.ExamArrange;
import com.fp.cloud.module.ems.model.ExamUser;
import com.fp.cloud.module.ems.service.ExamUserService;
import com.fp.cloud.module.sfm.model.PeFile;
import com.fp.cloud.module.sfm.service.FileServerService;
import com.fp.cloud.module.uc.model.User;
import com.fp.cloud.module.uc.service.UserService;
import com.fp.cloud.utils.ExcelUtils;
import com.fp.cloud.utils.HttpUtils;
import com.fp.cloud.utils.PropertiesUtils;
import com.fp.cloud.utils.SpringContextHolder;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 线上考试导入人员
 */
public class ExamUserDoc {
    private static final Log LOG = LogFactory.getLog(ExamResultDoc.class);

    private ExamUserDoc() {
    }

    public static ExamUserDoc newInstance() {
        return new ExamUserDoc();
    }

    public void processExamUserTemplate(String templatePath,
                                        HttpServletResponse response, HttpServletRequest request) {
        OutputStream outputStream = null;
        try {
            outputStream = response.getOutputStream();
            Workbook workbook = new HSSFWorkbook(new FileInputStream(templatePath));
            if (templatePath.endsWith(".xls")) {
                response.setContentType("application/vnd.ms-excel");
            } else if (templatePath.endsWith(".xlsx")) {
                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            }
            String filenamedisplay = URLEncoder.encode("考试人员导入模板") + ".xls";
            if ("FF".equals(HttpUtils.getBrowser(request))) {
                // 针对火狐浏览器处理方式不一样了
                filenamedisplay = new String("考试人员导入模板".getBytes("UTF-8"),
                        "iso-8859-1") + ".xls";
            }

            response.setHeader("Content-disposition", "attachment;filename=" + filenamedisplay);
            workbook.write(outputStream);
            outputStream.flush();
        } catch (IOException e) {
            LOG.error(e);
        } finally {
            IOUtils.closeQuietly(outputStream);
        }
    }

    public List<ExamUser> processImportExamUser(ExamArrange examArrange, InputStream inputStream) {
        Exam exam = examArrange.getExam();
        Map<Integer, Map<Integer, String>> errorMap = new HashMap<>();
        int startRowNum = 3;
        Workbook workbook = null;
        try {
            workbook = new HSSFWorkbook(inputStream);
            Sheet sheet = workbook.getSheetAt(0);
            int lastRowNum = sheet.getLastRowNum() + 1;
            if (lastRowNum <= startRowNum) {
                packageErrorMsg(errorMap, startRowNum, 3, "表格内容为空！");
                processErrorTemplate(workbook, errorMap);
                return new ArrayList<>(0);
            }

            Set<String> ticketSet = new HashSet<>(lastRowNum - startRowNum);
            Map<String, Integer> loginNameMap = new HashMap<>(lastRowNum - startRowNum);
            List<ExamUser> examUsers = new ArrayList<>();
            ExamUserService examUserService = SpringContextHolder.getBean("examUserService");
            Set<String> tickets = null;
            if (BooleanUtils.isTrue(exam.getEnableTicket())) {
                tickets = examUserService.listTicket(exam.getId());
            }

            for (int index = startRowNum; index < lastRowNum; index++) {
                Row contentRow = sheet.getRow(index);
                ExamUser examUser = packageExamUser(index, contentRow, BooleanUtils.isTrue(exam.getEnableTicket()), errorMap);
                if (examUser == null) {
                    continue;
                }

                examUser.setExam(exam);
                examUser.setExamArrange(examArrange);
                examUsers.add(examUser);
                if (StringUtils.isNotBlank(examUser.getLoginName())) {
                    if (loginNameMap.containsKey(examUser.getLoginName())) {
                        packageErrorMsg(errorMap, index, 0, "用户名重复！");
                    } else {
                        loginNameMap.put(examUser.getLoginName(), index);
                    }
                }

                if (StringUtils.isNotBlank(examUser.getTicket())) {
                    if (ticketSet.contains(examUser.getTicket())) {
                        packageErrorMsg(errorMap, index, 2, "准考证号重复！");
                    } else if (CollectionUtils.isNotEmpty(tickets) && tickets.contains(examUser.getTicket())) {
                        packageErrorMsg(errorMap, index, 2, "准考证号已存在！");
                    } else {
                        ticketSet.add(examUser.getTicket());
                    }
                }
            }

            if (CollectionUtils.isEmpty(examUsers)) {
                packageErrorMsg(errorMap, startRowNum, 3, "表格内容为空！");
                processErrorTemplate(workbook, errorMap);
                return new ArrayList<>(0);
            }

            if (MapUtils.isNotEmpty(errorMap)) {
                processErrorTemplate(workbook, errorMap);
                return new ArrayList<>(0);
            }

            Map<ExamUser.ExamUserType, List<String>> referIdMap = examUserService.findReferId(exam.getId());
            Set<String> referIds = null;
            if (MapUtils.isNotEmpty(referIdMap) && CollectionUtils.isNotEmpty(referIdMap.get(ExamUser.ExamUserType.USER))) {
                referIds = new HashSet<>(referIdMap.get(ExamUser.ExamUserType.USER));
            }

            processExamUser(examUsers, loginNameMap, errorMap, referIds);
            if (MapUtils.isNotEmpty(errorMap)) {
                processErrorTemplate(workbook, errorMap);
                return new ArrayList<>(0);
            }

            return examUsers;
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error(e);
            if (workbook != null) {
                packageErrorMsg(errorMap, startRowNum, 3, e.getMessage());
                try {
                    processErrorTemplate(workbook, errorMap);
                } catch (IOException e1) {
                    LOG.error(e1);
                }
            }

            return new ArrayList<>(0);
        }
    }

    private ExamUser packageExamUser(int index, Row contentRow, boolean enableTicket, Map<Integer, Map<Integer, String>> errorMap) {
        String loginName = ExcelUtils.getStringValue(contentRow.getCell(0));
        String userName = ExcelUtils.getStringValue(contentRow.getCell(1));
        String ticketNum = ExcelUtils.getStringValue(contentRow.getCell(2));
        if (StringUtils.isBlank(ticketNum) && StringUtils.isBlank(loginName) && StringUtils.isBlank(userName)) {
            return null;
        }

        ExamUser examUser = new ExamUser();
        if (StringUtils.isBlank(loginName)) {
            packageErrorMsg(errorMap, index, 0, "用户名为空！");
        } else if (loginName.length() > 50) {
            packageErrorMsg(errorMap, index, 0, "用户名长度不能超过50！");
        }

        if (StringUtils.isBlank(userName)) {
            packageErrorMsg(errorMap, index, 1, "姓名为空！");
        } else if (userName.length() > 50) {
            packageErrorMsg(errorMap, index, 1, "姓名长度不能超过50！");
        }

        if (enableTicket) {
            if (StringUtils.isBlank(ticketNum)) {
                packageErrorMsg(errorMap, index, 2, "准考证号为空！");
            } else if (ticketNum.length() > 20) {
                packageErrorMsg(errorMap, index, 2, "准考证号长度不能超过20！");
            }
        }

        if (enableTicket) {
            examUser.setTicket(ticketNum);
        }

        examUser.setReferType(ExamUser.ExamUserType.USER);
        examUser.setLoginName(loginName);
        examUser.setUserName(userName);
        return examUser;
    }

    private void packageErrorMsg(Map<Integer, Map<Integer, String>> errorMap, int rowNum, int cellNum, String errMsg) {
        Map<Integer, String> cellErrorMap = errorMap.get(rowNum);
        if (cellErrorMap == null) {
            cellErrorMap = new HashMap<>();
            errorMap.put(rowNum, cellErrorMap);
        }

        cellErrorMap.put(cellNum, errMsg);
    }

    private void processExamUser(List<ExamUser> examUsers, Map<String, Integer> loginNameMap, Map<Integer, Map<Integer, String>> errorMap, Set<String> referIds) {
        UserService userService = SpringContextHolder.getBean("userService");
        List<String> loginNames = examUsers.stream().map(ExamUser::getLoginName).collect(Collectors.toList());
        Map<String, ExamUser> examUserMap = examUsers.stream().collect(Collectors.toMap(ExamUser::getLoginName, examUser -> examUser));
        Map<String, User> userMap = userService.findByLogin(loginNames);
        List<User> users = new ArrayList<>();
        loginNameMap.forEach((loginName, rowIndex) -> {
            ExamUser examUser = examUserMap.get(loginName);
            if (MapUtils.isEmpty(userMap) || !userMap.containsKey(loginName)) {
                User user = new User();
                user.setLoginName(examUser.getLoginName());
                user.setUserName(examUser.getUserName());
                userMap.put(user.getLoginName(), user);
                users.add(user);
                return;
            }

            User user = userMap.get(loginName);
            if (!user.getStatus().equals(User.UserStatus.ENABLE)) {
                packageErrorMsg(errorMap, rowIndex, 0, "该人员被冻结");
            } else if (!user.getUserName().equals(examUser.getUserName())) {
                packageErrorMsg(errorMap, rowIndex, 1, "用户名和姓名不匹配");
            } else if (CollectionUtils.isNotEmpty(referIds) && referIds.contains(user.getId())) {
                packageErrorMsg(errorMap, rowIndex, 0, "用户已存在");
            }

        });

        if (MapUtils.isNotEmpty(errorMap)) {
            return;
        }

        if (CollectionUtils.isNotEmpty(users)) {
            userService.save(users);
        }

        ExamArrange examArrange = examUsers.get(0).getExamArrange();
        ExamUserService examUserService = SpringContextHolder.getBean("examUserService");
        Double showOrder = examUserService.getMaxShowOrder(examArrange.getExam().getId(), examArrange.getId());
        for (ExamUser examUser : examUsers) {
            User user = userMap.get(examUser.getLoginName());
            examUser.setShowOrder(++showOrder);
            examUser.setReferId(user.getId());
        }

    }


    private void processErrorTemplate(Workbook workbook, Map<Integer, Map<Integer, String>> errorMap) throws IOException {
        Sheet sheet = workbook.getSheetAt(0);
        int lastRowNum = sheet.getLastRowNum() + 1;
        int startRowNum = 3;
        CellStyle msgCellStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setColor(HSSFColor.RED.index);
        msgCellStyle.setFont(font);
        if (lastRowNum <= startRowNum) {
            Cell errMsgCell = sheet.createRow(startRowNum).createCell(2);
            errMsgCell.setCellValue(errorMap.get(startRowNum).get(-1));
            errMsgCell.setCellStyle(msgCellStyle);
            makeErrorFile(workbook);
            return;
        }

        CellStyle errCellStyle = getBorderStyle(workbook);
        for (int index = startRowNum; index < lastRowNum; index++) {
            Map<Integer, String> cellErrorMap = errorMap.get(index);
            if (MapUtils.isEmpty(cellErrorMap)) {
                continue;
            }

            Row contentRow = sheet.getRow(index);
            if (contentRow.getCell(0) == null && contentRow.getCell(1) == null
                    && contentRow.getCell(2) == null) {
                continue;
            }

            StringBuilder stringBuilder = new StringBuilder();
            for (Integer cellIndex : cellErrorMap.keySet()) {
                Cell contentCell = contentRow.getCell(cellIndex);
                if (contentCell == null) {
                    contentCell = contentRow.createCell(cellIndex);
                }

                contentCell.setCellStyle(errCellStyle);
                stringBuilder.append(cellErrorMap.get(cellIndex));
            }

            Cell errMsgCell = contentRow.createCell(3);
            errMsgCell.setCellStyle(msgCellStyle);
            errMsgCell.setCellValue(stringBuilder.toString());
        }

        makeErrorFile(workbook);
    }


    private void makeErrorFile(Workbook workbook) throws IOException {
        FileServerService fileServerService = SpringContextHolder.getBean("fileServerService");
        String storagePath = fileServerService.getTemplatePath(PeFile.TemplateType.EXAM, PeFile.ProcessorType.FILE);
        storagePath += PeConstant.ERROR + PeConstant.BACKSLASH + ExecutionContext.getUserId() + PeConstant.BACKSLASH +
                "errorExamUserImport.xls";
        storagePath = PropertiesUtils.getEnvProp().getProperty("file.upload.path") + PeConstant.BACKSLASH + storagePath;
        ExcelUtils.makeErrorFile(workbook, storagePath);
    }

    private CellStyle getBorderStyle(Workbook workbook) {
        CellStyle errCellStyle = workbook.createCellStyle();
        errCellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
        errCellStyle.setBottomBorderColor(HSSFColor.RED.index);
        errCellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
        errCellStyle.setLeftBorderColor(HSSFColor.RED.index);
        errCellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
        errCellStyle.setTopBorderColor(HSSFColor.RED.index);
        errCellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
        errCellStyle.setRightBorderColor(HSSFColor.RED.index);
        return errCellStyle;
    }

}
