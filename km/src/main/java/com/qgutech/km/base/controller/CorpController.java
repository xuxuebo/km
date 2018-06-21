package com.qgutech.km.base.controller;

import com.qgutech.km.base.service.CorpService;
import com.qgutech.km.base.model.CorpInfo;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.utils.PeDateUtils;
import com.qgutech.km.utils.PeException;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("corp")
public class CorpController {

    @Resource
    private CorpService corpService;

    @RequestMapping("manage/initPage")
    public String initPage() {
        return "base/corpManage";
    }

    @RequestMapping("manage/initEditPage")
    public String initEditPage(String corpId, Model model) {
        if (StringUtils.isNotBlank(corpId)) {
            CorpInfo corpInfo = corpService.get(corpId);
            model.addAttribute("corpInfo", corpInfo);
        }

        return "base/addCorpInfo";
    }

    @RequestMapping("manage/initViewPage")
    public String initViewPage(String corpId, Model model) {
        CorpInfo corpInfo = corpService.get(corpId);
        if (StringUtils.isNotBlank(corpInfo.getPayApps())) {
            String payApp = processPayApps(corpInfo.getPayApps());
            corpInfo.setPayApps(payApp);
        }

        model.addAttribute("corpInfo", corpInfo);
        return "base/viewCorpInfo";
    }

    private String processPayApps(String payAppStr) {
        List<String> appList = new ArrayList<>();
        if (payAppStr.contains(CorpInfo.PayApps.APPLICATION.toString())) {
            appList.add(CorpInfo.PayApps.APPLICATION.getText());
        }

        if (payAppStr.contains(CorpInfo.PayApps.CERTIFICATE.toString())) {
            appList.add(CorpInfo.PayApps.CERTIFICATE.getText());
        }

        if (payAppStr.contains(CorpInfo.PayApps.EXAMROOM.toString())) {
            appList.add(CorpInfo.PayApps.EXAMROOM.getText());
        }

        if (payAppStr.contains(CorpInfo.PayApps.REMOTEMONITOR.toString())) {
            appList.add(CorpInfo.PayApps.REMOTEMONITOR.getText());
        }

        if (payAppStr.contains(CorpInfo.PayApps.TICKET.toString())) {
            appList.add(CorpInfo.PayApps.TICKET.getText());
        }

        if (CollectionUtils.isEmpty(appList)) {
            return null;
        }

        return StringUtils.join(appList, PeConstant.COMMA);
    }

    @ResponseBody
    @RequestMapping("manage/checkDomainName")
    public JsonResult<CorpInfo> checkDomainName(String domainName, String corpId) {
        CorpInfo corpInfo = corpService.checkDomainName(domainName);
        if (corpInfo == null || corpInfo.getId().equals(corpId)) {
            return new JsonResult<>(true, JsonResult.SUCCESS);
        }

        return new JsonResult<>(false, JsonResult.FAILED);
    }

    @ResponseBody
    @RequestMapping("manage/checkCorpCode")
    public JsonResult<CorpInfo> checkCorpCode(String corpCode, String corpId) {
        CorpInfo corpInfo = corpService.checkCorpCode(corpCode);
        if (corpInfo == null || corpInfo.getId().equals(corpId)) {
            return new JsonResult<>(true, JsonResult.SUCCESS);
        }

        return new JsonResult<>(false, JsonResult.FAILED);
    }

    @ResponseBody
    @RequestMapping("manage/save")
    public JsonResult<CorpInfo> save(CorpInfo corpInfo) {
        try {
            if (StringUtils.isNotBlank(corpInfo.getPayApps())) {
                String payAppStr = corpInfo.getPayApps();
                payAppStr = payAppStr.endsWith(PeConstant.COMMA) ? payAppStr.substring(0, payAppStr.length() - 1) : payAppStr;
                corpInfo.setPayApps(payAppStr);
            }
            if(corpInfo.getEndTime() != null){
                corpInfo.setEndTime(PeDateUtils.weeHours(corpInfo.getEndTime(),1));
            }

            if (StringUtils.isBlank(corpInfo.getId())) {
                corpService.save(corpInfo);
            } else {
                if(CorpInfo.CorpVersion.FREE.equals(corpInfo.getVersion())){
                    corpInfo.setEndTime(null);
                }
                corpService.update(corpInfo);
            }

            return new JsonResult<>(true, JsonResult.SUCCESS);
        } catch (PeException e) {
            return new JsonResult<>(false, e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping("manage/search")
    public Page<CorpInfo> search(PageParam pageParam, CorpInfo corpInfo) {
        return corpService.search(pageParam, corpInfo);
    }

    @ResponseBody
    @RequestMapping("manage/enableCorp")
    public JsonResult<CorpInfo> enableCorp(String corpId) {
        if (StringUtils.isBlank(corpId)) {
            throw new IllegalArgumentException("corpId is null when synchronize corp");
        }

        CorpInfo corpInfo = corpService.get(corpId, CorpInfo._id, CorpInfo._fromAppType);
        if (corpInfo == null) {
            throw new IllegalArgumentException("corpInfo doesn't exist in DB!");
        }

        if (corpInfo.getFromAppType() == null || CorpInfo.FromAppType.PE.equals(corpInfo.getFromAppType())) {
            corpService.enableCorp(corpId);
        }

        if (CorpInfo.FromAppType.ELP.equals(corpInfo.getFromAppType())) {
            corpService.openCorpForElp(corpInfo);
        }

        return new JsonResult<>(true, JsonResult.SUCCESS);
    }

    @ResponseBody
    @RequestMapping("manage/disableCorp")
    public JsonResult<CorpInfo> disableCorp(String corpId) {
        corpService.disableCorp(corpId);
        return new JsonResult<>(true, JsonResult.SUCCESS);
    }
}
