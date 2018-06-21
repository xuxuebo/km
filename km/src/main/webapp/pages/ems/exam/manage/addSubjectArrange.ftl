<#assign ctx=request.contextPath/>
<#--下面的import及p.pageFrame当本页面在后台配置好可以访问后，要删除-->
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">考试</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">考试管理</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">
        <#if exam.optType?? && exam.optType == 'UPDATE'>
            编辑综合考试
        <#elseif exam.optType?? && exam.optType == 'VIEW'>
            预览综合考试
        <#else>
            创建综合考试
        </#if>
        </li>
    </ul>
</div>
<section class="steps-all-panel subject-arrange-all-panel">
    <div class="add-exam-top-head">
        <ul class="over-flow-hide step-items-wrap <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-step-state</#if>">
            <li class="add-paper-step-item floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover basic-step-item<#else>step-complete</#if>"
                style="text-align:left;">
                <div class="add-step-icon-wrap">
                   <span class="iconfont icon-step-circle floatL">
                    <span class="add-step-number">1</span>
                   </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">基本信息</span>
            </li>
            <li class="add-paper-step-item add-paper-step-two floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover subject-step-item<#else>step-complete</#if>">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                           <span class="add-step-number">2</span>
                        </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">科目设置</span>
            </li>
            <li class="add-paper-step-item add-paper-step-two floatL overStep">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                           <span class="add-step-number">3</span>
                        </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">考试安排</span>
            </li>
            <li class="add-paper-step-item add-paper-step-three floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover setting-step-item</#if>">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">4</span>
                     </span>
                </div>
                <span class="add-step-text">考试设置</span>
            </li>
        </ul>
    </div>
    <div class="add-exam-main-panel add-exam-step-three-wrap">
        <form id="examArrangeForm">
            <div class="step-detail-item-panel subject-arrange-setting-wrap">
                <div class="subject-arrange-top-panel">
                    <dl class="over-flow-hide user-detail-msg-wrap">
                        <dt class="floatL user-detail-title">考生信息:</dt>
                        <dd class="user-detail-value">
                            <#--<#if (orgCount <= 0 && userCount <= 0) >-->
                                <#--<p class="no-data-message">暂无</p>-->
                            <#--</#if>-->
                            <span class="exam-has-added-user-num" <#if (orgCount <= 0 && userCount <= 0) >style="display: none;" </#if>>
                                <span <#if (userCount <= 0) >style="display: none;" </#if>><a href="${ctx!}/ems/exam/manage/initUserPage?exam.id=${(exam.id)!}" id="USER_${(exam.id)!}" target="_blank">${(userCount)!}</a>人</span>
                                <span class="count-link" <#if (orgCount <= 0 || userCount <= 0) >style="display: none;" </#if>>+</span>
                                <span <#if (orgCount <= 0) >style="display: none;" </#if>><a href="${ctx!}/ems/exam/manage/initAddOrganize?exam.id=${(exam.id)!}" id="ORGANIZE_${(exam.id)!}"target="_blank">${(orgCount)!}</a>个组织</span>
                            </span>
                            <a data-id="${(exam.id)!}" href="javascript:void(0);"
                               class="exam-add-new-user comExam-add"
                               <#if (exam.optType?? && exam.optType == 'VIEW') || (exam.status != 'DRAFT')>style="display: none;line-height: 20px;"
                               <#else>style="line-height: 20px;" </#if>>添加考生</a>
                        </dd>
                    </dl>
                    <dl class="over-flow-hide user-detail-msg-wrap show-exam-setting-info" <#if exam.optType?? && exam.optType == 'VIEW'>style="display: none;"</#if>>
                        <dt class="floatL user-detail-title">时间设置:</dt>
                        <dd class="user-detail-value subject-arrange-tip">
                            各个科目的考试时间建议不要出现交集，否则会让考生无法正常参加考试
                        </dd>
                    </dl>
                </div>
                <div class="subject-arrange-main-panel">
                </div>
            </div>
        </form>
    </div>
</section>
<div class="pe-btns-group-wrap" style="text-align:center;">
<#if exam.status == 'DRAFT' || exam.status == 'NO_START' || exam.status == 'PROCESS'>
    <#if exam.optType?? && exam.optType == 'VIEW'>
        <div class="view-exam-group-one">
            <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-basic" style="display:none;">保存</button>
            <button type="button" class="pe-btn pe-btn-white pe-step-back-btn new-page-close-btn">关闭</button>
            <a href="javascript:;" class="pe-view-user-btn i-need-edit-exam"><span class="iconfont icon-edit"></span>我要编辑考试信息
            </a>
        </div>
    <#else>
        <#if exam.optType?? && exam.optType == 'UPDATE'>
            <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-basic">保存</button>
        <#else>
            <button type="button" class="pe-btn pe-btn-purple pe-step-pre-btn">上一步</button>
            <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-next">下一步</button>
        </#if>
        <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
    </#if>
</#if>
</div>
<script type="text/template" id="preivewArrangeTemp">
    <dl class="over-flow-hide user-detail-msg-wrap">
        <dt class="floatL user-detail-title">时间设置:</dt>
    </dl>
    <%_.each(data,function(examArrange,index){%>
    <div class="item-subject-setting-wrap">
        <dl class="over-flow-hide user-detail-msg-wrap">
            <dt class="floatL user-detail-title"><span class="iconfont subject-icon icon-my-examination floatL" style="margin-left:10px;"></span>科目<%=index+1%>:</dt>
            <input type="hidden" name="id" value="<%=examArrange.id%>"/>
            <dd class="user-detail-value" style="margin-bottom: 2px;">
                <div style="margin-bottom:22px;">
                        <span class="floatL subject-arrange-type">[
                            <%if(examArrange.subject.examType == "ONLINE") {%>
                            线上
                            <%}else if(examArrange.subject.examType =="OFFLINE"){%>
                            线下
                            <%}else{%>
                            综合考试
                            <%}%>
                            ]</span>
                    <div class="subject-arrange-name">
                        <%=examArrange.subject.examName%>
                    </div>
                </div>
                <div>
                    <div class="pe-time-input-wrap">
                        <div class="pe-date-wrap" style="width: 300px!important;">
                            <%=moment(examArrange.startTime).format('YYYY-MM-DD HH:mm')%>&nbsp;&nbsp;~&nbsp;&nbsp;<%=moment(examArrange.endTime).format('YYYY-MM-DD HH:mm')%>
                        </div>
                    </div>
                </div>
            </dd>
        </dl>
    </div>
    <%});%>
</script>

<script type="text/template" id="subjectArrangeTemp">
    <%for(var i=0,len=data.length;i<len;i++){%>
        <div class="item-subject-setting-wrap">
            <dl class="over-flow-hide user-detail-msg-wrap">
                <dt class="floatL user-detail-title"><span class="iconfont subject-icon icon-my-examination floatL" style="margin-left:10px;"></span>科目<%=i+1%>:</dt>
                <input type="hidden" name="id" value="<%=data[i].id%>"/>
                <dd class="user-detail-value" style="margin-bottom: 2px;">
                    <div style="margin-bottom:22px;">
                        <span class="floatL subject-arrange-type">[
                            <%if(data[i].subject.examType == "ONLINE") {%>
                            线上
                            <%}else if(data[i].subject.examType =="OFFLINE"){%>
                            线下
                            <%}else{%>
                            综合考试
                            <%}%>
                            ]</span>
                        <input type="hidden" name="subject.examName" value="<%=data[i].subject.examName%>"/>
                        <input type="hidden" name="subject.examType" value="<%=data[i].subject.examType%>"/>
                        <div class="subject-arrange-name">
                            <%=data[i].subject.examName%>
                        </div>
                    </div>
                    <div>
                        <div class="pe-time-input-wrap">
                            <div class="pe-date-wrap">
                                <%if ((moment(data[i].startTime).valueOf() < moment(new Date()).valueOf()) && '${(exam.status)}' != 'DRAFT') {%>
                                <#--<input id="subjectStartTime<%=i%>"-->
                                       <#--class="pe-table-form-text pe-time-text .pe-time-just-show pe-start-time startTime laydate-icon" readonly="readonly"-->
                                       <#--type="text" name="startTime<%=i%>" style="color:#cbcbcb;"-->
                                <#--<%if (data[i].startTime){%>-->
                                <#--value="<%=moment(data[i].startTime).format('YYYY-MM-DD HH:mm')%>"-->
                                <input type="text" style="display:none;" name="startTime<%=i%>" class="startTime"
                                       value="<%=moment(data[i].startTime).format('YYYY-MM-DD HH:mm')%>"/>
                                <span class="pe-table-form-text" style="opacity:0.4;width:156px;display:inline-block;line-height:20px;border-color: #b6acac;"><%=moment(data[i].startTime).format('YYYY-MM-DD HH:mm')%></span>

                                <%} else {%>
                                <input id="subjectStartTime<%=i%>" data-suiindex = '<%=i%>'
                                       class="pe-table-form-text pe-time-text  sui-date-picker pe-start-time startTime laydate-icon" readonly="readonly"
                                       type="text" name="startTime<%=i%>"
                                    <%if (data[i].startTime){%>
                                    value="<%=moment(data[i].startTime).format('YYYY-MM-DD HH:mm')%>"
                                    <%}%>>  `
                                <%}%>
                            </div>
                            <span class="pe-time-concat-line">-</span>
                            <div class="pe-date-wrap">
                                <%if ((moment(data[i].endTime).valueOf() < moment(new Date()).valueOf()) && '${(exam.status)}' != 'DRAFT') {%>
                                <input id="subjectEndTime<%=i%>" class="pe-table-form-text pe-time-just-show pe-time-text pe-end-time endTime laydate-icon"
                                       type="text" name="endTime<%=i%>" readonly="readonly" style="color:#cbcbcb;"
                                <%if (data[i].endTime){%>
                                value="<%=moment(data[i].endTime).format('YYYY-MM-DD HH:mm')%>"
                                <%}%>>
                                <%} else {%>
                                <input id="subjectEndTime<%=i%>" data-suiindex = '<%=i%>'
                                       class="pe-table-form-text sui-date-picker pe-time-text pe-end-time endTime laydate-icon"
                                       type="text" name="endTime<%=i%>" readonly="readonly"
                                     <%if (data[i].endTime){%>
                                    value="<%=moment(data[i].endTime).format('YYYY-MM-DD HH:mm')%>"
                                    <%}%>>
                                <%}%>
                            </div>
                            <div class="validate-form-cell" style="height:34px;display:inline-block;">

                            </div>
                        </div>
                    </div>
                </dd>
            </dl>
        </div>
    <%}%>
</script>
    <script>
        var datepickerObj = {};
        /*开始时间选择判断*/
        function startTimeValidate(startDom,endDom,chooseTime){
            var $starDom = $(startDom);
            var nowTime = new Date().getTime();//选择日期点击时的当前时间
            var endTime = moment($(endDom).val()).valueOf();
            var chooseTime = moment(chooseTime).valueOf();//当前日历插件选择的时间
            var $errorDom = $starDom.parent('.pe-date-wrap').siblings('.validate-form-cell').find('.error');

            /*小于当前时间校验*/
            if(chooseTime < nowTime) {
                if(!$errorDom.get(0)){
                    $starDom.addClass('error').parent('.pe-date-wrap').siblings('.validate-form-cell').append('<em id="' + $starDom.attr("name") + '-error" class="error">开始时间不能小于当前时间哦</em>');
                }else{
                    $starDom.addClass('error');
                    $errorDom.show().html('开始时间不能小于当前时间哦');
                }
//                $starDom.val('');
                return false;
            }else if(endTime && chooseTime > endTime){
                /*大于结束时间校验*/
                if(!$errorDom.get(0)){
                    $starDom.addClass('error').parent('.pe-date-wrap').siblings('.validate-form-cell').append('<em id="' + $starDom.attr("name") + '-error" class="error">开始时间不能大于结束时间哦</em>');
                }else{
                    $starDom.addClass('error');
                    $errorDom.show().html('开始时间不能大于结束时间哦');
                }
//                $starDom.val('');
            }else if(chooseTime === endTime){
                /*大于结束时间校验*/
                if(!$errorDom.get(0)){
                    $starDom.addClass('error').parent('.pe-date-wrap').siblings('.validate-form-cell').append('<em id="' + $starDom.attr("name") + '-error" class="error">开始时间不能等于结束时间哦</em>');
                }else{
                    $starDom.addClass('error');
                    $errorDom.show().html('开始时间不能等于结束时间哦');
                }
//                $starDom.val('');
            }else{
                if($errorDom.get(0)){
                    $errorDom.html('').hide();
                }
                $starDom.removeClass('error');
            }

        }
        /*结束时间判断*/
        function endTimeValidate(startDom,endDom,chooseTime){
            var $endDom = $(endDom);
            var nowTime = new Date().getTime();//选择日期点击时的当前时间
            if($(startDom).get(0)){
                var startTime = moment($(startDom).val()).valueOf();
            }else{
                var startTime = ''
            }
            var endTime = moment($(endDom).val()).valueOf();
            var chooseTime = moment(chooseTime).valueOf();//当前日历插件选择的时间
            var $errorDom = $endDom.parent('.pe-date-wrap').siblings('.validate-form-cell').find('.error');

            if(startTime && (chooseTime < startTime)) {
                if(!$errorDom.get(0)){
                    $endDom.addClass('error').parent('.pe-date-wrap').siblings('.validate-form-cell').append('<em id="' + $endDom.attr("name") + '-error" class="error">结束时间不能小于开始时间哦</em>')
                }else{
                    $endDom.addClass('error')
                    $errorDom.show().html('结束时间不能小于开始时间哦');
                }
//                $endDom.val('');
                return false;

            }else if(chooseTime < nowTime){
                if(!$errorDom.get(0)){
                    $endDom.addClass('error').parent('.pe-date-wrap').siblings('.validate-form-cell').append('<em id="' + $endDom.attr("name") + '-error" class="error">结束时间不能小于当前时间哦</em>');
                }else{
                    $endDom.addClass('error');
                    $errorDom.show().html('结束时间不能小于当前时间哦');
                }
//                $endDom.val('');
                return false;
            } else if(chooseTime === startTime){
                if(!$errorDom.get(0)){
                    $endDom.addClass('error').parent('.pe-date-wrap').siblings('.validate-form-cell').append('<em id="' + $endDom.attr("name") + '-error" class="error">结束时间不能等于开始时间哦</em>');
                }else{
                    $endDom.addClass('error');
                    $errorDom.show().html('结束时间不能等于开始时间哦');
                }
//                $endDom.val('');
                return false;
            }else{
                if($errorDom.get(0)){
                    $errorDom.html('').hide();
                }
                $endDom.removeClass('error');
            }
        }

        /*渲染时间插件*/
        function renderDatePicker(thisDom,startDom,endDom){
//        alert('出来了没有呀?');
            var _thisDom = $(thisDom);
            datepickerObj = _thisDom.datepicker({
                timepicker:true,
                autoclose: false
            }).on('hide',function(t,d){
                if(_thisDom.hasClass('pe-start-time')){
                    startTimeValidate(startDom,endDom,_thisDom.val());
                }else if(_thisDom.hasClass('pe-end-time')){
                    endTimeValidate(startDom,endDom,_thisDom.val());
                }
            });
        }

        /*每次模板渲染时，找到所有的时间input渲染成时间组件*/
        function findDateInput(){
            var allDateInput = $('.sui-date-picker');
            if(allDateInput.get(0)){
                for(var i = 0,iLen = allDateInput.length;i < iLen;i++){
                    var thisInput = $(allDateInput[i]);
                    var startDomName = '',endDomName = '';
                    if(thisInput.attr('data-suiindex') === 'single'){
                        startDomName = '#subjectStartTime';
                        endDomName = '#subjectEndTime';
                    }else{
                        var thisArrangeIndex = thisInput.attr('data-suiindex');
                        startDomName = '#subjectStartTime' + thisArrangeIndex;
                        endDomName = '#subjectEndTime' + thisArrangeIndex;
                    }
                    renderDatePicker(thisInput,startDomName,endDomName);
                }
            }

        }

        $(function () {
            $('.comExam-add').on('click', function () {
                var _thisExamId = $(this).attr('data-id');
                window.open("${ctx!}/ems/exam/manage/initUserPage?exam.id=" + _thisExamId, 'EXAM_ADD_USER');
            });

            var examId = '${(exam.id)!}';
            var optType = '${(exam.optType)!}';
            var examArranges = [];
            var editOrgUrl = '${ctx!}/ems/exam/manage/initAddOrganize?exam.id=${(exam.id)!}';
            var editUserUrl = '${ctx!}/ems/exam/manage/initUserPage?exam.id=${(exam.id)!}';
            var $userAdd = $('#USER_${(exam.id)!}');
            var $OrgAdd = $('#ORGANIZE_${(exam.id)!}');
            /*索取页面所有的input的name的数组集合*/
            function getInputName(dom){

                var itemInputs = $(dom).find('input[type="text"]');
                var itemNames = [];
                for(var j=0,len=itemInputs.length;j<len;j++){
                    itemNames.push($(itemInputs[j]).attr('name'))
                }
                editArrange.validateObj = produceValidateObj(itemNames);
            }
            /*动态生成校验的选项*/
            function produceValidateObj(names){
                var thisValidateObj = {
                    errorElement: 'em',
                    rules: {},
                    ignore: "",
                    messages: {}
                };
                for(var i=0;i<names.length;i++){
                    thisValidateObj.rules[names[i]] = 'required';
                    var subjectStartTimeReg = /startTime/i;
                    var subjectEndTimeReg = /endTime/i;
                    var endTimeReg = /endTime/i;
                    if(subjectStartTimeReg.test(names[i])){
                        thisValidateObj.messages[names[i]] = '时间不能为空哦';
                    }else if(subjectEndTimeReg.test(names[i])){
                        thisValidateObj.messages[names[i]] = '时间不能为空哦';
                    }
                }

                return thisValidateObj;
            }
            var editArrange = {
                validateObj:{},
                validateFunc:function(){
                    /*校验默认设置对象，这里有对表单验证通过后所执行的一些方法*/
                    var defaultValidate = {
                        errorElement:'em',
                        errorPlacement:function(error,element){
                            error.appendTo($(element).parents('.pe-time-input-wrap').find('.validate-form-cell'));
                        },
                        submitHandler:function(form){

                        }
                    };
                    var formValidate = $.extend(defaultValidate, editArrange.validateObj);
                    /*校验*/
                    if($.data( $('#examArrangeForm').get(0), "validator")){
                        /*对validate不对新增的input进行校验的问题处理*/
                        $('#examArrangeForm').data('validator','');
                    }
                    $("#examArrangeForm").validate(formValidate);
                },
                initData:function(){
                    PEBASE.ajaxRequest({
                        url : pageContext.rootPath + '/ems/exam/manage/listSubject',
                        data:{examId:'${exam.id}'},
                        success:function(data){
                            examArranges = data;
                            if(optType === 'VIEW'){
                                $('.subject-arrange-main-panel').html(_.template($('#preivewArrangeTemp').html())({'data': examArranges}));
                            } else {
                                $('.subject-arrange-main-panel').html(_.template($('#subjectArrangeTemp').html())({'data': examArranges}));
                                findDateInput();
                                $userAdd.attr('href',editUserUrl);
                                $OrgAdd.attr('href',editOrgUrl);
                            }
                            /*设置检验规则对象*/
                            getInputName('.subject-arrange-setting-wrap');
                            editArrange.validateFunc();
                        }
                    });
                },

                initPreviewPage:function(){
                    $('.subject-arrange-main-panel').html(_.template($('#preivewArrangeTemp').html())({'data': examArranges}));
                    $('.i-need-edit-exam').show();
                    $('.show-exam-setting-info').hide();
                    $('.exam-add-new-user').hide();
                    $('.save-basic').hide();
                    $userAdd.removeAttr('href');
                    $OrgAdd.removeAttr('href');
                },

                init: function () {
                    /*科目安排表单校验*/
                   /* var isValidate=$("#examArrangeForm").validate({
                        errorElement:'em',
                        rules:{
                            'examArranges[0].batchName':'required',
                            'examArranges[0].startTime':'required',
                            'examArranges[0].endTime':'required'
                        },
                        messages:{
                            'examArranges[0].batchName':'批次名称必填的哦',
                            'examArranges[0].startTime':'开始时间不能为空哦',
                            'examArranges[0].endTime':'结束时间不能为空哦'
                        },
                        submitHandler:function(form){

                        }
                    });*/

                    $('.i-need-edit-exam').on('click',function(){
                        $('.subject-arrange-main-panel').html(_.template($('#subjectArrangeTemp').html())({'data': examArranges}));
                        findDateInput();
                        $('.save-basic').show();
                        $(this).hide();
                        $('.exam-add-new-user').show();
                        $('.no-data-message').hide();
                        $('.show-exam-setting-info').show();
                        $userAdd.attr('href',editUserUrl);
                        $OrgAdd.attr('href',editOrgUrl);
                        /*设置检验规则对象*/
                        getInputName('.subject-arrange-setting-wrap');
                        editArrange.validateFunc();
                    });

                    $('.pe-step-back-btn').on('click', function () {
                        history.back(-1);
                    });

                    //关闭
                    $('.new-page-close-btn').on('click', function () {
                        window.close();
                    });


                    $('.pe-step-pre-btn').on('click',function(){
                        var params = {id: '${(exam.id)!}', optType: optType,examType:'${exam.examType}'};
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initSubjectSetting', params);
                    });

                    //点击下一步
                    $('.save-next').on('click', function () {
                        var isVal = $("#examArrangeForm").valid();
                        if(!isVal){
                            return false;
                        }
                        editArrange.submitForm(function (data) {
                            var params = {id: '${(exam.id)!}', optType: optType,examType:'${exam.examType}'};
                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initComprehensiveSetting', params);
                        })
                    });

                    $('.save-basic').on('click', function () {
                        var isVal = $("#examArrangeForm").valid();
                        if(!isVal){
                            return false;
                        }
                        editArrange.submitForm(function(data){
                            PEMO.DIALOG.tips({
                                content: '编辑成功',
                                end:function(){
                                    if(optType ==='VIEW'){
                                        editArrange.initPreviewPage();
                                    }

                                    examArranges = data.examArranges;
                                }
                            });

                            return false;
                        })
                    });
                    $('.edit-step-state .basic-step-item').on('click', function () {
                        var params = {id: '${(exam.id)!}', optType: optType};
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamInfo', params);
                    });

                    $('.edit-step-state .setting-step-item').on('click', function () {
                        var params = {id: '${(exam.id)!}', optType: optType};
                        var examTye = '${(exam.examType)!}';
                        if (examTye === 'OFFLINE') {
                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initOfflineExamSetting', params);
                        }else if(examTye === 'ONLINE'){
                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamSetting', params);
                        }else if(examTye=='COMPREHENSIVE'){
                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initComprehensiveSetting', params);
                        }
                    });

                    $('.edit-step-state .subject-step-item').on('click', function () {
                        var params = {id: '${(exam.id)!}', optType: optType};
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initSubjectSetting', params);
                    });
                },
                submitForm: function (callback) {
                    //校验时间是否必填
                    var subjectWrap = $('.item-subject-setting-wrap');
                    var subjectParam = {};
                    var timeIsError = false;
                    for (var i = 0; i < subjectWrap.length; i++) {
                        var sub = subjectWrap.eq(i);
                        var now = new Date().getTime();
                        var $startDom=$('#subjectStartTime'+i);
                        var $endDom=$('#subjectEndTime'+i);
                        var st = new Date($startDom.val()).getTime();
                        var end = new Date($endDom.val()).getTime();
                        var $errorDom = $startDom.parent('.pe-date-wrap').siblings('.validate-form-cell').find('.error');

                        if (st < now) {
                            timeIsError=true;
                            if(!$errorDom.get(0)){
                                $startDom.addClass('error').parent('.pe-date-wrap').siblings('.validate-form-cell').append('<em id="' + $startDom.attr("name") + '-error" class="error">开始时间不能小于当前时间哦</em>');
                            }else{
                                $startDom.addClass('error');
                                $errorDom.show().html('开始时间不能小于当前时间哦');
                            }

                        }

                        if (st > end) {
                            timeIsError=true;
                            if (!$errorDom.get(0)) {
                                $startDom.addClass('error').parent('.pe-date-wrap').siblings('.validate-form-cell').append('<em id="' + $startDom.attr("name") + '-error" class="error">开始时间不能大于结束时间哦</em>');
                            } else {
                                $startDom.addClass('error');
                                $errorDom.show().html('开始时间不能大于结束时间哦');
                            }

                        }

                        subjectParam['examArranges[' + i + '].id'] = sub.find('input[name="id"]').val();
                        subjectParam['examArranges[' + i + '].startTime'] = sub.find('input.startTime').val();
                        subjectParam['examArranges[' + i + '].endTime'] = sub.find('input.endTime').val();
                        subjectParam['examArranges[' + i + '].exam.id'] = examId;
                        subjectParam['examArranges[' + i + '].subject.examName'] = sub.find('input[name="subject.examName"]').val();
                        subjectParam['examArranges[' + i + '].subject.examType'] = sub.find('input[name="subject.examType"]').val();
                    }
                    if(timeIsError){
                        return false;
                    }
                    var data = $.extend({'id': examId, 'optType': optType}, subjectParam);
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/saveSubjectArrange',
                        data: data,
                        success: function (data) {
                            if (data.success) {
                                callback(data.data);
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
                }
            };

            editArrange.init();
            editArrange.initData();
        });

        function countUser(arrangeId, referType) {
            var $this = $('#' + referType + '_${(exam.id)!}');
            if($this.parents().is(':hidden')){
                $this.parents().show();
            }

            PEBASE.ajaxRequest({
                url:pageContext.rootPath+'/ems/exam/manage/countExamUser',
                data:{examId:'${(exam.id)!}',referType:referType},
                success:function (data) {
                    if(!$('#USER_${(exam.id)!}').parents().is(':hidden') && !$('#ORGANIZE_${(exam.id)!}').parents().is(':hidden')){
                        $this.parents('span').siblings('.count-link').show();
                    }

                    $this.parents('.exam-add-user-wrap').find('.exam-add-new-user').css('marginLeft','10px');
                    $this.text(data);
                }
            });
        }
    </script>
