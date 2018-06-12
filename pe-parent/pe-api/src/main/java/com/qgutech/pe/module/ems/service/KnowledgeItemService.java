package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.Item;
import com.qgutech.pe.module.ems.model.Knowledge;
import com.qgutech.pe.module.ems.model.KnowledgeItem;

import java.util.List;
import java.util.Map;

/**
 * 知识点试题关联Service
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月19日16:25:03
 */
public interface KnowledgeItemService extends BaseService<KnowledgeItem> {

    /**
     * 保存知识点试题关联信息
     *
     * @param itemId       试题ID
     * @param knowledgeIds 知识点集合
     * @return 执行数量
     * @since 2016年10月19日16:57:36
     */
    List<String> save(String itemId, List<String> knowledgeIds);

    /**
     * 通过知识点id集合获取题库ID集合
     *
     * @param knowledgeIds 知识点ID集合
     * @return 试题ID
     * @since 2016年10月19日17:09:26
     */
    List<String> listItemId(List<String> knowledgeIds, List<String> itemBankIds ,String itemAttribute);

    /**
     * 通过试题id集合获取知识点信息
     *
     * @param itemIds 试题ID集合
     * @return 知识点试题关联信息
     * @since 2016年10月19日17:23:57
     */
    Map<String, List<Knowledge>> findKnowledge(List<String> itemIds);

    /**
     * 通过试题id集合获取知识点信息
     *
     * @param itemIds 试题ID集合
     * @return 知识点试题关联信息
     * @since 2016年10月19日17:23:57
     */
    List<Knowledge> list(List<String> itemIds);

    /**
     * 通过题库ID获取试卷对应的知识点
     *
     * @param bankIds       题库ID集合
     * @param knowledgeName 题库名称
     * @param itemAttribute  试题属性
     * @return 知识点集合
     * @since 2016年10月21日11:44:12
     */
    List<Knowledge> listKnowledge(List<String> bankIds, String knowledgeName,String itemAttribute);

    /**
     * 通过实体ID获取知识点集合信息
     *
     * @param itemId 实体ID
     * @return author by LiYanCheng@HF
     * @since 2016年11月2日11:13:58
     */
    List<Knowledge> listKnowledge(String itemId);
    /**
     * 通过知识点和题库获取试题
     *
     * @param bankIds       题库ID集合
     * @param knowledgeIds  知识点ID集合
     * @param itemAttribute 试题的属性
     * @return  数量
     * @since 2017年3月22日13:08:54
     */

    int countItem(List<String> bankIds, List<String> knowledgeIds, String itemAttribute);

    /**
     * 获取练习中试题总数和类型
     *
     * @param exerciseId   练习的Id
     * @param knowledgeIds 知识点集合
     * @return exercise
     */

    Map<Item.ItemType, Integer> findItemTypesAndCount(String exerciseId, List<String> knowledgeIds);
}
