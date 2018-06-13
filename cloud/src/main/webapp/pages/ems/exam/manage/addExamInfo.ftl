<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">考试</li>
    <#if exam.subject?? && exam.subject>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">科目管理</li>
        <#if exam.markUpId??>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览
                <#else>
                    补考设置
                </#if>
            </li>
        <#elseif exam.examType?? && exam.examType == 'ONLINE'>
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
        <#if exam.markUpId??>
            <li class="pe-brak-nav-items iconfont icon-bread-arrow">
                <#if exam.optType?? && exam.optType == 'UPDATE'>
                    编辑
                <#elseif exam.optType?? && exam.optType == 'VIEW'>
                    预览
                <#else>
                    补考设置
                </#if>
            </li>
        <#elseif exam.examType?? && exam.examType == 'ONLINE'>
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
<section class="steps-all-panel">
    <div class="add-exam-top-head">
        <ul class="over-flow-hide step-items-wrap <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-step-state</#if>">
            <li class="add-paper-step-item floatL overStep" style="text-align:left;">
                <div class="add-step-icon-wrap">
                   <span class="iconfont icon-step-circle floatL">
                    <span class="add-step-number">1</span>
                   </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text">基本信息</span>
            </li>
            <li class="add-paper-step-item add-paper-step-two floatL
            <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover <#if exam.examType?? && exam.examType == 'COMPREHENSIVE'>subject-step-item<#else>paper-step-item</#if></#if>">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                           <span class="add-step-number">2</span>
                        </span>
                    <div class="add-step-line"></div>
                </div>
                <span class="add-step-text"><#if exam.examType?? && exam.examType == 'COMPREHENSIVE'>科目设置<#else>
                    试卷设置</#if></span>
            </li>
        <#if exam?? && exam.subject?? && exam.subject>
            <li class="add-paper-step-item add-paper-step-three floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover setting-step-item</#if>">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">3</span>
                     </span>
                </div>
                <span class="add-step-text">考试设置</span>
            </li>
        <#else>
            <li class="add-paper-step-item add-paper-step-two floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover arrange-step-item</#if>">
                <div class="add-step-icon-wrap">
                    <div class="add-step-line add-step-two-line"></div>
                    <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">3</span>
                     </span>
                    <#if !(exam.markUpId??)>
                        <div class="add-step-line"></div>
                    </#if>
                </div>
                <span class="add-step-text">考试安排</span>
            </li>
            <#if !(exam.markUpId??)>
                <li class="add-paper-step-item add-paper-step-three floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover setting-step-item</#if>">
                    <div class="add-step-icon-wrap">
                        <div class="add-step-line"></div>
                        <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">4</span>
                     </span>
                    </div>
                    <span class="add-step-text">考试设置</span>
                </li>
            </#if>
        </#if>
        </ul>
    </div>
    <form id="examManageForm">
    </form>
</section>
<div class="pe-btns-group-wrap" style="text-align:center;">
<#if exam.status?? && (exam.status == 'DRAFT' || exam.status == 'NO_START' || exam.status == 'PROCESS') || (exam.subject?? && exam.subject)>
    <#if exam.optType?? && (exam.optType == 'VIEW')>
    <div class="view-exam-group-one">
        <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-basic" hidden>保存</button>
    <#elseif exam.optType?? && exam.optType == 'UPDATE'>
        <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-basic">保存</button>
    <#else>
        <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-next">下一步</button>
    </#if>
    <#if exam.source?? && exam.source == 'ADD'>
        <button type="button" class="pe-btn pe-large-btn pe-btn-white new-page-close-btn">关闭</button>
    <#else >
        <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">返回</button>
    </#if>
    <#if exam.optType?? && (exam.optType == 'VIEW' && canEdit?? && canEdit)>
        <a href="javascript:;" class="pe-view-user-btn i-need-edit-exam"><span class="iconfont icon-edit"></span>我要编辑考试信息
        </a>
    </div>
    </#if>
<#else>
    <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">关闭</button>
</#if>
</div>
<script type="text/template" id="previewExamInfo">
    <div class="add-exam-main-panel edit-exam-base-one-wrap">
        <div class="pe-stand-form-cell add-exam-step-one-wrap">
            <label class="pe-form-label">
                <span class="pe-label-name floatL"><#if exam?? && exam.subject?? && exam.subject>科目名称:<#else>
                    考试名称:</#if></span>
                <span class="pe-label-name"><%=data.examName%></span>
            </label>
            <em class="error"></em>
        </div>
        <div class="pe-stand-form-cell add-exam-step-one-wrap">
            <label class="pe-form-label">
                <span class="pe-label-name floatL"><#if exam?? && exam.subject?? && exam.subject>科目编号:<#else>
                    考试编号:</#if></span>
                <span class="pe-label-name"><%=data.examCode%></span>
            </label>
            <em class="error"></em>
        </div>
        <#if exam.examType?? && exam.examType == 'ONLINE'>
            <div class="pe-stand-form-cell add-exam-step-one-wrap">
                <label class="pe-form-label">
                    <span class="pe-label-name floatL">考试地址:</span>
                    <span class="pe-label-name">
                    <input type="text" class="exam-address-cla floatL" readonly value="${(examAddress)!}"/>
                    <button class="pe-btn pe-btn-blue pe-step-next-btn" type="button" id="copy" style="height: 34px;width: 86px;float: left;border-radius: 0;">复制</button>
                </span>
                </label>
            </div>
        </#if>
        <#if exam?? && !(exam.subject?? && exam.subject) && !(exam.markUpId??) && exam.examType == 'ONLINE'>
            <div class="pe-stand-form-cell add-exam-step-one-wrap">
                <label class="pe-form-label" style="margin-right: 272px;">
                    <span class="pe-label-name floatL">准考证号:</span>
                    <span class="pe-stand-filter-form-text">
                        <%if (data.enableTicket && data.enableTicket === 'true') {%>
                        支持考生点击短链输入准考证号参加考试
                        <%} else {%>
                        不支持考生使用准考证号参加考试
                        <%}%>
                    </span>
                </label>
            </div>
        </#if>
        <div class="pe-stand-form-cell add-exam-step-one-wrap" style="display:block;">
            <label class="pe-form-label add-exam-msg-textarea-wrap" style="display:block;">
                <span class="pe-label-name floatL"><#if exam?? && exam.subject?? && exam.subject>科目说明:<#else>
                    考试说明:</#if></span><span class="pe-label-name"
                                            style="display:block;text-align:left;min-height:36px;height:auto;"><%=data.examPlain? data.examPlain:"暂无"%>
              </span>
            </label>
        </div>
    </div>
</script>

<script type="text/template" id="editExamInfo">
    <input type="hidden" name="markUpId" value="<%=data.markUpId%>"/>
    <input type="hidden" name="id" value="<%=data.id%>"/>
    <input type="hidden" name="subject" value="<%=data.subject%>"/>
    <input type="hidden" name="examType" value="<%=data.examType%>"/>
    <#if (exam.markUpId??)>
    <input type="hidden" name="enableTicket" value="<%=data.enableTicket%>"/>
    </#if>
    <div class="add-exam-main-panel add-exam-step-one-all-wrap">
        <div class="pe-stand-form-cell add-exam-step-one-wrap">
            <label class="pe-form-label">
                <span class="pe-label-name floatL"><span
                        style="color:#f00;">*</span><#if exam?? && exam.subject?? && exam.subject>科目名称:<#else>
                    考试名称:</#if></span>
            <#if exam?? && exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')&& (exam.status?? && exam.status != 'DRAFT')>
                <input type="hidden" name="examName" value="<%=data.examName%>"/>
                <span class="pe-stand-filter-form-text"><%=data.examName%></span>
            <#else>
                <input class="pe-stand-filter-form-input exam-name-input" type="text"
                       <#if exam?? && exam.subject?? && exam.subject>placeholder="科目名称不超过50字"
                       <#else>placeholder="考试名称不超过50字"</#if> maxlength="50"
                       name="examName" value="<%=data.examName%>">
            </#if>
            </label>
            <em class="error"></em>
        </div>
        <div class="pe-stand-form-cell add-exam-step-one-wrap">
            <label class="pe-form-label">
                <span class="pe-label-name floatL"><span
                        style="color:#f00;">*</span><#if exam?? && exam.subject?? && exam.subject>科目编号:<#else>
                    考试编号:</#if></span>
            <#if exam?? && exam.optType?? && (exam.optType == 'UPDATE'||exam.optType == 'VIEW') && (exam.status?? && exam.status != 'DRAFT')>
                <input type="hidden" name="examCode" value="<%=data.examCode%>"/>
                <span class="pe-stand-filter-form-text"><%=data.examCode%></span>
            <#else>
                <input class="pe-stand-filter-form-input exam-code-input" type="text"
                       name="examCode" value="<%=data.examCode%>">
            </#if>
            </label>
            <em class="error"></em>
        </div>
    <#if exam?? && !(exam.subject?? && exam.subject) && !(exam.markUpId??) && exam.examType == 'ONLINE'>
        <div class="pe-stand-form-cell add-exam-step-one-wrap">
            <label class="pe-form-label" <#if !(existUser?? && existUser)>style="margin-right: 125px;"</#if>>
                <span class="pe-label-name <#if (existUser?? && existUser)>floatL</#if>">准考证号:</span>
                <#if existUser?? && existUser>
                    <span class="pe-stand-filter-form-text">
                        <%if(data.enableTicket && data.enableTicket === 'true') {%>
                        支持考生点击短链输入准考证号参加考试
                        <%} else {%>
                        不支持考生使用准考证号参加考试
                        <%}%>
                        </span>
                <#else>
                    <label class="pe-radio">
                        <span class="iconfont <%if (!(data.enableTicket && data.enableTicket === 'true')) {%>icon-checked-radio<%} else {%>icon-unchecked-radio<%}%>"></span>
                        <input class="pe-form-ele" type="radio" name="enableTicket" value="false"
                    <%if (!(data.enableTicket && data.enableTicket === 'true')) {%>checked<%}%>/>
                        不支持考生使用准考证号参加考试
                    </label>
                    <label class="pe-radio" style="display: block;margin-left: 115px;">
                        <span class="iconfont <%if (data.enableTicket && data.enableTicket === 'true') {%>icon-checked-radio<%} else {%>icon-unchecked-radio<%}%>"></span>
                        <input class="pe-form-ele" type="radio" name="enableTicket" value="true"
                    <%if (data.enableTicket && data.enableTicket === 'true') {%>checked<%}%>/>
                        支持考生点击短链输入准考证号参加考试
                    </label>
                </#if>

            </label>
        </div>

    </#if>

        <div class="pe-stand-form-cell add-exam-step-one-wrap">
            <label class="pe-form-label add-exam-msg-textarea-wrap">
                <span class="pe-label-name floatL">&nbsp;<#if exam?? && exam.subject?? && exam.subject>科目说明:<#else>
                    考试说明:</#if></span>
                <textarea class="add-exam-msg-textarea" name="examPlain"
                          maxlength="1300" style="overflow: hidden;"><%=data.examPlain%></textarea>
            </label>
        </div>
    </div>
</script>

<script type="text/javascript">
    $(function () {
        if (typeof changeExamManaStorage === 'function') {
            window.removeEventListener("storage", changeExamManaStorage, false);
        }
        var optType = '${(exam.optType)!}';
        var status = '${(exam.status)!}';
        var subject = '${((exam.subject)!)?string('true','false')}';
        var source = '${(exam.source)!}';
        var examTye = '${(exam.examType)!}';
        var editExamInfo = {
            init: function () {
                var initData = {
                    id: '${(exam.id)!}', examType: examTye, examName: '${(exam.examName)!}',enableTicket:'${(exam.enableTicket?string('true','false'))!}'
                    , examCode: '${(exam.examCode)!}', examPlain: '${(exam.examPlain)!}', subject: subject
                    , status: status, optType: optType, markUpId: '${(exam.markUpId)!}'
                };

                if (optType == 'VIEW' || ('DRAFT' != status && !subject)) {//预览试卷置灰
                    $('#examManageForm').html(_.template($('#previewExamInfo').html())({data: initData}));
                } else {
                    $('#examManageForm').html(_.template($('#editExamInfo').html())({data: initData}));
                    PEBASE.peFormEvent('radio');
                }

                $('#copy').zclip({
                    path: '${resourcePath!}/web-static/proExam/js/plugins/zclip/ZeroClipboard.swf',
                    copy: function(){
                        return $('.exam-address-cla').val();
                    },
                    afterCopy: function(){
                        PEMO.DIALOG.tips({
                            content: "复制成功",
                            time: 1000
                        });
                    }
                });

                $('.save-next').on('click', function () {
                    editExamInfo.submitForm(function (data) {
                        if (examTye === 'COMPREHENSIVE') {
                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initSubjectSetting?id=' + data.id);
                        } else if (source === 'ADD') {
                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamPaper?id=' + data.id + '&source=ADD');
                        } else {
                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamPaper?id=' + data.id);
                        }
                    });
                });

                $('.save-basic').on('click', function () {
                    editExamInfo.submitForm(function (data) {
                        PEMO.DIALOG.tips({
                            content: '编辑成功',
                            time: 1000,
                            end: function () {
                                if (optType === 'VIEW') {
                                    initData = data;
                                    $('#examManageForm').html(_.template($('#previewExamInfo').html())({data: data}));
                                    $('.save-basic').hide();
                                    $('.i-need-edit-exam').show();
                                }
                            }
                        });
                    });
                });

                $('.pe-step-back-btn').on('click', function () {
                    if (subject && subject === 'true') {
                        location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initSubjectPage&nav=examMana';
                    } else {
                        location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initPage&nav=examMana';
                    }

                });

                $('.new-page-close-btn').on('click', function () {
                    window.close();
                });

                $('.edit-step-state .paper-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamPaper', params);
                });

                $('.edit-step-state .subject-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initSubjectSetting', params);
                });

                $('.edit-step-state .arrange-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    if (examTye === 'COMPREHENSIVE') {
                        var subjectIsError = editExamInfo.checkSubject();
                        if (subjectIsError) {
                            return false;
                        }
                    }
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initArrangePage', params);
                });

                $('.edit-step-state .setting-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    if (examTye === 'OFFLINE') {
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initOfflineExamSetting', params);
                    } else if (examTye === 'ONLINE') {
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamSetting', params);
                    } else if (examTye == 'COMPREHENSIVE') {
                        var subjectIsError = editExamInfo.checkSubject();
                        if (!subjectIsError) {
                            $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initComprehensiveSetting', params);
                        }
                    }
                });

                //我要编辑考试
                $('.i-need-edit-exam').on('click', function () {
                    $('#examManageForm').html(_.template($('#editExamInfo').html())({data: initData}));
                    PEBASE.peFormEvent('radio');
                    $(this).hide();
                    $('.save-basic').show();
                });
            },

            checkSubject: function () {
                var subjectIsError = false;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exam/manage/checkComprehensiveSubject',
                    data: {id: '${(exam.id)!}', examType: examTye},
                    async: false,
                    success: function (data) {
                        if (!data.success) {
                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn: ['我知道了'],
                                yes: function () {
                                    layer.closeAll();
                                }
                            });
                            subjectIsError = true;
                        }
                    }
                });
                return subjectIsError;
            },

            checkParams: function () {
                var examName = $('input[name="examName"]').val();
                if (!examName) {
                    $('input[name="examName"]').parent('.pe-form-label').next('.error').html('考试名称不可为空!');
                    return false;
                } else {
                    $('input[name="examName"]').parent('.pe-form-label').next('.error').html('');
                }
                if (examName.length > 50) {
                    $('input[name="examName"]').parent('.pe-form-label').next('.error').html('考试名称不超过50字!');
                    return false;
                } else {
                    $('input[name="examName"]').parent('.pe-form-label').next('.error').html('');
                }
                var examCode = $('input[name="examCode"]').val();
                if (!examCode) {
                    $('input[name="examCode"]').parent('.pe-form-label').next('.error').html('考试编号不可为空!');
                    return false;
                } else {
                    $('input[name="examCode"]').parent('.pe-form-label').next('.error').html('');
                }

                var isSameCode = false;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exam/manage/checkExamCode',
                    data: {id: '${(exam.id)!}', examCode: examCode},
                    async: false,
                    success: function (data) {
                        if (data.success) {
                            $('input[name="examCode"]').parent('.pe-form-label').next('.error').html('');
                        } else {
                            $('input[name="examCode"]').parent('.pe-form-label').next('.error').html('考试编号已经存在!');
                            isSameCode = true;
                        }
                    }
                });

                if (isSameCode) {
                    return false;
                }

                return true;
            },

            submitForm: function (callback) {
                var isVal = editExamInfo.checkParams();
                if (!isVal) {
                    return false;
                }

                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exam/manage/saveExamInfo',
                    data: $('#examManageForm').serialize(),
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

        editExamInfo.init();
        //考试编号输入检测函数
        $('.exam-code-input').keyup(function (e) {
            var e = e || window.event;
            var eKeyCode = e.keyCode;
            var thisVal = this.value;
            if ((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105) || (eKeyCode >= 65 && eKeyCode <= 90)
                    || eKeyCode === 8 || eKeyCode === 37 || eKeyCode === 39 || eKeyCode === 46) {
                if (thisVal.length >= 13) {
                    this.value = thisVal.substring(0, 15);
                }
            } else {
                this.value = thisVal;
                return false;
            }
        }).keydown(function () {
            var e = e || window.event;
            var eKeyCode = e.keyCode;
            var thisVal = this.value;
            if (!((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105) || (eKeyCode >= 65 && eKeyCode <= 90)
                    || eKeyCode === 8 || eKeyCode === 37 || eKeyCode === 39 || eKeyCode === 46)) {
                this.value = thisVal;
                return false;
            }
        });

        //考试名称限制50字
        $('.exam-name-input').keyup(function () {
            var thisVal = this.value;
            if (thisVal.length >= 50) {
                this.value = thisVal.substring(0, 50);
            }
        });
    });
</script>
