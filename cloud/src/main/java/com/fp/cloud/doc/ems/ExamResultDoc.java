package com.fp.cloud.doc.ems;


import com.fp.cloud.constant.PeConstant;
import com.fp.cloud.module.ems.model.Exam;
import com.fp.cloud.module.ems.model.ExamMonitor;
import com.fp.cloud.module.sfm.model.PeFile;
import com.fp.cloud.module.sfm.service.FileServerService;
import com.fp.cloud.module.uc.model.User;
import com.fp.cloud.utils.*;
import com.fp.cloud.base.ExecutionContext;
import com.fp.cloud.module.ems.model.ExamResult;
import com.fp.cloud.utils.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.DVConstraint;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataValidation;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddressList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.*;
import java.util.stream.Collectors;

public final class ExamResultDoc {

    private static final Log LOG = LogFactory.getLog(ExamResultDoc.class);

    private ExamResultDoc() {
    }

    public static ExamResultDoc newInstance() {
        return new ExamResultDoc();
    }

    /**
     * 下载线下考试模板
     *
     * @param users        人员信息
     * @param exam         考试信息
     * @param templatePath 模板路径
     * @param coverMark    折合分数
     * @since 2017年1月14日11:00:06
     */
    public void processExamResultTemplate(List<User> users, Exam exam, String templatePath, Double coverMark,
                                          HttpServletResponse response, HttpServletRequest request) {
        OutputStream outputStream = null;
        try {
            outputStream = response.getOutputStream();
            Workbook workbook = new HSSFWorkbook(new FileInputStream(templatePath));
            Sheet sheet = workbook.getSheetAt(0);
            Row headRow = sheet.getRow(1);
            Cell examCell = headRow.createCell(1);
            examCell.setCellValue(exam.getExamName() + "(" + exam.getExamCode() + ")");
            Cell markCell = headRow.createCell(3);
            markCell.setCellValue(coverMark);
            if (CollectionUtils.isNotEmpty(users)) {
                DVConstraint constraint = DVConstraint.createExplicitListConstraint(new String[]{"是", "否"});
                CellRangeAddressList regions = new CellRangeAddressList(4, 3 + users.size(), 3, 3);
                HSSFDataValidation hssfDataValidation = new HSSFDataValidation(regions, constraint);
                sheet.addValidationData(hssfDataValidation);
                for (int index = 0; index < users.size(); index++) {
                    Row userRow = sheet.getRow(4 + index);
                    if (userRow == null) {
                        userRow = sheet.createRow(4 + index);
                    }

                    Cell cell = userRow.createCell(0);
                    cell.setCellValue(users.get(index).getUserName());
                    cell = userRow.createCell(1);
                    cell.setCellValue(users.get(index).getLoginName());
                }
            }

            if (templatePath.endsWith(".xls")) {
                response.setContentType("application/vnd.ms-excel");
            } else if (templatePath.endsWith(".xlsx")) {
                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            }
            String filenamedisplay = URLEncoder.encode(exam.getExamName()) + ".xls";
            if ("FF".equals(HttpUtils.getBrowser(request))) {
                // 针对火狐浏览器处理方式不一样了
                filenamedisplay = new String(exam.getExamName().getBytes("UTF-8"),
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


    public List<ExamResult> processImportExamResult(Exam exam, List<ExamMonitor> examMonitors, Double coverMark, InputStream inputStream) {
        Map<Integer, Map<Integer, String>> errorMap = new HashMap<>();
        int startRowNum = 4;
        Workbook workbook = null;

        try {
            workbook = new HSSFWorkbook(inputStream);
            Sheet sheet = workbook.getSheetAt(0);
            if (CollectionUtils.isEmpty(examMonitors)) {
                packageErrorMsg(errorMap, startRowNum, -1, "考试不存在！");
                processErrorTemplate(workbook, exam.getId(), errorMap);
                return new ArrayList<>(0);
            }

            int lastRowNum = sheet.getLastRowNum() + 1;
            if (lastRowNum < startRowNum + 1) {
                packageErrorMsg(errorMap, startRowNum, -1, "表格内容为空！");
                processErrorTemplate(workbook, exam.getId(), errorMap);
                return new ArrayList<>(0);
            }

            Map<String, ExamMonitor> examMonitorMap = examMonitors.stream().collect(Collectors.toMap(examMonitor ->
                    examMonitor.getUser().getLoginName(), examMonitor -> examMonitor));
            Set<String> loginNames = new HashSet<>(lastRowNum - startRowNum);
            List<ExamResult> examResults = new ArrayList<>();
            for (int index = startRowNum; index < lastRowNum; index++) {
                boolean valid = true;
                Row contentRow = sheet.getRow(index);
                if (contentRow.getCell(0) == null && contentRow.getCell(1) == null
                        && contentRow.getCell(2) == null && contentRow.getCell(3) == null) {
                    continue;
                }

                String userName = ExcelUtils.getStringValue(contentRow.getCell(0));
                if (StringUtils.isBlank(userName)) {
                    packageErrorMsg(errorMap, index, 0, "人员信息有误！");
                    valid = false;
                }

                String loginName = ExcelUtils.getStringValue(contentRow.getCell(1));
                if (StringUtils.isBlank(loginName)) {
                    packageErrorMsg(errorMap, index, 1, "人员信息有误！");
                    valid = false;
                } else if (loginNames.contains(loginName)) {
                    packageErrorMsg(errorMap, index, 1, "人员信息重复！");
                    valid = false;
                }

                String markStr = ExcelUtils.getStringValue(contentRow.getCell(2));
                String passStr = ExcelUtils.getStringValue(contentRow.getCell(3));
                if (StringUtils.isBlank(markStr) && StringUtils.isBlank(passStr)) {
                    ExamMonitor examMonitor = examMonitorMap.get(loginName);
                    if (examMonitor == null || examMonitor.getUser() == null || !examMonitor.getUser().getUserName().equals(userName)) {
                        packageErrorMsg(errorMap, index, 0, "人员信息有误！");
                        continue;
                    }
                    loginNames.add(loginName);
                    ExamResult examResult = getMissExamResult(exam, examMonitor, coverMark);
                    examResults.add(examResult);
                    continue;
                }
                double mark = -1;
                if (StringUtils.isBlank(markStr)) {
                    packageErrorMsg(errorMap, index, 2, "成绩为空！");
                    valid = false;
                } else if (NumberUtils.isNumber(markStr)) {
                    mark = Double.parseDouble(markStr);
                    mark = PeNumberUtils.reservedDecimal(1, mark);
                    if (mark < 0) {
                        packageErrorMsg(errorMap, index, 2, "成绩非法！");
                        valid = false;
                    }

                    if (mark > coverMark) {
                        packageErrorMsg(errorMap, index, 2, "成绩超过试卷满分，满分为" + coverMark);
                        valid = false;
                    }

                } else {
                    packageErrorMsg(errorMap, index, 2, "成绩非法！");
                    valid = false;
                }

                if (StringUtils.isBlank(passStr) || (!"是".equals(passStr) && !"否".equals(passStr) && !"缺考".equals(passStr))) {
                    packageErrorMsg(errorMap, index, 3, "结果非法！");
                    valid = false;
                }

                if (!valid) {
                    continue;
                }

                ExamMonitor examMonitor = examMonitorMap.get(loginName);
                if (examMonitor == null || examMonitor.getUser() == null || !examMonitor.getUser().getUserName().equals(userName)) {
                    packageErrorMsg(errorMap, index, 0, "人员信息有误！");
                    continue;
                }

                loginNames.add(loginName);
                ExamResult examResult = new ExamResult();
                examResult.setUser(examMonitor.getUser());
                examResult.setExam(exam);
                examResult.setScore("缺考".equals(passStr) ? -1D : mark);
                examResult.setJudgeFlag(ExamResult.JudgeFlag.AUTO);
                examResult.setExamCount(NumberUtils.INTEGER_ONE);
                examResult.setPass("是".equals(passStr));
                examResult.setStatus(ExamResult.UserExamStatus.WAIT_RELEASE);
                examResult.setPublishTime(new Date());
                examResult.setExamArrange(examMonitor.getExamArrange());
                examResult.setCorpCode(ExecutionContext.getCorpCode());
                examResult.setTotalScore(coverMark);
                examResults.add(examResult);
            }

            if (MapUtils.isNotEmpty(errorMap)) {
                processErrorTemplate(workbook, exam.getId(), errorMap);
                return new ArrayList<>(0);
            }

            packageMissExamResult(examMonitors, exam, examResults, coverMark);
            return examResults;
        } catch (IOException e) {
            LOG.error(e);
            return new ArrayList<>(0);
        }
    }

    private ExamResult getMissExamResult(Exam exam, ExamMonitor examMonitor, Double coverMark) {
        ExamResult examResult = new ExamResult();
        examResult.setUser(examMonitor.getUser());
        examResult.setExam(exam);
        examResult.setJudgeFlag(ExamResult.JudgeFlag.AUTO);
        examResult.setExamCount(NumberUtils.INTEGER_ONE);
        examResult.setScore(-1D);
        examResult.setStatus(ExamResult.UserExamStatus.WAIT_RELEASE);
        examResult.setTotalScore(coverMark);
        examResult.setExamArrange(examMonitor.getExamArrange());
        examResult.setCorpCode(ExecutionContext.getCorpCode());
        return examResult;
    }

    private void packageMissExamResult(List<ExamMonitor> examMonitors, Exam exam, List<ExamResult> examResults, Double coverMark) {
        Set<String> userIds = examResults.stream().map(examResult -> examResult.getUser().getId()).collect(Collectors.toSet());
        for (ExamMonitor examMonitor : examMonitors) {
            if (examMonitor.getSubmitTime() != null || userIds.contains(examMonitor.getUser().getId())) {
                continue;
            }

            ExamResult examResult = getMissExamResult(exam, examMonitor, coverMark);
            examResults.add(examResult);
        }
    }

    private void packageErrorMsg(Map<Integer, Map<Integer, String>> errorMap, int rowNum, int cellNum, String errMsg) {
        Map<Integer, String> cellErrorMap = errorMap.get(rowNum);
        if (cellErrorMap == null) {
            cellErrorMap = new HashMap<>();
            errorMap.put(rowNum, cellErrorMap);
        }

        cellErrorMap.put(cellNum, errMsg);
    }

    private void processErrorTemplate(Workbook workbook, String examId, Map<Integer, Map<Integer, String>> errorMap) throws IOException {
        Sheet sheet = workbook.getSheetAt(0);
        int lastRowNum = sheet.getLastRowNum() + 1;
        int startRowNum = 4;
        CellStyle msgCellStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setColor(HSSFColor.RED.index);
        msgCellStyle.setFont(font);
        if (lastRowNum < startRowNum + 1) {
            Cell errMsgCell = sheet.createRow(startRowNum).createCell(4);
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
                    && contentRow.getCell(2) == null && contentRow.getCell(3) == null) {
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

            Cell errMsgCell = contentRow.createCell(4);


            errMsgCell.setCellStyle(msgCellStyle);
            errMsgCell.setCellValue(stringBuilder.toString());
        }

        makeErrorFile(workbook);
    }

    private void makeErrorFile(Workbook workbook) throws IOException {
        FileServerService fileServerService = SpringContextHolder.getBean("fileServerService");
        String storagePath = fileServerService.getTemplatePath(PeFile.TemplateType.ITEM, PeFile.ProcessorType.FILE);
        storagePath += PeConstant.ERROR + PeConstant.BACKSLASH + ExecutionContext.getUserId() + PeConstant.BACKSLASH +
                "errorExamResultImport.xls";
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
