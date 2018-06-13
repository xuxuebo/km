<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>数据</title>
    <link href="https://cdn.bootcss.com/layer/3.1.0/theme/default/layer.css" rel="stylesheet">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/index/css/index.css">
    <script src="${resourcePath!}/web-static/proExam/index/js/require.js"></script>
    <script type="text/javascript">
        requirejs.config({
            urlArgs: 'v=',
            baseUrl: '${resourcePath!}/web-static/proExam/index/js/',
            paths: {
                jquery: 'jquery.min',
                underscore: 'underscore-min',
                layer: 'layer'
            }
        });
    </script>
</head>
<body class="y-body">
<header class="y-head">
    <div class="y-logo__wrap">
        <a href="${ctx!}/cloud/front/index" class="y-logo"></a>
    </div>
    <div class="y-head__right">
        <form class="y-head__searcher" name="searchForm" action="javascript:void(0);">
            <label><input type="text" class="y-nav__search__input" placeholder="搜索文件"/></label>
            <button type="submit" class="y-nav__search__btn"><span class="yfont-icon">&#xe658;</span></button>
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
            <li><a href="${ctx!}/cloud/front/index" class="y-nav__link__item active"><span class="txt">云库</span></a></li>
            <li><a href="${ctx!}/cloud/front/dataView" class="y-nav__link__item"><span class="txt">数据</span></a></li>
        <#if admin?? && admin>
            <li><a href="${ctx!}/cloud/front/adminSetting" class="y-nav__link__item"><span class="txt">设置</span></a></li>
        </#if>

        </ul>
    </nav>
</header>
<section class="y-container">
    <aside class="y-aside" id="YAside">

    </aside>
    <section class="y-content">
        <div class="y-content-body" id="yunContentBody">
        </div>
        <footer class="y-footer">
            国家电网江苏省电力公司 ©苏ICP备15007035号-1
        </footer>
    </section>
</section>
<script type="text/template" id="tplTable">
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
                <span class="sort <%if(sort.name === 'desc'){%>desc<%}else{%>asc<%}%>">名称</span>
            </th>
            <th class="y-table__td size">
                <span class="sort  <%if(sort.size === 'desc'){%>desc<%}else{%>asc<%}%>">大小</span>
            </th>
            <th class="y-table__td upload-time">
                <span class="sort  <%if(sort.uploadTime === 'desc'){%>desc<%}else{%>asc<%}%>">上传时间</span>
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
                <div class="y-table__filed_name type-<%=item.fileType%>">
                    <%=item.fileName%>
                </div>
            </td>
            <td class="y-table__td size">
                <%=item.size%>
            </td>
            <td class="y-table__td upload-time">
                <%=item.time%>
            </td>
        </tr>
        <%})%>
        </tbody>
    </table>
</script>
<script type="text/template" id="tplYun">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-copy" type="button">复制到我的云库</button>
        <button class="y-btn y-btn__green js-download" type="button">下载</button>
        <button class="y-btn y-btn__orange js-del" type="button">删除</button>
    </div>
    <div class="y-content__table" id="yunTable">
    </div>
</script>
<script type="text/template" id="tplPublic">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue" type="button">复制到我的云库</button>
        <button class="y-btn y-btn__green" type="button">下载</button>
        <button class="y-btn y-btn__orange" type="button">删除</button>
    </div>
    <div class="y-content__table" id="publicTable">
    </div>
</script>
<script type="text/template" id="tplRecycle">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue" type="button">复制到我的云库</button>
        <button class="y-btn y-btn__green" type="button">下载</button>
        <button class="y-btn y-btn__orange" type="button">删除</button>
    </div>
    <div class="y-content__table" id="recycleTable">
    </div>
</script>
<script src="${resourcePath!}/web-static/proExam/index/js/index.js"></script>
</body>
</html>