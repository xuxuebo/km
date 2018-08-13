package com.qgutech.km.module.ems.controller;

import com.qgutech.km.base.service.CorpService;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.Library;
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
    @RequestMapping("/index")
    public String index(Model model) {
        model.addAttribute("userName", SessionContext.get().getUserName());
        model.addAttribute("admin", SessionContext.get().isAdmin());
        model.addAttribute("CNKI", PropertiesUtils.getConfigProp().getProperty("zhy.cnki"));
        model.addAttribute("FULLTEXT", PropertiesUtils.getConfigProp().getProperty("zhy.full.text"));
        return "index/index";
    }

    @RequestMapping("loadIndex")
    public String loadIndex(Model model){
        model.addAttribute("userName", SessionContext.get().getUserName());
        model.addAttribute("admin", SessionContext.get().isAdmin());
        model.addAttribute("firstLevelLibrary",libraryService.getFirstLevelLibrary());
        model.addAttribute("downloadServerUrl", PropertiesUtils.getConfigProp().getProperty("download.server.url"));
        model.addAttribute("fsServerHost", PropertiesUtils.getConfigProp().getProperty("fs.server.host"));
        model.addAttribute("myLibrary",libraryService.getUserLibraryByLibraryType(KnowledgeConstant.MY_LIBRARY).getId());
        return "index/loadIndex";
    }
    //首页  专业分类
    @RequestMapping("specialty")
    public String specialty(Model model){
        model.addAttribute("userName", SessionContext.get().getUserName());
        model.addAttribute("admin", SessionContext.get().isAdmin());
        return "index/specialty";
    }

    //首页  专业分类详情
    @RequestMapping("specialtyDetail")
    public String specialtyDetail(Model model, String libraryId){
        model.addAttribute("userName", SessionContext.get().getUserName());
        model.addAttribute("admin", SessionContext.get().isAdmin());
        model.addAttribute("libraryId", libraryId);
        Library library = libraryService.get(libraryId);
        model.addAttribute("libraryName", library.getLibraryName());
        return "index/specialtyDetail";
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

    //首页  数据统计
    @RequestMapping("dataStatistics")
    public String dataStatistics(Model model){
        model.addAttribute("userName", SessionContext.get().getUserName());
        model.addAttribute("admin", SessionContext.get().isAdmin());
        return "index/dataStatistics";
    }
    //首页  重点项目
    @RequestMapping("majorProject")
    public String majorProject(Model model){
        model.addAttribute("userName", SessionContext.get().getUserName());
        model.addAttribute("admin", SessionContext.get().isAdmin());
        return "index/majorProject";
    }
    //首页  重点项目 查看更多
    @RequestMapping("fileList")
    public String fileList(Model model,String libraryId,String type){
        model.addAttribute("userName", SessionContext.get().getUserName());
        model.addAttribute("admin", SessionContext.get().isAdmin());
        model.addAttribute("libraryId", libraryId);
        model.addAttribute("type", type);
        return "index/fileList";
    }
    //首页  重点项目 项目详情
    @RequestMapping("projectDetail")
    public String projectDetail(Model model,String libraryId){
        model.addAttribute("userName", SessionContext.get().getUserName());
        model.addAttribute("admin", SessionContext.get().isAdmin());
        model.addAttribute("libraryId", libraryId);
        return "index/projectDetail";
    }
    // 首页 重点项目 查看全文
    @RequestMapping("projectIntroduction")
    public String projectIntroduction(Model model,String libraryId){
        model.addAttribute("userName", SessionContext.get().getUserName());
        model.addAttribute("admin", SessionContext.get().isAdmin());
        model.addAttribute("libraryId", libraryId);
        model.addAttribute("library", libraryService.getLibraryAndDetail(libraryId));
        return "index/projectIntroduction";
    }
    //首页  我的云库
    @RequestMapping("publicLibrary")
    public String publicLibrary(Model model){
        model.addAttribute("userName", SessionContext.get().getUserName());
        model.addAttribute("admin", SessionContext.get().isAdmin());
        return "index/publicLibrary";
    }

    //首页  分享
    @RequestMapping("dataShare")
    public String dataShare(Model model){
        model.addAttribute("userName", SessionContext.get().getUserName());
        model.addAttribute("admin", SessionContext.get().isAdmin());
        return "index/dataShare";
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
