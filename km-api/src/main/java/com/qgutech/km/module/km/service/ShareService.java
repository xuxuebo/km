package com.qgutech.km.module.km.service;

import com.qgutech.km.base.service.BaseService;
import com.qgutech.km.module.km.model.Knowledge;
import com.qgutech.km.module.km.model.Share;

import java.util.List;

/**
 * Created by Administrator on 2018/6/22.
 */
public interface ShareService extends BaseService<Share>{

    /**
     * 获取我的分享内容
     * @return
     */
    List<Knowledge> getMyShare();

    /**
     * 取消分享
     * @param id
     */
    void cancelShare(String id);

    List<Share> getByKnowledgeIds(List<String> knowledgeIds);
    //批量修改文件的下载次数
    int updateDownCount(String shareIds);
    //批量修改文件的复制次数
    int updateCopyCount(String shareIds);
}
