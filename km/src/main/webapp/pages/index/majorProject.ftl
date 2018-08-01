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
        <div class="y-major-project" id="yunLContentBody">

        </div>
    </section>
</section>

<script type="text/template" id="YunTable">
        <div class="y-major-project-header">高温变相光热</div>
        <div class="y-major-project-content">
            <div class="y-project-contribution-list">
                <div class="y-contribution-info">贡献榜单</div>
                <div class="y-contribution">
                    <ul>
                        <li>
                            <div class="y-contribution-icon_first"></div>
                            <div class="y-contribution-img">
                                <img class="y-contribution-person-img"
                                     src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
                            </div>
                            <div class="y-contribution-name">张恒恒</div>
                            <div class="y-contribution-position">人力资源部</div>
                            <div class="y-contribution-person-number">50000份</div>
                        </li>
                        <li>
                            <div class="y-contribution-icon_second"></div>
                            <div class="y-contribution-img">
                                <img class="y-contribution-person-img"
                                     src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
                            </div>
                            <div class="y-contribution-name">张恒恒</div>
                            <div class="y-contribution-position">人力资源部</div>
                            <div class="y-contribution-person-number">50000份</div>
                        </li>
                        <li>
                            <div class="y-contribution-icon_third"></div>
                            <div class="y-contribution-img">
                                <img class="y-contribution-person-img"
                                     src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
                            </div>
                            <span class="y-contribution-name">张恒恒</span>
                            <span class="y-contribution-position">人力资源部</span>
                            <span class="y-contribution-person-number">50000份</span>
                        </li>
                        <li>
                            <div class="y-contribution-icon_forth"></div>
                            <div class="y-contribution-img">
                                <img class="y-contribution-person-img"
                                     src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
                            </div>
                            <div class="y-contribution-name">张恒恒</div>
                            <div class="y-contribution-position">人力资源部</div>
                            <div class="y-contribution-person-number">50000份</div>
                        </li>
                        <li>
                            <div class="y-contribution-icon_fifth"></div>
                            <div class="y-contribution-img">
                                <img class="y-contribution-person-img"
                                     src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
                            </div>
                            <div class="y-contribution-name">张恒恒</div>
                            <div class="y-contribution-position">人力资源部</div>
                            <div class="y-contribution-person-number">50000份</div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="y-project-content-up">
                <div class="y-project-desc">
                    <div class="y-project-info">项目介绍</div>
                    <div class="y-project-introduction">
                        <img class="y-project-img"
                             src="${resourcePath!}/web-static/proExam/index/img/ico_rar.png" alt="">
                        <div class="y-project-introduction-content">
                            <div class="y-project-content-title">高温变相光热</div>
                            <div class="y-project-content-author">项目负责人：宁远 张国元 丁敏</div>
                            <div class="y-introduction-content">保持公认的可爱、智慧、有气质的特征，修炼出做事脚踏实地、耐受力强、处处小心谨慎的优点，保持公认的可爱、智慧、有气质的特征，修炼出做事脚踏实地、耐受力强、处处小心谨慎的优点,保持公认的可爱、智慧、有气质的特征，修炼出做事脚踏实地、耐受力强、处处小心谨慎的优点保持公认的可爱、智慧、有气质的特征，修炼出做事脚踏实地、耐受力强、处处小心谨慎的优点暂时先用这三个优点来守护自己的有很高的智慧、酷爱和平、喜爱自由、丰富的幽默感、</div>
                            <div class="y-project-select-all">查看全文</div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="y-project-content-down">
                <div class="y-project-activity">
                    <div class="y-project-file-inline">
                        <div class="y-project-activity-info">云库动态</div>
                        <div class="y-project-activity-more">
                            <a href="#selectActivityMore">
                                查看更多
                            </a>
                        </div>
                    </div>
                    <div class="y-project-activity-list">
                        <ul>
                            <li>
                                <div class="y-project-activity-time">2018/08/12</div>
                                <div class="y-project-activity-name">刘丹上传了《人力资源管理办法条理人力资源管理办法条理人力资源管理办法条理人力资源管理办法条理》</div>
                            </li>
                            <li>
                                <div class="y-project-activity-time">2018/08/12</div>
                                <div class="y-project-activity-name">刘丹上传了《人力资源管理办法条理人力资源管理办法条理人力资源管理办法条理人力资源管理办法条理》</div>
                            </li>
                            <li>
                                <div class="y-project-activity-time">2018/08/12</div>
                                <div class="y-project-activity-name">刘丹上传了《人力资源管理办法条理人力资源管理办法条理人力资源管理办法条理人力资源管理办法条理》</div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="y-project-file">
                    <div class="y-project-file-inline">
                        <div class="y-project-file-info">项目文件</div>
                        <div class="y-project-file-more">
                            <a href="#selectFileMore">
                                查看更多
                            </a>
                        </div>
                    </div>
                    <div class="y-project-file-list">
                        <ul>
                            <li>
                                <img
                                        src="${resourcePath!}/web-static/proExam/index/img/ico_xlsx.png" alt="">
                                <span class="y-project-file-name">高温变相储热铝合金的研究现状与展望高温变相储热铝合金的研究现状与展望高温变相储热铝合金的研究现状与展望</span>
                                <span class="y-project-file-author-name">高晓松</span>
                                <span class="y-project-file-time">2018/5/5</span>
                            </li>
                            <li>
                                <img
                                        src="${resourcePath!}/web-static/proExam/index/img/ico_xlsx.png" alt="">
                                <span class="y-project-file-name">高温变相储热铝合金的研究现状与展望</span>
                                <span class="y-project-file-author-name">高晓松</span>
                                <span class="y-project-file-time">2018/5/5</span>
                            </li>
                            <li>
                                <img
                                        src="${resourcePath!}/web-static/proExam/index/img/ico_xlsx.png" alt="">
                                <span class="y-project-file-name">高温变相储热铝合金的研究现状与展望高温变相储热铝合金的研究现状与展望</span>
                                <span class="y-project-file-author-name">高晓松</span>
                                <span class="y-project-file-time">2018/5/5</span>
                            </li>
                            <li>
                                <img
                                        src="${resourcePath!}/web-static/proExam/index/img/ico_xlsx.png" alt="">
                                <span class="y-project-file-name">高温变相储热铝合金的研究现状与展望高温变相储热铝合金的研究现状与展望</span>
                                <span class="y-project-file-author-name">高晓松</span>
                                <span class="y-project-file-time">2018/5/5</span>
                            </li>
                            <li>
                                <img
                                        src="${resourcePath!}/web-static/proExam/index/img/ico_xlsx.png" alt="">
                                <span class="y-project-file-name">高温变相储热铝合金的研究现状与展望高温变相储热铝合金的研究现状与展望</span>
                                <span class="y-project-file-author-name">高晓松</span>
                                <span class="y-project-file-time">2018/5/5</span>
                            </li>
                            <li>
                                <img
                                        src="${resourcePath!}/web-static/proExam/index/img/ico_xlsx.png" alt="">
                                <span class="y-project-file-name">高温变相储热铝合金的研究现状与展望高温变相储热铝合金的研究现状与展望</span>
                                <span class="y-project-file-author-name">高晓松</span>
                                <span class="y-project-file-time">2018/5/5</span>
                            </li>
                            <li>
                                <img
                                        src="${resourcePath!}/web-static/proExam/index/img/ico_xlsx.png" alt="">
                                <span class="y-project-file-name">高温变相储热铝合金的研究现状与展望高温变相储热铝合金的研究现状与展望</span>
                                <span class="y-project-file-author-name">高晓松</span>
                                <span class="y-project-file-time">2018/5/5</span>
                            </li>
                            <li>
                                <img
                                        src="${resourcePath!}/web-static/proExam/index/img/ico_xlsx.png" alt="">
                                <span class="y-project-file-name">高温变相储热铝合金的研究现状与展望高温变相储热铝合金的研究现状与展望高温变相储热铝合金的研究现状与展望</span>
                                <span class="y-project-file-author-name">高晓松</span>
                                <span class="y-project-file-time">2018/5/5</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
</script>
<#--文件查看更多-->
<script type="text/template" id="tplFileTable">
    <table class="y-table">
        <thead class="y-table__header">
        <tr>
            <th class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </th>
            <th class="y-table__td name">
                <span class="">文件名</span>
            </th>
            <th class="y-table__td size">
                <span class="">用户名</span>
            </th>
            <th class="y-table__td create-time">
                <span class="">创建时间</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <%if(list.length !== 0){%>
        <%_.each(list,function(item,i){%>
        <tr class="y-table__tr" data-id="<%=item.id%>">
            <td class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </td>
            <td class="y-table__td name">
                <div class="y-table__opt__bar">
                </div>
                <div class="y-table__filed_name type-<%=item.knowledgeType%>">
                    <%=item.knowledgeName%>
                </div>
            </td>
            <td class="y-table__td size">
                <%=item.userName%>
            </td>
            <td class="y-table__td upload-time">
                <%=item.createTimeStr%>
            </td>
        </tr>
        <%})}%>
        </tbody>
    </table>
    <%if(list.length === 0){%>
    <div class="table__none">--暂无数据--</div>
    <%}%>
</script>
<#--文件查看更多-->
<script type="text/template" id="fileAllList">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__table" id="fileTable">
    </div>
</script>
<#--云库查看更多-->
<script type="text/template" id="tplActivityTable">
    <table class="y-table">
        <thead class="y-table__header">
        <tr>
            <th class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </th>
            <th class="y-table__td name">
                <span class="">文件名</span>
            </th>
            <th class="y-table__td size">
                <span class="">用户名</span>
            </th>
            <th class="y-table__td create-time">
                <span class="">创建时间</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <%if(list.length !== 0){%>
        <%_.each(list,function(item,i){%>
        <tr class="y-table__tr" data-id="<%=item.id%>">
            <td class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </td>
            <td class="y-table__td name">
                <div class="y-table__opt__bar">
                </div>
                <div class="y-table__filed_name type-<%=item.knowledgeType%>">
                    <%=item.knowledgeName%>
                </div>
            </td>
            <td class="y-table__td size">
                <%=item.userName%>
            </td>
            <td class="y-table__td upload-time">
                <%=item.createTimeStr%>
            </td>
        </tr>
        <%})}%>
        </tbody>
    </table>
    <%if(list.length === 0){%>
    <div class="table__none">--暂无数据--</div>
    <%}%>
</script>

<script type="text/template" id="yunActivityAllList">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__table" id="yunActivityTable">
    </div>
</script>
<script>
    // 初始化页面
    $(function() {
        var $yunLContentBody = $("#yunLContentBody"),
            $YunTable = $("#YunTable");
        var html = _.template($YunTable.html())();
        $yunLContentBody.html(html);
    })
</script>
<script src="${resourcePath!}/web-static/proExam/index/js/index.js"></script>
</body>
</html>