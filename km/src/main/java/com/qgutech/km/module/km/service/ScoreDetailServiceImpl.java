package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.ScoreDetail;
import com.qgutech.km.module.km.model.ScoreRule;
import com.qgutech.km.utils.PeException;
import com.qgutech.km.utils.PeUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Restrictions;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 积分明细
 *
 * @author TangFD@HF 2018-8-21
 */
@Service("scoreDetailService")
public class ScoreDetailServiceImpl extends BaseServiceImpl<ScoreDetail> implements ScoreDetailService {
    @Resource
    private KnowledgeService knowledgeService;
    @Resource
    private ScoreRuleService scoreRuleService;


    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Page<ScoreDetail> searchStatistic(ScoreDetail detail, PageParam pageParam) {
        PeUtils.validPage(pageParam);
        if (detail == null) {
            throw new PeException("detail param is invalid!");
        }

        Map<String, Object> params = new HashMap<>(5);
        StringBuilder sql = new StringBuilder("");
        sql.append(" FROM t_uc_user u INNER JOIN t_uc_organize o ON u.organize_id=o.id");
        sql.append(" LEFT JOIN t_km_score_detail sd ON u.id=sd.user_id");
        sql.append(" WHERE u.corp_code=:corpCode AND u.status=:status");
        params.put("corpCode", ExecutionContext.getCorpCode());
        params.put("status", "ENABLE");
        String codeAndName = detail.getCodeAndName();
        if (StringUtils.isNotEmpty(codeAndName)) {
            sql.append(" AND (u.login_name ILIKE :name or employee_code ILIKE :name or user_name ILIKE :name)");
            params.put("name", "%" + codeAndName + "%");
        }

        sql.append(" GROUP BY u.id,o.organize_name");
        Page<ScoreDetail> page = new Page<>();
        NamedParameterJdbcTemplate jdbcTemplate = getJdbcTemplate();
        if (pageParam.isAutoCount()) {
            List<Long> total = jdbcTemplate.queryForList("SELECT count(*)" + sql, params, Long.class);
            if (CollectionUtils.isEmpty(total)) {
                return page;
            }

            page.setTotal(total.size());
        }

        sql.append(" ORDER BY score DESC,u.id");
        if (pageParam.isAutoPaging()) {
            sql.append(" LIMIT :searchCount OFFSET :start");
            params.put("searchCount", pageParam.getPageSize());
            params.put("start", pageParam.getStart());
        }

        String query = "SELECT u.*,o.organize_name,SUM(COALESCE(sd.score,0)) score " + sql;
        List<ScoreDetail> scoreDetails = jdbcTemplate.query(query, params, (resultSet, i) -> {
            ScoreDetail scoreDetail = new ScoreDetail();
            scoreDetail.setUserId(resultSet.getString("id"));
            scoreDetail.setLoginName(resultSet.getString("login_name"));
            scoreDetail.setEmployeeCode(resultSet.getString("employee_code"));
            scoreDetail.setUserName(resultSet.getString("user_name"));
            scoreDetail.setOrganizeName(resultSet.getString("organize_name"));
            scoreDetail.setScore(resultSet.getInt("score"));
            return scoreDetail;
        });

        page.setRows(scoreDetails);
        return page;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Page<ScoreDetail> searchDetail(ScoreDetail detail, PageParam pageParam) {
        PeUtils.validPage(pageParam);
        if (detail == null || StringUtils.isEmpty(detail.getUserId())) {
            throw new PeException("detail param is invalid!");
        }

        Map<String, Object> params = new HashMap<>(5);
        StringBuilder sql = new StringBuilder(" FROM t_km_score_detail sd");
        sql.append(" INNER JOIN t_km_score_rule sr ON sd.rule_id=sr.id");
        sql.append(" INNER JOIN t_uc_user u ON sd.opt_user_id=u.id");
        sql.append(" INNER JOIN t_km_knowledge k ON sd.knowledge_id=k.id");
        sql.append(" WHERE sd.corp_code=:corpCode AND sd.user_id=:userId");
        params.put("corpCode", ExecutionContext.getCorpCode());
        params.put("userId", detail.getUserId());
        String ruleId = detail.getRuleId();
        if (StringUtils.isNotEmpty(ruleId)) {
            sql.append(" AND sr.id=:ruleId");
            params.put("ruleId", ruleId);
        }

        Page<ScoreDetail> page = new Page<>();
        NamedParameterJdbcTemplate jdbcTemplate = getJdbcTemplate();
        if (pageParam.isAutoCount()) {
            Long total = jdbcTemplate.queryForObject("SELECT count(*)" + sql, params, Long.class);
            if (total == null || total == 0) {
                return page;
            }

            page.setTotal(total);
        }

        sql.append(" ORDER BY sd.create_time DESC");
        if (pageParam.isAutoPaging()) {
            sql.append(" LIMIT :searchCount OFFSET :start");
            params.put("searchCount", pageParam.getPageSize());
            params.put("start", pageParam.getStart());
        }

        String query = "SELECT sr.name,k.knowledge_name,u.user_name,sd.score,sd.create_time " + sql;
        List<ScoreDetail> scoreDetails = jdbcTemplate.query(query, params, (resultSet, i) -> {
            ScoreDetail scoreDetail = new ScoreDetail();
            scoreDetail.setRuleName(resultSet.getString("name"));
            scoreDetail.setKnowledgeName(resultSet.getString("knowledge_name"));
            scoreDetail.setUserName(resultSet.getString("user_name"));
            scoreDetail.setScore(resultSet.getInt("score"));
            Timestamp createTime = resultSet.getTimestamp("create_time");
            scoreDetail.setCreateTime(createTime);
            scoreDetail.setCreateTimeStr(KnowledgeConstant.TIME_FORMAT.format(createTime));
            return scoreDetail;
        });

        page.setRows(scoreDetails);
        return page;
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void addScore(List<String> knowledgeIds, String ruleCode) {
        /*if (CollectionUtils.isEmpty(knowledgeIds) || StringUtils.isEmpty(ruleCode)) {
            throw new PeException("knowledgeIds and ruleCode must be not empty!");
        }

        ScoreRule scoreRule = scoreRuleService.getByCode(ruleCode);
        if (scoreRule == null) {
            throw new PeException("ruleCode not exist!");
        }

        List<Knowledge> knowledgeList = knowledgeService.getKnowledgeByIds(knowledgeIds);
        if (CollectionUtils.isEmpty(knowledgeList)) {
            return;
        }

        int score = scoreRule.getScore();
        String ruleId = scoreRule.getId();
        String corpCode = ExecutionContext.getCorpCode();
        String userId = ExecutionContext.getUserId();
        List<ScoreDetail> scoreDetails = new ArrayList<>(knowledgeList.size());
        for (Knowledge knowledge : knowledgeList) {
            if (KnowledgeConstant.SCORE_RULE_DOWNLOAD.equals(ruleCode) && userId.equals(knowledge.getCreateBy())) {
                continue;
            }

            String knowledgeType = knowledge.getKnowledgeType();
            if ("file".equals(knowledgeType)) {
                continue;
            }

            ScoreDetail detail = new ScoreDetail();
            detail.setScore(score);
            detail.setRuleId(ruleId);
            detail.setCorpCode(corpCode);
            detail.setUserId(knowledge.getCreateBy());
            detail.setKnowledgeId(knowledge.getId());
            detail.setOptUserId(userId);
            scoreDetails.add(detail);
        }

        if (scoreDetails.size() > 0) {
            batchSave(scoreDetails);
        }*/
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Map<String, Boolean> getKnowledgeIdMapByRuleId(String ruleId) {
        if (StringUtils.isEmpty(ruleId)) {
            throw new PeException("ruleId must be not empty!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.eq(ScoreDetail.RULE_ID, ruleId));
        List<ScoreDetail> scoreDetails = listByCriterion(conjunction);
        if (CollectionUtils.isEmpty(scoreDetails)) {
            return new HashMap<>(0);
        }

        Map<String, Boolean> knowledgeIdMap = new HashMap<>(scoreDetails.size());
        for (ScoreDetail scoreDetail : scoreDetails) {
            knowledgeIdMap.put(scoreDetail.getKnowledgeId(), true);
        }

        return knowledgeIdMap;
    }
}
