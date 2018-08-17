<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zn-CH">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>${(titleName)!'智慧云'}登录</title>
    <link rel="shortcut icon" href="${(resourcePath+icoUrl)!'${resourcePath!}/web-static/proExam/images/pe_ico_32.ico'}" type="image/x-icon"/>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/user.css?_v=${(resourceVersion)!}" type="text/css">
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/base64.js?_v=${(resourceVersion)!}"></script>
    <script>
        pageContext = {
            resourcePath:'${resourcePath!}',
            rootPath:'${ctx!}'
        };
    </script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/environment_check.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript">
        var ieBrowserReg = /IE_\d/ig;
        var firBrowserReg = /FIREFOX_\d/ig;
        var chromeBrowserReg = /CHROME_\d/ig;
        if(EnCheck.browserName && EnCheck.browserNum){
            /*IE8*/
            if(ieBrowserReg.test(EnCheck.browserName)){
                 if(EnCheck.browserNum < 9){
                      location.href = '${ctx!}/login/initBrowseLower';
                 }
            }else if(firBrowserReg.test(EnCheck.browserName)){
                if(EnCheck.browserNum < 30){
                    location.href = '${ctx!}/login/initBrowseLower';
                }
            }else if(chromeBrowserReg.test(EnCheck.browserName)){
                if(EnCheck.browserNum < 35){
                    location.href = '${ctx!}/login/initBrowseLower';
                }
            }

        }
    </script>
</head>
<body>
<div class="pe-login-wrapper">
    <div class="pe-login-top-nav-header">
        <div class="pe-logo">
            <img src="${(resourcePath+loginLogoUrl)!'${resourcePath!}/web-static/proExam/index/img/ico_user_logo.png'}" class="floatL" width="100%" alt="LOGO">
        </div>
    </div>

    <div id="pre-login-content">
        <div class="pre-login-content-layout pe-login-bg">
            <div class="pre-login-box-warp">
                <div class="pre-login-box">
                    <div class="pre-login-static-form">
                        <div class="pre-login-title">登录</div>
                        <form id="loginForm">
                            <div class="pe-test-error text-red">
                                <span class="iconfont icon-caution-tip floatL" style="color:#fff;display:none;"></span>
                                <div class="error-text" style="height:26px;line-height:26px;"></div>
                            </div>
                            <input name="forceLogin" type="hidden" value="true"/>
                            <div class="pre-login-field">
                                <label for=""><i class="iconfont icon-dengluyonghu"></i></label>
                                <input data-id="0" type="text" name="loginName" data-val="${(user.loginName)!}" onpropertychange="removeLoginBtnClass(this.value)" oninput="removeLoginBtnClass(this.value)" max-length="50"
                                       class="pre-login-text" value="${(user.loginName)!}"
                                       placeholder="用户名/手机号/邮箱">
                            </div>
                            <div class="pre-login-field">
                                <label id="password-label" for=""><i class="iconfont icon-denglumima"></i></label>
                                <input data-id="1" type="text" onfocus="this.type='password'" onpropertychange="removeLoginBtnClass(this.value)" oninput="removeLoginBtnClass(this.value)" name="password"
                                       class="pre-login-text password-input" value="${(user.password)!}" max-length="50"
                                       placeholder="密码">
                            </div>
                            <div class="pre-login-links">
                                <a href="${ctx!}/login/forgetPwdPage" class="pre-login-register"
                                   target="_blank">忘记密码</a>
                            </div>

                            <div class="pre-login-submit">
                                <button type="button" class="J_Submit no-login">登录</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="pe-login-foot">${(footExplain)!'Copyright &copy${.now?string("yyyy")} 国家电网江苏省电力公司 ©苏ICP备15007035号-1 '}</div>
</div>
<script>

    window.onload = function () {
        var val = $('input[name="loginName"]').val() || $('input[name="password"]').val();
        if (val && (val != '用户名/手机号/邮箱' && val != '密码')) {
            $('.J_Submit').removeClass('no-login');
        }
    };

    function removeLoginBtnClass(thisVal) {
        var val = thisVal;
        if (val && (val != '用户名/手机号/邮箱' && val != '密码')) {
            $('.J_Submit').removeClass('no-login');
            $('.pe-test-error').removeClass('error-bg');
            $('.pe-test-error').find('.error-text').text('')
        } else {
            $('.J_Submit').addClass('no-login');
        }
    }
    $(function () {

        if($('.pre-login-links').find('.icon-checked-checkbox').get(0)){
            $('.password-input').attr('type','password');
        }
        $('.password-input').blur(function(){
            if(!$.trim($(this).val())){
                $(this).attr('type','text');
            }
        });
        //ie9不支持Placeholder问题
        if (!placeholderSupport()) {   // 判断浏览器是否支持 placeholder
            $('[placeholder]').focus(function () {
                var input = $(this);
                if (input.val() == input.attr('placeholder')) {
                    input.val('');
                    input.removeClass('placeholder');
                }
            }).blur(function () {
                var input = $(this);
                if (input.val() == '' || input.val() == input.attr('placeholder')) {
                    input.addClass('placeholder');
                    input.val(input.attr('placeholder'));
                }
            }).blur();
        }

        function placeholderSupport() {
            return 'placeholder' in document.createElement('input');
        }
        var $errorDiv = $('.pe-test-error');
        $(document).keyup(function (e) {
            var e = e || window.event;
            if (e.keyCode === 13) {//keyCode=13是回车键
                $('.J_Submit').trigger('click');
            }
            var ua = navigator.userAgent.toLowerCase();
            if(ua.indexOf('msie 9.0') !== -1){
                //处理ie9下，oninput事件对删除键，剪切等按键不触发的问题
                if(e.keyCode === 8){
                    removeLoginBtnClass();
                }
                if(e.ctrlKey && e.keyCode === 88){
                    removeLoginBtnClass();
                }
            }

        });

        $('.J_Submit').on('click', function (e) {
            if ($(this).hasClass('no-login')) {
                return false;
            }
            $errorDiv.find('.error-text').text('');
            var loginName = $('input[name="loginName"]').val();
            if (!loginName) {
                $('input[name="loginName"]').focus();
                $errorDiv.find('.error-text').text('用户名不能为空');
                $errorDiv.addClass('error-bg');
                return false;
            }

            var password = $('input[name="password"]').val();
            if (!password) {
                $('input[name="password"]').focus();
                $errorDiv.find('.error-text').html('密码不能为空');
                $errorDiv.addClass('error-bg');
                return false;
            }
            if(password && password != '' && window.BASE64){
                password = window.BASE64.encoder(password);
            }

            $.ajax({
                url: '${ctx}/login/ajaxLogin',
                data:  {"loginName":loginName , "password":password},
                async: true,
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    if (!data.success) {
                        $errorDiv.find('.error-text').html(data.message);
                        $errorDiv.addClass('error-bg');
                        return false;
                    }

                    location.href = '${ctx!}/front/index';
                }
            });
        });

        //类别点击筛选事件
        $('.pe-check-by-list').off().click(function () {
            var iconCheck = $(this).find('span.iconfont');
            var thisRealCheck = $(this).find('input[type="checkbox"]');
            if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                thisRealCheck.prop('checked', 'checked');
            } else {
                iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                thisRealCheck.removeProp('checked');
            }
        });

        //兼容IE8的空console对象
        window.console = window.console || {
                    log: $.noop,
                    debug: $.noop,
                    info: $.noop,
                    warn: $.noop,
                    exception: $.noop,
                    assert: $.noop,
                    dir: $.noop,
                    dirxml: $.noop,
                    trace: $.noop,
                    group: $.noop,
                    groupCollapsed: $.noop,
                    groupEnd: $.noop,
                    profile: $.noop,
                    profileEnd: $.noop,
                    count: $.noop,
                    clear: $.noop,
                    time: $.noop,
                    timeEnd: $.noop,
                    timeStamp: $.noop,
                    table: $.noop,
                    error: $.noop
                };
    });
</script>
</body>
</html>