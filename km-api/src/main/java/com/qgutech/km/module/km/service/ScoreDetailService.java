package com.qgutech.km.module.km.service;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.ScoreDetail;


/**
 * 积分明细
 *
 * @author TangFD@HF 2018-8-21
 */
public interface ScoreDetailService extends BaseService<ScoreDetail> {

    /**
     * 积分统计
     *
     * @param detail    查询条件，不可为空
     * @param pageParam 分页对象
     * @return 人员积分统计信息
     * @throws RuntimeException 当pageParam不符合条件，或者detail为空时
     * @since TangFD@HF 2018-8-21
     */
    Page<ScoreDetail> searchStatistic(ScoreDetail detail, PageParam pageParam);

    /**
     * 查询积分明细
     *
     * @param detail    查询条件，不可为空
     * @param pageParam 分页对象
     * @return 人员积分明细信息
     * @throws RuntimeException 当pageParam不符合条件，或者detail为空，或者userId为空时
     * @since TangFD@HF 2018-8-21
     */
    Page<ScoreDetail> searchDetail(ScoreDetail detail, PageParam pageParam);
}
