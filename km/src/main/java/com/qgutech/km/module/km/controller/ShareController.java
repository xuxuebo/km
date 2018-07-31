package com.qgutech.km.module.km.controller;

import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.module.km.model.Share;
import com.qgutech.km.module.km.service.KnowledgeService;
import com.qgutech.km.module.km.service.ShareService;
import com.qgutech.km.module.km.service.StatisticService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2018/6/26.
 * 分享控制层
 */
@Controller
@RequestMapping("share")
public class ShareController {
    @Resource
    private ShareService shareService;
    @Resource
    private StatisticService statisticService;
    @Resource
    private KnowledgeService knowledgeService;

    @ResponseBody
    @RequestMapping("cancelShare")
    public JsonResult cancelShare(String shareIds){
        JsonResult jsonResult = new JsonResult();
        if(StringUtils.isEmpty(shareIds)){
            jsonResult.setSuccess(false);
            jsonResult.setMessage("请选择对象");
            return jsonResult;
        }
        try {
            shareService.cancelShare(shareIds);
            jsonResult.setSuccess(true);
        }catch (Exception e){
            jsonResult.setSuccess(false);
            jsonResult.setMessage(e.getMessage());
            return jsonResult;
        }
        return jsonResult;
    }

    @ResponseBody
    @RequestMapping("shareToOrg")
    public JsonResult shareToOrg(Share share) {
        JsonResult jsonResult = new JsonResult();
        List<String> libraryIds = share.getLibraryIds();
        if (CollectionUtils.isEmpty(libraryIds)) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("分享失败");
            return jsonResult;
        }

        List<String> knowledgeIds = share.getKnowledgeIds();
        if (CollectionUtils.isEmpty(knowledgeIds)) {
            jsonResult.setSuccess(false);
            jsonResult.setMessage("分享失败");
            return jsonResult;
        }

        try {
            knowledgeService.shareToOrg(share);
            jsonResult.setMessage("分享成功");
        } catch (Exception e) {
            e.printStackTrace();
            jsonResult.setSuccess(false);
            jsonResult.setMessage("分享失败");
        }

        return jsonResult;
    }
}
