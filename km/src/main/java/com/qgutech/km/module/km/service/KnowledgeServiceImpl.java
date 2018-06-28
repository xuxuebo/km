package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.module.km.model.*;
import com.qgutech.km.module.sfm.model.PeFile;
import com.qgutech.km.module.sfm.service.FileServerService;
import com.qgutech.km.module.uc.model.Organize;
import com.qgutech.km.module.uc.model.User;
import com.qgutech.km.module.uc.model.UserPosition;
import com.qgutech.km.module.uc.model.UserRole;
import com.qgutech.km.utils.PeDateUtils;
import com.qgutech.km.utils.PeException;
import com.qgutech.km.utils.PropertiesUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;
import java.util.List;


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
                new Order[]{Order.asc(Knowledge.FILE_ID),Order.desc(Knowledge.CREATE_TIME)});
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
        List<String> ids = new ArrayList<>(relList.size());
        for(KnowledgeRel kn : relList){
            ids.add(kn.getKnowledgeId());
        }
        return getKnowledgeByKnowledgeIds(ids);
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
                Restrictions.eq(Knowledge.CREATE_BY,ExecutionContext.getUserId()),
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
        List<Knowledge> list  = getKnowledgeByKnowledgeIds(knowledgeIds);
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
}
