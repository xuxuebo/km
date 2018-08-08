package com.qgutech.km.module.km.controller;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.Library;
import com.qgutech.km.module.km.service.LibraryService;
import com.qgutech.km.module.uc.model.User;
import com.qgutech.km.module.uc.service.UserService;
import com.qgutech.km.utils.UUIDGenerator;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
    @Resource
    private UserService userService;

    @RequestMapping("manage/initPage")
    public String initPage() {
        return "km/project/projectManage";
    }

    /**
     * 新增重点项目
     */
    @RequestMapping("addProject")
    @ResponseBody
    public JsonResult addProject(Library library) {
        JsonResult jsonResult = new JsonResult();
        if (library == null || StringUtils.isEmpty(library.getLibraryName())) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("NAME_EMPTY");
            return jsonResult;
        }

        boolean checkName = libraryService.checkName(null, library.getLibraryName(), KnowledgeConstant.PROJECT_LIBRARY);
        if (checkName) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("NAME_REPEAT");
            return jsonResult;
        }

        try {
            setLibraryContent(library);
            libraryService.saveLibraryAndDetail(library);
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

    @RequestMapping("updateProject")
    @ResponseBody
    public JsonResult updateProject(Library library) {
        JsonResult jsonResult = new JsonResult();
        if (library == null || StringUtils.isEmpty(library.getLibraryName()) || StringUtils.isEmpty(library.getId())) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("NAME_EMPTY");
            return jsonResult;
        }

        String id = library.getId();
        String libraryName = library.getLibraryName();
        boolean checkName = libraryService.checkName(id, libraryName, KnowledgeConstant.PROJECT_LIBRARY);
        if (checkName) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("NAME_REPEAT");
            return jsonResult;
        }

        try {
            libraryService.updateAndDetail(library);
        } catch (Exception e) {
            e.printStackTrace();
            jsonResult.setSuccess(false);
        }

        return jsonResult;
    }

    @RequestMapping("initProjectFace")
    public String initProjectFace(Model model, @RequestParam(required = false) String fileId,
                                  @RequestParam(required = false) String fileName) {
        if (StringUtils.isNotEmpty(fileId)) {
            String sourceUrl = userService.getFacePath(fileId, fileName);
            model.addAttribute("sourceUrl", sourceUrl);
        }

        return "km/project/initProjectFace";
    }
}
