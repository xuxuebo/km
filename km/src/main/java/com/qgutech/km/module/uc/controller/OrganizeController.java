package com.qgutech.km.module.uc.controller;

import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.base.vo.PeTreeNode;
import com.qgutech.km.module.uc.model.Organize;
import com.qgutech.km.module.uc.service.OrganizeService;
import com.qgutech.km.utils.PeException;
import com.qgutech.km.base.service.I18nService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * 部门控制层
 *
 * @author WuKang@HF
 * @version 1.0.0
 * @since 2016年11月1日17:31:34
 */
@Controller
@RequestMapping("uc/organize")
public class OrganizeController {
    @Resource
    private OrganizeService organizeService;
    @Resource
    private I18nService i18nService;

    @RequestMapping("manage/initPage")
    public String initPage(Model model) {
        Organize organize = organizeService.getRoot();
        model.addAttribute(organize);
        return "uc/organize/organizeManage";
    }

    /**
     * 部门的节点树集合
     *
     * @since 2016年11月1日17:40:42 author by WuKang@HF
     */
    @ResponseBody
    @RequestMapping("/listTree")
    public List<PeTreeNode> showTree() {
        return organizeService.listTreeNode();
    }

    /**
     * 部门新增
     *
     * @since 2016年11月1日17:41:25 author by WuKang@HF
     */
    @ResponseBody
    @RequestMapping("/manage/save")
    public JsonResult<Organize> saveOrganize(@ModelAttribute Organize organize) {
        try {
            String organizeId = organizeService.save(organize);
            organize.setId(organizeId);
            JsonResult<Organize> jsonResult = new JsonResult<>();
            jsonResult.setData(organize);
            jsonResult.setSuccess(true);
            return jsonResult;
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }
    }

    /**
     * 部门编辑
     *
     * @since 2016年11月1日18:00:38 author by WuKang@HF
     */
    @ResponseBody
    @RequestMapping("/manage/update")
    public JsonResult<Organize> updateOrganize(@ModelAttribute Organize organize) {
        try {
            organizeService.update(organize);
            return new JsonResult<>(true, JsonResult.SUCCESS);
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }
    }

    /**
     * 删除部门
     *
     * @since 2016年11月1日18:03:15 author by WuKang@HF
     */
    @ResponseBody
    @RequestMapping("/manage/delete")
    public JsonResult<Organize> deleteOrganize(String id) {
        try {
            organizeService.delete(id);
            return new JsonResult<>(true, i18nService.getI18nValue("delete.success"));
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }
    }

    /**
     * 部门上移下移
     *
     * @since 2016年11月1日18:05:34 author bu WuKang@HF
     */
    @ResponseBody
    @RequestMapping("/manage/moveLevel")
    public JsonResult<Organize> moveLevel(String id, boolean isUp) {
        try {
            organizeService.moveLevel(id, isUp);
            return new JsonResult<>(true, JsonResult.SUCCESS);
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }
    }
}
