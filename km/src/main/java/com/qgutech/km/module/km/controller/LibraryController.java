package com.qgutech.km.module.km.controller;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.base.vo.PeTreeNode;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.Library;
import com.qgutech.km.module.km.service.LibraryService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2018/6/23.
 */
@Controller
@RequestMapping("library")
public class LibraryController {

    @Resource
    private LibraryService libraryService;

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

}
