package com.qgutech.km.module.sfm.service;

import com.qgutech.km.module.sfm.model.PeFile;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.utils.PeDateUtils;
import com.qgutech.km.utils.PeException;
import com.qgutech.km.utils.PropertiesUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * file server service
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月10日10:29:26
 */
@Service("fileServerService")
public class FileServerServiceImpl extends BaseServiceImpl<PeFile> implements FileServerService {

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public PeFile storageFile(PeFile peFile, byte[] data) throws IOException {
        if (peFile == null || peFile.getFsType() == null || StringUtils.isBlank(peFile.getSuffix()) ||
                ArrayUtils.isEmpty(data) || peFile.getProcessorType() == null ||
                peFile.getTemplateType() == null) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        peFile.setCorpCode(ExecutionContext.getCorpCode());
        super.save(peFile);
        return upload(peFile, data);
    }

    @Override
    public PeFile upload(PeFile peFile, byte[] data) throws IOException {
        if (peFile == null || peFile.getFsType() == null || StringUtils.isBlank(peFile.getId()) ||
                StringUtils.isBlank(peFile.getSuffix()) || ArrayUtils.isEmpty(data) || peFile.getProcessorType() == null ||
                peFile.getTemplateType() == null) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        String filePath = getStoragePath(peFile);
        String storageRootPath = PropertiesUtils.getEnvProp().getProperty("file.upload.path");
        File file = new File(storageRootPath + PeConstant.BACKSLASH + filePath);
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }

        OutputStream outputStream = null;
        try {
            outputStream = new FileOutputStream(file);
            outputStream.write(data);
            filePath = PropertiesUtils.getEnvProp().getProperty("file.access.path") + PeConstant.BACKSLASH + filePath;
            peFile.setFilePath(filePath);
        } finally {
            IOUtils.closeQuietly(outputStream);
        }

        return peFile;
    }

    @Override
    public String getTemplatePath(PeFile.TemplateType templateType, PeFile.ProcessorType processorType) {
        if (processorType == null || templateType == null) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        PeFile peFile = new PeFile();
        peFile.setProcessorType(processorType);
        peFile.setTemplateType(templateType);
        peFile.setFsType(PeFile.FsType.TEMPLATE);
        return getStoragePath(peFile);
    }

    @Override
    @Transactional(readOnly = true)
    public PeFile subImage(String fileId, int imgX, int imgY, int imgW, int imgH) {
        if (StringUtils.isBlank(fileId) || imgX < 0 || imgY < 0 || imgW < 0 || imgH < 0) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        PeFile peFile = get(fileId, PeFile.ID, PeFile._fsType, PeFile._referId, PeFile._processorType, PeFile._suffix,
                PeFile._templateType, PeFile.CREATE_TIME, PeFile.CREATE_BY);
        if (peFile == null || !PeFile.ProcessorType.IMAGE.equals(peFile.getProcessorType())) {
            throw new PeException("源图片不存在");
        }

        String filePath = getStoragePath(peFile);
        String storageRootPath = PropertiesUtils.getEnvProp().getProperty("file.upload.path");
        File file = new File(storageRootPath + PeConstant.BACKSLASH + filePath);
        if (!file.exists()) {
            throw new PeException("源图片不存在");
        }

        BufferedImage bufferedImage;
        try {
            bufferedImage = ImageIO.read(file);
        } catch (IOException e) {
            throw new PeException(e.getMessage());
        }

        int srcWidth = bufferedImage.getWidth();
        int srcHeight = bufferedImage.getHeight();
        if (srcWidth < imgW || srcHeight < imgH) {
            throw new PeException("超过源图片大小范围");
        }

        String fileName = "x" + imgX + "y" + imgY + "w" + imgW + "h" + imgH + PeConstant.POINT + peFile.getSuffix();
        peFile.setFileName(fileName);
        Image image = bufferedImage.getScaledInstance(srcWidth, srcHeight, Image.SCALE_DEFAULT);
        ImageFilter cropFilter = new CropImageFilter(imgX, imgY, imgW, imgH);
        Image img = Toolkit.getDefaultToolkit().createImage(
                new FilteredImageSource(image.getSource(), cropFilter));
        BufferedImage tag = new BufferedImage(imgW, imgH, BufferedImage.TYPE_INT_RGB);
        Graphics graphics = tag.getGraphics();
        graphics.drawImage(img, 0, 0, null);
        graphics.dispose();
        filePath = StringUtils.substringBeforeLast(filePath, PeConstant.BACKSLASH) + PeConstant.BACKSLASH + fileName;
        File targetFile = new File(storageRootPath + PeConstant.BACKSLASH + filePath);
        File targetParentFile = targetFile.getParentFile();
        if (!targetParentFile.exists()) {
            targetParentFile.mkdirs();
        }

        try {
            ImageIO.write(tag, peFile.getSuffix(), targetFile);
        } catch (IOException e) {
            throw new PeException(e.getMessage());
        }

        filePath = PropertiesUtils.getEnvProp().getProperty("file.access.path") + PeConstant.BACKSLASH + filePath;
        peFile.setFilePath(filePath);
        return peFile;
    }

    private String getStoragePath(PeFile peFile) {
        String storagePath = ExecutionContext.getCorpCode() + PeConstant.BACKSLASH + peFile.getTemplateType().getText()
                + PeConstant.BACKSLASH + peFile.getProcessorType().getText() + PeConstant.BACKSLASH;
        switch (peFile.getFsType()) {
            case COMMON:
                String timeStr = PeDateUtils.format(peFile.getCreateTime(), "yyMM");
                storagePath = storagePath + PeFile.FsType.COMMON.getText() + PeConstant.BACKSLASH + timeStr
                        + PeConstant.BACKSLASH;
                if (StringUtils.isNotBlank(peFile.getReferId())) {
                    storagePath += peFile.getReferId() + PeConstant.BACKSLASH;
                }

                switch (peFile.getProcessorType()) {
                    case IMAGE:
                        return storagePath + peFile.getId() + PeConstant.BACKSLASH + PeFile.IMAGE_NAME + PeConstant.POINT + peFile.getSuffix();
                    default:
                        return storagePath + peFile.getId() + PeConstant.POINT + peFile.getSuffix();
                }

            case VIDEOTAPE:
                timeStr = PeDateUtils.format(peFile.getCreateTime(), "yyMM");
                storagePath = storagePath + PeFile.FsType.VIDEOTAPE.getText() + PeConstant.BACKSLASH + timeStr + PeConstant.BACKSLASH;
                if (StringUtils.isNotBlank(peFile.getExamId()) && StringUtils.isNotBlank(peFile.getArrangeId())) {
                    storagePath = storagePath + peFile.getExamId() + PeConstant.BACKSLASH + peFile.getArrangeId() + PeConstant.BACKSLASH;
                }

                switch (peFile.getProcessorType()) {
                    case IMAGE:
                        storagePath += peFile.getCreateBy() + PeConstant.BACKSLASH;
                        return storagePath + "images" + PeConstant.BACKSLASH + peFile.getId() + PeConstant.POINT + peFile.getSuffix();
                    case PRINT_IMAGE:
                        storagePath += peFile.getReferId() + PeConstant.BACKSLASH;
                        return storagePath + "printImage" + PeConstant.BACKSLASH + peFile.getId() + PeConstant.POINT + peFile.getSuffix();
                    default:
                        storagePath += peFile.getCreateBy() + PeConstant.BACKSLASH;
                        return storagePath + peFile.getId() + PeConstant.POINT + peFile.getSuffix();
                }

            case PHOTOGRAPH:
                timeStr = PeDateUtils.format(peFile.getCreateTime(), "yyMM");
                return storagePath + PeFile.FsType.PHOTOGRAPH.getText() + PeConstant.BACKSLASH + timeStr + PeConstant.BACKSLASH + peFile.getReferId() +
                        PeConstant.BACKSLASH + peFile.getCreateBy() + PeConstant.BACKSLASH +
                        peFile.getId() + PeConstant.POINT + peFile.getSuffix();
            case TEMPLATE:
                return storagePath + PeFile.FsType.TEMPLATE.getText() + PeConstant.BACKSLASH;
            default:
        }

        return null;
    }

    @Override
    @Transactional(readOnly = true)
    public String getFilePath(String fileId) {
        if (StringUtils.isBlank(fileId)) {
            throw new PeException("File id is blank!");
        }

        PeFile peFile = get(fileId, PeFile.ID, PeFile._fsType, PeFile._referId, PeFile._processorType, PeFile._suffix,
                PeFile._templateType, PeFile.CREATE_TIME, PeFile.CREATE_BY);
        if (peFile == null) {
            return null;
        }

        return getFilePath(peFile);
    }

    @Override
    public String getFilePath(PeFile peFile) {
        if (peFile == null || StringUtils.isBlank(peFile.getId()) || peFile.getFsType() == null ||
                StringUtils.isBlank(peFile.getSuffix()) || peFile.getProcessorType() == null ||
                peFile.getTemplateType() == null) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        String filePath = getStoragePath(peFile);
        return PropertiesUtils.getEnvProp().getProperty("file.access.path") + PeConstant.BACKSLASH + filePath;
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, String> findFilePath(List<String> fileIds) {
        List<PeFile> files = listByIds(fileIds, PeFile.ID, PeFile._fsType, PeFile._referId, PeFile._processorType, PeFile._suffix,
                PeFile._templateType, PeFile.CREATE_TIME, PeFile.CREATE_BY);
        if (CollectionUtils.isEmpty(files)) {
            return new HashMap<>(0);
        }

        if (CollectionUtils.isEmpty(files)) {
            return new HashMap<>(0);
        }

        Map<String, String> filePathMap = new HashMap<>(files.size());
        for (PeFile file : files) {
            String filePath = getFilePath(file);
            filePathMap.put(file.getId(), filePath);
        }

        return filePathMap;
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, String> findFilePath(List<String> fileIds, String examId, String arrangeId) {
        if (CollectionUtils.isEmpty(fileIds) || StringUtils.isBlank(examId) || StringUtils.isBlank(arrangeId)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        List<PeFile> files = listByIds(fileIds, PeFile.ID, PeFile._fsType, PeFile._referId,
                PeFile._processorType, PeFile._suffix, PeFile._templateType, PeFile.CREATE_TIME, PeFile.CREATE_BY);
        Map<String, String> fileMap = new HashMap<>(files.size());
        for (PeFile file : files) {
            file.setExamId(examId);
            file.setArrangeId(arrangeId);
            String filePath = getFilePath(file);
            fileMap.put(file.getId(), filePath);
        }

        return fileMap;
    }
}
