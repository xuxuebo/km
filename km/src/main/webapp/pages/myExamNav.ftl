<#assign ctx=request.contextPath/>
<!DOCTYPE html>
<html  style="height:100%;">
<head>
    <title>${(titleName)!'智慧云'}</title>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" href="${(resourcePath+icoUrl)!'${resourcePath!}/web-static/proExam/images/pe_ico_32.ico'}" type="image/x-icon" />
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/user.css?_v=493${(resourceVersion)!}" type="text/css">
    <#--<link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css" type="text/css">&lt;#&ndash;临时添加的css&ndash;&gt;-->
<#--前端调试-->
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
    <script>
        var pageContext = {
            rootPath:'${ctx!}',
            resourcePath:'${resourcePath!}'
        }
    </script>
<#--开发引用-->
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/compressJs/pro_exam_plugin_min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/sui_datepicker.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/user_control.js?_v=85${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/webSocket/swfobject.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/webSocket/web_socket.js?_v=${(resourceVersion)!}"></script>
<#--<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/sockjs-1.1.1.min.js"></script>-->
</head>
<body>
<#--公用头部-->
<div class="pe-public-top-nav-header user-top-nav-header" data-id="" style="padding:0;">
    <div class="pe-top-nav-container">
        <ul class="clearF">
            <li class="pe-logo floatL">
                <img src="${(resourcePath+logoUrl)!'${resourcePath!}/web-static/proExam/images/long_logo_pure.png'}" class="floatL" width="100%" alt="LOGO">
            </li>
            <li class="pe-login-area pe-login-item floatR">
                <form class="pe-search-input-wrap" name="peSearchForm" action="javascript:;">
                    <div class="my-exam-search-input" style="width:150px;height:64px;">
                    </div>
                </form>
                <div class="pe-user-name pe-login-icon" style="margin-left:80px;<#if !(roleType?? && roleType == 'ADMIN')>cursor:default;</#if>">
                    <i class="iconfont icon-role-user floatL clearF"></i>
                    <span class="pe-login-name-con floatL clearF">${(userName)!}</span>
                <#if admin?? && admin>
                    <i class="iconfont icon-thin-arrow-down floatL clearF login-name-con-arrow"></i>
                    <div class="login-sort-wrap" style="left: 250px;">
                        <div class="pe-login-sort" style="display: none;">
                            <div class="sort-triangle"></div>
                            <ul>
                                <li>考生</li>
                                <li class="admin-role">管理员</li>
                            </ul>
                        </div>
                    </div>
                </#if>
                </div>
                <#--<a href="javascript:;" class="pe-header-msg"><i class="iconfont icon-message-center floatL"></i>消息</a>-->
                <#--暂时功能先注释掉-->
                <#--<a href="javascript:;" class="pe-header-msg"><i class="iconfont icon-message-center floatL"></i>消息</a>-->
                <button type="button" class="pe-login-out iconfont icon-exit" title="退出"></button>
            </li>
        </ul>
    </div>
</div>
<#--公用主题部分，包括面包屑导航及大的背景-->
<div class="pe-main-wrap user-main-wrap">
<#--页面主题区域,用于包裹绝大部分的页面-->
    <div class="pe-main-wrap pe-center-wrap" style="padding:0;">
        <div class="pe-main-content">
            <div class="pe-user-manage-all-wrap">
                <div class="pe-manage-content-left user-main-content-left floatL">
                    <div class="pe-classify-wrap floatL pe-center-left my-exam-center-left">
                        <div class="pe-center-left-con" style="padding-top:0;">
                            <ul>
                                <li class="pe-user-menu-tree" data-type="initMyDynamic" style="cursor: pointer" <#--data-url="${ctx!}/front/initMyDynamic"-->><i class="iconfont" style="font-size:17px;">&#xe738;</i>我的考试</li>
                                <li class="pe-user-menu-tree" data-type="myExamPage" style="cursor: pointer" data-url="${ctx!}/front/initMyExamPage"><i class="iconfont">&#xe734;</i>历史考试</li>
                              <#--  <li class="pe-user-menu-tree" style="cursor: pointer"
                                    data-url="${ctx!}/front/initMyMockExamDynamic"><i class="iconfont">&#xe734;</i>模拟考试
                                </li>-->
                                <li class="pe-user-menu-tree" data-type="myExercisePage" style="cursor: pointer" data-url="${ctx!}/front/initMyExercisePage"><i class="iconfont" style="font-size:17px;">&#xe7ab;</i>我的练习</li>
                                <li class="pe-user-menu-tree" data-type="personalCenter" style="cursor: pointer" data-url="${ctx!}/front/initMyPersonalCenter"><i class="iconfont">&#xe733;</i>个人中心</li>
                                <li class="pe-user-menu-tree" data-type="myMsgCenter" style="cursor: pointer" data-url="${ctx!}/front/initMyMessageCenter"><i class="iconfont">&#xe739;</i>消息中心</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="my-exam-nav-all-right">
                    <section id="peMainPulickContent" class="pe-manage-content-right pe-recent-contain  my-exam-nav-right-panel">
                        <#--<div class="user-loading-panel"></div>-->
                    </section>
                </div>
            </div>
        </div>
    </div>
    <div class="pe-mask-listen"></div>
</div>

<#--回到顶部-->
<button style="left:auto;right:60px;display:none;top:68%;" type="button" class="pe-btn pe-btn-primary go-top-btn iconfont icon-go-top" style="display:none;"></button>
<#--公用部分尾部版权-->
<footer class="pe-footer-wrap user-footer-wrap">
    <div class="pe-footer-copyright">${(footExplain)!'Copyright &copy${.now?string("yyyy")} 青谷科技专业考试系统 All Rights Reserved 皖ICP备16015686号-2'}</div>
</footer>
<script>
    $(function () {
        userControl.initExamNav.init();

    })
</script>