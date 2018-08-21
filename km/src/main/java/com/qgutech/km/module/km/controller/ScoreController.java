package com.qgutech.km.module.km.controller;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.module.km.model.ScoreDetail;
import com.qgutech.km.module.km.model.ScoreRule;
import com.qgutech.km.module.km.service.ScoreDetailService;
import com.qgutech.km.module.km.service.ScoreRuleService;
import com.qgutech.km.module.uc.service.UserService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * 积分管理
 *
 * @author TangFD@HF 2018-8-21
 */
@Controller
@RequestMapping("score")
public class ScoreController {

    @Resource
    private ScoreRuleService scoreRuleService;
    @Resource
    private ScoreDetailService scoreDetailService;
    @Resource
    private UserService userService;

    @RequestMapping("manage/initPage")
    public String initPage() {
        return "km/score/scoreStatistic";
    }

    @RequestMapping("manage/scoreRule")
    public String scoreRule() {
        return "km/score/scoreRule";
    }

    @RequestMapping("manage/scoreDetail")
    public String scoreDetail(Model model, @RequestParam String userId) {
        model.addAttribute("userId", userId);
        return "km/score/scoreDetail";
    }

    @RequestMapping("manage/load")
    @ResponseBody
    public ScoreRule load(@RequestParam String ruleId) {
        return scoreRuleService.get(ruleId);
    }

    @RequestMapping("manage/search")
    @ResponseBody
    public Page<ScoreRule> search(ScoreRule rule, PageParam pageParam) {
        return scoreRuleService.search(rule, pageParam);
    }

    @RequestMapping("manage/updateRule")
    @ResponseBody
    public JsonResult updateRule(ScoreRule rule) {
        JsonResult jsonResult = new JsonResult();
        if (rule == null || StringUtils.isEmpty(rule.getId())) {
            jsonResult.setSuccess(false);
            return jsonResult;
        }

        try {
            scoreRuleService.update(rule, ScoreRule.NAME, ScoreRule.SCORE);
        } catch (Exception e) {
            e.printStackTrace();
            jsonResult.setSuccess(false);
        }

        return jsonResult;
    }

    @RequestMapping("manage/searchStatistic")
    @ResponseBody
    public Page<ScoreDetail> searchStatistic(ScoreDetail detail, PageParam pageParam) {
        return scoreDetailService.searchStatistic(detail, pageParam);
    }

    @RequestMapping("manage/searchDetail")
    @ResponseBody
    public Page<ScoreDetail> searchDetail(ScoreDetail detail, PageParam pageParam) {
        return scoreDetailService.searchDetail(detail, pageParam);
    }

}
