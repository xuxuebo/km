<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zn-CH">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>${(titleName)!'博易考'}登录</title>
    <link rel="shortcut icon" href="${(resourcePath+icoUrl)!'${resourcePath!}/web-static/proExam/images/pe_ico_32.ico'}" type="image/x-icon" />
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/user.css?_v=${(resourceVersion)!}" type="text/css">
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>
</head>
<body style="background:#fff;">
<#--公用头部-->
<div class="pe-public-top-nav-header pe-submit-success-header">
    <div class="pe-top-nav-container exam-cancel">
        <ul class="clearF">
            <li class="floatL">${(exam.examName)!}</li>
        </ul>
    </div>
</div>
<div class="pe-exam-cancel-wrap">
    <div class="cancel-bg"></div>
    <p>该场考试已作废</p>
    <button class="pe-btn pe-btn-blue exam-cancel-btn pe-large-btn">关闭</button>
</div>
<#--公用部分尾部版权-->
<footer class="pe-footer-wrap user-footer-wrap">
    <div class="pe-footer-copyright"> ${(footExplain)!'Copyright &copy${.now?string("yyyy")} 青谷科技专业考试系统 All Rights Reserved 皖ICP备16015686号-2'}</div>
</footer>
</body>
<script>
    $(function(){
        window.opener.location.reload();
        $('.exam-cancel-btn').on('click',function(){
            window.close();
        });

        var thisShouldHeight = $(window).height() - 64 - 60;
        $('.pe-exam-cancel-wrap').height(thisShouldHeight);
        $(window).resize(function(){
            var thisShouldHeightResize = $(window).height() - 64 - 60;
            $('.pe-exam-cancel-wrap').height(thisShouldHeightResize);
        });
    });
</script>
</html>
