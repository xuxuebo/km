package com.qgutech.pe.base.vo;

import com.qgutech.pe.module.ems.model.ExamArrange;
import com.qgutech.pe.module.ems.model.ExamResult;

import java.util.List;
import java.util.Map;

/**
 * 成绩报表统计dto
 *
 * @author LiYanCheng@HF
 * @since 2017年1月14日17:56:16
 */
public class ResultReport {


    /**
     * 未通过次数

     */
    private Integer noPassCount;

    /**
     * 通过次数
     */
    private Double passCount;


    /**
     * 总分
     */
    private Double totalScore;

    /**
     * 及格线
     */
    private Double passLine;

    /**
     * 及格率
     */
    private Double passRate;

    /**
     * 应考人员
     */
    private Long testCount;

    /**
     * 参考人员
     */
    private Long attendCount;

    /**
     * 参考率
     */
    private Double attendRate;

    /**
     * 最高分
     */
    private Double highScore;

    /**
     * 最低分
     */
    private Double lowScore;

    /**
     * 平均分
     */
    private Double averScore;

    /**
     * 我的成绩
     */
    private Double myScore;

    /**
     * 考试结果状态分布
     */
    private Map<ExamResult.UserExamStatus, List<ExamArrange>> statusMap;

    /**
     * 考试分数结果分布
     */
    private Map<String, Map<String, Long>> scoreMap;

    /**
     * 时间段
     */
    private List<String> scoreRanges;

    /**
     * 考试分数结果分布
     */
    private Map<String, Long> examScoreMap;

    /**
     * 考试安排map
     */
    private Map<String, ExamArrange> examArrangeMap;

    /**
     * 知识点分析雷达图
     */
    private Map<String, Map<String, Double>> knowledgeMap;

    /**
     * 知识点分析雷达图
     */
    private Map<String, Double> examKnowledgeMap;

    /**
     * 平均水平
     */
    private Map<String, Double> avgScoreMap;

    /**
     * 考生姓名
     */
    private String userName;


    /**
     * 我的水平
     */
    private Map<String, Double> myScoreMap;

    public Double getPassCount() {
        return passCount;
    }

    public void setPassCount(Double passCount) {
        this.passCount = passCount;
    }

    public Double getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(Double totalScore) {
        this.totalScore = totalScore;
    }

    public Double getPassLine() {
        return passLine;
    }

    public void setPassLine(Double passLine) {
        this.passLine = passLine;
    }

    public Double getPassRate() {
        return passRate;
    }

    public void setPassRate(Double passRate) {
        this.passRate = passRate;
    }

    public Long getTestCount() {
        return testCount;
    }

    public void setTestCount(Long testCount) {
        this.testCount = testCount;
    }

    public Long getAttendCount() {
        return attendCount;
    }

    public void setAttendCount(Long attendCount) {
        this.attendCount = attendCount;
    }

    public Double getAttendRate() {
        return attendRate;
    }

    public void setAttendRate(Double attendRate) {
        this.attendRate = attendRate;
    }

    public Double getHighScore() {
        return highScore;
    }

    public void setHighScore(Double highScore) {
        this.highScore = highScore;
    }

    public Double getLowScore() {
        return lowScore;
    }

    public void setLowScore(Double lowScore) {
        this.lowScore = lowScore;
    }

    public Double getAverScore() {
        return averScore;
    }

    public void setAverScore(Double averScore) {
        this.averScore = averScore;
    }

    public Map<ExamResult.UserExamStatus, List<ExamArrange>> getStatusMap() {
        return statusMap;
    }

    public void setStatusMap(Map<ExamResult.UserExamStatus, List<ExamArrange>> statusMap) {
        this.statusMap = statusMap;
    }

    public Integer getNoPassCount() {
        return noPassCount;
    }

    public void setNoPassCount(Integer noPassCount) {
        this.noPassCount = noPassCount;
    }
    public Map<String, Map<String, Long>> getScoreMap() {
        return scoreMap;
    }

    public void setScoreMap(Map<String, Map<String, Long>> scoreMap) {
        this.scoreMap = scoreMap;
    }

    public List<String> getScoreRanges() {
        return scoreRanges;
    }

    public void setScoreRanges(List<String> scoreRanges) {
        this.scoreRanges = scoreRanges;
    }

    public Map<String, ExamArrange> getExamArrangeMap() {
        return examArrangeMap;
    }

    public void setExamArrangeMap(Map<String, ExamArrange> examArrangeMap) {
        this.examArrangeMap = examArrangeMap;
    }

    public Map<String, Map<String, Double>> getKnowledgeMap() {
        return knowledgeMap;
    }

    public void setKnowledgeMap(Map<String, Map<String, Double>> knowledgeMap) {
        this.knowledgeMap = knowledgeMap;
    }

    public Double getMyScore() {
        return myScore;
    }

    public void setMyScore(Double myScore) {
        this.myScore = myScore;
    }

    public Map<String, Double> getMyScoreMap() {
        return myScoreMap;
    }

    public void setMyScoreMap(Map<String, Double> myScoreMap) {
        this.myScoreMap = myScoreMap;
    }

    public Map<String, Double> getAvgScoreMap() {
        return avgScoreMap;
    }

    public void setAvgScoreMap(Map<String, Double> avgScoreMap) {
        this.avgScoreMap = avgScoreMap;
    }

    public Map<String, Long> getExamScoreMap() {
        return examScoreMap;
    }

    public void setExamScoreMap(Map<String, Long> examScoreMap) {
        this.examScoreMap = examScoreMap;
    }

    public Map<String, Double> getExamKnowledgeMap() {
        return examKnowledgeMap;
    }

    public void setExamKnowledgeMap(Map<String, Double> examKnowledgeMap) {
        this.examKnowledgeMap = examKnowledgeMap;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

}
