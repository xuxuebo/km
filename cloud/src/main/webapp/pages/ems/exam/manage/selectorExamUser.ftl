<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>选择器</title>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css"/>
<#--<script src="${resourcePath!}/web-static/proExam/js/jquery.placeholder.js" type="text/javascript"></script>-->

</head>
<body class="pe-selector-body" style="padding: 0 20px;">
<form id="searchForm" action="javascript:;" name="searchForm" style="overflow: hidden;">
    <input type="hidden" name="organize.id" value="${(organize.id)!}"/>
    <input type="hidden" name="page" value="1"/>
    <input type="hidden" name="pageSize" value="10"/>

    <div class="pe-selector-right">
        <div class="pe-selector-wrap">
            <div class="pe-panel pe-panel-default">
                <div class="pe-panel-header " style="padding: 12px 8px;">
                    <div class="pe-form-cell">
                        <div class="pe-control-group">
                            <label for="keyword">搜索：</label>
                            <input id="keyword"
                                   style="width: 200px;line-height: 18px;"
                                   name="keyword" placeholder="用户名/姓名/工号/手机号" type="text"/>
                        </div>
                        <div class="pe-control-group" style="margin-right:0;float: right;">
                            <button class="pe-btn pe-btn-blue waitItemFilter" style="margin-right: 270px;"
                                    type="button">筛选
                            </button>
                        </div>
                    </div>
                </div>
                <div class="pe-panel-body pe-selector-content">
                    <div class="pe-selector-available">
                        <div class="pe-panel pe-panel-info">
                            <div class="pe-panel-header">
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
                        <button class="pe-btn pe-btn-blue pe-btn-block" type="button" data-role="select">选择
                            &gt;</button>
                        <button class="pe-btn pe-btn-blue pe-btn-block" type="button" data-role="selectAll">
                            全选&gt;&gt;</button>
                        <button class="pe-btn pe-btn-blue pe-btn-block" type="button" data-role="remove">&lt; 移除
                        </button>
                        <button class="pe-btn pe-btn-blue pe-btn-block" type="button" data-role="removeAll">&lt;&lt;清空
                        </button>
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
        <div class="pe-classify-wrap floatL" style="min-height: 490px;">
            <div class="pe-classify-top over-flow-hide pe-form ">
                <span class="floatL pe-classify-top-text">按部门筛选</span>
                <label class="floatR pe-checkbox" style=" padding-right: 15px;">
                    <span class="iconfont icon-checked-checkbox peChecked"></span>
                    <input id="itemIncludeDom" class="pe-form-ele" type="checkbox" value="true"
                           name="organize.include" checked="checked"/><span class="include-subclass">包含子类</span>
                </label>
            </div>
            <div class="pe-classify-tree-wrap">
                <div class="pe-tree-search-wrap">
                <#--复用时，保留下面的input单独classname 'pe-tree-form-text'-->
                    <input class="pe-tree-form-text" type="text" placeholder="请输入部门名称">
                <#--<span class="pe-placeholder">请输入题库名称</span>--><#--备用,误删-->
                    <span class="iconfont pe-tree-search-btn icon-search-magnifier"></span>
                </div>
                <div class="pe-select-tree-content-wrap">
                <#--<div class="pe-tree-main-wrap">-->
                <#--&lt;#&ndash;pe-no-manage-tree为非管理树类添加的样式，是管理类的树，无需此class&ndash;&gt;-->
                <#--<ul id="peZtreeMain" class="ztree pe-select-tree-container " data-type="km"></ul>-->
                <#--</div>-->
                    <div class="pe-tree-content-wrap">
                        <div class="pe-tree-main-wrap">
                            <div class="node-search-empty">暂无</div>
                        <#--pe-no-manage-tree为非管理树类添加的样式，是管理类的树，无需此class-->
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
</form>

<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.core.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript"
        src="${resourcePath!}/web-static/proExam/js/plugins/jquery.mCustomScrollbar.concat.min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js?_v=${(resourceVersion)!}"></script>

<script type="text/template" id="peItemTpl">
    <#--三行-->
    <%for(var i=0;i < list.length ;i++){%>
    <li title="<%=list[i].userName%>" data-index="<%=i%>">
        <div class="wrap" style="display: block;">
            <span class="pe-selector-user"><%=list[i].userName%></span>
            <span class="pe-selector-user" style="float: right"><%=list[i].loginName%></span>
        </div>
    </li>
    <%}%>
</script>
<script type="text/template" id="peSelectorPagination">

    <button class="pe-selector-page-pre-btn" <%= page==0?"disabled='disabled'":""%> type="button"><i
            class="iconfont icon-page-pre"></i></button>
    <%if(Math.ceil(total/pageSize) === 0){%>
        <input class="pe-selector-page-num" type="number" data-page="<%=page%>" min="1" max="1"
           value="1"/>
    <%}else{%>
       <input class="pe-selector-page-num" type="number" data-page="<%=page%>" min="1" max="<%=Math.ceil(total/pageSize)%>"
           value="<%=page+1%>"/>
    <%}%>
    <label>/<%=Math.ceil(total/pageSize)%></label>
    <button class="pe-selector-page-next-btn" <%= Math.ceil(total/pageSize)==(page+1)?"disabled='disabled'":""%> type="button">
    <i
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
        var arrangeId = '${(examArrange.id)!}';
        var examId = '${(examArrange.exam.id)!}';
        var selector = {
            availableData: [],
            selectData: [],
            URLS: {
                available: '${ctx!}/ems/exam/manage/searchWaitUser?id=' + arrangeId + '&exam.id=' + examId,
                selected: '${ctx!}/ems/exam/manage/searchSelectUser?id=' + arrangeId + '&exam.id=' + examId,
                save: '${ctx!}/ems/exam/manage/saveExamUser',
                remove: '${ctx!}/ems/exam/manage/deleteExamUser'
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
                        page.page = (data.page-1);
                        page.pageSize = data.pageSize;
                        $('.pe-selector-selected .pe-selector-exam-list').html(_.template($('#peItemTpl').html())({list: page.rows}));
                        $('#peSelectedNum').html(page.total);
                        _this.renderPagination($('.pe-selector-selected .pe-selector-pagination'), page);
                        localStorage.setItem('ARRANGE_USER_count_' + arrangeId, page.total);
                    }
                });
            },
            save: function (data,selectFlag) {
                var _this = this;
                var referIds = [];
               /* if($.isEmptyObject(data)){
                    PEMO.DIALOG.tips({
                        content:'请至少选择一位人员',
                        btn: ['我知道了'],
                        yes: function (shiIndex) {
                            layer.close(shiIndex);
                        }
                    });
                    selectFlag = true;
                    return false;
                }*/
                for (var key in data) {
                    referIds.push(data[key]);
                }

                data = {
                    'id': arrangeId,
                    'exam.id': examId,
                    'referIds': JSON.stringify(referIds),
                    'examUserType': 'USER'
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
                        selectFlag = true;
                    },
                    error: function () {
                        alert('error');
                        selectFlag = true;
                    }
                });
            },
            remove: function (data) {
                var _this = this;
                var referIds = [];
                if($.isEmptyObject(data)){
                    PEMO.DIALOG.tips({
                        content:'请至少选择一位人员',
                        btn: ['我知道了'],
                        yes: function (shiIndex) {
                            layer.close(shiIndex);
                        }
                    });
                    return false;
                }
                for (var key in data) {
                    referIds.push(data[key]);
                }

                data = {'id': arrangeId, 'exam.id': examId, 'referIds': JSON.stringify(referIds)};
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
                            PEMO.DIALOG.alert({
                                content: data.message,
                                btn: ['我知道了'],
                                yes: function () {
                                    layer.closeAll();
                                }
                            })
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
                var settingUrl = {
                    dataUrl: '${ctx}/uc/role/manage/listOrganizeTree',
                    clickNode: function (treeNode) {
                        if (treeNode) {
                            $('input[name="organize.id"]').val(treeNode.id);
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
                    _this.renderAvailable();
                });

                var selectFlag = true;
                //选择
                $('button[data-role="select"]').click(function () {
                    var itemsObj = {};
                    $('.pe-selector-available li.selected').each(function (index, item) {
                        var num = $(this).attr("data-index");
                        itemsObj['users[' + index + '].id'] = _this.availableData[num].id;
                    });
                    if($.isEmptyObject(itemsObj)){
                        PEMO.DIALOG.tips({
                            content:'请至少选择一位人员',
                            btn: ['我知道了'],
                            yes: function (shiIndex) {
                                layer.close(shiIndex);
                            }
                        });
                        selectFlag = true;
                        return;
                    }

                    if(selectFlag==false){
                        PEMO.DIALOG.tips({
                            content:'数据传输中,请稍等！',
                            btn: ['我知道了'],
                            time:2500,
                            yes: function (shiIndex) {
                                layer.close(shiIndex);
                            }
                        });
                        selectFlag = true;
                        return;
                    }
                    selectFlag = false;
                    _this.save(itemsObj,selectFlag);
                });

                //全选
                $('button[data-role="selectAll"]').click(function () {
                    if(selectFlag==false){
                        PEMO.DIALOG.tips({
                            content:'数据传输中,请稍等！',
                            btn: ['我知道了'],
                            time:2500,
                            yes: function (shiIndex) {
                                layer.close(shiIndex);
                            }
                        });
                        selectFlag = true;
                        return;
                    }

                    var itemsObj = {};
                    for (var i = 0; i < _this.availableData.length; i++) {
                        itemsObj['users[' + i + '].id'] = _this.availableData[i].id;
                    }
                    selectFlag = false;
                    _this.save(itemsObj,selectFlag);
                });

                //移除
                $('button[data-role="remove"]').click(function () {
                    var itemsObj = {};
                    $('.pe-selector-selected li.selected').each(function (index, item) {
                        var num = $(this).attr("data-index");
                        itemsObj['users[' + index + '].id'] = _this.selectData[num].id;
                    });
                    _this.remove(itemsObj);
                });

                //清空
                $('button[data-role="removeAll"]').click(function () {
                    var itemsObj = {};
                    for (var i = 0; i < _this.selectData.length; i++) {
                        itemsObj['users[' + i + '].id'] = _this.selectData[i].id;
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


                $('.waitItemFilter').click(function () {
                    var pageElem = document.searchForm.elements['page'];
                    pageElem.value = 1;
                    _this.renderAvailable();
                });

            }
        };

        selector.init();
    });
    /*$(function(){
        if(!placeholderSupport()){   // 判断浏览器是否支持 placeholder
            $('#keyword').focus(function() {
                var input = $(this);
                if (input.val() == input.attr('placeholder')) {
                    input.val('');
                    input.removeClass('placeholder');
                }
            }).blur(function() {
                var input = $(this);
                if (input.val() == '' || input.val() == input.attr('placeholder')) {
                    input.addClass('placeholder');
                    input.val(input.attr('placeholder'));
                }
            });

            $('#keyword').get(0).focus();
            $('#keyword').get(0).blur();
        };
    })
    function placeholderSupport() {
        return 'placeholder' in document.createElement('input');
    }
*/
</script>
</body>
</html>