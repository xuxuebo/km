package com.qgutech.pe.module.uc.service;

import com.qgutech.pe.base.ExecutionContext;
import com.qgutech.pe.base.service.BaseServiceImpl;
import com.qgutech.pe.constant.PeConstant;
import com.qgutech.pe.module.uc.model.Authority;
import com.sun.org.apache.regexp.internal.RE;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author Created by zhangyang on 2016/10/29.
 */
@Service("authorityService")
public class AuthorityServiceImpl extends BaseServiceImpl<Authority> implements AuthorityService {

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<Authority> list() {
        return listByCriterion(Restrictions.conjunction()
                .add(Restrictions.eq(Authority._corpCode, PeConstant.DEFAULT_CORP_CODE)));
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<String> listIds() {
        return listFieldValueByCriterion(Restrictions.conjunction()
                .add(Restrictions.eq(Authority._corpCode, PeConstant.DEFAULT_CORP_CODE)), Authority._id);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Authority get(String corpCode, String authCode) {
        if (StringUtils.isEmpty(corpCode) || StringUtils.isEmpty(authCode)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        Conjunction conjunction = Restrictions.conjunction();
        conjunction.add(Restrictions.eq(Authority._corpCode, corpCode));
        conjunction.add(Restrictions.eq(Authority._authCode, authCode));
        return getByCriterion(conjunction, Authority._id);
    }
}
