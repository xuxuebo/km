package com.qgutech.km.module.km.service;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.ScoreDetail;

import java.util.List;
import java.util.Map;


/**
 * 积分明细
 *
 * @author TangFD@HF 2018-8-21
 */
public interface ScoreDetailService extends BaseService<ScoreDetail> {

    /**
     * 积分统计
     *
     * @param detail    查询条件，不可为空
     * @param pageParam 分页对象
     * @return 人员积分统计信息
     * @throws RuntimeException 当pageParam不符合条件，或者detail为空时
     * @since TangFD@HF 2018-8-21
     */
    Page<ScoreDetail> searchStatistic(ScoreDetail detail, PageParam pageParam);

    /**
     * 查询积分明细
     *
     * @param detail    查询条件，不可为空
     * @param pageParam 分页对象
     * @return 人员积分明细信息
     * @throws RuntimeException 当pageParam不符合条件，或者detail为空，或者userId为空时
     * @since TangFD@HF 2018-8-21
     */
    Page<ScoreDetail> searchDetail(ScoreDetail detail, PageParam pageParam);

    /**
     * 根据积分规则，为操作的知识创建者添加积分
     *
     * @param knowledgeIds 知识Id列表，不可为空
     * @param ruleCode     积分规则编号，不可为空 <ul>
     *                     <li>upload</li>
     *                     <li>download</li>
     *                     <li>share</li>
     *                     <li>delete</li>
     *                     <li>cancel_share</li>
     *                     </ul>
     * @throws RuntimeException 当knowledgeIds为空，或者ruleCode为，或者ruleCode不存在时
     * @since TangFD@HF 2018-8-21
     */
    void addScore(List<String> knowledgeIds, String ruleCode);

    /**
     * 根据规则Id获取所有的知识Id映射
     *
     * @param ruleId 规则Id，不可为空
     * @return 知识Id映射，key：knowledgeId,value:true
     * @throws RuntimeException 当ruleId为空时
     * @since TangFD@HF 2018-8-23
     */
    Map<String, Boolean> getKnowledgeIdMapByRuleId(String ruleId);
}
