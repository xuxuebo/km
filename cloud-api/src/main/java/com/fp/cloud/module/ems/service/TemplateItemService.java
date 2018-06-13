package com.fp.cloud.module.ems.service;

import com.fp.cloud.base.model.Page;
import com.fp.cloud.base.service.BaseService;
import com.fp.cloud.base.model.PageParam;
import com.fp.cloud.base.vo.TemplatePreview;
import com.fp.cloud.module.ems.model.Item;
import com.fp.cloud.module.ems.model.PaperTemplateItem;

import java.util.List;
import java.util.Map;

/**
 * PaperTemplateItemRel Service
 *
 * @since 2016年10月19日16:53:52
 */
public interface TemplateItemService extends BaseService<PaperTemplateItem> {

    /**
     * 根据试卷模板Id集合删除试卷模板和试题关联信息
     *
     * @param paperTemplateIds 试卷模板Id集合
     * @return 受影响的行数
     * @since 2016年10月20日09:33:33 author by WuKang@HF
     */
    int batchDelete(List<String> paperTemplateIds);

    /**
     * 根据试卷模板Id查询出试题Id集合
     *
     * @param paperTemplateId 试卷模板Id
     * @return 试题Id集合
     * @since 2016年10月20日14:24:43 author by WuKang@HF
     */
    List<String> listItemIds(String paperTemplateId);

    /**
     * 该方法用于根据给定的试卷模板的Id，查询该模板下的试题集合列表
     *
     * @param templateId 试卷模板Id
     * @param pageParam  分页
     * @return 该试卷模板下的试题的集合{@linkplain Item}
     * @throws java.lang.IllegalArgumentException 当templateId为空时
     */
    Page<Item> searchFixItemsByTemplateId(String templateId, PageParam pageParam);

    /**
     * 根据试卷模板Id,查询出当前模板已经和试题的关联数据,分页查询结果
     *
     * @param templateId 试卷模板Id
     * @param pageParam  分页对象
     * @return 分页查询已被试卷模板选中的结果集
     * @throws java.lang.IllegalArgumentException 当templateId为空时
     */
    Page<Item> searchByTemplateId(String templateId, PageParam pageParam);

    /**
     * 通过试卷模板ID获取试题信息（预览试卷信息）
     *
     * @param paperTemplateId 试卷模板ID
     * @return 试题信息
     * @since 2016年10月21日13:19:13
     */
    Map<Item.ItemType, TemplatePreview> findMustItem(String paperTemplateId);

    /**
     * 预览试卷
     *
     * @param templateId 试卷模板ID
     * @return 试题信息
     * @since 2017年5月16日19:27:41
     */
    Map<Item.ItemType, TemplatePreview> previewPaper(String templateId);

    /**
     * @param templateId 模板Id
     * @return 返回Map
     * <ul>
     * <li>key:{@linkplain Item.ItemType 试题类型}</li>
     * <li>value:该类型的下的必考题集合</li>
     * </ul>
     */
    Map<Item.ItemType, List<Item>> findFixItemMap(String templateId);

    /**
     * 计算必考题每个类型对应的题目数
     *
     * @param templateId 模板ID
     * @return author by LiYanCheng@HF
     * @since 2016年11月12日15:56:37
     */
    Map<Item.ItemType, Long> countMustItem(String templateId);

    /**
     * 该方法用于批量删除指定试卷模板的已存在的试题
     *
     * @param templateId 试卷模板Id
     * @param itemIds    要删除的试题Id集合
     * @return 影响的行数
     */
    int deleteByTemplateIdAndItemIds(String templateId, List<String> itemIds);

    /**
     * 获取必考题的总分
     *
     * @param templateId 模板ID
     * @return 总分数
     * @since 2016年11月14日15:30:39
     */
    Double sumMustItemMark(String templateId);

    /**
     * 获取已经停用的试题
     *
     * @param templateId 模板ID
     * @return author by LiYanCheng@HF
     * @since 2016年11月15日18:45:37
     */
    List<Item> listStopItem(String templateId);

    /**
     * 获取正常的试题
     *
     * @param templateId 模板ID
     * @return author by LiYanCheng@HF
     * @since 2016年11月15日18:45:37
     */
    List<String> listEnableItem(String templateId);

    /**
     * 获取当前模板下，试题的最大排序
     *
     * @param templateId 试卷模板Id
     * @return 该试卷模板下的最大排序
     */
    double getMaxShowOrder(String templateId);

    /**
     * 移动必考题
     *
     * @param templateId 模板ID
     * @param itemId     试题ID
     * @param up         上移或者下移
     * @return
     * @since 2016年11月16日18:30:58
     */
    void moveMustItem(String templateId, String itemId, boolean up);

    /**
     * 计算【固定卷】试卷模板最多可以生成多少套试卷
     *
     * @param templateId 试卷模板ID
     * @return 试卷总数
     * @since 2017年5月16日16:05:57
     */
    Long countMarkPaper(String templateId);
}
