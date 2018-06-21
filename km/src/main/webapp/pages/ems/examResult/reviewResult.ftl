<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<#--公用头部-->
<header class="pe-public-top-nav-header" data-id="">
    <div class="pe-top-nav-container">
        <ul class="clearF">
            <li class="pe-result-detail floatL">成绩复评<span
                    class="pe-review-note">可针对客观题和主观题复评，更改试题得分；客观题修改得分后，不影响答题对错。</span></li>
        </ul>
    </div>
</header>
    <div class="pe-container-main review-result-wrap" >
    <div class="pe-answer-nav-top" style="overflow:visible;z-index:1990;">
        <div style="position:relative;height:100%;">
            <div class="pe-complete-left">
                <h2 class="pe-answer-title">${(exam.examName)!''}</h2>
            </div>
            <a class="tip-bubble iconfont icon-more floatR">
            <#--<span class="review-markUser">评卷人：<span></span></span>-->
            <#--<span class="review-reviewUser">复评人：<span></span></span>-->
            </a>
            <div class="mark-user-panel">
                <dl class="pe-online-item-wrap mark-user-dl">
                    <dt class="pe-online-test">评卷人:</dt>
                    <dd class="pe-online-score"></dd>
                </dl>
                <dl class="pe-online-item-wrap review-user-dl">
                    <dt class="pe-online-test">复评人:</dt>
                    <dd class="pe-online-score"></dd>
                </dl>
            </div>
        </div>
    </div>
    <div class="pe-answer-content-left-wrap" style="margin-top:106px;margin-bottom:30px;width:850px;">

    </div>
    <div class="pe-answer-content-right-wrap" style="top:170px;left:1268px;width:334px;">
        <div class="pe-view-contain">
            <form id="queryForm">
                <input type="hidden" name="examArrange.id" value="${(arrangeId)!}"/>
                <div class="pe-view-form">
                    <p class="pe-reviewR-des">共有<span class="user-total-dom"></span>人已评卷,可复评成绩</p>
                    <dd class="pe-stand-filter-label-wrap">
                        <label class="floatL pe-checkbox pe-check-by-list" for="" style="margin-right:15px;">
                            <span class="iconfont icon-checked-checkbox peChecked"></span>
                            <input class="pe-form-ele" checked="checked" type="checkbox"
                                   name="passStatus" value="true">通过
                        </label>
                        <label class="floatL pe-checkbox pe-check-by-list" for="" style="margin-right:15px;">
                            <span class="iconfont icon-checked-checkbox peChecked"></span>
                            <input class="pe-form-ele" checked="checked" type="checkbox"
                                   name="passStatus" value="false">未通过
                        </label>
                    </dd>
                </div>
            </form>
            <div class="pe-view-table-panel">
                <div class="pe-stand-table-main-panel">
                    <div class="pe-stand-table-wrap pe-dynamic-wrap" style="max-height:500px;overflow:auto;">
                    </div>
                    <div class="table-second-pagination-wrap">
                        <ul class="layer-page-wrap">
                            <li class="page-left"><a class=" iconfont icon-page-pre disabled"></a></li>
                            <li class="page-go"><input type="text" class="page-go-input" value="1"/>/<span class="page-total">5</span></li>
                            <li class="page-right"><a class=" iconfont icon-page-next"></a></li>
                            <li><select class="layer-page-drop-down dropdown">
                                <option value="10" selected>10</option>
                                <option value="20">20</option>
                                <option value="50">50</option>
                                <option value="100">100</option>
                            </select></li>
                            <input name="saveLayerPaginationPageSize" type="hidden" value="10" />
                            <input name="saveLayerPaginationPage" type="hidden" value="1" />
                        </ul>
                    </div>
                 </div>
                </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
<button type="button" class="pe-btn pe-btn-primary go-top-btn iconfont icon-go-top" style="display:none;"></button>
</div>
<script type="text/template" id="waitReleaseTemp">
    <table class="pe-stand-table pe-stand-table-default pe-dynamic-table" style="margin-bottom:20px;">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI
                    ;i++){%>
                <%if(peData.tableTitles[i].longTitle){%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                   是否已复评
                </th>
                <%}else{%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <%=peData.tableTitles[i].title%>
                </th>
                <%}%>
                <%}%>
        </tr>
        </thead>
        <tbody>
    <%if(peData.rows.length !== 0){%>
    <%_.each(peData.rows,function(examResult,index){%>
    <tr id="releaseUser_<%=index%>" data-id="<%=examResult.user.id%>" style="cursor:pointer;" <%if ((!compareData.userId && index === 0) || compareData.userId === examResult.user.id){%>class="select"<%}%>>
        <td style="border:none;"><div class="pe-ellipsis" title="<%=examResult.user.userName%>"><%=examResult.user.userName%></div></td>
        <%if (examResult.pass) {%>
        <td style="border:none;" title="通过">通过</td>
        <%} else {%>
        <td style="border:none;" class="text-red" title="未通过">未通过</td>
        <%}%>
        <td style="border:none;"><%=(Number(examResult.score).toFixed(1))%>/<%=examResult.totalScore%></td>
        <td style="border:none;"><%if (examResult.review) {%>是<%} else {%>否<%}%></td>
    </tr>
    <%})%>
   <%}%>
    </tbody>
  </table>
</script>
<script>
    $(function () {
        var reviewResult = {
            userId: '${(userId)!}',
            examId: '${(exam.id)!}',
            page: 1,
            pageSize: 10,
            totalPage: 0,
            init: function () {
                var _this = this;
                _this.bind();
                _this.initData();

            },

            initData: function () {
                var _this = this;
                if (_this.userId) {
                    _this.renderData({examId: _this.examId, userId: _this.userId});
                }

                _this.renderUserData();
            },

            renderUserData: function () {
                var _this = this;
                /*自定义表格头部数量及宽度*/
                var peTableTitle = [
                    {'title': '姓名', 'width': 15},
                    {'title': '结果', 'width': 15},
                    {'title': '成绩/满分', 'width': 21},
                    {'title': '是否已复评', 'width': 23,'longTitle':true}
                ];
                /*表格生成*/
                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/ems/examResult/manage/searchReviewExam',
                    formParam: $('#queryForm').serializeArray(),//表格上方表单的提交参数
                    tempId: 'waitReleaseTemp',//表格模板的id
                    title: peTableTitle, //表格头部的数量及名称数组;
                    pagination: 'secondPagin',
                    compareData:{userId:_this.userId},
                    onLoad: function (t) {
                        var total = 0;
                        if (t.data && t.data.rows.length > 0) {
                            total = t.data.total;
                            if (!_this.userId) {
                                _this.userId = t.data.rows[0].user.id;
                                _this.renderData({examId: _this.examId, userId: _this.userId});
                            }

                        }

                        $('.user-total-dom').text(total);
                        _this.countTotalPage(total);
                        /*表格每行点击事件处理*/
                        $('.pe-stand-table-wrap tr').click(function(){
                             var thisTrId = $(this).attr('data-id');
                            _this.userId = thisTrId;
                            $('.pe-stand-table-wrap tr').removeClass('select');
                            $(this).addClass('select');
                            _this.renderData({examId: _this.examId, userId: _this.userId});
                        })
                    }
                });
                var _this = this;
            },

            countTotalPage: function (total) {
                var y = total % reviewResult.pageSize;
                if (y === 0) {
                    reviewResult.totalPage = parseInt(total / reviewResult.pageSize);
                    return false;
                }

                reviewResult.totalPage = parseInt(total / reviewResult.pageSize) + 1;
            },

            preRenderData: function () {
                var page = reviewResult.page - 1;
                if (page <= 0) {
                    return false;
                }

                reviewResult.page = page;
                reviewResult.renderUserData();
            },

            nextRenderData: function () {
                var page = reviewResult.page + 1;
                if (page > reviewResult.totalPage) {
                    return false;
                }

                reviewResult.page = page;
                reviewResult.renderUserData();
            },

            renderData: function (params) {
                var _this = this;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/examResult/manage/findMarkUser',
                    data: params,
                    success: function (data) {
                        if (!data) {
                            return false;
                        }
                        if((!(data.MARK && data.MARK.length > 0) && !(data.REVIEW && data.REVIEW.length > 0))){
                            $('.tip-bubble').hide();
                        }

                        if (data.MARK && data.MARK.length > 0) {
                            $('.mark-user-dl').show();
                            var userNames = '';
                            $.each(data.MARK, function (index, user) {
                                if (index != data.MARK.length) {
                                    userNames += user.userName + ',';
                                } else {
                                    userNames += user.userName;
                                }
                            });

                            $('.mark-user-dl').find('.pe-online-score').text(userNames);
                        } else {
                            $('.mark-user-dl').hide();
                        }

                        if (data.REVIEW && data.REVIEW.length > 0) {
                            $('.review-user-dl').show();
                            userNames = '';
                            $.each(data.REVIEW, function (index, user) {
                                userNames += user.userName;
                                if (index != 0) {
                                    userNames += '，';
                                }
                            });

                            $('.review-user-dl').find('.pe-online-score').text(userNames);
                        } else {
                            $('.review-user-dl').hide();
                        }

                        if($('.mark-user-dl').is(':visible') && $('.review-user-dl:visible').is(':visible')){
                            $('.mark-user-panel').hide();
                        }
                    }
                });
                $('.pe-answer-content-left-wrap').load(pageContext.rootPath + '/ems/examResult/manage/reviewUserResult', params, function () {
                    $('.pe-for-submit').on('click', function () {
                        PEMO.DIALOG.confirmR({
                            content: '确定要保存复评结果吗？',
                            btn2: function () {
                                PEBASE.ajaxRequest({
                                    url: pageContext.rootPath + '/ems/judge/manage/submitReviewMarkExam',
                                    data: $('#reviewResultForm').serialize(),
                                    success: function (data) {
                                        PEMO.DIALOG.tips({
                                            content: '复评成功！',
                                            time: 2000,
                                            end: function () {
                                                _this.renderUserData();
                                            }
                                        });
                                    }
                                });
                            },
                            btn1: function () {
                                layer.closeAll();
                            }
                        });
                    });
                    //图片轮播的样式和功能
                    PEBASE.swiperInitItem($('body'),true);
                    var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
                    var leftPanelOffsetLeft = $('.pe-answer-content-left-wrap').offset().left;
                    $('.pe-answer-content-right-wrap').css('left',parseInt(leftPanel) + parseInt(leftPanelOffsetLeft) + 'px');

                });
            },

            bind: function () {
                var _this = this;
                $('.pe-check-by-list').off().click(function () {
                    var iconCheck = $(this).find('span.iconfont');
                    var thisRealCheck = $(this).find('input[type="checkbox"]');
                    if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                        iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox ');
                        thisRealCheck.prop('checked', 'checked');
                    } else {
                        iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                        thisRealCheck.removeProp('checked');
                    }
                    $('.pe-stand-table-wrap').peGrid('load', $('#queryForm').serializeArray());
                });

                /*初始化屏幕计算右边头像，题目等面板的位置*/
                var clientWidth = document.documentElement.clientWidth;
                var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
                var leftPanelOffsetLeft = $('.pe-answer-content-left-wrap').offset().left;
                $(window).scroll(function () {
                    var windowScrollTop = $(window).scrollTop();
                    var windowScrollLeft = $(window).scrollLeft();
                    if(windowScrollTop <= 64){
                        $('.pe-answer-nav-top').css("top",64-windowScrollTop);
                        $('.pe-answer-content-right-wrap').css("top",170-windowScrollTop);
                    }else{
                        $('.pe-answer-nav-top').css("top",0);
                        $('.pe-answer-content-right-wrap').css("top",106);
                    }
                    if(windowScrollLeft >0 ){
                        var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
                        $('.pe-answer-content-right-wrap').css("left",parseInt(leftPanel,10) - windowScrollLeft);
                    }else{
                        $('.pe-answer-content-right-wrap').css('left',850 + parseInt($('.pe-answer-content-left-wrap').offset().left) + 'px');
                    }
                });

                $(window).resize(function() {
                    var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
                    var leftPanelOffsetLeft = $('.pe-answer-content-left-wrap').offset().left;
                    if(parseInt(leftPanelOffsetLeft) <= 0){
                        $('.pe-answer-content-right-wrap').css('left',parseInt(leftPanel) + 'px');
                    }else{
//                        $('.pe-answer-content-right-wrap').css('left',parseInt(leftPanel) + parseInt(leftPanelOffsetLeft) + 'px');
                        $('.pe-answer-content-right-wrap').css('left',850 + parseInt($('.pe-answer-content-left-wrap').offset().left) + 'px');
                    }

                });
                PEBASE.renderHeight(0);
                $(window).scroll(function(){
                    if($(window).scrollTop() >= 1000){
                        $('.go-top-btn').fadeIn();
                    }else{
                        $('.go-top-btn').fadeOut();
                    }
                })
                /*回到头部*/
                $('.go-top-btn').click(function () {
                    $(window).scrollTop(0);
                });
            },
            initPagination:function(){
                //弹框里的第二种分页上一页，下一页的点击事件
                    var layerPagniWrap = $('.pe-dynamic-wrap').find('.layer-page-wrap');
                    var layerPageSize = $('.pe-dynamic-wrap').find('input[name="saveLayerPaginationPageSize"]');
                    var layerPage = $('.pe-dynamic-wrap').find('input[name="saveLayerPaginationPage"]');
                    var data = $.data($(tableDom).get(0), 'peGrid');
                    layerPagniWrap.find('.page-go-input').val(1);
                    if(totalPage === 1){
                        layerPagniWrap.find('.page-right a').addClass('disabled');
                        layerPagniWrap.find('.page-go-input').attr('readonly',true);
                    }
                    if(totalPage === 0){
                        layerPagniWrap.find('.page-right a').addClass('disabled');
                        layerPagniWrap.find('.page-go-input').attr('readonly',true);
                        layerPagniWrap.find('.page-go-input').val(0);
                    }
                    if(layerPagniWrap.get(0)){
                        /*下一页*/
                        layerPagniWrap.delegate('.page-right a','click',function(){
                            if($(this).hasClass('disabled')){
                                return false;
                            }
                            /*此处是表格里的参数数据，同步表格一致，暂时没有表格，先注释,参考peGrid.js里的peSecondPagination方法,下方data为假数据*/
//                            var data = $.data($(tableDom).get(0), 'peGrid');
                            var data = {
                                options:{
                                    page:1,
                                    pageSize:10
                                }
                            };
                            if(data.options.page + 1=== totalPage){
                                $(this).addClass('disabled');
                            }
                            layerPagniWrap.find('.page-left a').removeClass('disabled');

                            var nowPageSize = parseInt(layerPageSize.val(),10);
                            var nowPage = parseInt(layerPage.val(),10);

                            data.options.pageSize = nowPageSize;
                            data.options.page = nowPage + 1;
                            /*重新渲染表格*/
//                            render($(tableDom).get(0));
                        });
                        /*上一页*/
                        layerPagniWrap.delegate('.page-left a','click',function(){

                            if($(this).hasClass('disabled')){
                                return false;
                            }
                            /*同上*/
//                            var data = $.data($(tableDom).get(0), 'peGrid');
                            var data = {
                                options:{
                                    page:1,
                                    pageSize:10
                                }
                            };
                            if(data.options.page === 1){
                                $(this).addClass('disabled');
                            }
                            layerPagniWrap.find('.page-right a').removeClass('disabled');
                            var nowPageSize = parseInt(layerPageSize.val(),10);
                            var nowPage = parseInt(layerPage.val(),10);
                            data.options.pageSize = nowPageSize;
                            data.options.page = nowPage - 1;
                            /*同上*/
//                            render($(tableDom).get(0));
                        });

                        //layer里面的输入框"ENTER"按键跳转表格指定页面
                        layerPagniWrap.delegate('.page-go-input','keyup',function(e){
                            var e = e || window.event;
                            e.stopPropagation();
                            var eKeyCode = e.keyCode;
                            var thisVal = parseInt(this.value,10);
                            /*同上*/
//                            var data = $.data($(tableDom).get(0), 'peGrid');
                            var data = {
                                options:{
                                    page:1,
                                    pageSize:10
                                }
                            };
                            if ((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105) || eKeyCode === 8 || eKeyCode === 108 || eKeyCode === 46 || eKeyCode === 37 || eKeyCode === 39) {
                                if (parseInt(thisVal,10) > totalPage) {
                                    this.value = totalPage;
                                }
                            } else if(e.keyCode === 13 || e.keyCode === 108){
                                var nowPageSize = parseInt(layerPageSize.val(),10);
                                layerPage.val(thisVal);
                                data.options.pageSize = nowPageSize;
                                data.options.page = thisVal;
                                /*同上*/
//                                render($(tableDom).get(0));
                            }

                        });
                        layerPagniWrap.delegate('.page-go-input','keydown',function(e){
                            var e = e || window.event;
                            e.stopPropagation();
                            var eKeyCode = e.keyCode;
                            var thisVal = this.value;
                            if (!((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105) || eKeyCode === 8 || eKeyCode === 108 || eKeyCode === 46 || eKeyCode === 37 || eKeyCode === 39)) {
                                // this.value = thisVal;
                                return false;
                            }
                        })
                }
            }
        };

        reviewResult.init();
    });
</script>
</@p.pageFrame>