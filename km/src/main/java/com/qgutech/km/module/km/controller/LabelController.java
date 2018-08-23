package com.qgutech.km.module.km.controller;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.module.km.model.Label;
import com.qgutech.km.module.km.model.LabelRel;
import com.qgutech.km.module.km.service.LabelService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.UUID;

/**
 * Created by Administrator on 2018/6/25.
 * 标签控制层
 */
@Controller
@RequestMapping("/km/label")
public class LabelController {

    @Resource
    private LabelService labelService;

    /**
     *
     * @param model
     * @return
     */
    @RequestMapping("initPage")
    public String initPage(Model model){
        Label root = labelService.getRoot();
        if(root==null){
            root = new Label();
            root.setId(UUID.randomUUID().toString().replace("-",""));
            root.setLabelName("全部");
        }
        model.addAttribute(root);
        return "km/label/labelManage";
    }


    /**
     * 新增标签
     * @return
     */
    @ResponseBody
    @RequestMapping("addLabel")
    public JsonResult addLabel(@ModelAttribute Label label) {
        JsonResult jsonResult = new JsonResult();
        if (StringUtils.isEmpty(label.getLabelName())) {
            jsonResult.setMessage("NAME_EMPTY");
            jsonResult.setSuccess(false);
            return jsonResult;
        }
        String labelId;
        try {
            labelId = labelService.saveLabel(label);
        } catch (Exception e) {
            e.printStackTrace();
            jsonResult.setMessage("NAME_REPEAT");
            jsonResult.setSuccess(false);
            return jsonResult;
        }

        label.setId(labelId);
        jsonResult.setData(label);
        jsonResult.setSuccess(true);
        return jsonResult;
    }


    @ResponseBody
    @RequestMapping("deleteLabel")
    public JsonResult deleteLabel(String id){
        JsonResult jsonResult = new JsonResult();
        if(StringUtils.isEmpty(id)){
            jsonResult.setSuccess(false);
            jsonResult.setMessage("请选择对象");
        }else{
            String result = labelService.deleteLabel(id);
            if("操作成功".equals(result)){
                jsonResult.setSuccess(true);
            }else{
                jsonResult.setSuccess(false);
            }
            jsonResult.setMessage(result);
        }
        return jsonResult;
    }


    @ResponseBody
    @RequestMapping("updateLabel")
    public JsonResult updateLabel(@ModelAttribute Label label){
        JsonResult jsonResult = new JsonResult();
        labelService.updateLabel(label);
        jsonResult.setSuccess(true);
        jsonResult.setMessage("操作成功");
        return jsonResult;
    }

    /**
     * 树
     * @return
     */
    @ResponseBody
    @RequestMapping("listTree")
    public Page<Label> listTree(@ModelAttribute PageParam pageParam){
        return labelService.listTree(pageParam);
    }

    @ResponseBody
    @RequestMapping("list")
    public List<Label> list() {
        PageParam pageParam = new PageParam();
        pageParam.setAutoCount(false);
        pageParam.setAutoPaging(false);
        return listTree(pageParam).getRows();
    }

    /**
     * 移动节点
     * @param id
     * @param isUp
     * @return
     */
    @ResponseBody
    @RequestMapping("moveShowOrder")
    public JsonResult moveShowOrder(String id,boolean isUp){
        JsonResult jsonResult = new JsonResult(true,"操作成功");
        labelService.moveShowOrder(id,isUp);
        return jsonResult;
    }

    @ResponseBody
    @RequestMapping("addLabelRel")
    public JsonResult addLabelRel(@ModelAttribute LabelRel labelRel) {
        JsonResult jsonResult = new JsonResult();
        String knowledgeId = labelRel.getKnowledgeId();
        if (StringUtils.isEmpty(knowledgeId)) {
            jsonResult.setSuccess(false);
            return jsonResult;
        }

        try {
            labelService.saveLabelRel(labelRel);
        } catch (Exception e) {
            e.printStackTrace();
            jsonResult.setSuccess(false);
        }

        return jsonResult;
    }

}
