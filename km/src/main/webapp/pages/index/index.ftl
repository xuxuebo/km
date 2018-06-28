<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>云库</title>
    <link href="https://cdn.bootcss.com/layer/3.1.0/theme/default/layer.css" rel="stylesheet">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css"/>

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
        <div class="y-head__user" title="${userName!}">
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
            <li><a href="${ctx!}/km/front/index" class="y-nav__link__item active"><span class="txt">云库</span></a></li>
            <li><a href="${ctx!}/km/front/dataView" class="y-nav__link__item"><span class="txt">数据</span></a></li>
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
                    <span class="yfont-icon">&#xe643;</span><span class="txt">我的云库</span>
                </a>
            </li>
            <li class="y-menu__item public-yun">
                <a href="javascript:void(0);" class="y-menu__item__title y-aside__menu__item__title has-arrow">
                    <span class="yfont-icon">&#xe656;</span><span class="txt">公共库</span>
                </a>
                <ul class="y-menu__sub">
                    <#list firstLevelLibrary as fl>
                        <li class="y-menu__item">
                            <a href="#public/${fl.id}/${fl.libraryName}" data-id="${fl.id}" class="y-menu__item__title">
                                <span class="txt" data-name="${fl.libraryName}">${fl.libraryName}</span>
                            </a>
                        </li>
                    </#list>
                </ul>
            </li>

            <li class="y-menu__item share-yun">
                <a href="#share" class="y-menu__item__title y-aside__menu__item__title">
                    <span class="yfont-icon">&#xe643;</span><span class="txt">我的分享</span>
                </a>
            </li>

            <li class="y-menu__item recycle-yun">
                <a href="#recycle" class="y-menu__item__title y-aside__menu__item__title">
                    <span class="yfont-icon">&#xe65c;</span><span class="txt">回收站</span>
                </a>
            </li>
        </ul>
    </aside>
    <section class="y-content">
        <div class="y-content-body" id="yunLContentBody">
        </div>
    <#--<footer class="y-footer">-->
    <#--国家电网江苏省电力公司 ©苏ICP备15007035号-1-->
    <#--</footer>-->
    </section>
</section>
<script type="text/template" id="tplYunTable">
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
                <span class="">大小</span>
            </th>
            <th class="y-table__td create-time">
                <span class="">上传时间</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <%_.each(list,function(item,i){%>
        <tr class="y-table__tr js-opt-dbclick" data-fileid = "<%=item.fileId%>" data-folder = "<%=item.folder%>" data-id="<%=item.id%>">
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
                    <button type="button" title="删除" data-id="<%=item.id%>" class="yfont-icon opt-item js-opt-delete">&#xe652;</button>
                </div>
                <div class="y-table__filed_name type-<%=item.knowledgeType%>">
                    <%=item.knowledgeName%>
                </div>
            </td>
            <td class="y-table__td size">
                <%=item.knowledgeSize%>
            </td>
            <td class="y-table__td upload-time">
                <%=item.createTimeStr%>
            </td>
        </tr>
        <%})%>
        </tbody>
    </table>
</script>

<script type="text/template" id="tplPublicTable">
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
                <span class="">大小</span>
            </th>
            <th class="y-table__td create-time">
                <span class="">上传时间</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <%_.each(list,function(item,i){%>
        <tr class="y-table__tr js-opt-dbclick" data-id="<%=item.id%>" data-fileid="<%=item.fileId%>">
            <td class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </td>
            <td class="y-table__td name">
                <div class="y-table__opt__bar">
                    <button type="button" title="点击下载" data-id="<%=item.id%>" class="yfont-icon opt-item js-opt-download">&#xe64f;</button>
                </div>
                <div class="y-table__filed_name type-<%=item.knowledgeType%>">
                    <%=item.knowledgeName%>
                </div>
            </td>
            <td class="y-table__td size">
                <%=item.knowledgeSize%>
            </td>
            <td class="y-table__td upload-time">
                <%=item.createTimeStr%>
            </td>
        </tr>
        <%})%>
        </tbody>
    </table>
</script>

<script type="text/template" id="tplRecycleTable">
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
                <span class="">大小</span>
            </th>
            <th class="y-table__td create-time">
                <span class="">删除时间</span>
            </th>
        </tr>
        </thead>
        <tbody>
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
                    <button type="button" class="yfont-icon opt-item js-opt-download">&#xe64f;</button>
                    <button type="button" class="yfont-icon opt-item js-opt-more">&#xe652;</button>
                </div>
                <div class="y-table__filed_name type-<%=item.knowledgeType%>">
                    <%=item.knowledgeName%>
                </div>
            </td>
            <td class="y-table__td size">
                <%=item.knowledgeSize%>
            </td>
            <td class="y-table__td upload-time">
                <%=item.createTimeStr%>
            </td>
        </tr>
        <%})%>
        </tbody>
    </table>
</script>


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
                <span class=" ">文件名</span>
            </th>
            <th class="y-table__td create-time">
                <span class="  ">分享时间</span>
            </th>
            <th class="y-table__td expire-time">
                <span class="  ">失效时间</span>
            </th>
            <th class="y-table__td view-count">
                <span class="  ">浏览次数</span>
            </th>
            <th class="y-table__td download-count">
                <span class=" ">复制次数</span>
            </th>
            <th class="y-table__td copy-count">
                <span class="  ">下载次数</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <%_.each(list,function(item,i){%>
        <tr class="y-table__tr" data-id="<%=item.id%>" data-shareid="<%=item.shareId%>">
            <td class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </td>
            <td class="y-table__td name">
                <div class="y-table__filed_name type-<%=item.knowledgeType%>">
                    <%=item.knowledgeName%>
                </div>
            </td>
            <td class="y-table__td create-time">
                <%=item.createTimeStr%>
            </td>
            <td class="y-table__td expire-time">
                <%=item.expireTime%>
            </td>
            <td class="y-table__td view-count">
                <%=item.viewCount%>
            </td>
            <td class="y-table__td download-count">
                <%=item.downloadCount%>
            </td>
            <td  class="y-table__td copy-count">
                <%=item.copyCount%>
            </td>
        </tr>
        <%})%>
        </tbody>
    </table>
</script>


<#--模板引擎-->

<#--我的云库-->
<script type="text/template" id="tplYun">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-upload" id="filePicker" type="button">上传</button>
        <button class="y-btn y-btn__green js-download" type="button">下载</button>
        <button class="y-btn y-btn__green js-share" type="button">分享至共享库</button>
        <button class="y-btn y-btn__orange js-newFolder" type="button">新建文件夹</button>
        <div id="theList"></div>
    </div>
    <#--表格包裹的div-->
    <div class="pe-stand-table-main-panel">
        <div class="y-content__table" id="yunTable">
            <div class="pe-stand-table-pagination"></div>
        </div>
    </div>
</script>

<#--分享至公共库-->
<script type="text/template" id="shareToPublic">
       <input name="shareLibraryId" type="hidden">
       <div class="pe-select-tree-wrap pe-input-tree-wrap-drop">
           <ul id="editOrgTree" class="ztree pe-tree-container"></ul>
       </div>
</script>


<script type="text/template" id="addNewFolder" >
    <div class="clearF">
            <div class="validate-form-cell" style="margin-left:80px;">
            <em class="error" style="display: none;"></em>
            </div>
            <label class="floatL">
            <span class="pe-label-name floatL">文件夹名称:</span>
    <input class="pe-table-form-text pe-stand-filter-form-input pe-km-tree-name" type="text" placeholder="请输入文件夹名称"
    name="libraryName" >
            </label>
            </div>

</script >


<#--公共库-->
<script type="text/template" id="tplPublic">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-opt-copy" type="button">复制到我的云库</button>
        <button class="y-btn y-btn__green js-download" type="button">下载</button>
    </div>
    <div class="y-content__table" id="publicTable">
    </div>
</script>

<#--我的分享-->
<script type="text/template" id="tplShare">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-cancelShare" type="button">取消分享</button>
    </div>
    <div class="y-content__table" id="shareTable">
    </div>
</script>

<script type="text/template" id="cancelShare" >
    <div class="clearF">
        <div class="validate-form-cell" style="">
            <em class="error" style="display: none;"></em>
        </div>
        <label class="floatL">
            <span style="margin-left:60px;" class="pe-label-name floatL">确定将选中的文件取消分享?</span>
        </label>
    </div>

</script>




<#--回收站-->
<script type="text/template" id="tplRecycle">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-reduction" type="button" >还原文件</button>
        <button class="y-btn y-btn__green js-emptyRecycle" type="button">清空回收站</button>
    </div>
    <div class="y-content__table" id="recycleTable">
    </div>
</script>

<script type="text/template" id="reduction" >
    <div class="clearF">
        <div class="validate-form-cell" style="margin-left:80px;">
            <em class="error" style="display: none;"></em>
        </div>
        <label class="floatL">
            <span class="pe-label-name floatL">确定还原选中的文件?</span>
        </label>
    </div>

</script>

<script type="text/template" id="emptyRecycle" >
    <div class="clearF">
        <div class="validate-form-cell" style="margin-left:80px;">
            <em class="error" style="display: none;"></em>
        </div>
        <label class="floatL">
            <span class="pe-label-name floatL">确定清空回收站?</span>
        </label>
    </div>

</script >


<script src="${resourcePath!}/web-static/proExam/index/js/index.js"></script>
</body>
</html>