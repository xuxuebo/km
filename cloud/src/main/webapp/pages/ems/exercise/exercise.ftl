<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zn-CH">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="renderer" content="webkit"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>${(paper.exam.examName)!}</title>
    <link rel="shortcut icon" href="${(resourcePath+icoUrl)!'${resourcePath!}/web-static/proExam/images/pe_ico_32.ico'}"
          type="image/x-icon"/>
    <link rel="stylesheet"
          href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}"
          type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/exam.css?_v=${(resourceVersion)!}"
          type="text/css">
    <!--[if lgt IE 9]>
    <style type="text/css">
        .count-down-panel .show-count {
            line-height: 71px;
        }

        .complete-info {
            margin-top: -2px;
        }
    </style>
    <![endif]-->
    <script>
        var CFG = {
            userId: '${(user.id)!}',
            exeriseId: '${(exercise.id)!}',
            ctx: '${ctx!}',
            resourcePath: '${resourcePath!}',
            speedType: '${(exerciseSetting.speedType)!}',
            questionAnswer: '${(exerciseSetting.questionAnswer)!}',
            speed: '${(exerciseSetting.speed)!}',
            startNo:${(startNo)!},
            totalNo:${(sns?size)!}
        };
    </script>

</head>
<body style="background: rgb(237, 240, 244);">
<div class="loading-before-mask" ><div class="loadingText">Loading...</div></div>
<#--公用头部-->
<div class="pe-public-top-nav-header stu-top-nav-header" data-id="">
    <div class="pe-top-nav-container exam-answer-top-header">
        <ul class="clearF">
            <li class="exam-name floatL">${(exercise.exerciseName)!}</li>
            <li class="floatL">
                <button type="button" class="count-down-panel" id="countDownPanel">
                    <span class="iconfont icon-countdown-counter floatL"></span>
                    <strong class="count-down show-count">00:00:00</strong>
                </button>
            </li>
            <li class="floatR">
                <div class="progress-text">已答&nbsp;<span
                        class="has-answer-num"><#if startNo??>${startNo!}<#else>0</#if></span>&nbsp;题&nbsp;/&nbsp;共&nbsp;<span
                        class="total-answer-num">${(sns?size)!}</span>&nbsp;题
                </div>
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
<form class="pe-container-main marking-container-wrap" id="examForm">
    <input type="hidden" name="markNum"/>
    <input type="hidden" name="examId" value="${(examId)!}"/>
    <input type="hidden" name="exerciseSettingId" value="${(exerciseSetting.id)!}"/>
    <input type="hidden" name="startNo" value="${(startNo)!}"/>
    <div class="pe-answer-nav-top answer-exam-nav-top" style="height:10px;">
    </div>
    <div class="pe-answer-content-right-wrap exercise-content-right">
        <div class="pe-answer-right-top blue-shadow">
            <div class="pe-answer-right-top-img" style="text-align: center;">
                <img onerror="javascript:this.src='${resourcePath!}/web-static/proExam/images/default/default_face.png'"
                     src="${(user.facePath)!'${resourcePath!}/web-static/proExam/images/default_face.png'}">
            </div>
            <h2 class="pe-answer-name" style="width: 100%;text-align: center;">${(user.userName)!}</h2>
        <#if user.idCard??>
            <dl style="padding: 0 10px;;">
                <dt><i class="iconfont">&#xe732;</i></dt>
                <dd class="pe-answer-num">${(user.idCard)!}</dd>
            </dl>
        </#if>
        </div>
        <div class="pe-answer-right-content blue-shadow" id="peAnswerInfoPanel">
            <div class="pe-answer-right-content-top">
                <h2>答题情况</h2>
            </div>
            <div class="pe-answer-right-contain exercise-right-contain">
                <div class="pe-answer-test-num">
                <#list ['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'] as itemType>
                    <#if exercise.exerciseContent.prm?? && exercise.exerciseContent.prm[itemType]??>
                        <#assign pr = exercise.exerciseContent.prm[itemType]/>

                        <#list pr.ics as ic>
                            <a class="pe-wrong-answer-item" style="float:left;" name="no_${(ic.no)!}" href="javascript:void(0)">
                                <#if recordMap?? && recordMap[ic.id]??>
                                    <span class="pe-answer-right-num done">${(ic.no)!}</span>
                                    <#if recordMap[ic.id].sign?string("true","false")=="true">
                                        <span class="pe-star iconfont icon-start-difficulty pe-wrong-start"></span>
                                    </#if>
                                    <span class="iconfont <#if recordMap[ic.id].correct?string("1","0")=="1">pe-right icon-right<#else>pe-wrong-con icon-wrong</#if>"/>
                                <#else>
                                    <span class="pe-answer-right-num">${(ic.no)!}</span>
                                    <span class="pe-star iconfont icon-start-difficulty pe-wrong-start" style="display: none"></span>
                                    <span class="iconfont pe-result-empty"></span>
                                </#if>
                            </a>
                        </#list>
                    </#if>
                </#list>
                </div>
            </div>
        </div>
        <div class="pe-answer-sure" style="margin-top:20px;clear: both;">
            <input name="hidden-count" type="hidden"/>
            <button type="button" class="pe-answer-sure-btn">提交练习</button>
        </div>
    </div>
    <div class="pe-answer-content-left-wrap stu-content-left exercise-content-left">
        <div class="pe-answer-content-left">
        <#assign questionAnswer= exerciseSetting.questionAnswer/>
        <#list ['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'] as itemType>
            <#if exercise.exerciseContent.prm?? && exercise.exerciseContent.prm[itemType]??>
                <#assign pr = exercise.exerciseContent.prm[itemType]/>
                <#list pr.ics as ic>
                    <#if recordMap[ic.id]??>
                        <#assign hasSign = recordMap[ic.id].sign/>
                        <#assign item = recordMap[ic.id]/>
                    </#if>
                    <div class="pe-making-template-wrap <#if <#--((ic.no?number==1 && startNo?number==0) ||-->((ic.no?number == sns?size&& startNo==sns?size) ||(ic.no?number==(startNo+1)))><#else>hideSingle</#if>"
                         data-type="${(itemType)!}" data-id="${(ic.id)!}" data-no="${(ic.no)!}">
                        <div class="pe-paper-preview-content">
                            <div class="pe-question-top-head">
                                <h2 class="pe-question-head-text">
                                    <a href="javascript:;" class="anchor" namltee="single"></a>
                                    <#if itemType == 'SINGLE_SELECTION'>
                                        单选题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：只有一个选项是正确答案。）
                                    <#elseif itemType == 'MULTI_SELECTION'>
                                        多选题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：至少有两个选项是正确答案。）
                                    <#elseif itemType == 'INDEFINITE_SELECTION'>
                                        不定项选择（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：至少有一个选项是正确答案。）
                                    <#elseif itemType == 'JUDGMENT'>
                                        判断题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：判断下列说法是否正确。）
                                    <#elseif itemType == 'FILL'>
                                        填空题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：在对应的空格中填写答案。）
                                    <#elseif itemType == 'QUESTIONS'>
                                        问答题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：在输入框中填写答案。）
                                    </#if>
                                </h2>
                            </div>
                            <div class="add-paper-question-item-wrap pe-answer-content-item-wrap">
                                <div class="paper-add-question-content" data-type="${(itemType)!}">
                                    <div class="paper-question-stem">
                                        <a name="no_${(ic.no)!}" class="paper-question-num">${(ic.no)!}、</a>
                                        <div class="paper-item-detail-stem">
                                            <div style="display:block!important;"
                                                 class="pe-qes-content marking-qes--content"><span
                                                    class="pe-question-score">(${(ic.m)!}分)</span>${(ic.ct)!}</div>
                                        </div>

                                        <div class="pe-question-item-level">
                                            <div class="pe-star-wrap">
                                            <span class="pe-star-container">
                                                <span class="pe-star pe-mark-star iconfont
                                                <#if (!recordMap[ic.id]?? || (recordMap[ic.id]?? && recordMap[ic.id].sign??
                                                    && (recordMap[ic.id].sign?string('true','false'))=='false'))>
                                                    icon-un-mark-star<#else>icon-has-mark-star pe-checked-star
                                                    </#if>"
                                                      <#if recordMap[ic.id]??>disabled="true"</#if>
                                                      data-so="${ic.no}"></span>
                                            </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="all-images-wrap" style="display: none;">
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
                                                    <li class="question-single-item-wrap pe-exam-radio-wrap <#if io.t?? && io.t>right-option-wrap</#if>">
                                                        <input type="radio" id="_${ic.no}_${io_index}" name="_${ic.no}"
                                                            <#if recordMap?? && recordMap[ic.id]?? && recordMap[ic.id].answer?? &&  (recordMap[ic.id].answer?index_of('${io_index}')!=-1)>
                                                               checked="checked"</#if>
                                                               <#if recordMap[ic.id]??>disabled="disabled"</#if>
                                                               value="${(io_index)!}"/>
                                                        <label class="pe-exam-radio" for="_${ic.no}_${io_index}">
                                                            <div class="question-text-wrap">
                                                                <span class="question-item-letter-order">${(io.so)!}
                                                                    .</span>
                                                                <div class="question-items-choosen-text">${(io.ct)!}
                                                                </div>
                                                            </div>
                                                        </label>
                                                    </li>
                                                <#else>
                                                    <li class="question-single-item-wrap pe-exam-checkbox-wrap <#if io.t?? && io.t>right-option-wrap</#if>">
                                                        <input type="checkbox" id="_${ic.no}_${io_index}"
                                                               name="_${ic.no}"
                                                            <#if recordMap??&&recordMap[ic.id]?? && recordMap[ic.id].answer??&&(recordMap[ic.id].answer?index_of('${io_index}')!=-1)>
                                                               checked="checked"</#if><#if recordMap[ic.id]??>disabled="disabled"</#if>
                                                               value="${(io_index)!}"/>
                                                        <label class="pe-exam-radio" for="_${ic.no}_${io_index}">
                                                            <div class="question-text-wrap">
                                                                <span class="question-item-letter-order">${(io.so)!}
                                                                    .</span>
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
                                            <li class="question-single-item-wrap pe-exam-radio-wrap <#if ic.t?? && ic.t>right-option-wrap</#if>">
                                                <input type="radio" id="_${ic.no}_1" name="_${ic.no}"
                                                <#if recordMap??&&recordMap[ic.id]?? && recordMap[ic.id].answer??&&recordMap[ic.id].answer=='1'>
                                                       checked="checked"
                                                </#if>
                                                <#if recordMap??&&recordMap[ic.id]?? && recordMap[ic.id].answer??>disabled="disabled"</#if>
                                                       value="1"/>
                                                <label class="pe-exam-radio" for="_${ic.no}_1">
                                                    <div class="question-text-wrap">
                                                        <div class="question-items-choosen-text">正确</div>
                                                    </div>
                                                </label>
                                            </li>
                                            <li class="question-single-item-wrap pe-exam-radio-wrap <#if !(ic.t?? && ic.t)>right-option-wrap</#if>">
                                                <input type="radio" id="_${ic.no}_2" name="_${ic.no}"
                                                    <#if recordMap??&&recordMap[ic.id]?? && recordMap[ic.id].answer??&&recordMap[ic.id].answer=='0'>
                                                       checked="checked"
                                                    </#if>
                                                       <#if recordMap??&&recordMap[ic.id]?? && recordMap[ic.id].answer??>disabled="disabled"</#if>
                                                       value="0"/>
                                                <label class="pe-exam-radio" for="_${ic.no}_2">
                                                    <div class="question-text-wrap">
                                                        <div class="question-items-choosen-text">错误</div>
                                                    </div>
                                                </label>
                                            </li>
                                        </ul>
                                    <#elseif itemType == 'FILL'>
                                        <input type="hidden" name="_${ic.id}"/>
                                    <#else>
                                        <div class="pe-answer-content-text">
                                            <textarea name="_${ic.id}"
                                                <#if recordMap??&&recordMap[ic.id]?? && recordMap[ic.id].answer??&&recordMap[ic.id].answer!="">
                                                    readonly="readonly"
                                                </#if>>
                                                <#if recordMap??&&recordMap[ic.id]?? && recordMap[ic.id].answer??>
                                                   ${(recordMap[ic.id].answer)!}
                                                </#if>
                                            </textarea>
                                        </div>
                                    </#if>
                                    <div class="pe-wrong-answer" style="display: none;">
                                        <#if itemType == 'JUDGMENT'>
                                            <h2 class="pe-wrong-answer-con">答案：<#if ic.t?? && ic.t>正确<#else>
                                                错误</#if></h2>
                                        <#else>
                                            <h2 class="pe-wrong-answer-con">答案：${(ic.a)!}</h2>
                                        </#if>
                                        <p class="pe-wrong-parsing">解析：${(ic.ep)!}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="pe-title-btn marking-btn-wrap">
                            <#if (sns?size==1)>
                                <button type="button"
                                        <#if questionAnswer=='NOSHOW'>style="display: none"</#if>
                                        class="pe-btn pe-btn-green pe-complete-btn">确&nbsp;&nbsp;定
                                </button>
                                <button type="button" class="pe-btn pe-btn-green pe-last-submit-btn">提交练习</button>
                            <#elseif (ic.no == 1)>
                                <#if (ic.no>startNo)>
                                    <button type="button"
                                            <#if questionAnswer=='NOSHOW'>style="display: none"</#if>
                                            class="pe-btn pe-btn-green pe-complete-btn">确&nbsp;&nbsp;定</button>
                                    <button type="button"
                                            <#if questionAnswer=='SHOW'>
                                            style="display: none"</#if> class="pe-btn pe-btn-green pe-next-btn 1">
                                        下一题
                                    </button>
                                <#else>
                                <button type="button"
                                    <#if questionAnswer=='SHOW'>
                                        style="display: none"</#if> class="pe-btn pe-btn-green pe-next-btn 2">
                                    下一题
                                </button>
                                </#if>
                            <#elseif ic.no == (sns?size)>
                                <button type="button" class="pe-btn pe-btn-purple pe-prev-btn">上一题</button>
                                <#if (ic.no>startNo)>
                                <button type="button"
                                        <#if questionAnswer=='NOSHOW'>style="display: none"</#if>
                                        class="pe-btn pe-btn-green pe-complete-btn">确&nbsp;&nbsp;定</button>
                                </#if>
                                <button type="button" class="pe-btn pe-btn-green pe-last-submit-btn">提交练习
                                </button>
                            <#elseif ic.no<(startNo+1)>
                                <button type="button" class="pe-btn pe-btn-purple pe-prev-btn">上一题</button>
                                <button type="button" class="pe-btn pe-btn-green pe-next-btn">
                                    下一题
                                </button>
                            <#else>
                                <button type="button" class="pe-btn pe-btn-purple pe-prev-btn">上一题</button>
                                <#if (ic.no>startNo)>
                                    <button type="button"
                                            <#if questionAnswer=='NOSHOW'>style="display: none"</#if>
                                            class="pe-btn pe-btn-green pe-complete-btn">确&nbsp;&nbsp;定</button>
                                </#if>
                                <button type="button"
                                        <#if questionAnswer=='SHOW'>
                                        style="display: none"</#if>
                                        class="pe-btn pe-btn-green pe-next-btn 3">
                                    下一题
                                </button>
                            </#if>
                                <button type="button" class="pe-btn pe-btn-white pe-leave-temporary">
                                    暂时离开
                                </button>
                        </div>
                    </div>
                </#list>
            </#if>
        </#list>
        </div>
    </div>

</form>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/compressJs/examIng_plugin_min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${ctx!}/web-static/proExam/js/plugins/layer/layer.js"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>
<script type="text/template" id="showRightAnswer">
    <div class="pe-wrong-answer">
        <h2 class="pe-wrong-answer-con">
            答案：<%if(data.type==='JUDGMENT'){if(data.itemDetail.ics.t){%>
            正确
            <%}else{%>错误<%}}else{%><%=data.itemDetail.ics.a%><%}%></h2>
        <p class="pe-wrong-parsing">解析：<%=data.itemDetail.ics.eq%>
        </p>
    </div>
</script>

<script type="text/template" id="imageTemp">
    <%_.each(data,function(imageUrl,index){%>
    <li class="pe-view-question-detail-img-wrap swiper-slide over-flow-hide" data-index="<%=index%>"
        style="display:inline-block;">
        <img class="pe-question-detail-img-item" data-original="<%=imageUrl%>" src="<%=imageUrl%>" width="auto"
             height="100%"/>
    </li>
    <%});%>
</script>
<script type="text/javascript"
        src="${resourcePath!}/web-static/proExam/js/exercise.js?_v=54${(resourceVersion)!}">
</script>
<script>
    var exerciseSetting = {
        questionAnswer: '${(exerciseSetting.questionAnswer)!}',
        seeAnswer: '${(exercise.seeAnswer?string("true","false"))}'
    }
</script>
<script>

</script>
</body>
</html>