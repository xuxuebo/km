'use strict';
requirejs(['jquery', 'underscore', "layer", "upload"], function ($, _, layer, upload) {
    var $yunContentBody = $('#yunContentBody');
    var $yAside = $('#YAside');
    //路由
    var route = {
        routes: {
            'yun': {
                "templateId": '#tplYun',
                nav: 'my-yun',
                cb: "YunCb"
            },
            'public/.+': {
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
        var processor = "DOC";
        /*if (hash) {
            processor = hash.substring(1);
        }*/

        upload.uploadFile({
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
                console.log(url);
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
            var selectList = table.getSelect();
            if (selectList.length === 0) {
                layer.msg("请先选择操作项");
                return;
            }

        });
        //下载
        $('.js-download').on('click', function () {
            var selectList = table.getSelect();
            if (selectList.length === 0) {
                layer.msg("请先选择操作项");
                return;
            }
        });
        //上传
        $('.js-upload').on('click', function () {

        });

        //新建文件夹
        $('.js-newFolder').on('click', function () {

        });

    }

    //公共库
    function initPublicPage() {

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
    function initRecyclePage() {

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

});