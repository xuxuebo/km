<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>选择器</title>
    <link rel="shortcut icon" href="${(resourcePath+icoUrl)!'${resourcePath!}/web-static/proExam/images/pe_ico_32.ico'}" type="image/x-icon" />
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css"/>
</head>
<body class="pe-selector-body" style="padding: 0 20px;">
<form id="searchForm" action="javascript:;" name="searchForm" style="overflow: hidden;">
    <input type="hidden" name="organize.id" value="${(organize.id)!}"/>
    <input type="hidden" name="page" value="1"/>
    <input type="hidden" name="pageSize" value="10"/>

    <div class="selector-exam-organize-panel">
        <div class="pe-selector-wrap">
            <div class="pe-panel pe-panel-default">
                <div class="pe-panel-body pe-selector-content">
                    <div class="pe-selector-available">
                        <div class="pe-panel pe-panel-info">
                            <div class="pe-classify-wrap">
                                <div class="pe-classify-top over-flow-hide pe-form">
                                    <span class="floatL pe-classify-top-text">按类别筛选</span>
                                    <#--<button type="button" title="管理类别" class="floatR iconfont icon-hide-category"></button>-->
                                    <span class="floatR pe-checkbox pe-check-by-list" style="margin-right:14px;" >
                                      <span class="iconfont icon-checked-checkbox peChecked"></span>
                                      <input id="isOrganizeInclude" class="pe-form-ele is-organize-include" type="checkbox" value="true" name="itemBank.category.include" checked="checked" /><span class="include-subclass">包含子类</span>
                                   </span>
                                </div>
                                <div class="pe-classify-tree-wrap">
                                    <div class="pe-tree-search-wrap">
                                    <#--复用时，保留下面的input单独classname 'pe-tree-form-text'-->
                                        <input class="pe-tree-form-text" type="text">
                                    <#--<span class="pe-placeholder">请输入题库名称</span>--><#--备用,误删-->
                                        <span class="iconfont pe-tree-search-btn icon-search-magnifier"></span>
                                    </div>
                                    <div class="pe-tree-content-wrap">

                                        <div class="pe-tree-main-wrap">
                                            <div class="node-search-empty">暂无</div>
                                        <#--pe-no-manage-tree为非管理树类添加的样式，是管理类的树，无需此class-->
                                            <ul id="peZtreeMain" class="ztree pe-tree-container" data-type="km"></ul>
                                        </div>
                                    <#--题库管理根据需要是否显示-->
                                    <#--<div class="pe-control-tree-btn iconfont icon-set">管理类别</div>-->
                                    </div>
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
                                <div class="pe-selector-list-wrap" style="background:none;">
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
</form>
<#--用来暂存点击左边没有selected属性的树节点对象-->
<input type="hidden" name="saveSingleNode" value=""/>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.core.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript"
        src="${resourcePath!}/web-static/proExam/js/plugins/jquery.mCustomScrollbar.concat.min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>

<script type="text/template" id="peItemTpl">
    <#--三行-->
    <%for(var i=0;i < list.length ;i++){%>
    <li title="<%=list[i].organize.organizeName%>" data-index="<%=i%>" data-pId="<%=list[i].organize.pId%>" data-id="<%=list[i].organize.id%>">
        <div class="wrap">
            <span><%=list[i].organize.organizeName%></span>
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

        //兼容IE8的空console对象
        window.console = window.console || {
                    log: $.noop,
                    debug: $.noop,
                    info: $.noop,
                    warn: $.noop,
                    exception: $.noop,
                    assert: $.noop,
                    dir: $.noop,
                    dirxml: $.noop,
                    trace: $.noop,
                    group: $.noop,
                    groupCollapsed: $.noop,
                    groupEnd: $.noop,
                    profile: $.noop,
                    profileEnd: $.noop,
                    count: $.noop,
                    clear: $.noop,
                    time: $.noop,
                    timeEnd: $.noop,
                    timeStamp: $.noop,
                    table: $.noop,
                    error: $.noop
                };
        var arrangeId = '${(examArrange.id)!}';
        var examId = '${(examArrange.exam.id)!}';
        var selector = {
            availableData: [],
            selectData: [],
            URLS: {
                available: '${ctx!}/ems/exam/manage/listOrgTree?id='+arrangeId+'&exam.id='+examId,
                selected: '${ctx!}/ems/exam/manage/searchSelectOrg?id=' + arrangeId + '&exam.id=' + examId,
                save: '${ctx!}/ems/exam/manage/saveExamUser',
                remove: '${ctx!}/ems/exam/manage/deleteExamUser'
            },
            renderPagination: function (container, page) {
                container.html(_.template($('#peSelectorPagination').html())(page));
            },
            renderAvailable: function (selectNodes) {
                /*这里渲染树*/
                for(var k =0,len = selectNodes.length;k<len;k++){
                    $('#peZtreeMain #' + selectNodes[k].tId + '_a').addClass('isHasSelected');
                }
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
            save: function (dataArry) {
                /*此处dataArry是包含所有选择节点的对象数组集合*/
                var _this = this;
                var referIds = [];
                /*选中节点的对象集合*/
                var paramData = [];
                /*选中树的节点新的集合*/
                var selectNodes = [];
              //  if(dataArry[0] && !dataArry[0].pId){
                        //是根节点，选择的全部，无需在全部循环了,传递时根节点id
               //     paramData.push(dataArry[0].id);
                //}else{
                    for(var j =0,len=dataArry.length;j<len;j++){
                        dataArry[j].selected = true;
                        if(dataArry[j].pId){
                            paramData.push(dataArry[j].id);
                        }
                        selectNodes.push(dataArry[j]);
                    }
                //}

                var params = {
                    'id': arrangeId,
                    'exam.id': examId,
                    'referIds': JSON.stringify(paramData),
                    'examUserType': 'ORGANIZE'
                };

                //测试用提取出来，开发时删除
//                _this.renderAvailable(selectNodes);
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    data: params,
                    url: selector.URLS.save,
                    success: function (data) {
                        if (data.success) {
                            _this.renderAvailable(selectNodes);
                            _this.renderSelected();
                            $('input[name="saveSingleNode"]').data('singleNode',{});
                        } else {
                            alert('保存出错');
                        }
                    },
                    error: function () {
                        alert('error');
                    }
                });
            },
            getChildrenNode:function(data){
                var thisArry = [];
                function getNodeChildren(t){
                    for(var i = 0,len = t.length;i<len;i++){
                        if(!t[i].selected){
                            thisArry.push(t[i]);
                        }
                        if(t[i] && t[i].children){
                            getNodeChildren(t[i].children);
                        }
                    }
                }
                getNodeChildren(data);
                return thisArry;
            },
            remove: function (dataIdArry) {
                var _this = this;
                if(!dataIdArry || dataIdArry.length <= 0){
                    PEMO.DIALOG.tips({
                        content:'请选择部门',
                        time:2000
                    });

                    return false;
                }

                data = {'id': arrangeId, 'exam.id': examId, 'referIds': JSON.stringify(dataIdArry)};
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    data: data,
                    url: selector.URLS.remove,
                    success: function (data) {
                        if (data.success) {
                            _this.renderSelected();
                            var treeObj = $.fn.zTree.getZTreeObj("peZtreeMain");
                            for(var n=0,len = dataIdArry.length;n<len;n++){
                                var thisSelectedNode = treeObj.getNodeByParam("id", dataIdArry[n], null);
                                 thisSelectedNode.selected = '';
                                $('#peZtreeMain #' + thisSelectedNode.tId + '_a').removeClass('isHasSelected curSelectedNode');

                            }
                        } else {
                            alert('保存出错');
                        }
                    },
                    error: function () {
                        alert('error');
                    }
                });


            },

            init: function () {
                var _this = this;
                var settingUrl = {
                    dataUrl: _this.URLS.available,
                    clickNode: function (treeNode) {
                        if(treeNode && !treeNode.selected) {
                            $('input[name="saveSingleNode"]').data('singleNode',treeNode);
                        }
                    }
                };

                PEMO.ZTREE.initTree('peZtreeMain', settingUrl);
                PEBASE.peFormEvent('checkbox');
                _this.renderSelected();
                _this.initEvent();

            },
            initEvent: function () {
                var _this = this;
                //交互
                $('.pe-selector-available,.pe-selector-selected').on('click', "li", function (e) {
                    $(this).toggleClass("selected");
                });

                //选择
                $('button[data-role="select"]').click(function () {
                    var thisNode = $('input[name="saveSingleNode"]').data('singleNode');
                    if(!thisNode || $.isEmptyObject(thisNode)){
                        PEMO.DIALOG.tips({
                            content:'请选择部门',
                            time:2000
                        });
                        return false;
                    }
                    var itemsObj = [];
                    itemsObj.push($('input[name="saveSingleNode"]').data('singleNode'));

                    /*如果勾选了包含子节点并且是可选的则把其children的节点也循环进来*/
                    if($('input[name="itemBank.category.include"]').prop('checked') && itemsObj.length !=0 && itemsObj[0].children){
                        itemsObj = $.merge(itemsObj,selector.getChildrenNode(itemsObj[0].children));
                    }
                    _this.save(itemsObj);
                });
                var comExam = $(window.parent.document).find('input[name="comExam"]').val();

                //全选
                $('button[data-role="selectAll"]').click(function () {
                    if(!$('#peZtreeMain_1_a').hasClass('isHasSelected')){
                        var itemsAllObj = [],treeObj = $.fn.zTree.getZTreeObj("peZtreeMain"),rootNode = treeObj.getNodes();//根节点\
                        $('input[name="saveSingleNode"]').data('singleNode',rootNode[0]);
                        itemsAllObj.push(rootNode[0]);
                        itemsAllObj = $.merge(itemsAllObj,selector.getChildrenNode(itemsAllObj[0].children));
                        _this.save(itemsAllObj);
                    }else{
                        PEMO.DIALOG.tips({
                            content:'已选全部',
                            time:2000
                        })
                    }

                });

                //移除
                $('button[data-role="remove"]').click(function () {
                     var itemsObj = [];
                    $('.pe-selector-selected li.selected').each(function (index, item) {
                        var thisItemId = $(this).data('id');//tom
                        var num = $(this).attr("data-index");
//                        itemsObj['users[' + index + '].id'] = _this.selectData[num].id;
                        itemsObj.push( _this.selectData[num].organize.id);
                    });

                    /*移除的时候，需要节点的id*/
                    _this.remove(itemsObj);
                });

                //清空
                $('button[data-role="removeAll"]').click(function () {
                    var itemsObj = [];
                    for (var i = 0; i < _this.selectData.length; i++) {
//                        itemsObj['users[' + i + '].id'] = _this.selectData[i].id;
                        itemsObj.push( _this.selectData[i].organize.id);
                    }

                    _this.remove(itemsObj);
                });


                $('.waitItemFilter').click(function () {
                    _this.renderAvailable();
                });

                //类别点击筛选事件
                $('.pe-check-by-list').off().click(function(){
                    var iconCheck = $(this).find('span.iconfont');
                    var thisRealCheck = $(this).find('input[type="checkbox"]');
                    if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                        iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                        thisRealCheck.prop('checked', 'checked');//这里在ie8下目前会报错“意外的调用了方法”,待解决
                    }else{
                        iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                        thisRealCheck.removeProp('checked');
                    }
                });

            }
        };

        selector.init();
    });


</script>
</body>
</html>