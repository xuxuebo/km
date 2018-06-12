<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zn-CH">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
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
<div class="pe-test-wrapper pe-bind-phone-wrap pe-bind-email-wrap">
    <div class="paper-add-accredit-wrap">
        <h1 class="pe-password-title">绑定邮箱</h1>
        <div class="pe-password-contain" style="height: 420px">
            <div class="accountant-verify-content">验证您的身份</div>
            <div class="pe-password-form">
                <div class="pe-add-paper-content-wrap ">
                    <div class="add-paper-item-wrap">
                        <div style="font-size:13px;color:#666;">请输入您的用户名，帮助我们确定您的身份</div>
                            <label class="pe-table-form-label">
                                <span class="pe-input-tree-text">用户名:</span>
                                <input class="pe-password-input" style="width: 293px;" type="text" name="loginName"
                                    maxlength="50" />
                                       <em class="error" style="display: none"></em></span>
                            </label>
                    </div>
                    <div class="add-paper-item-wrap pe-password-next-btn"
                         style="padding:0 0 0 60px;">
                        <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-bind">下一步
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer class="pe-footer-wrap">
        <div class="pe-footer-copyright"> ${(footExplain)!'Copyright &copy${.now?string("yyyy")} 青谷科技专业考试系统 All Rights Reserved 皖ICP备16015686号-2'}</div>
    </footer>
</body>
<script>
    $(function(){
        //ie9不支持Placeholder问题
        PEBASE.isPlaceholder();
        var bindEmail={
            init: function () {
                var _this = this;
                _this.bind();
            },

            bind: function () {
                $('.save-bind').on('click',function(){
                   var loginName=$('input[name="loginName"]').val();
                    if(!loginName){
                        $('.error').show().text("用户名不能为空");
                        return false;
                    }
                    PEBASE.ajaxRequest({
                        url:'${ctx!}/login/activateEmail' ,
                        data:{loginName:loginName,email:'${email!}'},
                        success:function(data){
                           if(data.success){
                               $('body').load('${ctx!}/login/activateSuccessful?email=${email!}');
                           }else{
                               $('.error').show().text(data.message);
                           }
                        }
                    });
                });
            }
        };
        bindEmail.init();
    })
</script>