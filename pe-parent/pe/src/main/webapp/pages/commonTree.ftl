<#--树状布局开始,可复用,记得调用下面的初始化函数;-->
<div class="pe-classify-wrap floatL">
    <div class="pe-classify-top over-flow-hide pe-form">
        <span class="floatL pe-classify-top-text">按类别筛选</span>
        <label class="floatL pe-checkbox" for="peFormEle5">
            <span class="iconfont icon-unchecked-checkbox"></span>
            <input id="peFormEle" class="pe-form-ele" checked="false" type="checkbox" name="" /><span class="include-subclass">包含子类</span>
        </label>
        <button  type="button" title="管理类别" class="floatR iconfont icon-set pe-control-tree-btn set-category-btn"></button>
    </div>
    <div class="pe-classify-tree-wrap">
        <div class="pe-tree-search-wrap">
        <#--复用时，保留下面的input单独classname 'pe-tree-form-text'-->
            <input class="pe-tree-form-text" type="text" placeholder="请输入题库名称">
        <#--<span class="pe-placeholder">请输入题库名称</span>--><#--备用,误删-->
            <span class="iconfont pe-tree-search-btn icon-search-magnifier"></span>
        </div>
        <div class="pe-tree-content-wrap">
            <div class="pe-tree-main-wrap">
                <div class="node-search-empty">暂无</div>
                <ul id="peZtreeMain" class="ztree pe-tree-container" data-type="km"></ul>
            </div>
        </div>
        <#--'管理类别',如果需要在显示,用freemark判断,或者直接不添加即可;-->
        <#--<div class="pe-control-tree-btn iconfont icon-set">管理类别</div>-->
    </div>
</div>
<#--树状布局 结束,可复用-->
<script>
    $(function(){
        var showUrl,addUrl,editUrl,removeUrl,moveUrl;
        //初始化树状功能；peZtreeMain为主要树的id
        PEMO.ZTREE.initTree('peZtreeMain',showUrl,addUrl,editUrl,removeUrl,moveUrl);
    });

</script>