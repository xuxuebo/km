<!doctype html>
<html lang="zn-CH">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>${(titleName)!'智慧云'}登录</title>
    <link rel="shortcut icon" href="${(resourcePath+icoUrl)!'${resourcePath!}/web-static/proExam/images/pe_ico_32.ico'}" type="image/x-icon" />
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/user.css?_v=${(resourceVersion)!}" type="text/css">
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
<div class="pe-test-wrapper">
    <div class="paper-add-accredit-wrap" style="background-color:#none; margin-top: 15px;">
        <div class="pe-manage-panel pe-manage-default " style="min-height:647px;background:#fff;">
            <div class="pe-stand-table-panel">
                <h1 class="pe-password-title">找回密码</h1>
                <div class="pe-password-contain">
                    <ul class="over-flow-hide edit-step-state">
                        <li class="add-paper-step-item floatL overStep forget-pass-step-item">
                            <div class="add-step-icon-wrap">
                                 <span class="iconfont icon-step-circle floatL">
                                      <span class="add-step-number">1</span>
                                 </span>
                                <div class="add-step-line"></div>
                            </div>
                            <span class="add-step-text">填写号码</span>
                        </li>
                        <li class="add-paper-step-item add-paper-step-two floatL overStep edit-paper-must forget-pass-step-item">
                            <div class="add-step-icon-wrap">
                                <div class="add-step-line add-step-two-line"></div>
                            <span class="iconfont icon-step-circle floatL">
                                    <span class="add-step-number">2</span>
                                </span>
                                <div class="add-step-line"></div>
                            </div>
                            <span class="add-step-text">验证身份</span>
                        </li>
                        <li class="add-paper-step-item add-paper-step-two floatL overStep edit-paper-random forget-pass-step-item">
                            <div class="add-step-icon-wrap">
                                <div class="add-step-line add-step-two-line"></div>
                            <span class="iconfont icon-step-circle floatL">
                                         <span class="add-step-number">3</span>
                                    </span>
                                <div class="add-step-line"></div>
                            </div>
                            <span class="add-step-text">重置密码</span>
                        </li>
                        <li class="add-paper-step-item add-paper-step-three floatL overStep edit-paper-auth forget-pass-step-item"
                            style="width:150px;">
                            <div class="add-step-icon-wrap">
                                <div class="add-step-line"></div>
                            <span class="iconfont icon-step-circle floatL">
                                               <span class="add-step-number">4</span>
                                        </span>
                            </div>
                            <span class="add-step-text" style="margin-left:105px;">完成</span>
                        </li>
                    </ul>
                    <div class="pe-identity-container">
                        <div class="pe-identity-wrap">
                        </div>
                    </div>
                    <p class="pe-identity-warn"><i class="iconfont">&#xe640;</i>您还没有绑定任何手机和邮箱，只能联系管理员帮助您重置密码。</p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>