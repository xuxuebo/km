package com.qgutech.km.base.controller;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.redis.PeRedisClient;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.constant.RedisKey;
import com.qgutech.km.module.uc.model.SessionContext;
import com.qgutech.km.utils.PropertiesUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 运营平台控制层
 */
@Controller
@RequestMapping("bg")
public class BackGroundController {


    @RequestMapping("manage/initBackGround")
    public String initBackGround(Model model) {
        if (PeConstant.DEFAULT_CORP_CODE.equals(ExecutionContext.getCorpCode()) && SessionContext.get().isSystemAdmin()) {
            String resourceVersion = PeRedisClient.getCommonJedis().get(RedisKey.STATIC_RESOURCE_VERSION);
            if (StringUtils.isBlank(resourceVersion)) {
                resourceVersion = PropertiesUtils.getConfigProp().getProperty("static.resource.version");
            }

            model.addAttribute("resourceVersion", resourceVersion);
            return "background/index";
        }

        return null;
    }

    @ResponseBody
    @RequestMapping("manage/saveVersion")
    public JsonResult<String> saveVersion(String version) {
        if (StringUtils.isBlank(version)) {
            return new JsonResult<>(false, JsonResult.FAILED, "请输入版本号保存");
        }

        PeRedisClient.getCommonJedis().set(RedisKey.STATIC_RESOURCE_VERSION, version);
        PropertiesUtils.getConfigProp().setProperty("static.resource.version", version);
        return new JsonResult<>(true, JsonResult.SUCCESS);
    }

    @ResponseBody
    @RequestMapping("manage/getExamResult")
    public String getExamResult(String userId, String examId) {
        return PeRedisClient.getEmsJedis().hget(RedisKey.EXAM_USER_MARKING + PeConstant.REDIS_DIVISION + examId, userId);
    }

}
