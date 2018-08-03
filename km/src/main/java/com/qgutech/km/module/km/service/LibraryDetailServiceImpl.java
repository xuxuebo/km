package com.qgutech.km.module.km.service;

import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.module.km.model.LibraryDetail;
import com.qgutech.km.utils.PeException;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author TangFD@HF 2018/8/2
 */
@Service("libraryDetailService")
public class LibraryDetailServiceImpl extends BaseServiceImpl<LibraryDetail> implements LibraryDetailService {

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public LibraryDetail getByLibraryId(String libraryId) {
        if (StringUtils.isEmpty(libraryId)) {
            throw new PeException("libraryId must be not empty!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.eq(LibraryDetail.LIBRARY_ID, libraryId));
        return getByCriterion(conjunction);
    }
}
