package com.qgutech.km.base.controller;

import com.qgutech.km.base.model.Category;
import com.qgutech.km.base.service.CategoryService;
import com.qgutech.km.base.service.I18nService;
import com.qgutech.km.base.vo.PeTreeNode;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.utils.PeException;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * @author Created by zhangyang on 2016/10/24.
 */
@Controller
@RequestMapping("base/category")
public class CategoryController {
    @Resource
    private CategoryService categoryService;
    @Resource
    private I18nService i18nService;

    /**
     * 类别添加
     */
    @ResponseBody
    @RequestMapping("manage/add")
    public JsonResult<PeTreeNode> add(@ModelAttribute PeTreeNode treeNode, @ModelAttribute Category.CategoryEnumType categoryType) {
        Category category = getCategory(treeNode, categoryType);
        JsonResult<PeTreeNode> jsonResult = getSaveOrUpdateCategoryResult(category);
        if (jsonResult != null) {
            return jsonResult;
        }

        Category parentCategory = categoryService.get(category.getParentId());
        if (parentCategory == null) {
            return new JsonResult<>(false, i18nService.getI18nValue("parentCategory.not.exist"));
        }

        try {
            String categoryId = categoryService.save(category);
            treeNode.setId(categoryId);
            jsonResult = new JsonResult<>();
            jsonResult.setData(treeNode);
            jsonResult.setSuccess(true);
            return jsonResult;
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }

    }

    /**
     * 将treeNode转换为category
     */
    private Category getCategory(@ModelAttribute PeTreeNode treeNode, @ModelAttribute Category.CategoryEnumType categoryType) {
        if (treeNode == null) {
            throw new IllegalArgumentException("PeTreeNode parameter is illegal!");
        }

        Category category = new Category();
        if (categoryType != null) {
            category.setCategoryType(categoryType);
        }

        if (StringUtils.isNotBlank(treeNode.getpId())) {
            category.setParentId(treeNode.getpId());
        }

        if (StringUtils.isNotBlank(treeNode.getName())) {
            category.setCategoryName(treeNode.getName());
        }

        return category;
    }

    private JsonResult<PeTreeNode> getSaveOrUpdateCategoryResult(Category category) {
        //类别不能为空
        if (StringUtils.isBlank(category.getCategoryName())) {
            return new JsonResult<>(false, i18nService.getI18nValue("categoryName.not.blank"));
        }

        //类别名称不能超过30字符
        if (category.getCategoryName().length() > 30) {
            return new JsonResult<>(false, i18nService.getI18nValue("categoryName.length.maxLimit"));
        }

        //类别的种类为空
        if (category.getCategoryType() == null) {
            return new JsonResult<>(false, i18nService.getI18nValue("category.type.empty"));
        }

        return null;
    }

    /**
     * 删除类别
     */
    @ResponseBody
    @RequestMapping("manage/delete")
    public JsonResult delete(String id, @ModelAttribute Category.CategoryEnumType categoryType) {
        if (StringUtils.isBlank(id)) {
            return new JsonResult(false, i18nService.getI18nValue("category.not.exist"));
        }

        try {
            categoryService.delete(id, categoryType);
            return new JsonResult(true, i18nService.getI18nValue("delete.success"));
        } catch (PeException e) {
            return new JsonResult(false, e.getMessage());
        }

    }

    /**
     * 编辑类别
     */
    @ResponseBody
    @RequestMapping("manage/edit")
    public JsonResult<PeTreeNode> edit(@ModelAttribute PeTreeNode treeNode, @ModelAttribute Category.CategoryEnumType categoryType) {
        Category category = getCategory(treeNode, categoryType);
        if (StringUtils.isBlank(treeNode.getId())) {
            throw new IllegalArgumentException("PeTreeNode parameter is illegal!");
        }

        category.setId(treeNode.getId());
        JsonResult<PeTreeNode> jsonResult = getSaveOrUpdateCategoryResult(category);
        if (jsonResult != null) {
            return jsonResult;
        }

        try {
            categoryService.update(category);
            return new JsonResult<>(true, JsonResult.SUCCESS);
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }
    }

    /**
     * 类别上移下移
     */
    @ResponseBody
    @RequestMapping("manage/moveLevel")
    public JsonResult moveLevel(String id, boolean isUp) {
        try {
            categoryService.moveLevel(id, isUp);
            return new JsonResult(true, JsonResult.SUCCESS);
        } catch (PeException e) {
            return new JsonResult(false, e.getMessage());
        }
    }

    /**
     * 判断题库名称是否存在
     *
     * @param category
     * @return
     */
    @ResponseBody
    @RequestMapping("manage/checkNameExists")
    public JsonResult checkNameExists(@ModelAttribute Category category) {
        try {
            String catagoryId = categoryService.checkCatagoryName(category);
            if (StringUtils.isBlank(catagoryId)) {
                return new JsonResult<>(false, i18nService.getI18nValue("category.not.exist"));
            } else {
                return new JsonResult<>(true, JsonResult.SUCCESS, catagoryId);
            }
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }

    }

}
