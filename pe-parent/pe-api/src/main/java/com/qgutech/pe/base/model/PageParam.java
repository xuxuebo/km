package com.qgutech.pe.base.model;

import org.hibernate.criterion.Order;

public class PageParam {
    public enum SortOrder {
        asc, desc
    }

    /**
     * 起始页
     */
    protected int start = 1;

    /**
     * 第几页
     */
    protected int page = 0;

    /**
     * 每页显示行数
     */
    protected int pageSize = 10;

    /**
     * 排序字段
     */
    protected String sort;

    /**
     * 排序字段
     */
    protected SortOrder order;

    /**
     * 是否自动统计总条数
     */
    protected boolean autoCount = true;

    /**
     * 是否自动分页
     */
    protected boolean autoPaging = true;

    public int getStart() {
        return (this.page - 1) * this.pageSize;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
        this.start = (this.page - 1) * this.pageSize;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int rows) {
        this.pageSize = rows;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public SortOrder getOrder() {
        return order;
    }

    public void setOrder(SortOrder order) {
        this.order = order;
    }

    public boolean isAutoCount() {
        return autoCount;
    }

    public void setAutoCount(boolean autoCount) {
        this.autoCount = autoCount;
    }

    public boolean isAutoPaging() {
        return autoPaging;
    }

    public void setAutoPaging(boolean autoPaging) {
        this.autoPaging = autoPaging;
    }

    /**
     * 通过分页参数获取排序信息
     *
     * @return order
     * @since 2016年11月9日08:58:27
     */
    public Order getHibernateOrder() {
        if (sort == null || sort.length() <= 0) {
            return null;
        }


        if (order == null || SortOrder.asc.equals(order)) {
            return Order.asc(sort);
        }

        return Order.desc(sort);
    }
}
