'use strict';
requirejs(['jquery', 'underscore', "layer"], function ($, _, layer) {
    var $yunContentBody = $('#yunContentBody');
    var $yAside = $('#YAside');
    //路由
    var route = {
        routes: {
            'user':{
              "templateId":'#tplUser',
                nav:'y-user',
                cb:"userCb"
            },
            'organize':{
                "templateId":'#tplOrganize',
                nav:'y-organize',
                cb:"organizeCb"
            },
            'role':{
                "templateId":'#tplRole',
                nav:'y-role',
                cb:"roleCb"
            },
            'position':{
                "templateId":'#tplPosition',
                nav:'y-position',
                cb:"positionCb"
            },
            'label':{
                "templateId":'#tplLabel',
                nav:'y-label',
                cb:"labelCb"
            }
        },
        userCb: function (container, routeInfo, cb) {
            initYunPage(container, routeInfo,'用户管理');
        },
        organizeCb: function (container, routeInfo, cb) {
            initYunPage(container, routeInfo,'部门管理');
        },
        roleCb: function (container, routeInfo, cb) {
            initYunPage(container, routeInfo,'角色管理');
        },
        positionCb: function (container, routeInfo, cb) {
            initYunPage(container, routeInfo,'岗位管理');
        },
        labelCb: function (container, routeInfo, cb) {
            initYunPage(container, routeInfo,'标签管理');
        }
    };

    function changeHashCb(cb) {
        var _hash = location.hash.substring(1);
        if (!_hash) {
            location.hash = 'user';
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
            try {
                route[routeInfo.cb]($yunContentBody, routeInfo, cb);
            } catch (e) {
                console.error("没有此" + routeInfo.cb + "方法", e);
            }
        }
    }

    if (('onhashchange' in window) && ((typeof document.documentMode === 'undefined') || document.documentMode == 8)) {
        $(window).bind("hashchange", changeHashCb);
    }

    /*初始化*/
    changeHashCb();



    function initYunPage(container, routeInfo,title) {
        var _tpl = $(routeInfo.templateId).html();//tplUser  按钮
        container.html(_.template(_tpl)({title: title}));
        //table渲染
        var _table = $("#tblUserTable").html();//表头
        var $userTable = $('#userTable');//div

        var data = [
            {
                id: '1232131314',
                userName: '姓名',
                loginName: '用户名',
                employeeCode: '工号',
                mobile: '13075569283',
                corpInfo:'中心',
                organize:'部门',
                status:'正常',
                opt:'操作一下'
            }
        ];

        var table = {

        };
        renderTable();
        function renderTable() {
            $userTable.html(_.template(_table)({list: data}));
            table = initTable($userTable);
        }

        //table上按钮绑定事件 //TODO
        //新增
        $('.js-addUser').on('click', function () {
            layer.msg("新增");
        });
        //导入
        $('.js-import').on('click', function () {
            layer.msg("导入");
        });
        //冻结
        $('.js-frozen').on('click', function () {
            var selectList = table.getSelect();
            if (selectList.length === 0) {
                layer.msg("请先选择操作项");
                return;
            }
        });
        //激活
        $('.js-activation').on('click', function () {
            var selectList = table.getSelect();
            if (selectList.length === 0) {
                layer.msg("请先选择操作项");
                return;
            }
        });
        //重置密码
        $('.js-resetPwd').on('click', function () {
            var selectList = table.getSelect();
            if (selectList.length === 0) {
                layer.msg("请先选择操作项");
                return;
            }
        });
        //导出
        $('.js-export').on('click', function () {
            layer.msg("导出");
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