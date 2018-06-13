package com.fp.cloud.base.model;

import java.util.ArrayList;
import java.util.List;

/**
 * 与具体ORM实现无关的分页参数及查询结果封装.
 * <p/>
 * 注意所有序号从1开始.
 *
 * @param <T> Page中记录的类型.
 * @author ELF@TEAM
 * @since 2016年2月29日 09:57:44
 */
public class Page<T> {
    //-- 公共变量 --//
    public static final String ASC = "asc";
    public static final String DESC = "desc";

    //-- 分页参数 --//
    protected int start = 1;
    protected int pageSize = 10;
    private int page = 0;

    /**
     * 是否自动统计总条数
     */
    protected boolean autoCount = true;
    /**
     * 是否自动分页
     */
    protected boolean autoPaging = true;

    //--排序参数--//
    /**
     * 排序字段名称
     */
    private String sort;
    /**
     * 排序方向
     */
    private String order;

    //-- 返回结果 --//
    protected List<T> rows = new ArrayList<T>();
    protected long total = 0;

    //-- 构造函数 --//
    public Page() {
    }

    public Page(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    //-- 分页参数访问函数 --//

    /**
     * 获得当前页的页号,序号从1开始,默认为1.
     */
    public int getStart() {
        return start;
    }

    /**
     * 设置当前页的页号,序号从1开始,低于1时自动调整为1.
     */
    public void setStart(final int start) {
        this.start = start;

        if (start < 1) {
            this.start = 1;
        }
    }

    /**
     * 获得每页的记录数量, 默认为10.
     */
    public int getPageSize() {
        return pageSize;
    }

    /**
     * 设置每页的记录数量.
     */
    public void setPageSize(final int pageSize) {
        this.pageSize = pageSize;
    }

    /**
     * 根据pageNo和pageSize计算当前页第一条记录在总结果集中的位置,序号从1开始.
     */
    public int getFirst() {
        return ((start - 1) * pageSize) + 1;
    }

    /**
     * 获得查询对象时是否先自动执行count查询获取总记录数, 默认为false.
     */
    public boolean isAutoCount() {
        return autoCount;
    }

    /**
     * 设置查询对象时是否自动先执行count查询获取总记录数.
     */
    public void setAutoCount(final boolean autoCount) {
        this.autoCount = autoCount;
    }

    /**
     * 返回Page对象自身的setAutoCount函数,可用于连续设置。
     */
    public Page<T> autoCount(final boolean theAutoCount) {
        setAutoCount(theAutoCount);
        return this;
    }

    //-- 访问查询结果函数 --//

    /**
     * 获得页内的记录列表.
     */
    public List<T> getRows() {
        return rows;
    }

    /**
     * 设置页内的记录列表.
     */
    public void setRows(final List<T> result) {
        this.rows = result;
    }

    /**
     * 获得总记录数, 默认值为0.
     */
    public long getTotal() {
        return total;
    }

    /**
     * 设置总记录数.
     */
    public void setTotal(final long totalCount) {
        this.total = totalCount;
    }

    /**
     * 根据pageSize与totalCount计算总页数, 默认值为-1.
     */
    public long getTotalPages() {
        long count = total / pageSize;
        if (total % pageSize > 0) {
            count++;
        }
        return count;
    }

    /**
     * 是否还有下一页.
     */
    public boolean isHasNext() {
        return (start + 1 <= getTotalPages());
    }

    /**
     * 取得下页的页号, 序号从1开始.
     * 当前页为尾页时仍返回尾页序号.
     */
    public int getNextPage() {
        if (isHasNext()) {
            return start + 1;
        } else {
            return start;
        }
    }

    /**
     * 是否还有上一页.
     */
    public boolean isHasPre() {
        return (start - 1 >= 1);
    }

    /**
     * 取得上页的页号, 序号从1开始.
     * 当前页为首页时返回首页序号.
     */
    public int getPrePage() {
        if (isHasPre()) {
            return start - 1;
        } else {
            return start;
        }
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    public boolean isAutoPaging() {
        return autoPaging;
    }

    public void setAutoPaging(boolean autoPaging) {
        this.autoPaging = autoPaging;
    }

    @Override
    public String toString() {
        return "Page{" +
                "total=" + total +
                ", start=" + start +
                ", pageSize=" + pageSize +
                ", autoCount=" + autoCount +
                ", sort='" + sort + '\'' +
                ", order='" + order + '\'' +
                '}';
    }
}
