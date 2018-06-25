package com.qgutech.km.module.km.service;

import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.base.vo.PeTreeNode;
import com.qgutech.km.module.km.model.Label;

import java.util.List;

/**
 * Created by Administrator on 2018/6/25.
 */
public interface LabelService extends BaseService<Label> {

    String saveLabel(Label label);

    boolean checkName(Label label);

    String updateLabel(Label label);

    String deleteLabel(String id);

    List<PeTreeNode> listTree();

    void moveShowOrder(String id,boolean isUp);

    Label getRoot();

}
