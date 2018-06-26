package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.module.km.model.Statistic;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Administrator on 2018/6/22.
 */
@Service("statisticService")
public class StatisticServiceImpl extends BaseServiceImpl<Statistic> implements StatisticService {

    @Override
    @Transactional(readOnly = true)
    public List<Statistic> getByShareIds(List<String> shareIds) {

        Criterion criterion = Restrictions.and(Restrictions.eq(Statistic.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.in(Statistic.SHARE_ID,shareIds));
        return listByCriterion(criterion,new Order[]{Order.desc(Statistic.CREATE_TIME)});
    }


    @Override
    @Transactional(readOnly = false)
    public int deleteByShareIds(List<String> shareIds) {
        Criterion criterion = Restrictions.and(Restrictions.in(Statistic.SHARE_ID,shareIds),
                Restrictions.eq(Statistic.CORP_CODE,ExecutionContext.getCorpCode()),
                Restrictions.eq(Statistic.CREATE_BY,ExecutionContext.getUserId()));
        return delete(criterion);
    }
}
