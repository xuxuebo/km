package com.qgutech.km.module.km.service;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.Label;

/**
 * Created by Administrator on 2018/6/25.
 */
public interface LabelService extends BaseService<Label> {

    String saveLabel(Label label);

    boolean checkName(Label label);

    String updateLabel(Label label);

    String deleteLabel(String id);

    Page<Label> listTree(PageParam pageParam);

    void moveShowOrder(String id,boolean isUp);

    Label getRoot();

}
