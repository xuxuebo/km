package com.qgutech.km.module.km.controller;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.base.vo.PeTreeNode;
import com.qgutech.km.base.vo.Rank;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.KnowledgeLog;
import com.qgutech.km.module.km.model.Library;
import com.qgutech.km.module.km.model.LibraryDetail;
import com.qgutech.km.module.km.service.KnowledgeLogService;
import com.qgutech.km.module.km.service.LibraryDetailService;
import com.qgutech.km.module.km.service.LibraryService;
import com.qgutech.km.module.uc.service.UserService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

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
    private LibraryDetailService libraryDetailService;

    /**
     * 一级公共库
     * @return
     */
    @ResponseBody
    @RequestMapping("firstLevelLibrary")
    public List<Library> firstLevelLibrary(){

        return libraryService.getFirstLevelLibrary();
    }

    @ResponseBody
    @RequestMapping("manage/search")
    public Page<Library> search(Library library, PageParam pageParam){
        if(library==null){
            library = new Library();
        }
        if(pageParam==null){
            pageParam = new PageParam();
        }
        return libraryService.search(pageParam,library);
    }


    @ResponseBody
    @RequestMapping("listTree")
    public List<PeTreeNode> listTree(){
        return libraryService.listTree();
    }

    /**
     * 新建文件夹
     * @param libraryName
     * @return
     */
    @ResponseBody
    @RequestMapping("addFolder")
    public JsonResult addFolder(String libraryName,String libraryId){
        JsonResult jsonResult = new JsonResult();
        if(StringUtils.isEmpty(libraryName)){
            jsonResult.setMessage("请输入文件夹名");
            jsonResult.setSuccess(false);
            return jsonResult;
        }
        libraryService.addFolder(libraryName,libraryId);
        return jsonResult;
    }

    @RequestMapping("manage/initPage")
    public String initPage(){
        return "km/library/libraryManage";
    }

    /**
     * 新增公共库
     * @return
     */
    @RequestMapping("addPublicLibrary")
    @ResponseBody
    public JsonResult addPublicLibrary(Library library){
        JsonResult jsonResult = new JsonResult();
        if(library==null||StringUtils.isEmpty(library.getLibraryName())){
            jsonResult.setSuccess(false);
            jsonResult.setMessage("新增失败");
        }else{
            String result = libraryService.saveLibrary(library);
            if("库名重复".equals(result)){
                jsonResult.setSuccess(false);
                jsonResult.setMessage(result);
            }else{
                jsonResult.setSuccess(true);
            }
        }

        return jsonResult;
    }
    @RequestMapping("updateLibrary")
    @ResponseBody
    public JsonResult updateLibrary(Library library){
        JsonResult jsonResult = new JsonResult();
        if(library==null||StringUtils.isEmpty(library.getLibraryName())||StringUtils.isEmpty(library.getId())){
            jsonResult.setSuccess(false);
            jsonResult.setMessage("编辑失败");
        }else{
            String result =  libraryService.updateLibrary(library);
            if("库名重复".equals(result)){
                jsonResult.setSuccess(false);
                jsonResult.setMessage(result);
            }else{
                jsonResult.setSuccess(true);
            }
        }
        return jsonResult;
    }

    @ResponseBody
    @RequestMapping("libraryName")
    public JsonResult libraryName(String id){
        Library library ;
        if(StringUtils.isEmpty(id)){
            library = libraryService.getUserLibraryByLibraryType(KnowledgeConstant.MY_LIBRARY);
        }else{
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
        Library library = libraryService.get(libraryId, Library.ID, Library.LIBRARY_NAME, Library.LIBRARY_TYPE);
        if (library == null) {
            return null;
        }

        LibraryDetail libraryDetail = libraryDetailService.getByLibraryId(libraryId);
        library.setLibraryDetail(libraryDetail);
        String chargeIds = libraryDetail.getChargeIds();
        if (StringUtils.isNotEmpty(chargeIds)) {
            String[] userIds = chargeIds.split(",");
            Map<String, String> userIdAndNameMap = userService.getUserIdAndNameMap(Arrays.asList(userIds));
            StringBuilder name = new StringBuilder();
            for (String userName : userIdAndNameMap.values()) {
                name.append(userName).append(",");
            }

            String userName = name.toString();
            if (StringUtils.isNotEmpty(userName)) {
                libraryDetail.setChargeName(userName.substring(0, userName.length() - 1));
            }
        }

        String faceId = libraryDetail.getFaceId();
        if (StringUtils.isNotEmpty(faceId)) {
            String facePath = userService.getFacePath(faceId, libraryDetail.getFaceName());
            libraryDetail.setFacePath(facePath);
        }

        return library;
    }

    @ResponseBody
    @RequestMapping("rank")
    public List<Rank> rank(@RequestParam String libraryId){
        return libraryService.rank(libraryId);
    }

    @ResponseBody
    @RequestMapping("dynamic")
    public Page<KnowledgeLog> dynamic(KnowledgeLog knowledgeLog, PageParam pageParam) {
        return knowledgeLogService.search(knowledgeLog, pageParam);
    }
}
