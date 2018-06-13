package com.fp.cloud.module.ems.controller;

import com.fp.cloud.base.service.CorpService;
import com.fp.cloud.constant.PeConstant;
import com.fp.cloud.module.sfm.service.FileServerService;
import com.fp.cloud.module.uc.model.SessionContext;
import com.fp.cloud.module.uc.model.User;
import com.fp.cloud.module.uc.service.UserRedisService;
import com.fp.cloud.module.uc.service.UserService;
import com.fp.cloud.base.ExecutionContext;
import com.fp.cloud.base.model.CorpInfo;
import com.fp.cloud.utils.PeDateUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

/**
 * Created by Administrator on 19:03 2018/6/12.
 *  首页信息展示
 * @Description
 */
@Controller()
@RequestMapping("front")
public class FrontController {
    @Resource
    private UserRedisService userRedisService;
    @Resource
    private UserService userService;
    @Resource
    private FileServerService fileServerService;

    @Resource
    private CorpService corpService;
    /**
     * 学员端首页
     */
    @RequestMapping("initPage")
    public String initMyExamDynamic(Model model) {
        model.addAttribute("userName", SessionContext.get().getUserName());
        model.addAttribute("admin", SessionContext.get().isAdmin());
        return "myExamNav";
    }

    @RequestMapping("initBindMobile")
    public String initBindMobile(Model model) {
        User user = userRedisService.get(ExecutionContext.getUserId(), User._userName, User._roleType, User._mobile, User._loginName);
        if (StringUtils.isBlank(user.getMobile()) && !PeConstant.ADMIN.equals(user.getLoginName())) {
            return "uc/login/bindMobile";
        }

        return initMyExamDynamic(model);
    }

    @RequestMapping("manage/initPage")
    public String initMainPage(Model model) {
        model.addAttribute(User._userName, SessionContext.get().getUserName());
        CorpInfo corpInfo = corpService.getByCode(ExecutionContext.getCorpCode());
        model.addAttribute("corpInfo" , corpInfo);
        model.addAttribute("isShow","FALSE");
        if (corpInfo != null && corpInfo.getEndTime() != null && corpInfo.getVersion().equals(CorpInfo.CorpVersion.ENTERPRISE)){
            if (PeDateUtils.getDiffTime(corpInfo.getEndTime()) < 1){
                model.addAttribute("isShow","TRUE");
            }
        }
        return "topNav";
    }

    /**
     * 消息中心
     */
    @RequestMapping("initMyMessageCenter")
    public String initMyMessageCenter() {
        return "uc/login/messageCenter";
    }

    @RequestMapping("initMyPersonalCenter")
    public String initMyPersonalCenter(Model model) {
        User user = userService.get(ExecutionContext.getUserId());
        model.addAttribute("user", user);
        return "uc/login/PersonalCenter";
    }

    @RequestMapping("manage/manageIndex")
    public String manageIndex() {
        return "manageIndex";
    }
    @RequestMapping("manage/updateCorp")
    public String updateCorp(){
        return  "updateCorp";
    }
}
