<#assign ctx=request.contextPath/>
<div class="pe-break-nav-tip-container">
    <ul class="pe-break-nav-ul">
        <li class="pe-brak-nav-items">系统</li>
        <li class="pe-brak-nav-items iconfont icon-bread-arrow">消息设置</li>
    </ul>
</div>
<div class="pe-message-wrap">
    <div class="pe-message-header floatL">
        <input type="hidden" name="id" value="${(systemSetting.id)!}"/>
        <input type="hidden" name="systemType" value="${(systemSetting.systemType)!}"/>
        <ul class="pe-message-menu">
            <li class="nav" data-type="user" data-url="USER">
                <img src="${resourcePath!}/web-static/proExam/images/user-setting.png">
                <p style="margin-top: 20px;">用户消息设置</p>
                <span class="arrow-up"></span>
            </li>
            <@authVerify authCode="VERSION_OF_EXAM_MESSAGE">
                <li data-type="EXAM" data-url="EXAM">
                    <img src="${resourcePath!}/web-static/proExam/images/exam-setting.png">
                    <p style="margin-top: 10px;">考试消息设置</p>
                </li>
            </@authVerify>
        <@authVerify authCode="VERSION_OF_EXAM_MESSAGE">
            <li data-type="APPMSG" data-url="APPMSG">
                <img src="${resourcePath!}/web-static/proExam/images/app-setting.png">
                <p style="margin-top: 10px;">APP端消息通知设置</p>
            </li>
        </@authVerify>
        </ul>
    </div>
    <div class="pe-message-container floatL">

    </div>
</div>

<script type="text/javascript">
    $(function () {
        var editExamSetting = {
            init: function () {
                var _this = this;
                _this.initData("USER");
                _this.bind();
            },
            bind: function () {
                $('.pe-message-container').delegate('.pe-system-app-save','click',function(){
                    var id = $("input[name='id']").val();
                   PEBASE.ajaxRequest({
                       url: pageContext.rootPath + '/systemSetting/manage/saveAppMessage?id='+id,
                       data:$('#AppMessageForm').serialize(),
                       success:function(data){
                           if (data.success) {
                               PEMO.DIALOG.tips({
                                   content: "保存成功",
                                   end: function () {
                                       editExamSetting.initData("APPMSG");
                                   }
                               });
                               return false;
                           }
                       }
                   });
                });
                $('.pe-message-container').delegate('.pe-system-exam-save', 'click', function () {
                    var id = $("input[name='id']").val();
                  /*  if(id==""||id==undefined){
                        if(!editExamSetting.checkParam("examMessageForm")){
                            return;
                        }
                    }*/
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/systemSetting/manage/saveExamMessage?systemType=EXAM&&id='+id,
                        data: $('#examMessageForm').serialize(),
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: "保存成功",
                                    end: function () {
                                        editExamSetting.initData("EXAM");
                                    }
                                });
                                return false;
                            }
                        }
                    });
                });
                $(".pe-message-container").delegate(".pe-system-user-save", "click", function () {
                    var id = $("input[name='id']").val();
                 /*   if(id==""||id==undefined){
                        if(!editExamSetting.checkParam("userMessageForm")){
                            return;
                        }
                    }*/

                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/systemSetting/manage/saveUserMessage?systemType=USER&&id='+id,
                        data: $('#userMessageForm').serialize(),
                        success: function (data) {
                            if (data.success) {
                                PEMO.DIALOG.tips({
                                    content: "保存成功",
                                    end: function () {
                                        editExamSetting.initData("USER");
                                    }
                                });
                                return false;
                            }
                        }
                    });
                });
                $('.pe-message-menu li').on('click', function () {
                    if ($(this).hasClass('nav')) {
                        return false;
                    }
                    $(this).addClass('nav').append('<span class="arrow-up"></span>').siblings('li').removeClass('nav').find('.arrow-up').remove();
                    var type = $(this).data('type'),
                        dataUrl=$(this).data('url');
                    if(dataUrl){
                        editExamSetting.initData(dataUrl);
                    }
                    $('.pe-message-header').css('height', ($('.pe-message-container').height() + 100) + 'px');
                    PEBASE.peFormEvent('checkbox');
                });
            },
          /*  checkParam:function(data){
                var checked = ":checked";
                var $formD = $("#"+data);
                if(!$formD.find("input").is(checked)){
                    PEMO.DIALOG.alert({
                        content: "<p style='font-size: 14px;'>请先选择选项</p>",
                        btn: ['我知道了'],
                        area: ['500px'],
                        yes: function () {
                            layer.closeAll();
                        },
                        success: function () {
                            $('.layui-layer .layui-layer-content').height('auto');
                            return false;
                        }
                    });
                }
                return true;
            },*/
            checkboxChecked: function (iconCheck, thisRealCheck) {
                if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                    iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                    thisRealCheck.prop('checked', true);//这里在ie8下目前会报错“意外的调用了方法”,待解决
                }
            },
            checkboxUnChecked: function (iconCheck, thisRealCheck) {
                if (iconCheck.hasClass('icon-checked-checkbox')) {
                    iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                    thisRealCheck.removeProp('checked');
                }
            },
            initMessageDate: function (data) {
                var thisFunReturn = '';
                var id = $("input[name='id']").val();
                if(!data) {
                    data="USER";
                }
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + "/systemSetting/manage/getSystemSetting",
                    data: {id: id, systemType: data},
                    async: false,
                    success: function (data) {
                        if (data.success) {
                            thisFunReturn = data.message;
                            return data.message;
                        }
                    }

                });
                return thisFunReturn;
            },
            initData: function (data) {
                var initMessage = this.initMessageDate(data);
                if(!initMessage||initMessage == undefined) {
                    if(data=="USER"){
                        $(".pe-message-container").html(_.template($("#userMessageTemplate").html())({data:null}));
                    }else if(data=="EXAM"){
                        $(".pe-message-container").html(_.template($("#examMessageTemplate").html())({data:null}));
                    }else if(data == "APPMSG"){
                        $(".pe-message-container").html(_.template($("#AppMessageTemplate").html())({data:null}));
                    }
                    $("input[name='id']").val("");
                }else{
                     var systemSetting = JSON.parse(initMessage);
                    $("input[name='id']").val(systemSetting.id);
                    if(!systemSetting.message){
                        if(data=="USER"){
                            $(".pe-message-container").html(_.template($("#userMessageTemplate").html())({data:null}));
                        }else if(data=="EXAM"){
                            $(".pe-message-container").html(_.template($("#examMessageTemplate").html())({data:null}));
                        }else if(data=="APPMSG"){
                            $(".pe-message-container").html(_.template($("#AppMessageTemplate").html())({data:systemSetting}));
                        }
                    }else{
                        var returnData = JSON.parse(systemSetting.message);
                        $("input[name='id']").val(systemSetting.id);
                        if(data=="USER"){
                            $(".pe-message-container").html(_.template($("#userMessageTemplate").html())({data:returnData}));
                        }else if(data == "EXAM"){
                            $(".pe-message-container").html(_.template($("#examMessageTemplate").html())({data:returnData}));
                        }else if(data=="APPMSG"){
                            $(".pe-message-container").html(_.template($("#AppMessageTemplate").html())({data:systemSetting}));
                        }
                    }

                }
                $('.pe-message-header').css('height', ($('.pe-message-container').height() + 100) + 'px');
                PEBASE.peFormEvent('checkbox');
            }
        };
        editExamSetting.init();
    });

</script>
<script type="text/template" id="userMessageTemplate">
    <div>
        <form id="userMessageForm">
        <#--新增用户消息通知-->
            <div class="pe-message-title">
                <div class="pe-message-title-label">新增/导入</div>
                <div class="pe-message-content-item">
                    <div class="floatL">
                         <span class="pe-checkbox">
                        <span class="iconfont <%if(data && data.adMsg && data.adMsg['M']){%>icon-checked-checkbox peChecked <%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true" <%if(data && data.adMsg && data.adMsg['M']){%>checked="checked"<%}%>
                               name="userSetting.adMsg['M']" id="adMsg_M"/>
                        站内信
                    </span>
                        <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont <%if( data && data.adMsg&& data.adMsg['S']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if( data && data.adMsg&& data.adMsg['S']){%>checked="checked"<%}%>
                               name="userSetting.adMsg['S']" id="adMsg_S"/>
                        电子邮件
                    </span>
                        <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont <%if( data && data.adMsg&& data.adMsg['E']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if(data && data.adMsg&& data.adMsg['E']){%>checked="checked"<%}%>
                               name="userSetting.adMsg['E']" id="adMsg_E"/>
                        手机短信
                    </span>
                        <span class="pe-message-tip">*账户开通后，将以系统消息的形式发送消息</span>
                    </div>
                </div>
            </div>

            <div class="pe-message-title">
                <div class="pe-message-title-label">冻结</div>
                <div class="pe-message-content-item">
                    <span class="pe-checkbox">
                        <span class="iconfont <%if(data && data.frMsg&& data.frMsg['M']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if(data && data.frMsg&& data.frMsg['M']){%>checked="checked"<%}%>
                               name="userSetting.frMsg['M']" id="frMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont <%if(data && data.frMsg&& data.frMsg['S']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if(data && data.frMsg&& data.frMsg['S']){%>checked="checked"<%}%>
                               name="userSetting.frMsg['S']" id="frMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont <%if(data && data.frMsg&& data.frMsg['E']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if(data && data.frMsg&& data.frMsg['E']){%>checked="checked"<%}%>
                               name="userSetting.frMsg['E']" id="frMsg_E"/>
                        手机短信
                    </span>
                    <span class="pe-message-tip">*账户冻结，将以系统消息的形式发送消息</span>
                </div>
            </div>

            <div class="pe-message-title">
                <div class="pe-message-title-label">激活</div>
                <div class="pe-message-content-item">
                    <span class="pe-checkbox">
                        <span class="iconfont <%if( data && data.acMsg&& data.acMsg['M']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if( data && data.acMsg&& data.acMsg['M']){%>checked="checked" <%}%>
                               name="userSetting.acMsg['M']" id="acMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont <%if( data && data.acMsg&& data.acMsg['S']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if( data && data.acMsg&& data.acMsg['S']){%>checked="checked" <%}%>
                               name="userSetting.acMsg['S']" id="acMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont <%if( data && data.acMsg&& data.acMsg['E']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if( data && data.acMsg&& data.acMsg['E']){%>checked="checked" <%}%>
                               name="userSetting.acMsg['E']" id="acMsg_E"/>
                        手机短信
                    </span>
                    <span class="pe-message-tip">*账户激活后，将以系统消息的形式发送消息</span>
                </div>
            </div>

            <div class="pe-message-title">
                <div class="pe-message-title-label">部门调动</div>
                <div class="pe-message-content-item">
                    <span class="pe-checkbox">
                        <span class="iconfont <%if(data && data.trMsg && data.trMsg['M']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if(data && data.trMsg && data.trMsg['M']){%>checked="checked"<%}%>
                               name="userSetting.trMsg['M']" id="trMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont <%if(data && data.trMsg && data.trMsg['S']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if(data && data.trMsg && data.trMsg['S']){%>checked="checked"<%}%>
                               name="userSetting.trMsg['S']" id="trMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont <%if(data && data.trMsg && data.trMsg['E']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if(data && data.trMsg && data.trMsg['E']){%>checked="checked"<%}%>
                               name="userSetting.trMsg['E']" id="trMsg_E"/>
                        手机短信
                    </span>
                    <span class="pe-message-tip" style="font-size: 13px;font-family: sans-serif;margin-left: 50px;">*被调动部门后，将以系统消息的形式发送消息</span>
                </div>
            </div>
            <div class="pe-message-title">
                <div class="pe-message-title-label">重置密码</div>
                <div class="pe-message-content-item">
                    <span class="pe-checkbox">
                        <span class="iconfont <%if(data && data.rsMsg && data.rsMsg['M']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                        <%if(data && data.rsMsg && data.rsMsg['M']){%> checked="checked" <%}%>
                               name="userSetting.rsMsg['M']" id="rsMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont  <%if(data && data.rsMsg && data.rsMsg['S']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                       <%if(data && data.rsMsg && data.rsMsg['S']){%> checked="checked" <%}%>
                               name="userSetting.rsMsg['S']" id="rsMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont <%if(data && data.rsMsg&& data.rsMsg['E']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                     <%if(data && data.rsMsg && data.rsMsg['E']){%> checked="checked" <%}%>
                               name="userSetting.rsMsg['E']" id="rsMsg_E"/>
                        手机短信
                    </span>
                    <span class="pe-message-tip">*重置密码后，将以系统消息的形式发送消息</span>
                </div>
            </div>
            <div class="view-exam-group-one">
                <button type="button" class="pe-btn pe-btn-blue pe-step-save-draft pe-system-user-save">保存
                </button>
            </div>
        </form>
    </div>
</script>
<script type="text/template" id="examMessageTemplate">
    <div>
        <form id="examMessageForm">
            <div class="pe-message-title">
                <div class="pe-message-title-label">考试通知</div>
                <div class="pe-message-content-item">
                    <span class="pe-checkbox">
                        <span class="iconfont  <%if(data && data.eMsg && data.eMsg['M']){%>icon-checked-checkbox peChecked <%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if(data && data.eMsg && data.eMsg['M']){%>checked="checked"<%}%>
                               name="examSetting.eMsg['M']" id="eMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont  <%if(data && data.eMsg && data.eMsg['S']){%>icon-checked-checkbox peChecked <%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                                <%if(data && data.eMsg && data.eMsg['S']){%>checked="checked"<%}%>
                               name="examSetting.eMsg['S']" id="eMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont  <%if(data && data.eMsg && data.eMsg['E']){%>icon-checked-checkbox peChecked <%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                                <%if(data && data.eMsg && data.eMsg['E']){%>checked="checked"<%}%>
                               name="examSetting.eMsg['E']" id="eMsg_E"/>
                        手机短信
                    </span>
                    <span class="pe-message-tip">*发布考试时，将以系统消息的形式通知需要参加考试的人员</span>
                </div>
            </div>

            <div class="pe-message-title">
                <div class="pe-message-title-label">考试作废通知</div>
                <div class="pe-message-content-item">
                    <span class="pe-checkbox">
                        <span class="iconfont <%if(data && data.caMsg && data.caMsg['M']){%>icon-checked-checkbox peChecked <%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if(data && data.caMsg && data.caMsg['M']){%>checked="checked"<%}%>
                               name="examSetting.caMsg['M']" id="caMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont <%if(data && data.caMsg && data.caMsg['S']){%>icon-checked-checkbox peChecked <%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if(data && data.caMsg && data.caMsg['S']){%>checked="checked"<%}%>
                               name="examSetting.caMsg['S']" id="caMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont <%if(data && data.caMsg && data.caMsg['E']){%>icon-checked-checkbox peChecked <%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if(data && data.caMsg && data.caMsg['E']){%>checked="checked"<%}%>
                               name="examSetting.caMsg['E']" id="caMsg_E"/>
                        手机短信
                    </span>
                    <span class="pe-message-tip">*作废考试时，将以系统消息的形式通知原来需要参加考试的人员</span>
                </div>
            </div>

            <div class="pe-message-title">
                <div class="pe-message-title-label">考试移除人员通知</div>
                <div class="pe-message-content-item">
                    <span class="pe-checkbox">
                        <span class="iconfont <%if(data && data.reMsg && data.reMsg['M']){%>icon-checked-checkbox peChecked <%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                                <%if(data && data.reMsg && data.reMsg['M']){%>checked="checked"<%}%>
                               name="examSetting.reMsg['M']" id="reMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont <%if(data && data.reMsg && data.reMsg['S']){%>icon-checked-checkbox peChecked <%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if(data && data.reMsg && data.reMsg['S']){%>checked="checked"<%}%>
                               name="examSetting.reMsg['S']" id="reMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont <%if(data && data.reMsg && data.reMsg['E']){%>icon-checked-checkbox peChecked <%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                                <%if(data && data.reMsg && data.reMsg['E']){%>checked="checked"<%}%>
                               name="examSetting.reMsg['E']" id="reMsg_E"/>
                        手机短信
                    </span>
                    <span class="pe-message-tip">*移除参考人员时，将以系统消息的形式通知被移除人员</span>
                </div>
            </div>

            <div class="pe-message-title" hidden="hidden">
                <div class="pe-message-title-label">违纪通知</div>
                <div class="pe-message-content-item">
                    <span class="pe-checkbox">
                        <span class="iconfont <%if(data && data.bpMsg && data.bpMsg['M']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if(data && data.bpMsg && data.bpMsg['M']){%>checked="checked"<%}%>
                               name="examSetting.bpMsg['M']" id="bpMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont <%if(data && data.bpMsg && data.bpMsg['S']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if(data && data.bpMsg && data.bpMsg['S']){%>checked="checked"<%}%>
                               name="examSetting.bpMsg['S']" id="bpMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont <%if(data && data.bpMsg && data.bpMsg['E']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                               <%if(data && data.bpMsg && data.bpMsg['E']){%>checked="checked"<%}%>
                               name="examSetting.bpMsg['E']" id="bpMsg_E"/>
                        手机短信
                    </span>
                    <span class="pe-message-tip">*管理人员发现违纪人员时，，将以系统消息的形式通知违纪人员</span>
                </div>
            </div>
            <div class="pe-message-title" hidden="hidden">
                <div class="pe-message-title-label">强制交卷通知</div>
                <div class="pe-message-content-item">
                    <span class="pe-checkbox">
                        <span class="iconfont <%if(data && data.fsMsg && data.fsMsg['M']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                       <%if(data && data.fsMsg && data.fsMsg['M']){%>checked="checked"<%}%>
                               name="examSetting.fsMsg['M']" id="fsMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont  <%if(data && data.fsMsg && data.fsMsg['S']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                       <%if(data && data.fsMsg && data.fsMsg['S']){%>checked="checked"<%}%>
                               name="examSetting.fsMsg['S']" id="fsMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont  <%if(data && data.fsMsg && data.fsMsg['E']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                        <%if(data && data.fsMsg && data.fsMsg['E']){%>checked="checked"<%}%>
                               name="examSetting.fsMsg['E']" id="fsMsg_E"/>
                        手机短信
                    </span>
                    <span class="pe-message-tip">*管理员要求强制交卷时，将以系统消息的形式通知正在参加考试的人员</span>
                </div>
            </div>
            <div class="pe-message-title">
                <div class="pe-message-title-label">考试提醒</div>
                <div class="pe-message-content-item">
                    <span class="pe-checkbox">
                        <span class="iconfont <%if(data && data.rmMsg && data.rmMsg['M']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                        <%if(data && data.rmMsg && data.rmMsg['M']){%>checked="checked"<%}%>
                               name="examSetting.rmMsg['M']" id="rmMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont  <%if(data && data.rmMsg && data.rmMsg['S']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                        <%if(data && data.rmMsg && data.rmMsg['S']){%>checked="checked"<%}%>
                               name="examSetting.rmMsg['S']" id="rmMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont  <%if(data && data.rmMsg && data.rmMsg['E']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                         <%if(data && data.rmMsg && data.rmMsg['E']){%>checked="checked"<%}%>
                               name="examSetting.rmMsg['E']" id="rmMsg_E"/>
                        手机短信
                    </span>
                    <span class="pe-message-tip">*管理跟踪考试现场时，将以系统消息的形式通知未参加考试的人员</span>
                </div>
            </div>
            <div class="pe-message-title">
                <div class="pe-message-title-label">考试结束时间变更</div>
                <div class="pe-message-content-item">
                    <span class="pe-checkbox">
                        <span class="iconfont <%if(data && data.eeMsg && data.eeMsg['M']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                       <%if(data && data.eeMsg && data.eeMsg['M']){%>checked="checked"<%}%>
                               name="examSetting.eeMsg['M']" id="eeMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont  <%if(data && data.eeMsg && data.eeMsg['S']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                        <%if(data && data.eeMsg && data.eeMsg['S']){%>checked="checked"<%}%>
                               name="examSetting.eeMsg['S']" id="eeMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont  <%if(data && data.eeMsg && data.eeMsg['E']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                       <%if(data && data.eeMsg && data.eeMsg['E']){%>checked="checked"<%}%>
                               name="examSetting.eeMsg['E']" id="eeMsg_E"/>
                        手机短信
                    </span>
                    <span class="pe-message-tip">*考试结束时间变更时，将以系统消息的形式通知所有参考人员</span>
                </div>
            </div>
            <div class="pe-message-title">
                <div class="pe-message-title-label">发布成绩</div>
                <div class="pe-message-content-item">
                    <span class="pe-checkbox">
                        <span class="iconfont <%if(data && data.pmMsg && data.pmMsg['M']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                        <%if(data && data.pmMsg && data.pmMsg['M']){%>checked="checked"<%}%>
                               name="examSetting.pmMsg['M']" id="pmMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont  <%if(data && data.pmMsg && data.pmMsg['S']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                        <%if(data && data.pmMsg && data.pmMsg['S']){%>checked="checked"<%}%>
                               name="examSetting.pmMsg['S']" id="pmMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont  <%if(data && data.pmMsg && data.pmMsg['E']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                        <%if(data && data.pmMsg && data.pmMsg['E']){%>checked="checked"<%}%>
                               name="examSetting.pmMsg['E']" id="pmMsg_E"/>
                        手机短信
                    </span>
                    <span class="pe-message-tip">*系统自动或者管理员手动发布成绩时，将以系统消息的形式通知人员考试结果</span>
                </div>
            </div>
            <div class="pe-message-title">
                <div class="pe-message-title-label">补考通知</div>
                <div class="pe-message-content-item">
                    <span class="pe-checkbox">
                        <span class="iconfont <%if(data && data.muMsg && data.muMsg['M']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                        <%if(data && data.muMsg && data.muMsg['M']){%>checked="checked"<%}%>
                               name="examSetting.muMsg['M']" id="muMsg_M"/>
                        站内信
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont  <%if(data && data.muMsg && data.muMsg['S']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                        <%if(data && data.muMsg && data.muMsg['S']){%>checked="checked"<%}%>
                               name="examSetting.muMsg['S']" id="muMsg_S"/>
                        电子邮件
                    </span>
                    <span class="pe-checkbox" style="margin-left: 30px;">
                        <span class="iconfont  <%if(data && data.muMsg && data.muMsg['E']){%>icon-checked-checkbox peChecked<%}else{%>icon-unchecked-checkbox<%}%>"></span>
                        <input class="pe-form-ele" type="checkbox" value="true"
                        <%if(data && data.muMsg && data.muMsg['E']){%>checked="checked"<%}%>
                               name="examSetting.muMsg['E']" id="muMsg_E"/>
                        手机短信
                    </span>
                    <span class="pe-message-tip">*补考下发时，将以系统消息的形式通知需要参加补考的人员</span>
                </div>
            </div>
            <div class="view-exam-group-one">
                <button type="button" class="pe-btn pe-btn-blue pe-step-save-draft pe-system-exam-save">保存
                </button>
            </div>
        </form>
    </div>
</script>
<script type="text/template" id="AppMessageTemplate">
    <div>
        <form action="javascript:;" id="AppMessageForm">
            <div class="view-App-group-title">
                 <span class="pe-checkbox">
                    <%if (data && data.openAppMsg){%>
                    <span class="iconfont icon-checked-checkbox peChecked "></span>
                    <input class="pe-form-ele" type="checkbox" value="true" checked="checked" name="openAppMsg" id="openAppMsg">开启App端推送
                     <%}else{%>
                     <span class="iconfont icon-unchecked-checkbox"></span>
                    <input class="pe-form-ele" type="checkbox" value="true" name="openAppMsg" id="openAppMsg">开启App端推送
                     <%}%>
                 </span>
            </div>
            <div class="view-App-group">
                <div class="view-App-item-tips">考试通知</div>
                <div class="view-App-item-content">*发布考试时，将会推送通知给该场考试的考生</div>
            </div>
            <div class="view-App-group">
                <div class="view-App-item-tips">考前通知</div>
                <div class="view-App-item-content">*考前半小时，将会推送通知给该场考试的考生</div>
            </div>
            <div class="view-App-group">
                <div class="view-App-item-tips">发布成绩</div>
                <div class="view-App-item-content">*发布成绩时，将会推送通知给该场考试的考生</div>
            </div>
            <div class="view-App-group">
                <div class="view-App-item-tips">补考通知</div>
                <div class="view-App-item-content">*发布补考时，推送通知给需要参加补考的人员</div>
            </div>
            <div class="view-App-group_footer">
                <button type="button" class="pe-btn pe-btn-blue pe-step-save-draft pe-system-app-save">保存
                </button>
            </div>
        </form>
    </div>
</script>