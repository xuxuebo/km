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
        <#--<li class="y-menu__item y-role">-->
            <#--<a href="#role" class="y-menu__item__title y-aside__menu__item__title">-->
                <#--<span class="yfont-icon">&#xe643;</span><span class="txt">角色管理</span>-->
            <#--</a>-->
        <#--</li>-->
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
        <li class="y-menu__item y-library">
            <a href="#library" class="y-menu__item__title y-aside__menu__item__title">
                <span class="yfont-icon">&#xe643;</span><span class="txt">公共库管理</span>
            </a>
        </li>
        <li class="y-menu__item y-project">
            <a href="#project" class="y-menu__item__title y-aside__menu__item__title">
                <span class="yfont-icon">&#xe643;</span><span class="txt">重点项目管理</span>
            </a>
        </li>
        <li class="y-menu__item y-specialty">
            <a href="#specialty" class="y-menu__item__title y-aside__menu__item__title">
                <span class="yfont-icon">&#xe643;</span><span class="txt">专业分类管理</span>
            </a>
        </li>
        <li class="y-menu__item y-score">
            <a href="#score" class="y-menu__item__title y-aside__menu__item__title">
                <span class="yfont-icon">&#xe643;</span><span class="txt">积分管理</span>
            </a>
        </li>
    </ul>
</aside>
<div class="y-content">
    <div class="y-content-body" id="yunContentBody" style="overflow: hidden;height: 100%;">
    </div>
    <#--<footer class="y-footer">-->
        <#--国家电网江苏省电力公司 ©苏ICP备15007035号-1-->
    <#--</footer>-->
</div>
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

<script type="text/template" id="tplLibrary">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-addLibrary" type="button">新增公共库</button>
    </div>
    <div class="y-content__table" id="libraryTable"></div>
</script>

<script type="text/template" id="tplProject">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-addProject" type="button">新增重点项目</button>
    </div>
    <div class="y-content__table" id="projectTable"></div>
</script>

<script type="text/template" id="tplSpecialty">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-addSpecialty" type="button">新增专业分类</button>
    </div>
    <div class="y-content__table" id="specialtyTable"></div>
</script>

<script type="text/template" id="tplScore">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-addScore" type="button">积分规则</button>
    </div>
    <div class="y-content__table" id="scoreTable"></div>
</script>

<script src="${resourcePath!}/web-static/proExam/index/js/settingIndex.js"></script>