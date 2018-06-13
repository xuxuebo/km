<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<div class="pe-public-top-nav-header  view-member-detail-all-wrap">
    <h3 class="paper-add-accredit-title">人员详情</h3>
</div>
<div class="user-view-detail-wrap">
    <div class="pe-manage-default">
        <div class="detail-panel-left floatL">
            <div class="user-detail-head-pic">
                <img onerror="javascript:this.src='${resourcePath!}/web-static/proExam/images/default/default_face.png'" src="${(user.facePath)!'/pe/web-static/proExam/images/default/default_face.png'}" width=100%
                     height=100% alt="头像">
            </div>
        </div>
        <div class="detail-panel-right">
            <h2 class="detail-panel-top-name">${(user.userName)!'暂未设置'}</h2>
            <div class="detail-panel-base">
                <dl class="over-flow-hide user-detail-msg-wrap" style="overflow:hidden;">
                    <dt class="floatL user-detail-title">用户名:</dt>
                    <dd class="user-detail-value">${(user.loginName)!'暂未设置'}</dd>
                </dl>
                <dl style="overflow:hidden;">
                    <dt class="floatL user-detail-title">工&emsp;号:</dt>
                    <dd class="user-detail-value">${(user.employeeCode)!'暂未设置'}</dd>
                </dl>
                <dl style="overflow:hidden;">
                    <dt class="floatL user-detail-title">手机号:</dt>
                    <dd class="user-detail-value">${(user.mobile)!'暂未设置'}</dd>
                </dl>
            </div>
        </div>
        <div class="pe-question-top-head pe-question-more-wrap">
            <h2 class="pe-question-head-text"> 更多信息</h2>
            <span class="pe-add-question-more-msg">
               <span class="iconfont icon-pack"></span>
            </span>
        </div>
        <div class="user-detail-more-panel" style="margin-top:10px;display:none;">
            <dl class="over-flow-hide user-detail-msg-wrap" style="overflow:hidden;">
                <dt class="floatL user-detail-title">性&emsp;别:</dt>
                <#if user.sexType?? && user.sexType=='SECRECY'>
                    <dd class="user-detail-value">保密</dd>
                <#elseif user.sexType?? && user.sexType=='MALE'>
                    <dd class="user-detail-value">男</dd>
                <#elseif user.sexType?? && user.sexType=='FEMALE'>
                    <dd class="user-detail-value">女</dd>
                <#else>
                    <dd class="user-detail-value">暂未设置</dd>
                </#if>
            </dl>
            <dl style="overflow:hidden;">
                <dt class="floatL user-detail-title" style="margin-bottom:28px;">身份证:</dt>
                <dd class="user-detail-value" style="margin-bottom:28px;">${(user.idCard)!'暂未设置'}</dd>
            </dl>
            <dl style="overflow:hidden;">
                <dt class="floatL user-detail-title">部&emsp;门:</dt>
                <dd class="user-detail-value">${(user.organize.organizeName)!'暂未设置'}</dd>
            </dl>
            <dl style="overflow:hidden;">
                <dt class="floatL user-detail-title">岗&emsp;位:</dt>
                <dd class="user-detail-value">${(user.positionName)!'暂未设置'}</dd>
            </dl>
            <dl style="overflow:hidden;">
                <dt class="floatL user-detail-title">角&emsp;色:</dt>
                <#if user.roles??&&(user.roles?size>0)>
                    <dd class="user-detail-value"
                        style="margin-bottom:28px;"><#list user.roles as user><#if user_index!=0>、</#if>${(user.roleName)!}</#list></dd>
                <#else>
                    <dd class="user-detail-value" style="margin-bottom:28px;">暂未设置</dd>
                </#if>
            </dl>
            <dl style="overflow:hidden;">
                <dt class="floatL user-detail-title">邮&emsp;箱:</dt>
                <dd class="user-detail-value">${(user.email)!'暂未设置'}</dd>
            </dl>
            <dl style="overflow:hidden;">
                <dt class="floatL user-detail-title">地&emsp;址:</dt>
                <dd class="user-detail-value">${(user.address)!'暂未设置'}</dd>
            </dl>
        </div>
        <button type="button" class="pe-btn pe-btn-blue pe-large-btn user-view-detail-btn">关闭</button>
    </div>
</div>
<script type="text/javascript">
    $('.user-view-detail-btn').on('click', function () {
        window.close();
    });

    //点击更多信息按钮点击事件
    $('.pe-add-question-more-msg').click(function () {
        if ($(this).find('.iconfont').hasClass('icon-pack')) {
            $('.user-detail-more-panel').slideDown();
            $(this).find('.iconfont').removeClass('icon-pack').addClass('icon-show');
            $('.pe-question-top-head').css('border-bottom', '2px solid #e0e0e0');
        } else if ($(this).find('.iconfont').hasClass('icon-show')) {
            $('.user-detail-more-panel').slideUp();
            $(this).find('.iconfont').removeClass('icon-show').addClass('icon-pack');
            $('.pe-question-top-head').css('border-bottom', '0px');
        }

    });


    /*高度管理*/
    var _thisShouldHeight = $(window).height() - 64-60;
    $('.user-view-detail-wrap').css('minHeight',_thisShouldHeight);
</script>
</@p.pageFrame>