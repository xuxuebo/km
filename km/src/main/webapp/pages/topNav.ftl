<#assign ctx=request.contextPath/>
<!DOCTYPE html>
<html>
<head>
    <title>${(titleName)!'智慧云'}</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="renderer" content="webkit" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" href="${(resourcePath+icoUrl)!'${resourcePath!}/web-static/proExam/images/pe_ico_32.ico'}" type="image/x-icon"/>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css">
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.js?_v=${(resourceVersion)!}"></script>
    <script>
        var pageContext = {
            rootPath: '${ctx!}',
            resourcePath: '${resourcePath!}'
        };

        $(function () {
            $(document).ajaxComplete(function (event, jqXHR, options) {
                var ajaxRequestStatus = jqXHR.getResponseHeader("ajaxRequest");
                if (ajaxRequestStatus === 'loginFailed') {
                    location.href = pageContext.rootPath + '/client/logout';
                }
            });

            $(document).ajaxSend(function (event, jqxhr, settings) {
                var times = (new Date()).getTime() + Math.floor(Math.random() * 10000);
                if (settings.url.indexOf('?') > -1) {
                    settings.url = settings.url + '&_t=' + times;
                } else {
                    settings.url = settings.url + '?_t=' + times;
                }

            });
        });
    </script>
<#--开发引用-->
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/html5.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/media/video_dev.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.core.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.excheck.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.exedit.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.pagination.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.webuploader.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-peGrid.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/jquery.mCustomScrollbar.concat.min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/viewer.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.easydropdown.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.moment.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.validate.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/sui_datepicker.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/zclip/jquery.zclip.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/idangerous.swiper2.7.6.js?_v=${(resourceVersion)!}"></script>
    <style>
        /*修改智慧云部门管理样式*/
        .pe-main-wrap,.pe-main-content{
            width: auto;
            min-width: 900px;
        }
        .pe-organize-manage-all-wrap .pe-classify-wrap{
            width: 100%;
        }
        .pe-organize-manage-all-wrap .pe-tree-container, .pe-organize-manage-all-wrap .pe-tree-content-wrap, .pe-organize-manage-all-wrap .pe-tree-main-wrap{
            width: auto !important;
        }
        .pe-break-nav-tip-container{
            width: auto;
        }
        .exam-manage-all-wrap .pe-manage-content-right{
            width: auto;
        }
    </style>
    <script>document.documentElement.focus();</script>
</head>
<body class="pe-container">
<#--公用头部-->
<#--<div class="pe-public-top-nav-header" data-id="">-->
    <#--<div class="pe-top-nav-container">-->
        <#--<ul class="clearF">-->
            <#--<li class="pe-logo floatL">-->
                <#--<img src="${(resourcePath+logoUrl)!'${resourcePath!}/web-static/proExam/images/long_logo_pure.png'}" class="floatL" width="100%" alt="LOGO">-->
            <#--</li>-->
            <#--<li class="pe-nav-classify floatL">-->
                <#--<ul class="clearF">-->
                    <#--<li class="floatL pe-classify-detail" data-type="home">-->
                        <#--<a href="#url=${ctx!}/pages/manageIndex&nav=home" class="classify-link iconfont icon-page cur"-->
                           <#--style="font-size: 20px;"></a>-->
                    <#--</li>-->
                <#--<@authVerify authCode="ITEM">-->
                    <#--<li class="floatL pe-classify-detail" data-type="question">-->
                        <#--<a href="javascript:;" class="classify-link">试题</a>-->
                        <#--<ul class="pe-classify-sub-nav">-->
                            <#--<@authVerify authCode="ITEM_MANAGE">-->
                                <#--<li class="sub-nav-items">-->
                                    <#--<a href="#url=${ctx!}/ems/item/manage/initPage&nav=question"-->
                                       <#--class="sub-nav-link">试题管理</a>-->
                                <#--</li>-->
                            <#--</@authVerify>-->
                            <#--<@authVerify authCode="ITEM_BANK_MANAGE">-->
                                <#--<li class="sub-nav-items">-->
                                    <#--<a href="#url=${ctx!}/ems/itemBank/manage/initPage&nav=question"-->
                                       <#--class="sub-nav-link">题库管理</a>-->
                                <#--</li>-->
                            <#--</@authVerify>-->
                            <#--<@authVerify authCode="VERSION_OF_KNOWLEDGE_POINT">-->
                                <#--<@authVerify authCode="ITEM_KNOWLEDGE_MANAGE">-->
                                <#--<li class="sub-nav-items">-->
                                    <#--<a href="#url=${ctx!}/ems/knowledge/manage/initPage&nav=question"-->
                                       <#--class="sub-nav-link">知识点管理</a>-->
                                <#--</li>-->
                                <#--</@authVerify>-->
                            <#--</@authVerify>-->
                        <#--</ul>-->
                    <#--</li>-->
                <#--</@authVerify>-->
                <#--<@authVerify authCode="PAPER">-->
                    <#--<li class="floatL pe-classify-detail" data-type="examPaper">-->
                        <#--<a href="#url=${ctx}/ems/template/manage/initPage&nav=examPaper" class="classify-link">试卷</a>-->
                    <#--</li>-->
                <#--</@authVerify>-->
                <#--<@authVerify authCode="EXAM">-->
                    <#--<li class="floatL pe-classify-detail" data-type="examMana">-->
                        <#--<a href="javascript:;" class="classify-link">考试</a>-->
                        <#--<ul class="pe-classify-sub-nav">-->
                            <#--<@authVerify authCode="EXAM_MANAGE">-->
                                <#--<li class="sub-nav-items"><a href="#url=${ctx!}/ems/exam/manage/initPage&nav=examMana"-->
                                                             <#--class="sub-nav-link">考试管理</a></li>-->
                            <#--</@authVerify>-->
                            <#--<@authVerify authCode="EXAM_SUBJECT_MANAGE">-->
                                <#--<li class="sub-nav-items"><a-->
                                        <#--href="#url=${ctx!}/ems/exam/manage/initSubjectPage&nav=examMana"-->
                                        <#--class="sub-nav-link">科目管理</a></li>-->
                            <#--</@authVerify>-->
                            <#--&lt;#&ndash;<@authVerify authCode="EXAM_SIMULATION_MANAGE">-->
                                <#--<li class="sub-nav-items"><a-->
                                        <#--href="#url=${ctx!}/ems/simulationExam/manage/initSimulationExamPage&nav=examMana"-->
                                        <#--class="sub-nav-link">模拟考试</a></li>-->
                            <#--</@authVerify>&ndash;&gt;-->
                            <#--<@authVerify authCode="EXAM_EXERCISE">-->
                                <#--<li class="sub-nav-items"><a-->
                                        <#--href="#url=${ctx!}/ems/exercise/manage/initPage&nav=examMana"-->
                                        <#--class="sub-nav-link">练习管理</a></li>-->
                            <#--</@authVerify>-->
                        <#--</ul>-->
                    <#--</li>-->
                <#--</@authVerify>-->
                <#--<@authVerify authCode="VERSION_OF_MONITOR">-->
                    <#--<@authVerify authCode="MONITOR">-->
                    <#--<li class="floatL pe-classify-detail" data-type="monitor">-->
                        <#--<a href="#url=${ctx!}/ems/examMonitor/manage/initPage&nav=monitor" class="classify-link ">监控</a>-->
                    <#--</li>-->
                    <#--</@authVerify>-->
                <#--</@authVerify>-->
                <#--<@authVerify authCode="VERSION_OF_MARKING_MANAGE">-->
                    <#--<@authVerify authCode="JUDGE">-->
                    <#--<li class="floatL pe-classify-detail" data-type="mark">-->
                        <#--<a href="#url=${ctx!}/ems/judge/manage/initPage&nav=mark" class="classify-link">评卷</a>-->
                    <#--</li>-->
                    <#--</@authVerify>-->
                <#--</@authVerify>-->

                <#--<@authVerify authCode="RESULT">-->
                    <#--<li class="floatL pe-classify-detail" data-type="result">-->
                        <#--<a href="javascript:;" class="classify-link">成绩</a>-->
                        <#--<ul class="pe-classify-sub-nav">-->
                            <#--<@authVerify authCode="RESULT_RELEASE">-->
                                <#--<li class="sub-nav-items"><a-->
                                        <#--href="#url=${ctx!}/ems/examResult/manage/initResultPage&nav=result"-->
                                        <#--class="sub-nav-link">发布成绩</a></li>-->
                            <#--</@authVerify>-->
                            <#--<@authVerify authCode="RESULT_MANAGE">-->
                                <#--<li class="sub-nav-items"><a-->
                                        <#--href="#url=${ctx!}/ems/examResult/manage/initResultManagePage&nav=result"-->
                                        <#--class="sub-nav-link">查看成绩</a></li>-->
                            <#--</@authVerify>-->
                        <#--</ul>-->
                    <#--</li>-->
                <#--</@authVerify>-->
                <#--<@authVerify authCode="USER">-->
                    <#--<li class="floatL pe-classify-detail" data-type="user">-->
                        <#--<a href="javascript:;" class="classify-link">用户</a>-->
                        <#--<ul class="pe-classify-sub-nav">-->
                            <#--<@authVerify authCode="USER_MANAGE">-->
                                <#--<li class="sub-nav-items"><a href="#url=${ctx!}/uc/user/manage/initPage&nav=user"-->
                                                             <#--class="sub-nav-link">用户管理</a></li>-->
                            <#--</@authVerify>-->
                            <#--<@authVerify authCode="VERSION_OF_ROLE_MANAGE">-->
                                <#--<@authVerify authCode="USER_ROLE_MANAGE">-->
                                    <#--<li class="sub-nav-items"><a href="#url=${ctx!}/uc/role/manage/initPage&nav=user"-->
                                                             <#--class="sub-nav-link">角色管理</a></li>-->
                                <#--</@authVerify>-->
                            <#--</@authVerify>-->

                            <#--<@authVerify authCode="USER_POSITION_MANAGE">-->
                                <#--<li class="sub-nav-items"><a href="#url=${ctx!}/uc/position/manage/initPage&nav=user"-->
                                                             <#--class="sub-nav-link">岗位管理</a></li>-->
                            <#--</@authVerify>-->
                            <#--<@authVerify authCode="USER_ORGANIZE_MANAGE">-->
                                <#--<li class="sub-nav-items"><a href="#url=${ctx!}/uc/organize/manage/initPage&nav=user"-->
                                                             <#--class="sub-nav-link">部门管理</a></li>-->
                            <#--</@authVerify>-->
                            <#--<@authVerify authCode="CORP_MANAGE">-->
                                <#--<li class="sub-nav-items"><a href="#url=${ctx!}/corp/manage/initPage&nav=user"-->
                                                             <#--class="sub-nav-link">公司管理</a></li>-->
                            <#--</@authVerify>-->
                        <#--</ul>-->
                    <#--</li>-->
                <#--</@authVerify>-->
                    <#--<li class="floatL pe-classify-detail" data-type="system">-->
                        <#--<a href="javascript:;" class="classify-link">系统</a>-->
                        <#--<ul class="pe-classify-sub-nav">-->
                            <#--<li class="sub-nav-items"><a href="#url=${ctx!}/systemSetting/manage/initPage&nav=system"-->
                                                         <#--class="sub-nav-link">消息管理</a></li>-->
                        <#--</ul>-->
                    <#--</li>-->
                <#--</ul>-->
            <#--</li>-->
            <#--<li class="pe-login-area floatR" style="position: relative;">-->
                <#--<div class="pe-user-name pe-login-icon clearF">-->
                    <#--<i class="iconfont icon-role-user floatL clearF"></i>-->
                    <#--<span class="pe-login-name-con floatL clearF">${(userName)!}</span>-->
                    <#--<i class="iconfont icon-thin-arrow-down floatL clearF login-name-con-arrow"></i>-->
                    <#--<div class="login-sort-wrap pe-login-sort-manage">-->
                        <#--<div class="pe-login-sort" style="display: none;">-->
                            <#--<div class="sort-triangle"></div>-->
                            <#--<ul>-->
                                <#--<li class="stu-role">考生</li>-->
                                <#--<li class="admin-role">管理员</li>-->
                            <#--</ul>-->
                        <#--</div>-->
                    <#--</div>-->
                <#--</div>-->
                <#--<button class="pe-login-out iconfont icon-exit" title="退出" type="button"></button>-->
                <#--&lt;#&ndash;corpInfo.version == ENTERPRISE为企业版&ndash;&gt;-->
               <#--&lt;#&ndash; <a href="/pe/front/manage/updateCorp" class="<#if ((corpInfo.version)! != ""&&(corpInfo.version)! == 'ENTERPRISE')>pe-update-corp<#else>hidden</#if>"></a>&ndash;&gt;-->
            <#--</li>-->
        <#--</ul>-->
    <#--</div>-->
    <#--<#if ((corpInfo.version)! != ""&&(corpInfo.version)! == 'FREE')>-->
        <#--<a href='/pe/front/manage/updateCorp' class="pe-public-top-nav-freeOrenter nav-top-upgrade">免费版升级</a>-->
    <#--</#if>-->
    <#--<#if ((isShow)! != ""&&(isShow)! == 'TRUE')>-->
         <#--<a href='/pe/front/manage/updateCorp' class="pe-public-top-nav-freeOrenter nav-top-renew">续费-->
             <#--<span class="nav-top-renew-time">${(corpInfo.endTime?string("yyyy年MM月dd日"))!}即将到期</span>-->
         <#--</a>-->
    <#--</#if>-->
    <#--&lt;#&ndash;nav-top-renew&ndash;&gt;-->
<#--</div>-->
<#--<ul class="pe-classify-sub-nav">-->
<#--<li class="sub-nav-items"><a data-type="result" data-url="17" href="javascript:;" class="sub-nav-link">试题管理</a></li>-->
<#--<li class="sub-nav-items"><a data-type="result" data-url="18" href="javascript:;" class="sub-nav-link">题库管理234</a></li>-->
<#--<li class="sub-nav-items"><a data-type="result" data-url="19" href="javascript:;" class="sub-nav-link">点管234理</a></li>-->
<#--</ul>-->
<#--公用主题部分，包括面包屑导航及大的背景-->
<div class="pe-main-wrap">
    <div title="展开类别面板" class="category-show-btn iconfont icon-show-category"></div>
<#--&lt;#&ndash;面包屑提示及提示语区域&ndash;&gt;-->
<#--<div class="pe-break-nav-tip-container">-->
<#--<ul class="pe-break-nav-ul">-->
<#--<li class="pe-brak-nav-items">试题</li><li class="pe-brak-nav-items iconfont icon-bread-arrow">试题管理</li>-->
<#--</ul>-->
<#--</div>-->
<#--页面主题区域,用于包裹绝大部分的页面-->
    <section id="peMainPulickContent" class="pe-main-content">

    </section>
    <div class="pe-mask-listen"></div>
</div>

<#--公用部分尾部版权-->
<#--<footer class="pe-footer-wrap">-->
    <#--<div class="pe-footer-copyright">${(footExplain)!'Copyright &copy${.now?string("yyyy")} 青谷科技专业考试系统 All Rights Reserved 皖ICP备16015686号-2'}</div>-->
<#--</footer>-->
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/peEditor/pe_simple_editor.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/environment_check.js?_v=${(resourceVersion)!}"></script>
<script>
    $(function () {
//        PEMO.VIDEOPLAYER('http://vjs.zencdn.net/v/oceans.mp4');
//        PEMO.AUDIOPLAYER('http://localhost:8888/pe/web-static/proExam/js/plugins/media/11.mp3');
        PEBASE.publickHeader();
        $('.pe-login-out').on('click', function () {
            PEMO.DIALOG.confirmL({
                content: '您确定退出吗？',
                area: ['350px', '173px'],
                title: '提示',
                btn: ['取消', '确定'],
                btnAlign: 'c',
                skin: ' pe-layer-confirm pe-layer-has-tree login-out-dialog-layer',
                btn1: function () {
                    layer.closeAll();
                },
                 btn2: function () {
                location.href = pageContext.rootPath + '/client/logout';
                },
                success: function () {
                    PEBASE.peFormEvent('checkbox');
                }
            });
//            location.href = 'http://localhost:8888/pe/pages/ems/examResult/test12';
        });

        $(".pe-login-name-con").hover(function () {
            /*alert('test');*/
            $(".pe-login-sort").show();
            $('.login-name-con-arrow').addClass('icon-thin-arrow-up');
        });

        $('.stu-role').on('click', function () {
            location.href = '${ctx!}/front/initPage';
        });


        $(".pe-login-icon").mouseleave(function () {
            $(".pe-login-sort").hide();
            $('.login-name-con-arrow').removeClass('icon-thin-arrow-up');
        });
    });

    //兼容IE8的空console对象
    window.console = window.console || {
                log: $.noop,
                debug: $.noop,
                info: $.noop,
                warn: $.noop,
                exception: $.noop,
                assert: $.noop,
                dir: $.noop,
                dirxml: $.noop,
                trace: $.noop,
                group: $.noop,
                groupCollapsed: $.noop,
                groupEnd: $.noop,
                profile: $.noop,
                profileEnd: $.noop,
                count: $.noop,
                clear: $.noop,
                time: $.noop,
                timeEnd: $.noop,
                timeStamp: $.noop,
                table: $.noop,
                error: $.noop
            };
</script>
</body>
</html>