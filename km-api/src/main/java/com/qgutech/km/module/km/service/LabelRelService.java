package com.qgutech.km.module.km.service;

import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.LabelRel;

import java.util.List;

/**
 * Created by Administrator on 2018/6/25.
 */
public interface LabelRelService extends BaseService<LabelRel> {

    List<LabelRel> getByLabelId(String labelId);
}
