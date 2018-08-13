<!doctype html>
<html lang="zn-CH">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="renderer" content="webkit">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <title>${(titleName)!'智慧云'}登录</title>
    <link rel="shortcut icon" href="${(resourcePath+icoUrl)!'${resourcePath!}/web-static/proExam/images/pe_ico_32.ico'}" type="image/x-icon"/>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/user.css?_v=${(resourceVersion)!}" type="text/css">
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>

    <!--[if IE 8]>
        <style type="text/css">
            .main-browser-tip-wrap .tip-wrap-left{
                background:none;
                background-size: cover;
                filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${resourcePath!}/web-static/proExam/images/browser_lower_tip.png',  sizingMethod='scale');
            }
            .main-browser-tip-wrap .get-new-browser > li{
                background:none;
                background-size: cover;
                filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${resourcePath!}/web-static/proExam/images/chrome_browser_icon.png',  sizingMethod='scale');
            }
            .main-browser-tip-wrap .get-new-browser > .firefox-browser{
                background:none;
                background-size: cover;
                filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${resourcePath!}/web-static/proExam/images/firefox_browser_icon.png',  sizingMethod='scale');
            }
            .main-browser-tip-wrap .get-new-browser > .ie-browser{
                background:none;
                background-size: cover;
                filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${resourcePath!}/web-static/proExam/images/ie_browser_icon.png',  sizingMethod='scale');
            }
            .pe-top-nav-container{
                overflow:hidden; 
            }
            /*.pe-top-nav-container .pe-logo{*/
                /*background:none;*/
                /*margin-top:10px;*/
                /*background-size: cover;*/
                /*filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${resourcePath!}/web-static/proExam/images/long_logo_pure.png',  sizingMethod='scale');*/
            /*}*/
        </style>
    <![endif]-->

</head>
<body>
<div class="pe-browser-lower-wrap">
    <div class="pe-top-nav-container">
        <div class="pe-logo" style="width:118px;height:30px;">
            <span style="font-size: 26px;font-weight: bold;">智慧云</span>
        </div>
    </div>

    <div class="main-browser-tip-wrap">
        <div class="tip-wrap-left floatL clearF">
        </div>
        <div class="tip-wrap-right">
            <h2>抱歉，暂不支持低于IE9或Chrome小于35,Firefox小于30版本浏览器</h2>
            <p>请升级浏览器、或者使用高于30版本的火狐(Firefox)、谷歌（Chrome）浏览器。点击如下图标进行下载。</p>
            <ul class="get-new-browser">
                <li class="floatL" title="chrome浏览器"></li>
                <li class="floatL firefox-browser" title="firefox浏览器"></li>
                <li class="floatL ie-browser" title="IE浏览器"></li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>