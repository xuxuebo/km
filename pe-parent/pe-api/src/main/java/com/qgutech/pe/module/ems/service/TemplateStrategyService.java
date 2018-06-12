package com.qgutech.pe.module.ems.service;

import com.qgutech.pe.base.service.BaseService;
import com.qgutech.pe.module.ems.model.ItemBank;
import com.qgutech.pe.module.ems.model.Knowledge;
import com.qgutech.pe.module.ems.model.TemplateStrategy;

import java.util.List;

/**
 * 模板策略Service
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月20日15:13:36
 */
public interface TemplateStrategyService extends BaseService<TemplateStrategy> {

    /**
     * 通过模板获取题库信息
     *
     * @param templateId 模板ID
     * @return 题库信息集合
     * @since 2016年10月20日15:17:38
     */
    List<ItemBank> listItemBank(String templateId);

    /**
     * 通过模板获取知识点信息
     *
     * @param templateId 模板ID
     * @return 知识点信息集合
     * @since 2016年10月20日15:17:38
     */
    List<Knowledge> listKnowledge(String templateId);

    /**
     * 通过模板获取题库信息
     *
     * @param templateId   模板ID
     * @param strategyType 类型
     * @return 题库信息集合
     * @since 2016年10月20日15:17:38
     */
    List<String> listObjectId(String templateId, TemplateStrategy.StrategyType strategyType);

    /**
     * 通过题库ID和创建人ID删除组卷策略题库
     *
     * @param bankId  题库ID
     * @param userIds 创建人ID
     * @return 执行数量
     * @since 2016年10月20日15:51:02
     */
    int delete(String bankId, List<String> userIds);

    /**
     * 通过模板ID删除组卷策略信息
     *
     * @param templateIds 模板ID集合
     * @return author by LiYanCheng@HF
     * @since 2016年10月25日17:27:33
     */
    int delete(List<String> templateIds);

    /**
     * 批量保存模板组卷策略信息
     *
     * @param templateStrategies 知识点 题库集合信息
     * @param templateId         模板ID
     * @return ID集合
     * @since 2016年10月20日16:10:52
     */
    List<String> save(List<TemplateStrategy> templateStrategies, String templateId);
}
