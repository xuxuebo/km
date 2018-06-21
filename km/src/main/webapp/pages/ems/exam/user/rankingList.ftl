<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zn-CH">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/iconfont.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css">
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.js?_v=${(resourceVersion)!}"></script>
</head>
<body>
<div class="pe-ranking-wrap">
<#--<i class="iconfont pe-box-close">&#xe643;</i>-->
    <div class="pe-ranking-contain">
        <h2 class="pe-ranking-title">排行榜</h2>
        <div class="pe-ranking-item" style="overflow: hidden;padding: 10px 0;">
        <#if showFirst?? && showFirst>
            <dl>
                <dt class="pe-ranking-con">你的成绩：</dt>
                <dd class="pe-ranking-con">${(examResult.firstScore)!'0'}</dd>
        <#else>
            <dl>
                <dt class="pe-ranking-con">你的成绩：</dt>
                <dd class="pe-ranking-con">${(examResult.score)!'0'}</dd>
        </#if>
            <dt class="pe-ranking-con" style="margin-left: 20px;">排名：</dt>
            <dd class="pe-ranking-con">${(examResult.rankCount)!'0'}</dd>
        </dl>
            <dl class="pe-ranking-item-con floatR">
                <dt class="pe-ranking-result">参考人数：</dt>
                <dd class="pe-ranking-result">${(examResult.attentCount)!'0'}</dd>
                <dt class="pe-ranking-result">满分：</dt>
                <dd class="pe-ranking-result">${(examResult.totalScore)!'0'}</dd>
            </dl>
        </div>
        <div class="pe-stand-table-main-panel" style="background: none;">
            <div class="pe-ranking-table-wrap">
                <table class="pe-ranking-table">
                    <thead>
                    <tr>
                        <th style="width:10%;padding-left: 80px;">排名</th>
                        <th style="width:7%">姓名</th>
                        <th style="width:7%">成绩</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if examResult.exam.examSetting?? && examResult.exam.examSetting.rankSetting?? && examResult.exam.examSetting.rankSetting.rst?? && examResult.exam.examSetting.rankSetting.rst == 'SHOW_FIRST'>
                        <#list examResults as examResult>
                        <tr>
                            <td style="padding-left: 80px;">
                                <#if examResult_index == 0 || examResult_index == 1 || examResult_index == 2>
                                    <div class="list-rank-item clearF">
                                        <div class="rank-medal
                                 <#if examResult_index == 0>first-medal<#elseif examResult_index == 1>second-medal<#elseif examResult_index == 2>third-medal</#if>">
                                            <span class="iconfont icon-linkage "></span>
                                            <span class="iconfont icon-medal"></span>
                                            <span class="rank-number"> ${(examResult_index+1)!}</span>
                                        </div>
                                    </div>
                                <#else>
                                <div class="list-rank-item clearF" style="padding-left:8px;">
                                ${(examResult_index+1)!}
                                </div>
                                </#if>
                            </td>
                            <td>${(examResult.user.userName)!}</td>
                            <td>${(examResult.firstScore)!}</td>
                        </tr>
                        </#list>
                    <#else>
                        <#list examResults as examResult>
                        <tr>
                            <td style="padding-left: 80px;">
                                <#if examResult_index == 0 || examResult_index == 1 || examResult_index == 2>
                                <div class="list-rank-item clearF">
                                        <div class="rank-medal
                                 <#if examResult_index == 0>first-medal<#elseif examResult_index == 1>second-medal<#elseif examResult_index == 2>third-medal</#if>">
                                            <span class="iconfont icon-linkage "></span>
                                            <span class="iconfont icon-medal"></span>
                                            <span class="rank-number"> ${(examResult_index+1)!}</span>
                                        </div>
                                </div>
                                <#else>
                                <div class="list-rank-item clearF" style="padding-left:8px;">
                                ${(examResult_index+1)!}
                                </div>
                                </#if>
                            </td>
                            <td>${(examResult.user.userName)!}</td>
                            <td>${(examResult.score)!}</td>
                        </tr>
                        </#list>
                    </#if>
                    </tbody>
                </table>
                <p class="pe-ranking-tip">
                <#if showFirst?? && showFirst>
                    ＊成绩排名依据第一次考试成绩
                <#else>
                    ＊成绩排名依据最高的一次考试成绩
                </#if>
                </p>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function(){
            $('.pe-ranking-table tr').hover(
                    function(){
                        $(this).addClass('rank-tr-hover');
                    },
                    function(){
                        $(this).removeClass('rank-tr-hover');
                    }
            )
        })
    </script>
</div>
</body>
</html>