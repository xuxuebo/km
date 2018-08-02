<aside class="y-aside y-aside-professional" id="YAside">
    <div class="y-aside__title">
        <span class="yfont-icon">&#xe650;</span><span class="txt">菜单</span>
    </div>
    <ul class="y-aside__menu">
        <li class="y-menu__item y-user y-user-tree">
            <a href="#user" class="y-menu__item__title y-aside__menu__item__title" style="position: absolute;padding:0;top: -28px;left: -12px;">
                <span class="yfont-icon">&#xe643;</span><span class="txt">用户管理</span>
            </a>
        </li>
    </ul>
</aside>
<div class="y-content">
    <div class="y-content-body" id="yunContentBody">
        <h4 class="y-content__title">配电线路</h4>
        <div class="y-content-professional">
            <div class="y-content-professional-file-box">
                <div class="y-content-professional-file">
                    <div class="y-content-professional-wrap">
                        <span class="y-content-professional-title">文件</span>
                        <span class="y-content-professional-more">查看更多</span>
                    </div>
                    <ul class="y-content-professional-file-list"></ul>
                </div>
                <div class="y-content-professional-rank">
                    <div class="y-content-professional-wrap">
                        <span class="y-content-professional-title">贡献榜单</span>
                    </div>
                    <ul class="y-content-professional-rank-list"></ul>
                </div>
            </div>
            <div class="y-content-professional-dynamic">
                <div class="y-content-professional-wrap">
                    <span class="y-content-professional-title">动态</span>
                    <span class="y-content-professional-more">查看更多</span>
                </div>
                <ul class="y-content-professional-dynamic-list"></ul>
            </div>
        </div>
    </div>
    <footer class="y-footer footer-bar">
        国家电网江苏省电力公司 ©苏ICP备15007035号-1
    </footer>
</div>
<script type="text/template" id="tplYunManageList">
    <% for(var i=0;i< 8;i++) {%>
        <div class="y-menu-item-title">
            继电保护
        </div>
    <% }%>
</script>
<script type="text/template" id="tplYunFileList">
    <% for(var i=0;i< 8;i++) {%>
        <li class="y-content-professional-file-list-item">
            <div class="y-content-professional-file-list-item-title-info">
                <div class="y-content-professional-file-list-item-name">高晓松阿萨德阿萨德</div>
                <div class="y-content-professional-file-list-item-time">2015/05/02</div>
                <div style="clear: both"></div>
            </div>
            <div class="y-content-professional-file-list-item-title"><i class="y-content-professional-file-list-item-icon"></i>高温相变储热铝合金材料的研究现状及展望.docx</div>
        </li>
    <% }%>
</script>
<script type="text/template" id="tplYunRankList">
    <% for(var i=0;i< 5;i++) {%>
        <li class="y-content-professional-rank-list-item">
            <div class="y-content-professional-rank-list-item-rank"><i class="y-content-professional-rank-list-item-rank-pic"></i></div>
            <div class="y-content-professional-rank-list-item-name"><i class="y-content-professional-rank-list-item-name-avatar"></i>夏雨</div>
            <div class="y-content-professional-rank-list-item-department">人力资源部</div>
            <div class="y-content-professional-rank-list-item-grade">500,00份</div>
        </li>
    <% }%>
</script>
<script type="text/template" id="tplYunDynamicList">
    <% for(var i=0;i< 9;i++) {%>
    <li class="y-content-professional-dynamic-list-item">
        <div class="y-content-professional-dynamic-list-item-doc">刘云上传了《中国人力资源产业园区发展现状及投资策略建议报告》</div>
        <div class="y-content-professional-dynamic-list-item-time">2018/05/04</div>
    </li>
    <% }%>
</script>
<script>
    $(function () {
        $(".y-user-tree").append(_.template($("#tplYunManageList").html()))
        var h=$(".y-user").height()+23;
        $(".y-user").height(h);
        $(".y-content-professional-file-list").html(_.template($("#tplYunFileList").html()));
        $(".y-content-professional-rank-list").html(_.template($("#tplYunRankList").html()));
        $(".y-content-professional-dynamic-list").html(_.template($("#tplYunDynamicList").html()));
        $(".y-menu-item-title").eq(0).addClass("y-menu-item-title-active");
        $(".y-user-tree").delegate(".y-menu-item-title","click",function(){
            $(this).addClass("y-menu-item-title-active").siblings().removeClass("y-menu-item-title-active");
        })
    })
</script>