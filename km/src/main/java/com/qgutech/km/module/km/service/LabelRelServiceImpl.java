package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.module.km.model.LabelRel;
import com.qgutech.km.utils.PeException;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2018/6/25.
 */
@Service("labelRelService")
public class LabelRelServiceImpl extends BaseServiceImpl<LabelRel> implements LabelRelService {

    @Override
    @Transactional(readOnly = true)
    public List<LabelRel> getByLabelId(String labelId) {
        Criterion criterion = Restrictions.and(Restrictions.eq(LabelRel.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(LabelRel.LABEL_ID,labelId));
        return listByCriterion(criterion,new Order[]{Order.desc(LabelRel.CREATE_TIME)});
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<String> getKnowledgeIdsByLabelIdAndUserIds(String labelId, List<String> userIds) {
        if (StringUtils.isEmpty(labelId)) {
            throw new PeException("labelId must be not empty!");
        }

        Conjunction conjunction = Restrictions.and(Restrictions.eq(LabelRel.CORP_CODE, ExecutionContext.getCorpCode()));
        conjunction.add(Restrictions.eq(LabelRel.LABEL_ID, labelId));
        if (CollectionUtils.isNotEmpty(userIds)) {
            conjunction.add(Restrictions.in(LabelRel.CREATE_BY, userIds));
        }
        List<LabelRel> labelRelList = listByCriterion(conjunction);
        if (CollectionUtils.isEmpty(labelRelList)) {
            return new ArrayList<>(0);
        }

        List<String> knowledgeIds = new ArrayList<>(labelRelList.size());
        knowledgeIds.addAll(labelRelList.stream().map(LabelRel::getKnowledgeId).collect(Collectors.toList()));
        return knowledgeIds;
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public int deleteByKnowledgeId(String knowledgeId) {
        if (StringUtils.isEmpty(knowledgeId)) {
            throw new PeException("knowledgeId must be not empty!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.eq(LabelRel.KNOWLEDGE_ID, knowledgeId));
        return delete(conjunction);
    }
}
