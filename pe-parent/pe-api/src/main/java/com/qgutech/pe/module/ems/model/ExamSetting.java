package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.module.ems.vo.*;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.List;
import java.util.Map;

/**
 * 考试设置实体
 *
 * @author Created by zhangyang on 2016/11/14.
 */
@Entity
@Table(name = "t_ems_exam_setting", indexes = {
        @Index(name = "i_ems_exam_setting_examId", columnList = "exam_id"),
        @Index(name = "i_ems_exam_setting_createBy", columnList = "createBy")
},
        uniqueConstraints = {
                @UniqueConstraint(name = "u_ems_exam_examId", columnNames = {"corpCode", "exam_id"})
        })
public class ExamSetting extends BaseModel {
    public static final String _exam = "exam.id";
    public static final String _examSetting = "examSetting";
    public static final String _judgeSetting = "judgeSetting";
    public static final String _messageSetting = "messageSetting";
    public static final String _preventSetting = "preventSetting";
    public static final String _rankSetting = "rankSetting";
    public static final String _scoreSetting = "scoreSetting";
    public static final String _examAuthType = "examAuthType";


    /**
     * 多选题判分规则
     */
    public enum MultiScoreType {
        LESS_SELECT_NO_SCORE("选对满分，选错或少选不得分"),
        LESS_SELECT_SCORE_HALF("选对满分，选错不得分，少选得一半分"),
        LESS_SELECT_SCORE_RATE("选对满分，选错不得分，少选得分按照比例");

        private String text;

        MultiScoreType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 评卷模式
     */
    public enum JudgeType {
        AUTO_JUDGE("自动评卷"),//适合全部为客观题的试卷，系统对客观题自动评卷，若有主观题，则记为0分。
        MANUAL_JUDGE_PAPER("人工评卷,按试卷分配评卷人"),//适合含有主观题的试卷，系统对客观题自动评卷，主观题由评卷人手动评卷。
        MANUAL_JUDGE_ITEM("人工评卷,按试题分配评卷人");//适合含有主观题的试卷，系统对客观题自动评卷，主观题由评卷人手动评卷。

        private String text;

        JudgeType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 补考设置类型
     */
    public enum MakeUpType {
        NO_MAKEUP("不允许补考"),
        AUTO_MAKEUP("自动安排补考"),
        MANUAL_MAKEUP("手动安排补考");
        private String text;

        MakeUpType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 限制考试时长类型
     */
    public enum ExamLengthType {
        LIMIT("限制"),
        NO_LIMIT("不限制");
        private String text;

        ExamLengthType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 成绩发布类型
     */
    public enum ScorePublishType {
        JUDGED_AUTO_PUBLISH("评卷后自动发布成绩"),
        MANUAL("手动发布"),
        JUDGED_ALL_AND_EXAM_END("考试结束且完成所有评卷后发布成绩"),
        SUBJECT_AUTO_PUBLISH("所有科目的成绩全部发布后，自动发布综合考试的成绩"),
        SUBJECT_MANUAL("所有科目的成绩全部发布后，需要手动发布综合成绩"),
        SUBJECT_EXAM_TOGETHER("综合成绩和各科目的成绩一起发布");

        private String text;

        ScorePublishType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 成绩设置类型
     */
    public enum ScoreType {
        CONVERT("原试卷题目分数按比例折算"),
        ORIGINAL("使用原试卷分数"),
        SUBJECT("满分由所有科目累计"),
        SUBJECT_CONVERT("满分由所有科目按权重折算");
        private String text;

        ScoreType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 排行榜发布设置类型
     */
    public enum ShowRankType {
        SHOW_MARK("成绩发布后显示考试排名"),
        SHOW_END("成绩发布且考试结束后显示考试排名");
        private String text;

        ShowRankType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 排行榜显示设置类型
     */
    public enum RankShowType {
        NO_SHOW("不显示考试排名"),
        SHOW_FIRST("显示首次考试的排名"),
        SHOW_MAX("显示最高成绩的排名"),
        SHOW_AVERAGE("显示平均成绩的排名");
        private String text;

        RankShowType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 考试权限设置
     */
    public enum ExamAuthType {
        NO_SEE("不允许考生查看答卷"),
        SEE_PAPER_NO_ANSWER("允许考生查看答卷，但不允许查看正确答案"),
        JUDGE_AND_SEE_ALL("评卷后允许考生查看答卷和正确答案"),
        SEE_ERROR_NO_ANSWER("只允许考生查看答错的试题，且不显示正确答案"),
        SEE_ERROR_AND_ANSWER("只允许考生查看答错的试题，同时显示正确答案");

        private String text;

        ExamAuthType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 答卷模式
     */
    public enum AnswerType {
        ALL("整卷"), EVERY("逐题");
        private String text;

        AnswerType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    public enum ExamUserType {
        EXAM_MANAGER("考试管理员"), MANUAL_JUDGE_PAPER_USER("人工评卷,按试卷分配评卷人"), MANUAL_JUDGE_ITEM_USER("人工评卷,按试题分配评卷人");
        private String text;

        ExamUserType(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * 考试信息对象
     */
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "exam_id", nullable = false)
    private Exam exam;

    /**
     * 考生权限设置
     */
    @Column(length = 20)
    @Enumerated(EnumType.STRING)
    private ExamAuthType examAuthType;

    /**
     * 考试基本设置
     */
    @Type(type = "com.qgutech.pe.utils.JsonType", parameters = {
            @org.hibernate.annotations.Parameter(name = "clazzName",
                    value = "com.qgutech.pe.module.ems.vo.Es")})
    @Column(name = "exam_setting")
    private Es examSetting;

    /**
     * 评卷策略
     */
    @Type(type = "com.qgutech.pe.utils.JsonType", parameters = {
            @org.hibernate.annotations.Parameter(name = "clazzName",
                    value = "com.qgutech.pe.module.ems.vo.Js")})
    @Column(name = "judge_setting")
    private Js judgeSetting;

    /**
     * 成绩设置
     */
    @Type(type = "com.qgutech.pe.utils.JsonType", parameters = {
            @org.hibernate.annotations.Parameter(name = "clazzName",
                    value = "com.qgutech.pe.module.ems.vo.Ss")})
    @Column(name = "score_setting", nullable = false)
    private Ss scoreSetting;

    /**
     * 排行设置
     */
    @Type(type = "com.qgutech.pe.utils.JsonType", parameters = {
            @org.hibernate.annotations.Parameter(name = "clazzName",
                    value = "com.qgutech.pe.module.ems.vo.Rs")})
    @Column(name = "rank_setting")
    private Rs rankSetting;

    /**
     * 防舞弊设置
     */
    @Type(type = "com.qgutech.pe.utils.JsonType", parameters = {
            @org.hibernate.annotations.Parameter(name = "clazzName",
                    value = "com.qgutech.pe.module.ems.vo.Ps")})
    @Column(name = "prevent_setting")
    private Ps preventSetting;


    /**
     * 消息设置
     */
    @Type(type = "com.qgutech.pe.utils.JsonType", parameters = {
            @org.hibernate.annotations.Parameter(name = "clazzName",
                    value = "com.qgutech.pe.module.ems.vo.Ms")})
    @Column(name = "message_setting")
    private Ms messageSetting;

    /***************************************************
     * 非持久化字段                     *
     ***************************************************/

    /**
     * 考试管理员
     */
    @Transient
    private List<String> userIds;

    @Transient
    private List<ExamAuth> examAuthList;

    @Transient
    private List<JudgeUser> judgeUserRels;

    @Transient
    private Map<String, Long> typeCountMap;


    /**
     *付费项目
     */

    @Transient
    private String payApps;

    public Exam getExam() {
        return exam;
    }

    public void setExam(Exam exam) {
        this.exam = exam;
    }

    public ExamAuthType getExamAuthType() {
        return examAuthType;
    }

    public void setExamAuthType(ExamAuthType examAuthType) {
        this.examAuthType = examAuthType;
    }

    public Es getExamSetting() {
        return examSetting;
    }

    public void setExamSetting(Es examSetting) {
        this.examSetting = examSetting;
    }

    public Js getJudgeSetting() {
        return judgeSetting;
    }

    public void setJudgeSetting(Js judgeSetting) {
        this.judgeSetting = judgeSetting;
    }

    public Ss getScoreSetting() {
        return scoreSetting;
    }

    public void setScoreSetting(Ss scoreSetting) {
        this.scoreSetting = scoreSetting;
    }
    public String getPayApps() {
        return payApps;
    }

    public void setPayApps(String payApps) {
        this.payApps = payApps;
    }

    public Rs getRankSetting() {
        return rankSetting;
    }

    public void setRankSetting(Rs rankSetting) {
        this.rankSetting = rankSetting;
    }

    public Ps getPreventSetting() {
        return preventSetting;
    }

    public void setPreventSetting(Ps preventSetting) {
        this.preventSetting = preventSetting;
    }

    public Ms getMessageSetting() {
        return messageSetting;
    }

    public void setMessageSetting(Ms messageSetting) {
        this.messageSetting = messageSetting;
    }

    public List<String> getUserIds() {
        return userIds;
    }

    public void setUserIds(List<String> userIds) {
        this.userIds = userIds;
    }

    public List<ExamAuth> getExamAuthList() {
        return examAuthList;
    }

    public void setExamAuthList(List<ExamAuth> examAuthList) {
        this.examAuthList = examAuthList;
    }

    public List<JudgeUser> getJudgeUserRels() {
        return judgeUserRels;
    }

    public void setJudgeUserRels(List<JudgeUser> judgeUserRels) {
        this.judgeUserRels = judgeUserRels;
    }

    public Map<String, Long> getTypeCountMap() {
        return typeCountMap;
    }

    public void setTypeCountMap(Map<String, Long> typeCountMap) {
        this.typeCountMap = typeCountMap;
    }
}
