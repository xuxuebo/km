package com.fp.cloud.base.service;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.metadata.ClassMetadata;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

@Repository
public class HibernateDao {
    private HibernateTemplate hibernateTemplate;

    @Autowired
    public HibernateDao(SessionFactory sessionFactory) {
        this.hibernateTemplate = new HibernateTemplate(sessionFactory);
    }

    public HibernateDao() {
    }

    public Session getSession() {
        return hibernateTemplate.getSessionFactory().getCurrentSession();
    }

    public HibernateTemplate getHibernateTemplate() {
        return hibernateTemplate;
    }

    @Resource
    private JdbcTemplate jdbcTemplate;

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public int countRecordsNumber(DetachedCriteria dc, String countDistinctProjections) {
        dc.setProjection(Projections.countDistinct(countDistinctProjections));
        List list = this.getHibernateTemplate().findByCriteria(dc);
        int result = 0;
        for (Object aList : list) {
            Integer item = Integer.parseInt(aList + "");
            result += item;
        }

        dc.setProjection(null);// 避免对dc.setProjection影响到其它地方
        return result;
    }

    public List findByCriteria(DetachedCriteria dc, int... firstResultAndMaxResults) {
        dc.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);

        if (firstResultAndMaxResults != null && firstResultAndMaxResults.length == 2) {
            return this.getHibernateTemplate().findByCriteria(dc, firstResultAndMaxResults[0],
                    firstResultAndMaxResults[1]);
        }

        return getHibernateTemplate().findByCriteria(dc);
    }

    public List findByCriteria(DetachedCriteria dc) {
        dc.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        return getHibernateTemplate().findByCriteria(dc);
    }

    /**
     * 求传入的QBC查询总记录条数
     *
     * @param criteria QBC对象
     * @return
     */
    public int getTotalSizeForCriteria(DetachedCriteria criteria) {
        // 获取根据条件分页查询的总行数
        int totalSize = 0;
        criteria.setProjection(Projections.rowCount());
        List list = this.findByCriteria(criteria);
        if (list.isEmpty()) {
            return totalSize;
        } else {
            totalSize = Integer.parseInt(list.get(0).toString());
        }

        criteria.setProjection(null);// 清除count函数
        return totalSize;
    }

    /**
     * 使用HSQL语句检索数据
     *
     * @param queryString
     * @return
     */
    public List find(String queryString) {
        Query query = this.getSession().createQuery(queryString);
        return query.list();
    }

    /**
     * 使用带参数的HSQL语句检索数据
     *
     * @param queryString
     * @param value
     * @return
     */
    public List find(String queryString, Object value) {
        Query query = this.getSession().createQuery(queryString);
        query.setParameter(0, value);
        return query.list();
    }


    /**
     * 使用带参数的HSQL语句检索数据
     *
     * @param queryString
     * @param value
     * @return
     */
    @Transactional(readOnly = true)
    public List find(String queryString, Object[] value) {
        Query query = this.getSession().createQuery(queryString);
        if (value != null) {
            for (int i = 0; i < value.length; i++) {
                query.setParameter(i, value[i]);
            }
        }

        return query.list();
    }

    /**
     * 使用HSQL语句直接增加、更新、删除实体
     *
     * @param queryString
     * @param values
     * @return
     */
    public int bulkUpdate(String queryString, Object[] values) {
        return getHibernateTemplate().bulkUpdate(queryString, values);
    }

    public <T> T get(Class<T> entityClass, Serializable id) {
        return (T) this.getSession().get(entityClass, id);
    }

    @Transactional
    public <T> T load(Class<T> entityClass, Serializable id) {
        return (T) this.getSession().load(entityClass, id);
    }

    public <T> T merge(T model) {
        return (T) this.getSession().merge(model);
    }

    public void saveOrUpdate(Object model) {
        this.getSession().saveOrUpdate(model);
    }

    public String save(Object model) {
        return (String) this.getSession().save(model);
    }

    public <T> List<String> batchSave(List<T> models) {
        List<String> modelIds = new ArrayList<String>(models.size());
        Session session = this.getSession();
        for (int i = 0; i < models.size(); i++) {
            Object model = models.get(i);
            String modelId = (String) session.save(model);
            modelIds.add(modelId);
            if (i % 100 == 0) {
                session.flush();
                session.clear();
            }
        }

        return modelIds;
    }

    public <T> void batchSaveOrUpdate(List<T> models) {
        Session session = this.getSession();
        for (int i = 0; i < models.size(); i++) {
            Object model = models.get(i);
            session.saveOrUpdate(model);
            if (i % 100 == 0) {
                session.flush();
                session.clear();
            }
        }
    }

    public <T> void delete(Class<T> entityClass, Serializable id) {
        this.getSession().delete(get(entityClass, id));
    }

    public <T> void delete(T entity) {
        this.getSession().delete(entity);
    }

    public void flush() {
        this.getSession().flush();
    }

    public void clean() {
        this.getSession().clear();
    }

    public void update(Object model) {
        this.getSession().update(model);
    }

    /**
     * 查询某列的最大值id
     *
     * @param criteria QBC对象
     * @return
     */
    public int getMaxIdForCriteria(DetachedCriteria criteria, String propertyName) {
        int maxSize = 0;
        criteria.setProjection(Projections.max(propertyName));
        List list = new ArrayList();
        list = this.findByCriteria(criteria);
        if (list.isEmpty()) {
            return maxSize;
        } else {
            if (list.get(0) == null) {
                return maxSize;
            } else {
                maxSize = Integer.parseInt(list.get(0).toString());
            }
        }
        criteria.setProjection(null);// 清除count函数
        return maxSize;
    }
    //TODO ADD JdbcTemplate

    /**
     * <根据HQL语句查找唯一实体>
     *
     * @param hqlString HQL语句
     * @param values    不定参数的Object数组
     * @return 查询实体
     */
    public <T> T getByHQL(String hqlString, Object... values) {
        Query query = this.getSession().createQuery(hqlString);
        if (values != null) {
            for (int i = 0; i < values.length; i++) {
                query.setParameter(i, values[i]);
            }
        }

        return (T) query.uniqueResult();
    }

    /**
     * <根据HQL语句查找唯一实体>
     *
     * @param hqlString HQL语句
     * @return 查询实体
     */
    public <T> T getByHQL(String hqlString) {
        Query query = this.getSession().createQuery(hqlString);
        return (T) query.uniqueResult();
    }

    /**
     * <根据SQL语句查找唯一实体>
     *
     * @param sqlString SQL语句
     * @param values    不定参数的Object数组
     * @return 查询实体
     */
    public <T> T getBySQL(String sqlString, Object... values) {
        Query query = this.getSession().createSQLQuery(sqlString);
        if (values != null) {
            for (int i = 0; i < values.length; i++) {
                query.setParameter(i, values[i]);
            }
        }
        return (T) query.uniqueResult();
    }

    /**
     * <根据HQL得到记录数>
     *
     * @param hql    HQL语句
     * @param values 不定参数的Object数组
     * @return 记录总数
     */
    public <T> T countByHql(String hql, Object... values) {
        Query query = this.getSession().createQuery(hql);
        if (values != null) {
            for (int i = 0; i < values.length; i++) {
                query.setParameter(i, values[i]);
            }
        }
        return (T) query.uniqueResult();
    }

    /**
     * 查询一组数据
     *
     * @param hqlBuilder hqlBuilder
     * @return 查询结果列表
     */
    public <T> List<T> queryList(HqlBuilder hqlBuilder) {
        Query query = this.getSession().createQuery(hqlBuilder.getSql());
        setParameter(hqlBuilder, query);
        return query.list();
    }

    /**
     * 查询单个数据
     *
     * @param hqlBuilder hqlBuilder
     * @return 查询结果
     */
    public <T> T queryUniqueResult(HqlBuilder hqlBuilder) {
        Query query = this.getSession().createQuery(hqlBuilder.getSql());
        setParameter(hqlBuilder, query);
        return (T) query.uniqueResult();
    }

    /**
     * 执行更新的hql
     *
     * @param hqlBuilder hqlBuilder
     * @return 返回更新数据的条数
     */
    public int executeUpdate(HqlBuilder hqlBuilder) {
        Query query = this.getSession().createQuery(hqlBuilder.getSql());
        setParameter(hqlBuilder, query);
        return query.executeUpdate();
    }

    /**
     * 设置hqlBuilder的参数
     */
    private void setParameter(HqlBuilder hqlBuilder, Query query) {
        List<Object> parameterList = hqlBuilder.getParameterList();
        if (CollectionUtils.isNotEmpty(parameterList)) {
            for (int i = 0; i < parameterList.size(); i++) {
                Object obj = parameterList.get(i);
                query.setParameter(i, obj);
            }
        }

        Map<String, Object> parameterMap = hqlBuilder.getParameterMap();
        if (MapUtils.isNotEmpty(parameterMap)) {
            for (Map.Entry<String, Object> entry : parameterMap.entrySet()) {
                String placeHolder = entry.getKey();
                Object paramValue = entry.getValue();
                if (paramValue instanceof Collection) {
                    query.setParameterList(placeHolder, (Collection) paramValue);
                } else {
                    query.setParameter(placeHolder, paramValue);
                }
            }
        }

        Integer firstRecordIndex = hqlBuilder.getFirstRecordIndex();
        if (firstRecordIndex != null && firstRecordIndex >= 0) {
            query.setFirstResult(firstRecordIndex);
        }

        Integer maxRecordNum = hqlBuilder.getMaxRecordNum();
        if (maxRecordNum != null && maxRecordNum > 0) {
            query.setMaxResults(maxRecordNum);
        }
    }

    /**
     * 根据主键id列表批量删除一组数据
     *
     * @param modelIds 主键列表
     * @param clazz    class对象
     * @return 删除数据的条数
     */
    public int delete(List<String> modelIds, Class clazz) {
        ClassMetadata classMetadata = hibernateTemplate.getSessionFactory().getClassMetadata(clazz);
        String idPropertyName = classMetadata.getIdentifierPropertyName();
        HqlBuilder batchDeleteBuilder = new HqlBuilder();
        batchDeleteBuilder.append("delete from " + clazz.getSimpleName());
        batchDeleteBuilder.append("where " + idPropertyName + " in (:modelIds)");
        batchDeleteBuilder.addParameter("modelIds", modelIds);
        return executeUpdate(batchDeleteBuilder);
    }

    /**
     * <使用SQL查询所需指定类型的结果>
     *
     * @param sqlBuilder sql对象
     * @param entryClass 需要返回的类对象
     * @param <T>        泛型
     * @return 查询结果
     */
    public <T> List<T> queryBySQL(SqlBuilder sqlBuilder, Class<T> entryClass) {
        return new NamedParameterJdbcTemplate(getJdbcTemplate().getDataSource())
                .queryForList(sqlBuilder.getSql(), sqlBuilder.getParameterMap(), entryClass);
    }

    /**
     * <使用SQL查询所需指定实体类型的结果>
     *
     * @param sqlBuilder sql对象
     * @param entryClass 需要返回的类对象
     * @param <T>        泛型
     * @return 查询结果
     */
    public <T> List<T> queryModelBySQL(SqlBuilder sqlBuilder, Class<T> entryClass) {
        return new NamedParameterJdbcTemplate(getJdbcTemplate().getDataSource())
                .query(sqlBuilder.getSql(), sqlBuilder.getParameterMap(), BeanPropertyRowMapper.newInstance(entryClass));
    }

    /**
     * <使用SQL查询所需指定实体类型的结果>
     *
     * @param sqlBuilder sql对象
     * @return 查询结果
     */
    public List<Map<String, Object>> queryBySQL(SqlBuilder sqlBuilder) {
        return new NamedParameterJdbcTemplate(getJdbcTemplate().getDataSource()).queryForList(sqlBuilder.getSql(), sqlBuilder.getParameterMap());
    }

    /**
     * <使用SQL查询所需指定实体类型的结果>
     *
     * @param sqlBuilder sql对象
     * @return 查询结果
     */
    public Map<String, Object> queryForMap(SqlBuilder sqlBuilder) {
        return new NamedParameterJdbcTemplate(getJdbcTemplate().getDataSource()).queryForMap(sqlBuilder.getSql(), sqlBuilder.getParameterMap());
    }

    /**
     * 批量保存实体方法
     *
     * @param entities:实体列表
     * @param <T>:泛型
     */
    public <T> void saveOrUpdateEntityList(List<T> entities) {
        for (T t : entities) {
            saveOrUpdate(t);
        }
    }
}