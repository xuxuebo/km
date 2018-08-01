package com.qgutech.km.module.km.controller;

import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.Library;
import com.qgutech.km.module.km.service.LibraryService;
import com.qgutech.km.utils.UUIDGenerator;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * 重点项目管理
 *
 * @author TangFD@HF 2018-8-1
 */
@Controller
@RequestMapping("project")
public class ProjectController {

    @Resource
    private LibraryService libraryService;

    @RequestMapping("manage/initPage")
    public String initPage() {
        return "km/project/projectManage";
    }

    /**
     * 新增专业分类
     */
    @RequestMapping("addSpecialty")
    @ResponseBody
    public JsonResult addSpecialty(Library library) {
        JsonResult jsonResult = new JsonResult();
        if (library == null || StringUtils.isEmpty(library.getLibraryName())) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("NAME_EMPTY");
            return jsonResult;
        }

        boolean checkName = libraryService.checkName(null, library.getLibraryName(), KnowledgeConstant.SPECIALTY_LIBRARY);
        if (checkName) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("NAME_REPEAT");
            return jsonResult;
        }

        try {
            setLibraryContent(library);
            libraryService.insert(library);
        } catch (Exception e) {
            e.printStackTrace();
            jsonResult.setSuccess(false);
        }

        return jsonResult;
    }

    private void setLibraryContent(Library library) {
        String id = UUIDGenerator.uuid();
        library.setId(id);
        library.setIdPath(id);
        library.setLibraryType(KnowledgeConstant.PROJECT_LIBRARY);
        library.setShowOrder(0);
        library.setParentId("0");
    }

    @RequestMapping("updateSpecialty")
    @ResponseBody
    public JsonResult updateSpecialty(Library library) {
        JsonResult jsonResult = new JsonResult();
        if (library == null || StringUtils.isEmpty(library.getLibraryName()) || StringUtils.isEmpty(library.getId())) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("NAME_EMPTY");
            return jsonResult;
        }

        String id = library.getId();
        String libraryName = library.getLibraryName();
        boolean checkName = libraryService.checkName(id, libraryName, KnowledgeConstant.SPECIALTY_LIBRARY);
        if (checkName) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("NAME_REPEAT");
            return jsonResult;
        }

        try {
            libraryService.update(id, Library.LIBRARY_NAME, libraryName);
        } catch (Exception e) {
            e.printStackTrace();
            jsonResult.setSuccess(false);
        }

        return jsonResult;
    }
}
