<#import "../../../noNavTop.ftl" as p>
<@p.pageFrame>
<div class="pe-public-top-nav-header" style="position:relative;">
<#--TODO判断是否绝密-->
    <#if paper?? && paper.paperTemplate?? && paper.paperTemplate.security?? && paper.paperTemplate.security>
        <span class="iconfont icon-top-secret-back"></span>
        <span class="iconfont icon-secret-label"></span>
    </#if>
<#--判断是否绝密结束-->
    <div class="pe-detail-top-head over-flow-hide">
        <h3 class="pre-bank-items-name">${(paper.paperTemplate.paperName)!}</h3>
        <ul class="bank-items-detail-num-wrap over-flow-hide">
            <li class="item-bank-num floatL item-bank-all-num"><a href="javascript:;" class="bank-item-nav-link">共<span
                    class="item-totalCount">${(paper.itemCount)!'0'}</span>小题</a></li>
            <li class="item-bank-num floatL"><a href="javascript:;" class="bank-item-nav-link">满分：<span
                    class="item-allTotalMark">${(paper.mark)!'0'}</span>分</a></li>
            <li class="item-bank-num floatL"><a href="javascript:;"
                                                class="bank-item-nav-link preview-paper-analysis-btn"
                                                style="margin-left:18px;"><span
                    class="iconfont preview-paper-analysis-icon icon-hide-analysis"></span><span class="analysis-text">隐藏答题解析</span></a>
            </li>
        </ul>
    </div>
</div>
<div class="pe-main-wrap exam-manage-paper-view">
    <div class="pe-no-nav-main-wrap">
        <div class="pe-paper-preview-bank-wrap">
            <button type="button" class="pe-btn pe-btn-primary go-top-btn iconfont icon-go-top" style="display:none;"></button>
            <div class="pe-paper-preview-content"></div>
            <div class="pe-add-paper-step-btns" style="text-align:center;">
                <button type="button" class="pe-btn pe-btn-blue pe-preview-close-btn">关闭</button>
            </div>
        </div>
    </div>
</div>
<script type="text/template" id="uniformSetScoreTemp">
    <table>
        <tr style="height: 50px;">
            <td style="width: 200px;height:50px;">题&emsp;&emsp;型：<%=data.itemType%></td>
            <td style="width: 200px;height:50px;">题数：<%=data.itemCount%></td>
        </tr>
        <tr>
            <td style="width: 200px;">单题分值：<input type="text" class="single-item-mark"
                                                  style="width:40px;height: 20px;border: 1px solid #999;"/></td>
            <td style="width: 200px;">总分：<span class="uniform-set-total-score" style="color: #fc984e;"><%=data.itemMark%></span>
            </td>
        </tr>
    </table>
</script>
<script type="text/template" id="imageTemp">
    <%_.each(data,function(imageUrl,index){%>
    <li class="pe-view-question-detail-img-wrap swiper-slide over-flow-hide" data-index="<%=index%>"
        style="display:inline-block;">
        <%var srcReg = /\/explain/ig;%>
        <%if(srcReg.test(imageUrl)){%>
        <%var newImageSrc = imageUrl.replace('/explain','');%>
        <img class="pe-question-detail-img-item explain-img" data-original="<%=newImageSrc%>" src="<%=newImageSrc%>"
             width="auto"
             height="100%"/>
        <%}else{%>
        <img class="pe-question-detail-img-item" data-original="<%=imageUrl%>" src="<%=imageUrl%>" width="auto"
             height="100%"/>
        <%}%>
    </li>
    <%});%>
</script>
<script type="text/template" id="paperPreviewBank">
    <%_.each(['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'], function(itemType){ if (data[itemType]) {%>
    <div class="pe-question-type-wrap">
        <div class="pe-question-top-head">
            <%if(itemType === 'SINGLE_SELECTION'){%>
            <h2 class="pe-question-head-text"><a href="javascript:;" class="anchor" name="single"></a><span
                    class="item-type">单选题</span>(共<span class="item-count"><%=data[itemType].ic%></span>小题，总分<span
                    class="item-totalMark "><%=Number(data[itemType].tm).toFixed(1)%></span>分)</h2>
            <%}else if(itemType === 'MULTI_SELECTION'){%>
            <h2 class="pe-question-head-text"><a href="javascript:;" name="multi"></a><span class="item-type">多选题</span>(共<span
                    class="item-count"><%=data[itemType].ic%></span>小题，总分<span class="item-totalMark"><%=Number(data[itemType].tm).toFixed(1)%></span>分)
            </h2>
            <%}else if(itemType === 'INDEFINITE_SELECTION'){%>
            <h2 class="pe-question-head-text"><a href="javascript:;" name="indefinite"></a><span
                    class="item-type">不定项选择</span>(共<span class="item-count"><%=data[itemType].ic%></span>小题，总分<span
                    class="item-totalMark"><%=Number(data[itemType].tm).toFixed(1)%></span>分)</h2>
            <%}else if(itemType === 'JUDGMENT'){%>
            <h2 class="pe-question-head-text"><a href="javascript:;" name="judgement"></a><span
                    class="item-type">判断题</span>(共<span class="item-count"><%=data[itemType].ic%></span>小题，总分<span
                    class="item-totalMark"><%=Number(data[itemType].tm).toFixed(1)%></span>分)</h2>
            <%}else if(itemType === 'FILL'){%>
            <h2 class="pe-question-head-text"><a href="javascript:;" name="fill"></a><span class="item-type">填空题</span>(共<span
                    class="item-count"><%=data[itemType].ic%></span>小题，总分<span class="item-totalMark"><%=Number(data[itemType].tm).toFixed(1)%></span>分)
            </h2>
            <%}else if(itemType === 'QUESTIONS'){%>
            <h2 class="pe-question-head-text"><a href="javascript:;" name="question"></a><span
                    class="item-type">问答题</span>(共<span class="item-count"><%=data[itemType].ic%></span>小题，总分<span
                    class="item-totalMark"><%=Number(data[itemType].tm).toFixed(1)%></span>分)</h2>
            <%}%>
            <a href="javascript:;" class="exam-edit-paper-set-score" data-type="<%=itemType%>">设置统一分值</a>
        </div>
        <%_.each(data[itemType].ics, function(ic,index) {%>
        <div class="add-paper-question-item-wrap" data-id="<%=ic.id%>">
            <input type="hidden" name="itemId" value="<%=ic.id%>"/>
            <div class="exam-paper-opt-wrap">
                <ul>
                    <li><a class="opt-exam-btn deleBtn iconfont icon-delete delete-item"></a></li>
                    <li><a class="opt-exam-btn editBtn iconfont icon-edit edit-item"></a></li>
                    <%if(index === 0){%>
                    <li><a href="javascript:;" class="opt-exam-btn deleBtn iconfont icon-up disabled moveUp"></a></li>
                    <%}else{%>
                    <li><a href="javascript:;" class="opt-exam-btn deleBtn iconfont icon-up moveUp"></a></li>
                    <%}%>
                    <%if(index === data[itemType].ics.length -1){%>
                    <li><a href="javascript:;" class="opt-exam-btn deleBtn iconfont icon-down disabled moveDown"></a>
                    </li>
                    <%}else{%>
                    <li><a href="javascript:;" class="opt-exam-btn deleBtn iconfont icon-down moveDown"></a></li>
                    <%}%>
                </ul>
            </div>
            <div class="paper-add-question-content ">
                <div class="paper-question-stem">
                    <span class="paper-question-num"><%=(index+1)%>.</span>
                    <span class="pe-question-score">(<span class="item-mark"><%=ic.m%></span>分)</span>
                <#--题干-->
                    <div class="paper-item-detail-stem">
                        <%=ic.ct%>
                    </div>
                    <div class="all-images-wrap">
                        <div class="swiper-container">
                            <ul class="itemImageViewWrap swiper-wrapper">
                            </ul>
                            <div class="pagination"></div>
                        </div>
                    </div>
                </div>
            <#--题目选项-->
                <%if (itemType === 'SINGLE_SELECTION' || itemType === 'MULTI_SELECTION' || itemType ===
                'INDEFINITE_SELECTION') {%>
                <ul>
                    <%_.each(ic.ios, function(option) {%>
                    <li class="question-single-item-wrap">
                        <%if(itemType === 'SINGLE_SELECTION'){%>
                        <div class="pe-radio over-flow-hide">
                            <span class="iconfont <%if (option.t) {%>icon-checked-radio<%} else {%>icon-unchecked-radio<%}%> floatL"></span>
                            <%}else{%>
                            <div class="pe-checkbox over-flow-hide">
                                <span class="iconfont <%if (option.t) {%>icon-checked-checkbox<%} else {%>icon-unchecked-checkbox<%}%> floatL"></span>
                                <%}%>
                                <div class="question-text-wrap">
                                    <span class="question-item-letter-order"><%=option.so%>.</span>
                                    <div class="question-items-choosen-text"><%=option.ct%>
                                    </div>
                                </div>
                            </div>
                    </li>
                    <%})%>
                </ul>
                <%} else if (itemType === 'JUDGMENT'){%>
                <ul>
                    <li class="question-single-item-wrap">
                        <div class="pe-radio over-flow-hide">
                            <span class="iconfont <%if (ic.t) {%>icon-checked-radio<%} else{%>icon-unchecked-radio<%}%> floatL"></span>
                            <div class="question-text-wrap">
                                <div class="question-items-choosen-text">正确</div>
                            </div>
                        </div>
                    </li>
                    <li class="question-single-item-wrap">
                        <div class="pe-radio over-flow-hide">
                            <span class="iconfont <%if (!ic.t) {%>icon-checked-radio<%} else{%>icon-unchecked-radio<%}%> floatL"></span>
                            <div class="question-text-wrap">
                                <span class="question-items-choosen-text">错误</span>
                            </div>
                        </div>
                    </li>
                </ul>
                <%} else if(itemType === 'QUESTIONS'){%>
                <div class="pe-paper-question-answer-wrap">
                    <%=ic.a%>
                </div>
                <%}else{%>
                <div>
                    <%=ic.a%>
                </div>
                <%}%>
                <div class="pe-add-paper-true-answer-wrap" style="display: block;">
                    <span class="floatL" style="color:#444;">解析:</span>
                    <div>
                        <%if(ic.ep || (ic.epImgUrls && ic.epImgUrls.length !==0)){%>
                        <div class="paper-item-detail-stem">
                            <%=ic.ep%>
                        </div>
                        <%}else{%>
                        <span style="margin-left:6px;font-size:16px;line-height:1.68;">暂无</span>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
        <%});%>
    </div>
    <%}})%>
</script>
<script>
    $(function () {
        var paperId = '${(paper.id)!}';
        var editExamPaper = {
            renderData: function () {
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exam/manage/viewPaperItem',
                    data: {paperId: paperId},
                    success: function (data) {
                        if ($.isEmptyObject(data)) {
                            $('.pe-paper-preview-content').html('<p style="margin:0 auto;text-align:center;font-size:20px;color:#666;margin-top:20px;">暂时没有题目哦，赶快去添加吧!</p>')
                            return false;
                        }
                        $('.pe-paper-preview-content').html(_.template($('#paperPreviewBank').html())({data: data}));
                        $('.add-paper-question-item-wrap').each(function(i,wrapDom){
                            var imageUrls = [];
                            $(wrapDom).find('img.upload-img').each(function (i, e) {
                                if ($(e).parents('.pe-add-paper-true-answer-wrap').get(0)) {
                                    imageUrls.push($(e).data('src') + '/explain');
                                } else {
                                    imageUrls.push($(e).data('src'));
                                }
                                $(e).attr('data-index', i);
                            });

                            var imagesWrap = $(wrapDom).find('.all-images-wrap');
                            if (imageUrls.length > 0) {
                                $(wrapDom).find('.itemImageViewWrap').html(_.template($('#imageTemp').html())({data:imageUrls}));
                                imagesWrap.show();
                            }
                        });

                        var imagesWrap = $('.all-images-wrap');
                        for(var i=0,ILen = imagesWrap.length;i< ILen;i++){
                            $(imagesWrap[i]).addClass('all-images-wrap' + (i + 1)).attr('data-index',i+1);
                            if(!$(imagesWrap[i]).find('.swiper-wrapper img').get(0)){
                                $(imagesWrap[i]).hide();
                            }else{
                                $(imagesWrap[i]).find('.swiper-wrapper').css('transform','translate3d(0px, 0px, 0px)');
                                $(imagesWrap[i]).find('.swiper-wrapper').css('-webkit-transform','translate3d(0px, 0px, 0px)');
                                PEBASE.swiperInitItem($('body'),i+1);
                            }
                        }
                    }
                });
            },

            init: function () {
                var _this = this;
                _this.bind();
                _this.initData();
            },

            bind: function () {
                $('.pe-paper-preview-content').delegate('.exam-edit-paper-set-score', 'click', function () {
                    var itemData = {};
                    var $_this = $(this);
                    itemData.itemType = $(this).prev('.pe-question-head-text').children('.item-type').text();
                    itemData.itemCount = $(this).prev('.pe-question-head-text').children('.item-count').text();
                    itemData.itemMark = $(this).prev('.pe-question-head-text').children('.item-totalMark').text();
                    var itemIds = [];
                    var $questionTypeWrap = $(this).parents('.pe-question-type-wrap');
                    $questionTypeWrap.find('input[name="itemId"]').each(function (index, ele) {
                        itemIds.push($(ele).val());
                    });

                    PEMO.DIALOG.confirmR({
                        content: _.template($('#uniformSetScoreTemp').html())({data: itemData}),
                        area: ['400px', '260px'],
                        skin: 'pe-layer-confirmA uniform-set-score-dialog',
                        title: '设置统一分值',
                        btn: ['取消', '确定'],
                        btn2: function () {
                            var mark = $('.single-item-mark').val();
                            if (mark == null || mark == "") {
                                mark = 1;
                                $('.single-item-mark').val(1);
                            }

                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/exam/manage/updatePaperMark',
                                data: {'itemIds': JSON.stringify(itemIds), mark: mark, paperId: paperId},
                                success: function (data) {
                                    $questionTypeWrap.find('.item-mark').each(function (index, ele) {
                                        $(ele).text(mark);
                                    });
                                    var styleMark = mark * itemData.itemCount;
                                    $_this.prev('.pe-question-head-text').children('.item-totalMark').text(styleMark);
                                    var totalMark = $('.item-allTotalMark').text();
                                    totalMark = parseFloat(totalMark) - parseFloat(itemData.itemMark) + parseFloat($('.uniform-set-total-score').text());
                                    $('.item-allTotalMark').text(totalMark);
                                    localStorage.setItem('EXAM_PAPER_EDIT', paperId);
                                    window.location.reload();
                                }
                            });
                        },
                        btn1: function () {
                            layer.closeAll();
                        },
                        success: function () {
                            $('.single-item-mark').keyup(function (e) {
                                var e = e || window.event;
                                var eKeyCode = e.keyCode;
                                var thisVal = this.value;
                                if ((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105) || eKeyCode === 110 || eKeyCode === 190 || eKeyCode === 8 || eKeyCode === 108) {
                                    if (parseFloat(thisVal) > 100) {
                                        this.value = 100;
                                    } else if (parseFloat(thisVal) < 0) {
                                        this.value = '0.1';
                                    } else {
                                        if ((thisVal.indexOf('.') !== -1) && (thisVal.indexOf('.') !== thisVal.lastIndexOf('.'))) {
                                            this.value = thisVal.substring(0, thisVal.lastIndexOf('.'));
                                        }
                                        if (thisVal.length >= 4 && (thisVal.indexOf('.') !== -1)) {
                                            this.value = parseFloat(thisVal).toFixed(1);
                                        }
                                    }
                                } else {
                                    this.value = thisVal;
                                }

                                var totalMark = itemData.itemCount * parseFloat(this.value);
                                if (!/^(-|\+)?\d+$/.test(totalMark)) {
                                    totalMark = totalMark.toFixed(1);
                                }

                                $('.uniform-set-total-score').text(totalMark);
                            }).keydown(function () {
                                var e = e || window.event;
                                var eKeyCode = e.keyCode;
                                var thisVal = this.value;
                                if (!((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105) || eKeyCode === 110 || eKeyCode === 190 || eKeyCode === 8 || eKeyCode === 108)) {
                                    this.value = thisVal;
                                }

                                var totalMark = itemData.itemCount * parseFloat(this.value);
                                if (!/^(-|\+)?\d+$/.test(totalMark)) {
                                    totalMark = totalMark.toFixed(1);
                                }
                                $('.uniform-set-total-score').text(totalMark);
                            });
                        }
                    });
                });

//        $('.pe-detail-top-head').html('111');
                $('.pe-preview-close-btn').click(function () {
                    window.close();
                });
                /*回到头部*/
                $('.icon-go-top').click(function () {
                    $(window).scrollTop(0);
                });
                $(window).scroll(function(){
                    /*回到顶部*/
                    if($(window).scrollTop() >= 600){
                        $('.go-top-btn').fadeIn();
                    }else{
                        $('.go-top-btn').fadeOut();
                    }
                });
                //显示与隐藏试题解析
                $('.preview-paper-analysis-btn').click(function () {
                    var $thisIcon = $(this).find('.preview-paper-analysis-icon');
                    if ($thisIcon.hasClass('icon-hide-analysis')) {
                        $('.pe-add-paper-true-answer-wrap').slideUp();
                        $thisIcon.removeClass('icon-hide-analysis').addClass('icon-show-analysis');
                        $('.explain-img').hide();
                        hideExplainImgs();
                        $(this).find('.analysis-text').html('显示答题解析');
                    } else {
                        $('.pe-add-paper-true-answer-wrap').slideDown();
                        $thisIcon.removeClass('icon-show-analysis').addClass('icon-hide-analysis');
                        $('.explain-img').show();
                        showExplainImgs();
                        $(this).find('.analysis-text').html('隐藏答题解析');
                    }
                });

                function hideExplainImgs() {
                    var $explainImgs = $(".explain-img");
                    $explainImgs.each(function () {
                        var imgUrl = $(this).attr("src");
                        $(this).attr("data-original", '');
                        $(this).attr("src", '');
                        $(this).attr("imgUrl", imgUrl);
                        var $explainParentSwiper = $(this).parents('.all-images-wrap');
                        if(!$explainParentSwiper.find('.pe-question-detail-img-item:visible').not('.explain-img').get(0)){
                            $explainParentSwiper.css('cssText','height:0!important');
                        }
                    });
                }

                function showExplainImgs() {
                    var $explainImgs = $(".explain-img");
                    $explainImgs.each(function () {
                        var url = $(this).attr("imgUrl");
                        $(this).attr("data-original", url);
                        $(this).attr("src", url);
                        var $explainParentSwiper = $(this).parents('.all-images-wrap');
                        $explainParentSwiper.css('cssText','height:144px!important');
                    });

                }

                /*题目hover效果*/
                $('.exam-manage-paper-view').delegate('.add-paper-question-item-wrap', 'mouseenter', function (e) {
                    var e = e || window.event;
                    e.stopPropagation();
                    $(this).find('.paper-add-question-content').addClass('item-hover');
                    $(this).find('.exam-paper-opt-wrap').show();
                });

                $('.exam-manage-paper-view').delegate('.add-paper-question-item-wrap', 'mouseleave', function (e) {
                    var e = e || window.event;
                    e.stopPropagation();
                    $(this).find('.paper-add-question-content').removeClass('item-hover');
                    $(this).find('.exam-paper-opt-wrap').hide();
                });

                /*上下移动的交互*/
                $('.exam-manage-paper-view').delegate('.moveUp', 'click', function (e) {
                    var e = e || window.event;
                    e.stopPropagation();
                    e.preventDefault();
                    var _thisDom = $(this);
                    if (_thisDom.hasClass('disabled')) {
                        return false;
                    }
                    var itemId = _thisDom.parents('.add-paper-question-item-wrap').data('id');
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/movePaperItem',
                        data: {paperId: paperId, 'itemId': itemId, 'up': true},
                        success: function (data) {
                            var $thisParentDom = _thisDom.parents('.add-paper-question-item-wrap');
                            var $prevParentDom = $thisParentDom.prev('.add-paper-question-item-wrap').eq(0);
                            if ($prevParentDom.get(0)) {
                                var thisIndex = $thisParentDom.find('.paper-question-num').html();
                                var prevIndex = $prevParentDom.find('.paper-question-num').html();
                                $prevParentDom.before($thisParentDom);
                                $thisParentDom.find('.paper-question-num').html(prevIndex);
                                $prevParentDom.find('.paper-question-num').html(thisIndex);
                            }

                            if ($thisParentDom.index() === 1) {
                                $thisParentDom.find('.moveUp').addClass('disabled');
                            }
                            $thisParentDom.find('.moveDown').removeClass('disabled');

                            if ($prevParentDom.index() === _thisDom.parents('.pe-question-type-wrap').find('.add-paper-question-item-wrap').length) {
                                $prevParentDom.find('.moveDown').addClass('disabled');
                            }
                            $prevParentDom.find('.moveUp').removeClass('disabled');

                        }
                    });
                });
                $('.exam-manage-paper-view').delegate('.moveDown', 'click', function (e) {
                    var e = e || window.event;
                    e.stopPropagation();
                    e.preventDefault();
                    var _thisDom = $(this);
                    if (_thisDom.hasClass('disabled')) {
                        return false;
                    }

                    var itemId = _thisDom.parents('.add-paper-question-item-wrap').data('id');
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/manage/movePaperItem',
                        data: {paperId: paperId, 'itemId': itemId, 'up': false},
                        success: function (data) {
                            var $thisParentDom = _thisDom.parents('.add-paper-question-item-wrap');
                            var $nextParentDom = $thisParentDom.next('.add-paper-question-item-wrap').eq(0);
                            if ($nextParentDom.get(0)) {
                                var thisIndex = $thisParentDom.find('.paper-question-num').html();
                                var prevIndex = $nextParentDom.find('.paper-question-num').html();
                                $nextParentDom.after($thisParentDom);
                                $thisParentDom.find('.paper-question-num').html(prevIndex);
                                $nextParentDom.find('.paper-question-num').html(thisIndex);
                            }
                            if ($thisParentDom.index() === _thisDom.parents('.pe-question-type-wrap').find('.add-paper-question-item-wrap').length) {
                                $thisParentDom.find('.moveDown').addClass('disabled');
                            }
                            $thisParentDom.find('.moveUp').removeClass('disabled');

                            if ($nextParentDom.index() === 1) {
                                $nextParentDom.find('.moveUp').addClass('disabled');
                            }
                            $nextParentDom.find('.moveDown').removeClass('disabled');

                        }
                    });
                });

                $('.exam-manage-paper-view').delegate('.edit-item', 'click', function (e) {
                    var e = e || window.event;
                    e.stopPropagation();
                    var itemId = $(this).parents('.add-paper-question-item-wrap').data('id');
                    PEMO.DIALOG.selectorDialog({
                        title: '编辑试题',
                        area: ['1050px', '580px'],
                        content: [pageContext.rootPath + '/ems/exam/manage/initEditItemPage?paperId=' + paperId + '&itemId=' + itemId],
                        btn: ['取消', '保存'],
                        skin: 'pe-add-exam-dialog',
                        btn2: function (index) {
                            window.frames['layui-layer-iframe' + index].window.submitForm();
                            return false;
                        }
                    });
                });

                /*删除操作*/
                $('.exam-manage-paper-view').delegate('.delete-item', 'click', function (e) {
                    var e = e || window.event;
                    e.stopPropagation();
                    e.preventDefault();
                    var $thisParentDom = $(this).parents('.add-paper-question-item-wrap');
                    var itemId = $thisParentDom.data('id');
                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定删除该试题么？</h3></div>',
                        btn2: function () {
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/exam/manage/deletePaperItem',
                                data: {paperId: paperId, itemId: itemId},
                                success: function (data) {
                                    /*此处删除dom及相关的操作，开发时请移植到请求成功返回后执行*/
                                    localStorage.setItem('EXAM_PAPER_EDIT', paperId);
                                    editExamPaper.renderData();
                                    var curMark = $thisParentDom.find('.item-mark').text();
                                    $('.item-totalCount').text(Number($('.item-totalCount').text()) - 1);
                                    $('.item-allTotalMark').text(Number($('.item-allTotalMark').text()) - curMark);
                                }
                            });
                        }
                    });
                });

                //视频
                $('.exam-manage-paper-view').delegate('.image-video','click',function(){
                    var thisVideoSrc = $(this).attr('data-src');
                    PEMO.VIDEOPLAYER(thisVideoSrc);
                });
                //音频
                $('.exam-manage-paper-view').delegate('.image-audio','click',function(e){
                    var _this = $(this);
                    if($('.image-audio').not(_this).hasClass('audio-playing') || $('.image-audio').not($(this)).hasClass('audio-pause')){
                        PEMO.AUDIOOBJ.obj.player_.pause();
//                        PEMO.AUDIOOBJ.oldSrc = '';
                        var $audioPlayingDom =  $('.image-audio.audio-playing');
                        var $audioPauseDom =  $('.image-audio.audio-pause');
                        if($audioPlayingDom.get(0)){
                            var playingSrc = $audioPlayingDom.attr('src').replace(/audio_playing.gif/ig,'default-music.png');
                            $audioPlayingDom.attr('src',playingSrc);
                        }
                        if($audioPauseDom.get(0)){
                            var pauseSrc = $audioPauseDom.attr('src').replace(/audio_pause.png/ig,'default-music.png');
                            $audioPauseDom.attr('src',pauseSrc);
                        }
                        $audioPlayingDom.removeClass('audio-playing');
                        $audioPauseDom.removeClass('audio-pause');
                    }
                    var thisVideoSrc = _this.attr('data-src');
                    if(_this.hasClass('audio-playing')){
                        //已经在播放，这里执行暂停
                        PEMO.AUDIOPLAYER(thisVideoSrc,true);
                        _this.removeClass('audio-playing').addClass('audio-pause');
                        var newSrc = _this.attr('src').replace(/audio_playing.gif/ig,'audio_pause.png');
                        _this.attr('src',newSrc);
                    }else{
                        PEMO.AUDIOPLAYER(thisVideoSrc,false);
                        _this.addClass('audio-playing').removeClass('audio-pause');
                        var newSrc = _this.attr('src').replace(/audio_pause.png|default-music.png/ig,'audio_playing.gif');
                        _this.attr('src',newSrc);
                    }
                    /*监听音频播放结束*/
                    PEMO.AUDIOOBJ.obj.on('ended',function(){
                        $('.image-audio.audio-playing').removeClass('audio-playing audio-pause');
                        var newSrc = _this.attr('src').replace(/audio_pause.png|audio_playing.gif/ig,'default-music.png');
                        _this.attr('src',newSrc);
                    })
                });
            },

            initData: function () {
                var _this = this;
                _this.renderData();
            }
        };

        editExamPaper.init();
    });

</script>
</@p.pageFrame>