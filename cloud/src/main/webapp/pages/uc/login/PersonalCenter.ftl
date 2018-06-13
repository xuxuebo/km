<#assign ctx=request.contextPath/>
<div class=" user-main-right-panel" style="padding-left: 0;width:auto;">
    <div>
        <div class="">
            <form class="pe-center-form" name="personnalForm">
                <div style="margin-left: 0;">
                    <div class="pe-personal-wrap">
                        <div class="pe-center-right-wrap">
                            <div class="pe-center-right-nav">
                                <div class="pe-center-right-top">
                                    <input type="hidden" name="faceFileId" class="target-fileId"/>
                                    <input type="hidden" name="faceFileName" class="target-fileName"/>
                                    <button type="button" class="pe-user-head-edit-btn">
                                        <img class="userHeaderImg" onerror="javascript:this.src='${resourcePath!}/web-static/proExam/images/default/default_face.png'"
                                             src="${(user.facePath)!'/pe/web-static/proExam/images/default/default_face.png'}" />
                                        <span>编辑头像</span>
                                    </button>
                                </div>
                                <div class="pe-center-nav-content">
                                    <p class="pe-center-nav-name">${user.userName!}<a href="javascript:;" class="reset-pass-word"><i class="iconfont">&#xe73b;</i><i>修改密码</i></a></p>
                                    <ul class="clearF pe-center-nav-list">
                                        <li class="floatL clearF"><a href="javascript:;">共参加<span class="text-blue pe-center-num">${(exam.examCount)!0}</span>场</a></li>
                                        <li class="pe-center-item-con floatL clearF"><a href="javascript:;">通过<span class="text-green pe-center-num">${(exam.passCount)!0}</span>场</a></li>
                                        <li class="pe-center-item-con floatL clearF"><a href="javascript:;">未通过<span class="text-red pe-center-num">${(exam.noPassCount)!0}</span>场</a></li>
                                        <li class="pe-center-item-con floatL clearF"><a href="javascript:;">缺考<span class="text-gray pe-center-num">${(exam.missCount)!0}</span>场</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="pe-center-content-wrap" style="padding-top:17px;">
                                <div class="pe-center-content-inf">
                                    <h2 class="pe-question-head-text">基本信息</h2>
                                    <div class="pe-center-inf-con">
                                        <dl>
                                            <dt>用&nbsp;&nbsp;户&nbsp;&nbsp;名：</dt>
                                            <dd>${(user.loginName)!'暂无'}</dd>
                                        </dl>
                                        <dl>
                                            <dt>工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</dt>
                                            <dd>${(user.employeeCode)!'暂无'}</dd>
                                        </dl>
                                        <dl class="pe-center-inf-item bind-change-mobile">
                                            <dt>手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</dt>
                                            <#if user.mobile??>
                                                <dd class="mobile-val">${(user.mobile)!} <a class="pe-center-change change-mobile" data-name="更换手机" >更换</a></dd>
                                            <#else>
                                            <dd class="mobile-val"><a href="javascript:;" class="pe-mobile" data-name="绑定手机" >立即绑定</a><span class="pe-center-bound">*绑定验证的手机号（和邮箱）可用于登录平台、找回密码和接收消息</span></dd>
                                            </#if>
                                        </dl>
                                        <dl>
                                            <dt>邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：</dt>
                                        <#if user.email??>
                                            <dd class="email-val">${(user.email)!'暂无'} <a class="pe-center-change change-email" data-name="更换邮箱">更换</a></dd>
                                        <#else>
                                            <dd><a href="javascript:" class="pe-email" data-name="绑定邮箱">立即绑定</a><span class="pe-center-bound">*绑定验证的手机号（和邮箱）可用于登录平台、找回密码和接收消息</span></dd>
                                        </#if>
                                            <a href=""></a>
                                        </dl>
                                        <dl class="pe-center-inf-item">
                                            <dt>部&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门：</dt>
                                            <dd>${(user.organize.organizeName)!'暂无'}</dd>
                                        </dl>
                                        <dl>
                                            <dt>岗&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：</dt>
                                            <dd><#if user.positions?? && (user.positions?size>0)><#list user.positions as position>${(position.positionName)!'暂无'}&nbsp;&nbsp;&nbsp;</#list><#else>暂无</#if></dd>
                                        </dl>
                                        <dl class="pe-center-inf-item">
                                            <dt>入职日期：</dt>
                                            <dd>${(user.entryTime?string('yyyy-MM-dd'))!'暂无'}</dd>
                                        </dl>
                                        <dl>
                                            <dt>身份证号：</dt>
                                            <dd>${(user.idCard)!'暂无'}</dd>
                                        </dl>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script type="text/template" id="resetPassword">
    <form id="resetPasswordForm" style="width: 350px;">
        <div class="clearF">
            <div class="validate-form-cell" style="margin-left:68px;">
                <em class="error" style="display: none;width: 350px " ></em>
            </div>
            <label class="floatL">
                <span class="pe-label-name floatL"><span style="color: red;">*</span>原始密码:</span>
                <input class="pe-stand-filter-form-input " autocomplete="off" type="password" style="width: 250px;"
                       name="oldPassword" maxlength="50">
            </label>
            <div class="pe-main-km-text-wrap clearF">
                <span class="pe-label-name floatL" ><span style="color: red;">&emsp;*</span>新密码:</span>
                <input class="pe-stand-filter-form-input"  type="password" autocomplete="off" name="newPassword"
                           placeholder="6-20位字符.包括字母数字.区分大小写" style="width: 250px;">
            </div>
            <div class="pe-main-km-text-wrap clearF">
                <span class="pe-label-name floatL "><span style="color: red;">*</span>确认密码:</span>
                <input class="pe-stand-filter-form-input"  type="password" autocomplete="off" name="confirmPassword"
                       placeholder="6-20位字符.包括字母数字.区分大小写" style="width: 250px;"/>
            </div>
        </div>
    </form>
</script>
<script type="text/template" id="bindEmail">
    <form id="bindEmailForm" class="pe-center-form-wrap" style="padding: 0;">
        <div class="clearF">
            <div class="validate-form-cell" style="margin-left:68px;">
                <em class="error" style="display: none; width:  360px" ></em>
            </div>
            <label class="floatL">
                <span class="pe-label-name floatL" style="padding-left: 29px;"><span style="color: red;">*</span>邮箱:</span>
                <input class="pe-stand-filter-form-input" style="width: 280px;font-size: 12px;" autocomplete="off" type="text"
                       name="email" maxlength="50" placeholder="请填写邮箱">
            </label>
            <div class="pe-main-km-text-wrap clearF">
                <span class="pe-label-name floatL "><span style="color: red;">*</span>当前密码:</span>
                <input class="pe-stand-filter-form-input"  onfocus="this.type='password'" type="text" autocomplete="off" name="password"
                       placeholder="为了保障账号安全，您需要输入当前登录账号的密码" style="width: 280px;font-size: 12px;">
            </div>
        </div>
    </form>
</script>
<script type="text/template" id="bindMobile">
    <form id="bindMobileForm" class="pe-center-form-wrap" style="padding: 0;">
        <div class="clearF">
            <div class="validate-form-cell">
                <em class="error" style="display: none; width:  360px" ></em>
            </div>
            <label class="floatL">
                <span class="pe-label-name floatL" style="padding-left: 15px;"><span style="color: red;">*</span>手&nbsp;机&nbsp;号:</span>
                <input class="pe-stand-filter-form-input" autocomplete="off" type="text" style="width: 174px;"
                       name="mobile" maxlength="50">
                <button type="button" class="pe-identity-get-btn pe-online-btn" disabled="true">获取验证码</button>
            </label>
            <div class="pe-main-km-text-wrap clearF">
                <span class="pe-label-name floatL" style="padding-left: 15px;"><span style="color: red;">*</span>验&nbsp;证&nbsp;码:</span>
                <input class="pe-stand-filter-form-input" style="width: 282px;"  type="text" autocomplete="off" name="verifyCode">
            </div>
            <div class="pe-main-km-text-wrap clearF">
                <span class="pe-label-name floatL" style="margin-left: 10px;"><span style="color: red;">*</span>当前密码:</span>
                <input class="pe-stand-filter-form-input"  onfocus="this.type='password'" type="text" autocomplete="off" name="password"
                       placeholder="为了保障账号安全，您需要输入当前登录账号的密码" style="width: 282px;font-size: 12px;">
            </div>
        </div>
    </form>
</script>
<script>

   $(function(){
       userControl.perCenter.init('${(user.id)!}');
   })
</script>
