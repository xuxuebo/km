<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">考试</li>
    <#if exam?? && exam.subject?? && exam.subject>
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
    <#else>
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
<section class="steps-all-panel exam-add-four-all-wrap offline-msg-setting-all-wrap">
    <form id="examManageForm">
        <div class="add-exam-top-head">
        <ul class="over-flow-hide step-items-wrap <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-step-state</#if>">
                <li class="add-paper-step-item floatL <#if exam.optType?? && (exam.optType == 'UPDATE' || exam.optType == 'VIEW')>edit-btn-hover basic-step-item<#else>step-complete</#if>">
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
            <#if exam?? && exam.subject?? && exam.subject>
                <li class="add-paper-step-item add-paper-step-three floatL overStep">
                    <div class="add-step-icon-wrap">
                        <div class="add-step-line"></div>
                        <span class="iconfont icon-step-circle floatL">
                       <span class="add-step-number">3</span>
                     </span>
                    </div>
                    <span class="add-step-text">考试设置</span>
                </li>
            <#else >
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
        <#--展示的页面-->
            <div class="add-exam-item-wrap default-simple-setting-panel">
            <#if exam.subject?? && !exam.subject>
                <dl class="over-flow-hide user-detail-msg-wrap">
                    <dt class="floatL user-detail-title">考试管理员:</dt>
                    <dd class="user-detail-value">
                        <span class="exam-has-added-user-num EXAM_MANAGER_name_${(exam.id)!}">
                        <#if (examSetting.examAuthList)??>
                            <#list examSetting.examAuthList as examAuth>
                                <span class="tags add-question-bank-item bank-list <#if exam.optType?? && (exam.optType == 'VIEW')>not-hover</#if>"
                                      data-id="${(examAuth.user.id)!}" data-text="${(examAuth.user.userName)!}">
                                    <span class="has-item-user-name" title="${(examAuth.user.userName)!}">${(examAuth.user.userName)!}</span>
                                    <#if exam.createBy?? && examAuth?? && examAuth.user?? && examAuth.user.id?? && exam.createBy != examAuth.user.id>
                                        <span class="iconfont icon-inputDele"></span>
                                    </#if>
                            </span>
                            </#list>
                        </#if>
                        <a href="javascript:;" class="exam-view-user add-manager" <#if exam.optType?? && (exam.optType == 'VIEW')>style="display:none;" </#if>>选择人员</a>
                        </span>
                    </dd>
                </dl>
            </#if>
                    <dl class="over-flow-hide user-detail-msg-wrap">
                    <dt class="floatL user-detail-title">成绩设置:</dt>
                    <dd class="user-detail-value">
                        <div>
                            <label class="pe-radio pe-check-by-list">
                                原试卷题目分数按比例折算成满分
                                <input class="pe-form-ele" type="hidden" value="CONVERT" name="scoreSetting.st"/>
                                <input type="text" name="scoreSetting.cm" class="exam-create-num-input"
                                       value="${(examSetting.scoreSetting.cm)!'100'}">分 &nbsp;&nbsp;<span
                                    class="iconfont icon-caution-tip"></span>&nbsp;&nbsp;
                                <span class="offline-tip" hidden="hidden">线下考试可以不使用试卷，总分<span class="show-total-cla">${(examSetting.scoreSetting.cm)!}</span>分，可自定义</span>
                            </label>
                        </div>
                        <input type="hidden" name="id" value="${(examSetting.id)!}"/>
                        <input type="hidden" name="exam.id" value="${(exam.id)!}"/>
                    </dd>
                </dl>
                <dl class="over-flow-hide user-detail-msg-wrap">
                    <dt class="floatL user-detail-title">考试消息设置:</dt>
                    <dd class="user-detail-value offline-msg-setting"><#--评卷后允许考生查看答卷和正确答案-->

                    <#assign eMsg = true/><#--考试通知examMessage-->
                    <#assign exM = (examSetting.messageSetting.eMsg.M)!false/>
                    <#assign exS = (examSetting.messageSetting.eMsg.S)!false/>
                    <#assign exE = (examSetting.messageSetting.eMsg.E)!false/>
                    <#if  (!exM && !exS  && !exE)>
                        <#assign eMsg = false/>
                    </#if>
                    <#assign caMsg = true/><#--考试作废通知cancelMessage-->
                    <#assign caM = (examSetting.messageSetting.caMsg.M)!false/>
                    <#assign caS = (examSetting.messageSetting.caMsg.S)!false/>
                    <#assign caE = (examSetting.messageSetting.caMsg.E)!false/>
                    <#if (!caM && !caS && !caE )>
                        <#assign caMsg = false/>
                    </#if>
                    <#assign reMsg = true/><#--考试移除人员通知removeMessage-->
                    <#assign reM = (examSetting.messageSetting.reMsg.M)!false/>
                    <#assign reS = (examSetting.messageSetting.reMsg.S)!false/>
                    <#assign reE = (examSetting.messageSetting.reMsg.E)!false/>
                    <#if  (!reM  && !reS  && !reE)>
                        <#assign reMsg = false/>
                    </#if>
                    <#assign eeMsg = true/><#--考试结束时间变更examEndTimeMessage-->
                    <#assign eeM = (examSetting.messageSetting.eeMsg.M)!false/>
                    <#assign eeS = (examSetting.messageSetting.eeMsg.S)!false/>
                    <#assign eeE = (examSetting.messageSetting.eeMsg.E)!false/>
                    <#if (!eeM && !eeS&& !eeE )>
                        <#assign eeMsg = false/>
                    </#if>
                    <#assign pmMsg = true/><#--发布成绩通知publishMarkMessage-->
                    <#assign pmM = (examSetting.messageSetting.pmMsg.M)!false/>
                    <#assign pmS = (examSetting.messageSetting.pmMsg.S)!false/>
                    <#assign pmE = (examSetting.messageSetting.pmMsg.E)!false/>
                    <#if (!pmM  && !pmS && !pmE )>
                        <#assign pmMsg = false/>
                    </#if>
                    <#assign muMsg = true/><#--补考通知-->
                    <#assign muM = (examSetting.messageSetting.muMsg.M)!false/>
                    <#assign muS = (examSetting.messageSetting.muMsg.S)!false/>
                    <#assign muE = (examSetting.messageSetting.muMsg.E)!false/>
                    <#if (!muM && !muS &&!muE )>
                        <#assign muMsg = false/>
                    </#if>
                        <div>
                            <div>
                                <label class="pe-checkbox pe-check-by-list" for="">
                                    <span class="iconfont <#if eMsg>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" <#if eMsg>checked="checked" </#if> id="eMsg"/>
                                    考试通知
                                </label>
                            </div>

                            <div style="margin-left:18px;">
                                <label class="pe-checkbox pe-check-by-list" for="">
                                    <span class="iconfont <#if exM>icon-checked-checkbox peChecked
                                    <#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true"  id="eMsg_M"
                                           name="messageSetting.eMsg['M']" <#if exM >checked="checked"</#if>/>
                                    站内信
                                </label>
                                <label class="pe-checkbox pe-check-by-list" for="">
                                    <span class="iconfont <#if exS>icon-checked-checkbox peChecked
                                   <#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" id="eMsg_S"
                                           name="messageSetting.eMsg['S']" <#if exS>checked="checked"</#if>/>
                                    电子邮件
                                </label>
                                <label class="pe-checkbox pe-check-by-list" for="">
                                    <span class="iconfont <#if exE >icon-checked-checkbox peChecked
                                    <#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" id="eMsg_E"
                                           <#if exE > checked="checked"</#if> name="messageSetting.eMsg['E']"/>
                                    手机短信
                                </label>
                            </div>
                        </div>
                        <div>
                            <div>
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if caMsg>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" <#if caMsg>checked="checked"</#if> id="caMsg"/>
                                    考试作废通知
                                </label>
                            </div>
                            <div style="margin-left:18px;">
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if caM >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" id="caMsg_M" value="true"
                                           name="messageSetting.caMsg['M']" <#if caM >checked="checked"</#if>/>
                                    站内信
                                </label>
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if caS>icon-checked-checkbox peChecked<#else >icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" id="caMsg_S"
                                           name="messageSetting.caMsg['S']" <#if caS >checked="checked"</#if>/>
                                    电子邮件
                                </label>
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if caE>icon-checked-checkbox peChecked<#else >icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" id="caMsg_E"
                                           name="messageSetting.caMsg['E']" <#if caE>checked="checked"</#if>/>
                                    手机短信
                                </label>
                            </div>
                        </div>
                        <div>
                            <div>
                                <div>
                                    <label class="pe-checkbox pe-check-by-list">
                                        <span class="iconfont <#if reMsg>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                        <input class="pe-form-ele" type="checkbox" <#if reMsg>checked="checked"</#if> id="reMsg"/>
                                        考试移除人员通知
                                    </label>
                                </div>
                            </div>
                            <div style="margin-left:18px;">
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if reM >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" id="reMsg_M"
                                           name="messageSetting.reMsg['M']"<#if reM >checked="checked"</#if>/>
                                    站内信
                                </label>
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if reS>icon-checked-checkbox peChecked<#else >icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" id="reMsg_S"
                                           name="messageSetting.reMsg['S']" <#if reS>checked="checked"</#if>/>
                                    电子邮件
                                </label>
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if reE>icon-checked-checkbox peChecked<#else >icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" id="reMsg_E"
                                           name="messageSetting.reMsg['E']" <#if reE>checked="checked"</#if>/>
                                    手机短信
                                </label>
                            </div>
                        </div>
                        <div>
                            <div>
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if eeMsg>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" <#if eeMsg>checked="checked"</#if> id="eeMsg"/>
                                    考试结束时间变更
                                </label>
                            </div>
                            <div style="margin-left:18px;">
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if eeM>icon-checked-checkbox peChecked<#else >icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" id="eeMsg_M"
                                           name="messageSetting.eeMsg['M']" <#if eeM>checked="checked"</#if>/>
                                    站内信
                                </label>
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if eeS>icon-checked-checkbox peChecked<#else >icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" id="eeMsg_S"
                                           name="messageSetting.eeMsg['S']" <#if eeS>checked="checked"</#if>/>
                                    电子邮件
                                </label>
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if eeE>icon-checked-checkbox peChecked<#else >icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" id="eeMsg_E"
                                           name="messageSetting.eeMsg['E']" <#if eeE>checked="checked"</#if>/>
                                    手机短信
                                </label>
                            </div>
                        </div>
                        <div>
                            <div>
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if pmMsg>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" <#if pmMsg>checked="checked"</#if> id="pmMsg"/>
                                    发布成绩
                                </label>
                            </div>
                            <div style="margin-left:18px;">
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if pmM >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" id="pmMsg_M"
                                           <#if pmM >checked="checked"</#if>
                                           name="messageSetting.pmMsg['M']"/>
                                    站内信
                                </label>
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if pmS >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" id="pmMsg_S"
                                           <#if pmS >checked="checked"</#if>
                                           name="messageSetting.pmMsg['S']"/>
                                    电子邮件
                                </label>
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if pmE >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" id="pmMsg_E"
                                           <#if pmE >checked="checked"</#if>
                                           name="messageSetting.pmMsg['E']"/>
                                    手机短信
                                </label>
                            </div>
                        </div>
                        <div>
                            <div>
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if muMsg>icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" <#if muMsg>checked="checked"</#if> id="muMsg"/>
                                    补考通知
                                </label>
                            </div>
                            <div style="margin-left:18px;">
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if muM >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" id="muMsg_M"
                                           <#if muM >checked="checked"</#if>
                                           name="messageSetting.muMsg['M']"/>
                                    站内信
                                </label>
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if muS >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" id="muMsg_S"
                                           <#if muS >checked="checked"</#if>
                                           name="messageSetting.muMsg['S']"/>
                                    电子邮件
                                </label>
                                <label class="pe-checkbox pe-check-by-list">
                                    <span class="iconfont <#if muE >icon-checked-checkbox peChecked<#else>icon-unchecked-checkbox</#if>"></span>
                                    <input class="pe-form-ele" type="checkbox" value="true" id="muMsg_E"
                                           <#if muE >checked="checked"</#if>
                                           name="messageSetting.muMsg['E']"/>
                                    手机短信
                                </label>
                            </div>
                        </div>
                    </dd>
                </dl>
            </div>
        </div>
        <input type="hidden" value="${(exam.examType)!"OFFLINE"}" name="exam.examType" >
    </form>
</section>
<div class="pe-btns-group-wrap default-simple-setting-btns"
     style="text-align:center;">
<#if exam.optType?? && (exam.optType == 'VIEW')>
    <div class="view-exam-group-one">
        <#if exam.source?? && exam.source == 'ADD'>
            <button type="button" class="pe-btn pe-large-btn pe-btn-white new-page-close-btn">关闭</button>
        <#else>
            <button type="button" class="pe-btn pe-btn-white pe-large-btn pe-step-back-btn">返回</button>
        </#if>
        <a href="javascript:;" class="pe-view-user-btn i-need-edit-exam"><span class="iconfont icon-edit"></span>我要编辑考试信息</a>
    </div>
    <div class="view-exam-group-two" style="display:none;">
        <button type="button" class="pe-btn pe-large-btn pe-btn-blue update-save-btn">保存</button>
        <button type="button" class="pe-btn pe-btn-white pe-large-btn pe-step-back-btn">返回</button>
    </div>
<#elseif (exam.optType?? && exam.optType == 'UPDATE')>
        <button type="button" class="pe-btn pe-btn-blue pe-step-save-draft update-save-btn">保存</button>
    <#if exam.source?? && exam.source == 'ADD'>
        <button type="button" class="pe-btn pe-large-btn pe-btn-white new-page-close-btn">关闭</button>
    <#else>
        <button type="button" class="pe-btn pe-btn-white pe-large-btn pe-step-back-btn">返回</button>
    </#if>
<#else>
        <button type="button" class="pe-btn pe-btn-purple pe-step-pre-btn">上一步</button>
        <button type="button" class="pe-btn pe-btn-blue pe-step-save-draft update-save-btn">保存为草稿</button>
        <button type="button" class="pe-btn pe-btn-blue
        <#if exam.subject?? && exam.subject>pe-subject-save-and-use<#else >pe-step-save-and-use</#if>"
                <#--onclick="window.location.href('/pe/front/manage/initPage#url=/pe/ems/exam/manage/examManage')"-->
        >保存并启用</button>
    <#if exam.source?? && exam.source == 'ADD'>
        <button type="button" class="pe-btn pe-large-btn pe-btn-white new-page-close-btn">关闭</button>
    <#else>
        <button type="button" class="pe-btn pe-btn-white pe-large-btn pe-step-back-btn">返回</button>
    </#if>
</#if>
</div>
<script>
    $(function () {
        var editExamSetting = {
            init: function () {
                var optType = '${(exam.optType)!}';
                var source = '${(exam.source)!}';
                var canEdit = false;
                if (optType == 'VIEW') {//预览试卷置灰
                    $('input:not(.laydate-time)').attr('disabled', true);
                }

                $('.exam-create-num-input').on('blur',function () {
                    var totalScore = $(this).val();
                    if(totalScore < 0){
                        totalScore = 0;
                        $(this).val(totalScore);
                    }

                    $('.show-total-cla').text(totalScore);
                });

                //我要编辑考试
                $('.i-need-edit-exam').on('click', function () {
                    canEdit = true;
                    $('input:not(.laydate-time)').removeAttr('disabled');
                    $('.view-exam-group-one').hide();
                    $('.view-exam-group-two').show();
                    $('.add-manager').show();
                    $('.icon-inputDele').parent().removeClass('not-hover');
                });

                $('.edit-step-state .basic-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType , source: source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamInfo', params);
                });

                $('.edit-step-state .paper-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType , source: source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamPaper', params);
                });

                $('.edit-step-state .arrange-step-item').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType , source: source};
                    $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initArrangePage', params);
                });

                $('.pe-step-back-btn').on('click',function(){
                    var subject = '${(exam.subject)!?string("true","false")}';
                    if (subject && subject === 'true') {
                        location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initSubjectPage&nav=examMana';
                    } else {
                        location.href = '#url=' + pageContext.rootPath + '/ems/exam/manage/initPage&nav=examMana';
                    }
                });

                $('.new-page-close-btn').on('click',function(){
                    window.close();
                });

                //上一步
                $('.pe-step-pre-btn').on('click', function () {
                    var params = {id: '${(exam.id)!}', optType: optType, source: source};
                    var subject = '${(exam.subject)!?string("true","false")}';
                    if (subject==='true') {
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initExamPaper', params);
                    } else {
                        $('#peMainPulickContent').load(pageContext.rootPath + '/ems/exam/manage/initArrangePage', params);
                    }
                });

                $('.add-manager').on('click', function () {
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

                //类别点击筛选事件
                $('.pe-radio.pe-check-by-list').off().click(function () {
                    if(optType ==='VIEW' && !canEdit){
                        return false;
                    }

                    var iconCheck = $(this).find('span.iconfont');
                    var thisRealCheck = $(this).find('input[type="radio"]');
                    if (iconCheck.hasClass('icon-unchecked-radio')) {
                        iconCheck.removeClass('icon-unchecked-radio').addClass('icon-checked-radio peChecked');
                        thisRealCheck.prop('checked', 'checked');//这里在ie8下目前会报错“意外的调用了方法”,待解决
                    }
                    switch (thisRealCheck.attr("id")) {
                        case "CONVERT":
                            $("#ORIGINAL").removeProp('checked');
                            $("#ORIGINAL").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                            $("input[name='scoreSetting.cm']").removeProp("disabled");
                            break;
                        case "ORIGINAL":
                            $("#CONVERT").removeProp('checked');
                            $("#CONVERT").parent().find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                            $("input[name='scoreSetting.cm']").prop("disabled", "disabled");
                            break;
                        default:
                            break;
                    }
                });

                $('.pe-checkbox.pe-check-by-list').off().on('click',function(e){
                    var e = e || window.event;
                    if(optType ==='VIEW' && !canEdit){
                        return false;
                    }

                    e.preventDefault();
                    var iconCheck = $(this).find('span.iconfont');
                    var thisRealCheck = $(this).find('input[type="checkbox"]');
                    if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                        editExamSetting.checkboxChecked(iconCheck, thisRealCheck);
                    } else {
                        editExamSetting.checkboxUnChecked(iconCheck, thisRealCheck);
                    }
                    switch (thisRealCheck.attr("id")) {
                        case "SHOW_MARK":
                            if (thisRealCheck.prop("checked")) {
                                $("input[name='rankSetting.rsn']").removeProp("disabled");
                            } else {
                                $("input[name='rankSetting.rsn']").prop("disabled", "disabled");
                            }
                            break;
                        case "eMsg":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#eMsg_M").parent().find('span.iconfont'), $("#eMsg_M").parent().find('input[type="checkbox"]'));
                                editExamSetting.checkboxChecked($("#eMsg_S").parent().find('span.iconfont'), $("#eMsg_S").parent().find('input[type="checkbox"]'));
                            } else {
                                editExamSetting.checkboxUnChecked($("#eMsg_M").parent().find('span.iconfont'), $("#eMsg_M").parent().find('input[type="checkbox"]'));
                                editExamSetting.checkboxUnChecked($("#eMsg_S").parent().find('span.iconfont'), $("#eMsg_S").parent().find('input[type="checkbox"]'));
                            }
                            editExamSetting.checkboxUnChecked($("#eMsg_E").parent().find('span.iconfont'), $("#eMsg_E").parent().find('input[type="checkbox"]'));
                            break;
                        case "eMsg_M":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#eMsg").parent().find('span.iconfont'), $("#eMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#eMsg_S").prop("checked") && !$("#eMsg_E").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#eMsg").parent().find('span.iconfont'), $("#eMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "eMsg_S":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#eMsg").parent().find('span.iconfont'), $("#eMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#eMsg_M").prop("checked") && !$("#eMsg_E").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#eMsg").parent().find('span.iconfont'), $("#eMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "eMsg_E":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#eMsg").parent().find('span.iconfont'), $("#eMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#eMsg_M").prop("checked") && !$("#eMsg_S").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#eMsg").parent().find('span.iconfont'), $("#eMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "caMsg":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#caMsg_M").parent().find('span.iconfont'), $("#caMsg_M").parent().find('input[type="checkbox"]'));
                                editExamSetting.checkboxChecked($("#caMsg_S").parent().find('span.iconfont'), $("#caMsg_S").parent().find('input[type="checkbox"]'));
                            } else {
                                editExamSetting.checkboxUnChecked($("#caMsg_M").parent().find('span.iconfont'), $("#caMsg_M").parent().find('input[type="checkbox"]'));
                                editExamSetting.checkboxUnChecked($("#caMsg_S").parent().find('span.iconfont'), $("#caMsg_S").parent().find('input[type="checkbox"]'));
                            }
                            editExamSetting.checkboxUnChecked($("#caMsg_E").parent().find('span.iconfont'), $("#caMsg_E").parent().find('input[type="checkbox"]'));
                            break;
                        case "caMsg_M":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#caMsg").parent().find('span.iconfont'), $("#caMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#caMsg_S").prop("checked") && !$("#caMsg_E").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#caMsg").parent().find('span.iconfont'), $("#caMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "caMsg_S":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#caMsg").parent().find('span.iconfont'), $("#caMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#caMsg_M").prop("checked") && !$("#caMsg_E").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#caMsg").parent().find('span.iconfont'), $("#caMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "caMsg_E":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#caMsg").parent().find('span.iconfont'), $("#caMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#caMsg_M").prop("checked") && !$("#caMsg_S").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#caMsg").parent().find('span.iconfont'), $("#caMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "reMsg":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#reMsg_M").parent().find('span.iconfont'), $("#reMsg_M").parent().find('input[type="checkbox"]'));
                                editExamSetting.checkboxChecked($("#reMsg_S").parent().find('span.iconfont'), $("#reMsg_S").parent().find('input[type="checkbox"]'));
                            } else {
                                editExamSetting.checkboxUnChecked($("#reMsg_M").parent().find('span.iconfont'), $("#reMsg_M").parent().find('input[type="checkbox"]'));
                                editExamSetting.checkboxUnChecked($("#reMsg_S").parent().find('span.iconfont'), $("#reMsg_S").parent().find('input[type="checkbox"]'));
                            }
                            editExamSetting.checkboxUnChecked($("#reMsg_E").parent().find('span.iconfont'), $("#reMsg_E").parent().find('input[type="checkbox"]'));
                            break;
                        case "reMsg_M":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#reMsg").parent().find('span.iconfont'), $("#reMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#reMsg_S").prop("checked") && !$("#reMsg_E").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#reMsg").parent().find('span.iconfont'), $("#reMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "reMsg_S":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#reMsg").parent().find('span.iconfont'), $("#reMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#reMsg_M").prop("checked") && !$("#reMsg_E").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#reMsg").parent().find('span.iconfont'), $("#reMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "reMsg_E":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#reMsg").parent().find('span.iconfont'), $("#reMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#reMsg_M").prop("checked") && !$("#reMsg_S").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#reMsg").parent().find('span.iconfont'), $("#reMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "eeMsg":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#eeMsg_M").parent().find('span.iconfont'), $("#eeMsg_M").parent().find('input[type="checkbox"]'));
                                editExamSetting.checkboxChecked($("#eeMsg_S").parent().find('span.iconfont'), $("#eeMsg_S").parent().find('input[type="checkbox"]'));
                            } else {
                                editExamSetting.checkboxUnChecked($("#eeMsg_M").parent().find('span.iconfont'), $("#eeMsg_M").parent().find('input[type="checkbox"]'));
                                editExamSetting.checkboxUnChecked($("#eeMsg_S").parent().find('span.iconfont'), $("#eeMsg_S").parent().find('input[type="checkbox"]'));
                            }
                            editExamSetting.checkboxUnChecked($("#eeMsg_E").parent().find('span.iconfont'), $("#eeMsg_E").parent().find('input[type="checkbox"]'));
                            break;
                        case "eeMsg_M":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#eeMsg").parent().find('span.iconfont'), $("#eeMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#eeMsg_S").prop("checked") && !$("#eeMsg_E").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#eeMsg").parent().find('span.iconfont'), $("#eeMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "eeMsg_S":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#eeMsg").parent().find('span.iconfont'), $("#eeMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#eeMsg_M").prop("checked") && !$("#eeMsg_E").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#eeMsg").parent().find('span.iconfont'), $("#eeMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "eeMsg_E":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#eeMsg").parent().find('span.iconfont'), $("#eeMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#eeMsg_M").prop("checked") && !$("#eeMsg_S").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#eeMsg").parent().find('span.iconfont'), $("#eeMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "pmMsg":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#pmMsg_M").parent().find('span.iconfont'), $("#pmMsg_M").parent().find('input[type="checkbox"]'));
                                editExamSetting.checkboxChecked($("#pmMsg_S").parent().find('span.iconfont'), $("#pmMsg_S").parent().find('input[type="checkbox"]'));
                            } else {
                                editExamSetting.checkboxUnChecked($("#pmMsg_M").parent().find('span.iconfont'), $("#pmMsg_M").parent().find('input[type="checkbox"]'));
                                editExamSetting.checkboxUnChecked($("#pmMsg_S").parent().find('span.iconfont'), $("#pmMsg_S").parent().find('input[type="checkbox"]'));
                            }
                            editExamSetting.checkboxUnChecked($("#pmMsg_E").parent().find('span.iconfont'), $("#pmMsg_E").parent().find('input[type="checkbox"]'));
                            break;
                        case "pmMsg_M":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#pmMsg").parent().find('span.iconfont'), $("#pmMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#eeMsg_S").prop("checked") && !$("#eeMsg_E").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#pmMsg").parent().find('span.iconfont'), $("#pmMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "pmMsg_S":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#pmMsg").parent().find('span.iconfont'), $("#pmMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#eeMsg_M").prop("checked") && !$("#eeMsg_E").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#pmMsg").parent().find('span.iconfont'), $("#pmMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "pmMsg_E":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#pmMsg").parent().find('span.iconfont'), $("#pmMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#eeMsg_M").prop("checked") && !$("#eeMsg_S").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#pmMsg").parent().find('span.iconfont'), $("#pmMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "muMsg":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#muMsg_M").parent().find('span.iconfont'), $("#muMsg_M").parent().find('input[type="checkbox"]'));
                                editExamSetting.checkboxChecked($("#muMsg_S").parent().find('span.iconfont'), $("#muMsg_S").parent().find('input[type="checkbox"]'));
                            } else {
                                editExamSetting.checkboxUnChecked($("#muMsg_M").parent().find('span.iconfont'), $("#muMsg_M").parent().find('input[type="checkbox"]'));
                                editExamSetting.checkboxUnChecked($("#muMsg_S").parent().find('span.iconfont'), $("#muMsg_S").parent().find('input[type="checkbox"]'));
                            }
                            editExamSetting.checkboxUnChecked($("#muMsg_E").parent().find('span.iconfont'), $("#muMsg_E").parent().find('input[type="checkbox"]'));
                            break;
                        case "muMsg_M":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#muMsg").parent().find('span.iconfont'), $("#muMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#muMsg_S").prop("checked") && !$("#muMsg_E").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#muMsg").parent().find('span.iconfont'), $("#muMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "muMsg_S":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#muMsg").parent().find('span.iconfont'), $("#muMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#muMsg_M").prop("checked") && !$("#muMsg_E").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#muMsg").parent().find('span.iconfont'), $("#muMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        case "muMsg_E":
                            if (thisRealCheck.prop("checked")) {
                                editExamSetting.checkboxChecked($("#muMsg").parent().find('span.iconfont'), $("#muMsg").parent().find('input[type="checkbox"]'));
                            } else if (!$("#muMsg_M").prop("checked") && !$("#muMsg_S").prop("checked")) {
                                editExamSetting.checkboxUnChecked($("#muMsg").parent().find('span.iconfont'), $("#muMsg").parent().find('input[type="checkbox"]'));
                            }
                            break;
                        default:
                            break;
                    }
                });

                $('.update-save-btn').on('click', function () {
                    editExamSetting.submitForm(function (data) {
                        PEMO.DIALOG.tips({
                            content: "保存成功！",
                            time: 1000,
                            end: function () {
                                history.back(-1);
                            }
                        });
                    });
                });
                //鼠标进入和离开事件
                $(".iconfont.icon-caution-tip").mouseover(
                        function () {
                            $(".offline-tip").removeAttr('hidden');
                        }
                );
                $(".iconfont.icon-caution-tip").mouseleave(
                        function () {
                            $(".offline-tip").attr('hidden', 'hidden');
                        }
                );

                //保存并启用
                $(".pe-step-save-and-use").click(function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/saveEnableExam',
                        data: $('#examManageForm').serialize(),
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
                                }
                            });
                        }
                    });

                });

                //科目的保存并启用
                $(".pe-subject-save-and-use").click(function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/saveEnableSubject',
                        data: $('#examManageForm').serialize(),
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

                //考试管理员删除功能
                $('.add-exam-step-four-wrap').delegate('.icon-inputDele','click',function(){
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

            },
            submitForm: function (callback) {
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exam/manage/saveExamSetting',
                    data: $('#examManageForm').serialize(),
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
            checkboxChecked: function (iconCheck, thisRealCheck) {
                if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                    iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                    thisRealCheck.prop('checked', 'checked');
                }
            },
            checkboxUnChecked: function (iconCheck, thisRealCheck) {
                if (iconCheck.hasClass('icon-checked-checkbox')) {
                    iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                    thisRealCheck.removeProp('checked');
                }
            },
            initData: function () {
                window.addEventListener("storage", function (e) {
                    if (e.key.indexOf('EXAM_MANAGER_name_') >=0 && e.newValue) {
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
<#--   </@p.pageFrame>-->