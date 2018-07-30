package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.*;
import com.qgutech.km.module.uc.service.OrganizeService;
import com.qgutech.km.module.uc.service.UserService;
import com.qgutech.km.utils.PeException;
import com.qgutech.km.utils.PeUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
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
    @Resource
    private OrganizeService organizeService;
    @Resource
    private UserService userService;
    @Resource
    private LabelRelService labelRelService;

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

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Page<Knowledge> searchOrgShare(Knowledge knowledge, PageParam pageParam) {
        PeUtils.validPage(pageParam);
        if (knowledge == null) {
            throw new PeException("knowledge invalid!");
        }

        Page<Knowledge> page = new Page<>();
        String referType = knowledge.getReferType();
        List<String> userIds = getUserIds(knowledge, referType);
        if (userIds != null && userIds.size() == 0) {
            return page;
        }

        List<String> orgIds = organizeService.getAllParentOrgIds();
        if (CollectionUtils.isEmpty(orgIds)) {
            return page;
        }

        List<String> knowledgeIds = null;
        if (hasSearchCondition(knowledge)) {
            knowledgeIds = getKnowledgeIds(knowledge, userIds);
            if (CollectionUtils.isEmpty(knowledgeIds)) {
                return page;
            }
        }

        Map<String, Object> params = new HashMap<>(6);
        StringBuilder sql = getConditionSql(userIds, orgIds, knowledgeIds, params);
        NamedParameterJdbcTemplate jdbcTemplate = getJdbcTemplate();
        if (pageParam.isAutoCount()) {
            Long total = jdbcTemplate.queryForObject("SELECT count(*)" + sql, params, Long.class);
            if (total == null || total == 0) {
                return page;
            }

            page.setTotal(total);
        }

        if (pageParam.isAutoPaging()) {
            sql.append("limit :searchCount offset :start");
            params.put("searchCount", pageParam.getPageSize());
            params.put("start", pageParam.getStart());
        }

        List<Knowledge> knowledgeList = jdbcTemplate.queryForList("SELECT k.*" + sql, params, Knowledge.class);
        if (CollectionUtils.isEmpty(knowledgeIds)) {
            return page;
        }

        page.setRows(knowledgeList);
        return page;
    }

    private StringBuilder getConditionSql(List<String> userIds, List<String> orgIds, List<String> knowledgeIds, Map<String, Object> params) {
        StringBuilder sql = new StringBuilder(" FROM t_km_knowledge k");
        sql.append(" INNER JOIN t_km_knowledge_rel kr1 ON k.id=kr.knowledge_id AND kr.libraryId IN (:libraryIds)");
        params.put("libraryIds", orgIds);
        sql.append(" WHERE k.corp_code = :corpCode");
        params.put("corpCode", ExecutionContext.getCorpCode());
        if (CollectionUtils.isNotEmpty(userIds)) {
            sql.append(" AND kr.create_by in (:createBy)");
            params.put("createBy", userIds);
        }

        if (CollectionUtils.isNotEmpty(knowledgeIds)) {
            sql.append(" AND kr.knowledge_id in (:knowledgeIds)");
            params.put("knowledgeIds", knowledgeIds);
        }
        return sql;
    }

    private boolean hasSearchCondition(Knowledge knowledge) {
        return StringUtils.isNotEmpty(knowledge.getProjectLibraryId())
                || StringUtils.isNotEmpty(knowledge.getSpecialtyLibraryId())
                || StringUtils.isNotEmpty(knowledge.getTag())
                || StringUtils.isNotEmpty(knowledge.getKnowledgeName());
    }

    private List<String> getKnowledgeIds(Knowledge knowledge, List<String> userIds) {
        Map<String, Object> params = new HashMap<>(8);
        StringBuilder sql = new StringBuilder("SELECT k.knowledge_id FROM t_km_knowledge k");
        String tag = knowledge.getTag();
        if (StringUtils.isNotEmpty(tag)) {
            sql.append(" INNER JOIN t_km_label_rel lr ON k.id=lr.knowledge_id AND lr.label_id= :labelId");
            params.put("labelId", tag);
            if (CollectionUtils.isNotEmpty(userIds)) {
                sql.append(" AND lr.create_by in (:labelBy)");
                params.put("labelBy", userIds);
            }
        }

        String projectLibraryId = knowledge.getProjectLibraryId();
        if (StringUtils.isNotEmpty(projectLibraryId)) {
            sql.append(" INNER JOIN t_km_knowledge_rel kr1 ON k.id=kr1.knowledge_id AND kr1.libraryId=:projectLibraryId");
            params.put("projectLibraryId", projectLibraryId);
            if (CollectionUtils.isNotEmpty(userIds)) {
                sql.append(" AND kr1.create_by in (:projectBy)");
                params.put("projectBy", userIds);
            }
        }

        String specialtyLibraryId = knowledge.getSpecialtyLibraryId();
        if (StringUtils.isNotEmpty(specialtyLibraryId)) {
            sql.append(" INNER JOIN t_km_knowledge_rel kr2 ON k.id=kr2.knowledge_id AND kr2.libraryId=:specialtyLibraryId");
            params.put("specialtyLibraryId", specialtyLibraryId);
            if (CollectionUtils.isNotEmpty(userIds)) {
                sql.append(" AND kr2.create_by in (:specialtyBy)");
                params.put("specialtyBy", userIds);
            }
        }

        sql.append(" where k.corp_code = :corpCode");
        params.put("corpCode", ExecutionContext.getCorpCode());
        String knowledgeName = knowledge.getKnowledgeName();
        if (StringUtils.isNotEmpty(knowledgeName)) {
            sql.append(" AND k.knowledge_name ilike :name");
            params.put("name", "%" + knowledgeName + "%");
        }

        return getJdbcTemplate().queryForList(sql.toString(), params, String.class);
    }

    private NamedParameterJdbcTemplate getJdbcTemplate() {
        return new NamedParameterJdbcTemplate(baseService.getJdbcTemplate());
    }

    private List<String> getUserIds(Knowledge knowledge, String referType) {
        List<String> userIds = null;
        if (KnowledgeConstant.TYPE_USER.equals(referType)) {
            userIds = new ArrayList<>(1);
            userIds.add(knowledge.getReferId());
        } else if (KnowledgeConstant.TYPE_ORG.equals(referType)) {
            userIds = userService.getUserIdsByOrgId(knowledge.getReferId(), knowledge.isIncludeChild());
        }
        return userIds;
    }

    private List<String> getSearchLibraryIds(Knowledge knowledge) {
        String projectLibraryId = knowledge.getProjectLibraryId();
        String specialtyLibraryId = knowledge.getSpecialtyLibraryId();
        List<String> libraryIds = new ArrayList<>(2);
        if (StringUtils.isNotEmpty(projectLibraryId)) {
            libraryIds.add(projectLibraryId);
        }

        if (StringUtils.isNotEmpty(specialtyLibraryId)) {
            libraryIds.add(specialtyLibraryId);
        }

        return libraryIds;
    }

}
