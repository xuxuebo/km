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
            <li class="pe-logo floatL"></li>
        </ul>
    </div>
</div>
<div class="pe-test-wrapper pe-bind-phone-wrap">
    <div class="paper-add-accredit-wrap">
        <h1 class="pe-password-title">绑定邮箱</h1>
        <div class="pe-password-contain bind-email-success-wrap" style="height: 300px;background:#fff;">
            <div class="pe-password-form">
                <div class="email-success-title">恭喜您，已成功绑定了邮箱</div>
                <div class="pe-add-paper-content-wrap ">
                    <div class="add-paper-item-wrap">
                        <div class="bind-email-number">${email!}</div>
                    </div>
                    <div class="add-paper-item-wrap bind-email-success-tip-text">
                        下次登录时，你可以直接使用该邮箱作为登录名
                    </div>
                </div>
            </div>
            <div class="bind-email-success-change-tip">温馨提示：若想更换邮箱，请到个人中心修改</div>
        </div>
    </div>
    <footer class="pe-footer-wrap">
        <div class="pe-footer-copyright"> ${(footExplain)!'Copyright &copy${.now?string("yyyy")} 青谷科技专业考试系统 All Rights Reserved 皖ICP备16015686号-2'}</div>
    </footer>
</body>