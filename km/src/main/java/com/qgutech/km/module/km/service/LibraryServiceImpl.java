package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.Library;
import org.apache.commons.collections.CollectionUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2018/6/22.
 */
@Service("libraryService")
public class LibraryServiceImpl extends BaseServiceImpl<Library> implements LibraryService{


    @Override
    @Transactional(readOnly = true)
    public Library getUserLibraryByLibraryType(String libraryType) {

        Criterion criterion = Restrictions.and(Restrictions.eq(Library.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(Library.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(Library.LIBRARY_TYPE,libraryType),
                Restrictions.eq(Library.PARENT_ID,null));

        List<Library> libraries = listByCriterion(    criterion ,
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
}
