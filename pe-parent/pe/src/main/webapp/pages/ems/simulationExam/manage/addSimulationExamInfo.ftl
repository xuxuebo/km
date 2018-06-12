<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">考试</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">模拟考试</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">
        <#if exam.isTransient?? && exam.isTransient == 'f'>编辑<#else>创建</#if>
        </li>
    </ul>
</div>
<section class="pe-add-user-all-wrap">
    <form id="editItemForm" class="validate" action="javascript:;">
        <input type="hidden" name="id" value="${(exam.id)!}"/>
        <input type="hidden" name="isTransient" value="${(exam.isTransient)!}"/>
        <input name="templateId" hidden value=""/>
        <div class="pe-add-user-item-wrap over-flow-hide">
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                 <span class="pe-input-tree-text" style="width: auto">
                    <span style="color:red;">*</span>
                     <span>考试编号:</span>
                </span>
                <#if exam.isTransient=='t'>
                    <input class="pe-stand-filter-form-input pe-question-score-num" type="text"
                           value="${(exam.mockCode)!}"
                           name="mockCode" maxlength="50">
                <#else>
                ${(exam.mockCode)!}
                </#if>
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class=" pe-question-label">
                     <span class="pe-input-tree-text" style="width: auto">
                        <span style="color:red;">*</span>
                         <span>考试名称:</span>
                    </span>
                <#if exam?? && exam.examName??>
                ${(exam.examName)!}
                <#else>
                    <input class="pe-stand-filter-form-input pe-question-score-num" type="text" name="examName"
                           value="${(exam.examName)!}"
                           maxlength="50"/>
                </#if>
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class=" pe-question-label exam-paper">
                     <span class="pe-input-tree-text" style="width: auto">
                        <span style="color:red;">*</span>
                         <span>选择试卷</a>:</span>
                    </span>
                <#if exam.paperTemplate??&&exam.paperTemplate.id??>
                ${exam.paperTemplate.paperName}
                <#else>
                    <span class="exam-paper-setting-btn"><a class="exam-add-new-user"
                                                            style="line-height: 20px;text-decoration:underline">选择试卷</a></span>
                </#if>

                </label>
            </div>
            <div class="pe-user-msg-detail">
                <span class="pe-input-tree-text">
                         <span>可用范围:</span>
                    </span>
                <div class="pe-gender-wrap user-range">
                    <label class="pe-radio  green-raido-check">
                    <#if exam.isTransient=='f'>
                        <span class="iconfont <#if exam?? && exam.examSetting?? &&exam.examSetting.usableRange??&&(exam.examSetting.usableRange=='ALL')>icon-checked-radio<#else>icon-unchecked-radio</#if>"></span>
                            <span class="pe-select-true-answer">
                            <input class="pe-form-ele"
                                   <#if exam?? && exam.examSetting?? &&exam.examSetting.usableRange??&&(exam.examSetting.usableRange=='ALL')>checked="checked"</#if>
                                   type="radio" value="ALL" name="examSetting.usableRange"/>公开可用</span>
                    <#else>
                        <span class="iconfont icon-checked-radio"></span>
                            <span class="pe-select-true-answer">
                            <input class="pe-form-ele" checked="checked" type="radio" value="ALL"
                                   name="examSetting.usableRange"/>公开可用</span>
                    </#if>
                    </label>
                    <label class="pe-radio  green-raido-check">
                        <span class="iconfont <#if exam?? && exam.examSetting?? &&exam.examSetting.usableRange??&&(exam.examSetting.usableRange=='LIMIT')>icon-checked-radio<#else>icon-unchecked-radio</#if>"></span><span
                            class="pe-select-true-answer">
                        <input class="pe-form-ele" type="radio" value="LIMIT"
                               <#if exam?? && exam.examSetting?? &&exam.examSetting.usableRange??&&(exam.examSetting.usableRange=='LIMIT')>checked="checked"</#if>
                               name="examSetting.usableRange"/>指定可用<span
                            class="exam-user"><#if exam??&& exam.users??>${(exam.users)!?size}<#else>
                        0</#if>
                        </span>人<span><a class="add-user exam-add-new-user"
                                         style="line-height: 20px;text-decoration: underline">新增人员</a>
                    </>
                        </span>
                    </label>
                </div>
            </div>
            <div class="pe-user-msg-detail">
                <span class="pe-input-tree-text">
                         <span>分数设置:</span>
                    </span>
                <div class="pe-gender-wrap">
                    <label class="pe-radio green-raido-check">
                    <#if exam.isTransient=='t'>
                        <span class="iconfont icon-checked-radio"></span>
                    <span class="pe-select-true-answer">
                        <input class="pe-form-ele" checked="checked" type="radio" value="FULLMARK"
                               name="examSetting.scoreSetting"/>满分100分
                    <#else>
                        <span class="iconfont <#if exam??&& exam.examSetting?? &&exam.examSetting.scoreSetting?? && exam.examSetting.scoreSetting=='FULLMARK'>icon-checked-radio<#else>icon-unchecked-radio</#if>"></span>
                    <span class="pe-select-true-answer">
                        <input class="pe-form-ele" <#if exam.examSetting.scoreSetting=='FULLMARK'>
                               checked="checked"</#if> type="radio" value="FULLMARK"
                               name="examSetting.scoreSetting"/>满分100分
                    </#if>

                    </span>
                    </label>
                    <label class="pe-radio green-raido-check">
                        <span class="iconfont <#if exam??&& exam.examSetting?? &&exam.examSetting.scoreSetting?? && exam.examSetting.scoreSetting=='ORIGINAL'>icon-checked-radio<#else>icon-unchecked-radio</#if>"></span>
                        <span class="pe-select-true-answer">
                        <input class="pe-form-ele"
                               <#if exam??&& exam.examSetting?? &&exam.examSetting.scoreSetting??&&exam.examSetting.scoreSetting=='ORIGINAL'>checked="checked"</#if>
                               type="radio" value="ORIGINAL" name="examSetting.scoreSetting"/>试卷原分
                    </span>
                    </label>
                </div>
            </div>
            <div class="pe-user-msg-detail" style="margin-bottom:40px;">
                <label class=" pe-question-label">
                     <span class="pe-input-tree-text">
                         <span>及格条件:</span>
                    </span>
                <#if exam?? && exam.examSetting?? && exam.examSetting.passRate??>
                ${(exam.examSetting.passRate)!}%
                <#else>
                    <input class="pe-stand-filter-form-input pe-question-score-num" type="text"
                           name="examSetting.passRate"
                           style="width: 40px;">%
                </#if>

                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class=" pe-question-label">
                     <span class="pe-input-tree-text">
                         <span>结束时间:</span>
                    </span>
                    <div class="pe-date-wrap">
                        <input id="peExamEndTime"
                               value="<#if exam.endTime??>${(exam.endTime)!}</#if>"
                               class="pe-table-form-text pe-time-text pe-end-time laydate-icon"
                               type="text" onclick="laydate({format:'YYYY-MM-DD',istime:true,istoday:false})"
                               style="width:200px;" name="endTime"> <span class="add-paper-tip-text">不填则一直生效</span>
                    </div>

                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text">
                         <span>考试时长:</span>
                    </span>
                    限制考试时长为
                <#if exam?? && exam.examSetting??&& exam.examSetting.examLength??&&exam.examSetting.examLength!=0>
                ${(exam.examSetting.examLength)!}分钟
                <#elseif exam.isTransient=='f'&&exam.examSetting.examLength==0>
                    不限时长
                <#elseif exam.isTransient=='t'>
                    <input class="pe-stand-filter-form-input pe-question-score-num" value="" type="text"
                           style="width: 40px;" name="examSetting.examLength" maxlength="11">分钟
                </#if>
                    <span class="add-paper-tip-text">不填则不限制考试时长</span>
                </label>
            </div>
        </div>
        <div class="pe-user-msg-detail">
                <span class="pe-input-tree-text" style="width:auto;">
                         <span>答案是否可见:</span>
                    </span>
            <div class="pe-gender-wrap">
                <label class="pe-radio green-raido-check">
                <#if exam.isTransient=='t'>
                    <span class="iconfont icon-checked-radio"></span>
                        <span class="pe-select-true-answer">
                        <input class="pe-form-ele" type="radio" checked="checked" value="true"
                               name="examSetting.answerlimit"/>可见</span>
                <#else>
                    <span class="iconfont <#if exam?? && exam.examSetting??&& exam.examSetting.answerlimit??&&exam.examSetting.answerlimit==true>icon-checked-radio<#else>icon-unchecked-radio</#if>"></span>
                        <span class="pe-select-true-answer">
                        <input class="pe-form-ele" type="radio"
                               <#if exam?? && exam.examSetting??&& exam.examSetting.answerlimit??&&exam.examSetting.answerlimit==true>checked="checked"</#if>
                               value="true"
                               name="examSetting.answerlimit"/>可见</span>
                </#if>
                </label>
                <label class="pe-radio green-raido-check">
                    <span class="iconfont <#if exam?? && exam.examSetting??&& exam.examSetting.answerlimit??&&exam.examSetting.answerlimit==false>icon-checked-radio<#else>icon-unchecked-radio</#if>"></span>
                        <span class="pe-select-true-answer">
                        <input class="pe-form-ele"
                               <#if exam?? && exam.examSetting??&& exam.examSetting.answerlimit??&&exam.examSetting.answerlimit==false>checked="checked"</#if>
                               type="radio" value="false" name="examSetting.answerlimit"/>不可见
                    </span>
                </label>
            </div>
        </div>
        </div>
        <div class="pe-btns-wrap" style="margin-top: 60px;margin-bottom: 94px;">
        <#if exam?? && exam.isTransient=='f'>
            <button class="pe-btn pe-btn-blue pe-btn-save mock-update" type="submit" style="margin-left:89px;">保存修改
            </button>
        <#elseif exam?? &&exam.isTransient=='t'>
            <button class="pe-btn pe-btn-blue pe-btn-save mock-save" type="submit" style="margin-left:89px;">保存</button>
        </#if>
            <button class="pe-btn pe-btn-cancel" type="button">取消</button>
        </div>
    </form>
</section>
<!---选择试卷--->
<!---选择试卷模板---->
<script type="text/template" id="errMsgInfo">
    <span class="pe-form-validate-tip">
        <span class="iconfont icon-caution-tip"></span>
        <span><%=errMsg%></span>
    </span>
</script>
<script>
    $(function () {
        var checkParameters = function () {
            var passRate = $('input[name="examSetting.passRate"]').val();
            if (/^\+?[1-9][0-9]*$/.test(passRate)) {
                $('input[name="examSetting.passRate"]').after(_.template($('#errMsgInfo').html())({errMsg: '请输入数字！'}))
            }
        }
        //判断名字是否过长
        $('input[name="examName"]').keyup(function () {
            $('.pe-form-validate-tip').remove();
            var examName = $('input[name="examName"]').val();
            if (examName.length > 50) {
                $('input[name="examName"]').after(_.template($('#errMsgInfo').html())({errMsg: '模拟考试名称过长！'}));
            }
        });
        //选择试卷
        $('.pe-add-user-all-wrap').delegate('.exam-paper-setting-btn', 'click', function () {
            var papers = $(".exam-paper>a");
            if (papers.size() >= 1) {
                PEMO.DIALOG.tips({
                    content: "只能选择一份试卷！"
                });
                return;
            }
            PEMO.DIALOG.selectorDialog({
                title: '选择试卷',
                content: [pageContext.rootPath + '/ems/exam/manage/addExamPaper?examId=${(exam.id)!}', 'no'],
                area: ['925px', '580px'],
                btn: ['取消', '确认'],
                needPagination: true,
                skin: 'pe-add-exam-dialog exam-create-paper-dialog',
                btn2: function () {
                    var $paperCheck = $($(layer.getChildFrame('.select-paper-template'))).find("input[name='paperCheck']:checked").parent('.pe-paper-check');
                    var thisCheckId = $paperCheck.data('id');
                    var thisCheckName = $paperCheck.data('title');
                    var thisCheckType = $paperCheck.data('type');
                    if (!thisCheckId) {
                        PEMO.DIALOG.tips({
                            content: '请选择试卷！',
                            btn: ['我知道了'],
                            yes: function (index) {
                                layer.close(index);
                            }
                        });

                        return false;
                    }

                    var tempMap = {};
                    var tempId = $paperCheck.attr("data-id");
                    var tempName = $paperCheck.attr("data-title");
                    tempMap[tempId] = tempName;
                    console.log(tempMap);
                    var bankDom = '<a title="' + tempName + '" data-id="' + tempId + '" class="add-question-bank-item bank-list expire-content-class"><span class="paper-random-bank">'
                            + tempName + '</span><span class="iconfont icon-inputDele expire-delete-btn-class"><input type="hidden" name="itemBankId" value="'
                            + tempId + '"/></span></a><input name="paperTemplate.id" hidden value="' + tempId + '"/>';

                    $(".exam-paper-setting-btn").before(bankDom);
                    $('input[name="templateId"]').val(tempId);
                    layer.closeAll();
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/checkPaperTemplate',
                        data: {'templateId': tempId},
                        success: function (data) {
                            if (data.success) {
                                $('.exam-create-paper-dialog').hide();
                                /!*生成试卷loading弹框样式*!/
                                var loadingLayerIndex = layer.open({
                                    type: 1,
                                    closeBtn: 0,
                                    title: '',
                                    skin: 'creating-paper-dialog',
                                    area: ['620px', '300px'], //宽高
                                    content: _.template($('#paperCreatingTemp').html())({data: dataLoading})
                                });
                                setTimeout(function () {
                                    layer.close(loadingLayerIndex);
                                    var size = 1;
                                    thisCheckType === 'RANDOM' ? size = 2 : size;
                                    var dataSuccess = {
                                        "type": dataLoading.type,
                                        "paperName": dataLoading.paperName,
                                        "size": 2
                                    };

                                    editPaper.generatePaper(thisCheckId, size, function (data) {
                                        var params = {id: '${(exam.id)!}', optType: optType};
                                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamPaper', params);
                                    }, dataSuccess);
                                    layer.closeAll();
                                    return false;
                                }, 2000);

                            } else {
                                PEMO.DIALOG.alert({
                                    content: data.message,
                                    btn: ['我知道了'],
                                    yes: function (index) {
                                        layer.close(index);
                                        layer.close(loadingLayerIndex);
                                    }
                                });
                            }


                        }
                    });
                    return false;
                },
                btn1: function () {
                    layer.closeAll();
                }
            });
        });
        var examId = $("input[name='id']").val();
        var isFirst = $("input[name='isTransient']").val();
        $('.add-user').on('click', function () {
            PEMO.DIALOG.selectorDialog({
                title: '按人员添加',
                area: ['970px', '580px'],
                content: [pageContext.rootPath + '/ems/simulationExam/manage/initSelectorUserPage?id=' + examId + '&isTransient=' + isFirst, 'no'],
                btn: ['关闭'],
                btn1: function (index) {
                    layer.close(index);
                    var userNum = localStorage.getItem("MOCK_EXAM_USER" + examId);
                    $(".exam-user").text(userNum);
                }
            });
        });

        $(".pe-add-user-all-wrap").delegate('.expire-delete-btn-class', 'click', function () {
            $(".expire-content-class").remove();
            $('input[name="paperTemplate.id"]').remove();

        });

        $('.steps-all-panel .add-paper-no-item-wrap').hover(
                function (e) {
                    var e = e || window.event;
                    e.stopPropagation();
                    $(this).addClass('no-paper-wrap-hover');
                },
                function (e) {
                    var e = e || window.event;
                    e.stopPropagation();
                    $(this).removeClass('no-paper-wrap-hover');
                }
        );

        function checkExam() {
            var tempId = $(".exam-paper>a").attr("data-id");
            if (tempId === null || tempId === undefined || tempId === "") {
                PEMO.DIALOG.tips({
                    content: "请选择一份试卷！"
                });
                return false;
            }
            var examName = $('input[name="examName"]').val();
            if (examName === null || examName === undefined || examName === "") {
                PEMO.DIALOG.tips({
                    content: "请输入考试名称！"
                });
                return false;
            }
            var passRate = $('input[name="examSetting.passRate"]').val();
            if (passRate === null || passRate === undefined || passRate === "") {
                PEMO.DIALOG.tips({
                    content: "请输入及格条件！"
                })
                return false;
            }
            var aw = $(".user-range .icon-checked-radio+span>input");
            var userNum = $(".exam-user").text();
            if ("LIMIT" === aw.val()) {
                if (0 === parseInt(userNum)) {
                    PEMO.DIALOG.tips({
                        content: "请选择指定人员！"
                    });
                    return false;
                }
            }
            var endTime = $('input[name="endTime"]').val();
            if (endTime !== null || endTime !== undefined || endTime !== "") {
                var dt = new Date(endTime);
                if (new Date().valueOf() > dt.valueOf()) {
                    PEMO.DIALOG.tips({
                        content: "结束时间不能小于当前时间！"
                    });
                    return false;
                }
            }
            return true;

        };
        //保存考试
        $('.mock-save').on('click', function () {
            var pass = checkExam();
            if (!pass) {
                return;
            }
            var templateId = $('input[name="templateId"]').val();
            $.post(pageContext.rootPath + "/ems/exam/manage/checkPaperTemplate?templateId=" + templateId,
                    {}, function (data) {
                        if (!data.success) {
                            PEMO.DIALOG.tips({
                                content: data.message
                            });

                            return false;
                        }

                        /* PEMO.DIALOG.tips({
                             content: data.message
                         });*/
                    }, 'json');
            $.post(pageContext.rootPath + "/ems/simulationExam/manage/saveMockExam?" + $('#editItemForm').serialize(),
                    {}, function (data) {
                        if (data.success) {
                            PEMO.DIALOG.tips({
                                content: "模拟考试添加成功！",
                                end: function () {
                                    location.href = '#url=${ctx!}/ems/simulationExam/manage/initSimulationExamPage&nav=examMana';
                                }
                            });

                            return false;
                        }

                        PEMO.DIALOG.tips({
                            content: data.message
                        });
                    }, 'json');
        });
        //保存修改模拟考试
        $('.mock-update').on('click', function () {
            $.post(pageContext.rootPath + "/ems/simulationExam/manage/updateMockExam?" + $('#editItemForm').serialize(),
                    {}, function (data) {
                        if (data.success) {
                            PEMO.DIALOG.tips({
                                content: "模拟考试修改成功！",
                                end: function () {
                                    location.href = '#url=${ctx!}/ems/simulationExam/manage/initSimulationExamPage&nav=examMana';
                                }
                            });

                            return false;
                        }

                        PEMO.DIALOG.tips({
                            content: data.message
                        });
                    }, 'json');
        });

        $('.pe-btn-cancel').on('click', function () {
            history.go(-1);
        });

    });


</script>