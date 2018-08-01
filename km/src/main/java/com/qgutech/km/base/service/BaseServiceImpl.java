package com.qgutech.km.base.service;

import com.qgutech.km.base.model.BaseModel;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.utils.ReflectUtil;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.PageParam;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.*;
import org.hibernate.engine.spi.SessionFactoryImplementor;
import org.hibernate.engine.spi.TypedValue;
import org.hibernate.internal.CriteriaImpl;
import org.hibernate.loader.criteria.CriteriaQueryTranslator;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.util.ClassUtils;

import javax.annotation.Resource;
import java.lang.reflect.Field;
import java.util.*;

/**
 * 这个基础类，抽象了Service接口的一些通常实现，简化普通服务类的开发。
 * <p>
 *
 * @author ELF@TEAM
 * @since 2016年2月24日11:13:27
 */

@SuppressWarnings("unchecked")
public class BaseServiceImpl<T extends BaseModel> implements BaseService<T>, PeConstant {

    protected final Log LOG = LogFactory.getLog(getClass());

    @Resource
    protected HibernateDao baseService;

    protected final Class<T> modelClass;

    private static final int BATCH_SIZE = 1000;

    public BaseServiceImpl() {
        modelClass = ReflectUtil.getGenericParamClass(this.getClass());
    }

    protected Criteria createCriteria() {
        return baseService.getSession().createCriteria(modelClass);
    }

    protected Criteria createCriteria(Class<?> clazz) {
        return baseService.getSession().createCriteria(clazz);
    }

    protected String getEntityName() {
        return ClassUtils.getShortName(modelClass);
    }

    protected String getFullEntityName() {
        return modelClass.getName();
    }

    protected Conjunction getConjunction() {
        Conjunction conjunction = Restrictions.conjunction();
        conjunction.add(Restrictions.eq(BaseModel.CORP_CODE, ExecutionContext.getCorpCode()));
        return conjunction;
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public String save(T model) {
        Assert.notNull(model, "model is null!");
        String modelId = model.getId();
        if (StringUtils.isBlank(modelId)) {
            return baseService.save(model);
        }

        baseService.update(model);
        baseService.getSession().flush();
        return modelId;
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public void update(T model, String... fields) {
        Assert.notNull(model, "model is null!");
        if (fields == null || fields.length == 0) {
            baseService.update(model);
            return;
        }

        Set<String> set = new HashSet<>(fields.length + 2);
        Collections.addAll(set, fields);
        set.add(BaseModel.UPDATE_BY);
        set.add(BaseModel.UPDATE_TIME);
        model.setUpdateBy(ExecutionContext.getUserId());
        model.setUpdateTime(new Date());
        update(set.toArray(new String[set.size()]), model);
    }

    private int update(String[] fields, T model) {
        HqlBuilder builder = new HqlBuilder();
        builder.append(UPDATE).append(getEntityName()).append(SET);
        builder.append(fields[0]).append(EQUAL).append(COLON + processHqlMapKey(fields[0]));
        builder.addParameter(processHqlMapKey(fields[0]), getFieldValue(fields[0], model));
        for (int i = 1; i < fields.length; i++) {
            builder.append(COMMA).append(fields[i]).append(EQUAL).append(COLON + processHqlMapKey(fields[i]));
            builder.addParameter(processHqlMapKey(fields[i]), getFieldValue(fields[i], model));
        }

        builder.append(WHERE).append(BaseModel.ID).append(EQUAL).append(COLON + BaseModel.ID);
        builder.addParameter(processHqlMapKey(BaseModel.ID), model.getId());
        return executeUpdate(builder);
    }

    private String processHqlMapKey(String fieldKey) {
        if (!fieldKey.contains(PeConstant.POINT)) {
            return fieldKey;
        }

        StringBuilder builder = new StringBuilder();
        String[] fieldSegment = fieldKey.split("\\" + PeConstant.POINT);
        for (int index = 0; index < fieldSegment.length; index++) {
            if (index == 0) {
                builder.append(fieldSegment[index]);
                continue;
            }

            char[] cs = fieldSegment[index].toCharArray();
            cs[0] -= 32;
            builder.append(cs);
        }

        return builder.toString();
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public void update(List<T> models, String... fields) {
        Assert.notEmpty(models, "models is empty!");
        if (fields == null || fields.length == 0) {
            baseService.batchSaveOrUpdate(models);
            return;
        }

        for (T model : models) {
            update(model, fields);
        }
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int update(String modelId, String fieldName, Object value) {
        Assert.hasText(modelId, "modelId is empty!");
        Assert.hasText(fieldName, "fieldName is empty!");

        List<String> modelIds = new ArrayList<String>(1);
        modelIds.add(modelId);
        return update(modelIds, fieldName, value);
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int update(List<String> modelIds, String fieldName, Object value) {
        Assert.notEmpty(modelIds, "modelIds is empty!");
        Assert.hasText(fieldName, "fieldName is empty!");

        baseService.getSession().flush();
        HqlBuilder builder = new HqlBuilder();
        builder.append(UPDATE).append(getEntityName()).append(SET);
        builder.append(fieldName).append(EQUAL).append(COLON + "fieldValue").append(COMMA);
        builder.append(BaseModel.UPDATE_TIME).append(EQUAL).append(COLON + BaseModel.UPDATE_TIME).append(COMMA);
        builder.append(BaseModel.UPDATE_BY).append(EQUAL).append(COLON + BaseModel.UPDATE_BY);
        builder.append(WHERE).append(BaseModel.ID).append(IN).append(LEFT_BRACKET)
                .append(COLON + "primaryKeyValues").append(RIGHT_BRACKET);
        Query query = baseService.getSession().createQuery(builder.toString());
        query.setParameter("fieldValue", value);
        query.setParameter(BaseModel.UPDATE_TIME, new Date());
        query.setParameter(BaseModel.UPDATE_BY, ExecutionContext.getUserId());
        int size = modelIds.size();
        int count = size % BATCH_SIZE == 0 ? size / BATCH_SIZE : (size / BATCH_SIZE + 1);
        int execute = 0;
        for (int i = 0; i < count; i++) {
            int start = i * BATCH_SIZE;
            int end = (i + 1) * BATCH_SIZE >= size ? size : (i + 1) * BATCH_SIZE;
            query.setParameterList("primaryKeyValues", modelIds.subList(start, end));
            execute += query.executeUpdate();
        }

        baseService.getSession().clear();
        return execute;
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int update(List<String> modelIds, T model, String... fields) {
        Assert.notEmpty(modelIds, "modelIds is empty!");
        Assert.notNull(model, "model is null!");

        return updateByCriterion(Restrictions.in(BaseModel.ID, modelIds), model, fields);
    }

    private Object getFieldValue(String fieldName, Object model) {
        Class<?> clazz = model.getClass();
        if (!fieldName.contains(".")) {
            Field field = ReflectUtil.getField(clazz, fieldName);
            Assert.notNull(field, "field[fieldName:" + fieldName + "] not in class[" + clazz + "]!");
            return ReflectUtil.getFieldValue(field, model);
        }

        String beforeField = fieldName.substring(0, fieldName.indexOf("."));
        Assert.hasText(beforeField, "field[fieldName" + fieldName + "] is illegal!");
        Field field = ReflectUtil.getField(clazz, beforeField);
        Assert.notNull(field, "field[fieldName:" + beforeField + "] not in class[" + clazz + "]!");
        Object fieldValue = ReflectUtil.getFieldValue(field, model);
        if (fieldValue == null) {
            return null;
        }

        String afterField = fieldName.substring(fieldName.indexOf(".") + 1);
        Assert.hasText(afterField, "field[fieldName" + fieldName + "] is illegal!");
        return getFieldValue(afterField, fieldValue);
    }

    @Override
    @Transactional(readOnly = true)
    public T load(String modelId) {
        Assert.hasText(modelId, "modelId is empty!");
        return baseService.load(modelClass, modelId);
    }

    @Override
    @Transactional(readOnly = true)
    public T get(String modelId, String... fieldNames) {
        Assert.hasText(modelId, "modelId is empty!");
        if (fieldNames == null || fieldNames.length == 0) {
            return baseService.get(modelClass, modelId);
        }

        return getByFieldNameAndValue(BaseModel.ID, modelId, fieldNames);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public boolean exist(String modelId) {
        Assert.hasText(modelId, "modelId is empty!");
        return exist(BaseModel.ID, modelId);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public boolean exist(String fieldName, Object fieldValue) {
        Assert.hasText(fieldName, "fieldName is empty!");

        return exist(Restrictions.eq(fieldName, fieldValue));
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public boolean exist(Criterion criterion) {
        Assert.notNull(criterion, "criterion is null!");

        return getRowCountByCriterion(criterion) > 0;
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public Long getRowCountByFieldNameAndValue(String fieldName, Object fieldValue) {
        Assert.hasText(fieldName, "fieldName is empty!");

        return getRowCountByCriterion(Restrictions.eq(fieldName, fieldValue));
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public Long getRowCountByCriterion(Criterion criterion) {
        Assert.notNull(criterion, "criterion is null!");

        return getRowCountByCriteria(createCriteria().add(criterion));
    }

    @Override
    @Transactional(readOnly = true)
    public Long getRowCountByCriteria(Criteria criteria) {
        Assert.notNull(criteria, "criteria is null!");

        Object result = criteria.setProjection(Projections.rowCount()).uniqueResult();
        return result == null ? 0L : (Long) result;
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public <V> V sumByFieldNameAndValue(String fieldName, Object fieldValue, String sumField) {
        Assert.hasText(fieldName, "fieldName is empty!");
        Assert.hasText(sumField, "sumField is empty!");

        return sumByCriterion(Restrictions.eq(fieldName, fieldValue), sumField);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public <V> V sumByCriterion(Criterion criterion, String sumField) {
        Assert.notNull(criterion, "criterion is null!");
        Assert.hasText(sumField, "sumField is empty!");

        return (V) createCriteria().add(criterion)
                .setProjection(Projections.sum(sumField)).uniqueResult();
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public <K, V> Map<K, V> groupSumByCriterion(Criterion criterion, String groupField, String sumField) {
        Assert.notNull(criterion, "criterion is null!");
        Assert.hasText(groupField, "groupField is empty!");
        Assert.hasText(sumField, "sumField is empty!");

        Criteria criteria = createCriteria().add(criterion);
        Map<String, Boolean> aliasMap = new HashMap<String, Boolean>(1);
        if (groupField.contains(".")) {
            String alias = groupField.substring(0, groupField.indexOf("."));
            String subField = groupField.substring(groupField.indexOf(".") + 1);
            Assert.hasText(subField, "subField[" + groupField + "] is empty!");
            if (!validPrimaryKey(alias, subField)) {
                aliasMap.put(alias, true);
                criteria.createAlias(alias, alias);
            }
        }

        if (sumField.contains(".")) {
            String alias = sumField.substring(0, sumField.indexOf("."));
            String subField = sumField.substring(sumField.indexOf(".") + 1);
            Assert.hasText(subField, "subField[" + sumField + "] is empty!");
            if (!validPrimaryKey(alias, subField) && aliasMap.get(alias) == null) {
                criteria.createAlias(alias, alias);
            }
        }

        List<Object[]> list = criteria.setProjection(Projections.projectionList()
                .add(Projections.groupProperty(groupField))
                .add(Projections.sum(sumField))).list();
        if (list == null || list.size() == 0) {
            return new HashMap<K, V>(0);
        }

        Map<K, V> resultMap = new HashMap<K, V>(list.size());
        for (Object[] objects : list) {
            resultMap.put((K) objects[0], (V) (objects[1]));
        }

        return resultMap;
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public <K, V> Map<K, V> groupByCriterion(Criterion criterion, String groupField, String maxField) {
        Assert.notNull(criterion, "criterion is null!");
        Assert.hasText(groupField, "groupField is empty!");
        Assert.hasText(maxField, "maxField is empty!");

        Criteria criteria = createCriteria().add(criterion);
        Map<String, Boolean> aliasMap = new HashMap<String, Boolean>(1);
        if (groupField.contains(".")) {
            String alias = groupField.substring(0, groupField.indexOf("."));
            String subField = groupField.substring(groupField.indexOf(".") + 1);
            Assert.hasText(subField, "subField[" + groupField + "] is empty!");
            if (!validPrimaryKey(alias, subField)) {
                aliasMap.put(alias, true);
                criteria.createAlias(alias, alias);
            }
        }

        if (maxField.contains(".")) {
            String alias = maxField.substring(0, maxField.indexOf("."));
            String subField = maxField.substring(maxField.indexOf(".") + 1);
            Assert.hasText(subField, "subField[" + maxField + "] is empty!");
            if (!validPrimaryKey(alias, subField) && aliasMap.get(alias) == null) {
                criteria.createAlias(alias, alias);
            }
        }

        List<Object[]> list = criteria.setProjection(Projections.projectionList()
                .add(Projections.groupProperty(groupField))
                .add(Projections.max(maxField))).list();
        if (list == null || list.size() == 0) {
            return new HashMap<K, V>(0);
        }

        Map<K, V> resultMap = new HashMap<K, V>(list.size());
        for (Object[] objects : list) {
            resultMap.put((K) objects[0], (V) (objects[1]));
        }

        return resultMap;
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public <K, V> Map<K, V> groupByCriterion(Criterion criterion, Order[] orders
            , String groupField, String field) {
        Assert.notNull(criterion, "criterion is null!");
        Assert.notEmpty(orders, "orders is empty!");
        Assert.hasText(groupField, "groupField is empty!");
        Assert.hasText(field, "field is empty!");

        ProjectionList projectionList = Projections.projectionList()
                .add(Projections.groupProperty(groupField))
                .add(Projections.max(field));
        Criteria criteria = createCriteria().add(criterion);
        for (Order order : orders) {
            Assert.notNull(order, "order in orders is null!");
            criteria.addOrder(order);
            if (order.isAscending()) {
                projectionList.add(Projections.min(order.getPropertyName()).as(order.getPropertyName()));
            } else {
                projectionList.add(Projections.max(order.getPropertyName()).as(order.getPropertyName()));
            }
        }

        List<Object[]> list = criteria.setProjection(projectionList).list();
        if (list == null || list.size() == 0) {
            return new HashMap<K, V>(0);
        }

        Map<K, V> resultMap = new HashMap<K, V>(list.size());
        for (Object[] objects : list) {
            resultMap.put((K) objects[0], (V) (objects[1]));
        }

        return resultMap;
    }

    private boolean validPrimaryKey(String firstField, String subField) {
        Field field = ReflectUtil.getField(modelClass, firstField);
        Assert.notNull(field, "field[" + firstField + "] not in class[" + modelClass + "]!");
        if (!subField.contains(".")) {
            Field f = ReflectUtil.getField(field.getType(), subField);
            Assert.notNull(f, "field[" + subField + "] not in class[" + field.getType() + "]!");
            return BaseModel.ID.equals(f.getName());
        }

        String secondFieldName = subField.substring(0, subField.indexOf("."));
        Field secondField = ReflectUtil.getField(field.getType(), secondFieldName);
        Assert.notNull(secondField, "field[" + secondFieldName + "] not in class[" + field.getType() + "]!");
        String thirdFieldName = subField.substring(subField.indexOf(".") + 1);
        Field thirdField = ReflectUtil.getField(secondField.getType(), thirdFieldName);
        Assert.notNull(thirdField, "field[" + thirdFieldName + "] not in class[" + secondField.getType() + "]!");
        return false;
    }

    private void setFieldValue(String fieldName, Object fieldValue, Object model) {
        Class<?> clazz = model.getClass();
        if (!fieldName.contains(".")) {
            Field field = ReflectUtil.getField(clazz, fieldName);
            Assert.notNull(field, "field[fieldName:" + fieldName + "] not in class[" + clazz + "]!");
            ReflectUtil.setFieldValue(field, model, fieldValue);
            return;
        }

        String beforeField = fieldName.substring(0, fieldName.indexOf("."));
        Assert.hasText(beforeField, "field[fieldName" + fieldName + "] is illegal!");
        Field field = ReflectUtil.getField(clazz, beforeField);
        Assert.notNull(field, "field[fieldName:" + beforeField + "] not in class[" + clazz + "]!");
        Object relModel = ReflectUtil.getFieldValue(field, model);
        if (relModel == null) {
            relModel = ReflectUtil.newInstance(field.getType());
            ReflectUtil.setFieldValue(field, model, relModel);
        }

        String afterField = fieldName.substring(fieldName.indexOf(".") + 1);
        Assert.hasText(afterField, "field[fieldName" + fieldName + "] is illegal!");
        setFieldValue(afterField, fieldValue, relModel);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public T getByFieldNameAndValue(String fieldName, Object fieldValue, String... fieldNames) {
        Assert.hasText(fieldName, "fieldName is empty!");

        if (fieldNames == null || fieldNames.length == 0) {
            return getByCriterion(Restrictions.eq(fieldName, fieldValue));
        }

        Set<String> fields = new HashSet<String>(fieldNames.length + 1);
        Collections.addAll(fields, fieldNames);
        fields.add(fieldName);

        return getByCriterion(Restrictions.eq(fieldName, fieldValue), fields.toArray(new String[fields.size()]));
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public T getByCriterion(Criterion criterion, String... fieldNames) {
        Assert.notNull(criterion, "criterion is null!");

        Criteria criteria = createCriteria().add(criterion);
        if (fieldNames == null || fieldNames.length == 0) {
            return (T) criteria.uniqueResult();
        }

        return getByCriteriaAndFieldNames(criteria, fieldNames);
    }

    @Override
    @Transactional(readOnly = true)
    public T getByCriteria(Criteria criteria, String... fieldNames) {
        Assert.notNull(criteria, "criteria is null!");
        if (fieldNames == null || fieldNames.length == 0) {
            return (T) criteria.uniqueResult();
        }

        return getByCriteriaAndFieldNames(criteria, fieldNames);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public T getByFieldNameAndValue(String fieldName, Object fieldValue, Order[] orders, String... fieldNames) {
        Assert.hasText(fieldName, "fieldName is empty!");
        Assert.notEmpty(orders, "orders is empty!");

        if (fieldNames == null || fieldNames.length == 0) {
            return getByCriterion(Restrictions.eq(fieldName, fieldValue), orders);
        }

        Set<String> fields = new HashSet<String>(fieldNames.length + 1);
        Collections.addAll(fields, fieldNames);
        fields.add(fieldName);
        return getByCriterion(Restrictions.eq(fieldName, fieldValue), orders, fieldNames);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public T getByCriterion(Criterion criterion, Order[] orders, String... fieldNames) {
        Assert.notNull(criterion, "criterion is null!");
        Assert.notEmpty(orders, "orders is empty!");

        Criteria criteria = createCriteria().add(criterion);
        for (Order order : orders) {
            Assert.notNull(order, "order in orders is null!");
            criteria.addOrder(order);
        }

        criteria.setMaxResults(1);
        if (fieldNames == null || fieldNames.length == 0) {
            return (T) criteria.uniqueResult();
        }

        return getByCriteriaAndFieldNames(criteria, fieldNames);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public <V> V getFieldValueById(String modelId, String fieldName) {
        Assert.hasText(modelId, "modelId is empty!");
        Assert.hasText(fieldName, "fieldName is empty!");

        return getFieldValueByFieldNameAndValue(BaseModel.ID, modelId, fieldName);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public <V> V getFieldValueByFieldNameAndValue(String name, Object value, String fieldName) {
        Assert.hasText(name, "name is empty!");
        Assert.hasText(fieldName, "fieldName is empty!");

        return getFieldValueByCriterion(Restrictions.eq(name, value), fieldName);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public <V> V getFieldValueByCriterion(Criterion criterion, String fieldName) {
        Assert.notNull(criterion, "criterion is null!");
        Assert.hasText(fieldName, "fieldName is empty!");

        Criteria criteria = createCriteria().add(criterion);
        return getFieldValueByCriteria(criteria, fieldName);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public <V> V getFieldValueByFieldNameAndValue(String name, Object value, Order[] orders, String fieldName) {
        Assert.hasText(name, "name is empty!");
        Assert.notEmpty(orders, "orders is empty!");
        Assert.hasText(fieldName, "fieldName is empty!");

        return getFieldValueByCriterion(Restrictions.eq(name, value), orders, fieldName);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public <V> V getFieldValueByCriterion(Criterion criterion, Order[] orders, String fieldName) {
        Assert.notNull(criterion, "criterion is null!");
        Assert.notEmpty(orders, "orders is empty!");
        Assert.hasText(fieldName, "fieldName is empty!");

        Criteria criteria = createCriteria().add(criterion);


        for (Order order : orders) {
            Assert.notNull(order, "order in orders is null!");
            criteria.addOrder(order);
        }

        return getFieldValueByCriteria(criteria, fieldName);
    }

    @Override
    @Transactional(readOnly = true)
    public <V> V getFieldValueByCriteria(Criteria criteria, String fieldName) {
        Assert.notNull(criteria, "criteria is null!");
        Assert.hasText(fieldName, "fieldName is empty!");
        if (fieldName.contains(".")) {
            String alias = fieldName.substring(0, fieldName.indexOf("."));
            String subField = fieldName.substring(fieldName.indexOf(".") + 1);
            if (!validPrimaryKey(alias, subField)) {
                criteria.createAlias(alias, alias);
            }
        }

        return (V) criteria.setProjection(Projections.property(fieldName)).setMaxResults(1).uniqueResult();
    }

    private T getByCriteriaAndFieldNames(Criteria criteria, String[] fieldNames) {
        ProjectionList projectionList = Projections.projectionList();
        Map<String, Boolean> aliasMap = new HashMap<String, Boolean>();
        for (String fieldName : fieldNames) {
            Assert.hasText(fieldName, "field is empty!");
            if (fieldName.contains(".")) {
                String alias = fieldName.substring(0, fieldName.indexOf("."));
                String subField = fieldName.substring(fieldName.indexOf(".") + 1);
                Assert.hasText(subField, "subField[" + fieldName + "] is empty!");
                if (!validPrimaryKey(alias, subField) && aliasMap.get(alias) == null) {
                    aliasMap.put(alias, true);
                    criteria.createAlias(alias, alias);
                }
            }

            projectionList.add(Projections.property(fieldName));
        }

        Object o = criteria.setProjection(projectionList).uniqueResult();
        if (o == null) {
            return null;
        }

        T model = (T) ReflectUtil.createInstance(modelClass);
        Assert.notNull(model, "createInstance[class:" + modelClass + "] is failed!");
        if (o.getClass().isArray()) {
            Object[] objects = (Object[]) o;
            for (int i = 0; i < fieldNames.length; i++) {
                Object value = objects[i];
                if (value == null) {
                    continue;
                }

                setFieldValue(fieldNames[i], value, model);
            }
        } else {
            setFieldValue(fieldNames[0], o, model);
        }

        return model;
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<T> listByIds(List<String> modelIds, String... fieldNames) {
        Assert.notEmpty(modelIds, "modelIds is empty!");

        Criterion criterion = Restrictions.in(BaseModel.ID, modelIds);
        if (fieldNames == null || fieldNames.length == 0) {
            return listByCriterion(criterion);
        }

        Set<String> fields = new HashSet<String>(fieldNames.length + 1);
        Collections.addAll(fields, fieldNames);
        fields.add(BaseModel.ID);
        return listByCriterion(criterion, fields.toArray(new String[fields.size()]));
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<T> listByIds(List<String> modelIds, Order[] orders, String... fieldNames) {
        Assert.notEmpty(modelIds, "modelIds is empty!");
        Assert.notEmpty(orders, "orders is empty!");

        Criterion criterion = Restrictions.in(BaseModel.ID, modelIds);
        if (fieldNames == null || fieldNames.length == 0) {
            return listByCriterion(criterion, orders);
        }

        Set<String> fields = new HashSet<String>(fieldNames.length + 1);
        Collections.addAll(fields, fieldNames);
        fields.add(BaseModel.ID);
        return listByCriterion(criterion, orders, fields.toArray(new String[fields.size()]));
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<T> listByFieldNameAndValue(String fieldName, Object fieldValue, String... fieldNames) {
        Assert.hasText(fieldName, "fieldName is empty!");
        Criterion criterion = Restrictions.eq(fieldName, fieldValue);
        if (fieldNames == null || fieldNames.length == 0) {
            return listByCriterion(criterion);
        }

        Set<String> fields = new HashSet<String>(fieldNames.length + 1);
        Collections.addAll(fields, fieldNames);
        fields.add(fieldName);
        return listByCriterion(criterion, fields.toArray(new String[fields.size()]));
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<T> listByFieldNameAndValue(String fieldName, Object fieldValue
            , Order[] orders, String... fieldNames) {
        Assert.hasText(fieldName, "fieldName is empty!");
        Assert.notEmpty(orders, "orders is empty!");

        Criterion criterion = Restrictions.eq(fieldName, fieldValue);
        if (fieldNames == null || fieldNames.length == 0) {
            return listByCriterion(criterion, orders);
        }

        Set<String> fields = new HashSet<String>(fieldNames.length + 1);
        Collections.addAll(fields, fieldNames);
        fields.add(fieldName);
        return listByCriterion(criterion, orders, fields.toArray(new String[fields.size()]));
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<T> listByCriterion(Criterion criterion, String... fieldNames) {
        Assert.notNull(criterion, "criterion is null!");

        Criteria criteria = createCriteria().add(criterion);
        return listByCriteria(criteria, fieldNames);
    }

    @Override
    @Transactional(readOnly = true)
    public List<T> listByCriteria(Criteria criteria, String... fieldNames) {
        Assert.notNull(criteria, "criteria is null!");
        if (fieldNames == null || fieldNames.length == 0) {
            return criteria.list();
        }

        return listByCriteriaAndFieldNames(criteria, fieldNames);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<T> listByCriterion(Criterion criterion, Order[] orders, String... fieldNames) {
        Assert.notNull(criterion, "criterion is null!");
        Assert.notEmpty(orders, "orders is empty!");

        Criteria criteria = createCriteria().add(criterion);
        for (Order order : orders) {
            Assert.notNull(order, "order in orders is null!");
            criteria.addOrder(order);
        }

        return listByCriteria(criteria, fieldNames);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public <V> List<V> listFieldValueByFieldNameAndValue(String name, Object value
            , Order[] orders, String fieldName) {
        Assert.hasText(name, "name is empty!");
        Assert.notEmpty(orders, "orders is empty!");
        Assert.hasText(fieldName, "fieldName is empty!");

        return listFieldValueByCriterion(Restrictions.eq(name, value), orders, fieldName);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public <V> List<V> listFieldValueByFieldNameAndValue(String name, Object value, String fieldName) {
        Assert.hasText(name, "name is empty!");
        Assert.hasText(fieldName, "fieldName is empty!");

        return listFieldValueByCriterion(Restrictions.eq(name, value), fieldName);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public <V> List<V> listFieldValueByCriterion(Criterion criterion, Order[] orders, String fieldName) {
        Assert.notNull(criterion, "criterion is null!");
        Assert.notEmpty(orders, "orders is empty!");
        Assert.hasText(fieldName, "fieldName is empty!");

        Criteria criteria = createCriteria().add(criterion);
        for (Order order : orders) {
            Assert.notNull(order, "order in orders is null!");
            criteria.addOrder(order);
        }

        return listFieldValueByCriteria(criteria, fieldName);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public <V> List<V> listFieldValueByCriterion(Criterion criterion, String fieldName) {
        Assert.notNull(criterion, "criterion is null!");
        Assert.hasText(fieldName, "fieldName is empty!");

        Criteria criteria = createCriteria().add(criterion);
        return listFieldValueByCriteria(criteria, fieldName);
    }

    @Override
    @Transactional(readOnly = true)
    public <V> List<V> listFieldValueByCriteria(Criteria criteria, String fieldName) {
        Assert.notNull(criteria, "criteria is null!");
        Assert.hasText(fieldName, "fieldName is empty!");

        if (fieldName.contains(".")) {
            String alias = fieldName.substring(0, fieldName.indexOf("."));
            String subField = fieldName.substring(fieldName.indexOf(".") + 1);
            if (subField.contains(".")) {
                createAlias(criteria, alias, alias);
                alias = alias + "." + subField.substring(0, subField.indexOf("."));
                createAlias(criteria, alias, alias);
            } else if (!validPrimaryKey(alias, subField)) {
                createAlias(criteria, alias, alias);
            }
        }

        return (List<V>) criteria.setProjection(Projections.property(fieldName)).list();
    }

    protected List<T> listByCriteriaAndFieldNames(Criteria criteria, String[] fieldNames) {
        ProjectionList projectionList = Projections.projectionList();
        Map<String, Boolean> aliasMap = new HashMap<String, Boolean>();
        for (String fieldName : fieldNames) {
            Assert.hasText(fieldName, "fieldName is empty!");
            if (fieldName.contains(".")) {
                String alias = fieldName.substring(0, fieldName.indexOf("."));
                String subField = fieldName.substring(fieldName.indexOf(".") + 1);
                Assert.hasText(subField, "subField[" + fieldName + "] is empty!");
                if (subField.contains(".")) {
                    createAlias(criteria, alias, alias);
                    alias = alias + "." + subField.substring(0, subField.indexOf("."));
                    createAlias(criteria, alias, alias);
                } else if (!validPrimaryKey(alias, subField) && aliasMap.get(alias) == null) {
                    aliasMap.put(alias, true);
                    createAlias(criteria, alias, alias);
                }
            }

            projectionList.add(Projections.property(fieldName));
        }

        List<Object> list = criteria.setProjection(projectionList).list();
        if (list == null || list.size() == 0) {
            return new ArrayList<T>(0);
        }

        List<T> models = new ArrayList<T>(list.size());
        for (Object o : list) {
            T model = (T) ReflectUtil.createInstance(modelClass);
            Assert.notNull(model, "createInstance[class:" + modelClass + "] is failed!");
            if (o.getClass().isArray()) {
                Object[] objects = (Object[]) o;
                for (int i = 0; i < fieldNames.length; i++) {
                    Object value = objects[i];
                    if (value == null) {
                        continue;
                    }

                    setFieldValue(fieldNames[i], value, model);
                }
            } else {
                setFieldValue(fieldNames[0], o, model);
            }

            models.add(model);
        }

        return models;
    }

    private boolean createAlias(Criteria criteria, String path, String alias) {
        Iterator<CriteriaImpl.Subcriteria> iterator = ((CriteriaImpl) criteria).iterateSubcriteria();
        boolean exist = false;
        while (iterator.hasNext()) {
            CriteriaImpl.Subcriteria subCriteria = iterator.next();
            if (alias.equals(subCriteria.getAlias())) {
                exist = true;
                break;
            }
        }

        if (!exist) {
            criteria.createAlias(path, alias);
        }

        return !exist;
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int delete(String modelId) {
        Assert.hasText(modelId, "modelId is empty!");
        return delete(Collections.singletonList(modelId));
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int delete(List<String> modelIds) {
        Assert.notEmpty(modelIds, "modelIds is empty!");
        return baseService.delete(modelIds, modelClass);
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int delete(Criterion condition) {
        Assert.notNull(condition, "condition is null!");

        HqlBuilder builder = new HqlBuilder();
        builder.append(DELETE).append(FROM).append(getEntityName())
                .append(WHERE).append(toHqlBuilder(condition));

        return executeUpdate(builder);
    }

    @Override
    @Transactional(readOnly = true)
    public List<T> listByHQL(String hql, Object[] value) {
        Assert.hasText(hql, "hql is empty!");
        return baseService.find(hql, value);
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public List<String> batchSave(List<T> models) {
        Assert.notEmpty(models, "Models is empty!");
        return baseService.batchSave(models);
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public void batchSaveOrUpdate(List<T> models) {
        Assert.notEmpty(models, "Models is empty!");
        baseService.batchSaveOrUpdate(models);
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int updateByCriterion(Criterion condition, String fieldName, Object fieldValue) {
        Assert.hasText(fieldName, "fieldName is empty!");

        if (condition == null) {
            HqlBuilder builder = new HqlBuilder();
            builder.append(UPDATE).append(getEntityName()).append(SET)
                    .append(fieldName).append(EQUAL).append(QUESTION_MARK)
                    .append(COMMA).append(BaseModel.UPDATE_BY).append(EQUAL).append(QUESTION_MARK)
                    .append(COMMA).append(BaseModel.UPDATE_TIME).append(EQUAL).append(QUESTION_MARK);
            builder.addParameter(fieldValue).addParameter(ExecutionContext.getUserId())
                    .addParameter(new Date());
            return executeUpdate(builder);
        }

        T model = (T) ReflectUtil.createInstance(modelClass);
        Assert.notNull(model, "create instance[class:" + modelClass + "] failed!");
        setFieldValue(fieldName, fieldValue, model);
        return updateByCriterion(condition, model, fieldName);
    }

    private String[] getPersistPropertyNames() {
        return baseService.getHibernateTemplate().getSessionFactory()
                .getClassMetadata(modelClass).getPropertyNames();
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int updateByCriterion(Criterion condition, T model, String... fields) {
        Assert.notNull(condition, "condition is null!");
        Assert.notNull(model, "model is null!");

        model.setUpdateBy(ExecutionContext.getUserId());
        model.setUpdateTime(new Date());
        if (fields == null || fields.length == 0) {
            String[] propertyNames = getPersistPropertyNames();
            Set<String> properties = new HashSet<String>(propertyNames.length);
            Collections.addAll(properties, propertyNames);
            properties.remove(BaseModel.CORP_CODE);
            properties.remove(BaseModel.CREATE_BY);
            properties.remove(BaseModel.CREATE_TIME);
            fields = properties.toArray(new String[properties.size()]);
        } else {
            Set<String> properties = new HashSet<String>(fields.length + 2);
            Collections.addAll(properties, fields);
            properties.add(BaseModel.UPDATE_BY);
            properties.add(BaseModel.UPDATE_TIME);
            fields = properties.toArray(new String[properties.size()]);
        }

        HqlBuilder builder = new HqlBuilder();
        builder.append(UPDATE).append(getEntityName()).append(SET);
        builder.append(fields[0]).append(EQUAL).append(QUESTION_MARK);
        builder.addParameter(getFieldValue(fields[0], model));
        for (int i = 1; i < fields.length; i++) {
            builder.append(COMMA).append(fields[i]).append(EQUAL).append(QUESTION_MARK);
            builder.addParameter(getFieldValue(fields[i], model));
        }

        builder.append(WHERE).append(toHqlBuilder(condition));
        return executeUpdate(builder);
    }

    private int executeUpdate(HqlBuilder builder) {
        baseService.getSession().flush();
        Query query = baseService.getSession().createQuery(builder.toString());
        List<Object> parameterList = builder.getParameterList();
        for (int i = 0; i < parameterList.size(); i++) {
            query.setParameter(i, parameterList.get(i));
        }

        Map<String, Object> parameterMap = builder.getParameterMap();
        for (Map.Entry<String, Object> entry : parameterMap.entrySet()) {
            Object value = entry.getValue();
            String key = entry.getKey();
            if (value == null) {
                query.setParameter(key, null);
            } else if (value instanceof Collection) {
                query.setParameterList(key, (Collection) value);
            } else if (value.getClass().isArray()) {
                query.setParameterList(key, (Object[]) value);
            } else {
                query.setParameter(key, value);
            }
        }

        int execute = query.executeUpdate();
        baseService.getSession().clear();
        return execute;
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int incrByCriterion(Criterion condition, String fieldName, Object increment) {
        Assert.hasText(fieldName, "fieldName is empty!");
        Assert.notNull(increment, "increment is null!");

        if (condition == null) {
            HqlBuilder builder = new HqlBuilder();
            builder.append(UPDATE).append(getEntityName()).append(SET)
                    .append(fieldName).append(EQUAL)
                    .append(COALESCE).append(LEFT_BRACKET).append(fieldName).append(COMMA)
                    .append(ZERO).append(RIGHT_BRACKET).append(PLUS).append(QUESTION_MARK)
                    .append(COMMA).append(BaseModel.UPDATE_BY).append(EQUAL).append(QUESTION_MARK)
                    .append(COMMA).append(BaseModel.UPDATE_TIME).append(EQUAL).append(QUESTION_MARK);
            builder.addParameter(increment)
                    .addParameter(ExecutionContext.getUserId())
                    .addParameter(new Date());
            return executeUpdate(builder);
        }

        T model = (T) ReflectUtil.createInstance(modelClass);
        Assert.notNull(model, "create instance[class:" + modelClass + "] failed!");
        setFieldValue(fieldName, increment, model);
        return incrByCriterion(condition, model, new String[]{fieldName});
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int incrByCriterion(Criterion condition, T model, String[] incrFields, String... fields) {
        Assert.notNull(condition, "condition is null!");
        Assert.notNull(model, "model is null!");
        Assert.notEmpty(incrFields, "incrFields is empty!");

        model.setUpdateBy(ExecutionContext.getUserId());
        model.setUpdateTime(new Date());
        if (fields == null || fields.length == 0) {
            fields = new String[]{BaseModel.UPDATE_BY, BaseModel.UPDATE_TIME};
        } else {
            Set<String> properties = new HashSet<String>(fields.length + 2);
            Collections.addAll(properties, fields);
            properties.add(BaseModel.UPDATE_BY);
            properties.add(BaseModel.UPDATE_TIME);
            fields = properties.toArray(new String[properties.size()]);
        }

        HqlBuilder builder = new HqlBuilder();
        builder.append(UPDATE).append(getEntityName()).append(SET);
        builder.append(incrFields[0]).append(EQUAL)
                .append(COALESCE).append(LEFT_BRACKET).append(incrFields[0]).append(COMMA)
                .append(ZERO).append(RIGHT_BRACKET).append(PLUS).append(QUESTION_MARK);
        builder.addParameter(getFieldValue(incrFields[0], model));
        for (int i = 1; i < incrFields.length; i++) {
            builder.append(COMMA).append(incrFields[i]).append(EQUAL)
                    .append(COALESCE).append(LEFT_BRACKET).append(incrFields[i]).append(COMMA)
                    .append(ZERO).append(RIGHT_BRACKET).append(PLUS).append(QUESTION_MARK);
            builder.addParameter(getFieldValue(incrFields[i], model));
        }

        for (String field : fields) {
            builder.append(COMMA).append(field).append(EQUAL).append(QUESTION_MARK);
            builder.addParameter(getFieldValue(field, model));
        }


        builder.append(WHERE).append(toHqlBuilder(condition));
        return executeUpdate(builder);
    }

    private HqlBuilder toHqlBuilder(Criterion criterion) {
        HqlBuilder builder = new HqlBuilder();
        Criteria criteria = createCriteria();
        CriteriaQueryTranslator translator = new CriteriaQueryTranslator(
                (SessionFactoryImplementor) baseService.getHibernateTemplate().getSessionFactory(),
                (CriteriaImpl) criteria, getFullEntityName(), CriteriaQueryTranslator.ROOT_SQL_ALIAS);
        CriteriaQuery criteriaQuery = new PeCriteriaQuery(translator);
        String sqlString = criterion.toSqlString(criteria, criteriaQuery)
                .replace(CriteriaQueryTranslator.ROOT_SQL_ALIAS + BaseModel.POINT, StringUtils.EMPTY);
        builder.append(sqlString);
        TypedValue[] typedValues = criterion.getTypedValues(criteria, criteriaQuery);
        for (TypedValue typedValue : typedValues) {
            builder.addParameter(typedValue.getValue());
        }

        return builder;
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int incr(String modelId, String fieldName, Object increment) {
        Assert.hasText(modelId, "modelId is empty!");
        Assert.hasText(fieldName, "fieldName is empty!");
        Assert.notNull(increment, "increment is null!");

        List<String> modelIds = new ArrayList<String>(1);
        modelIds.add(modelId);
        return incr(modelIds, fieldName, increment);
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int incr(List<String> modelIds, String fieldName, Object increment) {
        Assert.notEmpty(modelIds, "modelIds is empty!");
        Assert.hasText(fieldName, "fieldName is empty!");
        Assert.notNull(increment, "increment is null!");

        return incrByCriterion(Restrictions.in(BaseModel.ID, modelIds), fieldName, increment);
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int incr(String modelId, T model, String[] incrFields, String... fields) {
        Assert.hasText(modelId, "modelId is empty!");
        Assert.notNull(model, "model is null!");
        Assert.notEmpty(incrFields, "incrFields is null!");

        List<String> modelIds = new ArrayList<String>(1);
        modelIds.add(modelId);
        return incr(modelIds, model, incrFields, fields);
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int incr(List<String> modelIds, T model, String[] incrFields, String... fields) {
        Assert.notEmpty(modelIds, "modelIds is null!");
        Assert.notNull(model, "model is null!");
        Assert.notEmpty(incrFields, "incrFields is empty!");

        return incrByCriterion(Restrictions.in(BaseModel.ID, modelIds), model, incrFields, fields);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public Page<T> search(PageParam pageParam, Criterion condition, Order... orders) {
        Assert.notNull(pageParam, "pageParam is null!");
        Assert.notNull(condition, "condition is null!");

        Page<T> page = new Page<>();
        if (pageParam.isAutoCount()) {
            Long count = getRowCountByCriterion(condition);
            if (count == null || count == 0L) {
                return page;
            }

            page.setTotal(count);
        }

        Criteria criteria = createCriteria().add(condition);
        String sortName = StringUtils.trim(pageParam.getSort());
        if (StringUtils.isNotEmpty(sortName)) {
            PageParam.SortOrder sortOrder = pageParam.getOrder();
            if (sortOrder == null || PageParam.SortOrder.asc.equals(sortOrder)) {
                criteria.addOrder(Order.asc(sortName));
            } else {
                criteria.addOrder(Order.desc(sortName));
            }
        } else if (orders != null && orders.length > 0) {
            for (Order order : orders) {
                criteria.addOrder(order);
            }
        } else {
            criteria.addOrder(Order.desc(BaseModel.CREATE_TIME));
        }

        if (pageParam.isAutoPaging()) {
            criteria.setFirstResult(pageParam.getStart())
                    .setMaxResults(pageParam.getPageSize());
        }

        page.setRows(criteria.list());
        return page;
    }

    @Override
    @Transactional(readOnly = true)
    public Page<T> search(PageParam pageParam, Criterion condition, Order[] orders, String... fields) {
        if (ArrayUtils.isEmpty(fields)) {
            return search(pageParam, condition, orders);
        }

        Page<T> page = new Page<>();
        if (pageParam.isAutoCount()) {
            Long count = getRowCountByCriterion(condition);
            if (count == null || count == 0L) {
                return page;
            }

            page.setTotal(count);
        }

        Criteria criteria = createCriteria().add(condition);
        String sortName = StringUtils.trim(pageParam.getSort());
        if (StringUtils.isNotEmpty(sortName)) {
            PageParam.SortOrder sortOrder = pageParam.getOrder();
            if (sortOrder == null || PageParam.SortOrder.asc.equals(sortOrder)) {
                criteria.addOrder(Order.asc(sortName));
            } else {
                criteria.addOrder(Order.desc(sortName));
            }
        } else if (orders != null && orders.length > 0) {
            for (Order order : orders) {
                criteria.addOrder(order);
            }
        } else {
            criteria.addOrder(Order.desc(BaseModel.CREATE_TIME));
        }

        if (pageParam.isAutoPaging()) {
            criteria.setFirstResult(pageParam.getStart())
                    .setMaxResults(pageParam.getPageSize());
        }

        List<T> rows = listByCriteriaAndFieldNames(criteria, fields);
        page.setRows(rows);
        return page;
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public Page<T> search(PageParam pageParam, Condition condition, Order... orders) {
        Assert.notNull(pageParam, "pageParam is null!");
        Assert.notNull(condition, "condition is null!");

        Page<T> page = new Page<>();
        if (pageParam.isAutoCount()) {
            Criteria criteria = createCriteria();
            condition.addCondition(criteria);
            Object count = getRowCountByCriteria(criteria);
            if (count == null || (Long) count == 0L) {
                return page;
            }

            page.setTotal((Long) count);
        }

        Criteria criteria = createCriteria();
        condition.addCondition(criteria);
        String sortName = StringUtils.trim(pageParam.getSort());
        if (StringUtils.isNotEmpty(sortName)) {
            PageParam.SortOrder sortOrder = pageParam.getOrder();
            if (sortOrder == null || PageParam.SortOrder.asc.equals(sortOrder)) {
                criteria.addOrder(Order.asc(sortName));
            } else {
                criteria.addOrder(Order.desc(sortName));
            }
        } else if (orders != null && orders.length > 0) {
            for (Order order : orders) {
                criteria.addOrder(order);
            }
        } else {
            criteria.addOrder(Order.desc(BaseModel.CREATE_TIME));
        }

        if (pageParam.isAutoPaging()) {
            criteria.setFirstResult(pageParam.getStart())
                    .setMaxResults(pageParam.getPageSize());
        }

        page.setRows(criteria.list());
        return page;
    }

    @Override
    @Transactional(readOnly = true)
    public Page<T> search(PageParam pageParam, Condition condition, Order[] orders, String... fields) {
        Assert.notNull(pageParam, "pageParam is null!");
        Assert.notNull(condition, "condition is null!");

        if (ArrayUtils.isEmpty(fields)) {
            return search(pageParam, condition, orders);
        }

        Page<T> page = new Page<>();
        if (pageParam.isAutoCount()) {
            Criteria criteria = createCriteria();
            condition.addCondition(criteria);
            Object count = getRowCountByCriteria(criteria);
            if (count == null || (Long) count == 0L) {
                return page;
            }

            page.setTotal((Long) count);
        }

        Criteria criteria = createCriteria();
        condition.addCondition(criteria);
        String sortName = StringUtils.trim(pageParam.getSort());
        if (StringUtils.isNotEmpty(sortName)) {
            PageParam.SortOrder sortOrder = pageParam.getOrder();
            if (sortOrder == null || PageParam.SortOrder.asc.equals(sortOrder)) {
                criteria.addOrder(Order.asc(sortName));
            } else {
                criteria.addOrder(Order.desc(sortName));
            }
        } else if (orders != null && orders.length > 0) {
            for (Order order : orders) {
                criteria.addOrder(order);
            }
        } else {
            criteria.addOrder(Order.desc(BaseModel.CREATE_TIME));
        }

        if (pageParam.isAutoPaging()) {
            criteria.setFirstResult(pageParam.getStart())
                    .setMaxResults(pageParam.getPageSize());
        }

        List<T> rows = listByCriteriaAndFieldNames(criteria, fields);
        page.setRows(rows);
        return page;
    }

    public NamedParameterJdbcTemplate getJdbcTemplate() {
        return new NamedParameterJdbcTemplate(baseService.getJdbcTemplate());
    }
}
