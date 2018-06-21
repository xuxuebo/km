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
            <li class="add-paper-step-item floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW' )>edit-btn-hover basic-step-item<#else>step-complete</#if>"
                style="text-align:left;">
                <div class="add-step-icon-wrap">
                   <span class="iconfont icon-step-circle floatL">
                    <span class="add-step-number">1</span>
                   </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">基本信息</span>
            </li>
            <li class="add-paper-step-item add-paper-step-two floatL
            <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover
                <#if exam.examType?? && exam.examType == 'COMPREHENSIVE'>subject-step-item<#else>paper-step-item</#if>
                <#else>step-complete</#if>">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                        <span class="iconfont icon-step-circle floatL">
                           <span class="add-step-number">2</span>
                        </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">科目设置</span>
            </li>
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
        </ul>
    </div>
    <form id="examManageForm">
        <div class="add-exam-main-panel subject-test-setting-wrap" style="padding-top:20px;">

        </div>
        <input type="hidden" value="${(exam.examType)!"COMPREHENSIVE"}" name="exam.examType"/>
        <input type="hidden" value="${(exam.optType)!}" name="exam.optType"/>
        <input type="hidden" name="exam.id" value="${(exam.id)!}"/>
        <input type="hidden" name="id" value="${(examSetting.id)!}"/>
    </form>
</section>
<#if exam.optType?? && (exam.optType == 'VIEW')>
<div class="pe-btns-group-wrap" style="margin:50px auto 60px;text-align:center;">
    <div class="view-exam-group-two" style="display: none;">
        <button type="button" class="pe-btn pe-btn-blue pe-step-save-draft">保存</button>
        <#if exam.source?? && exam.source == 'ADD'>
            <button type="button" class="pe-btn pe-large-btn pe-btn-white new-page-close-btn">关闭</button>
        <#else >
            <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
        </#if>
    </div>
    <div class="view-exam-group-one">
        <#if exam.source?? && exam.source == 'ADD'>
            <button type="button" class="pe-btn pe-large-btn pe-btn-white new-page-close-btn">关闭</button>
        <#else >
            <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
        </#if>
        <a href="javascript:;" class="pe-view-user-btn i-need-edit-exam"><span class="iconfont icon-edit"></span>我要编辑考试信息</a>
    </div>
</div>
<#else >

<div class="pe-btns-group-wrap" style="margin:50px auto 60px;text-align:center;">
    <#if !(exam.optType?? && exam.optType == 'UPDATE')>
        <button type="button" class="pe-btn pe-btn-purple pe-step-next-btn pre-step">上一步</button>
    </#if>

    <#if !(exam.status)?? || (exam.status) == 'DRAFT'>
        <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn pe-step-save-draft">保存为草稿</button>
        <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-next">保存并启用</button>
    <#else >
        <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn pe-step-save-draft">保存</button>
    </#if>
<button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
</div>
</#if>
<script type="text/template" id="editSettingTemp">
    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
        <dt class="floatL user-detail-title">考试管理员:</dt>
        <dd class="user-detail-value">
                <span class="exam-has-added-user-num EXAM_MANAGER_name_${(exam.id)!}">
                    <%if (examSetting.examAuthList && examSetting.examAuthList.length>0) { _.each(examSetting.examAuthList,function(examAuth,index){%>
                            <span class="tags add-question-bank-item bank-list " data-id="<%=examAuth.user.id%>"
                                  data-text="<%=examAuth.user.userName%>"><span class="has-item-user-name"
                                                                                title="<%=examAuth.user.userName%>"><%=examAuth.user.userName%></span>
                    <#if (examSetting.examAuthList)??>
                        <#list examSetting.examAuthList as examAuth>
                            <#if exam.createBy?? && examAuth?? && examAuth.user?? && examAuth.user.id?? && exam.createBy != examAuth.user.id>
                                <span class="iconfont icon-inputDele"></span>
                            </#if>
                        </#list>
                    </#if>
                            </span>
                        <%})}%>
                    <a href="javascript:;" class="exam-view-user add-manager" <#if exam.optType?? && (exam.optType == 'VIEW')>style="display:none;" </#if>>选择人员</a>
                </span>
        </dd>
    </dl>
    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
        <dt class="floatL user-detail-title">成绩设置:</dt>
        <dd class="user-detail-value">
            <div>
                <label class="pe-radio pe-check-by-list pe-edit-score-by-all <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> ">
                    <span class="iconfont <%if (!examSetting.scoreSetting.st || (examSetting.scoreSetting.st && examSetting.scoreSetting.st == 'SUBJECT')) {%>icon-checked-radio peChecked<%} else {%>icon-unchecked-radio<%}%>"></span>
                    <input class="pe-form-ele" type="radio" value="SUBJECT" name="scoreSetting.st"
                    <%if (!examSetting.scoreSetting.st || (examSetting.scoreSetting.st && examSetting.scoreSetting.st ==
                    'SUBJECT')) {%>checked="checked"<%}%>/>
                    满分由所有科目累计&nbsp;&nbsp;
                <#if fullMarks??>
                    满分:<span style="c-olor:#f6b37f">${fullMarks}</span>
                <#else>
                    存在科目未折合分数，满分无法准确计算
                </#if>
                </label>
                <div style="margin-left:18px;" class="<#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if>">考试最终成绩为各科目成绩之和</div>
            </div>
            <div>
                <label class="pe-radio pe-edit-score-setting pe-check-by-list <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if>">
                    <span class="iconfont click-exam-score-setting-convert <%if (examSetting.scoreSetting.st && examSetting.scoreSetting.st == 'CONVERT') {%>icon-checked-radio peChecked<%} else {%>icon-unchecked-radio<%}%>"></span>
                    <input class="pe-form-ele exam-score-setting-convert" type="radio" value="CONVERT"
                           name="scoreSetting.st"
                    <%if (examSetting.scoreSetting.st && examSetting.scoreSetting.st == 'CONVERT')
                    {%>checked="checked"<%}%>/>
                    满分折合成
                    <input type="text" name="scoreSetting.cm" class="exam-create-num-input"
                           <#if (exam.status)! =='PROCESS'>readonly="readonly"</#if>
                           value="<%=examSetting.scoreSetting.cm?examSetting.scoreSetting.cm:100%>">分
                </label>
            <#-- <div style="margin-left:18px;">
                 <input type="hidden" value="${(subjectList?size)}" class="exam-subject-marker">
                 考试最终成绩=
             <#if subjectList??>
                 <#list subjectList as  subject>
                     <#if (subject_index+1)==(subjectList?size)>
                         科目${subject_index+1}成绩*权重<input type="text" placeholder="33.3"
                                                         class="exam-create-num-input"
                                                         name="scoreSetting.sr[${subject_index+1}]"
                                                         data-type="${subject_index+1}"
                                                         value="<%=examSetting.scoreSetting.sr[${subject_index+1}]%>"/>%
                     <#else>
                         科目${subject_index+1}成绩*权重<input type="text" placeholder="33.3"
                                                         class="exam-create-num-input"
                                                         name="scoreSetting.sr[${subject_index+1}]"
                                                         data-type="${subject_index+1}"
                                                         value="<%=examSetting.scoreSetting.sr[${subject_index+1}]%>"/>%+
                     </#if>
                 </#list>
             </#if>
             </div>-->
            </div>
        </dd>
    </dl>
    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
        <dt class="floatL user-detail-title">及格条件:</dt>
        <dd class="user-detail-value">得分率不低于
            <input type="text" value="<%=examSetting.scoreSetting.pr?examSetting.scoreSetting.pr:60%>"
                   name="scoreSetting.pr"
                   <#if (exam.status)! =='PROCESS'>readonly="readonly"</#if>
                   class="exam-create-num-input">&nbsp;%
        </dd>
    </dl>
    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
        <dt class="floatL user-detail-title">成绩发布:</dt>
        <dd class="user-detail-value">
            <div>
                <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if>">
                    <span class="iconfont <%if (!examSetting.scoreSetting.spt ||examSetting.scoreSetting.spt && examSetting.scoreSetting.spt=='SUBJECT_AUTO_PUBLISH') {%>icon-checked-radio peChecked<%} else {%>icon-unchecked-radio<%}%>"></span>
                    <input class="pe-form-ele" type="radio" value="SUBJECT_AUTO_PUBLISH" name="scoreSetting.spt"
                           id="SUBJECT_AUTO_PUBLISH"
                    <%if (!examSetting.scoreSetting.spt || examSetting.scoreSetting.spt &&
                    examSetting.scoreSetting.spt=='SUBJECT_AUTO_PUBLISH') {%>
                    checked="checked" <%}%>/>
                    所有科目的成绩全部发布后，自动发布综合考试的成绩
                </label>
            </div>

            <div>
                <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if>">
                    <span class="iconfont <%if (examSetting.scoreSetting.spt && examSetting.scoreSetting.spt=='SUBJECT_MANUAL') {%>icon-checked-radio peChecked<%}else {%>icon-unchecked-radio<%}%>"></span>
                    <input class="pe-form-ele" type="radio" value="SUBJECT_MANUAL" name="scoreSetting.spt"
                           id="SUBJECT_MANUAL"
                    <%if (examSetting.scoreSetting.spt && examSetting.scoreSetting.spt=='SUBJECT_MANUAL')
                    {%>checked="checked"<%}%>/>
                    所有科目的成绩全部发布后，需要手动发布综合成绩
                </label>
            </div>
        <#--   <div>
               <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if>">
                   <span class="iconfont <%if (examSetting.scoreSetting.spt && examSetting.scoreSetting.spt == 'SUBJECT_EXAM_TOGETHER') {%>icon-checked-radio peChecked<%} else {%>icon-unchecked-radio<%}%>"></span>
                   <input class="pe-form-ele" type="radio" value="SUBJECT_EXAM_TOGETHER"
                          name="scoreSetting.spt" id="SUBJECT_EXAM_TOGETHER"
                   <%if (examSetting.scoreSetting.spt && examSetting.scoreSetting.spt=='SUBJECT_EXAM_TOGETHER')
                   {%>checked="checked"<%}%>/>
                   手动发布综合成绩，科目成绩和综合成绩一同发布
               </label>
           </div>-->
        </dd>
    </dl>
</script>

<script type="text/template" id="viewSettingTemp">
    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
        <dt class="floatL user-detail-title">考试管理员:</dt>
        <dd class="user-detail-value">
                <span class="exam-has-added-user-num EXAM_MANAGER_name_${(exam.id)!}">
                    <%if (examSetting.examAuthList && examSetting.examAuthList.length>0) { _.each(examSetting.examAuthList,function(examAuth,index){%>
                                <span class="tags add-question-bank-item bank-list <#if exam.optType?? && (exam.optType == 'VIEW')>not-hover</#if>"
                                  data-id="<%=examAuth.user.id%>" data-text="<%=examAuth.user.userName%>"><span class="has-item-user-name"
                                                                                title="<%=examAuth.user.userName%>"><%=examAuth.user.userName%></span>
                            <#if (examSetting.examAuthList)??>
                                <#list examSetting.examAuthList as examAuth>
                                    <#if exam.createBy?? && examAuth?? && examAuth.user?? && examAuth.user.id?? && exam.createBy != examAuth.user.id>
                                        <span class="iconfont icon-inputDele"></span>
                                    </#if>
                                </#list>
                            </#if>
                            </span>
                        <%})}%>
                </span>
        </dd>
    </dl>
    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
        <dt class="floatL user-detail-title">成绩设置:</dt>
        <dd class="user-detail-value">
            <div>
                <label class="pe-radio">
                    <span class="iconfont <%if (!examSetting.scoreSetting.st || (examSetting.scoreSetting.st && examSetting.scoreSetting.st == 'SUBJECT')) {%>icon-checked-radio peChecked<%} else {%>icon-unchecked-radio<%}%>"></span>
                    满分由所有科目累计&nbsp;&nbsp;
                <#if fullMarks??>
                    满分:<span style="c-olor:#f6b37f">${fullMarks}</span>
                <#else>
                    存在科目未折合分数，满分无法准确计算
                </#if>
                </label>
                <div style="margin-left:18px;">考试最终成绩为各科目成绩之和</div>
            </div>
            <div>
                <label class="pe-radio">
                    <span class="iconfont <%if (examSetting.scoreSetting.st && examSetting.scoreSetting.st == 'CONVERT') {%>icon-checked-radio peChecked<%} else {%>icon-unchecked-radio<%}%>"></span>
                    满分折合成<%=examSetting.scoreSetting.cm?examSetting.scoreSetting.cm:100%>分
                </label>
            </div>
        </dd>
    </dl>
    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
        <dt class="floatL user-detail-title">及格条件:</dt>
        <dd class="user-detail-value">得分率不低于<%=examSetting.scoreSetting.pr?examSetting.scoreSetting.pr:60%>%
        </dd>
    </dl>
    <dl class="over-flow-hide user-detail-msg-wrap exam-setting-msg-wrap">
        <dt class="floatL user-detail-title">成绩发布:</dt>
        <dd class="user-detail-value">
            <div>
                <label class="pe-radio">
                    <span class="iconfont <%if (examSetting.scoreSetting.spt && examSetting.scoreSetting.spt=='SUBJECT_AUTO_PUBLISH') {%>icon-checked-radio peChecked<%} else {%>icon-unchecked-radio<%}%>"></span>
                    所有科目的成绩全部发布后，自动发布综合考试的成绩
                </label>
            </div>

            <div>
                <label class="pe-radio">
                    <span class="iconfont <%if (examSetting.scoreSetting.spt && examSetting.scoreSetting.spt=='SUBJECT_MANUAL') {%>icon-checked-radio peChecked<%}else {%>icon-unchecked-radio<%}%>"></span>
                    所有科目的成绩全部发布后，需要手动发布综合成绩
                </label>
            </div>
        <#-- <div>
             <label class="pe-radio">
                 <span class="iconfont <%if (examSetting.scoreSetting.spt && examSetting.scoreSetting.spt=='SUBJECT_EXAM_TOGETHER') {%>icon-checked-radio peChecked<%} else {%>icon-unchecked-radio<%}%>"></span>
                 手动发布综合成绩，科目成绩和综合成绩一同发布
             </label>
         </div>-->
        </dd>
    </dl>
</script>
<script type="text/javascript">
    $(function () {
        if(typeof changeExamManaStorage === 'function'){
            window.removeEventListener("storage", changeExamManaStorage,false);
        }
        //保存基本信息
        var examSetting = {};
        var optType = '${(exam.optType)!}';
        var source = '${(exam.source)!}';
        var subjectBasicInfo = {
            initParam: function () {
                //权重处理

            },

            init: function () {

                $('.edit-step-state .basic-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType,source:source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamInfo', params);
                });

                $('.edit-step-state .paper-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType,source:source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamPaper', params);
                });

                $('.edit-step-state .arrange-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType,source:source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initArrangePage', params);
                });

                $('.edit-step-state .subject-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType,source:source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initSubjectSetting', params);
                });

                $('.pre-step').on('click',function(){
                    var params = {id: '${(exam.id)!}', optType: optType,source:source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initArrangePage', params);
                });

                //返回
                $('.pe-step-back-btn').on('click', function () {
                    history.back(-1);
                });


                //关闭
                $('.new-page-close-btn').on('click', function () {
                    window.close();
                });

                //我要编辑
                $('.i-need-edit-exam').on('click', function () {
                    $('.subject-test-setting-wrap').html(_.template($('#editSettingTemp').html())({examSetting: examSetting}));
                    $('.view-exam-group-one').hide();
                    $('.view-exam-group-two').show();
                    $('.add-manager').show();
                    $('.icon-inputDele').parent().removeClass('not-hover');
                    PEBASE.peFormEvent('checkbox');
                    PEBASE.peFormEvent('radio');
                });

                //保存
                $('.pe-step-save-draft').on('click', function () {
                    subjectBasicInfo.submitForm(function (data) {
                        PEMO.DIALOG.tips({
                            content: "保存成功！",
                            time: 1000,
                            end: function () {
                                history.back(-1);
                            }
                        });
                    });
                });


                //保存并启用
                $(".save-next").click(function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/saveEnableExam',
                        data: $('#examManageForm').serialize(),
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: "启用成功",
                                    end: function () {
                                        location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initPage';
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

                $('.subject-test-setting-wrap').on('click','.pe-check-by-list',function(){
                    if($(this).hasClass('noClick')){
                        return false;
                    }else {
                        var iconCheck = $(this).find('span.iconfont');
                        var thisRealCheck = $(this).find('input[type="radio"]');
                        var nextDiv = iconCheck.closest('div').next('div').eq(0);
                        nextDiv.find('span.iconfont').removeClass('icon-checked-radio').addClass('icon-unchecked-radio ');
                        nextDiv.find('input[type="radio"]').removeProp('checked');
                        iconCheck.removeClass('icon-unchecked-radio').addClass('icon-checked-radio ');
                        thisRealCheck.prop('checked', true);
                    }
                });

                    //权重处理
                $('.subject-test-setting-wrap').on('click','.pe-edit-score-setting',function(){
                    if($(this).hasClass('noClick')){
                        return false;
                    }else{

                        var iconCheck = $(this).find('span.iconfont');
                        var thisRealCheck = $(this).find('input[type="radio"]');
                        var preDiv = iconCheck.closest('div').prev('div').eq(0);
                        preDiv.find('span.iconfont').removeClass('icon-checked-radio').addClass('icon-unchecked-radio ');
                        preDiv.find('input[type="radio"]').removeProp('checked');
                        iconCheck.removeClass('icon-unchecked-radio').addClass('icon-checked-radio ');
                        thisRealCheck.prop('checked',true);

                        var subjectCount = parseInt($('.exam-subject-marker').val(),10);
                        if (subjectCount === 1) {
                            $('input[data-type="1"]').val(100);
                        }

                        var convert = $('.exam-score-setting-convert');
                        if (convert.prop('checked')) {
                            if (subjectCount > 1) {
                                var num = parseFloat((100 / (subjectCount)).toFixed(2),10);//33.33
                                var everyCount = 0;
                                for (var i = 1; i <= subjectCount; i++) {
                                    if (subjectCount > i) {
                                        $('input[data-type="' + i + '"]').val(num);
                                        everyCount = everyCount + num;
                                    }

                                    if (subjectCount == i) {
                                        $('input[data-type="' + i + '"]').val((100 - everyCount).toFixed(2));
                                    }
                                }
                            }
                        }
                    }
                });


                /*原试卷题目分数按比例折算成满分*/
                if ($('#examManageForm').find("input[name='scoreSetting.st']" + ":checked").val() === 'CONVERT') {
                    var cm = $('#examManageForm').find("input[name='scoreSetting.cm']").val();
                    if (!cm || $.trim(cm) === '' || parseInt($.trim(cm)) < 1) {
                        PEMO.DIALOG.tips({
                            content: "请设置 “成绩设置” 的 “原试卷题目分数按比例折算分数”！",
                            time: 1500
                        });
                        return false;
                    }
                }

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

                //选管理员
                $('.subject-test-setting-wrap').delegate('.add-manager', 'click', function () {
                    PEMO.DIALOG.selectorDialog({
                        title: '选择考试管理员',
                        area: ['970px', '580px'],
                        content: [pageContext.rootPath + '/ems/exam/manage/initSelector?type=EXAM_MANAGER&id=${(exam.id)!}', 'no'],
                        btn: ['关闭'],
                        btn1: function (index) {
                            layer.close(index);
                        }
                    });
                });

                //考试管理员删除功能
                $('.subject-test-setting-wrap').delegate('.icon-inputDele','click',function(){
                    var id = '${(exam.id)!}';
                    var userId = [];
                    userId.push($(this).parent().attr('data-id'));
                    var data = {id: id, referIds: JSON.stringify(userId), type: 'EXAM_MANAGER'};
                    var thisSpan=$(this);
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/deleteExamAdmin',
                        data:data,
                        success: function (data) {
                            if(data.success){
                                thisSpan.parent().remove();
                            }

                            return false;
                        }
                    })
                });
            },

            submitForm: function (callback) {
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exam/manage/saveExamSetting',
                    data: $('#examManageForm').serialize(),
                    success: function (data) {
                        if (data.success) {
                            callback(data.data.id);
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

            initData: function () {
            <#if examSetting??>
                //人员列表
                <#if (examSetting.examAuthList)??>
                    var examAuthList = [];
                    examSetting.examAuthList = examAuthList;
                    <#list examSetting.examAuthList as examAuth>
                        var examAuth = {}, user = {};
                        examAuth.user = user;
                        user.id = "${(examAuth.user.id)!}";
                        user.userName = "${(examAuth.user.userName)!}";
                        examAuthList.push(examAuth);
                    </#list>
                </#if>
                    //分数设置权重
                    var scoreSetting = {};
                <#if (examSetting.scoreSetting.sr)?? && (examSetting.scoreSetting.sr?size gt 0)>
                    var sr = {};
                    examSetting.scoreSetting = scoreSetting;
                    scoreSetting.sr = sr;
                    <#list examSetting.scoreSetting.sr?keys as srIndex>
                        sr[${srIndex}] = '${examSetting.scoreSetting.sr[srIndex]}';
                    </#list>
                <#elseif  !(examSetting.scoreSetting.sr)??||!(examSetting.scoreSetting.sr?size gt 0)>
                    var sr = {};
                    examSetting.scoreSetting = scoreSetting;
                    scoreSetting.sr = '';
                </#if>

                    <#if (examSetting.scoreSetting.st)??>
                        var st;
                        examSetting.scoreSetting = scoreSetting;
                        scoreSetting.st = '${(examSetting.scoreSetting.st)!}';
                    <#else>
                        var st;
                        examSetting.scoreSetting = scoreSetting;
                        scoreSetting.st = '';
                    </#if>

                    <#if (examSetting.scoreSetting.spt)??>
                        var spt;
                        examSetting.scoreSetting = scoreSetting;
                        scoreSetting.spt = '${(examSetting.scoreSetting.spt)!}';
                    <#else>
                        var spt;
                        examSetting.scoreSetting = scoreSetting;
                        scoreSetting.spt = '';
                    </#if>
                    <#if (examSetting.scoreSetting.pr)??>
                        var pr;
                        examSetting.scoreSetting = scoreSetting;
                        scoreSetting.pr = '${(examSetting.scoreSetting.pr)!}';
                    <#else>
                        var pr;
                        examSetting.scoreSetting = scoreSetting;
                        scoreSetting.pr = 60;
                    </#if>
            </#if>
                if (optType === 'VIEW') {
                    $('.subject-test-setting-wrap').html(_.template($('#viewSettingTemp').html())({examSetting: examSetting}));
                } else {
                    $('.subject-test-setting-wrap').html(_.template($('#editSettingTemp').html())({examSetting: examSetting}));
                    PEBASE.peFormEvent('checkbox');
                    PEBASE.peFormEvent('radio');
                }
                window.addEventListener("storage", function (e) {
                    if (e.key.indexOf('EXAM_MANAGER_name_') >=0 && e.newValue) {
                        $('.' + e.key).find('.add-question-bank-item').remove();
                        $('.' + e.key).find('.add-manager').before(e.newValue);//有两个的“选择人员”的classname是 add-manager
                        localStorage.removeItem(e.key);
                    }
                });
            }
        };
        subjectBasicInfo.init();
        subjectBasicInfo.initData();
    });
</script>
