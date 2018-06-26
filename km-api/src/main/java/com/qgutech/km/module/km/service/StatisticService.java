package com.qgutech.km.module.km.service;

import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.Statistic;

import java.util.List;

/**
 * Created by Administrator on 2018/6/22.
 */
public interface StatisticService extends BaseService<Statistic> {


    List<Statistic> getByShareIds(List<String> shareIds);

    int deleteByShareIds(List<String> shareIds);

}
