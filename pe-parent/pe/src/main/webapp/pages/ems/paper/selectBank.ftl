<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>选择器</title>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css"/>
</head>
<body class="pe-selector-body">
<div class="pe-panel-select-bank-wrap">
    <form id="searchBankForm">
        <input type="hidden" name="category.id" value="${(category.id)!}"/>
        <input type="hidden" name="itemStatus" value="ENABLE"/>
        <input type="hidden" name="itemAttribute" value="${itemAttribute!}"/>
        <input type="hidden" name="viewEqualZero" value="false"/>
        <div class="panel-select-bank-middle over-flow-hide">
            <div class="pe-panel-bank-left floatL">
                <div class="pe-classify-wrap floatL">
                    <div class="pe-classify-top over-flow-hide pe-form ">
                        <span class="floatL pe-classify-top-text">按类别筛选</span>
                        <label class="floatR pe-checkbox pe-check-by-list">
                            <span class="iconfont icon-checked-checkbox peChecked"></span>
                            <input id="itemIncludeDom" class="pe-form-ele" type="checkbox" value="true"
                                   name="category.include" checked="checked"/><span class="include-subclass">包含子类</span>
                        </label>
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
            <div class="pe-panel-bank-right floatL">
                <div class="pe-panel-bank-right-top">
                    <label class="pe-table-form-label pe-question-label">
                         <span class="pe-input-tree-text">
                             <span>题库名称:</span>
                        </span>
                        <input class="pe-table-form-text" value="" type="text" name="bankName" maxlength="50">
                    </label>
                    <button type="button" class="pe-btn pe-btn-blue pe-select-bank-btn">筛选</button>
                </div>
                <div class="pe-panel-bank-right-content">

                </div>
                <span class="pe-loading-tip">加载中...</span>
            </div>
        </div>
    </form>

    <div class="pe-panel-bank-footer">
        <div class="has-select-bank-tip">已选择题库:</div>
        <div class="pe-bank-slide-wrap">
            <a href="javascript:;" class="has-select-bank-prev-btn iconfont icon-a-page disabled"></a>
            <a href="javascript:;" class="has-select-bank-next-btn iconfont icon-next-page"></a>
            <div class="has-select-bank-item-wrap">
                <div class="select-bank-items-content">
                    <div class="select-bank-wrap-content">
                    </div>
                </div>
            </div>
        </div>
        <button type="button" class="select-bank-ok-btn pe-btn pe-btn-green floatR">确定</button>
    </div>
</div>

<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.core.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.mCustomScrollbar.concat.min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>
<script type="text/template" id="dialogSelectBank">
    <%for(var i=0,len = data.length;i
    <len;i++){%>
    <div class="pe-select-bank-item-wrap <%if (_.contains(selectBankIds,data[i].id)){%>curSelect<%}%>" data-count="<%=data[i].allNumber%>" data-id="<%=data[i].id%>">
        <span class="pe-select-bank-check-icon iconfont icon-solid-circle-chekced"></span>
        <h3 class="select-bank-name" title="<%=data[i].bankName%>"><%=data[i].bankName%></h3>
        <div class="select-bank-tip-msg">
            <span class="select-bank-num">总题数:<span style="margin-left:4px;"><%=data[i].allNumber%></span></span>
            <a href="${ctx!}/ems/template/manage/viewBankItemPage?itemBankId=<%=data[i].id%>&itemAttribute=${(itemAttribute)!}" target="_blank" class="select-bank-preview-item">预览</a>
        </div>
        <div class="select-bank-type-num">
            <dl class="select-bank-detail-type-wrap">
                <dt class="detail-type-name floatL">单选:</dt>
                <dd class="detail-type-name"><%=data[i].singleNumber%></dd>
            </dl>
            <dl class="select-bank-detail-type-wrap">
                <dt class="detail-type-name floatL">多选:</dt>
                <dd class="detail-type-name"><%=data[i].multiNumber%></dd>
            </dl>
            <dl class="select-bank-detail-type-wrap select-indefinite-type">
                <dt class="detail-type-name floatL">不定项选择:</dt>
                <dd class="detail-type-name"><%=data[i].indefiniteNumber%></dd>
            </dl>
            <dl class="select-bank-detail-type-wrap">
                <dt class="detail-type-name floatL">判断:</dt>
                <dd class="detail-type-name"><%=data[i].judgmentNumber%></dd>
            </dl>
            <dl class="select-bank-detail-type-wrap">
                <dt class="detail-type-name floatL">填空:</dt>
                <dd class="detail-type-name"><%=data[i].fillNumber%></dd>
            </dl>
            <dl class="select-bank-detail-type-wrap">
                <dt class="detail-type-name floatL">问答:</dt>
                <dd class="detail-type-name"><%=data[i].questionsNumber%></dd>
            </dl>
        </div>
    </div>
    <%}%>
</script>
<script type="text/template" id="checkedBankItem">
    <div class="item-wrap" data-id="<%=data.id%>">
        <a href="javascript:;" class="selected-bank-name-wrap floatL">
            <span class="selected-bank-name" data-id="<%=data.id%>" title="<%=data.bankName%>"><%=data.bankName%></span>
            <span class="iconfont icon-inputDele"></span>
        </a>
    </div>
</script>
<script type="text/javascript">
    var index = 0;
    var pageSize = 12;
    $(function () {
        var selectBank = {
            initBind: function () {
                //类别点击筛选事件
                $('.pe-check-by-list').off().click(function (e) {
                    var e = e || window.event;
                    e.stopPropagation();
                    e.preventDefault();
                    var iconCheck = $(this).find('span.iconfont');
                    var thisRealCheck = $(this).find('input[type="checkbox"]');
                    if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                        iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                        thisRealCheck.prop('checked', 'checked');
                    } else {
                        iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                        thisRealCheck.removeProp('checked');
                    }
                    $('.pe-panel-bank-right-content').mCustomScrollbar('destroy');
                    selectBank.loadBank(1);
                });

                //点击题库选择事件
                $('.pe-panel-bank-right-content').delegate('.pe-select-bank-item-wrap', 'click', function () {
                    var thisCount=$(this).data('count');
                    if(thisCount<=0){
                        return false;
                    }

                    var showWidth = $('.has-select-bank-item-wrap').width() + 5;//展示区域的那个div,45为微调移动的距离
                    var thisId = $(this).data('id');
                    var thisName = $(this).find('.select-bank-name').html();
                    //$(this).toggleClass('curSelect');
                    if ($(this).hasClass('curSelect')) {
                        //$('.select-bank-items-content').find()
                        $('.select-bank-items-content').find('[data-id='+thisId +']').remove();
                        selectBank.renderPostion();
                        $(this).removeClass('curSelect');
                    } else {
                        var selectedItm = {"id": thisId, "bankName": thisName};
                        $('.select-bank-items-content').find('.select-bank-wrap-content').append(_.template($('#checkedBankItem').html())({data: selectedItm}));
                        selectBank.renderPostion();
                        var newLeftPos = Math.abs($('.select-bank-items-content').position().left);
                        var newNum = Math.floor(newLeftPos / showWidth);
                        var itemAllNum = $('.select-bank-items-content').find('.item-wrap').length;
                        if ((itemAllNum - 6 * newNum) > 6) {
                            $('.has-select-bank-next-btn').removeClass('disabled');
                        }
                        $(this).addClass('curSelect');
                    }
                });

                //下方已选题库删除按钮点击事件
                $('.select-bank-items-content').delegate('.icon-inputDele', 'click', function () {
                    var thisDeleId = $(this).parents('.item-wrap').data('id');
                    $('.pe-panel-bank-right-content').find('[data-id='+thisDeleId+']').removeClass('curSelect');
                    $(this).parents('.item-wrap').remove();
                    selectBank.renderPostion();
                });

                //显示的宽度668px;$('.has-select-bank-item-wrap').width()
            <#--点击移动类别轮播交互-->
                $('.has-select-bank-next-btn').click(function () {
                    var showWidth = $('.has-select-bank-item-wrap').width() + 5;//展示区域的那个div,45为微调移动的距离
                    var itemAllNum = $('.select-bank-items-content').find('.item-wrap').length;
                    var leftPos = Math.abs($('.select-bank-items-content').position().left);
                    var num = Math.floor(leftPos / showWidth);
                    var isNextOver = false;
                    if (!isNextOver && !$('.select-bank-items-content').is(":animated")) {
                        if ((itemAllNum - 6 * num) <= 6) {
                            return;
                        } else {
                            index++;
                            isNextOver = true;
                            $('.select-bank-items-content').animate({left: -index * showWidth}, 'fast', function () {
                                var newLeftPos = Math.abs($('.select-bank-items-content').position().left);
                                var newNum = Math.floor(newLeftPos / showWidth);
                                isNextOver = false;
                                if ((itemAllNum - 6 * newNum) <= 6) {
                                    $('.has-select-bank-next-btn').addClass('disabled');
                                }
                                if ($('.select-bank-items-content').position().left < 0) {
                                    $('.has-select-bank-prev-btn').removeClass('disabled');
                                }

                            })
                        }
                    }
                });

                //向左移动
                $('.has-select-bank-prev-btn').click(function () {
                    var showWidth = $('.has-select-bank-item-wrap').width() + 5;//展示区域的那个div,45为微调移动的距离
                    var itemAllNum = $('.select-bank-items-content').find('.item-wrap').length;
                    var leftPos = Math.abs($('.select-bank-items-content').position().left);
                    var num = Math.floor(leftPos / showWidth);
                    var isPreOver = false;
                    if (!isPreOver && !$('.select-bank-items-content').is(":animated")) {
                        if (leftPos < showWidth) {
                            return false;
                        } else {
                            isPreOver = true;
                            $('.select-bank-items-content').animate({left: $('.select-bank-items-content').position().left + showWidth}, 'fast', function () {
                                var newLeftPos = Math.abs($('.select-bank-items-content').position().left);
                                var newNum = Math.floor(newLeftPos / showWidth);
                                isPreOver = false;
                                if (newLeftPos <= 40) {
                                    $('.has-select-bank-prev-btn').addClass('disabled');
                                }
                                if ((itemAllNum - 6 * newNum) > 6) {
                                    $('.has-select-bank-next-btn').removeClass('disabled');
                                }
                                index--;
                            })
                        }
                    }
                });


                $('.pe-select-bank-btn').on('click',function(){
                    $('.pe-panel-bank-right-content').mCustomScrollbar('destroy');
                    selectBank.loadBank(1);
                });
            },

            isNeedMargin: function (dom) {
                for (var i = 0, len = dom.length; i < len; i++) {
                    if ((i + 1) % 2 === 0) {
                        $(dom[i]).css('marginRight', '0');
                    }
                }
            },

            //已选的题库标签位置渲染函数
            renderPostion: function (newDom) {
                var itemWidth = 198;
                var itemLen = $('.item-wrap');
                if (!itemLen.get(0)) {
                    return false;
                } else {
                    if (itemLen.get(0) && itemLen.length < 4) {
                        itemLen.removeClass('first-line second-line').addClass('less-four');
                    } else if (itemLen.length < 7) {
                        $('.item-wrap:lt(3)').removeClass('less-four').addClass('first-line');
                        $('.item-wrap:lt(6):gt(2)').removeClass('less-four').addClass('second-line');
                    } else {
                        $('.select-bank-items-content').find('.select-bank-wrap-content').find('.item-wrap:even').removeClass('less-four second-line').addClass('first-line');
                        $('.select-bank-items-content').find('.select-bank-wrap-content').find('.item-wrap:odd').removeClass('less-four first-line').addClass('second-line');
                    }
                }
                var newLen = $('.select-bank-items-content').find('.select-bank-wrap-content').find('.item-wrap');
                var oddIndex = 0;//基数
                var evenIndex = 0;//偶数
                for (var i = 0; i < newLen.length; i++) {
                    if (newLen.eq(i).hasClass('first-line')) {
                        newLen.eq(i).css('left', oddIndex * itemWidth);
                        oddIndex++;
                    } else {
                        newLen.eq(i).css('left', evenIndex * itemWidth);
                        evenIndex++;
                    }
                }
            },

            init: function () {
                //ie9不支持Placeholder问题
//                PEBASE.isPlaceholder();
                var settingUrl = {
                    dataUrl: '${ctx}/ems/itemBank/manage/listTree',
                    clickNode: function (treeNode) {
                        $('input[name="category.id"]').val(treeNode.id);
                        $('.pe-panel-bank-right-content').mCustomScrollbar('destroy');
                        selectBank.loadBank(1);
                    }
                };

                PEMO.ZTREE.initTree('peZtreeMain', settingUrl);
                selectBank.isNeedMargin($('.pe-select-bank-item-wrap'));
                //初始化渲染位置;
                selectBank.renderPostion();
                PEBASE.peFormEvent('checkbox');
                $('.bank-list',parent.document).each(function (index, ele) {
                    var id = $(ele).find('input[name="itemBankId"]').val();
                    var bankName = $(ele).attr('title');
                    $('.select-bank-items-content').find('.select-bank-wrap-content').append(_.template($('#checkedBankItem').html())({data: {id:id,bankName:bankName}}));
                    selectBank.renderPostion();
                });

                $('.pe-panel-bank-right-content').mCustomScrollbar('destroy');
                selectBank.loadBank(1);
            },

            loadBank:function(page){
                PEBASE.ajaxRequest({
                    url : '${ctx!}/ems/itemBank/manage/search?sort=ALL&page='+page+'&pageSize='+pageSize,
                    data : $('#searchBankForm').serialize(),
                    success : function(data){
                        var selectBankIds = [];
                        $('.selected-bank-name').each(function(index,ele){
                            selectBankIds.push($(ele).data('id'));
                        });

                        $('.pe-panel-bank-right-content').html(_.template($('#dialogSelectBank').html())({selectBankIds:selectBankIds,data: data.rows}));
                        selectBank.initScroll(page);
                    }
                });
            },

            initScroll:function(page){
                var initPageNum = page;
                //模拟滚动条
                $('.pe-panel-bank-right-content').mCustomScrollbar({
                    axis: "y",
                    theme: "dark-3",
                    scrollbarPosition: "inside",
                    setWidth: '632px',
                    advanced: {updateOnContentResize: true},
                    callbacks: {
                        onUpdate: function () {
                        },
                        onTotalScroll:function(){
                            initPageNum++;
                            $('.pe-loading-tip').show();
                            $.ajax({
                                url: '${ctx!}/ems/itemBank/manage/search?sort=ALL&page='+initPageNum+'&pageSize='+pageSize,
                                dataType:'json',
                                data:$('#searchBankForm').serialize(),
                                success:function(data){
                                    var selectBankIds = [];
                                    $('.selected-bank-name').each(function(index,ele){
                                        selectBankIds.push($(ele).data('id'));
                                    });

                                    if(data && data.rows.length > 0){
                                        $('.pe-panel-bank-right-content').find('.mCSB_container').append(_.template($('#dialogSelectBank').html())({selectBankIds:selectBankIds,data: data.rows}));
                                        $('.pe-loading-tip').hide();
                                        $('.pe-panel-bank-right-content').mCustomScrollbar("update");
                                    }else{
                                        $('.pe-loading-tip').html('没有更多数据了呢');
                                        setTimeout(function(){
                                            $('.pe-loading-tip').hide().html('加载中...');
                                        },1500)
                                    }
                                }

                            })
                        }

                    }
                });
            }
        };

        selectBank.init();
        selectBank.initBind();
    });
</script>
</body>
</html>