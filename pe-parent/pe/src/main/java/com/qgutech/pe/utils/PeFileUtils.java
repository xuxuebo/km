package com.qgutech.pe.utils;

import com.mchange.lang.ByteUtils;
import com.qgutech.pe.constant.PeConstant;
import com.qgutech.pe.module.sfm.model.PeFile;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.util.Assert;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

/**
 * file utils
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月10日17:36:20
 */
public class PeFileUtils {

    private static final Log LOG = LogFactory.getLog(PeFileUtils.class);

    /**
     * 根据文件类型获取文件大小最大限制
     *
     * @param processorType 文件类型
     * @return 大小限制
     * @since 2016年10月10日17:40:01
     */
    public static long getFileSize(PeFile.ProcessorType processorType) {
        String maxSize = null;
        switch (processorType) {
            case IMAGE:
                maxSize = PropertiesUtils.getConfigProp().getProperty("image.maxSize");
                break;
            case AUDIO:
                maxSize = PropertiesUtils.getConfigProp().getProperty("audio.maxSize");
                break;
            case VIDEO:
                maxSize = PropertiesUtils.getConfigProp().getProperty("video.maxSize");
                break;
        }

        return PeNumberUtils.transformLong(maxSize) * 1024;
    }

    /**
     * 根据文件类型获取文件允许类型
     *
     * @param processorType 文件类型
     * @return 允许类型
     * @since 2016年10月10日17:40:01
     */
    public static String getFileType(PeFile.ProcessorType processorType) {
        switch (processorType) {
            case IMAGE:
                return PropertiesUtils.getConfigProp().getProperty("image.type");
            case AUDIO:
                return PropertiesUtils.getConfigProp().getProperty("audio.type");
            case VIDEO:
                return PropertiesUtils.getConfigProp().getProperty("video.type");
            default:
                return StringUtils.EMPTY;
        }
    }

    /**
     * 获取文件后缀名
     *
     * @param fileName 文件名称
     * @return 后缀名
     * @since 2016年10月10日18:23:34
     */
    public static String getFileSuffix(String fileName) {
        int lastIndex = fileName.lastIndexOf(PeConstant.POINT);
        return fileName.substring(lastIndex + 1);
    }

    /**
     * 字符串压缩
     *
     * @param paramString 字符串
     * @return 压缩后的 ascii 字符串
     * @since 2016年8月30日18:02:22
     */
    public static String compress(String paramString) {
        if (StringUtils.isBlank(paramString)) {
            return null;
        }

        ByteArrayOutputStream byteArrayOutputStream = null;
        ZipOutputStream zipOutputStream = null;
        try {
            byteArrayOutputStream = new ByteArrayOutputStream();
            zipOutputStream = new ZipOutputStream(byteArrayOutputStream);
            zipOutputStream.putNextEntry(new ZipEntry("0"));
            zipOutputStream.write(paramString.getBytes());
            zipOutputStream.closeEntry();
            byte[] arrayOfByte = byteArrayOutputStream.toByteArray();
            return ByteUtils.toHexAscii(arrayOfByte);
        } catch (IOException e) {
            LOG.error(e);
            return null;
        } finally {
            try {
                if (zipOutputStream != null) {
                    zipOutputStream.close();
                }
                if (byteArrayOutputStream != null) {
                    byteArrayOutputStream.close();
                }
            } catch (IOException ex) {
                LOG.error(ex);
            }
        }
    }

    /**
     * 字符串解压
     *
     * @param paramString 字符串
     * @return 解压后的字符串
     * @since 2016年8月30日18:02:22
     */
    public static String decompress(String paramString) {
        if (StringUtils.isBlank(paramString)) {
            return null;
        }

        ByteArrayOutputStream byteArrayOutputStream = null;
        ByteArrayInputStream byteArrayInputStream = null;
        ZipInputStream zipInputStream = null;
        try {
            byte[] data = ByteUtils.fromHexAscii(paramString);
            byteArrayOutputStream = new ByteArrayOutputStream();
            byteArrayInputStream = new ByteArrayInputStream(data);
            zipInputStream = new ZipInputStream(byteArrayInputStream);
            zipInputStream.getNextEntry();
            byte[] arrayOfByte = new byte[1024];
            int index;
            while ((index = zipInputStream.read(arrayOfByte)) > 0) {
                byteArrayOutputStream.write(arrayOfByte, 0, index);
            }

            return byteArrayOutputStream.toString();
        } catch (IOException e) {
            LOG.error(e);
            return null;
        } finally {
            try {
                if (zipInputStream != null) {
                    zipInputStream.close();
                }

                if (byteArrayInputStream != null) {
                    byteArrayInputStream.close();
                }

                if (byteArrayOutputStream != null) {
                    byteArrayOutputStream.close();
                }
            } catch (IOException ex) {
                LOG.error(ex);
            }
        }
    }
}
