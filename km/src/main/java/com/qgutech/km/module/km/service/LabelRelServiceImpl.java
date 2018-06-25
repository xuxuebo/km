package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.module.km.model.LabelRel;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

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
}
