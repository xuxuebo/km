<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">用户</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">公司管理</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">编辑公司</li>
    </ul>
</div>
<section class="pe-add-user-all-wrap">
    <form id="editItemForm" class="validate" action="javascript:;">
        <input type="hidden" name="id" value="${(corpInfo.id)!}"/>
        <div class="pe-add-user-item-wrap over-flow-hide">
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                 <span class="pe-input-tree-text" style="width: 90px;">
                    <span style="color:red;">*</span>
                     <span>企业ID:</span>
                </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num" type="text"
                           value="${(corpInfo.corpCode)!}" <#if corpInfo?? && corpInfo.corpStatus != 'DRAFT'>disabled</#if>
                           name="corpCode" maxlength="50">
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class=" pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                        <span style="color:red;">*</span>
                         <span>公司名称:</span>
                    </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num" type="text" name="corpName"
                           value="${(corpInfo.corpName)!}"
                           maxlength="50"/>
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text flaotL clearF" style="width: 90px;">
                         <span style="color:red;">*</span>
                         <span>域名设置:</span>
                    </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num" value="${(corpInfo.domainName)!}"
                           type="text"
                           name="domainName" maxlength="200">
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span style="color:red;">*</span>
                         <span>并发数:</span>
                    </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num" value="${(corpInfo.concurrentNum)!}"
                           type="text"
                           name="concurrentNum" maxlength="20">
                    <span style="color:red;">填0则不限制</span>
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span style="color:red;">*</span>
                         <span>注册账号数:</span>
                    </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num" value="${(corpInfo.registerNum)!''}"
                           type="text"
                           name="registerNum" maxlength="20">
                    <span style="color:red;">填0则不限制</span>
                </label>
            </div>
            <#--<div class="pe-user-msg-detail">-->
                <#--<label class="pe-question-label">-->
                     <#--<span class="pe-input-tree-text" style="width: 90px;">-->
                         <#--<span>到期时间:</span>-->
                    <#--</span>-->
                    <#--<div class="pe-date-wrap">-->
                        <#--<input id="peExamDialogEndTime" data-suiindex = 'single'-->
                               <#--class="pe-table-form-text sui-date-picker pe-time-text pe-end-time laydate-icon"-->
                               <#--type="text" name="endTime"  data-toggle='datepicker' data-date-timepicker='false'-->
                               <#--value="${(corpInfo.endTime?string("yyyy-MM-dd"))!}" readonly="readonly">-->
                        <#--&lt;#&ndash;<input class="pe-table-form-text laydate-icon pe-adduser-text"&ndash;&gt;-->
                               <#--&lt;#&ndash;value="${(corpInfo.endTime?string("yyyy-MM-dd"))!}" type="text"&ndash;&gt;-->
                               <#--&lt;#&ndash;name="endTime" onclick="laydate({format:'YYYY-MM-DD'})">&ndash;&gt;-->
                        <#--<span style="color:red;">不填则永久生效</span>-->
                    <#--</div>-->
                <#--</label>-->
            <#--</div>-->
            <!--短信功能start-->
            <div class="pe-user-msg-detail" style="height: 80px;">
                <label class="pe-question-label" style="float: left;margin-left: 22px;">
                    <span  class="pe-input-tree-text">
                        <span >短信功能:</span>
                         <input class="pe-form-ele" id="MESSAGE_SETTING" type="radio" value="" name="messageStatus"/>
                    </span>
                </label>
                <div style="float: left;margin-left: 10px;">
                    <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> " style="display: block;">
                            <span  class="iconfont
                             <#if ((corpInfo.messageStatus)! != ""&&(corpInfo.messageStatus)! == 'OPEN')>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                        <input class="pe-form-ele" id="OPEN_MESSAGE" type="radio" value="OPEN" name="messageStatus"
                               <#if (corpInfo.messageStatus)! != ""&&(corpInfo.messageStatus)! == 'OPEN'>checked="checked"</#if>/>开启
                    </label>
                    <label class="pe-radio" style="display: block;">
                                <span class="iconfont
                                  <#if ((corpInfo.messageStatus)! != ""&&(corpInfo.messageStatus)! == 'CLOSE')||(corpInfo.id)! =="">icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                        <input class="pe-form-ele" id="CLOSE_MESSAGE" type="radio" value="CLOSE"
                               <#if (corpInfo.messageStatus)! == ""||(corpInfo.messageStatus)! == 'CLOSE'>checked="checked"</#if> name="messageStatus"/>关闭
                    </label>
                </div>
            </div>
            <!--短信功能end-->
            <#--公司来源-->
            <div class="pe-user-msg-detail" style="height: 80px;">
                <label class="pe-question-label" style="float: left;margin-left: 22px;">
                    <span  class="pe-input-tree-text">
                        <span >公司来源:</span>
                         <input class="pe-form-ele" id="fromAppType" type="radio" value="" name="fromAppType"/>
                    </span>
                </label>
                <div style="float: left;margin-left: 10px;">
                    <label class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> " style="display: block;">
                            <span  class="iconfont
                             <#if ((corpInfo.fromAppType)! != ""&&(corpInfo.fromAppType)! == 'PE')||(corpInfo.id)! =="">icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                        <input class="pe-form-ele" id="PESource" type="radio" value="PE" name="fromAppType"
                               <#if ((corpInfo.fromAppType)! != ""&&(corpInfo.fromAppType)! == 'PE')||(corpInfo.id)! =="">checked="checked"</#if>/>博易考
                    </label>
                    <label class="pe-radio" style="display: block;">
                                <span class="iconfont
                                  <#if ((corpInfo.fromAppType)! != ""&&(corpInfo.fromAppType)! == 'ELP')>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                        <input class="pe-form-ele" id="ELPSource" type="radio" value="ELP"
                               <#if (corpInfo.fromAppType)! != ""&&(corpInfo.fromAppType)! == 'ELP'>checked="checked"</#if> name="fromAppType"/>时代光华
                    </label>
                </div>
            </div>
            <#--公司来源end-->
        <#--版本-->
            <div class="pe-user-msg-detail" style="height: 80px;">
                <label class="pe-question-label" style="float: left;margin-left: 22px;">
                    <span  class="pe-input-tree-text">
                        <span >版本:</span>
                         <input class="pe-form-ele" id="version" type="radio" value="" name="version"/>
                    </span>
                </label>
                <div style="float: left;margin-left: 10px;">
                    <div>
                        <label id="FREE_version" class="pe-radio <#if (exam.status)! =='PROCESS'>add-paper-tip-text noClick</#if> " style="display: block;">
                            <span class="iconfont
                             <#if ((corpInfo.version)! != ""&&(corpInfo.version)! == 'FREE')||(corpInfo.id)! =="">icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                            <input class="pe-form-ele" id="version" type="radio" value="FREE" name="version"
                               <#if ((corpInfo.version)! != ""&&(corpInfo.version)! == 'FREE')||(corpInfo.id)! =="">checked="checked"</#if>/>免费版
                        </label>
                    </div>
                    <div class="pe-radio-wrap">
                        <div style="display: inline-block;">
                            <label id="ENTERPRISE_version" class="pe-radio" style="display: inline-block;">
                                    <span class="iconfont
                                      <#if ((corpInfo.version)! != ""&&(corpInfo.version)! == 'ENTERPRISE')>icon-checked-radio peChecked<#else>icon-unchecked-radio</#if>"></span>
                                <input class="pe-form-ele" id="version" type="radio" value="ENTERPRISE"
                                   <#if (corpInfo.version)! != ""&&(corpInfo.version)! == 'ENTERPRISE'>checked="checked"</#if> name="version"/>企业版
                            </label>
                        </div>
                        <div class="pe-radio-wrap-data" style="display:  <#if ((corpInfo.version)! != ""&&(corpInfo.version)! == 'ENTERPRISE')> inline-block <#else> none </#if>;margin-left: 20px;" id="selectTime">
                            <input id="startTime" data-suiindex="single" placeholder='开始时间' class="pe-table-form-text sui-date-picker pe-time-text pe-end-time laydate-icon" type="text" name="startTime" data-toggle="datepicker" data-date-timepicker="false" value="${(corpInfo.startTime?string("yyyy-MM-dd"))!}" readonly="readonly" style="width: 180px;">
                            &nbsp;~&nbsp;
                            <input id="endTime" data-suiindex="single" placeholder='截止时间' class="pe-table-form-text sui-date-picker pe-time-text pe-end-time laydate-icon" type="text" name="endTime" data-toggle="datepicker" data-date-timepicker="false" value="${(corpInfo.endTime?string("yyyy-MM-dd"))!}"  readonly="readonly" style="width: 180px;">
                            <span style="color:red;">不填则永久生效</span>
                        </div>
                    </div>
                </div>
            </div>
        <#--版本end-->

            <div class="pe-user-msg-detail">
                <label class=" pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>公司地址:</span>
                     </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num" value="${(corpInfo.address)!}"
                           type="text"
                           name="address" maxlength="200"/>
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class=" pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>所属行业:</span>
                    </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num" value="${(corpInfo.industry)!}"
                           type="text"
                           name="industry" maxlength="200"/>
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>联系人:</span>
                    </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num" value="${(corpInfo.contacts)!}"
                           type="text"
                           name="contacts" maxlength="50">
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>联系电话:</span>
                    </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num"
                           value="${(corpInfo.contactsMobile)!}" type="text"
                           name="contactsMobile" maxlength="20">
                </label>
            </div>
            <div class="pe-user-msg-detail">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>电子邮件:</span>
                    </span>
                    <input class="pe-stand-filter-form-input pe-question-score-num" value="${(corpInfo.email)!}"
                           type="text"
                           name="email" maxlength="20">
                </label>
            </div>
            <div class="pe-user-msg-detail" style="height: 100px;">
                <label class="pe-question-label">
                     <span class="pe-input-tree-text" style="width: 90px;">
                         <span>备注:</span>
                    </span>
                    <textarea name="comments" style="width: 330px;height: 100px;">${(corpInfo.comments)!}</textarea>
                </label>
            </div>
        </div>
        <div class="pe-btns-wrap" style="margin-top: 60px;margin-bottom: 94px;">
            <button class="pe-btn pe-btn-blue pe-btn-save" type="submit" style="margin-left:89px;">保存</button>
            <button class="pe-btn pe-btn-cancel" type="button">取消</button>
        </div>
    </form>
</section>
<script type="text/template" id="errMsgInfo">
    <span class="pe-form-validate-tip">
        <span class="iconfont icon-caution-tip"></span>
        <span><%=errMsg%></span>
    </span>
</script>
<script>
    $(function () {
        var corpId = '${(corpInfo.id)!}';
        /*选择企业版可以选择时间*/
        setTimeout(function() {
            $('#FREE_version').on('click',function(){
                $('#selectTime').css('display','none');
                $('#selectTime').find('input').attr('disabled','disabled');
            });
            $('#ENTERPRISE_version').on('click',function(){
                $('#selectTime').css('display','inline-block');
                $('#selectTime').find('input').removeAttr('disabled');
            });
        }, 0)

        $("#editItemForm").validate({
            errorElement: 'em',
            rules: {
                corpName: "required",
                corpCode: {
                    required: true,
                    remote: {
                        url: pageContext.rootPath + '/corp/manage/checkCorpCode?corpId=' + corpId,     //后台处理程序
                        type: "post",               //数据发送方式
                        dataType: "json"
                    }
                },
                domainName: {
                    required: true,
                    remote: {
                        url: pageContext.rootPath + '/corp/manage/checkDomainName?corpId=' + corpId,     //后台处理程序
                        type: "post",               //数据发送方式
                        dataType: "json"
                    }
                },
                concurrentNum: {
                    min: 0,
                    required: true
                },
                registerNum: {
                    min: 0,
                    required: true
                },
                email: {
                    email: true
                },
                contactsMobile: {
                    isMobile: true
                }
            },
            messages: {
                corpName: "企业名称不能为空",
                corpCode: {
                    required: "企业ID不能为空",
                    remote: "企业ID不能重复"
                },
                domainName: {
                    required: "域名不能为空",
                    remote: "域名不能重复"
                },
                concurrentNum: {
                    isMobile: "最大并发数不能小于0",
                    required: '最大并发数不能为空'
                },
                registerNum: {
                    isMobile: "最大注册数不能小于0",
                    required: '最大注册数不能为空'
                },
                email: {
                    email: "请输入正确的邮箱格式"
                },
                contactsMobile: {
                    isMobile: "请输入正确的手机格式"
                }
            },
            submitHandler: function (form) {
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/corp/manage/save',
                    data: $('#editItemForm').serializeArray(),
                    success: function (data) {
                        if (!data.success) {
                            PEMO.DIALOG.tips({
                                content: data.message,
                                time: 2000
                            });
                            return false;
                        }

                        PEMO.DIALOG.tips({
                            content: '保存成功',
                            time: 1000,
                            end: function () {
                               location.href = '#url='+pageContext.rootPath+'/corp/manage/initPage&nav=user';
                            }
                        });
                    }
                });
            }
        });

        $('.pe-btn-cancel').on('click',function(){
            location.href = '#url='+pageContext.rootPath+'/corp/manage/initPage&nav=user';
        });
    });


</script>