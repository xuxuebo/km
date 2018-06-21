<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zn-CH">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="renderer" content="webkit" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>${(paper.exam.examName)!}</title>
    <link rel="shortcut icon" href="${resourcePath!}/web-static/proExam/images/pe_ico_32.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/exam.css?_v=${(resourceVersion)!}" type="text/css">

    <!--[if lgt IE 9]>
        <style type="text/css">
            .exam-loading-opacity-mask{
                display:none!important;
            }
            .exam-loading-mask{
                z-index:1999999;
                background:#fff url('${resourcePath!}/web-static/proExam/images/exam_loading_gif.gif') center center no-repeat!important;
                width:100%;
                height:100%;
            }
            .count-down-panel .show-count{
                line-height:71px;
            }
            .complete-info{
                margin-top:-2px;
            }
        </style>
    <![endif]-->
    <script>

        var CFG = {
            userId: '${(user.id)!}',
            examId: '${(examId)!}',
            answeredTime:'${(limitedTime)!}',
            residualTime:'${(residualTime)!}',
            openTab:'${(openTab?string('true','false'))!}',
            ctx:'${ctx!}',
            resourcePath:'${resourcePath!}'
        };
    </script>
</head>
<body>
<div class="exam-loading-mask"></div>
<#--<div class="exam-loading-opacity-mask"></div>-->
<#--公用头部-->
<div class="pe-public-top-nav-header stu-top-nav-header" data-id="">
    <div class="pe-top-nav-container exam-answer-top-header" >
        <ul class="clearF over-flow-hide">
            <li class="exam-name floatL">${(paper.exam.examName)!}</li>
            <li class="floatL">
                <button type="button" class="count-down-panel" id="countDownPanel">
                    <span class="iconfont icon-countdown-counter floatL"></span>
                    <strong class="count-down show-count">00:00:00</strong>
                </button>
            </li>
            <li class="floatR">
                <div class="progress-text">已答&nbsp;<span class="has-answer-num">4</span>&nbsp;题&nbsp;/&nbsp;共&nbsp;${(paper.itemCount)!}&nbsp;题</div>
                <div class="pe-answer-progress-panel">
                    <div class="pe-answer-progress-wrap">
                        <div class="pe-answer-progress" style="width: 0"></div>
                    </div>
                    <span class="complete-info">0%</span>
                </div>
            </li>
        </ul>
    </div>
</div>
<form class="pe-container-main" id="examForm" style="margin-bottom:15px;" >
    <input type="hidden" name="markNum"/>
    <input type="hidden" name="examId" value="${(examId)!}"/>
    <div class="pe-answer-nav-top answer-exam-nav-top" data-examId="${(examId)!}">
    </div>
    <div class="pe-answer-content-left-wrap stu-content-left blue-shadow">
        <div class="pe-answer-content-left">
        <#list ['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'] as itemType>
            <#if paper.paperContent.prm?? && paper.paperContent.prm[itemType]??>
                <#assign pr = paper.paperContent.prm[itemType]/>
                <div class="pe-paper-preview-content">
                    <div class="pe-question-top-head">
                        <h2 class="pe-question-head-text">
                            <a href="javascript:;" class="anchor" name="single"></a>
                            <#if itemType == 'SINGLE_SELECTION'>单选题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：只有一个选项是正确答案。）<#elseif itemType == 'MULTI_SELECTION'>
                                多选题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：至少有两个选项是正确答案。）<#elseif itemType == 'INDEFINITE_SELECTION'>不定项选择 （共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：至少有一个选项是正确答案。）<#elseif itemType == 'JUDGMENT'>
                                判断题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：判断下列说法是否正确。）<#elseif itemType == 'FILL'>填空题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：在对应的空格中填写答案。）<#elseif itemType == 'QUESTIONS'>问答题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：在输入框中填写答案。）</#if>
                        </h2>
                    </div>
                    <div class="add-paper-question-item-wrap pe-answer-content-item-wrap">
                        <#list pr.ics as ic>
                            <a name="no_${(ic.no)!}" id="no_${(ic.no)!}" style="position:relative;top:-84px;display:block;"></a>
                            <div class="paper-add-question-content "  id="no_${(ic.no)!}" data-type="${(itemType)!}">
                                <div class="paper-question-stem" data-index="${(ic.no)!}">
                                    <span class="paper-question-num">${(ic.no)!}、</span>
                                    <div class="paper-item-detail-stem">
                                        <div style="display:block!important;" class="pe-qes-content"><span class="pe-question-score">(${(ic.m)!}分)</span>${(ic.ct)!}</div>
                                    </div>
                                    <div class="pe-question-item-level">
                                        <div class="pe-star-wrap">
                                            <span class="pe-star-container">
                                                <span class="pe-star pe-mark-star iconfont icon-un-mark-star" data-so="${(ic.no)!}"></span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="all-images-wrap">
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
                                                    <input type="radio" id="_${ic.no}_${io_index}" name="_${ic.no}"
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
                                                    <input type="checkbox" id="_${ic.no}_${io_index}" name="_${ic.no}"
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
                                            <input type="radio" id="_${ic.no}_1" name="_${ic.no}" value="1"/>
                                            <label class="pe-exam-radio" for="_${ic.no}_1">
                                                <div class="question-text-wrap">
                                                    <div class="question-items-choosen-text">正确</div>
                                                </div>
                                            </label>
                                        </li>
                                        <li class="question-single-item-wrap pe-exam-radio-wrap">
                                            <input type="radio" id="_${ic.no}_2" name="_${ic.no}" value="0"/>
                                            <label class="pe-exam-radio" for="_${ic.no}_2">
                                                <div class="question-text-wrap">
                                                    <div class="question-items-choosen-text">错误</div>
                                                </div>
                                            </label>
                                        </li>
                                    </ul>
                                <#elseif itemType == 'FILL'>
                                    <input type="hidden" name="_${ic.no}"/>
                                <#else>
                                    <div class="pe-answer-content-text">
                                        <textarea name="_${ic.no}"></textarea>
                                    </div>
                                </#if>
                            </div>
                        </#list>
                    </div>
                </div>
            </#if>
        </#list>
            <div class="all-item-has-answer">未检测到未答的题目</div>
        </div>
    </div>
    <div class="pe-answer-content-right-wrap">
        <div class="pe-answer-right-top blue-shadow">
            <div class="pe-answer-right-top-img">
                <img onerror="javascript:this.src='${resourcePath!}/web-static/proExam/images/default/default_face.png'" src="${(user.facePath)!'${resourcePath!}/web-static/proExam/images/default_face.png'}">

                <span style="position: relative;" class="answer-video-cla un-ready-camera">
                    <span class="pe-answer-video fixed" id="webcam">
                     摄像正在启动<canvas id="canvas" width="320" height="240" style="display:none;"></canvas>
                        <#--<span class="video-cam-mask"></span>-->
                    </span>
                </span>
            </div>
            <h2 class="pe-answer-name">${(user.userName)!}</h2>
            <dl>
                <dt><i class="iconfont">&#xe735;</i></dt>
                <dd class="pe-answer-num">${(user.loginName)!}</dd>
            </dl>
            <dl>
                <dt><i class="iconfont">&#xe732;</i></dt>
                <dd class="pe-answer-num">${(user.idCard)!}</dd>
            </dl>
            <#--<dl>-->
                <#--<dt><i class="iconfont">&#xe765;</i></dt>-->
                <#--<dd class="pe-answer-num">${(mobile)!}</dd>-->
            <#--</dl>-->
        </div>
        <div class="pe-answer-right-content blue-shadow" id="peAnswerInfoPanel">
            <div class="pe-answer-right-content-top">
                <h2>答题情况</h2>
                <span class="pe-answer-no"><span style="padding-right: 5px;" class="iconfont icon-unchecked-checkbox floatL change-answer-checkbox"></span>只显示未答的题</span>
            </div>
            <div class="pe-answer-right-contain">
                <div class="pe-answer-test-num">
                    <#list sns as c>
                        <a href="#no_${(c_index+1)}" class="pe-answer-right-num no_${(c)}">${(c)}<span class="iconfont check" style="display: none;">&#xe769;</span></a>
                    </#list>
                    <div class="all-item-has-answer-a">
                        <div class="iconfont icon-message"></div>您已全部完成答题</div>
                </div>
            </div>
        </div>
        <div class="pe-answer-sure" style="margin-top:20px;">
            <button type="button" class="pe-answer-sure-btn">确认交卷</button>
        </div>
    </div>
</form>
<div class="camera-before-mask" style="display:none;"></div>

<#--考试提交进行的隐藏dom-->
<div class="pe-exam-sub-mask" style="display:none;"></div>
<div class="pe-box-wrap sub-status-dialog sub-exam-ing" style="display:none;">
    <div class="pe-box-contain">
        <div class="sub-ing-top-bg"></div>
        <div class="sub-ing-text">正在全力提交试卷中</div>
        <div class="sub-ing-tip">请您耐心等待提交完成后再关闭页面！</div>
    </div>
</div>
<#--考试提交失败的隐藏dom-->
<div class="pe-box-wrap sub-status-dialog sub-fail" style="display:none;">
    <i class="iconfont pe-box-close sub-exam-dia-close">&#xe643;</i>
    <div class="pe-box-contain">
        <div class="sub-ing-top-bg"></div>
        <div class="sub-ing-text">当前网速太慢，提交失败！</div>
        <button type="button" class="pe-btn pe-btn-green sub-again-btn">再次提交</button>
        <div class="sub-ing-tip">如有疑问，请联系考试管理员</div>
    </div>
</div>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/compressJs/examIng_plugin_min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/baseExam.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/exam.js?_v=${(resourceVersion)!}"></script>
</body>
</html>