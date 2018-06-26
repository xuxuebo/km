package com.qgutech.km.module.km.controller;

import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.module.km.service.ShareService;
import com.qgutech.km.module.km.service.StatisticService;
import com.qgutech.km.utils.PeException;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Arrays;

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
        }catch (PeException e){
            jsonResult.setSuccess(false);
            jsonResult.setMessage(e.getMessage());
            return jsonResult;
        }
        return jsonResult;
    }
}
