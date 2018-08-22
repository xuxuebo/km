package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.module.km.model.ScoreRule;
import com.qgutech.km.utils.PeException;
import com.qgutech.km.utils.PeUtils;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Restrictions;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 积分规则
 *
 * @author TangFD@HF 2018-8-21
 */
@Service("scoreRuleService")
public class ScoreRuleServiceImpl extends BaseServiceImpl<ScoreRule> implements ScoreRuleService {

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Page<ScoreRule> search(ScoreRule rule, PageParam pageParam) {
        PeUtils.validPage(pageParam);
        if (rule == null) {
            throw new PeException("rule param is invalid");
        }

        Map<String, Object> params = new HashMap<>(4);
        StringBuilder sql = new StringBuilder(" from t_km_score_rule where corp_code = :corpCode");
        params.put("corpCode", ExecutionContext.getCorpCode());
        String name = rule.getName();
        if (StringUtils.isNotEmpty(name)) {
            sql.append(" and (code ilike :name or name ilike :name)");
            params.put("name", "%" + name + "%");
        }

        Page<ScoreRule> page = new Page<>();
        NamedParameterJdbcTemplate jdbcTemplate = getJdbcTemplate();
        if (pageParam.isAutoCount()) {
            Long total = jdbcTemplate.queryForObject("SELECT count(*)" + sql, params, Long.class);
            if (total == null || total == 0) {
                return page;
            }

            page.setTotal(total);
        }

        sql.append(" order by update_time desc");
        if (pageParam.isAutoPaging()) {
            sql.append(" limit :searchCount offset :start");
            params.put("searchCount", pageParam.getPageSize());
            params.put("start", pageParam.getStart());
        }

        List<ScoreRule> scoreRules = jdbcTemplate.query("select * " + sql, params, (resultSet, i) -> {
            ScoreRule scoreRule = new ScoreRule();
            scoreRule.setId(resultSet.getString("id"));
            scoreRule.setCode(resultSet.getString("code"));
            scoreRule.setName(resultSet.getString("name"));
            scoreRule.setScore(resultSet.getInt("score"));
            return scoreRule;
        });

        page.setRows(scoreRules);
        return page;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public ScoreRule getByCode(String ruleCode) {
        if (StringUtils.isEmpty(ruleCode)) {
            throw new PeException("ruleCode must be not empty!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.eq(ScoreRule.CODE, ruleCode));
        return getByCriterion(conjunction);
    }
}
