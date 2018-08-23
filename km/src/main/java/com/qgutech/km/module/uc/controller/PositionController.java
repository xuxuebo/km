package com.qgutech.km.module.uc.controller;

import com.qgutech.km.base.model.Category;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.CategoryService;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.base.vo.PeTreeNode;
import com.qgutech.km.module.uc.model.Position;
import com.qgutech.km.module.uc.service.PositionService;
import com.qgutech.km.module.uc.service.UserPositionService;
import com.qgutech.km.utils.PeException;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 岗位控制层
 *
 * @author WuKang@HF
 * @version 1.0.0
 * @since 2016年11月1日12:36:36
 */
@Controller
@RequestMapping("uc/position")
public class PositionController {
    @Resource
    private CategoryService categoryService;
    @Resource
    private PositionService positionService;
    @Resource
    private UserPositionService userPositionService;

    @RequestMapping("manage/initPage")
    public String initPage() {
        return "uc/position/positionManage";
    }

    /**
     * 岗位类别节点树
     *
     * @since 2016年11月1日13:23:02 author by WuKang@HF
     */
    @ResponseBody
    @RequestMapping("manage/listTree")
    public List<PeTreeNode> showTree() {
        return categoryService.listTreeNode(Category.CategoryEnumType.POSITION);
    }

    /**
     * 用户管理显示岗位类别以及岗位树
     */
    @ResponseBody
    @RequestMapping("manage/listPositionTree")
    public List<PeTreeNode> listPositionTree() {
        List<PeTreeNode> treeNodes = categoryService.listTreeNode(Category.CategoryEnumType.POSITION);
        if (CollectionUtils.isEmpty(treeNodes)) {
            return new ArrayList<>(0);
        }

        List<String> categoryIds = treeNodes.stream().map(PeTreeNode::getId).collect(Collectors.toList());
        List<Position> positions = positionService.listByCategory(categoryIds);
        if (CollectionUtils.isEmpty(positions)) {
            return treeNodes;
        }

        List<PeTreeNode> childTreeNodes = new ArrayList<>(positions.size());
        positions.forEach(position -> {
            PeTreeNode peTreeNode = new PeTreeNode();
            peTreeNode.setName(position.getPositionName());
            peTreeNode.setId(position.getId());
            peTreeNode.setpId(position.getCategory().getId());
            childTreeNodes.add(peTreeNode);
        });

        treeNodes.addAll(childTreeNodes);
        return treeNodes;
    }

    /**
     * 岗位类别节点树
     *
     * @since 2016年11月1日13:23:02 author by WuKang@HF
     */
    @ResponseBody
    @RequestMapping("manage/listPosition")
    public List<Position> listPosition(String categoryId) {
        List<String> categoryIds = categoryService.listCategoryId(categoryId, Category.CategoryEnumType.POSITION);
        if (CollectionUtils.isEmpty(categoryIds)) {
            return new ArrayList<>(0);
        }

        return positionService.listByCategory(categoryIds);
    }

    /**
     * 岗位列表查询
     *
     * @since 2016年11月1日13:25:22 author by WuKang@HF
     */
    @ResponseBody
    @RequestMapping("manage/search")
    public Page<Position> search(@ModelAttribute Position position, @ModelAttribute PageParam pageParam) {
        return positionService.search(position, pageParam);
    }

    /**
     * 岗位新增
     *
     * @since 2016年11月1日13:30:28 author by WuKang@HF
     */
    @ResponseBody
    @RequestMapping("manage/savePosition")
    public JsonResult<Position> savePosition(@ModelAttribute Position position) {
        try {
            positionService.save(position);
            return new JsonResult<>(true, JsonResult.SUCCESS);
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }
    }

    /**
     * 岗位编辑
     *
     * @since 2016年11月1日13:37:33 author by WuKang@HF
     */
    @ResponseBody
    @RequestMapping("manage/updatePosition")
    public JsonResult<Position> updatePosition(@ModelAttribute Position position) {
        try {
            positionService.update(position);
            return new JsonResult<>(true, JsonResult.SUCCESS);
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }
    }

    /**
     * 删除岗位
     *
     * @since 2016年11月1日13:39:59 author by WuKang@HF
     */
    @ResponseBody
    @RequestMapping("manage/deletePosition")
    public JsonResult<Position> deletePosition(String positionId) {
        try {
            positionService.update(positionId, Position._positionStauts, Position.PositionStatus.DELETE);
            userPositionService.deleteByPositionId(positionId);
            return new JsonResult<>(true, JsonResult.SUCCESS);
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }
    }

    /**
     * 获取岗位信息(岗位名称、岗位类别名称、岗位类别id)
     */
    @ResponseBody
    @RequestMapping("manage/getPosition")
    public Position get(String positionId) {
        return positionService.get(positionId, Position.ID,
                Position._positionName, Position._category, Position._categoryName);
    }
}
