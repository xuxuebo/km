<#assign ctx=request.contextPath/>
<#--此处以下 到 练习结束部分 为练习的页面;上面的等后台嵌入-->
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">考试</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">练习管理</li>
    <#if exercise.id??&&exercise.optType=="UPDATE">
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">编辑</li>
    <#elseif exercise.id??&&exercise.optType=='VIEW'>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">预览</li>
    <#else>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">创建</li>
    </#if>
    </ul>
</div>
<form id="templateForm">
    <div class="pe-main-wrap exercise-main-content">
        <section id="peMainPulickContent" class="pe-main-content " >
            <section class="pe-add-question-wrap exercise-all-wrap add-exercise-wrap" style="width:auto;">
                <form id="exerciseForm">
                    <input name="id" value="${(exercise.id)!}" type="hidden">
                    <div class="pe-stand-form-cell pe-exercise-box">
                        <label class="pe-question-label">
                        <span class="pe-input-tree-text pe-exercise-lable">
                         <span><span style="color:red;padding-top:12px;">*</span>练习编号:</span>
                        </span>
                            <div class="exercise-choosen-bank" style="padding:0;">
                            <#if exercise.id??>
                                <span>
                                ${(exercise.exerciseCode)!}
                            </span>
                            <#else>
                                <input class="pe-stand-filter-form-input pe-question-score-num" type="text"
                                       name="exerciseCode"
                                       value="${(exercise.exerciseCode)!}"
                                       maxlength="50"/>
                            </#if>
                            </div>
                            <em class="error"></em>
                        </label>
                    </div>
                    <div class="pe-stand-form-cell pe-exercise-box">
                        <label class="pe-question-label">
                     <span class="pe-input-tree-text pe-exercise-lable">
                         <span><span style="color:red;padding-top:12px;">*</span>练习名称:</span>
                    </span>
                            <div class="exercise-choosen-bank" style="padding:0;">
                            <#if exercise.id??>
                                <input class="pe-stand-filter-form-input pe-question-score-num" type="text"
                                       name="exerciseName" <#if exercise.optType??&&exercise.optType=='VIEW'> readonly="readonly" style="border: 0;overflow: hidden;"</#if>
                                       value="${(exercise.exerciseName)!}"  placeholder="${(exercise.exerciseName)!}"
                                       maxlength="50"/>
                            <#else>
                                <input class="pe-stand-filter-form-input pe-question-score-num" type="text"
                                       name="exerciseName"
                                       value="${(exercise.exerciseName)!}"
                                       maxlength="50"/>
                            </#if>
                            </div>

                            <em class="error"></em>
                        </label>
                    </div>
                    <div class="pe-stand-form-cell pe-exercise-box">
                        <label class="pe-question-label" style="height:auto;min-height:40px;">
                        <span class="pe-input-tree-text pe-exercise-lable">
                            <span><span style="color:red;padding-top:12px;">*</span>选择题库:</span>
                        </span>
                            <div class="exercise-choosen-bank" style="width: 600px; <#if exercise.id??>padding:0<#else>padding:3px 0 0 0;</#if>">
                            <#if exercise.id??>
                                <span class="exam-has-added-user-num">
                                </span>
                                <#if (exercise.itemBanks??) && (exercise.itemBanks?size>0)>
                                    <#list exercise.itemBanks as itemBank>
                                        <a title="${(itemBank.bankName)!}" class="add-question-bank-item bank-list ">
                                         <span class="paper-random-bank">
                                         ${(itemBank.bankName)!}
                                         </span>
                                        </a>
                                    </#list>
                                </#if>
                            <#else>
                                <span class="exam-has-added-user-num">
                                    </span>
                                <dd style="overflow: hidden;" class="banklist">
                                    <#--<a title="${(itemBank.bankName)!}">-->
                                        <span class="pe-like-link pe-choosen-question-bank"
                                              style="float: left;">选择题库</span>
                                    <#--</a>-->
                                </dd>
                            </#if>
                            </div>
                        </label>
                    </div>
                    <div class="pe-stand-form-cell pe-exercise-box">
                        <label class="pe-question-label" style="height:auto;min-height:40px;">
                        <span class="pe-input-tree-text pe-exercise-lable">
                            <span>选择知识点:</span>
                        </span>
                            <div class="exercise-choosen-bank" style="width: 600px;line-height:32px;">
                            <#if exercise.id??>
                                <span class="exam-has-added-user-num">
                                </span>
                                <#if (exercise.knowledges??)&&(exercise.knowledges?size>0)>
                                    <#list exercise.knowledges as knowledge>
                                        <div class="pe-paper-item">
                                            <a title="${(knowledge.knowledgeName)!}"
                                               class="add-question-bank-item knowledge-list">
                                                <span class="paper-random-bank">${(knowledge.knowledgeName)!}</span>
                                            </a>
                                        </div>
                                    </#list>
                                <#else>
                                全部知识点
                                </#if>
                            <#else>
                                <span class="exam-has-added-user-num">
                                </span>
                                <span class="pe-like-link pe-choosen-knowledge" style="float: left;">选择知识点</span>
                            </#if>
                            </div>
                        </label>
                    </div>
                    <div class="pe-stand-form-cell pe-exercise-box">
                        <label class="pe-question-label" for="">
                        <span class="pe-input-tree-text pe-exercise-lable">
                            <span>可用范围:</span>
                        </span>
                            <div class="exercise-choosen-bank">
                                <label class="floatL pe-radio pe-check-by-list  <#if exercise.optType??&&exercise.optType=="VIEW"> add-paper-tip-text noClick</#if>" for="" style="margin-right:15px;">
                                    <span class="iconfont <#if !(exercise.applicationScope??) || (exercise.applicationScope??&&exercise.applicationScope=="ALL")>icon-checked-radio<#else>icon-unchecked-radio</#if> "></span>
                                    <input id=""
                                           class="pe-form-ele"<#if !(exercise.applicationScope??)|| (exercise.applicationScope??&&exercise.applicationScope=="ALL")>
                                           checked="checked"</#if> type="radio" name="applicationScope" value="ALL">
                                    公开可用
                                </label>
                                <label class="floatL pe-radio pe-check-by-list   <#if exercise.optType??&&exercise.optType=="VIEW"> add-paper-tip-text noClick</#if>" for="" style="margin-right:15px;">
                                    <span class="iconfont <#if exercise.applicationScope?? && exercise.applicationScope=="PORTION">icon-checked-radio<#else>icon-unchecked-radio</#if> "></span>
                                    <input id=""
                                           <#if optType??&&optType='VIEW'>readonly="readonly"</#if>
                                           class="pe-form-ele" <#if exercise.applicationScope?? && exercise.applicationScope=="PORTION">
                                           checked="checked"</#if> type="radio" name="applicationScope" value="PORTION">
                                    指定可用
                                    <span class="show-select-portion"
                                          <#if !(exercise.applicationScope?? && exercise.applicationScope=="PORTION") ||exercise.optType=='VIEW'>style="display: none;"</#if>>
                                        <span class="pe-exercise-num"
                                              style="color:#199ae2;margin-left: 20px;">${(exerciseNum)!"0"}</span>人&emsp;
                                                <span class="pe-like-link select-user-btn">
                                            选择考生
                                        </span>
                                    </span>
                                </label>
                            </div>
                        </label>
                    </div>
                    <div class="pe-stand-form-cell pe-exercise-box">
                        <label class="pe-time-wrap">
                        <span class="pe-input-tree-text pe-exercise-lable">
                            <span>结束时间:</span>
                        </span>
                            <#if exercise.optType??&&exercise.optType=="VIEW">
                                <div class="pe-date-wrap" style="width: 260px;" style="border: 0;">
                                <input id="peExamDialogEndTime" style="width: 200px;border: 0;" value="<#if exercise.endTime??>${(exercise.endTime?string('yyyy-MM-dd HH:mm'))!}<#else>不限时</#if>"
                                       class="pe-table-form-text pe-time-text pe-end-time"
                                       type="text" name="endTime" readonly="readonly">
                                </div>
                            <#else>
                            <div class="pe-date-wrap" style="width: 260px;">
                                <input id="peExamDialogEndTime" style="width: 200px"
                                       class="pe-table-form-text  sui-date-picker pe-time-text pe-end-time laydate-icon"
                                       type="text" name="endTime" data-toggle='datepicker' data-date-timepicker='true'
                                       value="${(exercise.endTime?string('yyyy-MM-dd HH:mm'))!}" readonly="readonly">
                            </div>
                                <span style="display: inline-block;color: #999;font-size: 12px;">*不填则一直生效</span>
                            </#if>

                        </label>
                    </div>
                </form>
            </section>
            <div class="pe-stand-form-cell">
                <div class="pe-btns-group-wrap" style="text-align:center;margin-bottom: 20px;" <#if exercise.optType??&&exercise.optType=='VIEW'>style="display: none"</#if>>
                <#if exercise.id??>
                    <#if exercise.optType=='UPDATE'>
                    <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn update-exercise">保存修改</button>
                    <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">取消</button>
                    </#if>
                <#else>
                    <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn enable-exercise">保存</button>
                    <button type="button" class="pe-btn pe-btn-white pe-step-back-btn">取消</button>
                </#if>

                </div>
            </div>
        <#--练习页面结束-->
        </section>
    </div>
</form>
<script>
    $(function () {
        var id = '${(exercise.id)!}';
        var addExercise = {
            init: function () {
                var _this = this;
                _this.bind();
            },

            checkTime: function () {
                var $endTime = $('input[name="endTime"]');
                var endTime = moment($endTime.val()).valueOf();
                var nowTime = moment('${(nowDate)!}').valueOf();
                if (nowTime > endTime) {
                    if (!$endTime.siblings('.error').get(0)) {
                        $endTime.addClass('error').after('<em id="' + $endTime.attr("name") + '-error" class="error">结束时间不能小于当前时间</em>');
                    } else {
                        $endTime.addClass('error');
                        $endTime.siblings('.error').show().html('结束时间不能小于当前时间');
                    }

                    return false;
                }

                if ($endTime.siblings('.error').get(0)) {
                    $endTime.siblings('.error').html('').hide();
                }

                $endTime.removeClass('error');
                return true;
            },

            bind: function () {
                $('.exercise-all-wrap').delegate('.icon-inputDele','click',function(){
                        var _thisParent = $(this).parents('.pe-paper-item');
                            _thisParent.remove();
                });
                $('.pe-check-by-list').off().click(function () {
                    if($(this).hasClass('noClick')){
                        return false;
                    }
                    if ($(this).find('.icon-checked-radio ').length > 0) {
                        return false;
                    }

                    $('.show-select-portion').hide();
                    $('.pe-check-by-list').each(function (i, e) {
                        if($(e).hasClass("noClick")){
                            return false;
                        }
                        $(this).find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                        $(this).find('input[type="radio"]').removeProp('checked');
                    });


                    var iconCheck = $(this).find('span.iconfont');
                    var thisRealCheck = $(this).find('input[type="radio"]');
                    iconCheck.addClass('icon-checked-radio peChecked');
                    thisRealCheck.prop('checked', 'checked');//这里在ie8下目前会报错“意外的调用了方法”,待解决
                    if (thisRealCheck.val() === 'PORTION') {
                        $('.show-select-portion').show();
                    }
                });

                $('.update-exercise').on('click', function () {
                    if (!addExercise.checkTime()) {
                        return false;
                    }

                    var exerciseName = $('input[name="exerciseName"]').val();
                    if (!exerciseName) {
                        $('input[name="exerciseName"]').parent('.exercise-choosen-bank').next('.error').html('练习名称不可为空');
                        return false;
                    } else {
                        $('input[name="exerciseName"]').parent('.exercise-choosen-bank').next('.error').html('');
                    }
                    if (exerciseName.length > 50) {
                        $('input[name="exerciseName"]').parent('.exercise-choosen-bank').next('.error').html('练习名称不超过50字');
                        return false;
                    } else {
                        $('input[name="exerciseName"]').parent('.exercise-choosen-bank').next('.error').html('');
                    }
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exercise/manage/update',
                        data: $('#templateForm').serializeArray(),
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: "保存修改成功！",
                                    time: 1000,
                                    end: function () {
                                        location.href = '#url=' + pageContext.rootPath + '/ems/exercise/manage/initPage&nav=examMana';
                                    }
                                });

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
                });

                $('.pe-step-back-btn').on('click', function () {
                    location.href = '#url=' + pageContext.rootPath + '/ems/exercise/manage/initPage&nav=examMana';
                });

                $('.enable-exercise').on('click', function () {
                    var exerciseCode = $('input[name="exerciseCode"]').val();
                    if (!exerciseCode) {
                        $('input[name="exerciseCode"]').parent('.exercise-choosen-bank').next('.error').html('练习编号不可为空');
                        return false;
                    } else {
                        $('input[name="exerciseCode"]').parent('.exercise-choosen-bank').next('.error').html('');
                    }

                    var exerciseName = $('input[name="exerciseName"]').val();
                    if (!exerciseName) {
                        $('input[name="exerciseName"]').parent('.exercise-choosen-bank').next('.error').html('练习名称不可为空');
                        return false;
                    } else {
                        $('input[name="exerciseName"]').parent('.exercise-choosen-bank').next('.error').html('');
                    }
                    if (exerciseName.length > 50) {
                        $('input[name="exerciseName"]').parent('.exercise-choosen-bank').next('.error').html('练习名称不超过50字');
                        return false;
                    } else {
                        $('input[name="exerciseName"]').parent('.exercise-choosen-bank').next('.error').html('');
                    }

                    var itemBlankId = $('input[name="itemBankId"]').length;
                    if (!itemBlankId) {
                        PEMO.DIALOG.alert({
                            content: "请至少选择一个题库",
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });
                        return false;
                    }

                    if (!addExercise.checkTime()) {
                        return false;
                    }

                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exercise/manage/save',
                        data: $('#templateForm').serializeArray(),
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: "启用成功！",
                                    time: 1000,
                                    end: function () {
                                        history.back(-1);
                                    }
                                });

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
                });

                $('.select-user-btn').on('click', function () {
                    window.open("${ctx!}/ems/exercise/manage/initUserPage?exerciseId=" + id, "EXERCISE_USER");
                });
                $('.pe-choosen-question-bank').on('click', function () {
                    PEMO.DIALOG.selectorDialog({
                        title: '选择题库',
                        area: ['960px', '620px'],
                        content: [pageContext.rootPath + '/ems/template/manage/initSelectBankPage?itemAttribute=EXERCISE', 'no'],
                        success: function (layero, index) {
                            layer.getChildFrame('.select-bank-ok-btn').on('click', function () {
                                var noAuthBankIds = [];
                                $('.bank-list.expire-content-class').each(function (index, ele) {
                                    noAuthBankIds.push($(ele).find('input[name="itemBankId"]').val());
                                });
                                $('.bank-list').remove();
                                $(layer.getChildFrame('.selected-bank-name')).each(function (index, ele) {
                                    var bankName = $(ele).attr('title');
                                    var id = $(ele).data('id');
                                    if (noAuthBankIds.indexOf(id) >= 0) {
                                        var bankDom = '<a title="' + bankName + '" class="add-question-bank-item bank-list expire-content-class"><span class="paper-random-bank">'
                                                + bankName + '</span><span class="iconfont icon-inputDele expire-delete-btn-class"><input type="hidden" name="itemBankId" value="'
                                                + id + '"/></span></a>';
                                    } else {
                                        bankDom = '<div class="pe-paper-item"><a title="' + bankName + '" class="add-question-bank-item bank-list"><span class="paper-random-bank">'
                                                + bankName + '</span><span class="iconfont icon-inputDele"><input type="hidden" name="itemBankId" value="'
                                                + id + '"/></span></a></div>';
                                    }

                                    $('.pe-choosen-question-bank').before(bankDom);
                                });
                                layer.close(index);
                            });
                        }
                    });
                });
                $('.pe-choosen-knowledge').on('click', function () {
                    var itemBlankId = $('input[name="itemBankId"]').length;
                    if (!itemBlankId) {
                        PEMO.DIALOG.alert({
                            content: "请先选择题库！",
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });
                        return;
                    }

                    PEMO.DIALOG.selectorDialog({
                        title: '选择知识点',
                        area: ['900px', '490px'],
                        content: [pageContext.rootPath + '/ems/template/manage/initSelectKlPage?itemAttribute=EXERCISE', 'no'],
                        success: function (layero, index) {
                            layer.getChildFrame('.pe-btn-green').on('click', function () {
                                var expireKlIds = [];
                                $('.knowledge-list.expire-content-class').each(function (index, ele) {
                                    expireKlIds.push($(ele).find('input[name="knowledgeId"]').val());
                                });

                                $('.knowledge-list').remove();
                                $(layer.getChildFrame('.pe-selector-selected tbody td')).each(function (index, ele) {
                                    var name = $(ele).data('name');
                                    var id = $(ele).data('id');
                                    if (expireKlIds.indexOf(id) >= 0) {
                                        var knowledgeDom = '<a title="' + name + '" class="add-question-bank-item knowledge-list expire-content-class"><span class="paper-random-bank">'
                                                + name + '</span><span class="iconfont icon-inputDele expire-delete-btn-class"><input type="hidden" name="knowledgeId" value="'
                                                + id + '"/></span></a>';
                                    } else {
                                        knowledgeDom = '<div class="pe-paper-item"><a title="' + name + '" class="add-question-bank-item knowledge-list"><span class="paper-random-bank">'
                                                + name + '</span><span class="iconfont icon-inputDele"><input type="hidden" name="knowledgeId" value="'
                                                + id + '"/></span></a></div>';
                                    }

                                    $('.pe-choosen-knowledge').before(knowledgeDom);
                                });
                                layer.close(index);
                            });
                        }
                    });
                });
            }
        };
        addExercise.init();
    });

    function countUser(exerciseId, transientCreate) {
        PEBASE.ajaxRequest({
            url: pageContext.rootPath + '/ems/exercise/manage/countExerciseUser',
            success: function (data) {
                $(".pe-exercise-num").text(data);
            }
        });
    }
</script>
