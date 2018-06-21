<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>选择器</title>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/plugins/sui-append.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pe-common.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css"/>
</head>
<body class="pe-selector-body">
<form id="searchForm" action="javascript:;" name="searchForm">
    <input type="hidden" name="itemBank.category.id" value="${(categoryId)!}"/>
    <input type="hidden" name="itemBank.id" value=""/>
    <input type="hidden" name="page" value="1"/>
    <input type="hidden" name="pageSize" value="10"/>

    <div class="pe-selector-right">
        <div class="pe-selector-wrap">
            <div class="pe-panel pe-panel-default">
                <div class="pe-panel-header " style="padding: 12px 8px;">
                    <div class="pe-form-cell" style="height:32px;">
                        <div class="pe-control-group">
                            <div data-toggle="datepicker" class="control-group input-daterange">
                                <label for="keyword" style="margin-right:0;" class="control-label pe-label-name floatL">创建时间：</label>
                                <div class="controls pe-date-wrap">
                                    <input type="text" id="pePaperStartTime" style="width: 95px;line-height: 18px;" name="queryStartTime" class="pe-table-form-text input-medium input-date pe-time-text laydate-icon"><span>-</span>
                                    <input type="text" id="pePaperEndTime" style="width: 95px;line-height: 18px;" name="queryEndTime" class="pe-table-form-text input-medium input-date pe-time-text laydate-icon">
                                </div>
                            </div>
                        </div>
                        <div class="pe-control-group">
                            <label for="keyword" class="pe-label-name floatL clearF" style="margin-right:0;vertical-align:middle;">题干：</label>
                            <input id="keyword"
                                   style="width: 100px;"
                                   name="keyword" placeholder="题干" type="text"/>
                        </div>
                        <div class="pe-control-group" style="margin-right:0;float: right;">
                            <button class="pe-btn pe-btn-blue waitItemFilter" style="margin-right: 2px;" type="button">
                                筛选
                            </button>
                        </div>
                    </div>
                </div>
                <div class="pe-panel-body pe-selector-content">
                    <div class="pe-selector-available">
                        <div class="pe-panel pe-panel-info">
                            <div class="pe-panel-header">
                                <select name="securityQuery" id="peIsSecurity"
                                        class="floatR pe-selector-available-select">
                                    <option value="ALL">全部试题</option>
                                    <option value="SECURITY">绝密试题</option>
                                    <option value="NOT_SECURITY">非绝密试题</option>
                                </select>
                                待选（<span id="peAvailableNum">0</span>）
                            </div>
                            <div class="pe-panel-body pe-selector-list-content">
                                <div class="pe-selector-list-wrap">
                                    <ul class="pe-table pe-selector-exam-list">
                                    </ul>
                                </div>
                            </div>
                            <div class="pe-panel-footer">
                                <div class="pe-selector-pagination">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="pe-selector-opt">
                        <button class="pe-btn pe-btn-blue pe-btn-block" type="button" data-role="select">选择 &gt;</button>
                        <button class="pe-btn pe-btn-blue pe-btn-block" type="button" data-role="selectAll">全选&gt;&gt;</button>
                        <button class="pe-btn pe-btn-blue pe-btn-block" type="button" data-role="remove">&lt; 移除</button>
                        <button class="pe-btn pe-btn-blue pe-btn-block" type="button" data-role="removeAll">&lt;&lt;清空</button>
                    </div>
                    <div class="pe-selector-selected">
                        <div class="pe-panel pe-panel-info">
                            <div class="pe-panel-header">
                                已选（<span id="peSelectedNum">0</span>）
                            </div>
                            <div class="pe-panel-body pe-selector-list-content">
                                <div class="pe-selector-list-wrap">
                                    <ul class="pe-table pe-selector-exam-list">
                                    </ul>
                                </div>
                            </div>
                            <div class="pe-panel-footer">
                                <div class="pe-selector-pagination">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <div class="pe-selector-left">
        <div class="pe-classify-wrap floatL" style="min-height: 487px;">
            <div class="pe-classify-top over-flow-hide pe-form ">
                <span class="floatL pe-classify-top-text">按类别筛选</span>
                <span class="floatR pe-checkbox  pe-check-by-list" style=" padding-right: 15px;">
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                        <input id="itemIncludeDom" class="pe-form-ele " type="checkbox" value="true"
                           name="itemBank.category.include" checked="checked"/><span class="include-subclass">包含子类</span>
                </span>
            </div>
            <div class="pe-classify-tree-wrap">
                <div class="pe-tree-search-wrap">
                <#--复用时，保留下面的input单独classname 'pe-tree-form-text'-->
                    <input class="pe-tree-form-text" type="text" placeholder="请输入题库类别名称">
                <#--<span class="pe-placeholder">请输入题库名称</span>--><#--备用,误删-->
                    <span class="iconfont pe-tree-search-btn icon-search-magnifier"></span>
                </div>
                <div class="pe-select-tree-content-wrap">
                <#--<div class="pe-tree-main-wrap">-->
                <#--&lt;#&ndash;pe-no-manage-tree为非管理树类添加的样式，是管理类的树，无需此class&ndash;&gt;-->
                <#--<ul id="peZtreeMain" class="ztree pe-select-tree-container " data-type="km"></ul>-->
                <#--</div>-->
                    <div class="pe-tree-content-wrap" style="min-height: 0;">
                        <div class="pe-tree-main-wrap">
                            <div class="node-search-empty" style="text-align: center;">暂无</div>
                            <ul id="peZtreeMain" class="ztree pe-tree-container pe-select-tree-container"
                                data-type="km"></ul>
                        </div>
                    </div>
                </div>
            <#--题库管理根据需要是否显示-->
            <#--<div class="pe-control-tree-btn iconfont icon-set">管理类别</div>-->
            </div>
        </div>
    </div>
    <div class="clear"></div>
</form>

<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.core.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.mCustomScrollbar.concat.min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/sui_datepicker.js?_v=${(resourceVersion)!}"></script>

<script type="text/template" id="peItemTpl">
    <#--三行-->
    <%for(var i=0;i < list.length ;i++){%>
    <li title="<%=list[i].stemOutline%>" class="<%=list[i].security?'security':''%>" data-index="<%=i%>">
        <div class="wrap">
            <span class="text-gray">[<%if(list[i].type === 'SINGLE_SELECTION'){%>单选<%}else if(list[i].type === 'MULTI_SELECTION'){%>多选<%}else if(list[i].type === 'INDEFINITE_SELECTION'){%>不定项<%}else if(list[i].type === 'JUDGMENT'){%>判断<%}else if(list[i].type === 'FILL'){%>填空<%}else if(list[i].type === 'QUESTIONS'){%>问答<%}%>]</span>
            <%=list[i].stemOutline%>
        </div>
    </li>
    <%}%>
</script>
<script type="text/template" id="peSelectorPagination">

    <button class="pe-selector-page-pre-btn" <%= page==0?"disabled='disabled'":""%> type="button"><i class="iconfont icon-page-pre"></i></button>
    <%if(Math.ceil(total/pageSize) === 0){%>
    <input class="pe-selector-page-num" type="number" data-page="<%=page%>" min="1" max="1"
           value="1"/>
    <%}else{%>
    <input class="pe-selector-page-num" type="number" data-page="<%=page%>" min="1" max="<%=Math.ceil(total/pageSize)%>"
           value="<%=page+1%>"/>
    <%}%>
    <label>/<%if(total==0){%>1<%}else{%><%=Math.ceil(total/pageSize)%><%}%></label>
    <button class="pe-selector-page-next-btn" <%if(total==0){%><%=disabled='disabled'%><%}else{%> <%= Math.ceil(total/pageSize)==(page+1)?"disabled='disabled'":""%><%}%> type="button"><i
            class="iconfont icon-page-next"></i></button>
    <select class="pe-selector-page-size">
        <option value="10"
        <%=pageSize==10?'selected="selected"':''%> >10</option>
        <option value="20"
        <%=pageSize==20?'selected="selected"':''%>>20</option>
        <option value="50"
        <%=pageSize==50?'selected="selected"':''%>>50</option>
        <option value="100"
        <%=pageSize==100?'selected="selected"':''%>>100</option>
        <option value="500"
        <%=pageSize==500?'selected="selected"':''%>>500</option>
    </select>
</script>
<script>
    $(function () {
        var templateId = '${(templateId)!""}';
        var selector = {
            availableData: [],
            selectData: [],
            URLS: {
                available: '${ctx!}/ems/template/manage/searchWaitItem?templateId=' + templateId,
                selected: '${ctx!}/ems/template/manage/searchSelectFixItem?templateId=' + templateId,
                save: '${ctx!}/ems/template/manage/saveFixed',
                remove: '${ctx!}/ems/template/manage/deleteFixed'
            },
            renderPagination: function (container, page) {
                container.html(_.template($('#peSelectorPagination').html())(page));
            },
            renderAvailable: function (data) {
                var _this = this;
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    data: data,
                    url: _this.URLS.available + '&' + $('#searchForm').serialize(),
                    success: function (page) {
                        _this.availableData = page.rows;
                        $('.pe-selector-available .pe-selector-exam-list').html(_.template($('#peItemTpl').html())({list: page.rows}));
                        $('#peAvailableNum').html(page.total);
                        _this.renderPagination($('.pe-selector-available .pe-selector-pagination'), page);
                    }
                });
            },
            renderSelected: function (data) {
                var _this = this;
                data = $.extend({'page': 1, 'pageSize': 10}, data);
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    data: data,
                    url: _this.URLS.selected,
                    success: function (page) {
                        _this.selectData = page.rows;
                        $('.pe-selector-selected .pe-selector-exam-list').html(_.template($('#peItemTpl').html())({list: page.rows}));
                        $('#peSelectedNum').html(page.total);
                        _this.renderPagination($('.pe-selector-selected .pe-selector-pagination'), page);

                    }
                });
            },
            save: function (data) {
                var referIds = [];
                var _this = this;
                for (var key in data) {
                    referIds.push(data[key]);
                }

                data = {
                    'id': templateId,
                    'referIds': JSON.stringify(referIds)
                };
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    data: data,
                    url: selector.URLS.save,
                    success: function (data) {
                        if (data.success) {
                            _this.renderAvailable();
                            _this.renderSelected();
                        } else {
                            alert('保存出错');
                        }
                    },
                    error: function () {
                        alert('error');
                    }
                });
            },
            remove: function (data) {
                var _this = this;
                data = $.extend({'id': templateId}, data);
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    data: data,
                    url: selector.URLS.remove,
                    success: function (data) {
                        if (data.success) {
                            _this.renderAvailable();
                            _this.renderSelected();
                        } else {
                            alert('保存出错');
                        }
                    },
                    error: function () {
                        alert('error');
                    }
                });
            },
            search: function (data) {
                //todo form序列号
                selector.renderAvailable();
            },
            init: function () {
                var _this = this;
                //ie9不支持Placeholder问题
//                PEBASE.isPlaceholder();
                var settingUrl = {
                    dataUrl: '${ctx}/ems/item/manage/listTree',
                    clickNode: function (treeNode) {
                        if (treeNode) {
                            if (treeNode.isParent) {
                                $('input[name="itemBank.category.id"]').val(treeNode.id);
                                $('input[name="itemBank.id"]').val('');
                            } else {
                                $('input[name="itemBank.id"]').val(treeNode.id);
                                $('input[name="itemBank.category.id"]').val('');
                            }
                        }

                        _this.renderAvailable();
                    }
                };

                PEMO.ZTREE.initTree('peZtreeMain', settingUrl);
                PEBASE.peFormEvent('checkbox');

                _this.renderAvailable();
                _this.renderSelected();
                _this.initEvent();

            },
            initEvent: function () {
                var _this = this;
                //交互
                $('.pe-selector-available,.pe-selector-selected').on('click', "li", function (e) {
                    $(this).toggleClass("selected");
                });
                //选择题库类型
                $('#peIsSecurity').change(function () {
                    $('input[name="page"]').attr("value", 1);
                    _this.renderAvailable();
                });

                //选择
                $('button[data-role="select"]').click(function () {
                    var itemsObj = {};
                    var $selectItem = $('.pe-selector-available li.selected');
                    if ($selectItem.length == 0) {
                        PEMO.DIALOG.tips({
                            content: "请选择要添加的试题！",
                            time: 1700
                        });
                        return;
                    }
                    $selectItem.each(function (index, item) {
                        var num = $(this).attr("data-index");
                        itemsObj['items[' + index + '].id'] = _this.availableData[num].id;
                    });

                    _this.save(itemsObj);
                });

                //全选
                $('button[data-role="selectAll"]').click(function () {
                    var peAvailableNum=$('#peAvailableNum').html();
                    if (peAvailableNum == 0) {
                        PEMO.DIALOG.tips({
                            content: "待选试题为空，无法添加！",
                            time: 1700
                        });
                        return false;
                    }
                    var itemsObj = {};
                    for (var i = 0; i < _this.availableData.length; i++) {
                        itemsObj['items[' + i + '].id'] = _this.availableData[i].id;
                    }
                    _this.save(itemsObj);
                });

                //移除
                $('button[data-role="remove"]').click(function () {
                    var itemsObj = {};
                    var $removelist = $('.pe-selector-selected li.selected');
                    if (!_this.hasItems()) {
                        return;
                    }
                    ;
                    if ($removelist.length == 0) {
                        PEMO.DIALOG.tips({
                            content: "请选择要移除的试题！",
                            time: 1700
                        });
                        return;
                    }
                    $removelist.each(function (index, item) {
                        var num = $(this).attr("data-index");
                        itemsObj['items[' + index + '].id'] = _this.selectData[num].id;
                    });
                    _this.remove(itemsObj);
                });

                //清空
                $('button[data-role="removeAll"]').click(function () {
                    var itemsObj = {};
                    if (!_this.hasItems()) {
                        return;
                    }
                    ;
                    for (var i = 0; i < _this.selectData.length; i++) {
                        itemsObj['items[' + i + '].id'] = _this.selectData[i].id;
                    }
                    _this.remove(itemsObj);
                });


                //待选分页交互 /*TODO 判断是否为数字*/
                $('.pe-selector-available').on('change', '.pe-selector-page-num', function () {
                    var page = $(this).val();
                    if (!isNaN(page)) {
                        document.searchForm.elements['page'].value = page;
                        _this.renderAvailable();
                    }
                });
                $('.pe-selector-available').on('change', '.pe-selector-page-size', function () {
                    var pageSize = $(this).val();
                    if (!isNaN(pageSize)) {
                        document.searchForm.elements['page'].value = 1;
                        document.searchForm.elements['pageSize'].value = pageSize;
                        _this.renderAvailable();
                    }
                });
                //下一页
                $('.pe-selector-available').on('click', '.pe-selector-page-next-btn', function () {
                    var pageElem = document.searchForm.elements['page'];
                    pageElem.value = parseInt(pageElem.value) + 1;
                    _this.renderAvailable();
                });
                //上一页
                $('.pe-selector-available').on('click', '.pe-selector-page-pre-btn', function () {
                    var pageElem = document.searchForm.elements['page'];
                    pageElem.value = parseInt(pageElem.value) - 1;
                    _this.renderAvailable();
                });

                //已选分页 /*TODO 判断是否为数字*/
                $('.pe-selector-selected').on('change', '.pe-selector-page-num', function () {
                    var page = $(this).val();
                    if (!isNaN(page)) {
                        _this.renderSelected({
                            'page': page,
                            'pageSize': $(this).siblings('.pe-selector-page-size').val()
                        });
                    }
                });
                $('.pe-selector-selected').on('change', '.pe-selector-page-size', function () {
                    var pageSize = $(this).val();
                    _this.renderSelected({'page': 1, 'pageSize': pageSize});
                });
                //下一页
                $('.pe-selector-selected').on('click', '.pe-selector-page-next-btn', function () {
                    var page = $(this).siblings('.pe-selector-page-num').val();
                    var pageSize = $('.pe-selector-selected').find('.pe-selector-page-size').val();
                    _this.renderSelected({'page': parseInt(page) + 1, 'pageSize': pageSize});
                });
                //上一页
                $('.pe-selector-selected').on('click', '.pe-selector-page-pre-btn', function () {
                    var page = $(this).siblings('.pe-selector-page-num').val()
                    var pageSize = $('.pe-selector-selected').find('.pe-selector-page-size').val();
                    _this.renderSelected({'page': parseInt(page) - 1, 'pageSize': pageSize});
                });
                //包含子类
                $('.pe-check-by-list').off().click(function(){
                    var iconCheck = $(this).find('span.iconfont');
                    var thisRealCheck = $(this).find('input[type="checkbox"]');
                    if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                        iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                        thisRealCheck.prop('checked', 'checked');
                    } else {
                        iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                        thisRealCheck.removeProp('checked');
                    }
                    _this.renderAvailable();
                });

                $('.waitItemFilter').click(function () {
                    $('input[name="page"]').attr("value", 1);
                    _this.renderAvailable();
                });

            },
            //判断已选试题是否为空
            hasItems: function () {
                var $hasItem = $('.pe-selector-selected li');
                if ($hasItem.length == 0) {
                    PEMO.DIALOG.tips({
                        content: "已选试题为空，无法删除！",
                        time: 1500
                    });
                    return false;
                }
                return true;
            }
        };

        selector.init();
    });


</script>
</body>
</html>