<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zn-CH" style="height:100%;">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>智慧云登录</title>
    <link rel="shortcut icon" href="${resourcePath!}/web-static/proExam/images/pe_ico_32.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/user.css?_v=${(resourceVersion)!}" type="text/css">
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/environment_check.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript">
        var ieBrowserReg = /IE_\d/ig;
        var firBrowserReg = /FIREFOX_\d/ig;
        var chromeBrowserReg = /CHROME_\d/ig;
        if(EnCheck.browserName && EnCheck.browserNum){
            /*IE8*/
            if(ieBrowserReg.test(EnCheck.browserName)){
                if(EnCheck.browserNum < 9){
                    location.href = '/pe/login/initBrowseLower';
                }
            }else if(firBrowserReg.test(EnCheck.browserName)){
                if(EnCheck.browserNum < 30){
                    location.href = '/pe/login/initBrowseLower';
                }
            }else if(chromeBrowserReg.test(EnCheck.browserName)){
                if(EnCheck.browserNum < 35){
                    location.href = '/pe/login/initBrowseLower';
                }
            }

        }
    </script>
</head>
<body style="height: 100%;">
<div class="pe-test-wrapper pe-test-wrap single-test-login-wrap" id="pe-test-content">
    <div class="pe-test-login-wrap">
        <div class="pe-login-nav-container">
            <div class="pe-logo">
                <img src="${resourcePath!}/web-static/proExam/images/long_logo_stand.png" class="floatL" width="10%"
                     alt="LOGO">
            </div>
        </div>
        <div class="pe-test-con">
            <h2 class="pe-test-title">${(exam.examName)!}</h2>
            <div class="pre-login-box pre-text-box">
                <div class="pre-login-static-form">
                    <div class="pre-test-title">登录</div>
                    <form class="pe-text-form" id="loginForm">
                        <input type="hidden" name="examId" value="${(exam.id)!}"/>
                        <div class="pe-test-error text-red">
                            <span class="iconfont icon-caution-tip floatL" style="color:#fff;display:none;"></span>
                            <div class="error-text" style="height:26px;line-height:26px;"></div>
                        </div>
                        <input name="forceLogin" type="hidden" value="true"/>
                        <div class="pre-login-field pe-test-field">
                            <label for=""><i class="iconfont  icon-dengluyonghu"></i></label>
                            <input type="text" name="loginName" class="pre-test-text" oninput="removeLoginBtnClass(this)" onpropertychange="removeLoginBtnClass(this)"  maxlength="32"
                                   placeholder="准考证号/用户名/手机号/邮箱">
                        </div>
                        <div class="pre-login-field">
                            <label id="password-label" for=""><i class="iconfont icon-denglumima"></i></label>
                            <input type="text" onfocus="this.type='password'" name="password" class="pre-test-text password-name" oninput="removeLoginBtnClass(this)" onpropertychange="removeLoginBtnClass(this)"  maxlength="40"
                                   placeholder="密码">
                        </div>
                        <div class="pre-test-submit">
                            <button type="button" class="J_Submit no-login">登录</button>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>
<script>

    window.onload = function () {
        var val = $('input[name="loginName"]').val() || $('input[name="password"]').val();
        if (val && (val != '准考证号/用户名/手机号/邮箱' && val != '密码')) {
            $('.J_Submit').removeClass('no-login');
        }
    };

    function removeLoginBtnClass(thisDom) {
        var _this = $(thisDom),value = _this.val(),loginNameVal = $.trim($('input[name="loginName"]').val()),passwordVal = $.trim($('input[name="password"]').val());
        if (((loginNameVal && loginNameVal != '准考证号/用户名/手机号/邮箱') && (passwordVal && passwordVal != '密码'))) {
            $('.J_Submit').removeClass('no-login');
            $('.pe-test-error').removeClass('error-bg');
            $('.pe-test-error').find('.error-text').text('')
        } else {
            if(_this.hasClass('password-name')){
                _this.get(0).type = 'text';
            }
            $('.J_Submit').addClass('no-login');
        }
    }

    $(function () {
//
//        if($('.pre-login-links').find('.icon-checked-checkbox').get(0)){
//            $('.password-input').attr('type','password');
//        }

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
            if ($(this).hasClass('no-login')) {
                return false;
            }
            $errorDiv.find('.error-text').text('');
            var loginName = $('input[name="loginName"]').val();
            if (!loginName) {
                $('input[name="loginName"]').focus();
                $errorDiv.find('.error-text').text('账号不能为空');
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

            $.ajax({
                url: '${ctx}/login/ajaxLogin',
                data: $('#loginForm').serialize(),
                async: true,
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    if (!data.success) {
                        $errorDiv.find('.error-text').html(data.message);
                        $errorDiv.addClass('error-bg');
                        return false;
                    }

                    location.href = '${ctx!}/ems/exam/client/initVerifyUser?examId=${(exam.id)!}&openTab=true';
                }
            });
        });
    });
</script>
</body>
</html>