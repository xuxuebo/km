package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.base.service.SessionService;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.Share;
import com.qgutech.km.module.km.model.Statistic;
import com.qgutech.km.module.uc.model.SessionContext;
import com.qgutech.km.utils.PeDateUtils;
import com.qgutech.km.utils.PeException;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.hibernate.SessionFactory;
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
     * @param id
     */
    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public void cancelShare(String id) {
        if(StringUtils.isEmpty(id)){
            throw new PeException("id is null ");
        }
        List<String> shareIds = Arrays.asList(id.split(","));
        List<Share> shareList = listByCriterion(Restrictions.and(Restrictions.in(Share.ID,shareIds)));
        if(CollectionUtils.isEmpty(shareIds)){
            throw new PeException("shareList is null ");
        }
        delete(shareIds);
        statisticService.delete(Restrictions.and(Restrictions.in(Statistic.SHARE_ID,shareIds),
                Restrictions.eq(Statistic.CORP_CODE,ExecutionContext.getCorpCode()),
                Restrictions.eq(Statistic.CREATE_BY,ExecutionContext.getUserId())));
    }
}
