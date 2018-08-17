package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.base.vo.PeTreeNode;
import com.qgutech.km.base.vo.Rank;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.KnowledgeRel;
import com.qgutech.km.module.km.model.Library;
import com.qgutech.km.module.km.model.LibraryDetail;
import com.qgutech.km.module.uc.model.User;
import com.qgutech.km.module.uc.service.UserService;
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

/**
 * Created by Administrator on 2018/6/22.
 */
@Service("libraryService")
public class LibraryServiceImpl extends BaseServiceImpl<Library> implements LibraryService{

    @Resource
    private KnowledgeService knowledgeService;
    @Resource
    private KnowledgeRelService knowledgeRelService;
    @Resource
    private UserService userService;
    @Resource
    private LibraryDetailService libraryDetailService;

    @Override
    @Transactional(readOnly = false)
    public Library getUserLibraryByLibraryType(String libraryType) {

        Criterion criterion = Restrictions.and(Restrictions.eq(Library.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(Library.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(Library.LIBRARY_TYPE,libraryType),
                Restrictions.eq(Library.PARENT_ID,"0"),
                Restrictions.eq(Library.CREATE_BY,ExecutionContext.getUserId()));

        List<Library> libraries = listByCriterion(criterion ,
                new Order[]{Order.asc(Library.CREATE_TIME)}
                );
        if(CollectionUtils.isEmpty(libraries)){
          Library newLibrary = new Library();
          newLibrary.setParentId("0");
          newLibrary.setIdPath("");
          newLibrary.setLibraryType(libraryType);
          newLibrary.setLibraryName(KnowledgeConstant.MY_LIBRARY.equals(libraryType)?"我的云库":"我的回收站");
          newLibrary.setShowOrder(1);
          save(newLibrary);
          newLibrary.setIdPath(newLibrary.getId());
          update(newLibrary);
          return newLibrary;
        }
        return libraries.get(0);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Library> getFirstLevelLibrary() {
        String corpCode = ExecutionContext.getCorpCode();
        Criterion criterion = Restrictions.and(Restrictions.eq(Library.CORP_CODE,corpCode),
                Restrictions.eq(Library.PARENT_ID,"0"),
                Restrictions.eq(Library.LIBRARY_TYPE, KnowledgeConstant.PUBLIC_LIBRARY));

        List<Library> libraryList = listByCriterion(criterion,new Order[]{Order.desc(Library.CREATE_TIME)});
        if(CollectionUtils.isEmpty(libraryList)){
            return new ArrayList<>(0);
        }
        return libraryList;
    }


    @Override
    @Transactional(readOnly = true)
    public List<PeTreeNode> listTree() {
        List<Library> libraries = getFirstLevelLibrary();
        if(CollectionUtils.isEmpty(libraries)){
            return new ArrayList<>();
        }
        List<PeTreeNode> peTreeNodes = new ArrayList<>(libraries.size());
        PeTreeNode peTreeNode;
        for(Library l : libraries){
            peTreeNode = new PeTreeNode();
            peTreeNode.setName(l.getLibraryName());
            peTreeNode.setpId(l.getParentId());
            peTreeNode.setId(l.getId());
            peTreeNode.setParent(true);
            peTreeNode.setCanEdit(false);
            peTreeNodes.add(peTreeNode);
        }
        return peTreeNodes;
    }

    /**
     * 新建文件夹
     * 1.文件夹本身也是文件  同时也是一个个人库
     * 2.rel关系
     *
     * 1.新增文件
     * 2.新增
     * @param libraryName
     * @return
     */
    @Override
    @Transactional(readOnly = false)
    public String addFolder(String libraryName,String libraryId) {
        if(StringUtils.isEmpty(libraryId)){
            Library myLibrary = getUserLibraryByLibraryType(KnowledgeConstant.MY_LIBRARY);
            libraryId = myLibrary.getId();
        }

        boolean repeat = checkFolderNameRepeat(libraryId, libraryName);
        if (repeat) {
            return "ERROR_NAME_REPEAT";
        }

        Library oldLibrary = get(libraryId);
        Library library = new Library();
        library.setLibraryName(libraryName);
        library.setParentId(oldLibrary.getId());
        library.setLibraryType(KnowledgeConstant.MY_LIBRARY);
        library.setIdPath("");
        library.setShowOrder(getMaxShowOrderByParentId(oldLibrary.getId())+1);
        String id = save(library);
        update(id,Library.ID_PATH,oldLibrary.getIdPath()+"."+id);

        Knowledge knowledge = new Knowledge();
        knowledge.setKnowledgeName(libraryName);
        knowledge.setKnowledgeType("file");
        knowledge.setFolder(id);//所属文件夹
        knowledge.setFileId("");
        knowledge.setKnowledgeSize(0);
        knowledge.setSourceKnowledgeId("");
        knowledge.setShowOrder(0);
        String  knowledgeId =knowledgeService.save(knowledge);

        KnowledgeRel k = new KnowledgeRel();
        k.setLibraryId(oldLibrary.getId());
        k.setKnowledgeId(knowledgeId);
        k.setShareId("");
        knowledgeRelService.save(k);


        return id;
    }

    private boolean checkFolderNameRepeat(String libraryId, String folderName) {
        Criterion criterion = Restrictions.and(Restrictions.eq(Library.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(Library.LIBRARY_NAME, folderName),
                Restrictions.eq(Library.LIBRARY_TYPE, KnowledgeConstant.MY_LIBRARY),
                Restrictions.eq(Library.CREATE_BY, ExecutionContext.getUserId()),
                Restrictions.eq(Library.PARENT_ID, libraryId));
        List<Library> libraryList = listByCriterion(criterion);
        if(CollectionUtils.isEmpty(libraryList)){
            return false;
        }

        List<String> libraryIds = new ArrayList<>(libraryList.size());
        libraryIds.addAll(libraryList.stream().map(Library::getId).collect(Collectors.toList()));
        //// TODO: 2018/8/17 检查回收站
        return CollectionUtils.isNotEmpty(libraryList);
    }

    /**
     * 获取一个库下的字库(文件夹)的最大showOrder
     * @param parentId
     * @return
     */
    private Float getMaxShowOrderByParentId(String parentId){
        Criterion criterion = Restrictions.and(Restrictions.eq(Library.PARENT_ID,parentId),
                Restrictions.eq(Library.CORP_CODE,ExecutionContext.getCorpCode()));
        List<Library> libraries = listByCriterion(criterion,new Order[]{Order.desc(Library.SHOW_ORDER)});
        if(CollectionUtils.isEmpty(libraries)){
            return 0f;
        }
        return libraries.get(0).getShowOrder();
    }

    @Override
    @Transactional(readOnly = true)
    public Page<Library> search(PageParam pageParam, Library library) {
        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.and(Restrictions.eq(Library.CORP_CODE,ExecutionContext.getCorpCode()),
                Restrictions.eq(Library.PARENT_ID,"0"),
                Restrictions.eq(Library.LIBRARY_TYPE,KnowledgeConstant.PUBLIC_LIBRARY)));
        Page<Library> page = search(pageParam,conjunction,new Order[]{Order.desc(Library.CREATE_TIME)},Library.ID,Library.LIBRARY_NAME);
        if(CollectionUtils.isEmpty(page.getRows())){
            return new Page<>();
        }
        return page;
    }

    @Override
    @Transactional(readOnly = false)
    public String saveLibrary(Library library) {
        boolean hasName = checkName(library);
        if(hasName){
            return "库名重复";
        }
        library.setLibraryType(KnowledgeConstant.PUBLIC_LIBRARY);
        library.setShowOrder(0);
        library.setParentId("0");
        library.setIdPath("");
        String id = save(library);
        update(id,Library.ID_PATH,id);
        return id;
    }


    @Override
    @Transactional(readOnly = true)
    public boolean checkName(Library library) {
        if(library==null|| StringUtils.isEmpty(library.getLibraryName())){
            throw  new PeException(" checkName error ");
        }
        Criterion criterion = Restrictions.and(Restrictions.eq(Library.CORP_CODE,ExecutionContext.getCorpCode()),
                Restrictions.eq(Library.LIBRARY_NAME,library.getLibraryName()),
                Restrictions.eq(Library.LIBRARY_TYPE,KnowledgeConstant.PUBLIC_LIBRARY),Restrictions.eq(Library.PARENT_ID,"0"));
        Library library1 = getByCriterion(criterion);
        if(StringUtils.isEmpty(library.getId())){
            if(library1!=null){
                return true;
            }else{
                return false;
            }

        }
        Library old = get(library.getId());
        if(old==null){
            throw  new PeException(" checkName error ");
        }
        if(library1!=null&&!library1.getId().equals(old.getId())){
            return true;
        }
        return false;
    }

    @Override
    @Transactional(readOnly = false)
    public String updateLibrary(Library library) {
        boolean hasName = checkName(library);
        if(hasName){
            return "库名重复";
        }
        update(library.getId(),Library.LIBRARY_NAME,library.getLibraryName());
        return library.getId();
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public boolean checkName(String libraryId, String libraryName, String libraryType) {
        if (StringUtils.isEmpty(libraryName) || StringUtils.isEmpty(libraryType)) {
            throw new PeException("libraryName and libraryType must be not empty!");
        }

        Criterion criterion = Restrictions.and(Restrictions.eq(Library.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(Library.LIBRARY_NAME, libraryName),
                Restrictions.eq(Library.LIBRARY_TYPE, libraryType),
                Restrictions.eq(Library.PARENT_ID, "0"));
        Library library = getByCriterion(criterion);
        if (StringUtils.isEmpty(libraryId)) {
            return library != null;
        }

        return library != null && !library.getId().equals(libraryId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String insert(Library library) {
        if (library == null || StringUtils.isEmpty(library.getId())
                || StringUtils.isEmpty(library.getLibraryName())
                || StringUtils.isEmpty(library.getLibraryType())
                || StringUtils.isEmpty(library.getIdPath())) {
            throw new PeException("invalid library entity!");
        }

        batchInsert(Collections.singletonList(library));
        return library.getId();
    }

    private void batchInsert(List<Library> libraries) {
        String insertSql = "INSERT INTO t_km_library (id, corp_code, create_by, create_time, update_by, update_time, " +
                "id_path, parent_id, show_order, library_name, library_type) VALUES (?,?,?,?,?,?,?,?,?,?,?);";
        baseService.getJdbcTemplate().batchUpdate(insertSql, getParams(libraries));
    }

    private List<Object[]> getParams(List<Library> libraries) {
        List<Object[]> params = new ArrayList<>(libraries.size());
        String corpCode = ExecutionContext.getCorpCode();
        String userId = ExecutionContext.getUserId();
        Date date = new Date();
        for (Library library : libraries) {
            Object[] param = new Object[]{library.getId(), corpCode, userId, date, userId, date, library.getIdPath()
                    , library.getParentId(), library.getShowOrder(), library.getLibraryName(), library.getLibraryType()};
            params.add(param);
        }

        return params;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Page<Library> searchLibrary(PageParam page, Library library) {
        PeUtils.validPage(page);
        if (library == null || StringUtils.isEmpty(library.getLibraryType())) {
            throw new PeException("library and libraryType must be not empty!");
        }

        Conjunction conjunction = getConjunction();
        String parentId = library.getParentId();
        if (StringUtils.isEmpty(parentId)) {
            parentId = "0";
        }

        Conjunction criterion = Restrictions.and(Restrictions.eq(Library.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(Library.PARENT_ID, parentId),
                Restrictions.eq(Library.LIBRARY_TYPE, library.getLibraryType()));
        String libraryName = library.getLibraryName();
        if (StringUtils.isNotEmpty(libraryName)) {
            criterion.add(Restrictions.ilike(Library.LIBRARY_NAME, "%" + libraryName + "%"));
        }

        conjunction.add(criterion);
        Page<Library> libraryPage = search(page, conjunction, new Order[]{Order.desc(Library.CREATE_TIME)}, Library.ID, Library.LIBRARY_NAME);
        if (CollectionUtils.isEmpty(libraryPage.getRows())) {
            return new Page<>();
        }

        return libraryPage;
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void initLibraryByLibraryIdAndType(List<String> libraryIds, String libraryType) {
        if (CollectionUtils.isEmpty(libraryIds) || StringUtils.isEmpty(libraryType)) {
            throw new PeException("libraryIds and libraryType must be not empty!");
        }

        String corpCode = ExecutionContext.getCorpCode();
        Conjunction conjunction = Restrictions.and(Restrictions.eq(Library.CORP_CODE, corpCode),
                Restrictions.eq(Library.LIBRARY_TYPE, libraryType),
                Restrictions.in(Library.ID, libraryIds));
        List<Library> libraries = listByCriterion(conjunction, Library.ID);
        if (CollectionUtils.isNotEmpty(libraries)) {
            int librariesSize = libraries.size();
            if (librariesSize == libraryIds.size()) {
                return;
            }

            for (Library library : libraries) {
                libraryIds.remove(library.getId());
            }
        }

        List<Library> libraryList = new ArrayList<>(libraryIds.size());
        for (String libraryId : libraryIds) {
            Library library = new Library();
            library.setId(libraryId);
            library.setIdPath(libraryId);
            library.setParentId("0");
            library.setLibraryType(libraryType);
            library.setShowOrder(0);
            library.setLibraryName(libraryId);
            library.setCorpCode(corpCode);
            libraryList.add(library);
        }

        batchInsert(libraryList);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<Rank> rank(String libraryId) {
        if (StringUtils.isEmpty(libraryId)) {
            throw new PeException("libraryId must be not empty!");
        }

        String sql = "SELECT create_by,count(id) total FROM t_km_knowledge_rel WHERE corp_code=:corpCode " +
                "AND library_id=:libraryId GROUP BY create_by ORDER BY total DESC,create_by LIMIT 5";
        Map<String, Object> params = new HashMap<>(2);
        params.put("corpCode", ExecutionContext.getCorpCode());
        params.put("libraryId", libraryId);
        List<String> userIds = new ArrayList<>();
        List<Rank> rankList = getJdbcTemplate().query(sql, params, (resultSet, i) -> {
            String userId = resultSet.getString("create_by");
            userIds.add(userId);
            return new Rank(userId, (int) resultSet.getLong("total"));
        });

        if (CollectionUtils.isEmpty(rankList)) {
            return new ArrayList<>(0);
        }

        List<User> users = userService.list(userIds);
        KnowledgeServiceImpl.setRankInfo(users, rankList);
        return rankList;
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public String saveLibraryAndDetail(Library library) {
        if (library == null || library.getLibraryDetail() == null) {
            throw new PeException("library entity invalid!");
        }

        String libraryId = insert(library);
        LibraryDetail libraryDetail = library.getLibraryDetail();
        if (libraryDetail != null) {
            libraryDetail.setLibraryId(libraryId);
            libraryDetail.setCorpCode(ExecutionContext.getCorpCode());
            baseService.save(libraryDetail);
        }

        return libraryId;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Library getLibraryAndDetail(String libraryId) {
        if (StringUtils.isEmpty(libraryId)) {
            throw new PeException("libraryId must be not empty!");
        }

        Library library = get(libraryId, Library.ID, Library.LIBRARY_NAME, Library.LIBRARY_TYPE);
        if (library == null) {
            return null;
        }

        LibraryDetail libraryDetail = libraryDetailService.getByLibraryId(libraryId);
        if (libraryDetail == null) {
            return library;
        }

        library.setLibraryDetail(libraryDetail);
        String chargeIds = libraryDetail.getChargeIds();
        if (StringUtils.isNotEmpty(chargeIds)) {
            String[] userIds = chargeIds.split(",");
            Map<String, String> userIdAndNameMap = userService.getUserIdAndNameMap(Arrays.asList(userIds));
            StringBuilder name = new StringBuilder();
            for (String userName : userIdAndNameMap.values()) {
                name.append(userName).append(",");
            }

            String userName = name.toString();
            if (StringUtils.isNotEmpty(userName)) {
                libraryDetail.setChargeName(userName.substring(0, userName.length() - 1));
            }
        }

        String faceId = libraryDetail.getFaceId();
        if (StringUtils.isNotEmpty(faceId)) {
            String facePath = userService.getFacePath(faceId, libraryDetail.getFaceName());
            libraryDetail.setFacePath(facePath);
        }

        return library;
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void updateAndDetail(Library library) {
        if (library == null || library.getLibraryDetail() == null) {
            throw new PeException("library invalid!");
        }

        update(library.getId(), Library.LIBRARY_NAME, library.getLibraryName());
        LibraryDetail libraryDetail = library.getLibraryDetail();
        libraryDetail.setCorpCode(ExecutionContext.getCorpCode());
        libraryDetailService.update(libraryDetail);
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public String getIdByNameAndType(String folderName, String type) {
        if (StringUtils.isEmpty(folderName) || StringUtils.isEmpty(type)) {
            throw new PeException("type and folderName must be not empty!");
        }

        Library myLibrary = getUserLibraryByLibraryType(KnowledgeConstant.MY_LIBRARY);
        Criterion criterion = Restrictions.and(Restrictions.eq(Library.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(Library.LIBRARY_TYPE, type),
                Restrictions.eq(Library.LIBRARY_NAME, folderName),
                Restrictions.eq(Library.PARENT_ID, myLibrary.getId()),
                Restrictions.eq(Library.CREATE_BY, ExecutionContext.getUserId()));

        Library library = getByCriterion(criterion);
        if (library == null) {
            return null;
        }

        return library.getId();
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<Library> getHotLibraryByType(String libraryType, int hotCount) {
        if (StringUtils.isEmpty(libraryType)) {
            throw new PeException("libraryType must be not empty!");
        }

        Map<String, Object> param = new HashMap<>(3);
        StringBuilder sql = new StringBuilder("SELECT l.id,l.library_name FROM t_km_library l ");
        sql.append(" LEFT JOIN t_km_knowledge_rel kr ON l.id=kr.library_id ");
        sql.append(" WHERE l.corp_code=:corpCode AND l.library_type=:type ");
        param.put("corpCode", ExecutionContext.getCorpCode());
        param.put("type", libraryType);
        sql.append(" GROUP BY l.id ORDER BY count(kr.id) DESC,l.id LIMIT :rankCount ");
        if (hotCount > 0) {
            sql.append(" LIMIT :rankCount ");
            param.put("rankCount", hotCount);
        }

        return getJdbcTemplate().queryForList(sql.toString(), param, Library.class);
    }
}
