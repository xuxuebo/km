package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.KnowledgeRel;
import com.qgutech.km.module.km.model.Library;
import com.qgutech.km.module.uc.service.UserService;
import com.qgutech.km.utils.PeDateUtils;
import com.qgutech.km.utils.PeException;
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
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2018/6/22.
 */
@Service("knowledgeRelService")
public class KnowledgeRelServiceImpl extends BaseServiceImpl<KnowledgeRel> implements KnowledgeRelService {
    @Resource
    private UserService userService;

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
                new Order[]{Order.desc(Library.CREATE_TIME)}
        );
        return knowledgeRels;
    }

    @Override
    @Transactional(readOnly = true)
    public List<KnowledgeRel> findByLibraryIdAndKnowledgeIds(String libraryId, List<String> knowledgeIds) {
        if(StringUtils.isEmpty(libraryId)){
            throw  new PeException("libraryId not be null ");
        }
        Criterion criterion = Restrictions.and(Restrictions.eq(KnowledgeRel.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(KnowledgeRel.LIBRARY_ID,libraryId),
                Restrictions.in(KnowledgeRel.KNOWLEDGE_ID,knowledgeIds));

        List<KnowledgeRel> knowledgeRels = new ArrayList<>();
        knowledgeRels = listByCriterion(   criterion ,
                new Order[]{Order.asc(Library.CREATE_TIME)}
        );
        return knowledgeRels;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<KnowledgeRel> findKnowledgeRel(Knowledge knowledge) {
        if (knowledge == null || StringUtils.isEmpty(knowledge.getLibraryId())) {
            throw new PeException("libraryId not be null ");
        }


        Conjunction conjunction = Restrictions.and(Restrictions.eq(KnowledgeRel.CORP_CODE, ExecutionContext.getCorpCode()));
        conjunction.add(Restrictions.eq(KnowledgeRel.LIBRARY_ID, knowledge.getLibraryId()));
        String createBy = knowledge.getCreateBy();
        if (StringUtils.isNotEmpty(createBy)) {
            List<String> userIds = userService.listUserId(createBy, null);
            if (CollectionUtils.isEmpty(userIds)) {
                return new ArrayList<>(0);
            }

            conjunction.add(Restrictions.in(KnowledgeRel.CREATE_BY, userIds));
        }

        Date startDate = knowledge.getStartDate();
        if (startDate != null) {
            conjunction.add(Restrictions.gt(KnowledgeRel.CREATE_TIME, PeDateUtils.getFirstDate(startDate)));
        }

        Date endDate = knowledge.getEndDate();
        if (endDate != null) {
            conjunction.add(Restrictions.lt(KnowledgeRel.CREATE_TIME, PeDateUtils.getEndDate(endDate)));
        }

        return listByCriterion(conjunction, new Order[]{Order.desc(Library.CREATE_TIME)});
    }
}
