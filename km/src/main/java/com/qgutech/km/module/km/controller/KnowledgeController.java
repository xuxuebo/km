package com.qgutech.km.module.km.controller;

import com.alibaba.fastjson.util.IOUtils;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.KnowledgeRel;
import com.qgutech.km.module.km.model.Library;
import com.qgutech.km.module.km.model.Share;
import com.qgutech.km.module.km.service.KnowledgeRelService;
import com.qgutech.km.module.km.service.KnowledgeService;
import com.qgutech.km.module.km.service.LibraryService;
import com.qgutech.km.module.sfm.model.PeFile;
import com.qgutech.km.module.sfm.service.FileServerService;
import com.qgutech.km.module.uc.model.User;
import com.qgutech.km.utils.PeException;
import com.qgutech.km.utils.PeFileUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 文件服务器 控制层
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月10日10:32:33
 */
@Controller
@RequestMapping("km")
public class KnowledgeController {

    private static final Log LOG = LogFactory.getLog(KnowledgeController.class);
    @Resource
    private FileServerService fileServerService;
    @Resource
    private KnowledgeService knowledgeService;
    @Resource
    private KnowledgeRelService knowledgeRelService;
    @Resource
    private LibraryService libraryService;

    @ResponseBody
    @RequestMapping("uploadFile")
    public JsonResult<PeFile> uploadFile(@RequestParam(value = "uploadFile", required = false) MultipartFile multipartFile,
                                         PeFile peFile) throws IOException {
        try {
            // multipartFile.transferTo(new File("D:/1.webm"));
            JsonResult<PeFile> jsonResult = checkFile(multipartFile, peFile);
            if (!jsonResult.isSuccess()) {
                return jsonResult;
            }

            peFile.setId(null);
            peFile = fileServerService.storageFile(peFile, multipartFile.getBytes());
            return new JsonResult<>(true, PeConstant.SUCCESS, peFile);
        } catch (PeException ex) {
            LOG.error(ex);
            return new JsonResult<>(false, ex.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping("saveKnowledge")
    public JsonResult<Knowledge> saveKnowledge(Knowledge knowledge) {
        try {
            if (StringUtils.isBlank(knowledge.getId())) {
                String knowledgeId = knowledgeService.save(knowledge);
                KnowledgeRel knowledgeRel = new KnowledgeRel();
                knowledgeRel.setKnowledgeId(knowledgeId);
                Library myLibrary = libraryService.getUserLibraryByLibraryType("MY_LIBRARY");
                knowledgeRel.setLibraryId(myLibrary.getId());
                knowledgeRelService.save(knowledgeRel);
            } else {
                knowledgeService.update(knowledge);
            }

            return new JsonResult<>(true, JsonResult.SUCCESS);
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping("subImage")
    public JsonResult<PeFile> subImage(String fileId, int imgX, int imgY, int imgW, int imgH) {
        try {
            PeFile peFile = fileServerService.subImage(fileId, imgX, imgY, imgW, imgH);
            return new JsonResult<>(true, PeConstant.SUCCESS, peFile);
        } catch (PeException ex) {
            LOG.error(ex);
            return new JsonResult<>(false, ex.getMessage());
        }
    }


    private JsonResult<PeFile> checkFile(MultipartFile multipartFile, PeFile peFile) {
        if (multipartFile == null || multipartFile.isEmpty()) {
            return new JsonResult<>(false, "请选择文件上传");
        }

        if (peFile == null || peFile.getProcessorType() == null || peFile.getTemplateType() == null || peFile.getFsType() == null) {
            return new JsonResult<>(false, "请选择文件类型");
        }

        String fileName = multipartFile.getOriginalFilename();
        peFile.setFileName(fileName);
        String fileSuffix = PeFileUtils.getFileSuffix(fileName);
        if (StringUtils.isNotBlank(fileSuffix)) {
            peFile.setSuffix(fileSuffix.toLowerCase());
        }

        long fileSize = multipartFile.getSize();
        peFile.setFileSize(fileSize);
        if (!PeFile.FsType.COMMON.equals(peFile.getFsType())) {
            return new JsonResult<>(true, JsonResult.SUCCESS);
        }

        long maxSize = PeFileUtils.getFileSize(peFile.getProcessorType());
        if (maxSize > 0 && maxSize < fileSize) {
            return new JsonResult<>(false, "文件大小已经超过上限，上限 " + (maxSize / 1024) + "KB");
        }

        String fileTypes = PeFileUtils.getFileType(peFile.getProcessorType());
        if (StringUtils.isNotBlank(fileTypes)) {
            List<String> fileTypeList = Arrays.asList(fileTypes.split(PeConstant.COMMA));
            if (!fileTypeList.contains(peFile.getSuffix())) {
                return new JsonResult<>(false, "文件格式不正确，正确格式 " + fileTypes);
            }

        }

        return new JsonResult<>(true, PeConstant.SUCCESS, peFile);
    }

    /**
     * 通过文件路径和文件名创建文件
     *
     * @param path     文件路径不为空
     * @param fileName 文件名不为空
     * @return File 目标文件
     */
    private File getFile(String path, String fileName) {
        if (path == null) {
            throw new PeException("文件路径为空");
        }
        if (fileName == null) {
            throw new PeException("文件名为空");
        }
        File file = new File(path, fileName);
        if (!file.exists()) {
            throw new PeException("目标文件不存在");
        }
        return file;


    }

    /**
     * 下载文件
     * @param request
     * @param response
     * @param knowledgeIds  文件id
     */
    @RequestMapping("downloadKnowledge")
    public void downLoadUserTemplate(HttpServletRequest request, HttpServletResponse response,String knowledgeIds) {
        if(StringUtils.isEmpty(knowledgeIds)){
            return;
        }
        String[] knowledgeIdArr = knowledgeIds.split(",");

        String fileName = "UserTemplate.xls";
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName="
                + fileName);
        OutputStream os = null;
        InputStream inputStream = null;
        try {
            String path = request.getSession().getServletContext().getRealPath("") + "/template";
            inputStream = new FileInputStream(getFile(path, fileName));
            os = response.getOutputStream();
            byte[] b = new byte[2048];
            int length;
            while ((length = inputStream.read(b)) > 0) {
                os.write(b, 0, length);
            }
            os.flush();
        } catch (IOException e) {
            LOG.error(e);
        } finally {
            IOUtils.close(os);
            IOUtils.close(inputStream);
        }
    }

    /**
     * 我的云库
     * createBy
     * 云库表  云库和文件关系表  文件表
     */
    @ResponseBody
    @RequestMapping("manage/search")
    public List<Knowledge> search(){
        List<Knowledge> list = knowledgeService.getKnowledgeByCreateBy(KnowledgeConstant.MY_LIBRARY);
        if(CollectionUtils.isEmpty(list)){
            list = new ArrayList<>(0);
        }
        return list;
    }

    /**
     * 我的回收站文件列表
     *
     * 云库表  云库和文件关系表  文件表
     */
    @ResponseBody
    @RequestMapping("manage/searchRecycle")
    public List<Knowledge> searchRecycle(){
        List<Knowledge> list = knowledgeService.getKnowledgeByCreateBy(KnowledgeConstant.RECYCLE_LIBRARY);
        if(CollectionUtils.isEmpty(list)){
            list = new ArrayList<>(0);
        }
        return list;
    }



    /**
     * 分享到公共库
     * @return
     * 1.添加个人的分享记录
     * 2.在公共库添加此文件记录
     * 3.统计表
     */
    @ResponseBody
    @RequestMapping("shareToPublic")
    public JsonResult shareToPublic(Share share){
        JsonResult jsonResult = new JsonResult();
        int count = knowledgeService.shareToPublic(share);
        if(count<=0){
            jsonResult.setSuccess(false);
            jsonResult.setMessage("分享失败");
        }else{
            jsonResult.setMessage("分享成功");
        }
        return jsonResult;
    }



}
