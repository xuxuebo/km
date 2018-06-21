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
<body>
<#--公用头部-->
<div class="pe-public-top-nav-header pe-submit-success-header">
    <div class="pe-top-nav-container">
        <ul class="clearF">
            <li class="pe-logo floatL">
                <img src="${(resourcePath+logoUrl)!'${resourcePath!}/web-static/proExam/images/long_logo_pure.png'}" class="floatL" width="100%" alt="LOGO">
            </li>
        </ul>
    </div>
</div>
<div class="pe-submit-wrapper">
    <div class="pe-submit-contain">
    <#--  <div style="position: relative;width: 60px;margin: 0 auto;">
          &lt;#&ndash;  <img class="pe-airplane-first" src="${resourcePath!}/web-static/proExam/images/airplane.png">
            <img class="pe-airplane-sec" src="${resourcePath!}/web-static/proExam/images/airplane2.png">
            <img class="pe-airplane-third" src="${resourcePath!}/web-static/proExam/images/airplane3.png">&ndash;&gt;
        </div>-->
    </div>
    <div class="pe-submit-content">
         <h1 class="pe-submit-paper">试卷已成功提交!</h1>
         <p class="pe-submit-tip">成绩发布后，我们会以站内信、邮件或短信的方式通知您</p>
         <div class="pe-submit-btn">
             <button class="pe-btn pe-btn-blue pe-submit-close">关闭</button>
         </div>
         <p class="pe-submit-page-close"><span class="text-orange">5</span>秒后，页面会自动关闭</p>
    </div>
</div>
</body>
<script>
    $(function(){
        var openTab = '${(openTab?string('true','false'))!}';
        if(!openTab || openTab === 'false'){
            window.opener.location.reload();
        }

        $('.pe-submit-contain').height($(window).width() / 4.19);//5.16为背景图片的长宽比例;

        $(window).resize(function(){
            $('.pe-submit-contain').height($(window).width() / 4.19);//5.16为背景图片的长宽比例;
        })
        $('.pe-submit-close').on('click',function(){
            if(!openTab || openTab === 'false'){
                window.close();
            } else {
                location.replace('${ctx!}/front/initPage');
            }
        });

        if(history.pushState){
            history.pushState(null, null, document.URL);
            window.addEventListener('popstate', function () {
                history.pushState(null, null, document.URL);
            });
        }

        var number = parseInt($('.text-orange').text());
           setInterval(function(){
               if(number <= 0){
                   $('.pe-submit-close').trigger('click');
                   return false;
               }

               --number;
               $('.text-orange').text(number);
           },1000);

        window.onunload = function() {
            if(!openTab || openTab === 'false'){
                window.close();
            } else {
                location.replace('${ctx!}/front/initPage');
            }
        };
    });
</script>
</html>
