package com.qgutech.pe.base.service;

import com.qgutech.pe.base.model.Message;
import com.qgutech.pe.base.model.Page;
import com.qgutech.pe.base.model.PageParam;

import java.util.List;

public interface MessageService extends BaseService<Message> {
    /**
     * 个人中心的消息
     *
     * @param pageParam 分页条件
     * @return 具体列表数据如下：
     * <ul>
     * <li>{@linkplain Message#createTime 消息的建立时间}</li>
     * <li>{@linkplain Message#content  消息的内容}</li>
     * <li>{@linkplain Message#id 消息的id}<li/>
     * <li>{@linkplain Message#read  消息是否已读}</li>
     * </ul>
     * @since 2017年2月24日16:48:47 author LiuChen
     */
    Page<Message> search(PageParam pageParam);

    /**
     * 消息标记为已读
     *
     * @param messageIds 消息的Id集合
     * @return 改变行数
     * @since 2017年2月24日16:49:42 author LiuChen
     */
    int markReadMessage(List<String> messageIds);

    /**
     * 【计算未读数量】
     *
     * @param userId 学员ID
     * @return 数量
     * @since 2017-5-5 17:48:23
     */
    Long count(String userId);
}
