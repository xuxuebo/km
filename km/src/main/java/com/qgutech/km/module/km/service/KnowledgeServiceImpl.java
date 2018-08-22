package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.BaseModel;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.base.vo.Rank;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.*;
import com.qgutech.km.module.uc.model.Organize;
import com.qgutech.km.module.uc.model.User;
import com.qgutech.km.module.uc.service.OrganizeService;
import com.qgutech.km.module.uc.service.UserService;
import com.qgutech.km.utils.PeDateUtils;
import com.qgutech.km.utils.PeException;
import com.qgutech.km.utils.PeUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
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
    private KnowledgeLogService knowledgeLogService;
    @Resource
    private KmFullTextSearchService kmFullTextSearchService;
    @Resource
    private ScoreDetailService scoreDetailService;

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
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public int shareToPublic(Share share) {
        if(null==share || StringUtils.isEmpty(share.getKnowledgeId())||StringUtils.isEmpty(share.getShareLibraryId())){
            return 0;
        }
        String knowledgeIds = share.getKnowledgeId();
        List<String> knowledgeIdList= Arrays.asList(knowledgeIds.split(",")) ;
        List<KnowledgeRel> knowledgeRelList = new ArrayList<>(knowledgeIdList.size());
        List<KnowledgeLog> knowledgeLogList = new ArrayList<>(knowledgeIdList.size());
        List<Share> shareList = new ArrayList<>(knowledgeIdList.size());
        List<Statistic> statisticList = new ArrayList<>(knowledgeIdList.size());
        KnowledgeRel knowledgeRel;
        Statistic statistic;
        String shareLibraryId = share.getShareLibraryId();
        List<String> newShareKnowledgeIds = new ArrayList<>(knowledgeIdList.size());
        Map<String, Boolean> existMap = knowledgeRelService.getLibraryIdKnowledgeIdMap(Collections.singletonList(shareLibraryId), knowledgeIdList);
        for(String knowledgeId : knowledgeIdList){
            //保存公共库
            knowledgeRel = new KnowledgeRel();
            knowledgeRel.setKnowledgeId(knowledgeId);
            knowledgeRel.setLibraryId(shareLibraryId);
            knowledgeRel.setShareId("");
            knowledgeRelList.add(knowledgeRel);
            knowledgeLogList.add(new KnowledgeLog(knowledgeId, shareLibraryId, KnowledgeConstant.LOG_SHARE));

            //保存分享记录
            share.setShareType(KnowledgeConstant.SHARE_NO_PASSWORD);
            share.setExpireTime(KnowledgeConstant.SHARE_PERMANENT_VALIDITY);
            share.setKnowledgeId(knowledgeId);
            share.setPassword("");
            shareList.add(share);
            String key = shareLibraryId + "&" + knowledgeId;
            if (BooleanUtils.isNotTrue(existMap.get(key))) {
                newShareKnowledgeIds.add(knowledgeId);
            }
        }

        knowledgeRelService.batchSave(knowledgeRelList);
        knowledgeLogService.batchSave(knowledgeLogList);
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
        if (newShareKnowledgeIds.size() > 0) {
            scoreDetailService.addScore(newShareKnowledgeIds, KnowledgeConstant.SCORE_RULE_SHARE);
        }
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
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public int reductionOrDelete(List<String> knowledgeIdList, String libraryType) {
        if (CollectionUtils.isEmpty(knowledgeIdList)){
            return 0;
        }
        Library myLibrary = libraryService.getUserLibraryByLibraryType(KnowledgeConstant.MY_LIBRARY);
        Library recycleLibrary = libraryService.getUserLibraryByLibraryType(KnowledgeConstant.RECYCLE_LIBRARY);
        //删除操作 将文件至回收站
        List<KnowledgeRel> list;
        String ruleCode, libraryId;
        if (KnowledgeConstant.MY_LIBRARY.equals(libraryType)) {
            list = knowledgeRelService.findByLibraryIdAndKnowledgeIds(myLibrary.getId(), knowledgeIdList);
            ruleCode = KnowledgeConstant.SCORE_RULE_DELETE;
            libraryId = recycleLibrary.getId();
        } else if (KnowledgeConstant.RECYCLE_LIBRARY.equals(libraryType)) {
            //还原操作 将文件至个人云库
            list = knowledgeRelService.findByLibraryIdAndKnowledgeIds(recycleLibrary.getId(), knowledgeIdList);
            ruleCode = KnowledgeConstant.SCORE_RULE_RECYCLE;
            libraryId = myLibrary.getId();
        } else {
            return 0;
        }

        List<String> knowledgeIds = new ArrayList<>(list.size());
        for (KnowledgeRel kn : list) {
            kn.setLibraryId(libraryId);
            knowledgeIds.add(kn.getKnowledgeId());
        }

        knowledgeRelService.update(list, KnowledgeRel.LIBRARY_ID);
        if (CollectionUtils.isNotEmpty(knowledgeIds)) {
            scoreDetailService.addScore(knowledgeIds, ruleCode);
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
     *
     * @param knowledgeIds
     */
    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void copyToMyLibrary(String knowledgeIds) {
        if (StringUtils.isEmpty(knowledgeIds)) {
            throw new PeException("knowledgeIds is null ");
        }

        Library myLibrary = libraryService.getUserLibraryByLibraryType(KnowledgeConstant.MY_LIBRARY);
        List<String> knowledgeIdList = Arrays.asList(knowledgeIds.split(","));
        List<KnowledgeRel> knowledgeRelList = new ArrayList<>(knowledgeIdList.size());
        List<KnowledgeLog> knowledgeLogs = new ArrayList<>(knowledgeIdList.size());
        String libraryId = myLibrary.getId();
        Map<String, String> knowledgeIdAndShareIdMap = shareService.getSharedKnowledgeIdAndShareIdMap(knowledgeIdList);
        String corpCode = ExecutionContext.getCorpCode();
        List<Share> shareList = new ArrayList<>();
        for (String knId : knowledgeIdList) {
            String shareId = knowledgeIdAndShareIdMap.get(knId);
            KnowledgeRel knowledgeRel = new KnowledgeRel();
            knowledgeRel.setKnowledgeId(knId);
            knowledgeRel.setShareId(shareId);
            knowledgeRel.setLibraryId(libraryId);
            knowledgeRelList.add(knowledgeRel);
            knowledgeLogs.add(new KnowledgeLog(knId, libraryId, KnowledgeConstant.LOG_COPY));
            if(StringUtils.isEmpty(shareId)){
                shareList.add(getInitShare(knowledgeIdAndShareIdMap, corpCode, knId));
            }
        }

        if (shareList.size() > 0) {
            shareService.batchSave(shareList);
            List<Statistic> statistics = new ArrayList<>(shareList.size());
            for (Share saveShared : shareList) {
                String sharedId = saveShared.getId();
                knowledgeIdAndShareIdMap.put(saveShared.getKnowledgeId(), sharedId);
                statistics.add(new Statistic(sharedId, 0, 0, 0));
            }

            statisticService.batchSave(statistics);
            for (KnowledgeRel knowledgeRel : knowledgeRelList) {
                String shareId = knowledgeIdAndShareIdMap.get(knowledgeRel.getKnowledgeId());
                knowledgeRel.setShareId(shareId);
            }
        }

        knowledgeRelService.batchSave(knowledgeRelList);
        knowledgeLogService.batchSave(knowledgeLogs);
        StringBuilder shareIds = new StringBuilder();
        knowledgeIdAndShareIdMap.values().forEach(shareId -> {
            shareIds.append(shareId).append(",");
        });
        shareService.updateCopyCount(shareIds.toString());
    }

    private Share getInitShare(Map<String, String> knowledgeIdAndShareIdMap, String corpCode, String knId) {
        Share shareKnowledge = new Share();
        shareKnowledge.setShareType(KnowledgeConstant.SHARE_NO_PASSWORD);
        shareKnowledge.setExpireTime(KnowledgeConstant.SHARE_PERMANENT_VALIDITY);
        shareKnowledge.setKnowledgeId(knId);
        shareKnowledge.setPassword("");
        shareKnowledge.setCorpCode(corpCode);
        knowledgeIdAndShareIdMap.put(knId, "NEW_ADD");
        return shareKnowledge;
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


        Page<Knowledge> page = search(pageParam, conjunction, Order.desc(Knowledge.CREATE_TIME));
        List<Knowledge> rows = page.getRows();
        if (CollectionUtils.isNotEmpty(rows)) {
            setCreateNameAndDate(rows);
        }

        return page;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Page<Knowledge> searchOrgShare(Knowledge knowledge, PageParam pageParam) {
        PeUtils.validPage(pageParam);
        if (knowledge == null) {
            throw new PeException("knowledge invalid!");
        }

        Page<Knowledge> page = new Page<>();
        String folder = knowledge.getFolder();
        if (StringUtils.isNotEmpty(folder)) {
            List<String> knowledgeIds = getKnowledgeIds(knowledge, null);
            if (CollectionUtils.isEmpty(knowledgeIds)) {
                return page;
            }

            Map<String, Object> params = new HashMap<>(6);
            StringBuilder sql = getConditionSql(null, Collections.singletonList(folder), knowledgeIds, params);
            queryKnowledgeList(sql, params, pageParam, page);
            List<Knowledge> rows = page.getRows();
            if (CollectionUtils.isEmpty(rows)) {
                return page;
            }

            setOrgName(knowledge.getRelId(), rows);
            return page;
        }

        String referType = knowledge.getReferType();
        List<String> userIds = getUserIds(knowledge, referType);
        if (userIds != null && userIds.size() == 0) {
            return page;
        }

        List<String> orgIds = organizeService.getAllParentOrgIds();
        if (CollectionUtils.isEmpty(orgIds)) {
            return page;
        }

        orgIds.add(ExecutionContext.getUserId());
        List<String> knowledgeIds = null;
        if (hasSearchCondition(knowledge)) {
            knowledgeIds = getKnowledgeIds(knowledge, userIds);
            if (CollectionUtils.isEmpty(knowledgeIds)) {
                return page;
            }
        }

        Map<String, Object> params = new HashMap<>(6);
        StringBuilder sql = getConditionSql(userIds, orgIds, knowledgeIds, params);
        queryKnowledgeList(sql, params, pageParam, page);
        return page;
    }

    private void setOrgName(String relId, List<Knowledge> rows) {
        KnowledgeRel knowledgeRel = knowledgeRelService.get(relId);
        Organize organize = organizeService.get(knowledgeRel.getLibraryId());
        if (organize != null) {
            for (Knowledge row : rows) {
                row.setOrgName(organize.getOrganizeName());
            }
        }
    }

    private void queryKnowledgeList(StringBuilder sql, Map<String, Object> params,
                                    PageParam pageParam, Page<Knowledge> page) {
        NamedParameterJdbcTemplate jdbcTemplate = getJdbcTemplate();
        if (pageParam.isAutoCount()) {
            Long total = jdbcTemplate.queryForObject("SELECT count(*)" + sql, params, Long.class);
            if (total == null || total == 0) {
                return;
            }

            page.setTotal(total);
        }

        sql.append(" order by kr.create_time desc");
        if (pageParam.isAutoPaging()) {
            sql.append(" limit :searchCount offset :start");
            params.put("searchCount", pageParam.getPageSize());
            params.put("start", pageParam.getStart());
        }

        List<Knowledge> knowledgeList = jdbcTemplate.query("SELECT k.*,kr.id relId,o.organize_name,u.user_name " + sql, params, (resultSet, i) -> {
            Knowledge k = new Knowledge();
            k.setId(resultSet.getString("id"));
            k.setKnowledgeName(resultSet.getString("knowledge_name"));
            k.setCreateTime(resultSet.getTimestamp("create_time"));
            k.setCreateBy(resultSet.getString("create_by"));
            k.setKnowledgeSize(resultSet.getLong("knowledge_size"));
            k.setKnowledgeType(resultSet.getString("knowledge_type"));
            k.setRelId(resultSet.getString("relId"));
            k.setFileId(resultSet.getString("file_id"));
            k.setFolder(resultSet.getString("folder"));
            k.setCorpCode(resultSet.getString("corp_code"));
            String orgName = resultSet.getString("organize_name");
            String userName = resultSet.getString("user_name");
            orgName = StringUtils.isEmpty(orgName) ? userName : orgName;
            k.setOrgName(orgName);
            return k;
        });

        if (CollectionUtils.isEmpty(knowledgeList)) {
            return;
        }

        setCreateNameAndDate(knowledgeList);
        page.setRows(knowledgeList);
    }

    private void setCreateNameAndDate(List<Knowledge> knowledgeList) {
        Set<String> userIdSet = knowledgeList.stream().map(Knowledge::getCreateBy).collect(Collectors.toSet());
        Map<String, String> userIdAndNameMap = userService.getUserIdAndNameMap(userIdSet);
        String userId = ExecutionContext.getUserId();
        for (Knowledge k : knowledgeList) {
            String createBy = k.getCreateBy();
            k.setCanDelete(userId.equalsIgnoreCase(createBy));
            k.setUserName(userIdAndNameMap.get(createBy));
            k.setCreateTimeStr(KnowledgeConstant.TIME_FORMAT.format(k.getCreateTime()));
        }
    }

    private StringBuilder getConditionSql(List<String> userIds, List<String> orgIds, List<String> knowledgeIds, Map<String, Object> params) {
        StringBuilder sql = new StringBuilder(" FROM t_km_knowledge k");
        sql.append(" INNER JOIN t_km_knowledge_rel kr ON k.id=kr.knowledge_id AND kr.library_id IN (:libraryIds)");
        params.put("libraryIds", orgIds);
        sql.append(" LEFT JOIN t_uc_organize o ON o.id = kr.library_id");
        sql.append(" LEFT JOIN t_uc_user u ON u.id = kr.library_id");
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
        StringBuilder sql = new StringBuilder("SELECT k.id FROM t_km_knowledge k");
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
            sql.append(" INNER JOIN t_km_knowledge_rel kr1 ON k.id=kr1.knowledge_id AND kr1.library_id=:projectLibraryId");
            params.put("projectLibraryId", projectLibraryId);
            if (CollectionUtils.isNotEmpty(userIds)) {
                sql.append(" AND kr1.create_by in (:projectBy)");
                params.put("projectBy", userIds);
            }
        }

        String specialtyLibraryId = knowledge.getSpecialtyLibraryId();
        if (StringUtils.isNotEmpty(specialtyLibraryId)) {
            sql.append(" INNER JOIN t_km_knowledge_rel kr2 ON k.id=kr2.knowledge_id AND kr2.library_id=:specialtyLibraryId");
            params.put("specialtyLibraryId", specialtyLibraryId);
            if (CollectionUtils.isNotEmpty(userIds)) {
                sql.append(" AND kr2.create_by in (:specialtyBy)");
                params.put("specialtyBy", userIds);
            }
        }

        String folder = knowledge.getFolder();
        if (StringUtils.isNotEmpty(folder)) {
            sql.append(" INNER JOIN t_km_knowledge_rel kr3 ON k.id=kr3.knowledge_id AND kr3.library_id=:folder");
            params.put("folder", folder);
            if (CollectionUtils.isNotEmpty(userIds)) {
                sql.append(" AND kr3.create_by in (:specialtyBy)");
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

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void shareToOrg(Share share) {
        if (null == share
                || CollectionUtils.isEmpty(share.getLibraryIds())
                || CollectionUtils.isEmpty(share.getKnowledgeIds())) {
            throw new PeException("share param is invalid!");
        }

        List<String> knowledgeIds = share.getKnowledgeIds();
        Map<String, String> knowledgeIdAndShareIdMap = shareService.getSharedKnowledgeIdAndShareIdMap(knowledgeIds);
        List<String> libraryIds = share.getLibraryIds();
        libraryService.initLibraryByLibraryIdAndType(libraryIds, KnowledgeConstant.ORG_SHARE_LIBRARY);
        Map<String, Boolean> existMap = knowledgeRelService.getLibraryIdKnowledgeIdMap(libraryIds, knowledgeIds);
        int size = knowledgeIds.size();
        String corpCode = ExecutionContext.getCorpCode();
        List<Share> shareList = new ArrayList<>(size);
        int capacity = size * libraryIds.size() - existMap.size();
        List<KnowledgeRel> knowledgeRelList = new ArrayList<>(capacity);
        List<KnowledgeLog> knowledgeLogList = new ArrayList<>(capacity);
        List<String> newShareKnowledgeIds = new ArrayList<>(capacity);
        for (String libraryId : libraryIds) {
            for (String knowledgeId : knowledgeIds) {
                String key = libraryId + "&" + knowledgeId;
                if (BooleanUtils.isTrue(existMap.get(key))) {
                    continue;
                }

                newShareKnowledgeIds.add(knowledgeId);
                String shareId = knowledgeIdAndShareIdMap.get(knowledgeId);
                if (StringUtils.isEmpty(shareId)) {
                    shareList.add(getInitShare(knowledgeIdAndShareIdMap, corpCode, knowledgeId));
                }

                KnowledgeRel knowledgeRel = new KnowledgeRel();
                knowledgeRel.setKnowledgeId(knowledgeId);
                knowledgeRel.setLibraryId(libraryId);
                knowledgeRel.setShareId(shareId);
                knowledgeRel.setCorpCode(corpCode);
                knowledgeRelList.add(knowledgeRel);
                knowledgeLogList.add(new KnowledgeLog(knowledgeId, libraryId, KnowledgeConstant.LOG_SHARE));
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

        if (knowledgeRelList.size() == 0) {
            return;
        }

        knowledgeRelService.batchSave(knowledgeRelList);
        knowledgeLogService.batchSave(knowledgeLogList);
        scoreDetailService.addScore(newShareKnowledgeIds, KnowledgeConstant.SCORE_RULE_SHARE);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<String> getIdsByFileIds(List<String> fileIds) {
        if (CollectionUtils.isEmpty(fileIds)) {
            throw new PeException("fileIds must be not empty!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.in(Knowledge.FILE_ID, fileIds));
        List<Knowledge> knowledgeList = listByCriterion(conjunction);
        if (CollectionUtils.isEmpty(knowledgeList)) {
            return new ArrayList<>(0);
        }

        List<String> knowledgeIds = new ArrayList<>(knowledgeList.size());
        knowledgeIds.addAll(knowledgeList.stream().map(Knowledge::getId).collect(Collectors.toList()));

        return knowledgeIds;
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void deleteInDir(List<String> knowledgeIdList, String libraryId) {
        if (CollectionUtils.isEmpty(knowledgeIdList) || StringUtils.isEmpty(libraryId)) {
            throw new PeException("knowledgeIdList and libraryId must be not empty!");
        }

        List<KnowledgeRel> list = knowledgeRelService.findByLibraryIdAndKnowledgeIds(libraryId, knowledgeIdList);
        if (CollectionUtils.isEmpty(list)) {
            return;
        }

        Library recycleLibrary = libraryService.getUserLibraryByLibraryType(KnowledgeConstant.RECYCLE_LIBRARY);
        //删除操作 将文件至回收站
        List<String> knowledgeIds = new ArrayList<>(list.size());
        for (KnowledgeRel kn : list) {
            kn.setLibraryId(recycleLibrary.getId());
            knowledgeIds.add(kn.getKnowledgeId());
        }
        knowledgeRelService.update(list, KnowledgeRel.LIBRARY_ID);
        if (CollectionUtils.isNotEmpty(knowledgeIds)) {
            scoreDetailService.addScore(knowledgeIds, KnowledgeConstant.SCORE_RULE_DELETE);
        }
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Map<String, String> getKnowledgeTotalAndDayCount() {
        Map<String, String> countMap = new HashMap<>(2);
        Conjunction conjunction = getConjunction();
        Long count = getRowCountByCriterion(conjunction);
        countMap.put("totalCount", (count == null ? 0 : count) + "");
        conjunction.add(Restrictions.gt(BaseModel.CREATE_TIME, PeDateUtils.getFirstDate(new Date())));
        count = getRowCountByCriterion(conjunction);
        countMap.put("dayCount", (count == null ? 0 : count) + "");
        return countMap;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<Rank> rank(String type, int rankCount) {
        if (rankCount <= 0) {
            rankCount = 5;
        }

        Map<String, Object> params = new HashMap<>(3);
        StringBuilder sql = new StringBuilder("SELECT u.user_name,count(k.id) total FROM t_uc_user u ");
        sql.append(" LEFT JOIN t_km_knowledge k on k.create_by=u.id ");
        Date startDate = getStartDate(type);
        if (startDate != null) {
            sql.append(" AND k.create_time >=:start ");
            params.put("start", startDate);
        }

        sql.append(" WHERE u.corp_code=:corpCode AND u.status=:status ");
        params.put("corpCode", ExecutionContext.getCorpCode());
        params.put("status", "ENABLE");
        sql.append(" GROUP BY u.id ORDER BY total DESC,u.id LIMIT :rankCount ");
        params.put("rankCount", rankCount);
        final int[] index = {1};
        List<Rank> rankList = getJdbcTemplate().query(sql.toString(), params, (resultSet, i) -> {
            Rank rank = new Rank(null, (int) resultSet.getLong("total"));
            rank.setUserName(resultSet.getString("user_name"));
            rank.setRank(index[0]++);
            return rank;
        });

        return rankList;
    }

    private Date getStartDate(String type) {
        int day = 0;
        if (KnowledgeConstant.RANK_WEEK.equals(type)) {
            day = -7;
        } else if (KnowledgeConstant.RANK_MONTH.equals(type)) {
            day = -30;
        }

        if (day == 0) {
            return null;
        }

        return PeDateUtils.getFirstDate(DateUtils.addDays(new Date(), day));

    }

    public static void setRankInfo(List<User> users, List<Rank> rankList) {
        Map<String, User> userMap = new HashMap<>(users.size());
        for (User user : users) {
            userMap.put(user.getId(), user);
        }

        int rankIndex = 1, count = 0;
        for (Rank rank : rankList) {
            String userId = rank.getUserId();
            User user = userMap.get(userId);
            rank.setOrgName(user.getOrganizeName());
            rank.setUserName(user.getUserName());
            rank.setFacePath(user.getFacePath());
            int ranks = rank.getCount();
            if (ranks < count) {
                rankIndex++;
                count = ranks;
            } else if (count == 0) {
                count = ranks;
            }

            rank.setRank(rankIndex);
        }
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public int getSameNameCount(String libraryId, String knowledgeName, String knowledgeType) {
        if (StringUtils.isEmpty(libraryId) || StringUtils.isEmpty(knowledgeName) || StringUtils.isEmpty(knowledgeType)) {
            throw new PeException("libraryId and knowledgeName must be not empty!");
        }

        String suffix = "." + knowledgeType;
        Map<String, Object> param = new HashMap<>(4);
        StringBuilder sql = new StringBuilder("SELECT k.knowledge_name FROM t_km_knowledge_rel kr ");
        sql.append(" INNER JOIN t_km_knowledge k on k.id=kr.knowledge_id ");
        sql.append(" WHERE kr.library_id=:libraryId AND kr.corp_code=:corpCode ");
        param.put("libraryId", libraryId);
        param.put("corpCode", ExecutionContext.getCorpCode());
        sql.append(" AND k.knowledge_name LIKE :name AND k.knowledge_type != :type ");
        String replace = knowledgeName.replace(suffix, "");
        param.put("name", replace + "%");
        param.put("type", "file");
        List<String> names = getJdbcTemplate().queryForList(sql.toString(), param, String.class);
        if (CollectionUtils.isEmpty(names)) {
            return 0;
        }

        int sameName = 0;
        for (String name : names) {
            if (knowledgeName.equals(name)) {
                sameName++;
                continue;
            }

            if (!name.endsWith(suffix)) {
                continue;
            }

            name = name.replace(suffix, "").replace(replace, "");
            if (!name.startsWith("(") || !name.endsWith(")")) {
                continue;
            }
            name = name.replace("(", "").replace(")", "");
            try {
                int parseInt = Integer.parseInt(name);
                if (parseInt > 0) {
                    sameName++;
                }
            } catch (NumberFormatException ignored) {
            }
        }

        return sameName;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Page<Knowledge> searchHotKnowledge(Knowledge knowledge, PageParam pageParam) {
        PeUtils.validPage(pageParam);
        if (knowledge == null) {
            throw new PeException("Knowledge condition invalid!");
        }

        Organize root = organizeService.getRoot();
        Map<String, Object> params = new HashMap<>(4);
        StringBuilder sql = new StringBuilder(" FROM t_km_knowledge k ");
        sql.append(" INNER JOIN t_km_knowledge_rel kr on k.id=kr.knowledge_id ");
        sql.append(" LEFT JOIN t_km_knowledge_log kl on k.id=kl.knowledge_id AND type=:type ");
        params.put("type", KnowledgeConstant.LOG_DOWNLOAD);
        sql.append(" WHERE k.corp_code=:corpCode AND kr.library_id =:libraryId");
        params.put("corpCode", ExecutionContext.getCorpCode());
        params.put("libraryId", root.getId());
        sql.append(" GROUP BY k.id ORDER BY count(kl.id) DESC,max(k.create_time) DESC ");

        Page<Knowledge> page = new Page<>();
        NamedParameterJdbcTemplate jdbcTemplate = getJdbcTemplate();
        if (pageParam.isAutoCount()) {
            List<Long> counts = jdbcTemplate.queryForList("SELECT COUNT(*)" + sql, params, Long.class);
            if (CollectionUtils.isEmpty(counts)) {
                return page;
            }

            page.setTotal(counts.size());
        }

        if (pageParam.isAutoPaging()) {
            sql.append(" LIMIT :num OFFSET :start");
            params.put("num", pageParam.getPageSize());
            params.put("start", pageParam.getStart());
        }

        List<Knowledge> knowledges = jdbcTemplate.query("SELECT k.id,k.knowledge_name" + sql, params, (resultSet, i) -> {
            Knowledge k = new Knowledge();
            k.setId(resultSet.getString("id"));
            k.setKnowledgeName(resultSet.getString("knowledge_name"));
            return k;
        });

        page.setRows(knowledges);
        return page;
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public String saveAndRel(Knowledge knowledge) {
        if (knowledge == null) {
            throw new PeException("knowledge must be not null");
        }

        String knowledgeId = save(knowledge);
        String libraryId = knowledge.getLibraryId();
        KnowledgeRel knowledgeRel = new KnowledgeRel();
        knowledgeRel.setKnowledgeId(knowledgeId);
        knowledgeRel.setLibraryId(libraryId);
        knowledgeRel.setShareId("");
        knowledgeRelService.save(knowledgeRel);
        knowledgeLogService.save(new KnowledgeLog(knowledgeId, libraryId, KnowledgeConstant.LOG_UPLOAD));
        IndexKnowledge indexKnowledge = convert(knowledge);
        kmFullTextSearchService.add(indexKnowledge);
        scoreDetailService.addScore(Collections.singletonList(knowledgeId), KnowledgeConstant.SCORE_RULE_UPLOAD);
        return knowledgeId;
    }

    private IndexKnowledge convert(Knowledge knowledge) {
        if (knowledge == null) {
            throw new IllegalArgumentException("Knowledge is null!");
        }

        IndexKnowledge indexKnowledge = new IndexKnowledge();
        indexKnowledge.setKnowledgeId(knowledge.getId());
        indexKnowledge.setCorpCode(knowledge.getCorpCode());
        indexKnowledge.setKnowledgeName(knowledge.getKnowledgeName());
        indexKnowledge.setKnowledgeType(knowledge.getKnowledgeType());
        indexKnowledge.setStoredFileId(knowledge.getFileId());
        indexKnowledge.setTags(knowledge.getTag());
        indexKnowledge.setContent("");
        indexKnowledge.setOptStatus("ENABLE");
        indexKnowledge.setUploaderUserName("");

        return indexKnowledge;
    }
}
