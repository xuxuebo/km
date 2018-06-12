<#assign ctx=request.contextPath/>
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
<section class="steps-all-panel">
    <div class="add-exam-top-head">
        <ul class="over-flow-hide step-items-wrap <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW' )>edit-step-state</#if>">
            <li class="add-paper-step-item floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW' )>edit-btn-hover basic-step-item<#else>step-complete</#if>" style="text-align:left;">
                <div class="add-step-icon-wrap">
                   <span class="iconfont icon-step-circle floatL">
                    <span class="add-step-number">1</span>
                   </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">基本信息</span>
            </li>
            <li class="add-paper-step-item add-paper-step-two floatL overStep">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                        <span class="iconfont icon-step-circle floatL">
                           <span class="add-step-number">2</span>
                        </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">科目设置</span>
            </li>
            <li class="add-paper-step-item add-paper-step-two floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW' )>edit-btn-hover arrange-step-item</#if>">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                           <span class="add-step-number">3</span>
                        </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">考试安排</span>
            </li>
            <li class="add-paper-step-item add-paper-step-three floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW' )>edit-btn-hover setting-step-item</#if>">
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
    <form id="subjectSettingForm">
        <div class="add-exam-main-panel subject-setting-all-panel">
            <div class="step-detail-item-panel">
                <div class="subject-detail-panel">

                </div>
                <input type="hidden" name="id" value="${(exam.id)!}">
                <#if exam.status?? && exam.status == 'DRAFT'>
                <button type="button" class="add-subject-btn" <#if exam.optType?? && (exam.optType == 'VIEW')>style="display: none;" </#if>>
                    <span class="iconfont icon-new-add"></span>添加科目
                </button>
                </#if>
            </div>

        </div>
    </form>
</section>
<div class="pe-btns-group-wrap" style="margin:50px auto 60px;text-align:center;">
    <#if exam.status == 'DRAFT'>
        <#if exam.optType?? && (exam.optType == 'VIEW')>
            <div class="view-exam-group-one">
                <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-basic"  style="display: none;">保存</button>
                <button type="button" class="pe-btn pe-btn-white pe-step-back-btn new-page-close-btn">关闭</button>
                <a href="javascript:;" class="pe-view-user-btn i-need-edit-exam"><span
                        class="iconfont icon-edit"></span>我要编辑考试信息
                </a>
            </div>
        <#elseif exam.optType?? && exam.optType == 'UPDATE'>
            <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-basic">保存</button>
            <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
        <#else>
            <button type="button" class="pe-btn pe-btn-purple pe-step-next-btn pre-step">上一步</button>
            <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-next">下一步</button>

            <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
        </#if>
    <#else>
        <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">关闭</button>
    </#if>
</div>
<script type="text/template" id="previewSubjectTemp">
    <div class="item-subject-setting-wrap">
        <a href="javascript:;" class="iconfont  icon-dialog-close-btn dele-subject-btn"></a>
        <dl class="user-detail-msg-wrap exam-setting-msg-wrap">
            <dt class="floatL user-detail-title" style="margin-top:2px\9;"><span class="iconfont subject-icon icon-my-examination"></span><span style="color: #999;">科目<span class="subject-num"><%=(examArrange.index+1)%>:</span></span></dt>
            <dd class="user-detail-value">
                <p style="margin-bottom: 16px;color: #444;"><%=examArrange.subject?examArrange.subject.examName:'暂无'%></p>
                <div style="margin-bottom:16px;">
                    <label class="pe-checkbox">
                        <%if (examArrange.subjectSetting && examArrange.subjectSetting.sp) {%>
                        <span class="iconfont icon-checked-checkbox peChecked" style="color:#8cccf0;"></span>
                        <%} else {%>
                        <span class="iconfont icon-unchecked-checkbox"></span>
                        <%}%>
                        若该科目成绩未通过，则最终成绩强制未通过
                    </label>
                </div>
                <div>
                    <label class="pe-checkbox">
                        <%if (examArrange.subjectSetting && examArrange.subjectSetting.so) {%>
                        <span class="iconfont icon-checked-checkbox peChecked" style="color:#8cccf0;"></span>
                        <%} else {%>
                        <span class="iconfont icon-unchecked-checkbox"></span>
                        <%}%>
                        强制科目顺序，只有通过该科目的考试，才能参加下面的科目考试
                    </label>
                </div>
            </dd>
        </dl>
    </div>
</script>

<script type="text/template" id="editSubjectTemp">
    <div class="item-subject-setting-wrap">
        <%if(status !='ENABLE'){%>
            <a href="javascript:;" class="iconfont  icon-dialog-close-btn dele-subject-btn"
               <%if( length <= 2){%>style="display:none;" <%}%>></a>
        <%}%>
        <dl class="user-detail-msg-wrap exam-setting-msg-wrap">
            <dt class="floatL user-detail-title" style="margin-top:2px\9;"><span class="iconfont subject-icon icon-my-examination floatL"></span><span class="floatL">科目<span class="subject-num"><%=(examArrange.index+1)%></span></span>:</dt>
            <dd class="user-detail-value">
                <%if (examArrange.subject && examArrange.subject.examName) {%>
                    <a title="<%=examArrange.subject.examName%>" class="add-question-bank-item subject-list " style="margin-bottom:16px;max-width: 292px;width:auto;">
                        <span class="paper-random-bank"><%=examArrange.subject.examName%></span>
                                            <%if(status !='ENABLE'){%>
                                            <span class="iconfont icon-inputDele input-dele">
                                            <%}%>
                                            <input type="hidden" name="examArranges[<%=examArrange.index%>].subject.id" value="<%=examArrange.subject.id%>"></span>
                        <input type="hidden" name="examArranges[<%=examArrange.index%>].id" value="<%=examArrange.id%>">
                        <input type="hidden" name="examArranges[<%=examArrange.index%>].subject.examName" value="<%=examArrange.subject.examName%>">
                    </a>
                     <a href="javascript:;" class="subject-setting-choose" style="display: none">选择科目</a>
                <%} else {%>
                    <a href="javascript:;" class="subject-setting-choose">选择科目</a>
                <%}%>
                <div style="margin-bottom:16px;">
                    <label class="pe-checkbox">
                        <%if (examArrange.subjectSetting && examArrange.subjectSetting.sp) {%>
                            <span class="iconfont icon-checked-checkbox peChecked"></span>
                            <input class="pe-form-ele subjects-pass" type="checkbox" name="examArranges[<%=examArrange.index%>].subjectSetting.sp" value="true" checked="checked"
                                <%if(status ==='ENABLE'){%> disabled="disabled"<%}%>/>
                        <%} else {%>
                            <span class="iconfont icon-unchecked-checkbox"></span>
                            <input class="pe-form-ele subjects-pass" type="checkbox" name="examArranges[<%=examArrange.index%>].subjectSetting.sp" value="true"
                                <%if(status ==='ENABLE'){%> disabled="disabled"<%}%>/>
                        <%}%>
                        若该科目成绩未通过，则最终成绩强制未通过
                    </label>
                </div>
                <div>
                    <label class="pe-checkbox">
                    <%if (examArrange.subjectSetting && examArrange.subjectSetting.so) {%>
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                        <input class="pe-form-ele subject-order" type="checkbox" value="true"  name="examArranges[<%=examArrange.index%>].subjectSetting.so" checked="checked"
                            <%if(status ==='ENABLE'){%> disabled="disabled"<%}%>/>
                    <%} else {%>
                        <span class="iconfont icon-unchecked-checkbox"></span>
                        <input class="pe-form-ele subject-order" type="checkbox" value="true" name="examArranges[<%=examArrange.index%>].subjectSetting.so"
                            <%if(status ==='ENABLE'){%> disabled="disabled"<%}%>/>
                    <%}%>
                        强制科目顺序，只有通过该科目的考试，才能参加下面的科目考试
                    </label>
                </div>
            </dd>
        </dl>
    </div>
</script>
<script type="text/javascript">
    $(function () {
        if(typeof changeExamManaStorage === 'function'){
            window.removeEventListener("storage", changeExamManaStorage,false);
        }
        //保存试卷基本信息
        var optType = '${(exam.optType)!}';
        var examTye = '${(exam.examType)!}';
        var examArranges = [];
        var subjectBasicInfo = {
            initExamArrange:function(){
                <#if exam.examArranges?? && exam.examArranges?size gt 0>
                    <#list exam.examArranges as examArrange>
                        var examArrange = {};
                        var subject = {};
                        var subjectSetting = {};
                        examArrange.subject = subject;
                        examArrange.subjectSetting = subjectSetting;
                        examArrange.index = parseInt('${(examArrange_index)}');
                        subject.examName = '${(examArrange.subject.examName)!}';
                        examArrange.id = '${(examArrange.id)!}';
                        subject.id = '${(examArrange.subject.id)!}';
                        var so = '${(examArrange.subjectSetting.so?string('true','false'))!}';
                        subjectSetting.so = so && so === 'true';
                        var sp = '${(examArrange.subjectSetting.sp?string('true','false'))!}';
                        subjectSetting.sp = sp && sp === 'true';
                        examArranges.push(examArrange);
                    </#list>
                </#if>
            },

            initData:function(){
                subjectBasicInfo.initExamArrange();
                if(examArranges.length<=0){
                    if(optType === 'VIEW'){
                        var examArrange = {};
                        examArrange.index = 0;
                        $('.subject-detail-panel').append(_.template($('#previewSubjectTemp').html())({examArrange:examArrange}));
                        examArrange.index = 1;
                        $('.subject-detail-panel').append(_.template($('#previewSubjectTemp').html())({examArrange:examArrange}));
                    } else {
                        subjectBasicInfo.addSubject({});
                        subjectBasicInfo.addSubject({});
                    }

                } else {
                    var status = '${(exam.status)!}';
                    $.each(examArranges,function(index,examArrange){
                        var arrangeLength = examArranges.length;
                        if(optType === 'VIEW'){
                            $('.subject-detail-panel').append(_.template($('#previewSubjectTemp').html())({examArrange:examArrange}));
                        } else {
                            $('.subject-detail-panel').append(_.template($('#editSubjectTemp').html())({examArrange:examArrange,status:status,length:arrangeLength}));
                            PEBASE.peFormEvent('checkbox');
                        }
                    });
                }
            },

            addSubject:function(examArrange){
                var index = $('.item-subject-setting-wrap').length;
                examArrange.index = index;
                $('.subject-detail-panel').append(_.template($('#editSubjectTemp').html())({examArrange:examArrange,length:index}));
                PEBASE.peFormEvent('checkbox');
                if($('.item-subject-setting-wrap').length === 10){
                    $('.add-subject-btn').hide();
                }
            },

            resetInputName:function(){
                $('.item-subject-setting-wrap').each(function(index,ele){
                    $(ele).find('input[name^="examArranges"]').each(function(cIndex,cEle){
                        var nameValue = $(this).attr('name');
                        var pointIndex = nameValue.indexOf(".");
                        nameValue = "examArranges["+index+"]"+nameValue.substr(pointIndex);
                        $(this).attr('name',nameValue);
                    });
                });
            },

            init:function(){
                $('.i-need-edit-exam').on('click',function(){
                    $('.subject-detail-panel').html('');
                    if(!examArranges || examArranges.length<=0){
                        subjectBasicInfo.addSubject({});
                        subjectBasicInfo.addSubject({});
                    } else {
                        $.each(examArranges,function(index,examArrange){
                            $('.subject-detail-panel').append(_.template($('#editSubjectTemp').html())({examArrange:examArrange}));
                        });
                    }

                    PEBASE.peFormEvent('checkbox');
                    $('.save-basic').show();
                    $(this).hide();
                    $('.add-subject-btn').show();
                });

                //点击第一步
                $('.edit-step-state .basic-step-item').on('click',function(){
                    var params = {id:'${(exam.id)!}',optType:optType};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamInfo',params);
                });

                //点击考试安排
                $('.edit-step-state .arrange-step-item').on('click',function(){
                    var params = {id:'${(exam.id)!}',optType:optType};
                    if(examTye === 'COMPREHENSIVE'){
                        var subjectIsError = subjectBasicInfo.checkSubject();
                        if(subjectIsError){
                            return false;
                        }
                    }
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initArrangePage',params);
                });

                //点击考试设置
                $('.edit-step-state .setting-step-item').on('click',function(){
                    var params = {id:'${(exam.id)!}',optType:optType};
                    if (examTye === 'OFFLINE') {
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initOfflineExamSetting', params);
                    }else if(examTye === 'ONLINE'){
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamSetting', params);
                    }else if(examTye==='COMPREHENSIVE'){
                        var subjectIsError = subjectBasicInfo.checkSubject();
                        if(!subjectIsError){
                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initComprehensiveSetting', params);
                        }
                    }
                });

                //返回
                $('.pe-step-back-btn').on('click', function () {
                    history.back(-1);
                });

                //关闭
                $('.new-page-close-btn').on('click', function () {
                    window.close();
                });

                //上一步
                $(".pre-step").on('click', function () {
                    var params = {id:'${(exam.id)!}',optType:optType};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamInfo',params);
                });

                //下一步
                $('.save-next').on('click', function () {
                    subjectBasicInfo.submitForm(function (data) {
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initArrangePage?id='+data.id);
                    });
                });

                //保存
                $('.save-basic').on('click',function(){
                    subjectBasicInfo.submitForm(function (data) {
                        PEMO.DIALOG.alert({
                            content: '编辑成功',
                            time: 1000,
                            end:function(){
                                if (optType === 'VIEW') {
                                    var params = {id: '${(exam.id)!}', optType: optType};
                                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initSubjectSetting', params);
                                }
                            },
                            success:function(){
                                $('.layui-layer .layui-layer-content').height(26);
                            }
                        });
                    });
                });

                /*区块hover效果事件*/
                $('.subject-setting-all-panel').delegate('.item-subject-setting-wrap','mouseenter',function(e){
                    var index = $('.item-subject-setting-wrap').length;
                    var e = e || window.event;
                        e.stopPropagation();
                        $(this).addClass('item-hover');
                    if($(this).find('.dele-subject-btn').get(0) && optType !='VIEW' && index>2){
                        $(this).find('.dele-subject-btn').show();
                    }
                });
                $('.subject-setting-all-panel').delegate('.item-subject-setting-wrap','mouseleave',function(e){
                    var e = e || window.event;
                    e.stopPropagation();
                    $(this).removeClass('item-hover');
                    if($(this).find('.dele-subject-btn').get(0)){
                        $(this).find('.dele-subject-btn').hide();
                    }
                });
            },

            submitForm:function(callback){
                var subjectNum = $('.subject-list').length;
                if (subjectNum <2) {
                    PEMO.DIALOG.tips({
                        content: "科目数量少于2个！"
                    });
                    return false;
                }

                var arrangeNum = $('.item-subject-setting-wrap').length;
                if(arrangeNum != subjectNum){
                    PEMO.DIALOG.alert({
                        content: "请设置相应的科目数量！",
                        btn: ['我知道了'],
                        yes:function () {
                            layer.closeAll();
                        }
                    });
                    return false;
                }

                subjectBasicInfo.resetInputName();
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exam/manage/saveSubjectSetting',
                    data: $('#subjectSettingForm').serialize(),
                    success: function (data) {
                        if (data.success) {
                            callback(data.data);
                            return false;
                        }

                        PEMO.DIALOG.alert({
                            content: data.message,
                            btn: ['我知道了'],
                            yes:function () {
                                layer.closeAll();
                            }
                        });
                    }
                });
            },
            checkSubject:function(){
                var subjectIsError=false;
                PEBASE.ajaxRequest({
                    url:pageContext.rootPath + '/ems/exam/manage/checkComprehensiveSubject',
                    data:{id:'${(exam.id)!}',examType:'${(exam.examType)!}'},
                    async:false,
                    success:function(data){
                        if(!data.success){
                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn: ['我知道了'],
                                yes: function () {
                                    layer.closeAll();
                                }
                            });
                            subjectIsError=true;
                        }
                    }
                });
                return subjectIsError;
            }
        };

        $('.step-detail-item-panel').delegate('.subject-setting-choose','click', function () {
            var thisChoose=$(this);
            PEMO.DIALOG.selectorDialog({
                title: '选择科目',
                content: [pageContext.rootPath + '/ems/exam/manage/selectorSubject?'+$('#subjectSettingForm').serialize(), 'no'],
                btn: ['取消', '确认'],
                area: ['902px', '590px'],
                skin: 'pe-add-exam-dialog pe-subject-choosen-dialog',
                needPagination:true,
                btn2: function () {
                    var $paperCheck = $($(layer.getChildFrame('.select-subject'))).find("input[name='subjectCheck']:checked").parent('.pe-subject-check');
                    var thisCheckId = $paperCheck.data('id');
                    var thisCheckName = $paperCheck.data('name');
                    if (!thisCheckId) {
                        PEMO.DIALOG.tips({
                            content: '请选择科目！',
                            btn: ['我知道了'],
                            yes: function (index) {
                                layer.close(index);
                            }
                        });

                        return false;
                    }

                    var subjectNum = $('.subject-list').length;
                    var subjectDom = '<a title="' + thisCheckName + '" class="add-question-bank-item subject-list" style="margin-bottom:16px;max-width: 292px;width:auto;">' +
                            '<span class="paper-random-bank">'+thisCheckName
                            + '</span><span class="iconfont icon-inputDele input-dele"><input type="hidden" name="examArranges['+subjectNum+'].subject.id" value="'
                            + thisCheckId + '"/></span></a>';
                    thisChoose.before(subjectDom);
                    thisChoose.hide();
                    layer.closeAll();

                    return false;
                },
                btn1: function () {
                    layer.closeAll();
                },
                success:function(){
                   var thisLayerFrame = $($(layer.getChildFrame('.select-subject'))).css({"height":"444px","overflow":"auto"});

                }
            });
        });

        $('.add-subject-btn').on('click',function(){
            var examArrange = {};
            subjectBasicInfo.addSubject(examArrange,$('#editSubjectTemp'));
        });

        $('.step-detail-item-panel').delegate('.dele-subject-btn','click',function(){
            var subjectNum = $('.item-subject-setting-wrap').length;
            if (subjectNum <=2) {
                PEMO.DIALOG.tips({
                    content: "科目数量少于2个！"
                });
                return false;
            }

            var thisDele = $(this);
            PEMO.DIALOG.confirmR({
                content: '<div><h3 class="pe-dialog-content-head">确定删除该科目么？</h3></div>',
                btn2: function () {
                    thisDele.parent().remove();
                    $('.subject-num').each(function (index) {
                        $(this).text(index+1);
                    });

                    if($('.item-subject-setting-wrap').length < 10){
                        $('.add-subject-btn').show();
                    }
                },
                btn1: function () {
                    layer.closeAll();
                }
            });
        });

        $('.step-detail-item-panel').delegate('.input-dele','click',function(){
            $(this).parent().next().show();
            $(this).parent().remove();
        });

        subjectBasicInfo.init();
        subjectBasicInfo.initData();
    });
</script>
