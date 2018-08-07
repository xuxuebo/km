package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.*;
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

    @Override
    @Transactional(readOnly = true)
    public List<KnowledgeRel> findByLibraryId(String libraryId) {
        if(StringUtils.isEmpty(libraryId)){
            throw  new PeException("libraryId not be null ");
        }
        Criterion criterion = Restrictions.and(Restrictions.eq(KnowledgeRel.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(KnowledgeRel.LIBRARY_ID,libraryId));

        List<KnowledgeRel> knowledgeRels = new ArrayList<>();
        knowledgeRels = listByCriterion(   criterion ,
                new Order[]{Order.desc(Library.CREATE_TIME)}
        );
        return knowledgeRels;
    }

    @Override
    @Transactional(readOnly = true)
    public List<KnowledgeRel> findByLibraryIdAndKnowledgeIds(String libraryId, List<String> knowledgeIds) {
        if(StringUtils.isEmpty(libraryId)){
            throw  new PeException("libraryId not be null ");
        }
        Criterion criterion = Restrictions.and(Restrictions.eq(KnowledgeRel.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(KnowledgeRel.LIBRARY_ID,libraryId),
                Restrictions.in(KnowledgeRel.KNOWLEDGE_ID,knowledgeIds));

        List<KnowledgeRel> knowledgeRels = new ArrayList<>();
        knowledgeRels = listByCriterion(   criterion ,
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
}
