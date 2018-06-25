$(function(){
    var $yunContentBody = $('#yunContentBody');
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
            url: pageContext.resourcePath + '/km/manage/search',
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
        var processor = "FILE";


        window.uploadFile({
            swf: "/km/web-static/flash/Uploader.swf",
            server: "http://192.168.0.35/fs/file/uploadFile",
            pick: "#filePicker",
            resize: false,
            dnd: "#theList",
            paste: document.body,
            disableGlobalDnd: true,
            thumb: {
                width: 100,
                height: 100,
                quality: 70,
                allowMagnify: true,
                crop: true
            },
            compress: false,
            prepareNextFile: true,
            chunked: true,
            chunkSize: 5000 * 1024,
            threads: true,
            fileNumLimit: 1,
            fileSingleSizeLimit: 10 * 1024 * 1024 * 1024,
            duplicate: true
        }, {
            uploadCompleted: function (data) {
                if (data == undefined || data == null) {
                    return;
                }
                var url = pageContext.rootPath + '/km/km/saveKnowledge';
                pro = data.processor;
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    data: {fileId:data.id, knowledgeName: data.storedFileName, knowledgeType: data.processor, knowledgeSize: data.fileSize, showOrder: 0},
                    url: url,
                    success: function (data) {
                        PEMO.DIALOG.tips({
                            content: '保存成功',
                            time: 1000
                        });
                        //刷新列表
                        route['YunCb']($yunContentBody, route.routes.yun, null);
                    }
                });
            },
            appCode: "km",
            processor: processor,
            //extractPoint: true,
            corpCode: "lbox",
            businessId: (new Date()).getTime(),
            responseFormat: "json"
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
                url: pageContext.rootPath + '/km/km/downloadKnowledge',
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
                                    time: 1000,
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

    }

    //公共库
    function initPublicPage(container, routeInfo) {
        var libraryId = publicId;
        var libraryName = publicName;
        var _tpl = $(routeInfo.templateId).html();
        container.html(_.template(_tpl)({title: '公共库>'+libraryName}));
        //table渲染
        var _table = $("#tplYunTable").html();
        var $yunTable = $('#publicTable');
        var data = [];
        $.ajax({
            async: false,
            type: "POST",
            url: pageContext.resourcePath + '/km/publicByLibraryId',//公共库的查询列表
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
    }

    //我的分享
    function initSharePage(container, routeInfo) {
        var _tpl = $(routeInfo.templateId).html();
        container.html(_.template(_tpl)({title: '我的分享'}));
        //table渲染
        var data = [
            {
                id: '1231',
                fileType: 'file',
                fileName: '2018/05/11',
                createTime: '',
                expireTime: '',
                viewCount: '1',
                downloadCount: '1',
                copyCount: '1'
            }
        ];
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
            var selectList = table.getSelect();
            if (selectList.length === 0) {
                layer.msg("请先选择操作项");
                return;
            }
            //TODO
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
            url: pageContext.resourcePath + '/km/manage/searchRecycle',
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
        //绑定事件
        $('.js-reduction').on('click', function () {
            var selectList = table.getSelect();
            if (selectList.length === 0) {
                layer.msg("请先选择操作项");
                return;
            }
        });
        $('.js-emptyRecycle').on('click', function () {
                layer.msg("清空回收站");
                return;
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
