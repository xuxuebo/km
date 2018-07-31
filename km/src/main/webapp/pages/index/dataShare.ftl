<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>分享</title>
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
            <li><a href="${ctx!}/km/front/dataStatistics" class="y-nav__link__item"><span class="txt">数据统计</span></a></li>
            <li><a href="${ctx!}/km/front/majorProject" class="y-nav__link__item"><span class="txt">重点项目</span></a></li>
            <li><a href="${ctx!}/km/front/majorProject" class="y-nav__link__item active"><span class="txt">分享</span></a></li>
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
        <ul id="orgTreeAndUsers" class="ztree pe-tree-container"></ul>
    </aside>
    <section class="y-content">
        <div class="y-major-project">
            <span class="y-major-project-header">张主任</span>
            <div class="y-share-project-content">
                <div class="y-share-project-type">
                    <dl class="y-share-project-type-list js-major">
                        <dt>专业:</dt>
                        <dd>
                            <span class="y-share-project-type-item" data-typeid = '0'>全部</span>
                            <span class="y-share-project-type-item y-active" data-typeid = '1'>继电保护</span>
                            <span class="y-share-project-type-item" data-typeid = '2'>输电线路</span>
                            <span class="y-share-project-type-item" data-typeid = '3'>配电线路</span>
                            <span class="y-share-project-type-item" data-typeid = '4'>变电运行</span>
                            <span class="y-share-project-type-item" data-typeid = '5'>变电检修</span>
                            <span class="y-share-project-type-item" data-typeid = '6'>营销专业</span>
                        </dd>
                    </dl>
                    <dl class="y-share-project-type-list js-project">
                        <dt>项目:</dt>
                        <dd>
                            <span class="y-share-project-type-item" data-typeid = '7'>全部</span>
                            <span class="y-share-project-type-item y-active" data-typeid = '8'>UPFC</span>
                            <span class="y-share-project-type-item" data-typeid = '9'>微网路由</span>
                            <span class="y-share-project-type-item" data-typeid = '10'>高温相变光热</span>
                        </dd>
                    </dl>
                    <dl class="y-share-project-type-list js-label">
                        <dt>标签:</dt>
                        <dd>
                            <span class="y-share-project-type-item" data-typeid = '11'>全部</span>
                            <span class="y-share-project-type-item y-active" data-typeid = '12'>图片</span>
                            <span class="y-share-project-type-item" data-typeid = '13'>视频</span>
                            <span class="y-share-project-type-item" data-typeid = '14'>其他</span>
                        </dd>
                    </dl>
                </div>
                <div class="y-content__opt__bar">
                    <div class="y-share-bar">
                        <button class="y-btn y-btn__blue" id="filePicker" type="button">分享</button>
                        <ul class="js-share-list">
                            <li class="js-share-local">从本地分享</li>
                            <li class="js-share-y">从云库分享</li>
                        </ul>
                    </div>
                    <button class="y-btn y-btn__green js-download" type="button">下载</button>
                    <button class="y-btn y-btn__orange js-copy" type="button">复制</button>
                    <div id="theList"></div>
                </div>
                <div class="y-share-table-main-panel">
                    <div class="y-content__table" id="shareTable">
                        <div class="pe-stand-table-pagination"></div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</section>
<#--表格模板-->
<script type="text/template" id="tplShareTable">
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
            <th class="y-table__td user-name">
                <span class="">分享人</span>
            </th>
            <th class="y-table__td size">
                <span class="">大小</span>
            </th>
            <th class="y-table__td create-time">
                <span class="">上传时间</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <%if(list.length !== 0){%>
        <%_.each(list,function(item,i){%>
        <tr class="y-table__tr js-opt-dbclick" data-shareid="<%=item.shareId%>" data-fileid = "<%=item.fileId%>" data-folder = "<%=item.folder%>" data-id="<%=item.id%>">
            <td class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </td>
            <td class="y-table__td name">
                <div class="y-table__opt__bar">
                    <button type="button" title="点击下载" data-id="<%=item.id%>" class="yfont-icon opt-item js-opt-download">&#xe64f;</button>
                    <button type="button" title="分享" data-id="<%=item.id%>" class="yfont-icon opt-item js-opt-share">&#xe652;</button>
                    <button type="button" title="删除" data-id="<%=item.id%>" class="yfont-icon opt-item js-opt-delete">&#xe65c;</button>
                </div>
                <div class="y-table__filed_name type-<%=item.knowledgeType%>">
                    <%=item.knowledgeName%>
                </div>
            </td>
            <td class="y-table__td user-name">
                <%=item.knowledgeUserName%>
            </td>
            <td class="y-table__td size">
                <%=item.knowledgeSize%>
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
<#--分享至公共库-->
<script type="text/template" id="shareToPublic">
    <input name="shareLibraryId" type="hidden">
    <div class="pe-select-tree-wrap pe-input-tree-wrap-drop">
        <ul id="editOrgTree" class="ztree pe-tree-container"></ul>
    </div>
</script>
<script src="${resourcePath!}/web-static/proExam/index/js/share.js"></script>
</body>
</html>