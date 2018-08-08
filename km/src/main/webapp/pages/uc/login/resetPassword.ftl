<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zn-CH">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>${(titleName)!'智慧云'}登录</title>
    <link rel="shortcut icon" href="${(resourcePath+icoUrl)!'${resourcePath!}/web-static/proExam/images/pe_ico_32.ico'}" type="image/x-icon"/>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/user.css?_v=${(resourceVersion)!}" type="text/css">
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/user_control.js?_v=${(resourceVersion)!}"></script>
    <script>
        var pageContext = {
            rootPath:'${ctx!}',
            resourcePath:'${resourcePath!}'
        }
    </script>
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
<div class="pe-test-wrapper find-password-wrap">
    <div class=" paper-add-accredit-wrap" style="background-color:#none; margin-top: 15px;">
        <div class="pe-manage-panel pe-manage-default" style="min-height:647px;background:#fff;">
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
                        <li class="add-paper-step-item add-paper-step-three floatL edit-paper-auth forget-pass-step-item"
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
                    <form class="pe-password-form" style="padding-left:140px;">
                        <input name="userId" type="hidden" value="${userId!}">
                        <div class="pe-add-paper-content-wrap ">
                            <div class="add-paper-item-wrap over-flow-hide">
                                <label class="pe-left-text">&emsp;新密码：</label>
                                <input class="pe-password-input pe-identity-input-con" type="password" name="paperCode"
                                       id="first-paperCode" maxlength="50" placeholder="密码为6-20位，区分大小写"/>
                                <span class="pe-password-tip"></span>
                            </div>
                            <div class="add-paper-item-wrap over-flow-hide">
                                <span class="pe-left-text">确认密码：</span>
                                <input class="pe-password-input pe-identity-input-con" type="password" name="paperCode"
                                       id="second-paperCode" maxlength="50">
                            </div>
                            <div class="add-paper-item-wrap over-flow-hide pe-password-next-btn">
                                <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn pe-save-btn">保存
                                </button>
                            </div>
                        </div>
                    </form>
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
        userControl.forgetPW.resetPW.init();
    })
</script>
</html>
