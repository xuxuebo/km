package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.base.vo.PeTreeNode;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.KnowledgeRel;
import com.qgutech.km.module.km.model.Library;
import org.apache.commons.collections.CollectionUtils;
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
    @Transactional(readOnly = true)
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
            return null;
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
    public String addFolder(String libraryName) {
        Library myLibrary = getUserLibraryByLibraryType(KnowledgeConstant.MY_LIBRARY);
        Library library = new Library();
        library.setLibraryName(libraryName);
        library.setParentId(myLibrary.getId());
        library.setLibraryType(KnowledgeConstant.MY_LIBRARY);
        library.setIdPath("");
        library.setShowOrder(getMaxShowOrderByParentId(myLibrary.getId())+1);
        String id = save(library);
        update(id,Library.ID_PATH,myLibrary.getIdPath()+"."+id);

        Knowledge knowledge = new Knowledge();
        knowledge.setKnowledgeName(libraryName);
        knowledge.setKnowledgeType("file");
        knowledge.setFolder(id);
        knowledge.setFileId("");
        knowledge.setKnowledgeSize(0);
        knowledge.setSourceKnowledgeId(id);
        knowledge.setShowOrder(0);
        String  knowledgeId =knowledgeService.save(knowledge);

        KnowledgeRel knowledgeRel = new KnowledgeRel();
        knowledgeRel.setLibraryId(id);
        knowledgeRel.setKnowledgeId(knowledgeId);
        knowledgeRelService.save(knowledgeRel);

        KnowledgeRel k = new KnowledgeRel();
        k.setLibraryId(myLibrary.getId());
        k.setKnowledgeId(knowledgeId);
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
}
