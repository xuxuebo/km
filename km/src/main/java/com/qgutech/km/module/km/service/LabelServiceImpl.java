package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.base.vo.PeTreeNode;
import com.qgutech.km.module.km.model.Label;
import com.qgutech.km.module.km.model.LabelRel;
import com.qgutech.km.utils.PeException;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2018/6/25.
 */
@Service("labelService")
public class LabelServiceImpl extends BaseServiceImpl<Label> implements LabelService {

    @Resource
    private LabelRelService labelRelService;

    @Override
    @Transactional(readOnly = false)
    public String saveLabel(Label label) {
        checkLabel(label);
        boolean hasLabelName = checkName(label);
        if(hasLabelName){
            throw new PeException("名称重复");
        }
        label.setShowOrder(getMaxShowOrder(label.getParentId())+1);
        return save(label);
    }

    private void checkLabel(Label label){
        if(label==null){
            throw  new IllegalArgumentException("label is null ");
        }else if(StringUtils.isEmpty(label.getLabelName())||label.getLabelName().length()>50){
            throw  new IllegalArgumentException("lable is illegal");
        }else if(StringUtils.isEmpty(label.getParentId())){
            throw  new IllegalArgumentException("label not has parent label  ");
        }
    }


    /**
     * 获取某个父级下的标签最大排序树 若没有下级则返回0F
     * @param parentId
     * @return
     */
    @Transactional(readOnly = true)
    public Float getMaxShowOrder(String parentId){
        if(StringUtils.isEmpty(parentId)){
            throw new PeException("parentId must not be null ");
        }
        Criterion criterion = Restrictions.and(Restrictions.eq(Label.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.eq(Label.PARENT_ID,parentId));
        List<Label> labelList = listByCriterion(criterion,new Order[]{Order.desc(Label.SHOW_ORDER)});
        if(CollectionUtils.isEmpty(labelList)){
            return 0f;
        }
        return labelList.get(0).getShowOrder();
    }

    /**
     * 检验同一级下名称是否重复
     * @param label
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public boolean checkName(Label label) {
        Criterion criterion = Restrictions.and(Restrictions.eq(Label.CORP_CODE,ExecutionContext.getCorpCode()),
                Restrictions.eq(Label.PARENT_ID,label.getParentId()),
                Restrictions.eq(Label.LABEL_NAME,label.getLabelName()));
        String labelId = getFieldValueByCriterion(criterion,Label.ID);
        return !StringUtils.isBlank(labelId) &&
                !(StringUtils.isNotBlank(label.getId()) && labelId.equals(label.getId()));
    }


    @Override
    @Transactional(readOnly = false)
    public String updateLabel(Label label) {
        checkLabel(label);
        if(StringUtils.isEmpty(label.getId())){
            throw new PeException("labelId is null ");
        }
        Label dataLabel = get(label.getId());
        if(dataLabel==null){
            throw new PeException("dataLabel is null");
        }
        boolean hasName = checkName(label);
        if(hasName){
            throw new PeException("名称重复");
        }
        String oldParentId = label.getParentId();
        if (StringUtils.isNotBlank(oldParentId) && oldParentId.equals(label.getParentId())) {
            super.update(label, Label.LABEL_NAME,Label.PARENT_ID);
        }
        return label.getId();
    }

    /**
     * 1.校验其有没有下级
     * 2.校验是否有文件引用此标签
     * @param id
     * @return
     */
    @Override
    @Transactional(readOnly = false)
    public String deleteLabel(String id) {
        List<LabelRel> labelRelList = labelRelService.getByLabelId(id);
        if(!CollectionUtils.isEmpty(labelRelList)){
            return "有文件设置了此标签";
        }
        Criterion criterion = Restrictions.and(Restrictions.eq(Label.CORP_CODE,ExecutionContext.getCorpCode()),
                Restrictions.eq(Label.PARENT_ID,id));
        List<Label> labelList = listByCriterion(criterion,new Order[]{Order.desc(Label.CREATE_TIME)});
        if(!CollectionUtils.isEmpty(labelList)){
            return "此目录包含下级,无法删除";
        }
        delete(id);
        return "操作成功";
    }


    @Override
    @Transactional(readOnly = true)
    public List<PeTreeNode> listTree() {
        Criterion criterion = Restrictions.and(Restrictions.eq(Label.CORP_CODE,ExecutionContext.getCorpCode()));
        List<Label> allLabel = listByCriterion(criterion,new Order[]{Order.asc(Label.SHOW_ORDER),Order.desc(Label.CREATE_TIME)});
        if(CollectionUtils.isEmpty(allLabel)){
            return new ArrayList<>();
        }
        List<PeTreeNode> nodeList = new ArrayList<>(allLabel.size());
        PeTreeNode peTreeNode;
        for(Label label : allLabel){
            peTreeNode = new PeTreeNode();
            peTreeNode.setName(label.getLabelName());
            peTreeNode.setpId(label.getParentId());
            peTreeNode.setId(label.getId());
            peTreeNode.setParent(true);
            nodeList.add(peTreeNode);
        }
        return nodeList;
    }

    @Override
    @Transactional(readOnly = false)
    public void moveShowOrder(String id, boolean isUp) {
        if(StringUtils.isEmpty(id)){
            throw new IllegalArgumentException("id is null ");
        }
        Label label = get(id);
        if(label==null){
            throw  new IllegalArgumentException("label is null ");
        }
        Criteria criteria = createCriteria();
        criteria.add(Restrictions.and(Restrictions.eq(Label.CORP_CODE,ExecutionContext.getCorpCode()),
                Restrictions.eq(Label.PARENT_ID,label.getParentId())));
        Float showOrder = label.getShowOrder();
        if(isUp){
            criteria.add(Restrictions.and(Restrictions.lt(Label.SHOW_ORDER,showOrder)));
            criteria.addOrder(Order.desc(Label.SHOW_ORDER));
        }else{
            criteria.add(Restrictions.and(Restrictions.gt(Label.SHOW_ORDER,showOrder)));
            criteria.addOrder(Order.asc(Label.SHOW_ORDER));
        }
        criteria.setMaxResults(1);
        Label lastLabel = (Label)criteria.uniqueResult();
        if (lastLabel==null){
            throw new IllegalArgumentException("lastLabel is null ");
        }
        label.setShowOrder(lastLabel.getShowOrder());
        lastLabel.setShowOrder(label.getShowOrder());
        update(label,Label.SHOW_ORDER);
        update(lastLabel,Label.SHOW_ORDER);
    }

    @Override
    @Transactional(readOnly = true)
    public Label getRoot() {
        Label label = getByCriterion(Restrictions.and(
                Restrictions.eq(Label.CORP_CODE, ExecutionContext.getCorpCode())
                , Restrictions.isNull(Label.PARENT_ID)));
        if(label==null){
            label = new Label();
            label.setLabelName("全部");
            label.setShowOrder(0);
            label.setParentId(null);
            String id = save(label);
            label.setId(id);
        }
       return label;
    }
}
