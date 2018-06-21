<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>设置</title>
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
        <a href="${ctx!}/km/front/index" class="y-logo"></a>
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
            <li><a href="${ctx!}/km/front/index" class="y-nav__link__item "><span class="txt">云库</span></a></li>
            <li><a href="${ctx!}/km/front/dataView" class="y-nav__link__item"><span class="txt">数据</span></a></li>
        <#if admin?? && admin>
            <li><a href="${ctx!}/km/front/adminSetting" class="y-nav__link__item active"><span class="txt">设置</span></a></li>
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
            <li class="y-menu__item y-user">
                <a href="#user" class="y-menu__item__title y-aside__menu__item__title">
                    <span class="yfont-icon">&#xe643;</span><span class="txt">用户管理</span>
                </a>
            </li>
            <li class="y-menu__item y-organize">
                <a href="#organize" class="y-menu__item__title y-aside__menu__item__title">
                    <span class="yfont-icon">&#xe643;</span><span class="txt">部门管理</span>
                </a>
            </li>
            <li class="y-menu__item y-role">
                <a href="#role" class="y-menu__item__title y-aside__menu__item__title">
                    <span class="yfont-icon">&#xe643;</span><span class="txt">角色管理</span>
                </a>
            </li>
            <li class="y-menu__item y-position">
                <a href="#position" class="y-menu__item__title y-aside__menu__item__title">
                    <span class="yfont-icon">&#xe643;</span><span class="txt">岗位管理</span>
                </a>
            </li>
            <li class="y-menu__item y-label">
                <a href="#label" class="y-menu__item__title y-aside__menu__item__title">
                    <span class="yfont-icon">&#xe643;</span><span class="txt">标签管理</span>
                </a>
            </li>
        </ul>
    </aside>
    <section class="y-content">
        <div class="y-content-body" id="yunContentBody">
        </div>
        <footer class="y-footer">
            国家电网江苏省电力公司 ©苏ICP备15007035号-1
        </footer>
    </section>
</section>
<script type="text/template" id="tblUserTable">
    <table class="y-table">
        <thead class="y-table__header">
        <tr>
            <th class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </th>
            <th class="y-table__td userName">
                <span class="sorts">姓名</span>
            </th>
            <th class="y-table__td loginName">
                <span class="sorts">用户名</span>
            </th>
            <th class="y-table__td employeeCode">
                <span class="sorts">工号</span>
            </th>
            <th class="y-table__td mobile">
                <span class="sorts">手机号码</span>
            </th>
            <th class="y-table__td corpInfo">
                <span class="sorts">分公司/中心</span>
            </th>
            <th class="y-table__td organize">
                <span class="sorts">部门</span>
            </th>
            <th class="y-table__td status">
                <span class="sorts">状态</span>
            </th>
            <th class="y-table__td opt">
                <span class="sorts">操作</span>
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
            <td class="y-table__td userName">
                    <%=item.userName%>
            </td>
            <td class="y-table__td loginName">
                <%=item.loginName%>
            </td>
            <td class="y-table__td employeeCode">
                <%=item.employeeCode%>
            </td>
            <td class="y-table__td mobile">
                <%=item.mobile%>
            </td>
            <td class="y-table__td corpInfo">
                <%=item.corpInfo%>
            </td>
            <td class="y-table__td organize">
                <%=item.organize%>
            </td>
            <td class="y-table__td status">
                <%=item.status%>
            </td>
            <td class="y-table__td opt">
                <%=item.opt%>
            </td>
        </tr>
        <%})%>
        </tbody>
    </table>
</script>
<script type="text/template" id="tplUser">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
            <button class="y-btn y-btn__blue js-addUser" type="button">新增</button>
            <button class="y-btn y-btn__green js-import" type="button">导入</button>
            <button class="y-btn y-btn__orange js-frozen" type="button">冻结</button>
            <button class="y-btn y-btn__blue js-activation" type="button">激活</button>
            <button class="y-btn y-btn__green js-resetPwd" type="button">重置密码</button>
            <button class="y-btn y-btn__orange js-export" type="button">导出</button>
    </div>
    <div class="y-content__table" id="userTable">
    </div>
</script>
<script type="text/template" id="tplOrganize">
    <h4 class="y-content__title"><%=title%></h4>

    <div class="y-content__table" id="organizeTable"></div>
</script>
<script type="text/template" id="tplRole">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-addRole" type="button">新增角色</button>
    </div>
    <div class="y-content__table" id="roleTable"></div>
</script>

<script type="text/template" id="tplPosition">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__table" id="positionTable"></div>
</script>


<script type="text/template" id="tplLabel">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-addLabel" type="button">新增标签</button>
    </div>
    <div class="y-content__table" id="labelTable"></div>
</script>

<script src="${resourcePath!}/web-static/proExam/index/js/settingIndex.js"></script>
</body>
</html>