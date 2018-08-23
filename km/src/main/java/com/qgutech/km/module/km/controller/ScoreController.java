package com.qgutech.km.module.km.controller;

import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.vo.JsonResult;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.module.km.model.*;
import com.qgutech.km.module.km.service.*;
import com.qgutech.km.module.uc.model.Organize;
import com.qgutech.km.module.uc.service.OrganizeService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.*;

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
    private KnowledgeService knowledgeService;
    @Resource
    private KnowledgeRelService knowledgeRelService;
    @Resource
    private LibraryService libraryService;
    @Resource
    private OrganizeService organizeService;

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

    @RequestMapping("manage/dealOldData")
    @ResponseBody
    public void dealOldData() {
        List<Knowledge> knowledges = knowledgeService.findAll();
        if (CollectionUtils.isEmpty(knowledges)) {
            return;
        }

        List<String> knowledgeIds = new ArrayList<>(knowledges.size());
        ScoreRule upload = scoreRuleService.getByCode(KnowledgeConstant.SCORE_RULE_UPLOAD);
        Map<String, Boolean> knowledgeIdMap = scoreDetailService.getKnowledgeIdMapByRuleId(upload.getId());
        for (Knowledge knowledge : knowledges) {
            String knowledgeId = knowledge.getId();
            if ("file".equals(knowledge.getKnowledgeType()) || BooleanUtils.isTrue(knowledgeIdMap.get(knowledgeId))) {
                continue;
            }

            knowledgeIds.add(knowledgeId);
        }

        if (knowledgeIds.size() > 0) {
            scoreDetailService.addScore(knowledgeIds, KnowledgeConstant.SCORE_RULE_UPLOAD);
        }


        Library library = libraryService.getUserLibraryByLibraryType(KnowledgeConstant.RECYCLE_LIBRARY);
        List<KnowledgeRel> recycleRels = knowledgeRelService.findByLibraryId(library.getId());
        if (CollectionUtils.isNotEmpty(recycleRels)) {
            List<String> recycleKnowledgeIds = new ArrayList<>(recycleRels.size());
            ScoreRule delete = scoreRuleService.getByCode(KnowledgeConstant.SCORE_RULE_DELETE);
            Map<String, Boolean> deleteKnowledgeIdMap = scoreDetailService.getKnowledgeIdMapByRuleId(delete.getId());
            for (KnowledgeRel rel : recycleRels) {
                String knowledgeId = rel.getKnowledgeId();
                if (BooleanUtils.isTrue(deleteKnowledgeIdMap.get(knowledgeId))) {
                    continue;
                }

                recycleKnowledgeIds.add(knowledgeId);
            }

            if (recycleKnowledgeIds.size() > 0) {
                scoreDetailService.addScore(recycleKnowledgeIds, KnowledgeConstant.SCORE_RULE_DELETE);
            }
        }

        Map<String, Organize> organizeMap = organizeService.findAll();
        Set<String> keySet = organizeMap.keySet();
        List<String> shareKnowledgeIds = knowledgeRelService.getKnowledgeIdsByLibraryIdsAndUserIds(new ArrayList<>(keySet), null);
        if (CollectionUtils.isEmpty(shareKnowledgeIds)) {
            return;
        }

        ScoreRule share = scoreRuleService.getByCode(KnowledgeConstant.SCORE_RULE_SHARE);
        Map<String, Boolean> shareKnowledgeIdMap = scoreDetailService.getKnowledgeIdMapByRuleId(share.getId());
        for (Iterator<String> iterator = shareKnowledgeIds.iterator(); iterator.hasNext(); ) {
            if (BooleanUtils.isTrue(shareKnowledgeIdMap.get(iterator.next()))) {
                iterator.remove();
            }
        }

        if (shareKnowledgeIds.size() > 0) {
            scoreDetailService.addScore(shareKnowledgeIds, KnowledgeConstant.SCORE_RULE_SHARE);
        }
    }


}
