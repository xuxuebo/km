package com.qgutech.km.module.sfm.service;

import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.sfm.model.PeFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * 文件服务器接口
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年9月1日09:42:19
 */
public interface FileServerService extends BaseService<PeFile> {

    /**
     * 上传文件
     *
     * @param peFile 上传文件类型
     *               <ul>
     *               <li>{@linkplain PeFile#fsType 功能类型；不可为空}
     *               <ol>
     *               <li>{@linkplain PeFile.FsType#COMMON 公用功能}</li>
     *               <li>{@linkplain PeFile.FsType#TEMPLATE 上传下载模板}</li>
     *               <li>{@linkplain PeFile.FsType#VIDEOTAPE 监控}</li>
     *               <li>{@linkplain PeFile.FsType#PHOTOGRAPH 学生答卷拍照}</li>
     *               </ol>
     *               </li>
     *               <li>{@linkplain PeFile#templateType 模板类型；不可为空}
     *               <ol>
     *               <li>{@linkplain PeFile.TemplateType#USER 用户模板}</li>
     *               <li>{@linkplain PeFile.TemplateType#ITEM 试题}</li>
     *               <li>{@linkplain PeFile.TemplateType#EXAM 考试}</li>
     *               </ol>
     *               </li>
     *               <li>{@linkplain PeFile#processorType 文件类型；不可为空}
     *               <ol>
     *               <li>{@linkplain PeFile.ProcessorType#VIDEO 视频}</li>
     *               <li>{@linkplain PeFile.ProcessorType#AUDIO 音频}</li>
     *               <li>{@linkplain PeFile.ProcessorType#IMAGE 图片}</li>
     *               <li>{@linkplain PeFile.ProcessorType#FILE 文件}</li>
     *               </ol>
     *               </li>
     *               <li>{@linkplain PeFile#fileName 文件名称}</li>
     *               <li>{@linkplain PeFile#fileSize 文件大小}</li>
     *               <li>{@linkplain PeFile#referId 关联ID}</li>
     *               </ul>
     * @param data   字节信息
     * @return 返回信息
     * <ul>
     * <li>{@linkplain PeFile#id 主键}</li>
     * <li>{@linkplain PeFile#filePath 文件路径}</li>
     * </ul>
     * @since 2017年3月13日19:33:03
     */
    PeFile storageFile(PeFile peFile, byte[] data) throws IOException;

    /**
     * 上传文件不保存数据库
     *
     * @param peFile 上传文件类型
     *               <ul>
     *               <li>{@linkplain PeFile#fsType 功能类型；不可为空}
     *               <ol>
     *               <li>{@linkplain PeFile.FsType#COMMON 公用功能}</li>
     *               <li>{@linkplain PeFile.FsType#TEMPLATE 上传下载模板}</li>
     *               <li>{@linkplain PeFile.FsType#VIDEOTAPE 监控}</li>
     *               <li>{@linkplain PeFile.FsType#PHOTOGRAPH 学生答卷拍照}</li>
     *               </ol>
     *               </li>
     *               <li>{@linkplain PeFile#templateType 模板类型；不可为空}
     *               <ol>
     *               <li>{@linkplain PeFile.TemplateType#USER 用户模板}</li>
     *               <li>{@linkplain PeFile.TemplateType#ITEM 试题}</li>
     *               <li>{@linkplain PeFile.TemplateType#EXAM 考试}</li>
     *               </ol>
     *               </li>
     *               <li>{@linkplain PeFile#processorType 文件类型；不可为空}
     *               <ol>
     *               <li>{@linkplain PeFile.ProcessorType#VIDEO 视频}</li>
     *               <li>{@linkplain PeFile.ProcessorType#AUDIO 音频}</li>
     *               <li>{@linkplain PeFile.ProcessorType#IMAGE 图片}</li>
     *               <li>{@linkplain PeFile.ProcessorType#FILE 文件}</li>
     *               </ol>
     *               </li>
     *               <li>{@linkplain PeFile#fileName 文件名称}</li>
     *               <li>{@linkplain PeFile#fileSize 文件大小}</li>
     *               <li>{@linkplain PeFile#referId 关联ID}</li>
     *               </ul>
     * @param data   字节信息
     * @return 返回信息
     * <ul>
     * <li>{@linkplain PeFile#id UUID}</li>
     * <li>{@linkplain PeFile#filePath 文件路径}</li>
     * </ul>
     * @since 2017年3月13日19:33:03
     */
    PeFile upload(PeFile peFile, byte[] data) throws IOException;

    /**
     * 【获取模板地址】
     *
     * @param templateType  模板类型
     * @param processorType 文件类型
     * @return 模板路径
     * @since 2017年6月21日12:22:42
     */
    String getTemplatePath(PeFile.TemplateType templateType, PeFile.ProcessorType processorType);

    /**
     * 【裁剪图片】
     *
     * @param fileId 文件ID
     * @param imgX   X量
     * @param imgY   Y量
     * @param imgW   W量
     * @param imgH   H量
     * @return 返回信息
     * <ul>
     * <li>{@linkplain PeFile#id 主键}</li>
     * <li>{@linkplain PeFile#filePath 文件路径}</li>
     * </ul>
     * @since 2017年6月20日16:53:13
     */
    PeFile subImage(String fileId, int imgX, int imgY, int imgW, int imgH);

    /**
     * 通过fileId 获取文件路径
     *
     * @param fileId 文件索引
     * @return file path
     * @since 2016年9月2日14:10:03
     */
    String getFilePath(String fileId);

    /**
     * 获取文件路径
     *
     * @param peFile 文件
     * @return file path
     * @since 2016年9月2日14:10:03
     */
    String getFilePath(PeFile peFile);

    /**
     * 通过fileId 获取文件路径
     *
     * @param fileIds 文件索引
     * @return file path
     * @since 2016年9月2日14:10:03
     */
    Map<String, String> findFilePath(List<String> fileIds);

    /**
     * 通过fileId 获取文件路径
     *
     * @param fileIds 文件索引
     * @return file path
     * @since 2016年9月2日14:10:03
     */
    Map<String, String> findFilePath(List<String> fileIds, String examId, String arrangeId);
}
