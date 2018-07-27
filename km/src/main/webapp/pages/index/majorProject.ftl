<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>重点项目</title>
<#--<link href="https://cdn.bootcss.com/layer/3.1.0/theme/default/layer.css" rel="stylesheet">-->
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/layer.css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css"/>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pe-common.css?_v=${(resourceVersion)!}" type="text/css">

    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/index/css/index.css">
    <script>
        var pageContext = {
            resourcePath:'${resourcePath!}',
            rootPath:'${ctx!}'
        };
    </script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/jquery.min.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/underscore-min.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js?_v=${(resourceVersion)!}"></script>
    <script src="${resourcePath!}/web-static/proExam/index/js/webuploader.js" type="text/javascript" charset="utf-8"></script>
    <script src="${resourcePath!}/web-static/proExam/index/js/upload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.core.js?_v=0.1"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.excheck.js?_v=0.1"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.exedit.js?_v=0.1"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.mCustomScrollbar.concat.min.js?_v=0.1"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js"></script>
    <style type="text/css">
        .y-content__opt__bar .webuploader-container .webuploader-pick{background-color: transparent}
    </style>
</head>
<body class="y-body">
<header class="y-head">
    <div class="y-logo__wrap">
        <a href="${ctx!}/km/front/index" class="y-logo"></a>
    </div>
    <div class="y-head__right">
        <form class="y-head__searcher" name="searchForm" action="javascript:void(0);">
            <label><input type="text" class="y-nav__search__input" id="searchKeyword" placeholder="搜索文件"/></label>
            <button type="submit" class="y-nav__search__btn" id="searchBtn"><span class="yfont-icon">&#xe658;</span></button>
        </form>
        <div class="y-head__msg">
            <span class="yfont-icon">&#xe654;</span>
            <i class="has-msg"></i>
        </div>
        <div class="y-head__help">
            <span class="yfont-icon">&#xe64d;</span>
        </div>
        <div class="y-head__user" title="点击退出" onclick="loginOut();">
            <div class="y-head__avatar">
                <img src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
            </div>
            <div class="y-head__username">
            ${userName!}
            </div>
        </div>
    </div>
    <nav class="y-nav">
        <ul class="y-nav__link">
            <li><a href="${ctx!}/km/front/index" class="y-nav__link__item"><span class="txt">云库</span></a></li>
        <#--<li><a href="${ctx!}/km/front/dataView" class="y-nav__link__item"><span class="txt">数据</span></a></li>-->
            <li><a href="${ctx!}/km/front/dataStatistics" class="y-nav__link__item"><span class="txt">数据统计</span></a></li>
            <li><a href="${ctx!}/km/front/majorProject" class="y-nav__link__item active"><span class="txt">重点项目</span></a></li>
        <#if admin?? && admin>
            <li><a href="${ctx!}/km/front/adminSetting" class="y-nav__link__item"><span class="txt">设置</span></a></li>
        </#if>

        </ul>
    </nav>
</header>
<section class="y-container">
    <aside class="y-aside" id="YAside">
        <div class="y-aside__title">
            <span class="yfont-icon">&#xe650;</span><span class="txt">菜单</span>
        </div>
        <ul class="y-aside__menu">
            <li class="y-menu__item my-yun">
                <a href="#yun" class="y-menu__item__title y-aside__menu__item__title">
                    <span class="yfont-icon">&#xe643;</span><span class="txt">重点项目</span>
                </a>
            </li>
        </ul>
    </aside>
    <section class="y-content">
        <div class="y-major-project">
            <span class="y-major-project-header">高温变相光热</span>
            <div class="y-major-project-content">
                <div class="y-project-content-up">
                    <div class="y-project-desc">
                        <div class="y-project-info">项目介绍</div>
                        <div class="y-project-introduction">
                            <div class="y-project-img">
                                <img class="s-person-img"
                                     src="${resourcePath!}/web-static/proExam/index/img/ico_rar.png" alt="">
                            </div>
                            <div class="y-project-introduction-content">
                                <div>高温变相光热</div>
                                <div>项目负责人：宁远 张国元 丁敏</div>
                                <div>查看全文</div>
                            </div>
                        </div>
                    </div>
                    <div class="y-project-contribution-list">
                        <div class="y-contribution-info">贡献榜单</div>
                        <div class="y-contribution"></div>
                    </div>
                </div>
                <div class="y-project-content-down">
                    <div class="y-project-file">
                        <div class="y-project-file-inline">
                            <div class="y-project-file-info">项目文件</div>
                            <div class="y-project-file-more">查看更多</div>
                        </div>
                        <div class="y-project-file-list"></div>
                    </div>
                    <div class="y-project-activity">
                        <div class="y-project-file-inline">
                            <div class="y-project-activity-info">云库动态</div>
                            <div class="y-project-activity-more">查看更多</div>
                        </div>
                        <div class="y-project-activity-list"></div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</section>


<script src="${resourcePath!}/web-static/proExam/index/js/index.js"></script>
</body>
</html>