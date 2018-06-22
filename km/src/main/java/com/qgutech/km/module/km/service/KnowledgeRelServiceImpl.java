package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.KnowledgeRel;
import com.qgutech.km.module.km.model.Library;
import com.qgutech.km.utils.PeException;
import org.apache.commons.lang.StringUtils;
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
@Service("knowledgeRelService")
public class KnowledgeRelServiceImpl extends BaseServiceImpl<KnowledgeRel> implements KnowledgeRelService {

    @Override
    @Transactional(readOnly = true)
    public List<KnowledgeRel> findByLibraryId(String libraryId) {
        if(StringUtils.isEmpty(libraryId)){
            throw  new PeException("libraryId not be null ");
        }
        Criterion criterion = Restrictions.and(Restrictions.eq(KnowledgeRel.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(KnowledgeRel.LIBRARY_ID,libraryId));

        List<KnowledgeRel> knowledgeRels = new ArrayList<>();
        knowledgeRels = listByCriterion(   criterion ,
                new Order[]{Order.asc(Library.CREATE_TIME)}
        );
        return knowledgeRels;
    }
}
