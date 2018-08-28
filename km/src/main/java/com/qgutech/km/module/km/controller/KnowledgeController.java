package com.qgutech.km.module.km.controller;

import com.qgutech.fs.utils.FsFileManagerUtil;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.redis.PeJedisCommands;
import com.qgutech.km.base.redis.PeRedisClient;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.KnowledgeLog;
import com.qgutech.km.module.km.model.Library;
import com.qgutech.km.module.km.model.Share;
import com.qgutech.km.module.km.service.*;
import com.qgutech.km.module.km.vo.FileVo;
import com.qgutech.km.module.sfm.model.PeFile;
import com.qgutech.km.module.sfm.service.FileServerService;
import com.qgutech.km.utils.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 文件服务器 控制层
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月10日10:32:33
 */
@Controller
@RequestMapping("knowledge")
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
    @Resource
    private ShareService shareService;
    @Resource
    private KmFullTextSearchService kmFullTextSearchService;
    @Resource
    private KnowledgeLogService knowledgeLogService;
    @Resource
    private ScoreDetailService scoreDetailService;

    @ResponseBody
    @RequestMapping("uploadFile")
    public JsonResult<PeFile> uploadFile(@RequestParam(value = "uploadFile", required = false) MultipartFile multipartFile,
                                         @ModelAttribute PeFile peFile) throws IOException {
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

    @RequestMapping("openUpload")
    public String openUpload(Model model) {
        model.addAttribute("sourceUrl", "");
        model.addAttribute("targetUrl", "");
        return "km/uploadFile";
    }

    @ResponseBody
    @RequestMapping("saveKnowledge")
    public JsonResult<Knowledge> saveKnowledge(@ModelAttribute Knowledge knowledge) {
        try {
            if (StringUtils.isBlank(knowledge.getId())) {
                String libraryId = knowledge.getLibraryId();
                libraryId = getLibraryId(libraryId);
                String knowledgeName = knowledge.getKnowledgeName();
                String knowledgeType = knowledge.getKnowledgeType();
                int count = knowledgeService.getSameNameCount(libraryId, knowledgeName, knowledgeType);
                knowledgeName = getSameKnowledgeName(knowledgeName, knowledgeType, count);
                knowledge.setKnowledgeName(knowledgeName);
                knowledge.setLibraryId(libraryId);
                knowledgeService.saveAndRel(knowledge);
            } else {
                knowledgeService.update(knowledge);
            }

            return new JsonResult<>(true, knowledge.getId());
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }
    }

    private String getLibraryId(String libraryId) {
        if (StringUtils.isEmpty(libraryId)) {
            Library myLibrary = libraryService.getUserLibraryByLibraryType("MY_LIBRARY");
            return myLibrary.getId();
        }

        String folderName = null;
        if (KnowledgeConstant.UPLOAD_SHARE.equals(libraryId)) {
            folderName = "分享";
        } else if (KnowledgeConstant.UPLOAD_PROJECT.equals(libraryId)) {
            folderName = "重点项目";
        } else if (KnowledgeConstant.UPLOAD_SPECIAL.equals(libraryId)) {
            folderName = "专业分类";
        }

        if (StringUtils.isEmpty(folderName)) {
            return libraryId;
        }

        libraryId = libraryService.getIdByNameAndType(folderName, KnowledgeConstant.MY_LIBRARY);
        if (StringUtils.isEmpty(libraryId)) {
            libraryId = libraryService.addFolder(folderName, null);
        }

        return libraryId;
    }

    private String getSameKnowledgeName(String knowledgeName, String knowledgeType, int count) {
        if (count == 0) {
            return knowledgeName;
        }

        String suffix = "." + knowledgeType;
        return knowledgeName.replace(suffix, "") + "(" + count + ")" + suffix;
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
    @ResponseBody
    @RequestMapping("downloadKnowledge")
    public JsonResult downLoadUserTemplate(HttpServletRequest request, HttpServletResponse response,String knowledgeIds) {
        JsonResult jsonResult = new JsonResult();
        if(StringUtils.isEmpty(knowledgeIds)){
            jsonResult.setSuccess(false);
            jsonResult.setMessage("请选择文件");
            return jsonResult;
        }
        List<String> ids =Arrays.asList(knowledgeIds.split(","));
        List<Knowledge> knowledgeList = knowledgeService.recursionList(ids);
        List<String> fileIds = new ArrayList<>(knowledgeList.size());
        for(Knowledge s : knowledgeList){
            fileIds.add(s.getFileId());
        }
        //批量文件的路径
        List<String> fileUrls = new ArrayList<>(fileIds.size());
        /*if(fileIds.size()<=1){
            String fileUrl = FsFileManagerUtil.getFileUrl(PropertiesUtils.getConfigProp().getProperty("fs.server.host"),fileIds.get(0), UUID.randomUUID().toString());
            fileUrls.add(fileUrl);
        }else{
            String fileUrl = FsFileManagerUtil.getCompressFileUrl(PropertiesUtils.getConfigProp().getProperty("fs.server.host"),fileIds, UUID.randomUUID().toString());
            fileUrl.replace("getFile","downloadFile");
            fileUrls.add(fileUrl);
        }*/
        jsonResult.setData(fileUrls);
        jsonResult.setSuccess(true);
        return jsonResult;

    }

    /**
     * 我的云库
     * createBy
     * 云库表  云库和文件关系表  文件表
     */
    @ResponseBody
    @RequestMapping("search")
    public List<Knowledge> search(String libraryId){
        List<Knowledge> knowledgeList = knowledgeService.getKnowledgeByCreateBy(KnowledgeConstant.MY_LIBRARY,libraryId);
        if(CollectionUtils.isEmpty(knowledgeList)){
            return new ArrayList<>(0);
        }

        for(Knowledge knowledge : knowledgeList){
            knowledge.setCreateTimeStr(PeDateUtils.format(knowledge.getCreateTime(),PeDateUtils.FORMAT_YYYY_MM_DD_HH_MM));
            knowledge.setKnowledgeSize(totalSize(knowledge.getId()));
        }
        return knowledgeList;
    }

    private long totalSize(String id){
        List<Knowledge> knowledgeList = knowledgeService.recursionList(Arrays.asList(id));
        long totalSize = 0;
        for(Knowledge k : knowledgeList){
            totalSize = totalSize + k.getKnowledgeSize();
        }
        return totalSize;
    }

    @ResponseBody
    @RequestMapping("fullTextSearch")
    public List<Knowledge> fullTextSearch(String keyword){
        if (StringUtils.isBlank(keyword)){
            List<Knowledge> knowledgeList = knowledgeService.getKnowledgeByCreateBy(KnowledgeConstant.MY_LIBRARY,null);
            if(CollectionUtils.isEmpty(knowledgeList)){
                return new ArrayList<Knowledge>(0);
            }

            for(Knowledge knowledge : knowledgeList){
                knowledge.setCreateTimeStr(PeDateUtils.format(knowledge.getCreateTime(),PeDateUtils.FORMAT_YYYY_MM_DD_HH_MM));
            }
            return knowledgeList;
        }

        Page<String> page = new Page<>();
        page.setAutoPaging(false);
        page.setAutoCount(false);
        page = kmFullTextSearchService.search(keyword, page);

        List<String> fileIds = page.getRows();
        if (CollectionUtils.isEmpty(fileIds)){
            return new ArrayList<Knowledge>(0);
        }

        List<Knowledge> knowledgeList = knowledgeService.getKnowledgeByKnowledgeIds(fileIds);
        if(CollectionUtils.isEmpty(knowledgeList)){
            knowledgeList = new ArrayList<>(0);
        }

        for(Knowledge knowledge : knowledgeList){
            knowledge.setCreateTimeStr(PeDateUtils.format(knowledge.getCreateTime(),PeDateUtils.FORMAT_YYYY_MM_DD_HH_MM));
        }
        return knowledgeList;
    }

    /**
     * 我的回收站文件列表
     *
     * 云库表  云库和文件关系表  文件表
     */
    @ResponseBody
    @RequestMapping("searchRecycle")
    public List<Knowledge> searchRecycle(){
        List<Knowledge> list = knowledgeService.getKnowledgeByCreateBy(KnowledgeConstant.RECYCLE_LIBRARY,null);
        if(CollectionUtils.isEmpty(list)){
            list = new ArrayList<>(0);
        }
        for(Knowledge knowledge : list){
            knowledge.setCreateTimeStr(PeDateUtils.format(knowledge.getCreateTime(),PeDateUtils.FORMAT_YYYY_MM_DD_HH_MM));
        }
        return list;
    }



    /**
     * 分享到公共库 如果此文件已分享则不添加记录
     * @return
     * 1.添加个人的分享记录
     * 2.在公共库添加此文件记录
     * 3.统计表
     */
    @ResponseBody
    @RequestMapping("shareToPublic")
    public JsonResult shareToPublic(@ModelAttribute Share share){
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

    /**
     * 公共库列表
     * @param libraryId
     * @return
     */
    @ResponseBody
    @RequestMapping("publicByLibraryId")
    public List<Knowledge> publicByLibraryId(String libraryId){
        if(StringUtils.isEmpty(libraryId)){
            return new ArrayList<>(0);
        }
        List<Knowledge> list = knowledgeService.getByLibraryId(libraryId);
        for(Knowledge knowledge : list){
            knowledge.setCreateTimeStr(PeDateUtils.format(knowledge.getCreateTime(),PeDateUtils.FORMAT_YYYY_MM_DD_HH_MM));
        }
        return list;
    }

    /**
     * 我的分享
     * @return
     */
    @ResponseBody
    @RequestMapping("myShare")
    public List<Knowledge> myShare(){
        return shareService.getMyShare();
    }

    /**
     * 还原我的回收站文件
     * @param knowledgeIds  文件id
     * @return
     */
    @ResponseBody
    @RequestMapping("reduction")
    public JsonResult reduction(String knowledgeIds){
        JsonResult jsonResult = new JsonResult();
        try {
            if(StringUtils.isBlank(knowledgeIds)){
                jsonResult.setSuccess(true);
                return jsonResult;
            }

            List<String> knowledgeIdList = Arrays.asList(knowledgeIds.split(","));
            if (CollectionUtils.isEmpty(knowledgeIdList)){
                jsonResult.setSuccess(true);
                return jsonResult;
            }

            knowledgeService.reductionOrDelete(knowledgeIdList,KnowledgeConstant.RECYCLE_LIBRARY);
        }catch (Exception e){
            jsonResult.setSuccess(false);
            jsonResult.setMessage(e.getMessage());
            return jsonResult;
        }
        jsonResult.setSuccess(true);
        return jsonResult;
    }

    /**
     * 清空我的回收站
     * @return
     */
    @ResponseBody
    @RequestMapping("emptyTrash")
    public JsonResult emptyTrash( HttpServletRequest hRequest){
        JsonResult jsonResult = new JsonResult();
        String timestamp = hRequest.getParameter("timestamp");
        String nonce = hRequest.getParameter("nonce");
        String sign = hRequest.getParameter("sign");
        if (StringUtils.isBlank(sign)||StringUtils.isBlank(timestamp)||StringUtils.isBlank(nonce)){
            jsonResult.setMessage("操作有误");
            jsonResult.setSuccess(false);
            return jsonResult;
        }
        if (!sign.equalsIgnoreCase(MD5Generator.getHexMD5(nonce + "xu" + timestamp))) {
            jsonResult.setMessage("操作有误");
            jsonResult.setSuccess(false);
            return jsonResult;
        }
        PeJedisCommands commonJedis = PeRedisClient.getCommonJedis();
        String key="nonce_"+nonce+ExecutionContext.getUserId();
        if (commonJedis.exists(key)) {
            jsonResult.setMessage("操作有误");
            jsonResult.setSuccess(false);
            return jsonResult;
        }
        commonJedis.setex(key,60,"1");
        try {
            knowledgeService.emptyTrash();
        }catch (Exception e){
            jsonResult.setSuccess(false);
            jsonResult.setMessage(e.getMessage());
            return jsonResult;
        }
        jsonResult.setSuccess(true);
        return jsonResult;
    }

    /**
     * 删除我的云库文件
     * @param knowledgeIds  文件id
     * @return
     */
    @ResponseBody
    @RequestMapping("delete")
    public JsonResult delete(String knowledgeIds, @RequestParam(required = false) String folderId){
        JsonResult jsonResult = new JsonResult();
        try {
            if(StringUtils.isBlank(knowledgeIds)){
                jsonResult.setSuccess(true);
                return jsonResult;
            }

            List<String> knowledgeIdList = Arrays.asList(knowledgeIds.split(","));
            if (CollectionUtils.isEmpty(knowledgeIdList)){
                jsonResult.setSuccess(true);
                return jsonResult;
            }

            if (StringUtils.isEmpty(folderId)) {
                knowledgeService.reductionOrDelete(knowledgeIdList, KnowledgeConstant.MY_LIBRARY);
            } else {
                knowledgeService.deleteInDir(knowledgeIdList, folderId);
            }
            for (String knowledgeId : knowledgeIdList) {
                kmFullTextSearchService.delete(knowledgeId);
            }

        }catch (Exception e){
            jsonResult.setSuccess(false);
            jsonResult.setMessage(e.getMessage());
            return jsonResult;
        }
        jsonResult.setSuccess(true);
        return jsonResult;
    }

    @RequestMapping("initPublicLibraryPage")
    public String initPublicLibraryPage(String libraryId,Model model){
        model.addAttribute("libraryId",libraryId);
        return "km/knowledge/publicLibraryPage";
    }

    /**
     * 公共库分页
     * @param pageParam
     * @param knowledge
     * @return
     */
    @ResponseBody
    @RequestMapping("publicLibraryData")
    public Page<Knowledge> publicLibraryData(@ModelAttribute PageParam pageParam, Knowledge knowledge, String libraryId){
        if(StringUtils.isEmpty(libraryId)){
            return new Page<Knowledge>();
        }
        if(pageParam==null){
            pageParam = new PageParam();
        }
        if(knowledge == null){
            knowledge = new Knowledge();
        }

        return knowledgeService.publicLibraryData(pageParam,knowledge,libraryId);
    }

    /**
     * 复制到我的云库
     * @return
     */
    @RequestMapping("copyToMyLibrary")
    @ResponseBody
    public JsonResult copyToMyLibrary(String knowledgeIds){
        JsonResult jsonResult = new JsonResult();
        if(StringUtils.isEmpty(knowledgeIds)){
            jsonResult.setSuccess(false);
            jsonResult.setMessage("请选择操作对象");
            return jsonResult;
        }
        try {
            knowledgeService.copyToMyLibrary(knowledgeIds);
        }catch (Exception e){
            jsonResult.setSuccess(false);
            jsonResult.setMessage(e.getMessage());
            return jsonResult;
        }
        jsonResult.setSuccess(true);
        return jsonResult;
    }

    /**
     * 下载文件
     *
     * @param knowledgeIds 文件id
     * @return
     */
    @ResponseBody
    @RequestMapping("downloadKnowledge2")
    public JsonResult downloadKnowledge(String knowledgeIds, @RequestParam(required = false) String libraryId) {
        JsonResult jsonResult = new JsonResult();
        if (StringUtils.isEmpty(knowledgeIds)) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("请选择文件");
            return jsonResult;
        }
        List<String> ids = Arrays.asList(knowledgeIds.split(","));
        List<Knowledge> knowledgeList = knowledgeService.recursionList(ids);
        if (CollectionUtils.isEmpty(knowledgeList)) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("此文件夹内没有文件");
            return jsonResult;
        }

        String key = "DOWNLOAD_KNOWLEDGE_" + knowledgeIds + "_" + libraryId;
        PeJedisCommands jedis = PeRedisClient.getCommonJedis();
        try {
            Long lock = jedis.setnx(key, 60L);
            if (lock <= 0) {
                jsonResult.setSuccess(false);
                jsonResult.setMessage("文件正在下载中，请稍候！");
                return jsonResult;
            }

            /*boolean hasAuth = knowledgeRelService.checkAuth(ids);
            if (!hasAuth) {
                jsonResult.setSuccess(false);
                jsonResult.setMessage("此文件暂无权限，不能下载！");
                return jsonResult;
            }*/

            String name;
            if (knowledgeList.size() == 1) {
                name = knowledgeList.get(0).getKnowledgeName();
            } else {
                name = "压缩文件包.zip";
            }
            List<String> fileIds = new ArrayList<>(knowledgeList.size());
            fileIds.addAll(knowledgeList.stream().map(Knowledge::getFileId).collect(Collectors.toList()));
            if (StringUtils.isEmpty(libraryId)) {
                Library myLibrary = libraryService.getUserLibraryByLibraryType("MY_LIBRARY");
                libraryId = myLibrary.getId();
            }

            List<KnowledgeLog> knowledgeLogs = new ArrayList<>(knowledgeList.size());
            final String finalLibraryId = libraryId;
            knowledgeLogs.addAll(knowledgeList.stream().map(s -> new KnowledgeLog(s.getId(), finalLibraryId, KnowledgeConstant.LOG_DOWNLOAD)).collect(Collectors.toList()));
            knowledgeLogService.batchSave(knowledgeLogs);
            scoreDetailService.addScore(ids, KnowledgeConstant.SCORE_RULE_DOWNLOAD);
            Map<String, String> shareIdMap = shareService.getSharedKnowledgeIdAndShareIdMap(ids);
            if (MapUtils.isNotEmpty(shareIdMap)) {
                StringBuilder shareIds = new StringBuilder();
                shareIdMap.values().forEach(shareId -> {
                    shareIds.append(shareId).append(",");
                });
                try {
                    shareService.updateDownCount(shareIds.toString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            //批量文件的路径
            List<String> fileUrls = new ArrayList<>(fileIds.size());
            StringBuilder sb = new StringBuilder();
            for (String s : fileIds) {
                String fileUrl = FsFileManagerUtil.getFileUrl(PropertiesUtils.getConfigProp().getProperty("fs.server.host"), s, UUID.randomUUID().toString());
                sb.append(fileUrl).append(",");
            }
            fileUrls.add(sb.substring(0, sb.length() - 1));
            FileVo fileVo = new FileVo();
            fileVo.setName(name);
            fileVo.setFileUrl(sb.substring(0, sb.length() - 1));
            jsonResult.setData(fileVo);
            jsonResult.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            jsonResult.setSuccess(false);
            jsonResult.setMessage("系统异常！");
        } finally {
            jedis.expire(key, 0);
        }

        return jsonResult;
    }

    @RequestMapping("updateDownCount")
    @ResponseBody
    public JsonResult updateDownCount(String shareIds){
        JsonResult jsonResult = new JsonResult();
        jsonResult.setSuccess(true);
        try {
            shareService.updateDownCount(shareIds);
        }catch (Exception e){
            jsonResult.setSuccess(false);
            return jsonResult;
        }
        return jsonResult;
    }

    @RequestMapping("updateCopyCount")
    @ResponseBody
    public JsonResult updateCopyCount(String shareIds){
        JsonResult jsonResult = new JsonResult();
        jsonResult.setSuccess(true);
        try {
            shareService.updateCopyCount(shareIds);
        }catch (Exception e){
            jsonResult.setSuccess(false);
            return jsonResult;
        }
        return jsonResult;
    }
    @RequestMapping("folder")
    @ResponseBody
    public JsonResult folder(String folder,Model model){
        JsonResult jsonResult = new JsonResult();
        if(StringUtils.isEmpty(folder)){
            folder = libraryService.getUserLibraryByLibraryType(KnowledgeConstant.MY_LIBRARY).getId();
        }
        model.addAttribute("folder",folder);
        return jsonResult;
    }

    @ResponseBody
    @RequestMapping("searchKnowledge")
    public Page<Knowledge> searchKnowledge(@ModelAttribute Knowledge knowledge, @ModelAttribute PageParam pageParam) {
        return knowledgeService.search(knowledge, pageParam);
    }

    @RequestMapping("orgShare/search")
    @ResponseBody
    public Page<Knowledge> search(@ModelAttribute Knowledge knowledge, @ModelAttribute PageParam pageParam) {
        if (knowledge == null) {
            knowledge = new Knowledge();
        }
        if (pageParam == null) {
            pageParam = new PageParam();
        }

        Page<Knowledge> page = knowledgeService.searchOrgShare(knowledge, pageParam);
        List<Knowledge> rows = page.getRows();
        if (CollectionUtils.isEmpty(rows)) {
            return page;
        }

        for (Knowledge row : rows) {
            row.setKnowledgeSize(totalSize(row.getId()));
        }

        return page;
    }

    @RequestMapping("orgShare/deleteShare")
    @ResponseBody
    public JsonResult deleteShare(String relId) {
        JsonResult jsonResult = new JsonResult();
        try {
            knowledgeRelService.deleteShare(relId);
        } catch (Exception e) {
            e.printStackTrace();
            jsonResult.setSuccess(false);
            jsonResult.setMessage("删除失败！");
        }

        return jsonResult;
    }


    @ResponseBody
    @RequestMapping("searchHotKnowledge")
    public Page<Knowledge> searchHotKnowledge(@ModelAttribute Knowledge knowledge, @ModelAttribute PageParam pageParam) {
        return knowledgeService.searchHotKnowledge(knowledge, pageParam);
    }
}
