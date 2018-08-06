package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.KnowledgeLog;
import com.qgutech.km.utils.PeDateUtils;
import com.qgutech.km.utils.PeException;
import com.qgutech.km.utils.PeUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author TangFD@HF 2018/8/1
 */
@Service("knowledgeLogService")
public class KnowledgeLogServiceImpl extends BaseServiceImpl<KnowledgeLog> implements KnowledgeLogService {

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Page<KnowledgeLog> search(KnowledgeLog knowledgeLog, PageParam pageParam) {
        PeUtils.validPage(pageParam);
        if (knowledgeLog == null || StringUtils.isEmpty(knowledgeLog.getLibraryId())) {
            throw new PeException("knowledgeLog condition invalid!");
        }

        Map<String, Object> params = new HashMap<>();
        StringBuilder sql = getSqlBuilder(knowledgeLog, params);
        Page<KnowledgeLog> page = new Page<>();
        page.setPageSize(pageParam.getPageSize());
        NamedParameterJdbcTemplate jdbcTemplate = getJdbcTemplate();
        if (pageParam.isAutoCount()) {
            Long total = jdbcTemplate.queryForObject("SELECT COUNT(*)" + sql, params, Long.class);
            if (total == null || total == 0) {
                return page;
            }

            page.setTotal(total);
        }

        StringBuilder searchSql = new StringBuilder("SELECT kl.type,kl.create_time,u.user_name,k.knowledge_name");
        searchSql.append(sql);
        searchSql.append(" ORDER BY kl.create_time DESC");
        if (pageParam.isAutoPaging()) {
            searchSql.append(" LIMIT :num OFFSET :start");
            params.put("num", pageParam.getPageSize());
            params.put("start", pageParam.getStart());
        }

        List<KnowledgeLog> knowledgeLogs = jdbcTemplate.query(searchSql.toString(), params, (resultSet, i) -> {
            KnowledgeLog log = new KnowledgeLog();
            log.setType(resultSet.getString("type"));
            log.setCreateTimeStr(KnowledgeConstant.DATE_FORMAT.format(resultSet.getTimestamp("create_time")));
            log.setUserName(resultSet.getString("user_name"));
            log.setKnowledgeName(resultSet.getString("knowledge_name"));
            return log;
        });

        page.setRows(knowledgeLogs);
        return page;
    }

    private StringBuilder getSqlBuilder(KnowledgeLog knowledgeLog, Map<String, Object> params) {
        StringBuilder sql = new StringBuilder(" FROM t_km_knowledge_log kl");
        sql.append(" INNER JOIN t_km_knowledge k on kl.knowledge_id=k.id");
        sql.append(" INNER JOIN t_uc_user u ON kl.create_by=u.id");
        sql.append(" WHERE kl.corp_code=:corpCode AND kl.library_id=:libraryId");
        params.put("corpCode", ExecutionContext.getCorpCode());
        params.put("libraryId", knowledgeLog.getLibraryId());
        String knowledgeName = knowledgeLog.getKnowledgeName();
        if (StringUtils.isNotEmpty(knowledgeName)) {
            sql.append(" AND k.knowledge_name ILIKE :name");
            params.put("name", "%" + knowledgeName + "%");
        }

        String userName = knowledgeLog.getUserName();
        if (StringUtils.isNotEmpty(userName)) {
            sql.append(" AND (u.user_name ILIKE :userName OR u.login_name ILIKE :userName OR u.employee_code ILIKE :userName)");
            params.put("userName", "%" + knowledgeName + "%");
        }

        Date startTime = knowledgeLog.getStartTime();
        if (startTime != null) {
            sql.append(" AND kl.create_time >= :startTime");
            params.put("startTime", PeDateUtils.getFirstDate(startTime));
        }

        Date endTime = knowledgeLog.getEndTime();
        if (endTime != null) {
            sql.append(" AND kl.create_time <= :endTime");
            params.put("endTime", PeDateUtils.getEndDate(endTime));
        }

        return sql;
    }
}
