<!doctype html>
<html lang="zn-CH">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="renderer" content="webkit">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <title>${(paper.exam.examName)!}</title>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/exam.css" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/plugins/video-js.css" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/plugins/viewer.min.css" type="text/css">
    <script>
        var CFG = {
            userId: '${(userId)!}',
            examId: '${(examId)!}',
            residualTime: '${(residualTime)!}'
        };
    </script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.js"></script>
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/viewer-jquery.min.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/html5.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/carmera/jquery.webcam.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/media/video_dev.js"></script>
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/idangerous.swiper2.7.6.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/mockExam.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/mExam.js"></script>
</head>
<body>
<#--公用头部-->
<div class="pe-public-top-nav-header stu-top-nav-header" data-id="">
    <div class="pe-top-nav-container">
        <ul class="clearF">
            <li class="pe-logo floatL"></li>
        </ul>
    </div>
</div>
<form class="pe-container-main" id="examForm" name="examForm" action="javascript:;" method="post">
    <input type="hidden" name="markNum"/>
    <input type="hidden" name="examId" value="${(examId)!}"/>
    <div class="pe-answer-nav-top" data-examId="${(examId)!}">
        <div class="pe-complete-left">
            <h2 class="pe-answer-title">${(paper.mockExam.examName)!}</h2>
            <dl>
                <dt>总题数：</dt>
                <dd>${(paper.itemCount)!}</dd>
            </dl>
            <dl>
                <dt class="pe-answer-time">答题时长：</dt>
                <dd id="examTime">${(answerLength)!}</dd>
            </dl>
        </div>
        <div class="pe-complete-right">
            <button type="button" class="count-down-panel" id="countDownPanel">
                <strong class="count-down show-count">00:00:00</strong>
                <span class="show-count-down-text">显示倒计时</span>
                <i class="iconfont icon-eye-close"></i>
                <i class="iconfont icon-eye-open"></i>
            </button>
        </div>
    </div>
    <div class="pe-answer-content-left-wrap stu-content-left">
        <div class="pe-answer-content-left">
        <#list ['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'] as itemType>
            <#if paper.paperContent.prm?? && paper.paperContent.prm[itemType]??>
                <#assign pr = paper.paperContent.prm[itemType]/>
                <div class="pe-paper-preview-content">
                    <div class="pe-question-top-head">
                        <h2 class="pe-question-head-text">
                            <a href="javascript:;" class="anchor" name="single"></a>
                            <#if itemType == 'SINGLE_SELECTION'>单选题（共${(pr.ic)!}小题，总分${(pr.tm)!}
                                分。答题规则：只有一个选项是正确答案。）<#elseif itemType == 'MULTI_SELECTION'>
                                多选题（共${(pr.ic)!}小题，总分${(pr.tm)!}
                                分。答题规则：至少有两个选项是正确答案。）<#elseif itemType == 'INDEFINITE_SELECTION'>不定项选择 （共${(pr.ic)!}
                                小题，总分${(pr.tm)!}分。答题规则：至少有一个选项是正确答案。）<#elseif itemType == 'JUDGMENT'>
                                判断题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：判断下列说法是否正确。）<#elseif itemType == 'FILL'>
                                填空题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：在对应的空格中填写答案。）<#elseif itemType == 'QUESTIONS'>
                                问答题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：在输入框中填写答案。）</#if>
                        </h2>
                    </div>
                    <div class="add-paper-question-item-wrap pe-answer-content-item-wrap">
                        <#list pr.ics as ic>
                            <div class="paper-add-question-content " data-type="${(itemType)!}">
                                <div class="paper-question-stem" data-index="${(ic.id)!}">
                                    <a name="no_${(ic.no)!}" class="paper-question-num">${(ic.no)!}、</a>
                                    <input hidden name="itemId" value="${(ic.id)}">
                                    <div class="paper-item-detail-stem">
                                        <span class="pe-question-score">(${(ic.m)!}分)</span>
                                        <p class="pe-qes-content">${(ic.ct)!}</p>
                                    </div>
                                    <div class="pe-question-item-level">
                                        <div class="pe-star-wrap">
                                            <span class="pe-star-container">
                                                <span class="pe-star iconfont icon-start-difficulty"
                                                      data-so="${ic.no}"></span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="all-images-wrap all-images-wrap${(ic.id)!}">
                                    <div class="swiper-container">
                                        <ul class="itemImageViewWrap swiper-wrapper">
                                        </ul>
                                        <div class="pagination"></div>
                                    </div>
                                </div>
                                <#if itemType == 'SINGLE_SELECTION' || itemType == 'MULTI_SELECTION' || itemType == 'INDEFINITE_SELECTION'>
                                    <ul class="pe-answer-content-select">
                                        <#list ic.ios as io>
                                            <#if itemType == 'SINGLE_SELECTION'>
                                                <li class="question-single-item-wrap pe-exam-radio-wrap">
                                                    <input type="radio" id="_${ic.no}_${io_index}" name="${ic.id}"
                                                           value="${(io_index)!}"/>
                                                    <label class="pe-exam-radio" for="_${ic.no}_${io_index}">
                                                        <div class="question-text-wrap">
                                                            <span class="question-item-letter-order">${(io.so)!}.</span>
                                                            <div class="question-items-choosen-text">${(io.ct)!}
                                                            </div>
                                                        </div>
                                                    </label>
                                                </li>
                                            <#else>
                                                <li class="question-single-item-wrap pe-exam-checkbox-wrap">
                                                    <input type="checkbox" id="_${ic.no}_${io_index}" name="${ic.id}"
                                                           value="${(io_index)!}"/>
                                                    <label class="pe-exam-radio" for="_${ic.no}_${io_index}">
                                                        <div class="question-text-wrap">
                                                            <span class="question-item-letter-order">${(io.so)!}.</span>
                                                            <div class="question-items-choosen-text">${(io.ct)!}
                                                            </div>
                                                        </div>
                                                    </label>
                                                </li>
                                            </#if>
                                        </#list>
                                    </ul>
                                <#elseif itemType == 'JUDGMENT'>
                                    <ul class="pe-answer-content-select pe-exam-judge-wrap">
                                        <li class="question-single-item-wrap pe-exam-radio-wrap">
                                            <input type="radio" id="_${ic.no}_1" name="${ic.id}" value="1"/>
                                            <label class="pe-exam-radio" for="_${ic.no}_1">
                                                <div class="question-text-wrap">
                                                    <div class="question-items-choosen-text">正确</div>
                                                </div>
                                            </label>
                                        </li>
                                        <li class="question-single-item-wrap pe-exam-radio-wrap">
                                            <input type="radio" id="_${ic.no}_2" name="${ic.id}" value="0"/>
                                            <label class="pe-exam-radio" for="_${ic.no}_2">
                                                <div class="question-text-wrap">
                                                    <div class="question-items-choosen-text">错误</div>
                                                </div>
                                            </label>
                                        </li>
                                    </ul>
                                <#elseif itemType == 'FILL'>
                                    <input type="hidden" name="${ic.id}"/>
                                <#else>
                                    <div class="pe-answer-content-text">
                                        <textarea name="${ic.id}"></textarea>
                                    </div>
                                </#if>
                            </div>
                        </#list>
                    </div>
                </div>
            </#if>
        </#list>
        </div>
    </div>
    <div class="pe-answer-content-right-wrap">
        <div class="pe-answer-right-top">
            <div class="pe-answer-right-top-img">
                <img src="${(facePath)!}">
                <span style="position: relative;" class="answer-video-cla">
                    <span class="pe-answer-video fixed" id="webcam">
                     摄像正在启动<canvas id="canvas" width="320" height="240" style="display:none;"></canvas>
                    </span>
                </span>
            </div>
            <h2 class="pe-answer-name">${(userName)!}</h2>
            <dl>
                <dt><i class="iconfont">&#xe735;</i></dt>
                <dd class="pe-answer-num">${(loginName)!}</dd>
            </dl>
            <dl>
                <dt><i class="iconfont">&#xe732;</i></dt>
                <dd class="pe-answer-num">${(idCard)!}</dd>
            </dl>
            <dl>
                <dt><i class="iconfont">&#xe765;</i></dt>
                <dd class="pe-answer-num">${(mobile)!}</dd>
            </dl>
        </div>
        <div class="pe-answer-right-content" id="peAnswerInfoPanel">
            <div class="pe-answer-right-content-top">
                <h2>答题情况</h2>
                <span class="pe-answer-no"><span style="padding-right: 5px;"
                                                 class="iconfont icon-unchecked-checkbox floatL change-answer-checkbox"></span>只显示未答的题</span>
            </div>
            <div class="pe-answer-right-contain">
                <div class="pe-answer-progress-panel">
                    <div class="pe-answer-progress-wrap">
                        <div class="pe-answer-progress" style="width: 0%"></div>
                    </div>
                    <span class="complete-info">0%</span>
                </div>
                <div class="pe-answer-test-num">
                <#list sns as c>
                    <a href="#no_${c_index}" class="pe-answer-right-num no_${(c)}">${(c)}<span class="iconfont check"
                                                                                               style="display: none;">&#xe769;</span></a>
                </#list>
                </div>
                <div class="pe-answer-sure">
                    <button type="submit" class="pe-answer-sure-btn">确认交卷</button>
                </div>
            </div>
        </div>
    </div>
</form>
<footer class="pe-footer-wrap">
    <div class="pe-footer-copyright"> Copyright ©2016 青谷科技专业考试系统 All Rights Reserved 皖ICP备16015686号-2</div>
</footer>
</body>
</html>