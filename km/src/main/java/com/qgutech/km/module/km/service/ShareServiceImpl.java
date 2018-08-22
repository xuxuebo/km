package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.base.service.SessionService;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.KnowledgeRel;
import com.qgutech.km.module.km.model.Share;
import com.qgutech.km.module.km.model.Statistic;
import com.qgutech.km.module.uc.model.SessionContext;
import com.qgutech.km.utils.PeDateUtils;
import com.qgutech.km.utils.PeException;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by Administrator on 2018/6/22.
 */
@Service("ShareService")
public class ShareServiceImpl extends BaseServiceImpl<Share> implements ShareService {

    @Resource
    private KnowledgeService knowledgeService;
    @Resource
    private StatisticService statisticService;
    @Resource
    private SessionService sessionService;
    @Resource
    private KnowledgeRelService knowledgeRelService;
    @Resource
    private ScoreDetailService scoreDetailService;
    /**
     *1.我的分享--分享文件--分享统计
     *
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public List<Knowledge> getMyShare() {
        Criterion criterion = Restrictions.and(Restrictions.eq(Share.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(Share.CREATE_BY,ExecutionContext.getUserId()));
        List<Share> shareList = listByCriterion(criterion,new Order[]{Order.desc(Share.CREATE_TIME)});
        if(CollectionUtils.isEmpty(shareList)){
            return new ArrayList<>(0);
        }
        List<String> shareIds = new ArrayList<>(shareList.size());
        List<String> knIds = new ArrayList<>(shareList.size());
        Map<String,String> map = new HashMap<>(shareList.size());
        for(Share share : shareList){
            shareIds.add(share.getId());
            knIds.add(share.getKnowledgeId());
            map.put(share.getKnowledgeId(),share.getId());
        }

        List<Knowledge> knowledgeList = knowledgeService.getKnowledgeByKnowledgeIds(knIds);
        List<Statistic> statisticList = statisticService.getByShareIds(shareIds);
        Map<String,Statistic> statisticMap = new HashMap<>(statisticList.size());
        for(Statistic statistic : statisticList){
            statisticMap.put(statistic.getShareId(),statistic);
        }
        Statistic statistic;
        for(Knowledge knowledge : knowledgeList){
            statistic = statisticMap.get(map.get(knowledge.getId()));
            if(statistic!=null){
                knowledge.setViewCount(statistic.getViewCount());
                knowledge.setDownloadCount(statistic.getDownloadCount());
                knowledge.setCopyCount(statistic.getCopyCount());
                knowledge.setShareId(statistic.getShareId());
            }else{
                knowledge.setViewCount(0);
                knowledge.setDownloadCount(0);
                knowledge.setCopyCount(0);
            }
            knowledge.setCreateTimeStr(PeDateUtils.format(knowledge.getCreateTime(),PeDateUtils.FORMAT_YYYY_MM_DD_HH_MM));
            knowledge.setExpireTime("永久有效");

        }
        return knowledgeList;
    }

    /**
     * 取消分享
     * 1.删除分享记录
     * 2.删除分享记录的统计记录
     * 3.删除公共库的分享记录
     */
    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public void cancelShare(String knowledgeId) {
        if(StringUtils.isEmpty(knowledgeId)){
            throw new PeException("id is null ");
        }
        List<String> knowledgeIds = Arrays.asList(knowledgeId.split(","));
        List<Share> shareList = listByCriterion(Restrictions.and(Restrictions.in(Share.KNOWLEDGE_ID,knowledgeIds)));
        if(CollectionUtils.isEmpty(shareList)){
            return;
        }
        List<String> shareIds = new ArrayList<>(shareList.size());
        List<String> libraryIds = new ArrayList<>(shareList.size());
        for(Share share : shareList){
            shareIds.add(share.getId());
            libraryIds.add(share.getShareLibraryId());
        }
        delete(shareIds);
        statisticService.delete(Restrictions.and(Restrictions.in(Statistic.SHARE_ID,shareIds),
                Restrictions.eq(Statistic.CORP_CODE,ExecutionContext.getCorpCode()),
                Restrictions.eq(Statistic.CREATE_BY,ExecutionContext.getUserId())));
        knowledgeRelService.delete(Restrictions.and(Restrictions.in(KnowledgeRel.LIBRARY_ID,libraryIds),
                Restrictions.in(KnowledgeRel.KNOWLEDGE_ID,knowledgeIds)));
        scoreDetailService.addScore(knowledgeIds, KnowledgeConstant.SCORE_RULE_CANCEL_SHARE);
    }

    @Override
    public List<Share> getByKnowledgeIds(List<String> knowledgeIds) {
        return null;
    }


    @Override
    public int updateDownCount(String shareIds) {
        if(StringUtils.isEmpty(shareIds)){
            return 0;
        }
        List<String> shareList = Arrays.asList(shareIds.split(","));
        List<Statistic> statisticList = statisticService.getByShareIds(shareList);
        if(CollectionUtils.isEmpty(statisticList)){
            return 0;
        }
        for(Statistic s : statisticList){
            int c = s.getDownloadCount()==null?0:s.getDownloadCount();
            s.setDownloadCount(c+1);
        }
        statisticService.batchSaveOrUpdate(statisticList);
        return statisticList.size();
    }

    @Override
    public int updateCopyCount(String shareIds) {
        if(StringUtils.isEmpty(shareIds)){
            return 0;
        }
        List<String> shareList = Arrays.asList(shareIds.split(","));
        List<Statistic> statisticList = statisticService.getByShareIds(shareList);
        if(CollectionUtils.isEmpty(statisticList)){
            return 0;
        }
        for(Statistic s : statisticList){
            int c = s.getCopyCount()==null?0:s.getCopyCount();
            s.setCopyCount(c+1);
        }
        statisticService.batchSaveOrUpdate(statisticList);
        return statisticList.size();
    }

    public ShareServiceImpl() {
        super();
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Map<String, String> getSharedKnowledgeIdAndShareIdMap(List<String> knowledgeIds) {
        Conjunction conjunction = Restrictions.and(Restrictions.eq(Share.CORP_CODE, ExecutionContext.getCorpCode()));
        if (CollectionUtils.isNotEmpty(knowledgeIds)) {
            conjunction.add(Restrictions.in(Share.KNOWLEDGE_ID, knowledgeIds));
        }

        List<Share> shareList = listByCriterion(conjunction, Share.KNOWLEDGE_ID, Share.ID);
        if (CollectionUtils.isEmpty(shareList)) {
            return new HashMap<>(0);
        }

        Map<String, String> knowledgeIdAndShareIdMap = new HashMap<>(shareList.size());
        for (Share share : shareList) {
            knowledgeIdAndShareIdMap.put(share.getKnowledgeId(), share.getId());
        }

        return knowledgeIdAndShareIdMap;
    }
}
