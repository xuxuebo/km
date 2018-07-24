package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.base.vo.PeTreeNode;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.KnowledgeRel;
import com.qgutech.km.module.km.model.Library;
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
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2018/6/22.
 */
@Service("libraryService")
public class LibraryServiceImpl extends BaseServiceImpl<Library> implements LibraryService{

    @Resource
    private KnowledgeService knowledgeService;
    @Resource
    private KnowledgeRelService knowledgeRelService;

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

        library.setCorpCode(ExecutionContext.getCorpCode());
        return baseService.save(library);
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
}
