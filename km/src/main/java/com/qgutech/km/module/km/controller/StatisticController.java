package com.qgutech.km.module.km.controller;

import com.qgutech.km.base.vo.Rank;
import com.qgutech.km.module.km.model.Statistic;
import com.qgutech.km.module.km.service.KnowledgeRelService;
import com.qgutech.km.module.km.service.KnowledgeService;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 文件统计控制层
 *
 * @author TangFD@HF
 * @since 2018-8-14
 */
@Controller
@RequestMapping("statistic")
public class StatisticController {

    @Resource
    private KnowledgeService knowledgeService;
    @Resource
    private KnowledgeRelService knowledgeRelService;


    @RequestMapping("fileCount")
    @ResponseBody
    public Map<String, String> fileCount() {
        return knowledgeService.getKnowledgeTotalAndDayCount();
    }

    @RequestMapping("rank")
    @ResponseBody
    public List<Rank> rank(@RequestParam(required = false) String type) {
        return knowledgeService.rank(type, 5);
    }

    @RequestMapping("orgStatistic")
    @ResponseBody
    public Statistic orgStatistic() {
        return knowledgeRelService.orgRank(6);
    }

    @RequestMapping("libraryRank")
    @ResponseBody
    public Statistic libraryRank(@RequestParam String type) {
        return knowledgeRelService.libraryRank(type, 6);
    }

    @RequestMapping("orgRank")
    @ResponseBody
    public List<Rank> orgRank() {
        Statistic statistic = knowledgeRelService.orgRank(5);
        List<String> names = statistic.getNames();
        if (CollectionUtils.isEmpty(names)) {
            return new ArrayList<>(0);
        }
        List<Rank> ranks = new ArrayList<>(names.size());
        List<Long> counts = statistic.getCounts();
        for (int i = 0; i < names.size(); i++) {
            Rank rank = new Rank(null, counts.get(i).intValue());
            rank.setOrgName(names.get(i));
            ranks.add(rank);
        }
        return ranks;
    }
}
