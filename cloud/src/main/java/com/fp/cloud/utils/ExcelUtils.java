package com.fp.cloud.utils;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xwpf.usermodel.XWPFDocument;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * excel utils
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月18日10:54:32
 */
public class ExcelUtils {

    public static Row createRow(Sheet sheet, int rowNum, int cellRow, String message,
                                CellStyle cellStyle) {
        Row row = sheet.createRow(rowNum);
        Cell cell = row.createCell(cellRow);
        cell.setCellValue(message);
        cell.setCellStyle(cellStyle);
        return row;
    }

    public static Row createRow(Sheet sheet, int rowNum, String message, CellStyle cellStyle) {
        return createRow(sheet, rowNum, 0, message, cellStyle);
    }

    public static CellStyle createCellStyle(Workbook workbook, Font font) {
        CellStyle cellStyle = workbook.createCellStyle();
        cellStyle.setFont(font);
        return cellStyle;
    }

    public static CellStyle createCellStyle(Workbook workbook) {
        return workbook.createCellStyle();
    }

    public static Font createFont(Workbook workbook, short color, short fontSize) {
        Font font = workbook.createFont();
        font.setColor(color);
        font.setFontHeightInPoints(fontSize);
        return font;
    }

    public static String replaceBlank(String str) {
        if (str != null) {
            Pattern p = Pattern.compile("\\s*|\t|\r|\n");
            Matcher m = p.matcher(str);
            return m.replaceAll("");
        }

        return null;
    }

    public static void exportExcel(HttpServletRequest request, HttpServletResponse response, String excelName) throws IOException {
        response.setContentType("application/vnd.ms-excel");
        if ("FF".equals(HttpUtils.getBrowser(request))) {
            excelName = new String(excelName.getBytes("UTF-8"), "iso-8859-1");
        } else {
            excelName = URLEncoder.encode(excelName, "UTF-8");
        }

        response.setHeader("content-disposition", "attachment;filename=" + excelName + ".xls");
    }

    public static void exportWord(HttpServletRequest request, HttpServletResponse response, String wordName) throws IOException {
        response.setContentType("application/msword");
        if ("FF".equals(HttpUtils.getBrowser(request))) {
            wordName = new String(wordName.getBytes("UTF-8"), "iso-8859-1");
        } else {
            wordName = URLEncoder.encode(wordName, "UTF-8");
        }

        response.setHeader("content-disposition", "attachment;filename=" + wordName + ".docx");
    }


    public static void exportExcel(HttpServletRequest request, HttpServletResponse response, String filePath, String excelName) throws IOException {
        File file = new File(filePath);
        if (!file.exists()) {
            return;
        }

        String fileName = file.getName();
        if (fileName.endsWith(".docx")) {
            exportWord(request, response, excelName);
        } else {
            exportExcel(request, response, excelName);
        }

        OutputStream outputStream = null;
        InputStream inputStream = null;
        try {
            outputStream = response.getOutputStream();
            inputStream = new FileInputStream(file);
            byte[] data = new byte[inputStream.available()];
            inputStream.read(data);
            outputStream.write(data);
            outputStream.flush();
        } finally {
            IOUtils.closeQuietly(inputStream);
            IOUtils.closeQuietly(outputStream);
        }
    }

    public static void makeErrorFile(Workbook workbook, String filePath) throws IOException {
        OutputStream outputStream = null;
        try {
            outputStream = getOutputStream(filePath);
            workbook.write(outputStream);
            outputStream.flush();
        } finally {
            IOUtils.closeQuietly(outputStream);
        }
    }

    private static OutputStream getOutputStream(String filePath) throws FileNotFoundException {
        File errorFile = new File(filePath);
        if (!errorFile.getParentFile().exists()) {
            errorFile.getParentFile().mkdirs();
        }

        return new FileOutputStream(filePath);
    }

    public static void makeErrorWordFile(XWPFDocument document, String filePath) throws IOException {
        OutputStream outputStream = null;
        try {
            outputStream = getOutputStream(filePath);
            document.write(outputStream);
            outputStream.flush();
        } finally {
            IOUtils.closeQuietly(outputStream);
        }
    }


    public static String getStringValue(Cell cell) {
        if (cell == null) {
            return StringUtils.EMPTY;
        }

        switch (cell.getCellType()) {
            case Cell.CELL_TYPE_NUMERIC:
                double doubleVal = cell.getNumericCellValue();
                long longVal = Math.round(cell.getNumericCellValue());
                Object inputValue;// 单元格值
                if (Double.parseDouble(longVal + ".0") == doubleVal) {
                    inputValue = longVal;
                } else {
                    inputValue = doubleVal;
                }

                return inputValue + StringUtils.EMPTY;
            default:
                String cellValue = cell.getStringCellValue();
                if (StringUtils.isBlank(cellValue)) {
                    return StringUtils.EMPTY;
                }

                return cellValue.trim();
        }
    }
}
