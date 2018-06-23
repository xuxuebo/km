package com.qgutech.km.module.km.controller;

import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.base.vo.PeTreeNode;
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
    public JsonResult addFolder(String libraryName){
        JsonResult jsonResult = new JsonResult();
        if(StringUtils.isEmpty(libraryName)){
            jsonResult.setMessage("请输入文件夹名");
            jsonResult.setSuccess(false);
            return jsonResult;
        }
        libraryService.addFolder(libraryName);
        return jsonResult;
    }

}
