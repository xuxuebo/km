package com.qgutech.km.base.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Message;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.utils.PeUtils;
import com.qgutech.km.base.model.PageParam;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("messageService")
public class MessageServiceImpl extends BaseServiceImpl<Message> implements MessageService {

    @Override
    @Transactional(readOnly = true)
    public Page<Message> search(PageParam pageParam) {
        PeUtils.validPage(pageParam);
        Conjunction conjunction = Restrictions.conjunction();
        conjunction.add(Restrictions.eq(Message._user, ExecutionContext.getUserId()));
        conjunction.add(Restrictions.eq(Message._corpCode, ExecutionContext.getCorpCode()));
        return search(pageParam, conjunction, new Order[]{Order.desc(Message._createTime)}, Message._id,
                Message._content, Message._read, Message._createTime);

    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int markReadMessage(List<String> messageIds) {
        if (CollectionUtils.isEmpty(messageIds)) {
            throw new IllegalArgumentException("Parameters is illegal when update status!");
        }
        Criterion criterion = Restrictions.and(
                Restrictions.eq(Message._user, ExecutionContext.getUserId()),
                Restrictions.in(Message._id, messageIds)
        );

        return updateByCriterion(criterion, Message._read, true);
    }

    @Override
    @Transactional(readOnly = true)
    public Long count(String userId) {
        if (StringUtils.isBlank(userId)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.eq(Message._user, userId));
        conjunction.add(Restrictions.eq(Message._read, Boolean.FALSE));
        return getRowCountByCriterion(conjunction);
    }
}
