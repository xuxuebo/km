<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>首页</title>

    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/layer.css">
    <link rel="stylesheet"
          href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}"
          type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}"
          type="text/css"/>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pe-common.css?_v=${(resourceVersion)!}"
          type="text/css">
    <link rel="stylesheet" href="//at.alicdn.com/t/font_700396_49emqhcpus8.css" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/index/css/index.css">
    <script>
        var pageContext = {
            resourcePath: '${resourcePath!}',
            rootPath: '${ctx!}'
        };
    </script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/jquery.min.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/webuploader.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/underscore-min.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js?_v=${(resourceVersion)!}"></script>
    <script src="${resourcePath!}/web-static/proExam/index/js/upload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.core.js?_v=0.1"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.excheck.js?_v=0.1"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.exedit.js?_v=0.1"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.mCustomScrollbar.concat.min.js?_v=0.1"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/echarts-4.1.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/require.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/common.js"></script>
    <style type="text/css">
        .y-content__opt__bar .webuploader-container .webuploader-pick {
            background-color: transparent
        }
    </style>
</head>
<body class="y-body">
<input id="downloadServerUrl" value="${downloadServerUrl!}" type="hidden">
<input id="corpCode" value="${corpCode!}" type="hidden">
<input id="fsServerHost" value="${fsServerHost!}" type="hidden">
<input type="hidden" value="${myLibrary!}" id="myLibrary"/>
<header class="y-head">
    <div class="y-logo__wrap">
        <a href="${ctx!}/km/front/index" class="y-logo"></a>
    </div>
    <div class="y-head__right">
        <form class="y-head__searcher" name="searchForm" action="javascript:void(0);">
            <label><input type="text" class="y-nav__search__input" id="searchKeyword" placeholder="搜索文件"/></label>
            <button type="submit" class="y-nav__search__btn" id="searchBtn"><span class="yfont-icon">&#xe658;</span>
            </button>
        </form>
        <div class="y-header-user">
            <i class="icon-tuichu">
                <img class="icon-tuichu-pic" src="${(resourcePath+logoUrl)!'${resourcePath!}/web-static/proExam/index/img/icon-exist.png'}" onclick="YUN.loginOut();"/>
            </i>
            <span class="y-header-user-name">按时间快点哈就</span>
        </div>
        <#--<div class="y-head__msg">-->
            <#--<span class="yfont-icon">&#xe654;</span>-->
            <#--<i class="has-msg"></i>-->
        <#--</div>-->
        <#--<div class="y-head__help">-->
            <#--<span class="yfont-icon">&#xe64d;</span>-->
        <#--</div>-->
        <#--<div title="点击退出" onclick="YUN.loginOut();">-->
            <#--<div class="y-head__avatar">-->
                <#--<img src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">-->
            <#--</div>-->
            <#--<div class="y-head__username">-->
                <#--阿达阿萨德-->
            <#--</div>-->
        <#--</div>-->
    </div>
    <nav class="y-nav">
        <ul class="y-nav__link">
            <li data-type="index" class="y-nav__link__item active"><span class="txt">云库</span></li>
            <li data-type="dataShare" class="y-nav__link__item"><span class="txt">分享</span></li>
            <li data-type="majorProject" class="y-nav__link__item"><span class="txt">重点项目</span></li>
            <li data-type="professionalClassification" class="y-nav__link__item"><span class="txt">专业分类</span></li>
            <li data-type="dataStatistics" class="y-nav__link__item"><span class="txt">数据统计</span></li>
            <li data-type="publicLibrary" class="y-nav__link__item"><span class="txt">我的云库</span></li>
        <#--<#if admin?? && admin>-->
            <li data-type="adminSetting" class="y-nav__link__item"><span class="txt">设置</span></li>
        <#--</#if>-->

        </ul>
    </nav>
</header>
<section class="y-container">
