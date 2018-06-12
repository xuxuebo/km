<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">考试</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">考试管理</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">
        <#if exam.optType?? && exam.optType == 'UPDATE'>
            编辑
        <#elseif exam.optType?? && exam.optType == 'VIEW'>
            预览
        <#else>
            补考设置
        </#if>
        </li>
    </ul>
</div>
<section class="steps-all-panel">
    <div class="add-exam-top-head">
        <ul class="over-flow-hide step-items-wrap <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-step-state</#if>">
            <li class="add-paper-step-item floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover basic-step-item<#else>step-complete</#if>"
                style="text-align:left;"><#--#b8ecaa-->
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
            <li class="add-paper-step-item add-paper-step-two  overStep  floatL">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">3</span>
                     </span>
                </div>
                <span class="add-step-text">考试安排</span>
            </li>
        </ul>
    </div>
    <div class="add-exam-main-panel add-exam-step-three-wrap">
        <form id="markUpExamForm">
            <div class="arrange-items-wrap">

            </div>
        </form>
    </div>
</section>
<div class="pe-btns-group-wrap" style="text-align:center;">
<#if exam.optType?? && exam.optType == 'VIEW'>
    <div class="view-exam-group-one">
        <#if exam.status?? && (exam.status == 'NO_START' || exam.status == 'PROCESS')>
            <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-basic" style="display:none;">保存
            </button>
        <#elseif exam.status?? && exam.status == 'DRAFT'>
            <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-next">发布</button>
        </#if>
        <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
        <#if exam.status !='OVER'>
            <a href="javascript:;" class="pe-view-user-btn i-need-edit-exam"><span
                    class="iconfont icon-edit"></span>我要编辑考试信息
            </a>
        </#if>
    </div>
<#elseif exam.optType?? && exam.optType == 'UPDATE'>
    <#if exam.status ?? && (exam.status == 'NO_START' || exam.status == 'PROCESS')>
        <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-basic">保存</button>
    <#elseif exam.status?? && exam.status == 'DRAFT'>
        <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-next">发布</button>
    </#if>
    <button type="button" class="pe-btn pe-btn-white pe-large-btn pe-step-back-btn">返回</button>
<#else>
    <button type="button" class="pe-btn pe-btn-purple pe-step-pre-btn">上一步</button>
    <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-next">发布</button>
</#if>
</div>
<#--预览单批次模板-->
<script type="text/template" id="previewArrange">
    <div class="arrange-item single-batch-model">
        <div class="add-exam-item-wrap" style="border: 0;">
            <input type="hidden" name="exam.id" value="${(exam.id)!}"/>
            <div class="pe-stand-form-cell">
                <label class="pe-time-wrap">
                    <span class="pe-label-name floatL"><span style="color:#f00;">*</span>补考对象:</span>
                    <div class="pe-date-wrap">
                        <label class="floatL pe-checkbox pe-uc-state-checkbox" for=""
                               style="margin-right:15px;">
                            <span class="iconfont <%if (data && data.markUpTypes && _.contains(data.markUpTypes,'NO_PASS')) {%>icon-checked-checkbox<%} else {%>icon-unchecked-checkbox<%}%>"> </span>
                            <input id="peFormEleStart" class="pe-form-ele enable"
                                   type="checkbox" name="markUpTypes" value="NO_PASS"/>未通过考生
                        </label>
                        <label class="floatL pe-checkbox pe-uc-freeze-checkbox" for="">
                            <span class="iconfont <%if (data && data.markUpTypes && _.contains(data.markUpTypes,'MISS_EXAM')) {%>icon-checked-checkbox<%} else {%>icon-unchecked-checkbox<%}%>"></span>
                            <input id="peFormEleStop" class="pe-form-ele forbidden" type="checkbox"
                                   name="markUpTypes" value="MISS_EXAM"/>缺考考生
                        </label>
                    </div>
                </label>
            </div>
            <div class="pe-stand-form-cell">
                <div class="pe-time-wrap">
                    <span class="pe-label-name floatL"><span style="color:#f00;">*</span>补考结束时间:</span>
                    <div class="pe-date-wrap">
                        <%=data.endTime?data.endTime:'暂无'%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</script>
<#--编辑单批次模板-->
<script type="text/template" id="editExamArrange">
    <div class="arrange-item single-batch-model">
        <div class="add-exam-item-wrap" style="border: 0;">
            <input type="hidden" name="exam.id" value="${(exam.id)!}"/>
            <input type="hidden" name="id" value="${(examArrange.id)!}"/>
            <div class="pe-stand-form-cell">
                <div class="pe-time-wrap">
                    <span class="pe-label-name floatL"><span style="color:#f00;">*</span>补考对象:</span>
                    <div class="pe-date-wrap">
                        <label class="floatL pe-checkbox pe-uc-state-checkbox <#if exam.status ?? && exam.status != 'DRAFT'>pe-check-by-list</#if>"
                               style="margin-right:15px;">
                            <span class="iconfont <%if (data && data.markUpTypes && _.contains(data.markUpTypes,'NO_PASS')) {%>icon-checked-checkbox<%} else {%>icon-unchecked-checkbox<%}%>"> </span>
                            <input id="peFormEleStart" class="pe-form-ele enable"
                            <%if (data && data.markUpTypes && _.contains(data.markUpTypes,'NO_PASS'))
                            {%>checked="checked"<%}%>
                            type="checkbox" name="markUpTypes" value="NO_PASS"/>未通过考生
                        </label>
                        <label class="floatL pe-checkbox pe-uc-freeze-checkbox <#if exam.status ?? && exam.status != 'DRAFT'>pe-check-by-list</#if>">
                            <span class="iconfont <%if (data && data.markUpTypes && _.contains(data.markUpTypes,'MISS_EXAM')) {%>icon-checked-checkbox<%} else {%>icon-unchecked-checkbox<%}%>"></span>
                            <input id="peFormEleStop" class="pe-form-ele forbidden" type="checkbox"
                            <%if (data && data.markUpTypes && _.contains(data.markUpTypes,'MISS_EXAM'))
                            {%>checked="checked"<%}%>
                            name="markUpTypes" value="MISS_EXAM"/>缺考考生
                        </label>
                    </div>
                </div>
            </div>
            <div class="pe-stand-form-cell">
                <div class="pe-time-wrap">
                    <span class="pe-label-name floatL"><span style="color:#f00;">*</span>补考结束时间:</span>
                    <div class="pe-date-wrap">
                        <input class="pe-table-form-text  sui-date-picker  pe-time-text pe-end-time laydate-icon"
                               name="endTime"
                               id="peExamDialogEndTime" data-suiindex='0' data-toggle='datepicker' data-date-timepicker='true'
                               type="text" value="<%=data?data.endTime:''%>"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</script>
<script>

    var optType = '${(exam.optType)!}';
    var examArrange = {};
    var source = '${(exam.source)!}';
    $(function () {
        var editArrange = {
            init: function () {
                var _this = this;
                _this.bind();
                _this.initData();
            },

            checkEndTime: function (startDom,endDom,chooseTime) {
                var $endDom = $(endDom);
                var nowTime = new Date().getTime();//选择日期点击时的当前时间
                if($(startDom).get(0)){
                    var startTime = moment($(startDom).val()).valueOf();
                }else{
                    var startTime = ''
                }
                var endTime = moment($(endDom).val()).valueOf();
                var chooseTime = moment(chooseTime).valueOf();//当前日历插件选择的时间
                if(startTime && (chooseTime < startTime)) {
                    if(!$endDom.siblings('.error').get(0)){
                        $endDom.addClass('error').after('<em id="' + $endDom.attr("name") + '-error" class="error">结束时间不能小于开始时间哦</em>')
                    }else{
                        $endDom.addClass('error');
                        $endDom.siblings('.error').show().html('结束时间不能小于开始时间哦');
                    }
                    $endDom.val('');
                    return false;

                }else if(chooseTime < nowTime){
                    if(!$endDom.siblings('.error').get(0)){
                        $endDom.addClass('error').after('<em id="' + $endDom.attr("name") + '-error" class="error">结束时间不能小于当前时间哦</em>');
                    }else{
                        $endDom.addClass('error');
                        $endDom.siblings('.error').show().html('结束时间不能小于当前时间哦');
                    }
                    $endDom.val('');
                    return false;
                }else if(startTime === chooseTime) {
                    if(!$endDom.siblings('.error').get(0)){
                        $endDom.addClass('error').after('<em id="' + $endDom.attr("name") + '-error" class="error">结束时间不能等于开始时间哦</em>')
                    }else{
                        $endDom.addClass('error');
                        $endDom.siblings('.error').show().html('结束时间不能等于开始时间哦');
                    }
                    $endDom.val('');
                    return false;
                }else{
                    if($endDom.siblings('.error').get(0)){
                        $endDom.siblings('.error').html('').hide();
                    }
                    $endDom.removeClass('error');
                    return true;
                }
            },

            initData: function () {
                var markUpTypes = [];
            <#if examArrange?? && examArrange.markUpTypes?? && (examArrange.markUpTypes?size>0)>
                <#list examArrange.markUpTypes as markUpType>
                    markUpTypes.push('${(markUpType)!}');
                </#list>
            </#if>

                examArrange = {
                    markUpTypes: markUpTypes,
                    endTime: '${(examArrange.endTime?string("yyyy-MM-dd HH:mm"))!}'
                };
                if (optType === 'VIEW') {
                    $('.arrange-items-wrap').html(_.template($('#previewArrange').html())({data: examArrange}));
                } else {
                    $('.arrange-items-wrap').html(_.template($('#editExamArrange').html())({data: examArrange}));
                    editArrange.initSelectTime();
                    PEBASE.peFormEvent('checkbox');
                }

            },

            initSelectTime: function () {
//                $('#peExamDialogStartTime0').datepicker({
//                    timepicker: true,
//                    autoclose: false
//                }).on('hide', function (t, d) {
//                    editArrange.checkEndTime()
//                });
                var $window = $(window);
                /*自定义了时间插件消失的 “事件”,在sui_datepicker.js里面会触发这个事件;*/
                $window.bind("datePickerHide", function (e,t) {
                    if(t){
                        var _thisInput = $(t.element[0]);
                        var startDomName = '',endDomName = '';
                            startDomName = '#peExamDialogStartTime';
                            endDomName = '#peExamDialogEndTime';

                        if(_thisInput.hasClass('pe-start-time')){
//                            startTimeValidate(startDomName,endDomName,_thisInput.val());
                        }else if(_thisInput.hasClass('pe-end-time')){
                            editArrange.checkEndTime(startDomName,endDomName,_thisInput.val()) ;
                        }
                    }
                })
            },

            bind: function () {
                $('.edit-step-state .basic-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamInfo', params);
                });

                $('.edit-step-state .paper-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamPaper', params);
                });


                $('.save-next').on('click', function () {
                    var isVal = editArrange.checkParams();
                    if (!isVal) {
                        return false;
                    }

                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/saveMarkUpArrange',
                        data: $('#markUpExamForm').serialize(),
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: '发布成功',
                                    time: 1000,
                                    end: function () {
                                        location.href = '#url=${ctx!}/ems/exam/manage/initPage&nav=examMana';
                                    }
                                });

                                return false;
                            }

                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn: ['我知道了'],
                                yes: function (shiIndex) {
                                    layer.close(shiIndex);
                                }
                            });
                        }
                    });
                });

                $('.pe-step-back-btn').on('click', function () {
                    location.href = '#url=${ctx!}/ems/exam/manage/initPage&nav=examMana';
                });

                //上一步
                $(".pe-step-pre-btn").on('click', function () {
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamPaper?id=${(exam.id)!}');
                });

                $('.i-need-edit-exam').on('click', function () {
                    $('.arrange-items-wrap').html(_.template($('#editExamArrange').html())({data: examArrange}));
                    editArrange.initSelectTime();
                    $(this).hide();
                    $('.save-basic').show();
                });

                $('.save-basic').on('click', function () {
                    var isVal = editArrange.checkParams();
                    if (!isVal) {
                        return false;
                    }

                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/saveMarkUpArrange',
                        data: $('#markUpExamForm').serialize(),
                        success: function (data) {
                            PEMO.DIALOG.tips({
                                content: '编辑成功',
                                time: 1000,
                                end: function () {
                                    if (optType === 'UPDATE') {
                                        $('.arrange-items-wrap').html(_.template($('#editExamArrange').html())({data: examArrange}));
                                        editArrange.initSelectTime();
                                    } else if (optType === 'VIEW') {
                                        $('.arrange-items-wrap').html(_.template($('#previewArrange').html())({data: examArrange}));
                                        $('.save-basic').hide();
                                        $('.i-need-edit-exam').show();
                                    }
                                }
                            });
                        }
                    });
                });
            },

            checkParams: function () {
                $('em.error').remove();
                var isVal = editArrange.checkEndTime();
                examArrange.endTime = $('input[name="endTime"]').val();
                var markUpTypes = $('input[name="markUpTypes"]:checked').val();
                var $markUpTypeDom = $('input[name="markUpTypes"]').parents('.pe-date-wrap');
                if (!markUpTypes) {
                    if (!$markUpTypeDom.find('.error').get(0)) {
                        $markUpTypeDom.append('<em class="error" style="position: relative;right: 0;">补考设置对象不可为空</em>');
                    }

                    isVal = false;
                } else if ($markUpTypeDom.find('.error').get(0)) {
                    $markUpTypeDom.find('.error').get(0).remove();
                }

                return isVal;
            }
        };


        editArrange.init();
    });
</script>