
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
        <%if(list.length !== 0){%>
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
                    <button type="button" title="删除" data-id="<%=item.id%>" class="yfont-icon opt-item js-opt-delete">&#xe65c;</button>
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
        <%})}%>
        </tbody>
    </table>
    <%if(list.length === 0){%>
    <div class="table__none">--暂无数据--</div>
    <%}%>
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
        <%if(list.length !== 0){%>
        <%_.each(list,function(item,i){%>
        <tr class="y-table__tr js-opt-dbclick" data-shareid="<%=item.shareId%>" data-id="<%=item.id%>" data-fileid="<%=item.fileId%>">
            <td class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </td>
            <td class="y-table__td name">
                <div class="y-table__opt__bar">
                    <button type="button" title="点击下载" data-shareid="<%=item.shareId%>" data-id="<%=item.id%>" class="yfont-icon opt-item js-opt-download">&#xe64f;</button>
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
        <%})}%>
        </tbody>
    </table>
    <%if(list.length === 0){%>
    <div class="table__none">--暂无数据--</div>
    <%}%>
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
                    <#--<button type="button" class="yfont-icon opt-item js-opt-download">&#xe64f;</button>
                    <button type="button" class="yfont-icon opt-item js-opt-more">&#xe652;</button>-->
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
        <%})}%>
        </tbody>
    </table>
    <%if(list.length === 0){%>
    <div class="table__none">--暂无数据--</div>
    <%}%>
</script>


<script type="text/template" id="tplShareTable">
    <div>
        <table class="y-table">
            <thead class="y-table__header">
            <tr>
                <th class="y-table__td checkbox" style="width: 2%">
                    <label class="y-checkbox">
                        <input type="checkbox">
                        <span class="y-checkbox__span"></span>
                    </label>
                </th>
                <th class="y-table__td name" style="width: 25%">
                    <span class=" ">文件名</span>
                </th>
                <th class="y-table__td create-time" style="width: 8%">
                    <span class="  ">分享时间</span>
                </th>
                <th class="y-table__td size" style="width: 8%">
                    <span class="  ">大小</span>
                </th>
                <th class="y-table__td download-count" style="width: 8%">
                    <span class=" ">下载次数</span>
                </th>
                <th class="y-table__td copy-count" style="width: 8%">
                    <span class="  ">复制次数</span>
                </th>
            </tr>
            </thead>
            <tbody>
            <%if(list.length !== 0){%>
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
                        <span title="<%=item.knowledgeName%>"><%=item.knowledgeName%></span>
                    </div>
                </td>
                <td class="y-table__td create-time">
                    <%=item.createTimeStr%>
                </td>
                <td class="y-table__td size">
                    <%=item.knowledgeSize%>
                </td>
                <td class="y-table__td download-count">
                    <%=item.downloadCount%>
                </td>
                <td  class="y-table__td copy-count">
                    <%=item.copyCount%>
                </td>
            </tr>
            <%})}%>
            </tbody>
        </table>
        <%if(list.length === 0){%>
        <div class="table__none">--暂无数据--</div>
        <%}%>
    </div>

</script>


<#--模板引擎-->

<#--我的云库-->
<script type="text/template" id="tplYun">
    <h4 class="y-content__title"><%=title%></h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-upload" id="filePicker" type="button">上传</button>
        <button class="y-btn y-btn__green js-download" type="button">下载</button>
        <button class="y-btn y-btn__green js-share" type="button">分享至公共库</button>
        <button class="y-btn y-btn__orange js-newFolder" type="button">新建文件夹</button>
        <div id="theList"></div>
    </div>
    <#--表格包裹的div-->
    <ul class="y-bread-crumbs" id="breadCrumbs">
        <li>全部</li>
    </ul>

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
    <div class="pe-stand-table-main-panel">
        <div class="y-content__table" id="publicTable">
            <div class="pe-stand-table-pagination"></div>
        </div>
    </div>
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

<#--面包屑-->
<script  type="text/template" id="breadCrumbsTpl">
    <%_.each(list,function(item,i){%>
        <%if(list.length ==1){%>
        <li><span><%=item.title%></span></li>
        <%}else if(i==0){%>
        <li><a href="javascript:void(0);" data-id="<%=item.id%>"><%=item.title%></a></li>
        <%}else if(i===list.length-1){%>
        <li><span class="split">&gt;</span><span><%=item.title%></span></li>
        <%}else{%>
        <li><span class="split">&gt;</span><a href="javascript:void(0);" data-id="<%=item.id%>"><%=item.title%></a></li>
        <%}%>
    <%})%>
</script>


<#--<script src="${resourcePath!}/web-static/proExam/index/js/index.js"></script>-->
<script>
    $(function () {
        var $yunContentBody = $('#yunLContentBody');
        var $yAside = $('#YAside');
        //路由
        var publicId = "";
        var publicName = "";
        var breadCrumbsList = [{title: '全部', id: $("#myLibrary").val()}];
        var _breadCrumbsTpl = $("#breadCrumbsTpl").html();

        var route = {
            routes: {
                'yun': {
                    "templateId": '#tplYun',
                    nav: 'my-yun',
                    cb: "YunCb"
                },
                'public/': {
                    "templateId": '#tplPublic',
                    nav: 'public-yun',
                    cb: "publicCb"
                },
                'recycle': {
                    "templateId": '#tplRecycle',
                    nav: 'recycle-yun',
                    cb: "recycleCb"
                },
                "share": {
                    "templateId": '#tplShare',
                    nav: 'share-yun',
                    cb: "shareCb"
                }
            },
            YunCb: function (container, routeInfo, cb, id) {
                initYunPage(container, routeInfo, cb, id);
            },
            publicCb: function (container, routeInfo, cb) {
                breadCrumbsList.length =1;
                initPublicPage(container, routeInfo);
            },
            recycleCb: function (container, routeInfo, cb) {
                breadCrumbsList.length =1;
                initRecyclePage(container, routeInfo);
            },
            shareCb: function (container, routeInfo, cb) {
                breadCrumbsList.length =1;
                initSharePage(container, routeInfo);
            }
        };

        //初始化
        function changeHashCb(cb) {
            var _hash = location.hash.substring(1);
            if (!_hash) {
                location.hash = 'yun';
            }
            var hashArr = _hash.split("/");
            $yAside.find("li").removeClass('active');
            var routeInfo;
            if (hashArr.length > 1) {
                var subNav = hashArr[1];
                publicId = subNav;
                var subName = $yAside.find('a[data-id="' + subNav + '"]').children('span').data("name");
                publicName = subName;
                //元素同胞
                $yAside.find('a[data-id="' + subNav + '"]').parent().addClass('active').siblings().removeClass('active');

                //$('#yunLContentBody').html('<iframe style="width:100%;height: 100%;margin-left: -170px;" src="/km/front/manage/initPage#url=/km/knowledge/initPublicLibraryPage"></iframe>');
                //$('#yunLContentBody').html('<iframe style="width:100%;height: 100%;margin-left: -170px;" src="/km/front/manage/initPage#url=/km/knowledge/initPublicLibraryPage?libraryId='+publicId+'"></iframe>');
                for (var key in route.routes) {
                    if (new RegExp(key).test(_hash)) {
                        routeInfo = route.routes[key];
                        break;
                    }
                }
            } else {
                routeInfo = route.routes[hashArr[0]]
            }
            if (typeof routeInfo === "undefined") {
                console.warn('没有改路由信息');
                return;
            }
            /*定位菜单*/
            var $curNav = $yAside.find('.' + routeInfo.nav);
            if ($curNav.size() > 0) {
                $curNav.addClass('active').siblings().removeClass('active');
            }
            if (routeInfo.cb) {
                route[routeInfo.cb]($yunContentBody, routeInfo, cb);
                /* try {

                 } catch (e) {
                 console.error("没有此" + routeInfo.cb + "方法", e);
                 }*/
            }
        }

        //修改
        if (('onhashchange' in window) && ((typeof document.documentMode === 'undefined') || document.documentMode == 8)) {
            $(window).bind("hashchange", changeHashCb);
        }

        /*初始化*/
        changeHashCb();


        //初始化我的云库页面
        function initYunPage(container, routeInfo, cb, id) {
            var _tpl = $(routeInfo.templateId).html();
            container.html(_.template(_tpl)({title: '我的云库'}));
            //table渲染
            var _table = $("#tplYunTable").html();
            var $yunTable = $('#yunTable');
            var data = [];
            $.ajax({
                async: false,//此值要设置为FALSE  默认为TRUE 异步调用
                type: "POST",
                url: pageContext.resourcePath + '/knowledge/search',
                data: {'libraryId': id},
                dataType: 'json',
                success: function (result) {
                    data = result;
                }
            });
            for (var i = 0; i < data.length; i++) {
                data[i].knowledgeSize = conver(data[i].knowledgeSize);
            }
            var table, initSort = {
                name: "desc",
                size: "desc",
                uploadTime: "desc"
            };
            renderTable();
            function renderTable() {
                $yunTable.html(_.template(_table)({list: data, sort: initSort}));
                table = initTable($yunTable);
                $yunTable.find('.sort').click(function () {
                    $yunTable.html(_.template(_table)({
                        list: data, sort: $.extend({}, initSort, {name: 'asc'})
                    }));
                });
            }

            //渲染面包屑
            var $breadCrumbs = $('#breadCrumbs');
            $breadCrumbs.html(_.template(_breadCrumbsTpl)({list: breadCrumbsList}));
            $breadCrumbs.on("click", "a", function () {
                var $this = $(this);
                var id = $this.attr("data-id");
                var index = $this.parent().index();
                if (!id) {
                    return;
                }
                breadCrumbsList.length = index + 1;
                route['YunCb']($yunContentBody, route.routes.yun, null, id);
            });

            $('.js-upload').on('click', function () {
                PEMO.DIALOG.selectorDialog({
                    content: pageContext.rootPath + '/km/knowledge/openUpload',
                    area: ['600px', '400px'],
                    title: '上传文件',
                    btn1: function () {
                    },
                    btn2: function () {
                        layer.closeAll();
                    },
                    success: function (d, index) {
                        var iframeBody = layer.getChildFrame('body', index);
                        var hasPicSrc = $('.pe-user-head-edit-btn').find('img').attr('src');
                        if (hasPicSrc) {
                            $(iframeBody).find('.jcrop-preview').prop("src", hasPicSrc);
                        }
                    }
                });
            });

            $("#searchBtn").on('click', function () {
                var $searchKeyword = $("#searchKeyword");
                console.log($searchKeyword);

                var _keyword = $searchKeyword.val();
                console.log(_keyword);
                $.ajax({
                    async: false,//此值要设置为FALSE  默认为TRUE 异步调用
                    type: "POST",
                    url: pageContext.resourcePath + '/knowledge/fullTextSearch?keyword=' + _keyword,
                    dataType: 'json',
                    success: function (result) {
                        data = result;
                        for (var i = 0; i < data.length; i++) {
                            data[i].knowledgeSize = conver(data[i].knowledgeSize);
                        }
                    }
                });

                renderTable();
            });

            //绑定事件
            //分享到云库
            $('.js-share').on('click', function () {
                //id
                var selectList = table.getSelect();
                if (selectList.length === 0) {
                    layer.msg("请先选择操作项");
                    return;
                }
                var knowledgeIds = "";
                for (var i = 0; i < selectList.length; i++) {
                    knowledgeIds += selectList[i] + ",";
                }
                knowledgeIds = knowledgeIds.substring(0, knowledgeIds.length - 1);
                //分享弹框
                PEMO.DIALOG.confirmL({
                    content: _.template($('#shareToPublic').html())({}),
                    area: ['468px', '520px'],
                    title: '选择公共库',
                    btn: ['确定', '取消'],
                    skin: 'pe-layer-confirm pe-layer-has-tree organize-change-layer',
                    resize: false,
                    btnAlign: 'c',
                    btn1: function () {
                        var libraryId = $('input[name="shareLibraryId"]').val();
                        PEBASE.ajaxRequest({
                            url: pageContext.rootPath + '/km/knowledge/shareToPublic',
                            data: {'knowledgeId': knowledgeIds, 'shareLibraryId': libraryId},
                            success: function (data) {
                                if (data.success) {
                                    layer.closeAll();
                                    PEMO.DIALOG.tips({
                                        content: '操作成功',
                                        time: 1000,
                                    });

                                    return false;
                                }
                                PEMO.DIALOG.alert({
                                    content: data.message,
                                    btn: ['我知道了'],
                                    yes: function () {
                                        layer.closeAll();
                                    }
                                });
                            }
                        });
                    },
                    btn2: function () {//取消按钮
                        layer.closeAll();
                    },

                    success: function () {
                        //初始化树
                        var settingInputTree = {
                            isOpen: true,
                            dataUrl: pageContext.rootPath + '/km/library/listTree',
                            clickNode: function (treeNode) {
                                $('input[name="shareLibraryId"]').val(treeNode.id);
                                //$('.show-org-name').val(treeNode.name);
                            },
                            treePosition: 'inputDropDown'
                        };
                        PEMO.ZTREE.initTree('editOrgTree', settingInputTree);
                        var treeObj = $.fn.zTree.getZTreeObj("editOrgTree");
                        treeObj.expandAll(true);
                    }
                });
            });
            //下载
            $('.js-download').on('click', function () {
                var selectList = table.getSelect();
                if (selectList.length === 0) {
                    layer.msg("请先选择操作项");
                    return;
                }
                var knIds = "";
                for (var i = 0; i < selectList.length; i++) {
                    knIds += selectList[i] + ",";
                }
                knIds = knIds.substring(0, knIds.length - 1);

                var fileIds = [];
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/km/knowledge/downloadKnowledge2',
                    async: false,
                    data: {'knowledgeIds': knIds},
                    success: function (data) {
                        if (data.success) {
                            downloadFile(data.data.fileUrl, data.data.name);
                        } else {
                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn: ['我知道了'],
                                yes: function (index) {
                                    layer.close(index);
                                }
                            });
                        }

                    }
                });
            });
            $('.pe-stand-table-main-panel').delegate('.js-opt-download', 'click', function () {
                var knIds = $(this).data('id');
                var fileIds = [];
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/km/knowledge/downloadKnowledge2',
                    async: false,
                    data: {'knowledgeIds': knIds},
                    success: function (data) {
                        if (data.success) {
                            downloadFile(data.data.fileUrl, data.data.name);
                        } else {
                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn: ['我知道了'],
                                yes: function (index) {
                                    layer.close(index);
                                }
                            });
                        }

                    }
                });
            });

            //新建文件夹
            $('.js-newFolder').on('click', function () {
                PEMO.DIALOG.confirmL({
                    content: _.template($('#addNewFolder').html())(),
                    title: '新增文件夹',
                    btnAlign: 'l',
                    area: ['475px'],
                    skin: 'pe-layer-confirm pe-knowledge-manage-layer',
                    btn: ['确定', '取消'],
                    btn1: function () {
                        var libraryName = $('input[name="libraryName"]').val();
                        var libraryId = $('#myLibrary').val();
                        //校验文件夹名称
                        if (libraryName == null || libraryName == '' || libraryName == undefined) {
                            return false;
                        }
                        PEBASE.ajaxRequest({
                            url: pageContext.rootPath + '/km/library/addFolder',
                            data: {
                                "libraryName": libraryName, "libraryId": libraryId
                            },
                            success: function (data) {

                                if (data.success) {
                                    PEMO.DIALOG.tips({
                                        content: '新增成功',
                                        time: 1000
                                        //TODO  刷新列表

                                    });
                                    layer.closeAll();
                                    //刷新列表
                                    var libraryId = $('#myLibrary').val();
                                    route['YunCb']($yunContentBody, route.routes.yun, null, libraryId);
                                } else {
                                    PEMO.DIALOG.alert({
                                        content: data.message,
                                        btn: ['我知道了'],
                                        yes: function (index) {
                                            layer.close(index);
                                        }
                                    });
                                }

                            }
                        });
                    },
                    btn2: function () {
                        layer.closeAll();
                    },
                });
            });

            //删除
            $('.pe-stand-table-main-panel').delegate('.js-opt-delete', 'click', function () {
                var knowledgeIds = $(this).data("id");
                if (knowledgeIds == null || knowledgeIds == undefined || knowledgeIds == '') {
                    return false;
                }
                PEMO.DIALOG.confirmL({
                    content: '<div><h3 class="pe-dialog-content-head">确定删除？</h3><p class="pe-dialog-content-tip">删除后，可在我的回收站找回。 </p></div>',
                    btn1: function () {

                        PEBASE.ajaxRequest({
                            url: pageContext.rootPath + '/km/knowledge/delete',
                            data: {
                                "knowledgeIds": knowledgeIds
                            },
                            success: function (data) {
                                if (data.success) {
                                    PEMO.DIALOG.tips({
                                        content: '操作成功',
                                        time: 1000,
                                    });
                                    layer.closeAll();
                                    //刷新列表
                                    route['YunCb']($yunContentBody, route.routes.yun, null, null);
                                } else {
                                    PEMO.DIALOG.alert({
                                        content: data.message,
                                        btn: ['我知道了'],
                                        yes: function (index) {
                                            layer.close(index);
                                        }
                                    });
                                }

                            }
                        });
                    },
                    btn2: function () {
                        layer.closeAll();
                    },
                });
            });

            $('.pe-stand-table-main-panel').delegate('.js-opt-share', 'click', function () {

                var knowledgeIds = $(this).data("id");
                if (knowledgeIds == null || knowledgeIds == undefined || knowledgeIds == '') {
                    return false;
                }
                //分享弹框
                PEMO.DIALOG.confirmL({
                    content: _.template($('#shareToPublic').html())({}),
                    area: ['468px', '520px'],
                    title: '选择公共库',
                    btn: ['确定', '取消'],
                    skin: 'pe-layer-confirm pe-layer-has-tree organize-change-layer',
                    resize: false,
                    btnAlign: 'c',
                    btn1: function () {
                        var libraryId = $('input[name="shareLibraryId"]').val();
                        PEBASE.ajaxRequest({
                            url: pageContext.rootPath + '/km/knowledge/shareToPublic',
                            data: {'knowledgeId': knowledgeIds, 'shareLibraryId': libraryId},
                            success: function (data) {
                                if (data.success) {
                                    layer.closeAll();
                                    PEMO.DIALOG.tips({
                                        content: '操作成功',
                                        time: 1000,
                                    });

                                    return false;
                                }
                                PEMO.DIALOG.alert({
                                    content: data.message,
                                    btn: ['我知道了'],
                                    yes: function () {
                                        layer.closeAll();
                                    }
                                });
                            }
                        });
                    },
                    btn2: function () {//取消按钮
                        layer.closeAll();
                    },

                    success: function () {
                        //初始化树
                        var settingInputTree = {
                            isOpen: true,
                            dataUrl: pageContext.rootPath + '/km/library/listTree',
                            clickNode: function (treeNode) {
                                $('input[name="shareLibraryId"]').val(treeNode.id);
                                //$('.show-org-name').val(treeNode.name);
                            },
                            treePosition: 'inputDropDown'
                        };
                        PEMO.ZTREE.initTree('editOrgTree', settingInputTree);
                        var treeObj = $.fn.zTree.getZTreeObj("editOrgTree");
                        treeObj.expandAll(true);
                    }
                });
            });
            $('.js-opt-dbclick').dblclick(function () {
                var folder = $(this).data('folder');
                var fileId = $(this).data('fileid');
                if (fileId == null || fileId == '') {//没有文件id
                    var title = "";
                    $.ajax({
                        async: false,//此值要设置为FALSE  默认为TRUE 异步调用
                        type: "POST",
                        data: {'id': folder},
                        url: pageContext.rootPath + '/km/library/libraryName',
                        dataType: 'json',
                        success: function (result) {
                            title = result.data;
                        }
                    });
                    breadCrumbsList.push({id: folder, title: title});
                    $('#myLibrary').val(folder);
                    route['YunCb']($yunContentBody, route.routes.yun, null, folder);
                } else {
                    return false;
                }

            });
        }

        //公共库

        function initPublicPage(container, routeInfo) {
            var libraryId = publicId;
            var libraryName = publicName;
            var _tpl = $(routeInfo.templateId).html();
            container.html(_.template(_tpl)({title: '公共库>' + libraryName}));
            //table渲染
            var _table = $("#tplPublicTable").html();
            var $yunTable = $('#publicTable');
            var data = [];
            $.ajax({
                async: false,
                type: "POST",
                url: pageContext.resourcePath + '/knowledge/publicByLibraryId',//公共库的查询列表
                data: {"libraryId": libraryId},
                dataType: 'json',
                success: function (result) {
                    data = result;
                }
            });
            for (var i = 0; i < data.length; i++) {
                data[i].knowledgeSize = conver(data[i].knowledgeSize);
            }
            var table, initSort = {
                name: "desc",
                size: "desc",
                uploadTime: "desc"
            };
            renderTable();
            function renderTable() {
                $yunTable.html(_.template(_table)({list: data, sort: initSort}));
                table = initTable($yunTable);
                $yunTable.find('.sort').click(function () {
                    $yunTable.html(_.template(_table)({
                        list: data, sort: $.extend({}, initSort, {name: 'asc'})
                    }));
                });
            }

            $('.js-download').on('click', function () {
                var selectList = table.getSelect();
                if (selectList.length === 0) {
                    layer.msg("请先选择操作项");
                    return;
                }
                var knIds = "";
                for (var i = 0; i < selectList.length; i++) {
                    knIds += selectList[i] + ",";
                }
                knIds = knIds.substring(0, knIds.length - 1);

                var shareIdArr = table.getPubLicShareId();
                var shareIds = "";
                for (var i = 0; i < shareIdArr.length; i++) {
                    shareIds += shareIdArr[i] + ",";
                }
                shareIds = shareIds.substring(0, shareIds.length - 1);

                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/km/knowledge/updateDownCount',
                    async: false,
                    data: {'shareIds': shareIds},
                    success: function (data) {
                        if (data.success) {
                            console.log("修改成功");
                        } else {
                            console.log("修改失败");
                        }

                    }
                });

                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/km/knowledge/downloadKnowledge2',
                    async: false,
                    data: {'knowledgeIds': knIds},
                    success: function (data) {
                        if (data.success) {
                            downloadFile(data.data.fileUrl, data.data.name);
                        } else {
                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn: ['我知道了'],
                                yes: function (index) {
                                    layer.close(index);
                                }
                            });
                        }

                    }
                });


            });
            $('.js-opt-copy').on('click', function () {
                var selectList = table.getSelect();
                if (selectList.length === 0) {
                    layer.msg("请先选择操作项");
                    return;
                }
                var knowledgeIds = "";
                for (var i = 0; i < selectList.length; i++) {
                    knowledgeIds += selectList[i] + ",";
                }
                if (knowledgeIds.length <= 1) {
                    return false;
                }
                knowledgeIds = knowledgeIds.substring(0, knowledgeIds.length - 1);
                var shareIdArr = table.getPubLicShareId();
                var shareIds = "";
                for (var i = 0; i < shareIdArr.length; i++) {
                    shareIds += shareIdArr[i] + ",";
                }
                shareIds = shareIds.substring(0, shareIds.length - 1);
                PEMO.DIALOG.confirmL({
                    content: '<div><h3 class="pe-dialog-content-head">确定复制选中的文件？</h3><p class="pe-dialog-content-tip">确认后,可在我的云库内查看。 </p></div>',
                    btn1: function () {

                        PEBASE.ajaxRequest({
                            url: pageContext.rootPath + '/km/knowledge/copyToMyLibrary',
                            data: {
                                "knowledgeIds": knowledgeIds, "shareIds": shareIds
                            },
                            success: function (data) {
                                if (data.success) {
                                    PEMO.DIALOG.tips({
                                        content: '操作成功',
                                        time: 1000,
                                    });
                                    layer.closeAll();
                                } else {
                                    PEMO.DIALOG.alert({
                                        content: data.message,
                                        btn: ['我知道了'],
                                        yes: function (index) {
                                            layer.close(index);
                                        }
                                    });
                                }

                            }
                        });
                    },
                    btn2: function () {
                        layer.closeAll();
                    },
                });
            });


            $('.js-opt-download').on('click', function () {

                var knIds = $(this).data("id");
                var shareIds = $(this).data("shareid");
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/km/knowledge/updateDownCount',
                    async: false,
                    data: {'shareIds': shareIds},
                    success: function (data) {
                        if (data.success) {
                            console.log("修改成功");
                        } else {
                            console.log("修改失败");
                        }

                    }
                });
                var fileIds = [];
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/km/knowledge/downloadKnowledge2',
                    async: false,
                    data: {'knowledgeIds': knIds},
                    success: function (data) {
                        if (data.success) {
                            downloadFile(data.data.fileUrl, data.data.name);
                        } else {
                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn: ['我知道了'],
                                yes: function (index) {
                                    layer.close(index);
                                }
                            });
                        }

                    }
                });
            });
        }

        //我的分享
        function initSharePage(container, routeInfo) {
            var _tpl = $(routeInfo.templateId).html();
            container.html(_.template(_tpl)({title: '我的分享'}));
            //table渲染
            var data = [];
            $.ajax({
                async: false,
                type: "POST",
                url: pageContext.resourcePath + '/knowledge/myShare',
                dataType: 'json',
                success: function (result) {
                    data = result;
                }
            });
            for (var i = 0; i < data.length; i++) {
                data[i].knowledgeSize = conver(data[i].knowledgeSize);
            }
            var _table = $("#tplShareTable").html();
            var $yunTable = $('#shareTable');

            var table = {};
            renderTable();
            function renderTable() {
                $yunTable.html(_.template(_table)({list: data}));
                table = initTable($yunTable);
            }

            //绑定事件
            //取消分享
            $('.js-cancelShare').on('click', function () {
                var selectList = table.getSelectShareId();
                if (selectList.length === 0) {
                    layer.msg("请先选择操作项");
                    return;
                }
                var shareIds = "";
                for (var i = 0; i < selectList.length; i++) {
                    shareIds += selectList[i] + ",";
                }
                if (shareIds.length <= 1) {
                    return false;
                }
                shareIds = shareIds.substring(0, shareIds.length - 1);
                PEMO.DIALOG.confirmL({
                    content: '<div><h3 class="pe-dialog-content-head">确定取消选中的分享记录的？</h3><p class="pe-dialog-content-tip">取消后，分享记录不可以恢复，请谨慎操作。 </p></div>',
                    btn1: function () {

                        PEBASE.ajaxRequest({
                            url: pageContext.rootPath + '/km/share/cancelShare',
                            data: {
                                "shareIds": shareIds
                            },
                            success: function (data) {
                                if (data.success) {
                                    PEMO.DIALOG.tips({
                                        content: '操作成功',
                                        time: 1000,
                                    });
                                    layer.closeAll();
                                    //刷新列表
                                    route['shareCb']($yunContentBody, route.routes.share, null);
                                } else {
                                    PEMO.DIALOG.alert({
                                        content: data.message,
                                        btn: ['我知道了'],
                                        yes: function (index) {
                                            layer.close(index);
                                        }
                                    });
                                }

                            }
                        });
                    },
                    btn2: function () {
                        layer.closeAll();
                    },
                });
            });

        }

        //回收站
        function initRecyclePage(container, routeInfo) {
            var _tpl = $(routeInfo.templateId).html();
            container.html(_.template(_tpl)({title: '我的回收站'}));
            //table渲染
            var _table = $("#tplRecycleTable").html();
            var $yunTable = $('#recycleTable');
            var data = [];
            $.ajax({
                async: false,//此值要设置为FALSE  默认为TRUE 异步调用
                type: "POST",
                url: pageContext.resourcePath + '/knowledge/searchRecycle',
                dataType: 'json',
                success: function (result) {
                    data = result;
                }
            });
            for (var i = 0; i < data.length; i++) {
                data[i].knowledgeSize = conver(data[i].knowledgeSize);
            }
            var table, initSort = {
                name: "desc",
                size: "desc",
                uploadTime: "desc"
            };
            renderTable();
            function renderTable() {
                $yunTable.html(_.template(_table)({list: data, sort: initSort}));
                table = initTable($yunTable);
            }

            //绑定事件 还原文件
            $('.js-reduction').on('click', function () {
                var selectList = table.getSelect();
                if (selectList.length === 0) {
                    layer.msg("请先选择操作项");
                    return;
                }
                var knowledgeIds = "";
                for (var i = 0; i < selectList.length; i++) {
                    knowledgeIds += selectList[i] + ",";
                }
                if (knowledgeIds.length <= 1) {
                    return false;
                }
                knowledgeIds = knowledgeIds.substring(0, knowledgeIds.length - 1);
                PEMO.DIALOG.confirmL({
                    content: '<div><h3 class="pe-dialog-content-head">确定还原选中的记录的？</h3><p class="pe-dialog-content-tip">还原后,可在我的云库内查看。 </p></div>',
                    btn1: function () {

                        PEBASE.ajaxRequest({
                            url: pageContext.rootPath + '/km/knowledge/reduction',
                            data: {
                                "knowledgeIds": knowledgeIds
                            },
                            success: function (data) {
                                if (data.success) {
                                    PEMO.DIALOG.tips({
                                        content: '操作成功',
                                        time: 1000,
                                    });
                                    layer.closeAll();
                                    //刷新列表
                                    route['recycleCb']($yunContentBody, route.routes.recycle, null);
                                } else {
                                    PEMO.DIALOG.alert({
                                        content: data.message,
                                        btn: ['我知道了'],
                                        yes: function (index) {
                                            layer.close(index);
                                        }
                                    });
                                }

                            }
                        });
                    },
                    btn2: function () {
                        layer.closeAll();
                    },
                });
            });
            //清空回收站
            $('.js-emptyRecycle').on('click', function () {
                PEMO.DIALOG.confirmL({
                    content: '<div><h3 class="pe-dialog-content-head">确定清空回收站？</h3><p class="pe-dialog-content-tip">确认后,不可恢复,请谨慎操作！ </p></div>',
                    btn1: function () {
                        PEBASE.ajaxRequest({
                            url: pageContext.rootPath + '/km/knowledge/emptyTrash',
                            data: {},
                            success: function (data) {
                                if (data.success) {
                                    PEMO.DIALOG.tips({
                                        content: '操作成功',
                                        time: 1000,
                                    });
                                    layer.closeAll();
                                    //刷新列表
                                    route['recycleCb']($yunContentBody, route.routes.recycle, null);
                                } else {
                                    PEMO.DIALOG.alert({
                                        content: data.message,
                                        btn: ['我知道了'],
                                        yes: function (index) {
                                            layer.close(index);
                                        }
                                    });
                                }

                            }
                        });
                    },
                    btn2: function () {
                        layer.closeAll();
                    }
                });
            });
        }

        //初始化table事件
        function initTable($container) {
            var $thead = $container.find(".y-table__header");
            var $tbody = $container.find("tbody");
            var $allCheckbox = $thead.find('input[type="checkbox"]');
            var $checkbox = $tbody.find('.y-table__td.checkbox').find("input");
            //全选
            $allCheckbox.on("change", function () {
                if (this.checked) {
                    $checkbox.prop('checked', 'checked');
                } else {
                    $checkbox.removeProp('checked');
                }
            });

            //单行选中
            $checkbox.on("change", function () {
                if (checkAll()) {
                    $allCheckbox.prop('checked', 'checked');
                } else {
                    $allCheckbox.removeProp('checked');
                }
            });

            //排序
            $thead.find('.sort').on("click", function () {
                var isDes = $(this).hasClass("desc");
                if (isDes) {
                    $(this).removeClass('desc').addClass("asc");
                } else {
                    $(this).addClass('desc').removeClass("asc");
                }
            });
            //选择所有
            function checkAll() {
                var total = $checkbox.size();
                var count = 0;
                $checkbox.each(function (i, item) {
                    if ($(item).get(0).checked) {
                        count++;
                    }
                });
                return total === count;
            }

            //选择
            return {
                getPubLicShareId: function () {
                    var list = [];
                    $checkbox.each(function (i, item) {
                        var $item = $(item);
                        if ($item.get(0).checked) {
                            list.push($item.closest('.y-table__tr').attr('data-shareid'));
                        }
                    });
                    return list;
                },
                getSelect: function () {
                    var list = [];
                    $checkbox.each(function (i, item) {
                        var $item = $(item);
                        if ($item.get(0).checked) {
                            list.push($item.closest('.y-table__tr').attr('data-id'));
                        }
                    });
                    return list;
                },
                getSelectShareId: function () {
                    var list = [];
                    $checkbox.each(function (i, item) {
                        var $item = $(item);
                        if ($item.get(0).checked) {
                            list.push($item.closest('.y-table__tr').attr('data-id'));
                        }
                    });
                    return list;
                }
            };
        }

        window.refreshPage = function () {
            var id = $('#myLibrary').val();
            route['YunCb']($yunContentBody, route.routes.yun, null, id);
        }
    })

    function downloadFile(path, params) {
        var downUrl = $('#downloadServerUrl').val();
        var a = document.createElement('a');
        var corpCode = $('#corpCode').val();
        a.download = '';
        a.style.display = 'none';
        a.href = downUrl + '/file/downLoadFiles?fileIds=' + path + '&fileName=' + params + '&corpCode='+corpCode;
        // 触发点击
        document.body.appendChild(a);
        a.click();
        // 然后移除
        document.body.removeChild(a);
    }
    //
    function funDownload(content, filename) {
        // 创建隐藏的可下载链接
        var a = document.createElement('a');
        a.download = filename;
        a.style.display = 'none';
        // 字符内容转变成blob地址
        //var blob = new Blob([content]);
        //console.log(blob);
        //a.href = URL.createObjectURL(blob);
        a.href = content;
        // 触发点击
        document.body.appendChild(a);
        a.click();
        // 然后移除
        document.body.removeChild(a);
    };
    //转换单位
    function conver(limit) {
        var size = "";
        if (limit < 0.1 * 1024) { //如果小于0.1KB转化成B
            size = limit.toFixed(2) + "B";
        } else if (limit < 0.1 * 1024 * 1024) {//如果小于0.1MB转化成KB
            size = (limit / 1024).toFixed(2) + "KB";
        } else if (limit < 0.1 * 1024 * 1024 * 1024) { //如果小于0.1GB转化成MB
            size = (limit / (1024 * 1024)).toFixed(2) + "MB";
        } else { //其他转化成GB
            size = (limit / (1024 * 1024 * 1024)).toFixed(2) + "GB";
        }

        var sizestr = size + "";
        var len = sizestr.indexOf("\.");
        var dec = sizestr.substr(len + 1, 2);
        if (dec == "00") {//当小数点后为00时 去掉小数部分
            return sizestr.substring(0, len) + sizestr.substr(len + 3, 2);
        }
        return sizestr;
    }

    function handleName(name) {
        if (name.length >= 10) {
            name = name.substring(0, 10);
        }
        return name;
    }

    function loginOut() {
        PEMO.DIALOG.confirmL({
            content: '您确定退出吗？',
            area: ['350px', '173px'],
            title: '提示',
            btn: ['取消', '确定'],
            btnAlign: 'c',
            skin: ' pe-layer-confirm pe-layer-has-tree login-out-dialog-layer',
            btn1: function () {
                layer.closeAll();
            },
            btn2: function () {
                location.href = pageContext.rootPath + '/km/client/logout';
            },
            success: function () {
                PEBASE.peFormEvent('checkbox');
            }
        });
    }


</script>
