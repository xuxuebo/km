<aside class="y-aside y-aside-professional" id="YAside">
    <div class="y-aside__title">
        <span class="yfont-icon">&#xe650;</span><span class="txt">菜单</span>
    </div>
    <ul class="y-aside__menu">
        <li class="y-menu__item y-user y-user-tree">
            <a href="#user" class="y-menu__item__title y-aside__menu__item__title"
               style="position: absolute;padding:0;top: -28px;left: -12px;">
                <span class="yfont-icon">&#xe643;</span><span class="txt">用户管理</span>
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
    <div class="y-menu-item-title" onclick="selectProjectDetail('<%=data[i].id%>')">
        <%= data[i].name %>
    </div>
    <% }%>
</script>


<script>
    $(function () {
        $.ajax({
            url: pageContext.resourcePath + '/library/listLibrary?type=SPECIALTY_LIBRARY',
            dataType: 'json',
            success: function (result) {
                var tree = $('.y-user-tree');
                tree.append(_.template($("#tplYunManageList").html())({data: result}));
                var user = $(".y-user");
                var h = user.height() + 23;
                user.height(h);
                $(".y-menu-item-title").eq(0).addClass("y-menu-item-title-active");
                tree.delegate(".y-menu-item-title", "click", function () {
                    $(this).addClass("y-menu-item-title-active").siblings().removeClass("y-menu-item-title-active");
                });
                var $yContainer = $('.y-content');
                $yContainer.load('/km/front/specialtyDetail?libraryId=' + result[0].id);
            }
        });
    })
    function selectProjectDetail(id) {
        var $yContainer = $('.y-content');
        $yContainer.load('/km/front/specialtyDetail?libraryId=' + id);
    }

</script>