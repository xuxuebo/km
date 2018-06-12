package com.qgutech.pe.module.youmeng;

import com.qgutech.pe.module.youmeng.android.AndroidCustomizedcast;

/**
 * @author: xiaolong@hf
 * @since: 2018/5/9 9:12
 */

public interface YouMengService {
    /**
     * 给安卓推送消息
     * @return
     * @throws Exception
     */
    boolean sendAndroidBroadcast(Notification notification) throws Exception;

    /**
     * 通过文件推送消息
     * @param notification
     * @return
     * @throws Exception
     */
    boolean sendAndroidBroadcastByFile(Notification notification) throws Exception;

    /**
     * 给ios推送消息
     * @param notification 消息实体类
     * @return
     * @throws Exception
     */
    boolean sendIOSCustomizedcast(Notification notification) throws Exception;

    /**
     * 通过文件上传消息
     * @param notification
     * @return
     * @throws Exception
     */
    boolean sendIOSCustomizedcastByFile(Notification notification) throws Exception;

    /**
     * 根据考试id 给所有考生推送消息，当前消息类型为：考试前半小时推送;
     * @param examId 考试id
     * @return
     * @throws Exception
     */
    boolean sendExamMessage(String examId) throws Exception;


}
