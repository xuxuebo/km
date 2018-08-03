<aside class="y-aside" id="YAside">
    <div class="y-aside__title">
        <span class="yfont-icon">&#xe650;</span><span class="txt">菜单</span>
    </div>
    <#--<div class="y-aside__title">-->
        <#--<span class="yfont-icon">&#xe643;</span><span class="txt">重点项目</span>-->
        <#--<ul id="majorProjectTree" class="major-project-tree">-->

        <#--</ul>-->
    <#--</div>-->
    <ul class="y-aside__menu">
        <li class="y-menu__item y-user y-user-tree">
            <a href="#user" class="y-menu__item__title y-aside__menu__item__title" style="position: absolute;padding:0;top: -28px;left: -12px;">
                <span class="yfont-icon iconfont">&#xe72e;</span><span class="txt">重点项目</span>
            </a>
        </li>
    </ul>
</aside>
<section class="y-content">
    <div class="y-content-body" id="yunLContentBody">

    </div>
</section>
<script type="text/template" id="tplYunManageList">
    <% for(var i=0;i< data.length;i++) {%>
    <div class="y-menu-item-title" onclick="selectProjectDetail()">
        <%= data[i].name %>
    </div>
    <% }%>
</script>


<script src="${resourcePath!}/web-static/proExam/index/js/majorProject.js"></script>