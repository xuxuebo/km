package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.*;
import com.qgutech.km.module.uc.model.Organize;
import com.qgutech.km.module.uc.service.OrganizeService;
import com.qgutech.km.module.uc.service.UserService;
import com.qgutech.km.utils.PeDateUtils;
import com.qgutech.km.utils.PeException;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2018/6/22.
 */
@Service("knowledgeRelService")
public class KnowledgeRelServiceImpl extends BaseServiceImpl<KnowledgeRel> implements KnowledgeRelService {
    @Resource
    private UserService userService;
    @Resource
    private ShareService shareService;
    @Resource
    private KnowledgeRelService knowledgeRelService;
    @Resource
    private StatisticService statisticService;
    @Resource
    private KnowledgeLogService knowledgeLogService;
    @Resource
    private OrganizeService organizeService;
    @Resource
    private LibraryService libraryService;
    @Resource
    private ScoreDetailService scoreDetailService;

    @Override
    @Transactional(readOnly = true)
    public List<KnowledgeRel> findByLibraryId(String libraryId) {
        if (StringUtils.isEmpty(libraryId)) {
            throw new PeException("libraryId not be null ");
        }
        Criterion criterion = Restrictions.and(Restrictions.eq(KnowledgeRel.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(KnowledgeRel.LIBRARY_ID, libraryId));

        List<KnowledgeRel> knowledgeRels = new ArrayList<>();
        knowledgeRels = listByCriterion(criterion,
                new Order[]{Order.desc(Library.CREATE_TIME)}
        );
        return knowledgeRels;
    }

    @Override
    @Transactional(readOnly = true)
    public List<KnowledgeRel> findByLibraryIdAndKnowledgeIds(String libraryId, List<String> knowledgeIds) {
        if (StringUtils.isEmpty(libraryId)) {
            throw new PeException("libraryId not be null ");
        }
        Criterion criterion = Restrictions.and(Restrictions.eq(KnowledgeRel.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(KnowledgeRel.LIBRARY_ID, libraryId),
                Restrictions.in(KnowledgeRel.KNOWLEDGE_ID, knowledgeIds));

        List<KnowledgeRel> knowledgeRels = new ArrayList<>();
        knowledgeRels = listByCriterion(criterion,
                new Order[]{Order.asc(Library.CREATE_TIME)}
        );
        return knowledgeRels;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<KnowledgeRel> findKnowledgeRel(Knowledge knowledge) {
        if (knowledge == null || StringUtils.isEmpty(knowledge.getLibraryId())) {
            throw new PeException("libraryId not be null ");
        }


        Conjunction conjunction = Restrictions.and(Restrictions.eq(KnowledgeRel.CORP_CODE, ExecutionContext.getCorpCode()));
        conjunction.add(Restrictions.eq(KnowledgeRel.LIBRARY_ID, knowledge.getLibraryId()));
        String createBy = knowledge.getCreateBy();
        if (StringUtils.isNotEmpty(createBy)) {
            List<String> userIds = userService.listUserId(createBy, null);
            if (CollectionUtils.isEmpty(userIds)) {
                return new ArrayList<>(0);
            }

            conjunction.add(Restrictions.in(KnowledgeRel.CREATE_BY, userIds));
        }

        Date startDate = knowledge.getStartDate();
        if (startDate != null) {
            conjunction.add(Restrictions.gt(KnowledgeRel.CREATE_TIME, PeDateUtils.getFirstDate(startDate)));
        }

        Date endDate = knowledge.getEndDate();
        if (endDate != null) {
            conjunction.add(Restrictions.lt(KnowledgeRel.CREATE_TIME, PeDateUtils.getEndDate(endDate)));
        }

        return listByCriterion(conjunction, new Order[]{Order.desc(Library.CREATE_TIME)});
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<String> getKnowledgeIdsByLibraryIdsAndUserIds(List<String> libraryIds, List<String> userIds) {
        if (CollectionUtils.isEmpty(libraryIds)) {
            throw new PeException("libraryIds not be empty!");
        }

        Conjunction conjunction = Restrictions.and(Restrictions.eq(KnowledgeRel.CORP_CODE, ExecutionContext.getCorpCode()));
        conjunction.add(Restrictions.in(KnowledgeRel.LIBRARY_ID, libraryIds));
        if (CollectionUtils.isNotEmpty(userIds)) {
            conjunction.add(Restrictions.in(KnowledgeRel.CREATE_BY, userIds));
        }

        List<KnowledgeRel> knowledgeRelList = listByCriterion(conjunction);
        if (CollectionUtils.isEmpty(knowledgeRelList)) {
            return new ArrayList<>(0);
        }

        List<String> knowledgeIds = new ArrayList<>(knowledgeRelList.size());
        knowledgeIds.addAll(knowledgeRelList.stream().map(KnowledgeRel::getKnowledgeId).collect(Collectors.toList()));
        return knowledgeIds;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Map<String, Boolean> getLibraryIdKnowledgeIdMap(List<String> libraryIds, List<String> knowledgeIds) {
        if (CollectionUtils.isEmpty(libraryIds) || CollectionUtils.isEmpty(knowledgeIds)) {
            throw new PeException("libraryIds and knowledgeIds not be empty!");
        }

        Conjunction conjunction = Restrictions.and(Restrictions.eq(KnowledgeRel.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.in(KnowledgeRel.LIBRARY_ID, libraryIds),
                Restrictions.in(KnowledgeRel.KNOWLEDGE_ID, knowledgeIds));
        List<KnowledgeRel> knowledgeRelList = listByCriterion(conjunction);
        if (CollectionUtils.isEmpty(knowledgeRelList)) {
            return new HashMap<>(0);
        }

        Map<String, Boolean> libraryIdKnowledgeIdMap = new HashMap<>(knowledgeRelList.size());
        for (KnowledgeRel knowledgeRel : knowledgeRelList) {
            libraryIdKnowledgeIdMap.put(knowledgeRel.getLibraryId() + "&" + knowledgeRel.getKnowledgeId(), true);
        }

        return libraryIdKnowledgeIdMap;
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void addToLibrary(Share share) {
        if (null == share
                || CollectionUtils.isEmpty(share.getLibraryIds())
                || CollectionUtils.isEmpty(share.getKnowledgeIds())) {
            throw new PeException("share param is invalid!");
        }

        List<String> knowledgeIds = share.getKnowledgeIds();
        Map<String, String> knowledgeIdAndShareIdMap = new HashMap<>();
        List<String> libraryIds = share.getLibraryIds();
        int size = knowledgeIds.size();
        String corpCode = ExecutionContext.getCorpCode();
        List<Share> shareList = new ArrayList<>(size);
        int capacity = size * libraryIds.size();
        List<KnowledgeRel> knowledgeRelList = new ArrayList<>(capacity);
        List<KnowledgeLog> knowledgeLogList = new ArrayList<>(capacity);
        for (String libraryId : libraryIds) {
            for (String knowledgeId : knowledgeIds) {
                String shareId = knowledgeIdAndShareIdMap.get(knowledgeId);
                if (StringUtils.isEmpty(shareId)) {
                    Share shareKnowledge = new Share();
                    shareKnowledge.setShareType(KnowledgeConstant.SHARE_NO_PASSWORD);
                    shareKnowledge.setExpireTime(KnowledgeConstant.SHARE_PERMANENT_VALIDITY);
                    shareKnowledge.setKnowledgeId(knowledgeId);
                    shareKnowledge.setPassword("");
                    shareKnowledge.setCorpCode(corpCode);
                    knowledgeIdAndShareIdMap.put(knowledgeId, "NEW_ADD");
                    shareList.add(shareKnowledge);
                }

                KnowledgeRel knowledgeRel = new KnowledgeRel();
                knowledgeRel.setKnowledgeId(knowledgeId);
                knowledgeRel.setLibraryId(libraryId);
                knowledgeRel.setShareId(shareId);
                knowledgeRel.setCorpCode(corpCode);
                knowledgeRelList.add(knowledgeRel);
                knowledgeLogList.add(new KnowledgeLog(knowledgeId, libraryId, KnowledgeConstant.LOG_UPLOAD));
            }
        }

        if (shareList.size() > 0) {
            shareService.batchSave(shareList);
            List<Statistic> statistics = new ArrayList<>(size);
            for (Share saveShared : shareList) {
                String sharedId = saveShared.getId();
                knowledgeIdAndShareIdMap.put(saveShared.getKnowledgeId(), sharedId);
                statistics.add(new Statistic(sharedId, 0, 0, 0));
            }

            //保存共享统计记录
            statisticService.batchSave(statistics);
            for (KnowledgeRel knowledgeRel : knowledgeRelList) {
                String shareId = knowledgeIdAndShareIdMap.get(knowledgeRel.getKnowledgeId());
                knowledgeRel.setShareId(shareId);
            }
        }

        knowledgeRelService.batchSave(knowledgeRelList);
        knowledgeLogService.batchSave(knowledgeLogList);
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void deleteByKnowledgeIdsAndLibraryId(List<String> knowledgeIds, String libraryId) {
        if (CollectionUtils.isEmpty(knowledgeIds)
                || StringUtils.isEmpty(libraryId)) {
            throw new PeException("libraryId and knowledgeIds must be not empty!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.in(KnowledgeRel.KNOWLEDGE_ID, knowledgeIds));
        conjunction.add(Restrictions.eq(KnowledgeRel.LIBRARY_ID, libraryId));
        delete(conjunction);
        List<KnowledgeLog> knowledgeLogs = new ArrayList<>(knowledgeIds.size());
        knowledgeLogs.addAll(knowledgeIds.stream().map(knowledgeId -> new KnowledgeLog(knowledgeId, libraryId, KnowledgeConstant.LOG_DELETE)).collect(Collectors.toList()));
        knowledgeLogService.batchSave(knowledgeLogs);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Statistic orgRank(int rankCount) {
        String sql = "SELECT o.id,count(kr.id) FROM t_uc_organize o LEFT JOIN t_km_knowledge_rel kr on o.id=kr.library_id "
                + " WHERE o.corp_code=:corpCode and o.organize_status=:status AND o.parent_id is not null  GROUP BY o.id";
        Map<String, Object> param = new HashMap<>(2);
        param.put("corpCode", ExecutionContext.getCorpCode());
        param.put("status", Organize.OrganizeStatus.ENABLE.name());
        Map<String, Long> orgIdAndCountMap = new HashMap<>();
        getJdbcTemplate().query(sql, param, (resultSet, i) -> {
            String orgId = resultSet.getString("id");
            long count = resultSet.getLong("count");
            orgIdAndCountMap.put(orgId, count);
            return null;
        });

        Organize root = organizeService.getRoot();
        String rootId = root.getId();
        Map<String, Organize> organizeMap = organizeService.findAll();
        List<Organize> firstLevels = new ArrayList<>();
        Map<String, String> orgIdAndFirstIdMap = new HashMap<>();
        for (Organize organize : organizeMap.values()) {
            String parentId = organize.getParentId();
            if (StringUtils.isEmpty(parentId)) {
                continue;
            }

            String organizeId = organize.getId();
            if (rootId.equalsIgnoreCase(parentId)) {
                firstLevels.add(organize);
                orgIdAndFirstIdMap.put(organizeId, organizeId);
            }

            String idPath = organize.getIdPath();
            String[] split = idPath.split("\\.");
            if (split.length < 2) {
                continue;
            }

            orgIdAndFirstIdMap.put(organizeId, split[1]);
        }

        Map<String, Long> firstIdAndCountMap = new HashMap<>();
        for (Map.Entry<String, Long> entry : orgIdAndCountMap.entrySet()) {
            String orgId = entry.getKey();
            String firstOrgId = orgIdAndFirstIdMap.get(orgId);
            if (StringUtils.isEmpty(firstOrgId)) {
                continue;
            }

            Long count = firstIdAndCountMap.get(firstOrgId);
            count = count == null ? 0 : count;
            Long value = entry.getValue();
            value = value == null ? 0 : value;
            firstIdAndCountMap.put(firstOrgId, count + value);
        }

        List<Organize> organizes = new ArrayList<>(firstIdAndCountMap.size());
        for (String firstId : firstIdAndCountMap.keySet()) {
            Organize organize = organizeMap.get(firstId);
            Long count = firstIdAndCountMap.get(firstId);
            organize.setUserCount(count == null ? 0 : count);
            organizes.add(organize);
        }

        int size = organizes.size();
        if (size == 0) {
            return new Statistic();
        }

        Collections.sort(organizes, (o1, o2) -> (int) (o2.getUserCount() - o1.getUserCount()));
        List<String> orgNames = new ArrayList<>(size);
        List<Long> countList = new ArrayList<>(size);
        for (Organize organize : organizes) {
            orgNames.add(organize.getOrganizeName());
            countList.add(organize.getUserCount());
        }

        rankCount = rankCount <= 0 ? 5 : rankCount;
        rankCount = rankCount > size ? size : rankCount;
        Statistic statistic = new Statistic();
        statistic.setNames(orgNames.subList(0, rankCount));
        statistic.setCounts(countList.subList(0, rankCount));
        return statistic;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Statistic libraryRank(String type, int rankCount) {
        if (StringUtils.isEmpty(type)) {
            throw new PeException("type must be not empty!");
        }

        rankCount = rankCount <= 0 ? 5 : rankCount;
        Map<String, Object> param = new HashMap<>(3);
        StringBuilder sql = new StringBuilder("SELECT k.library_name,count(kr.id) total FROM t_km_knowledge_rel kr ");
        sql.append(" INNER JOIN t_km_library k ON k.id=kr.library_id ");
        sql.append(" WHERE kr.corp_code=:corpCode and k.library_type=:type ");
        param.put("corpCode", ExecutionContext.getCorpCode());
        param.put("type", type);
        sql.append(" GROUP BY kr.library_id,k.library_name ");
        sql.append(" ORDER BY total DESC,kr.library_id LIMIT :rankCount");
        param.put("rankCount", rankCount);

        List<String> names = new ArrayList<>(rankCount);
        List<ValuePair> pairs = new ArrayList<>(rankCount);
        getJdbcTemplate().query(sql.toString(), param, (resultSet, i) -> {
            String libraryName = resultSet.getString("library_name");
            names.add(libraryName);
            pairs.add(new ValuePair(libraryName, resultSet.getLong("total")));
            return null;
        });

        Statistic statistic = new Statistic();
        statistic.setNames(names);
        statistic.setValuePairs(pairs);
        return statistic;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public boolean checkAuth(List<String> knowledgeIds) {
        if (CollectionUtils.isEmpty(knowledgeIds)) {
            throw new PeException("knowledgeIds must be not empty!");
        }

        List<String> libraryIds = getLibraryIds();
        if(CollectionUtils.isEmpty(libraryIds)){
            return false;
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.in(KnowledgeRel.LIBRARY_ID, libraryIds));
        conjunction.add(Restrictions.in(KnowledgeRel.KNOWLEDGE_ID, knowledgeIds));
        List<KnowledgeRel> knowledgeRelList = listByCriterion(conjunction);
        if (CollectionUtils.isEmpty(knowledgeRelList)) {
            return false;
        }

        Set<String> knowledgeSet = knowledgeRelList.stream().map(KnowledgeRel::getKnowledgeId).collect(Collectors.toSet());
        return knowledgeSet.size() == new HashSet<>(knowledgeIds).size();
    }

    private List<String> getLibraryIds() {
        List<String> libraryIds = new ArrayList<>();
        libraryIds.add(ExecutionContext.getUserId());
        Library myLibrary = libraryService.getUserLibraryByLibraryType(KnowledgeConstant.MY_LIBRARY);
        if (myLibrary != null) {
            libraryIds.add(myLibrary.getId());
        }

        PageParam pageParam = new PageParam();
        pageParam.setAutoCount(false);
        pageParam.setAutoPaging(false);
        Library library = new Library();
        library.setLibraryType(KnowledgeConstant.PUBLIC_LIBRARY);
        Page<Library> libraryPage = libraryService.searchLibrary(pageParam, library);
        List<Library> rows = libraryPage.getRows();
        if (CollectionUtils.isNotEmpty(rows)) {
            libraryIds.addAll(rows.stream().map(Library::getId).collect(Collectors.toList()));
        }

        List<String> parentOrgIds = organizeService.getAllParentOrgIds();
        libraryIds.addAll(parentOrgIds);

        return libraryIds;
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void deleteShare(String relId) {
        if (StringUtils.isEmpty(relId)) {
            throw new PeException("relId must be not empty!");
        }

        KnowledgeRel knowledgeRel = get(relId);
        List<String> knowledgeIds = Collections.singletonList(knowledgeRel.getKnowledgeId());
        delete(relId);
        String libraryId = knowledgeRel.getLibraryId();
        try {
            //分享的文件夹中的文件删除不减积分
            Organize organize = organizeService.get(libraryId);
            if (organize != null) {
                scoreDetailService.addScore(knowledgeIds, KnowledgeConstant.SCORE_RULE_CANCEL_SHARE);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Map<String, List<KnowledgeRel>> getByLibraryIds(Collection<String> libraryIds) {
        if (CollectionUtils.isEmpty(libraryIds)) {
            throw new PeException("libraryIds must be not empty!");
        }

        Criterion criterion = Restrictions.and(Restrictions.eq(KnowledgeRel.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.in(KnowledgeRel.LIBRARY_ID, libraryIds));

        List<KnowledgeRel> knowledgeRels = listByCriterion(criterion);
        if (CollectionUtils.isEmpty(knowledgeRels)) {
            return new HashMap<>(0);
        }

        Map<String, List<KnowledgeRel>> map = new HashMap<>(libraryIds.size());
        for (KnowledgeRel knowledgeRel : knowledgeRels) {
            String libraryId = knowledgeRel.getLibraryId();
            List<KnowledgeRel> knowledgeRelList = map.get(libraryId);
            if (knowledgeRelList == null) {
                knowledgeRelList = new ArrayList<>();
                map.put(libraryId, knowledgeRelList);
            }
            knowledgeRelList.add(knowledgeRel);
        }

        return map;
    }
}
