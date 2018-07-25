package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.*;
import com.qgutech.km.utils.PeException;
import com.qgutech.km.utils.PeUtils;
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


@Service("knowledgeService")
public class KnowledgeServiceImpl extends BaseServiceImpl<Knowledge> implements KnowledgeService {

    @Resource
    private LibraryService libraryService;
    @Resource
    private KnowledgeRelService knowledgeRelService;
    @Resource
    private ShareService shareService;

    @Resource
    private StatisticService statisticService;

    /**
     * 获取个人云库文件列表
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public List<Knowledge> getKnowledgeByCreateBy(String libraryType,String libraryId) {
        List<Knowledge> knowledgeList = new ArrayList<>();

        //添加id in
        List<String> knowledgeIds = new ArrayList<>();
        //查询我的个人库的id
        Library library = libraryService.getUserLibraryByLibraryType(libraryType);
        if(library==null){
            return new ArrayList<>(0);
        }
        //查询云库里面所有文件id
        List<KnowledgeRel> knowledgeRelList;
        if(StringUtils.isEmpty(libraryId)){
            knowledgeRelList = knowledgeRelService.findByLibraryId(library.getId());
        }else{
            knowledgeRelList = knowledgeRelService.findByLibraryId(libraryId);
        }

        if(CollectionUtils.isEmpty(knowledgeRelList)){
            return new ArrayList<>(0);
        }
        //取我的云库里面所有文件id
        Map<String,Date> dateMap = new HashMap<>();
        for(KnowledgeRel k : knowledgeRelList){
            knowledgeIds.add(k.getKnowledgeId());
            dateMap.put(k.getKnowledgeId(),k.getUpdateTime());
        }
        Criterion criterion = Restrictions.and(
                Restrictions.eq(Knowledge.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.in(Knowledge.ID,knowledgeIds)
                );
        knowledgeList = listByCriterion((criterion),
                new Order[]{Order.asc(Knowledge.FOLDER),Order.desc(Knowledge.CREATE_TIME)});
        if(KnowledgeConstant.RECYCLE_LIBRARY.equals(libraryType)){
            for(Knowledge k : knowledgeList){
                k.setCreateTime(dateMap.get(k.getId()));
            }
        }
        return knowledgeList;
    }

    @Override
    @Transactional(readOnly = false)
    public int shareToPublic(Share share) {
        if(null==share || StringUtils.isEmpty(share.getKnowledgeId())||StringUtils.isEmpty(share.getShareLibraryId())){
            return 0;
        }
        String knowledgeIds = share.getKnowledgeId();
        List<String> knowledgeIdList= Arrays.asList(knowledgeIds.split(",")) ;
        List<KnowledgeRel> knowledgeRelList = new ArrayList<>(knowledgeIdList.size());
        List<Share> shareList = new ArrayList<>(knowledgeIdList.size());
        List<Statistic> statisticList = new ArrayList<>(knowledgeIdList.size());
        KnowledgeRel knowledgeRel;
        Statistic statistic;
        for(String knowledgeId : knowledgeIdList){
            //保存公共库
            knowledgeRel = new KnowledgeRel();
            knowledgeRel.setKnowledgeId(share.getKnowledgeId());
            knowledgeRel.setLibraryId(share.getShareLibraryId());
            knowledgeRel.setShareId("");
            knowledgeRelList.add(knowledgeRel);

            //保存分享记录
            share.setShareType(KnowledgeConstant.SHARE_NO_PASSWORD);
            share.setExpireTime(KnowledgeConstant.SHARE_PERMANENT_VALIDITY);
            share.setKnowledgeId(knowledgeId);
            share.setPassword("");
            shareList.add(share);
        }

        knowledgeRelService.batchSave(knowledgeRelList);
        List<String> shareIds = shareService.batchSave(shareList);
        Map<String,String> shareIdAndKnowledgeIdMap = new HashMap<>();
        for(Share s : shareList){
            shareIdAndKnowledgeIdMap.put(s.getKnowledgeId(),s.getId());
        }
        for(KnowledgeRel k : knowledgeRelList){
            k.setShareId(shareIdAndKnowledgeIdMap.get(k.getKnowledgeId()));
        }
        knowledgeRelService.batchSaveOrUpdate(knowledgeRelList);
        for(String shareId : shareIds){
            statistic = new Statistic(shareId,0,0,0);
            statisticList.add(statistic);
        }
        //保存共享统计记录
        statisticService.batchSave(statisticList);
        return 1;
    }


    @Override
    @Transactional(readOnly = true)
    public List<Knowledge> getKnowledgeByKnowledgeIds(List<String> knowledgeIdList) {
        Criterion criterion = Restrictions.and(Restrictions.in(Knowledge.ID,knowledgeIdList),
                Restrictions.eq(Knowledge.CREATE_BY,ExecutionContext.getUserId()),
                Restrictions.eq(Knowledge.CORP_CODE,ExecutionContext.getCorpCode()));
        return listByCriterion(criterion,new Order[]{Order.desc(Knowledge.CREATE_TIME)});
    }

    @Override
    public List<Knowledge> getKnowledgeByIds(List<String> knowledgeIdList) {
        Criterion criterion = Restrictions.and(Restrictions.in(Knowledge.ID,knowledgeIdList),
                Restrictions.eq(Knowledge.CORP_CODE,ExecutionContext.getCorpCode()));
        return listByCriterion(criterion,new Order[]{Order.desc(Knowledge.CREATE_TIME)});
    }

    @Override
    @Transactional(readOnly = true)
    public List<Knowledge> getByLibraryId(String libraryId) {
        List<KnowledgeRel> relList = new ArrayList<>();
        Criterion criterion = Restrictions.and(Restrictions.eq(KnowledgeRel.CORP_CODE,ExecutionContext.getCorpCode()),
                Restrictions.eq(KnowledgeRel.LIBRARY_ID,libraryId));
        relList = knowledgeRelService.listByCriterion(criterion,new Order[]{Order.desc(KnowledgeRel.CREATE_TIME)});
        if(CollectionUtils.isEmpty(relList)){
            return new ArrayList<>();
        }
        Map<String,String> map = new HashMap<>();
        for(KnowledgeRel k : relList){
            map.put(k.getKnowledgeId(),k.getShareId());
        }
        List<String> ids = new ArrayList<>(relList.size());
        for(KnowledgeRel kn : relList){
            ids.add(kn.getKnowledgeId());
        }
        List<Knowledge> knowledgeList = getKnowledgeByIds(ids);
        for(Knowledge k : knowledgeList){
            k.setShareId(map.get(k.getId()));
        }
        return knowledgeList;
    }


    @Override
    @Transactional(readOnly = false)
    public int reductionOrDelete(List<String> knowledgeIdList, String libraryType) {
        if (CollectionUtils.isEmpty(knowledgeIdList)){
            return 0;
        }
        Library myLibrary = libraryService.getUserLibraryByLibraryType(KnowledgeConstant.MY_LIBRARY);
        Library recycleLibrary = libraryService.getUserLibraryByLibraryType(KnowledgeConstant.RECYCLE_LIBRARY);
        //删除操作 将文件至回收站
        List<KnowledgeRel> list = new ArrayList<>();
        if(KnowledgeConstant.MY_LIBRARY.equals(libraryType)){
            list = knowledgeRelService.findByLibraryIdAndKnowledgeIds(myLibrary.getId(),knowledgeIdList);
            for(KnowledgeRel kn : list){
                kn.setLibraryId(recycleLibrary.getId());
            }
            knowledgeRelService.update(list,KnowledgeRel.LIBRARY_ID);
        }else if(KnowledgeConstant.RECYCLE_LIBRARY.equals(libraryType)){//还原操作 将文件至个人云库
            list = knowledgeRelService.findByLibraryIdAndKnowledgeIds(recycleLibrary.getId(),knowledgeIdList);
            for(KnowledgeRel kn : list){
                kn.setLibraryId(myLibrary.getId());
            }
            knowledgeRelService.update(list,KnowledgeRel.LIBRARY_ID);
        }
        return list.size();
    }


    @Override
    @Transactional(readOnly = false)
    public void emptyTrash() {
        Library library = libraryService.getUserLibraryByLibraryType(KnowledgeConstant.RECYCLE_LIBRARY);
        Criterion criterion = Restrictions.and(Restrictions.eq(KnowledgeRel.LIBRARY_ID,library.getId()));
        knowledgeRelService.delete(criterion);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<Knowledge> publicLibraryData(PageParam pageParam, Knowledge knowledge, String libraryId) {
        if(StringUtils.isEmpty(libraryId)){
            return new Page<Knowledge>();
        }
        List<KnowledgeRel> knowledgeRelList = knowledgeRelService.findByLibraryId(libraryId);
        if(CollectionUtils.isEmpty(knowledgeRelList)){
            return new Page<>();
        }
        List<String> knIds = new ArrayList<>(knowledgeRelList.size());
        for(KnowledgeRel kn : knowledgeRelList){
            knIds.add(kn.getKnowledgeId());
        }
        Criterion criterion = Restrictions.and(Restrictions.in(Knowledge.ID,knIds),
                Restrictions.eq(Knowledge.CORP_CODE,ExecutionContext.getCorpCode()));
        return search(pageParam,criterion,new Order[]{Order.asc(Knowledge.FILE_ID),Order.desc(Knowledge.CREATE_TIME)});
    }

    /**
     * 复制到我的个人云库
     * @param knowledgeIds
     */
    @Override
    @Transactional(readOnly = false)
    public void copyToMyLibrary(String knowledgeIds) {
        if(StringUtils.isEmpty(knowledgeIds)){
            throw  new PeException("knowledgeIds is null ");
        }
        Library myLibrary = libraryService.getUserLibraryByLibraryType(KnowledgeConstant.MY_LIBRARY);
        List<String> knowledgeIdList = Arrays.asList(knowledgeIds.split(","));
        List<KnowledgeRel> knowledgeRelList = new ArrayList<>(knowledgeIdList.size());
        KnowledgeRel knowledgeRel;
        for(String knId : knowledgeIdList){
            knowledgeRel = new KnowledgeRel();
            knowledgeRel.setKnowledgeId(knId);
            knowledgeRel.setShareId("");
            knowledgeRel.setLibraryId(myLibrary.getId());
            knowledgeRelList.add(knowledgeRel);
        }
        knowledgeRelService.batchSave(knowledgeRelList);
    }

    /**
     *
     * @param knowledgeIds
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public List<Knowledge> recursionList(List<String> knowledgeIds) {
        List<Knowledge> list  = getKnowledgeByIds(knowledgeIds);
        List<Knowledge> all = new ArrayList<>();
        all = getAllKnowledge(all,list);
        return all;
    }

    private List<Knowledge> getAllKnowledge(List<Knowledge> all,List<Knowledge> targetList){
        for(Knowledge knowledge : targetList){
            if(!StringUtils.isEmpty(knowledge.getFileId())){
                all.add(knowledge);
            }else{//文件夹
                if(!StringUtils.isEmpty(knowledge.getFolder())){
                    List<Knowledge> dd = getByLibraryId(knowledge.getFolder());
                    getAllKnowledge(all,dd);
                }

            }
        }
        return all;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Page<Knowledge> search(Knowledge knowledge, PageParam pageParam) {
        PeUtils.validPage(pageParam);
        if (knowledge == null || StringUtils.isEmpty(knowledge.getLibraryId())) {
            throw new PeException("knowledge and LibraryId must be empty!");
        }

        List<KnowledgeRel> relList = knowledgeRelService.findKnowledgeRel(knowledge);
        if (CollectionUtils.isEmpty(relList)) {
            return new Page<>();
        }

        List<String> knowledgeIds = new ArrayList<>(relList.stream().map(KnowledgeRel::getKnowledgeId).collect(Collectors.toList()));
        Conjunction conjunction = Restrictions.and(Restrictions.in(Knowledge.ID, knowledgeIds));
        conjunction.add(Restrictions.eq(Knowledge.CORP_CODE, ExecutionContext.getCorpCode()));
        String knowledgeName = knowledge.getKnowledgeName();
        if (StringUtils.isNotEmpty(knowledgeName)) {
            conjunction.add(Restrictions.ilike(Knowledge.KNOWLEDGE_NAME, ExecutionContext.getUserId()));
        }

        return search(pageParam, conjunction, Order.desc(Knowledge.CREATE_TIME));
    }
}
