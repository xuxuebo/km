package com.qgutech.km.module.km.service;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.ScoreRule;


/**
 * 积分规则
 *
 * @author TangFD@HF 2018-8-21
 */
public interface ScoreRuleService extends BaseService<ScoreRule> {

    /**
     * 根据条件获取当前公司积分规则列表
     *
     * @param rule      规则条件，不可为空 <ul>
     *                  <li>{@link ScoreRule#NAME},规则名称或编号</li>
     *                  </ul>
     * @param pageParam 分页对象
     * @return 包含积分规则集合的分页对象 <ul>
     * <li>{@link ScoreRule#CODE},规则编号</li>
     * <li>{@link ScoreRule#NAME},规则名称</li>
     * <li>{@link ScoreRule#SCORE},规则分值</li>
     * </ul>
     * @throws RuntimeException 当pageParam不符合条件，或者rule为空时
     * @since TangFD@HF 2018-8-21
     */
    Page<ScoreRule> search(ScoreRule rule, PageParam pageParam);

    /**
     * 根据积分规则编号，获取积分规则实体信息
     *
     * @param ruleCode 积分规则编号，不可为空 <ul>
     *                 <li>upload</li>
     *                 <li>download</li>
     *                 <li>share</li>
     *                 <li>delete</li>
     *                 <li>cancel_share</li>
     *                 </ul>
     * @return 积分规则实体信息
     * @throws RuntimeException 当ruleCode为空时
     * @since TangFD@HF 2018-8-21
     */
    ScoreRule getByCode(String ruleCode);
}
