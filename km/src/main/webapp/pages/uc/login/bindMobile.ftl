<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zn-CH">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">    <title>${(titleName)!'智慧云'}</title>
    <link rel="shortcut icon" href="${(resourcePath+icoUrl)!'${resourcePath!}/web-static/proExam/images/pe_ico_32.ico'}" type="image/x-icon"/>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/user.css?_v=${(resourceVersion)!}" type="text/css">
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/jquery.slideunlock.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>
</head>
<body>
<#--公用头部-->
<div class="pe-public-top-nav-header" data-id="">
    <div class="pe-top-nav-container">
        <ul class="clearF">
            <li class="pe-logo floatL">
                <img src="${(resourcePath+logoUrl)!'${resourcePath!}/web-static/proExam/images/long_logo_pure.png'}" class="floatL" width="100%" alt="LOGO">
            </li>
        </ul>
    </div>
</div>
<div class="pe-test-wrapper pe-bind-phone-wrap">
    <div class="paper-add-accredit-wrap">
        <h1 class="pe-password-title">绑定手机</h1>
        <div class="pe-password-contain">
                    <div class="pe-password-form">
                        <div class="pe-add-paper-content-wrap ">
                            <div class="add-paper-item-wrap">
                                <label class="pe-table-form-label">
                                    <input class="pe-password-input" style="width: 293px;height:26px;" type="text" name="mobile"
                                           maxlength="50" placeholder="请输入需绑定手机号"/>
                                    <span class="pe-password-tip" style="padding-left: 10px;line-height:1;display: none"><i
                                            class="iconfont icon-caution-tip"></i>&nbsp;<span class="error-msg"></span></span>
                                </label>
                            </div>
                            <div class="add-paper-item-wrap">
                                <div id="slider" class="">
                                    <div id="slider_bg"></div>
                                    <span id="label" class="iconfont icon-slide-to-unlock"></span> <span id="labelTip">按住左边滑块，拖动完成验证</span>
                                </div>
                                <span class="floatR slider-circle-states iconfont icon-lock"></span>
                            </div>
                            <div class="add-paper-item-wrap">
                                <label class="pe-table-form-labe over-flow-hide">
                                    <input class="pe-password-input" style="width: 180px;float:left;height:26px;" type="text"
                                           name="code" maxlength="50"
                                           placeholder="请输入验证码"/>
                                    <input class="pe-password-input code-btn" style="height:40px;border-left:none;" type="button"
                                           value="获取短信验证码"/>
                                    <span class="pe-password-tip" style="padding-left: 10px;line-height:1;display: none"><i
                                            class="iconfont icon-caution-tip"></i>&nbsp;<span class="error-msg"></span></span>
                                </label>
                            </div>
                            <div class="add-paper-item-wrap pe-password-next-btn"
                                 style="padding: 30px 0 0 0;">
                                <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-bind">
                                    <span class="save-bind-text bind-disabled">立即绑定</span>
                                </button>
                                <button type="button" class="pe-btn pe-btn-white pe-large-btn skip-step" style="font-size:14px;">跳过该步骤
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
    </div>
    <footer class="pe-footer-wrap">
        <div class="pe-footer-copyright">${(footExplain)!'Copyright &copy${.now?string("yyyy")} 青谷科技专业考试系统 All Rights Reserved 皖ICP备16015686号-2'}</div>
    </footer>
</body>
<script>
    $(function () {
        //ie9不支持Placeholder问题
        PEBASE.isPlaceholder();
        var bindMobile = {
            isCanClick:false,
            init: function () {
                var _this = this;
                _this.initData();
                _this.bind();
            },

            bind: function () {
                var _this = this;
                $('.paper-add-accredit-wrap').delegate('.get-code-btn', 'click', function () {
                    var isVal = _this.validateMobile();
                    if (!isVal) {
                        return false;
                    }

                    var mobile = $('input[name="mobile"]').val();
                    PEBASE.ajaxRequest({
                        url: '${ctx!}/uc/user/client/bindLoginMobile',
                        data: {mobile: mobile},
                        success: function (data) {
                            if (data.success) {
                                var times = 60;
                                $('.get-code-btn').removeClass('get-code-btn').addClass('code-btn').val(times + 's');
                                var timeInterval = setInterval(function () {
                                    times--;
                                    $('.code-btn').val(times + 's');
                                    if (times === 0) {
                                        clearInterval(timeInterval);
                                        $('.code-btn').removeClass('code-btn').addClass('get-code-btn').val('获取短信验证码');
                                        return false;
                                    }
                                }, 1000);

                                bindMobile.isCanClick = true;
                                return false;
                            }

                            $('input[name="code"]').parents('.add-paper-item-wrap').find('.error-msg').text(data.message);
                        }
                    });
                });

                $('input[name="code"]').blur(function(){
                    if(bindMobile.isCanClick && $.trim($(this).val())){
                        $('.save-bind-text').removeClass('bind-disabled');
                    }
                });

                $('.save-bind').on('click', function () {
                    var isVal = _this.validateMobile();
                    if (!isVal) {
                        return false;
                    }

                    var mobile = $('input[name="mobile"]').val();
                    var verifyCode = $('input[name="code"]').val();
                    if (!verifyCode) {
                        $('input[name="code"]').parents('.add-paper-item-wrap').find('.error-msg').text('手机验证码不能为空！');
                        return false;
                    }

                    PEBASE.ajaxRequest({
                        url: '${ctx!}/uc/user/client/checkLoginVerifyCode',
                        data: {mobile: mobile, verifyCode: verifyCode},
                        success: function (data) {
                            if (data.success) {
                                location.href = '${ctx!}/front/initPage';
                                return false;
                            }
                            $('input[name="code"]').parents('.add-paper-item-wrap').find('.error-msg').text(data.message);
                        }
                    });
                });

                $('.skip-step').on('click',function(){
                    location.href = '${ctx!}/front/initPage';
                });
            },

            initData: function () {
                var _this = this;
                new SliderUnlock("#slider", {"index":-2,"max":$("#slider").width() + 14}, function () {
                    var isVal = _this.validateMobile();
                    if (!isVal) {
                        return false;
                    }
                    $('#label').removeClass('icon-sliding-around').addClass('icon-slide-to-unlock');
                    $('.slider-circle-states').removeClass('icon-lock').addClass('icon-datiduiti');
                    $('#label').unbind().next('#labelTip').text('手机号验证通过').css({'color': '#fff'});
                    $('.code-btn').removeClass('code-btn').addClass('get-code-btn');
                }).init();

            },

            validateMobile: function () {
                var $mobile = $('input[name="mobile"]');
                var mobile = $mobile.val();
                var $errMsg = $mobile.parents('.add-paper-item-wrap').find('.error-msg');
                $errMsg.parents('.pe-password-tip').hide();
                if (!mobile) {
                    $errMsg.text('请输入手机号码！');
                    $errMsg.parents('.pe-password-tip').show();
                    return false;
                }

                if (!/^((13[0-9])|(15[^4])|(18[0,1,2,3,5-9])|(17[0-8])|(147))\d{8}$/.test(mobile)) {
                    $errMsg.text('手机号输入不正确！');
                    $errMsg.parents('.pe-password-tip').show();
                    return false;
                }

                var isVal = true;
                var setting = {
                    url: '${ctx!}/uc/user/client/checkMyMobile',
                    async: false,
                    data: {'mobile': mobile},
                    success: function (data) {
                        if (!data.success) {
                            $errMsg.text('该手机号已被占用!');
                            $errMsg.parents('.pe-password-tip').show();
                            isVal = false;
                        }
                    }
                };

                PEBASE.ajaxRequest(setting);
                return isVal;
            }
        };

        bindMobile.init();
    });
</script>
</html>