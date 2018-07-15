package com.qgutech.km.module.ems.controller;

import com.qgutech.km.base.service.CorpService;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.service.LibraryService;
import com.qgutech.km.module.sfm.service.FileServerService;
import com.qgutech.km.module.uc.model.SessionContext;
import com.qgutech.km.module.uc.model.User;
import com.qgutech.km.module.uc.service.UserRedisService;
import com.qgutech.km.module.uc.service.UserService;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.CorpInfo;
import com.qgutech.km.utils.PeDateUtils;
import com.qgutech.km.utils.PropertiesUtils;
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
    @Resource
    private LibraryService libraryService;


    //首页  我的云库
    @RequestMapping("index")
    public String index(Model model){
        model.addAttribute("userName", SessionContext.get().getUserName());
        model.addAttribute("admin", SessionContext.get().isAdmin());
        model.addAttribute("firstLevelLibrary",libraryService.getFirstLevelLibrary());
        model.addAttribute("downloadServerUrl", PropertiesUtils.getConfigProp().getProperty("download.server.url"));
        model.addAttribute("fsServerHost", PropertiesUtils.getConfigProp().getProperty("fs.server.host"));
        model.addAttribute("myLibrary",libraryService.getUserLibraryByLibraryType(KnowledgeConstant.MY_LIBRARY).getId());
        return "index/index";
    }

    //首页  设置
    @RequestMapping("adminSetting")
    public String adminSetting(Model model){
        model.addAttribute("userName", SessionContext.get().getUserName());
        model.addAttribute("admin", SessionContext.get().isAdmin());
        return "index/adminSetting";
    }

    //首页  数据可视化视图
    @RequestMapping("dataView")
    public String dataView(Model model){
        model.addAttribute("userName", SessionContext.get().getUserName());
        model.addAttribute("admin", SessionContext.get().isAdmin());
        return "index/dataView";
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
