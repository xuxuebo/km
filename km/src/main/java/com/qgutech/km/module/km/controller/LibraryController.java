package com.qgutech.km.module.km.controller;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.redis.PeJedisCommands;
import com.qgutech.km.base.redis.PeRedisClient;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.base.vo.PeTreeNode;
import com.qgutech.km.base.vo.Rank;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.KnowledgeLog;
import com.qgutech.km.module.km.model.Library;
import com.qgutech.km.module.km.model.Share;
import com.qgutech.km.module.km.service.KnowledgeLogService;
import com.qgutech.km.module.km.service.KnowledgeRelService;
import com.qgutech.km.module.km.service.KnowledgeService;
import com.qgutech.km.module.km.service.LibraryService;
import com.qgutech.km.module.uc.service.UserService;
import com.qgutech.km.utils.MD5Generator;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2018/6/23.
 */
@Controller
@RequestMapping("library")
public class LibraryController {

    @Resource
    private LibraryService libraryService;
    @Resource
    private UserService userService;
    @Resource
    private KnowledgeLogService knowledgeLogService;
    @Resource
    private KnowledgeService knowledgeService;
    @Resource
    private KnowledgeRelService knowledgeRelService;

    /**
     * 一级公共库
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("firstLevelLibrary")
    public List<Library> firstLevelLibrary() {

        return libraryService.getFirstLevelLibrary();
    }

    @ResponseBody
    @RequestMapping("manage/search")
    public Page<Library> search(Library library, PageParam pageParam) {
        if (library == null) {
            library = new Library();
        }
        if (pageParam == null) {
            pageParam = new PageParam();
        }
        return libraryService.search(pageParam, library);
    }


    @ResponseBody
    @RequestMapping("listTree")
    public List<PeTreeNode> listTree() {
        return libraryService.listTree();
    }

    /**
     * 新建文件夹
     *
     * @param libraryName
     * @return
     */
    @ResponseBody
    @RequestMapping("addFolder")
    public JsonResult addFolder(String libraryName, String libraryId, HttpServletRequest hRequest) {
        JsonResult jsonResult = new JsonResult();
        String timestamp = hRequest.getParameter("timestamp");
        String nonce = hRequest.getParameter("nonce");
        String sign = hRequest.getParameter("sign");
        if (StringUtils.isBlank(sign)||StringUtils.isBlank(timestamp)||StringUtils.isBlank(nonce)){
            jsonResult.setMessage("操作有误");
            jsonResult.setSuccess(false);
            return jsonResult;
        }
        if (!sign.equals(MD5Generator.getHexMD5(nonce+"xu"+timestamp).toUpperCase())){
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
        if (StringUtils.isEmpty(libraryName)) {
            jsonResult.setMessage("请输入文件夹名");
            jsonResult.setSuccess(false);
            return jsonResult;
        }
        String message = libraryService.addFolder(libraryName, libraryId);
        if ("ERROR_NAME_REPEAT".equals(message)) {
            jsonResult.setMessage("文件夹名称重复！");
            jsonResult.setSuccess(false);
            return jsonResult;
        }

        libraryService.addFolder(libraryName, libraryId);
        return jsonResult;
    }

    @RequestMapping("manage/initPage")
    public String initPage() {
        return "km/library/libraryManage";
    }

    /**
     * 新增公共库
     *
     * @return
     */
    @RequestMapping("addPublicLibrary")
    @ResponseBody
    public JsonResult addPublicLibrary(Library library) {
        JsonResult jsonResult = new JsonResult();
        if (library == null || StringUtils.isEmpty(library.getLibraryName())) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("新增失败");
        } else {
            String result = libraryService.saveLibrary(library);
            if ("库名重复".equals(result)) {
                jsonResult.setSuccess(false);
                jsonResult.setMessage(result);
            } else {
                jsonResult.setSuccess(true);
            }
        }

        return jsonResult;
    }

    @RequestMapping("updateLibrary")
    @ResponseBody
    public JsonResult updateLibrary(Library library) {
        JsonResult jsonResult = new JsonResult();
        if (library == null || StringUtils.isEmpty(library.getLibraryName()) || StringUtils.isEmpty(library.getId())) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("编辑失败");
        } else {
            String result = libraryService.updateLibrary(library);
            if ("库名重复".equals(result)) {
                jsonResult.setSuccess(false);
                jsonResult.setMessage(result);
            } else {
                jsonResult.setSuccess(true);
            }
        }
        return jsonResult;
    }

    @ResponseBody
    @RequestMapping("libraryName")
    public JsonResult libraryName(String id) {
        Library library;
        if (StringUtils.isEmpty(id)) {
            library = libraryService.getUserLibraryByLibraryType(KnowledgeConstant.MY_LIBRARY);
        } else {
            library = libraryService.get(id);
        }
        JsonResult jsonResult = new JsonResult();
        jsonResult.setData(library.getLibraryName());
        return jsonResult;
    }


    @ResponseBody
    @RequestMapping("manage/searchLibrary")
    public Page<Library> searchLibrary(Library library, PageParam pageParam) {
        if (library == null) {
            library = new Library();
        }
        if (pageParam == null) {
            pageParam = new PageParam();
        }
        return libraryService.searchLibrary(pageParam, library);
    }

    @ResponseBody
    @RequestMapping("listLibrary")
    public List<PeTreeNode> listLibrary(@RequestParam String type) {
        PageParam pageParam = new PageParam();
        pageParam.setAutoPaging(false);
        pageParam.setAutoCount(false);
        Library library = new Library();
        library.setLibraryType(type);
        Page<Library> page = libraryService.searchLibrary(pageParam, library);
        List<Library> rows = page.getRows();
        if (CollectionUtils.isEmpty(rows)) {
            return new ArrayList<>(0);
        }

        List<PeTreeNode> peTreeNodes = new ArrayList<>(rows.size());
        for (Library row : rows) {
            PeTreeNode peTreeNode = new PeTreeNode();
            peTreeNode.setName(row.getLibraryName());
            peTreeNode.setId(row.getId());
            peTreeNode.setParent(false);
            peTreeNode.setCanEdit(false);
            peTreeNodes.add(peTreeNode);
        }

        return peTreeNodes;
    }

    @ResponseBody
    @RequestMapping("load")
    public Library load(@RequestParam String libraryId) {
        return libraryService.getLibraryAndDetail(libraryId);
    }

    @ResponseBody
    @RequestMapping("rank")
    public List<Rank> rank(@RequestParam String libraryId) {
        return libraryService.rank(libraryId);
    }

    @ResponseBody
    @RequestMapping("dynamic")
    public Page<KnowledgeLog> dynamic(KnowledgeLog knowledgeLog, PageParam pageParam) {
        return knowledgeLogService.search(knowledgeLog, pageParam);
    }

    @RequestMapping("addToLibrary")
    @ResponseBody
    public JsonResult addToLibrary(Share share) {
        JsonResult jsonResult = new JsonResult();
        List<String> libraryIds = share.getLibraryIds();
        if (CollectionUtils.isEmpty(libraryIds)) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("上传失败！");
            return jsonResult;
        }

        List<String> fileIds = share.getFileIds();
        List<String> knowledgeIds = share.getKnowledgeIds();
        if (CollectionUtils.isNotEmpty(fileIds)) {
            List<String> knowledgeIdList = knowledgeService.getIdsByFileIds(fileIds);
            if (knowledgeIds == null) {
                knowledgeIds = knowledgeIdList;
                share.setKnowledgeIds(knowledgeIds);
            } else {
                knowledgeIds.addAll(knowledgeIdList);
            }
        }

        if (CollectionUtils.isEmpty(knowledgeIds)) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("上传失败！");
            return jsonResult;
        }

        try {
            knowledgeRelService.addToLibrary(share);
        } catch (Exception e) {
            e.printStackTrace();
            jsonResult.setSuccess(false);
            jsonResult.setMessage("上传失败！");
        }

        return jsonResult;
    }


    @RequestMapping("delete")
    @ResponseBody
    public JsonResult delete(Share share) {
        JsonResult jsonResult = new JsonResult();
        List<String> knowledgeIds = share.getKnowledgeIds();
        String libraryId = share.getShareLibraryId();
        if (CollectionUtils.isEmpty(knowledgeIds) || StringUtils.isEmpty(libraryId)) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("删除失败！");
            return jsonResult;
        }

        try {
            knowledgeRelService.deleteByKnowledgeIdsAndLibraryId(knowledgeIds, libraryId);
        } catch (Exception e) {
            e.printStackTrace();
            jsonResult.setSuccess(false);
            jsonResult.setMessage("删除失败！");
        }

        return jsonResult;
    }

    @RequestMapping("hotLibrary")
    @ResponseBody
    public List<Library> hotLibrary(String libraryType, int hotCount) {
        try {
            return libraryService.getHotLibraryByType(libraryType, hotCount);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

}
