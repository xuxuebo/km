$(function(){
    var $yunContentBody = $('#yunLContentBody');
    var $yAside = $('#YAside');
    //路由
    var publicId = "";
    var publicName = "";
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
        YunCb: function (container, routeInfo, cb) {
            initYunPage(container, routeInfo);
        },
        publicCb: function (container, routeInfo, cb) {
            initPublicPage(container, routeInfo);
        },
        recycleCb: function (container, routeInfo, cb) {
            initRecyclePage(container, routeInfo);
        },
        shareCb: function (container, routeInfo, cb) {
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
            var subName =$yAside.find('a[data-id="' + subNav + '"]').children('span').data("name");
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
    function initYunPage(container, routeInfo) {

        var _tpl = $(routeInfo.templateId).html();
        container.html(_.template(_tpl)({title: '我的云库'}));
        //table渲染
        var _table = $("#tplYunTable").html();
        var $yunTable = $('#yunTable');
        var data = [];
        $.ajax({
            async: false,//此值要设置为FALSE  默认为TRUE 异步调用
            type: "POST",
            url: pageContext.resourcePath + '/knowledge/manage/search',
            dataType: 'json',
            success: function (result) {
                data = result;
            }
        });
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

        var hash = window.location.hash;




         $('.js-upload').on('click', function () {
             PEMO.DIALOG.selectorDialog({
                 content: pageContext.rootPath + '/km/knowledge/openUpload',
                 area: ['520px', '320px'],
                 title: '上传文件',
                 btn1: function () {
                 },
                 btn2: function () {
                     layer.closeAll();
                 },
                 success: function (d,index) {
                     var iframeBody = layer.getChildFrame('body', index);
                     var hasPicSrc = $('.pe-user-head-edit-btn').find('img').attr('src');
                     if(hasPicSrc){
                         $(iframeBody).find('.jcrop-preview').prop("src", hasPicSrc);
                     }
                 }
             });
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
            var knowledgeIds ="";
            for(var i = 0;i<selectList.length;i++){
                knowledgeIds += selectList[i] +",";
            }
            knowledgeIds = knowledgeIds.substring(0,knowledgeIds.length-1);
            //分享弹框
            PEMO.DIALOG.confirmL({
                content: _.template($('#shareToPublic').html())({}),
                area: ['468px','520px'],
                title: '选择公共库',
                btn: ['确定', '取消'],
                skin: 'pe-layer-confirm pe-layer-has-tree organize-change-layer',
                resize:false,
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
                        isOpen:true,
                        dataUrl: pageContext.rootPath + '/km/library/listTree',
                        clickNode: function (treeNode) {
                            $('input[name="shareLibraryId"]').val(treeNode.id);
                            //$('.show-org-name').val(treeNode.name);
                        },
                        treePosition:'inputDropDown'
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
            for(var i = 0 ;i<selectList.length;i++){
                knIds += selectList[i]+",";
            }
            knIds = knIds.substring(0,knIds.length-1);

            var fileIds = [];
            PEBASE.ajaxRequest({
                url: pageContext.rootPath + '/km/knowledge/downloadKnowledge',
                async: false,
                data: {'knowledgeIds':knIds},
                success: function (data) {
                    if (data.success) {
                        fileIds = data.data;
                    }else{
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
            for(var i=0;i<fileIds.length;i++){
                downloadFile(fileIds[i],null);
            }
        });
        $('.js-opt-download').on('click', function () {
            var knIds =  $(this).data('id');
            console.log(knIds);
            var fileIds = [];
            PEBASE.ajaxRequest({
                url: pageContext.rootPath + '/km/knowledge/downloadKnowledge',
                async: false,
                data: {'knowledgeIds':knIds},
                success: function (data) {
                    if (data.success) {
                        fileIds = data.data;
                    }else{
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
            for(var i=0;i<fileIds.length;i++){
                downloadFile(fileIds[i],null);
            }
        });

        //新建文件夹
        $('.js-newFolder').on('click', function () {
            PEMO.DIALOG.confirmL({
                content: _.template($('#addNewFolder').html())(),
                title: '新增文件夹',
                btnAlign:'l',
                area:['475px'],
                skin: 'pe-layer-confirm pe-knowledge-manage-layer',
                btn: ['确定','取消'],
                btn1: function () {
                    var libraryName = $('input[name="libraryName"]').val();
                    //校验文件夹名称
                    if(libraryName==null||libraryName==''||libraryName==undefined){
                        return false;
                    }
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/km/library/addFolder',
                        data: {
                            "libraryName": libraryName
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
                                route['YunCb']($yunContentBody, route.routes.yun, null);
                            }else{
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
                btn2:function(){
                    layer.closeAll();
                },
            });
        });

        //删除
        $('.js-opt-delete').on('click', function () {
            var knowledgeIds = $(this).data("id");
            if(knowledgeIds==null||knowledgeIds==undefined||knowledgeIds==''){
                return false;
            }
            PEMO.DIALOG.confirmL({
                content:'<div><h3 class="pe-dialog-content-head">确定删除？</h3><p class="pe-dialog-content-tip">删除后，可在我的回收站找回。 </p></div>',
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
                                route['YunCb']($yunContentBody, route.routes.yun, null);
                            }else{
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
                btn2:function(){
                    layer.closeAll();
                },
            });
        });

        $('.js-opt-share').on('click', function () {

            var knowledgeIds =$(this).data("id");
            if(knowledgeIds==null||knowledgeIds==undefined||knowledgeIds==''){
                    return false;
            }
            //分享弹框
            PEMO.DIALOG.confirmL({
                content: _.template($('#shareToPublic').html())({}),
                area: ['468px','520px'],
                title: '选择公共库',
                btn: ['确定', '取消'],
                skin: 'pe-layer-confirm pe-layer-has-tree organize-change-layer',
                resize:false,
                btnAlign: 'c',
                btn1: function () {
                    var libraryId = $('input[name="shareLibraryId"]').val();
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/km/km/shareToPublic',
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
                        isOpen:true,
                        dataUrl: pageContext.rootPath + '/km/library/listTree',
                        clickNode: function (treeNode) {
                            $('input[name="shareLibraryId"]').val(treeNode.id);
                            //$('.show-org-name').val(treeNode.name);
                        },
                        treePosition:'inputDropDown'
                    };
                    PEMO.ZTREE.initTree('editOrgTree', settingInputTree);
                    var treeObj = $.fn.zTree.getZTreeObj("editOrgTree");
                    treeObj.expandAll(true);
                }
            });
        });
    }

    //公共库
    function initPublicPage(container, routeInfo) {
        var libraryId = publicId;
        var libraryName = publicName;
        var _tpl = $(routeInfo.templateId).html();
        container.html(_.template(_tpl)({title: '公共库>'+libraryName}));
        //table渲染
        var _table = $("#tplPublicTable").html();
        var $yunTable = $('#publicTable');
        var data = [];
        $.ajax({
            async: false,
            type: "POST",
            url: pageContext.resourcePath + '/knowledge/publicByLibraryId',//公共库的查询列表
            data:{"libraryId":libraryId},
            dataType: 'json',
            success: function (result) {
                data = result;
            }
        });
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
            for(var i = 0 ;i<selectList.length;i++){
                knIds += selectList[i]+",";
            }
            knIds = knIds.substring(0,knIds.length-1);

            var fileIds = [];
            PEBASE.ajaxRequest({
                url: pageContext.rootPath + '/km/knowledge/downloadKnowledge',
                async: false,
                data: {'knowledgeIds':knIds},
                success: function (data) {
                    if (data.success) {
                        fileIds = data.data;
                    }else{
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
            for(var i=0;i<fileIds.length;i++){
                downloadFile(fileIds[i],null);
            }
        });
        $('.js-opt-copy').on('click', function () {
            var selectList = table.getSelect();
            if (selectList.length === 0) {
                layer.msg("请先选择操作项");
                return;
            }
            var knowledgeIds = "";
            for(var i=0;i<selectList.length;i++){
                knowledgeIds += selectList[i] + ",";
            }
            if(knowledgeIds.length<=1){
                return false;
            }
            knowledgeIds =  knowledgeIds.substring(0,knowledgeIds.length-1);
            PEMO.DIALOG.confirmL({
                content:'<div><h3 class="pe-dialog-content-head">确定复制选中的文件？</h3><p class="pe-dialog-content-tip">确认后,可在我的云库内查看。 </p></div>',
                btn1: function () {

                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/km/knowledge/copyToMyLibrary',
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
                            }else{
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
                btn2:function(){
                    layer.closeAll();
                },
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
            for(var i=0;i<selectList.length;i++){
                shareIds += selectList[i] + ",";
            }
            if(shareIds.length<=1){
                return false;
            }
            shareIds =  shareIds.substring(0,shareIds.length-1);
            PEMO.DIALOG.confirmL({
                content:'<div><h3 class="pe-dialog-content-head">确定取消选中的分享记录的？</h3><p class="pe-dialog-content-tip">取消后，分享记录不可以恢复，请谨慎操作。 </p></div>',
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
                            }else{
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
                btn2:function(){
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
            url: pageContext.resourcePath + '/knowledge/manage/searchRecycle',
            dataType: 'json',
            success: function (result) {
                data = result;
            }
        });
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
            for(var i=0;i<selectList.length;i++){
                knowledgeIds += selectList[i] + ",";
            }
            if(knowledgeIds.length<=1){
                return false;
            }
            knowledgeIds =  knowledgeIds.substring(0,knowledgeIds.length-1);
            PEMO.DIALOG.confirmL({
                content:'<div><h3 class="pe-dialog-content-head">确定还原选中的记录的？</h3><p class="pe-dialog-content-tip">还原后,可在我的云库内查看。 </p></div>',
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
                            }else{
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
                btn2:function(){
                    layer.closeAll();
                },
            });
        });
        //清空回收站
        $('.js-emptyRecycle').on('click', function () {
            PEMO.DIALOG.confirmL({
                content:'<div><h3 class="pe-dialog-content-head">确定清空回收站？</h3><p class="pe-dialog-content-tip">确认后,不可恢复,请谨慎操作！ </p></div>',
                btn1: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/km/knowledge/emptyTrash',
                        data: {
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
                            }else{
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
                btn2:function(){
                    layer.closeAll();
                },
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
                        list.push($item.closest('.y-table__tr').attr('data-shareid'));
                    }
                });
                return list;
            }
        };
    }

})

function downloadFile(path,params) {
    $("#downloadform").remove();
    var form = $("<form>");//定义一个form表单
    form.attr("id", "downloadform");
    form.attr("style", "display:none");
    form.attr("target", "");
    form.attr("method", "get");
    form.attr("action", path);
    for(var key in params){
        var input1 = $("<input>");
        input1.attr("type", "hidden");
        input1.attr("name", key);
        input1.attr("value", params[key]);
        form.append(input1);
    }
    $("body").append(form);//将表单放置在web中
    form.submit();//表单提交()
}
