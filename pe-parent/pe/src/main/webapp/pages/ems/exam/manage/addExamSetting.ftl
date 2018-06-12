<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">考试</li>
    <#if exam.subject?? && exam.subject>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">科目管理</li>
        <#if exam.examType?? && exam.examType == 'ONLINE'>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑线上科目
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览线上科目
                <#else>
                    创建线上科目
                </#if>
            </li>
        <#else>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑线下科目
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览线下科目
                <#else>
                    创建线下科目
                </#if>
            </li>
        </#if>
    <#else >
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">考试管理</li>
        <#if exam.examType?? && exam.examType == 'ONLINE'>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑线上考试
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览线上考试
                <#else>
                    创建线上考试
                </#if>
            </li>
        <#elseif exam.examType?? && exam.examType == 'OFFLINE'>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑线下考试
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览线下考试
                <#else>
                    创建线下考试
                </#if>
            </li>
        <#else>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑综合考试
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览综合考试
                <#else>
                    创建综合考试
                </#if>
            </li>
        </#if>
    </#if>
    </ul>
</div>
<section class="steps-all-panel exam-add-four-all-wrap">
    <div class="add-exam-top-head">
        <ul class="over-flow-hide step-items-wrap <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-step-state</#if>">
            <li class="add-paper-step-item floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover basic-step-item<#else>step-complete</#if>"><#--#b8ecaa-->
                <div class="add-step-icon-wrap">
               <span class="iconfont icon-step-circle floatL">
                <span class="add-step-number">1</span>
               </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">基本信息</span>
            </li>
            <li class="add-paper-step-item add-paper-step-two floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover paper-step-item<#else>step-complete</#if>">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">2</span>
                    </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">试卷设置</span>
            </li>
        <#if exam.subject?? && exam.subject>
            <li class="add-paper-step-item add-paper-step-three floatL overStep">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                   <span class="add-step-number">3</span>
                 </span>
                </div>
                <span class="add-step-text">考试设置</span>
            </li>
        <#else>
            <li class="add-paper-step-item add-paper-step-two floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover arrange-step-item<#else>step-complete</#if>">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                   <span class="add-step-number">3</span>
                 </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">考试安排</span>
            </li>
            <li class="add-paper-step-item add-paper-step-three floatL overStep">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                   <span class="add-step-number">4</span>
                 </span>
                </div>
                <span class="add-step-text">考试设置</span>
            </li>
        </#if>
        </ul>
    </div>
    <div class="add-exam-main-panel add-exam-step-four-wrap">
    </div>
</section>
<div class="pe-btns-group-wrap default-simple-setting-btns"
     style="text-align:center;">
<#if exam.optType?? && (exam.optType == 'VIEW')  >
<div class="view-exam-group-one">
<#else>
    <#if !(exam.optType?? && exam.optType == 'UPDATE')>
        <button type="button" class="pe-btn pe-btn-purple pe-step-pre-btn">上一步</button>
    </#if>
    <#if (exam.status)?? && (exam.status) == 'DRAFT'>
        <button type="button" class="pe-btn pe-btn-blue pe-step-save-draft">保存为草稿</button>
        <button type="button" class="pe-btn pe-btn-blue
        <#if exam.subject?? && exam.subject>pe-subject-save-and-use<#else >pe-step-save-and-use</#if>">保存并启用
        </button>
    <#else>
        <button type="button" class="pe-btn pe-btn-blue pe-step-save-draft">保存</button>
    </#if>
</#if>
<#if exam.source?? && exam.source == 'ADD'>
    <button type="button" class="pe-btn pe-large-btn pe-btn-white new-page-close-btn">关闭</button>
<#else >
    <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
</#if>
<#if exam.optType?? && (exam.optType == 'VIEW') && (exam.status)?? && (exam.status) != 'OVER'>
    <a href="javascript:;" class="pe-view-user-btn i-need-edit-exam"><span
            class="iconfont icon-edit"></span>我要编辑考试信息</a>
</div>
    <div class="view-exam-group-two" style="display: none;">
        <button type="button" class="pe-btn pe-btn-blue pe-step-save-draft">保存</button>
        <#if exam.source?? && exam.source == 'ADD'>
            <button type="button" class="pe-btn pe-large-btn pe-btn-white new-page-close-btn">关闭</button>
        <#else >
            <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
        </#if>
    </div>
</#if>
</div>
<input type="hidden" id="itemIds" value=""/>

<script>
    $(function () {
        var subject = '${((exam.subject)!)?string('true','false')}';
        var formId = "defaultSimpleExamSettingForm";
        var editExamSetting = {
            init: function () {
                var _this = this;
                _this.bind();
                var source = '${(exam.source)!}';
                var optType = '${(exam.optType)!}';
                var params = {id: '${(exam.id)!}', optType: optType, source: source};
                $(".add-exam-main-panel").load(pageContext.rootPath + '/ems/exam/manage/simpleSetting', params, function () {
                    $('.add-exam-main-panel').find('.hide-input-span').hide();
                    $('.add-exam-main-panel').find('.show-input-text').show();
                    if (optType == 'VIEW') {//预览试卷置灰
                        $('input:not(.laydate-time)').attr('readonly', true);
                        $('.add-exam-main-panel').find('.exam-more-set-btn').hide();
                        $('.add-exam-main-panel').find('.hide-input-span').show();
                        $('.add-exam-main-panel').find('.show-input-text').hide();
                    }
                });
                //对输入的数字（keyup时间）做校验
                $('.add-exam-main-panel').delegate('.exam-create-num-input', 'keyup', function () {
                    var name = $(this).attr("name");
                    var inputNum = $(this).val();
                    inputNum = inputNum.replace(/[^0-9]/g, ''); //只能输入数字
                    if (name != 'examSetting.mn') {
                        inputNum = inputNum.replace(/^0/g, "");//验证第一个字符不是0
                    } else {
                    }
                    $(this).val(inputNum);
                });

                //对输入的数字（鼠标失焦）做校验
                $('.add-exam-main-panel').delegate('.exam-create-num-input', 'blur', function () {
                    var inputNum = $(this).val();
                    var name = $(this).attr("name");
                    if (!inputNum || parseInt(inputNum) < 0) {
                        if (name == 'examSetting.el' || name == 'rankSetting.rsn') {
                            inputNum = '';
                        }
                        if (name == 'examSetting.mn') {
                            inputNum = '';
                        }
                        if (name == 'scoreSetting.cm') {
                            inputNum = 100;
                        }
                        if (name == 'scoreSetting.pr') {
                            inputNum = 60;
                        }
                        if (name == 'preventSetting.csN') {
                            inputNum = 3;
                        }
                        if (name == 'preventSetting.noD' || name == 'preventSetting.bsD') {
                            inputNum = 5;
                        }
                        if (name == 'preventSetting.ltD') {
                            inputNum = 10;
                        }
                        return $(this).val(inputNum);
                    }
                    if (!/^[0-9]*$/.test(inputNum)) {
                        inputNum = inputNum.replace(/[^0-9]/g, ''); //只能输入数字
                        if (name != 'examSetting.mn') {
                            inputNum = inputNum.replace(/^0/g, ""); //验证第一个字符不是0
                        }
                    }
                    if (parseInt(inputNum) >= 999999) {
                        inputNum = 999999;
                    }

                    if (name == 'examSetting.mn') {
                        if (parseInt(inputNum) < 0) {
                            inputNum = '';
                        }
                    }
                    if (name == 'scoreSetting.pr') {
                        if (parseInt(inputNum) > 100) {
                            inputNum = 100;
                        }
                    }
                    if (name == 'rankSetting.rsn') {
                        if (parseInt(inputNum) < 1) {
                            inputNum = '';
                        }
                    }
                    if (name == 'preventSetting.csN') {
                        if (parseInt(inputNum) < 1) {
                            inputNum = 3;
                        }
                    }
                    if (name == 'preventSetting.noD' || name == 'preventSetting.bsD') {
                        if (parseInt(inputNum) < 1) {
                            inputNum = 5;
                        }
                    }
                    if (name == 'preventSetting.ltD') {
                        if (parseInt(inputNum) < 1) {
                            inputNum = 10;
                        }
                    }
                    return $(this).val(inputNum);
                });

                //我要编辑考试
                $('.i-need-edit-exam').on('click', function () {
                <#if !(exam.status?? && exam.status == 'PROCESS')>
                    $('input:not(.laydate-time)').removeAttr('readonly');
                </#if>
                    $('.sameChange label').removeClass("noClick");
                    $('button').removeAttr('disabled');
                    $('.view-exam-group-one').hide();
                    $('.view-exam-group-two').show();
                    $('.add-exam-main-panel').find('.exam-more-set-btn').show();
                    $('.add-exam-main-panel').find('.hide-input-span').hide();
                    $('.add-exam-main-panel').find('.show-input-text').show();
                    $('.view-exam-group-select-user').show();
                    $('.icon-inputDele').parent().removeClass('not-hover');
                });

                //跳转基本设置
                $('.edit-step-state .basic-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamInfo', params);
                });

                //跳转试卷设置
                $('.edit-step-state .paper-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamPaper', params);
                });

                //跳转考试安排
                $('.edit-step-state .arrange-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initArrangePage', params);
                });

                //选择考试管理员
                $('.add-exam-main-panel').delegate('.add-manager', 'click', function () {
                    PEMO.DIALOG.selectorDialog({
                        title: '选择考试管理员',
                        area: ['870px', '580px'],
                        content: [pageContext.rootPath + '/ems/exam/manage/initSelector?type=EXAM_MANAGER&id=${(exam.id)!}', 'no'],
                        btn: ['关闭'],
                        btn1: function (index) {
                            layer.close(index);
                        }
                    });
                });
                //类别点击筛选事件

                $('.add-exam-main-panel').delegate('.pe-radio.pe-check-by-list', 'click', function () {
                    if ($(this).hasClass('noClick')) {
                        return false;
                    } else {
                        var iconCheck = $(this).find('span.iconfont');
                        var thisRealCheck = $(this).find('input[type="radio"]');
                        if (iconCheck.hasClass('icon-unchecked-radio')) {
                            iconCheck.removeClass('icon-unchecked-radio').addClass('icon-checked-radio peChecked');
                            thisRealCheck.prop('checked', true);
                        }
                        switch (thisRealCheck.attr("id")) {
                            case "AUTO_JUDGE":
                                $("#MANUAL_JUDGE_PAPER").removeProp('checked');
                                $("#MANUAL_JUDGE_PAPER").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#MANUAL_JUDGE_ITEM").removeProp('checked');
                                $("#MANUAL_JUDGE_ITEM").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#MANUAL_JUDGE").removeProp('checked');
                                $("#MANUAL_JUDGE").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("input[name='judgeSetting.vi']").removeProp("checked");
                                $("input[name='judgeSetting.vi']").parent().find('span.iconfont').removeClass('icon-checked-checkbox peChecked').addClass('icon-unchecked-checkbox');
                                $("input[name='judgeSetting.vi']").prop("disabled", "disabled");
//                                $("input[name='judgeSetting.jt']").prop("disabled", "disabled");
                                $(".MANUAL_JUDGE_PAPER_span").hide();
                                $(".MANUAL_JUDGE_ITEM_span").hide();
                                $('#MANUAL_JUDGE_PAPER').parent().removeClass('pe-check-by-list').addClass('add-paper-tip-text');
                                $('#MANUAL_JUDGE_ITEM').parent().removeClass('pe-check-by-list').addClass('add-paper-tip-text');
                                $('input[name="judgeSetting.vi"]').parent().removeClass('pe-check-by-list').addClass('add-paper-tip-text');
                                break;
                            case "MANUAL_JUDGE_PAPER":
                                $("#AUTO_JUDGE").removeProp('checked');
                                $("#AUTO_JUDGE").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#MANUAL_JUDGE_ITEM").removeProp('checked');
                                $("#MANUAL_JUDGE_ITEM").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#MANUAL_JUDGE").prop('checked', 'checked');
                                $("#MANUAL_JUDGE").parent().find('span.iconfont').removeClass('icon-unchecked-radio').addClass('icon-checked-radio peChecked');
                                $("input[name='judgeSetting.vi']").removeProp("disabled");
                                $(".MANUAL_JUDGE_PAPER_span").show();
                                $(".MANUAL_JUDGE_ITEM_span").hide();
                                break;
                            case "MANUAL_JUDGE_ITEM":
                                $("#AUTO_JUDGE").removeProp('checked');
                                $("#AUTO_JUDGE").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#MANUAL_JUDGE_PAPER").removeProp('checked');
                                $("#MANUAL_JUDGE_PAPER").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#MANUAL_JUDGE").prop('checked', 'checked');
                                $("#MANUAL_JUDGE").parent().find('span.iconfont').removeClass('icon-unchecked-radio').addClass('icon-checked-radio peChecked');
                                $("input[name='judgeSetting.vi']").removeProp("disabled");
                                $(".MANUAL_JUDGE_PAPER_span").hide();
                                $(".MANUAL_JUDGE_ITEM_span").show();
                                break;
                            case "MANUAL_JUDGE":
                                $("#AUTO_JUDGE").removeProp('checked');
                                $("#AUTO_JUDGE").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#MANUAL_JUDGE_ITEM").removeProp('checked');
                                $("#MANUAL_JUDGE_ITEM").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#MANUAL_JUDGE_PAPER").prop('checked', 'checked');
                                $("#MANUAL_JUDGE_PAPER").parent().find('span.iconfont').removeClass('icon-unchecked-radio').addClass('icon-checked-radio peChecked');
                                $("input[name='judgeSetting.vi']").removeProp("disabled");
                                $("input[name='judgeSetting.jt']").removeProp("disabled");
                                $(".MANUAL_JUDGE_PAPER_span").show();
                                $(".MANUAL_JUDGE_ITEM_span").hide();
                                $('#MANUAL_JUDGE_PAPER').parent().removeClass('add-paper-tip-text').addClass('pe-check-by-list');
                                $('#MANUAL_JUDGE_ITEM').parent().removeClass('add-paper-tip-text').addClass('pe-check-by-list');
                                $('input[name="judgeSetting.vi"]').parent().removeClass('add-paper-tip-text').addClass('pe-check-by-list');
                                break;
                            case "EVERY":
                                $("#ALL").removeProp('checked');
                                $("#ALL").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("input[name='examSetting.ce']").removeProp("disabled");
                                $('input[name="examSetting.ce"]').parent().removeClass('add-paper-tip-text').addClass('pe-check-by-list');
                                break;
                            case "ALL":
                                $("#EVERY").removeProp('checked');
                                $("#EVERY").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("input[name='examSetting.ce']").removeProp("checked");
                                $("input[name='examSetting.ce']").parent().find('span.iconfont').removeClass('icon-checked-checkbox peChecked').addClass('icon-unchecked-checkbox');
                                $("input[name='examSetting.ce']").prop("disabled", "disabled");
                                $('input[name="examSetting.ce"]').parent().removeClass('pe-check-by-list').addClass('add-paper-tip-text');
                                break;
                            case "MANUAL":
                                $("#JUDGED_AUTO_PUBLISH").removeProp('checked');
                                $("#JUDGED_AUTO_PUBLISH").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#JUDGED_ALL_AND_EXAM_END").removeProp('checked');
                                $("#JUDGED_ALL_AND_EXAM_END").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("input[name='scoreSetting.tp']").removeProp("disabled");
                                $("input[name='scoreSetting.tp']").parent().removeClass('add-paper-tip-text').addClass('pe-check-by-list');
//                                $("input[name='scoreSetting.pd']").attr('onclick', 'laydate({format:"YYYY-MM-DD hh:mm",istime:true,istoday:false})');
                                break;
                            case "JUDGED_AUTO_PUBLISH":
                                $("#MANUAL").removeProp('checked');
                                $("#MANUAL").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#JUDGED_ALL_AND_EXAM_END").removeProp('checked');
                                $("#JUDGED_ALL_AND_EXAM_END").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("input[name='scoreSetting.tp']").removeProp("checked");
                                $("input[name='scoreSetting.tp']").parent().find('span.iconfont').removeClass('icon-checked-checkbox peChecked').addClass('icon-unchecked-checkbox');
                                $("input[name='scoreSetting.tp']").prop("disabled", "disabled");
                                $("input[name='scoreSetting.tp']").parent().removeClass('pe-check-by-list').addClass('add-paper-tip-text');
//                                $("input[name='scoreSetting.pd']").attr('onclick', '');
                                break;
                            case "JUDGED_ALL_AND_EXAM_END":
                                $("#MANUAL").removeProp('checked');
                                $("#MANUAL").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("#JUDGED_AUTO_PUBLISH").removeProp('checked');
                                $("#JUDGED_AUTO_PUBLISH").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                                $("input[name='scoreSetting.tp']").removeProp("checked");
                                $("input[name='scoreSetting.tp']").parent().find('span.iconfont').removeClass('icon-checked-checkbox peChecked').addClass('icon-unchecked-checkbox');
                                $("input[name='scoreSetting.tp']").prop("disabled", "disabled");
                                $("input[name='scoreSetting.tp']").parent().removeClass('pe-check-by-list').addClass('add-paper-tip-text');
//                                $("input[name='scoreSetting.pd']").attr('onclick', '');
                                break;
                            default:
                                break;
                        }
                    }
                });

                //增加评卷人
                $('.add-exam-main-panel').delegate('.add-paper-user', 'click', function () {
                    if ($("#MANUAL_JUDGE_PAPER").prop("checked") == true || $("#simplejudgeSetting_jt").val() === 'MANUAL_JUDGE_PAPER') {
                        PEMO.DIALOG.selectorDialog({
                            title: '分配评卷人',
                            area: ['970px', '580px'],
                            content: [pageContext.rootPath + '/ems/exam/manage/initSelector?type=JUDGE_PAPER_USER&id=${(exam.id)!}', 'no'],
                            btn: ['关闭'],
                            btn1: function (index) {
                                layer.close(index);
                            }
                        });
                    }
                });


                $('.add-exam-main-panel').delegate('.exam-more-set-btn', 'click', function () {
                    formId = 'moreExamSettingForm';
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    $(".add-exam-main-panel").load(pageContext.rootPath + '/ems/exam/manage/initMoreSetting', params, function (e) {
                        PEBASE.peFormEvent('checkbox');
                        PEBASE.peFormEvent('radio');
                    });
                });

                /*面板hover效果事件*/
                $('.user-detail-msg-wrap').hover(
                        function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                            $(this).addClass('item-hover');

                        },
                        function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                            $(this).removeClass('item-hover');
                        }
                );

                //保存为草稿
                $(".pe-step-save-draft").click(function () {
                    var isSubject = '${(exam.subject?string('true','false'))!}';
                    var firstPageUrl = '#url=' + pageContext.rootPath + '/ems/exam/manage/initPage';
                    if ("true" === isSubject) {
                        firstPageUrl = '#url=' + pageContext.rootPath + '/ems/exam/manage/initSubjectPage';
                    }
                    editExamSetting.submitForm(function (data) {
                        PEMO.DIALOG.tips({
                            content: "保存成功！",
                            time: 1000,
                            end: function () {
                                location.href = firstPageUrl;
                            }
                        });
                    });
                });

                //保存并启用
                $(".pe-step-save-and-use").click(function () {
                    var isVal = editExamSetting.checkParams();
                    if (!isVal) {
                        return false;
                    }

                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/saveEnableExam',
                        data: $('#' + formId).serialize(),
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: "启用成功",
                                    end: function () {
                                        location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initPage&nav=examMana';
                                    }
                                });
                                return false;
                            }

                            var errorHtml = '<p style="font-size: 14px;">';
                            $.each(data.data, function (i, errMsg) {
                                errorHtml = errorHtml + '<span class="iconfont icon-tree-dot" style="font-size: 12px;margin-left: 3px;"></span>' + errMsg + '<br/>';
                            });

                            errorHtml = errorHtml + '</p>';
                            PEMO.DIALOG.alert({
                                content: errorHtml,
                                btn: ['我知道了'],
                                area: ['500px'],
                                yes: function () {
                                    layer.closeAll();
                                },
                                success: function () {
                                    $('.layui-layer .layui-layer-content').height('auto');
                                }
                            });
                        }
                    });
                });

                //科目的保存并启用
                $(".pe-subject-save-and-use").click(function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/saveEnableSubject',
                        data: $('#' + formId).serialize(),
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: "启用成功！",
                                    time: 1000,
                                    end: function () {
                                        location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initSubjectPage';
                                    }
                                });

                                return false;
                            }

                            var errorHtml = '<p style="font-size: 14px;">';
                            $.each(data.data, function (i, errMsg) {
                                errorHtml = errorHtml + '<span class="iconfont icon-tree-dot" style="font-size: 12px;margin-left: 3px;"></span>' + errMsg + '<br/>';
                            });

                            errorHtml = errorHtml + '</p>'
                            PEMO.DIALOG.alert({
                                content: errorHtml,
                                btn: ['我知道了'],
                                area: ['500px'],
                                yes: function () {
                                    layer.closeAll();
                                },
                                success: function () {
                                    $('.layui-layer .layui-layer-content').height('auto');
                                }
                            });
                        }
                    });
                });

                //考试管理员删除功能
                $('.add-exam-main-panel').delegate('.icon-inputDele', 'click', function () {
                    var id = '${(exam.id)!}';
                    var userId = [];
                    userId.push($(this).parent().attr('data-id'));
                    var data = {id: id, referIds: JSON.stringify(userId), type: 'EXAM_MANAGER'};
                    var thisSpan = $(this);
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/deleteExamAdmin',
                        data: data,
                        success: function (data) {
                            if (data.success) {
                                thisSpan.parent().remove();
                            }

                            return false;
                        }
                    })
                });

                //返回
                $('.pe-step-back-btn').on('click', function () {
                    if (subject && subject === 'true') {
                        location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initSubjectPage&nav=examMana';
                    } else {
                        location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initPage&nav=examMana';
                    }
                });

                //关闭
                $('.new-page-close-btn').on('click', function () {
                    window.close();
                });

                //上一步
                $('.pe-step-pre-btn').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    var subject = '${(exam.subject)!?string("true","false")}';
                    if (subject === 'true') {
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamPaper', params);
                    } else {
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initArrangePage', params);
                    }
                });
            },
            checkboxChecked: function (iconCheck, thisRealCheck) {
                if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                    iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                    thisRealCheck.prop('checked', 'checked');//这里在ie8下目前会报错“意外的调用了方法”,待解决
                }
            },
            checkboxUnChecked: function (iconCheck, thisRealCheck) {
                if (iconCheck.hasClass('icon-checked-checkbox')) {
                    iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                    thisRealCheck.removeProp('checked');
                }
            },
            checkParams: function () {
                var formD = $("#" + formId);
                var isChecked = ":checked";
                /*考试时长*/
                var errors = [];
                var isLimitedSubmited = 0;
                if (formD.find("input[name='examSetting.elt']" + isChecked).val() === 'LIMIT') {
                    isLimitedSubmited = isLimitedSubmited + 1;
                    var timeLen = formD.find("input[name='examSetting.el']").val();
                    if (!timeLen || $.trim(timeLen) === '' || parseInt($.trim(timeLen)) < 1) {
                        errors.push("请设置考试时长");
                    }
                }
                /*自动安排补考   补考次数*/
                if (formD.find("input[name='examSetting.mt']" + isChecked).val() === 'AUTO_MAKEUP') {
                    var makenum = formD.find("input[name='examSetting.mn']").val();
                    if (!makenum || $.trim(makenum) === '' || parseInt($.trim(makenum)) < 0) {
                        formD.find("input[name='examSetting.mn']").val(0);
                    }
                }
                /*原试卷题目分数按比例折算成满分*/
                if (formD.find("input[name='scoreSetting.st']" + isChecked).val() === 'CONVERT') {
                    var cm = formD.find("input[name='scoreSetting.cm']").val();
                    if (!cm || $.trim(cm) === '' || parseInt($.trim(cm)) < 1) {
                        errors.push("请设置 “成绩设置” 的 “原试卷题目分数按比例折算分数”");
                    }
                }
                /*得分率不低于*/
                var pr = formD.find("input[name='scoreSetting.pr']").val();
                if (!pr || $.trim(pr) === '' || parseInt($.trim(pr)) < 1) {
                    errors.push("请设置 “及格条件” 的 “得分率”");
                }
                /*定时发布成绩*/
                if (formD.find("input[name='scoreSetting.spt']" + isChecked).val() === 'MANUAL' && formD.find("input[name='scoreSetting.tp']" + isChecked).val()) {
                    var pd = formD.find("input[name='scoreSetting.pd']").val();
                    if (!pd || $.trim(pd) === '') {
                        errors.push("成绩发布设置,手动定时发布成绩时间不可为空");
                    }
                }
                /*排行榜显示设置 排名*/
                if (formD.find("input[name='rankSetting.rst']" + isChecked).val() !== 'NO_SHOW') {
                    var rst = formD.find("input[name='rankSetting.rst']" + isChecked).val();
                    var rsn = $("#rankSetting_rsn_" + rst).val();
                    if (rsn && parseInt($.trim(rsn)) < 0) {
                        errors.push("请设置 “排行榜显示设置” 的 “显示排名”");
                    }

                    formD.find("input[name='rankSetting.rsn']").val(rsn);
                }
                /*防舞弊设置 切屏次数*/
                if (formD.find("input[name='preventSetting.cs']" + isChecked).val()) {
                    var csN = formD.find("input[name='preventSetting.csN']").val();
                    if (!csN || $.trim(csN) === '' || parseInt($.trim(csN)) < 1) {
                        errors.push("请设置 “防舞弊设置” 的 “切屏次数”");
                    }
                }
                /*防舞弊设置 考试页面不操作*/
                if (formD.find("input[name='preventSetting.no']" + isChecked).val()) {
                    var noD = formD.find("input[name='preventSetting.noD']").val();
                    if (!noD || $.trim(noD) === '' || parseInt($.trim(noD)) < 1) {
                        errors.push("请设置 “防舞弊设置” 的 “考试页面不操作时长”");
                    }
                }
                /*防舞弊设置 迟到*/
                if (formD.find("input[name='preventSetting.lt']" + isChecked).val()) {
                    var ltD = formD.find("input[name='preventSetting.ltD']").val();
                    if (!ltD || $.trim(ltD) === '' || parseInt($.trim(ltD)) < 1) {
                        errors.push("请设置 “防舞弊设置” 的 “迟到时长”");
                    }
                }
                /*防舞弊设置 答卷时间少于*/
                if (formD.find("input[name='preventSetting.bs']" + isChecked).val()) {
                    isLimitedSubmited = isLimitedSubmited + 1;
                    var bsD = formD.find("input[name='preventSetting.bsD']").val();
                    if (!bsD || $.trim(bsD) === '' || parseInt($.trim(bsD)) < 1) {
                        errors.push("请设置 “防舞弊设置” 的 “答卷时间最小时长”");
                    }
                }

                if (isLimitedSubmited == 2) {
                    var bsD = formD.find("input[name='preventSetting.bsD']").val();//考试必须限制时长；
                    var timeLen = formD.find("input[name='examSetting.el']").val();//考试时长
                    if (bsD && timeLen && parseInt($.trim(bsD)) > parseInt($.trim(timeLen))) {
                        errors.push("考试限制时长必须小于考试时长;");
                    }
                }

                if (errors.length > 0) {
                    var errorHtml = '<p style="font-size: 14px;">';
                    $.each(errors, function (i, errMsg) {
                        errorHtml = errorHtml + '<span class="iconfont icon-tree-dot" style="font-size: 12px;margin-left: 3px;"></span>' + errMsg + '<br/>';
                    });

                    errorHtml = errorHtml + '</p>';
                    PEMO.DIALOG.alert({
                        content: errorHtml,
                        btn: ['我知道了'],
                        area: ['500px'],
                        yes: function () {
                            layer.closeAll();
                        },
                        success: function () {
                            $('.layui-layer .layui-layer-content').height('auto');
                        }
                    });

                    return false;
                }

                return true;
            },
            submitForm: function (callback) {
                var isVal = editExamSetting.checkParams();
                if (!isVal) {
                    return false;
                }
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exam/manage/saveExamSetting',
                    data: $('#' + formId).serialize(),
                    success: function (data) {
                        if (data.success) {
                            callback(data.data.exam.id);
                            return false;
                        }

                        PEMO.DIALOG.alert({
                            content: data.message,
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });
                    }
                });
            },
            bind:function () {
                $('.add-exam-main-panel').delegate('.exam-setting-wrap-top', 'click', function () {
                    var $that = $(this).find('.fold-setting-btn');
                    if ($that.hasClass('icon-thin-arrow-up')) {
                        $that.parents('.exam-setting-wrap').find('.exam-setting-wrap-content').slideUp();
                        $that.parents('.exam-setting-wrap').removeClass('select');
                        $that.removeClass('icon-thin-arrow-up').addClass('icon-thin-arrow-down');
                        return false;
                    }

                    $that.parents('.exam-setting-wrap').addClass('select');
                    $that.removeClass('icon-thin-arrow-down').addClass('icon-thin-arrow-up');
                    $that.parents('.exam-setting-wrap').find('.exam-setting-wrap-content').slideDown();
                });
            },
            initData: function () {
                window.addEventListener("storage", function (e) {
                    if (e.key.indexOf('EXAM_MANAGER_count_') >= 0 && e.newValue) {
                        $('.' + e.key).html(e.newValue - 1);
                        localStorage.removeItem(e.key);
                    } else if ((e.key.indexOf('JUDGE_PAPER_USER_count_') >= 0 || e.key.indexOf('JUDGE_ITEM_USER_count_') >= 0) && e.newValue) {
                        $('.' + e.key).parent().show();
                        $('.' + e.key).text(e.newValue);
                        localStorage.removeItem(e.key);
                    } else if ((e.key.indexOf('JUDGE_PAPER_USER_name_') >= 0 || e.key.indexOf('JUDGE_ITEM_USER_name_') >= 0) && e.newValue) {
                        $('.' + e.key).parent().show();
                        $('.' + e.key).find('.add-question-bank-item').remove();
                        $('.' + e.key).find('.add-paper-user').before(e.newValue);//有两个的“选择人员”的classname是 add-manager

                        localStorage.removeItem(e.key);
                    } else if (e.key.indexOf('EXAM_MANAGER_name_') >= 0 && e.newValue) {
                        $('.' + e.key).find('.add-question-bank-item').remove();
                        $('.' + e.key).find('.add-manager').before(e.newValue);//有两个的“选择人员”的classname是 add-manager
                        localStorage.removeItem(e.key);
                    }
                });
                PEBASE.peFormEvent('checkbox');
                PEBASE.peFormEvent('radio');
            }
        };

        editExamSetting.init();
        editExamSetting.initData();
    })
</script>


