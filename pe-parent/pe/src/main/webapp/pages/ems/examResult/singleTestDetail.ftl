<#assign ctx=request.contextPath/>
<#--todo开发开始做这个页面的跳转时记得把下面的import和p.pageFrame删除-->
<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<#--公用头部-->
<header class="pe-public-top-nav-header">
    <div class="pe-top-nav-container">
        <ul class="clearF">
            <li class="pe-result-detail floatL">考试详情</li>
        </ul>
    </div>
</header>
<div class="pe-container-main single-text-wrap">
    <div class="pe-answer-nav-top" style="overflow: visible;">
        <div class="pe-result-left">
            <div class="pe-result-img">
                    <img src="${(examResult.user.facePath)!'${resourcePath!}/web-static/proExam/images/default_face.png'}"/>
            </div>
            <h2 class="pe-result-name" title="${(examResult.user.userName)!''}">${(examResult.user.userName)!''}</h2>
        </div>
        <div class="pe-result-right">
            <h2 class="pe-answer-title"><span class="pe-result-online">[线上]</span>${(examResult.exam.examName)!}</h2>
            <div class="pe-result-item" style="overflow:visible;">
                <p class="pe-result-pass-btn text-red">未通过</p>
                <div class="pe-wrong-item pe-result-item-con">
                    <dl>
                        <dt class="pe-wrong-test">考试成绩:</dt>
                        <dd class="pe-wrong-test"><span class="user-detail-score">0</span>分</dd>
                    </dl>
                    <dl>
                        <dt class="pe-wrong-score">满分:</dt>
                        <dd class="pe-wrong-score"><span class="user-detail-total-score">0</span>分</dd>
                    </dl>
                <#--<dl>-->
                <#--<dt class="pe-wrong-score">当前排名:</dt>-->
                <#--<dd><span class="pe-result-num">2</span><i class="iconfont pe-result-tip">&#xe6f4;</i></dd>-->
                <#--</dl>-->
                    <dl style="position:relative;">
                        <dt class="pe-wrong-score">考试次数:</dt>
                        <dd class="pe-result-score">${(examResult.examCount)!'0'}
                            <#if examResult.examCount?? && (examResult.examCount > 1)><i class="iconfont icon-thin-arrow-down"></i></#if>
                        </dd>
                        <#--<#if examResult.examCount?? && (examResult.examCount > 1)>-->
                            <div class="pe-single-detail-item" >
                                <div class="pe-login-sort" style="display: none; ">
                                    <div class="sort-triangle"></div>
                                    <ul class="single-test-num" style="max-height:200px;">
                                        <#if examResult.examCount == (resultDetails?size)>
                                            <#list resultDetails as resultDetail>
                                                <#if resultDetail_index == 0>
                                                    <li data-id="${(resultDetail.id)!}">首次</li>
                                                <#elseif resultDetail.markExam??>
                                                    <li data-id="${(resultDetail.id)!}">手动补考${(resultDetail_index)!}</li>
                                                <#else>
                                                    <li data-id="${(resultDetail.id)!}">自动补考${(resultDetail_index)!}</li>
                                                </#if>
                                            </#list>
                                        <#else>
                                            <li>缺考</li>
                                            <#list resultDetails as resultDetail>
                                                <#if resultDetail.markExam??>
                                                    <li data-id="${(resultDetail.id)!}">手动补考${(resultDetail_index+1)!}</li>
                                                <#else>
                                                    <li data-id="${(resultDetail.id)!}">自动补考${(resultDetail_index+1)!}</li>
                                                </#if>
                                            </#list>
                                        </#if>
                                    </ul>
                                </div>
                            </div>
                        <#--</#if>-->
                    </dl>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="pe-answer-content-left-wrap">
        <div class="pe-answer-content-left">

        </div>
    </div>
    <div class="pe-answer-content-right-wrap" style="top: 214px;left: 1250px;">
        <div class="pe-answer-right-content" style="margin-top: 0;">
            <div class="pe-answer-right-content-top">
                <h2>考生答题情况</h2>
            </div>
            <div class="pe-answer-right-contain">
                <div class="pe-answer-test-num">
                </div>
                <div class="pe-result-sort">
                    <ul>
                        <li><i class="iconfont pe-right-con">&#xe600;</i>正确</li>
                        <li class="pe-result-sort-con"><i class="iconfont pe-false-con">&#xe761;</i>错误</li>
                        <li class="pe-result-sort-con"><span class="pe-empty-con">0</span>未答</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/template" id="queNoTemp">
    <%_.each(['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'],function(itemType,itIndex){var prm = data.paper.paperContent.prm;if(prm[itemType]) {var pr = prm[itemType]; _.each(pr.ics,function(ic){%>
    <a class="pe-wrong-answer-item" href="#<%=ic.no%>"><span class="pe-answer-right-data" style="border-bottom: none;"><%=ic.no%></span>
                    <%if (!data.userExamRecordMap[ic.id] || !data.userExamRecordMap[ic.id].answer) {%>
                        <span class="pe-result-empty iconfont" style="color:#fff;">&#xe614;</span>
                    <%} else {%>
                        <%if (itemType === 'SINGLE_SELECTION' || itemType === 'MULTI_SELECTION' || itemType === 'INDEFINITE_SELECTION' || itemType === 'JUDGMENT') {%>
                            <%if (data.userExamRecordMap[ic.id].realScore >0) {%>
                            <span class="iconfont pe-right">&#xe600;</span>
                            <%} else {%>
                            <span class="iconfont pe-wrong-con">&#xe614;</span>
                            <%}%>
                        <%} else {%>
                            <%if (data.userExamRecordMap[ic.id].realScore >0) {%>
                            <span class="iconfont pe-right"><%=data.userExamRecordMap[ic.id].realScore%></span>
                            <%} else {%>
                            <span class="iconfont pe-wrong-con">0</span>
                            <%}%>
                        <%}%>
                    <%}%>
                    </a>
    <%});}});%>
</script>
<script type="text/template" id="queAnswerTemp">
    <%_.each(['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'],function(itemType,itIndex){var prm = data.paper.paperContent.prm;if(prm[itemType]) {var pr = prm[itemType];%>
    <div class="pe-paper-preview-content">
        <div class="pe-question-top-head">
            <%if(itemType === 'SINGLE_SELECTION'){%>
            <h2 class="pe-question-head-text"><a href="javascript:;" class="anchor" name="single"></a>单选题(共<%=pr.ic%>小题，总分<%=pr.tm%>分)
            </h2>
            <%}else if(itemType === 'MULTI_SELECTION'){%>
            <h2 class="pe-question-head-text"><a href="javascript:;" name="multi"></a>多选题(共<%=pr.ic%>小题，总分<%=pr.tm%>分)
            </h2>
            <%}else if(itemType === 'INDEFINITE_SELECTION'){%>
            <h2 class="pe-question-head-text"><a href="javascript:;" name="indefinite"></a>不定项选择(共<%=pr.ic%>小题，总分<%=pr.tm%>分)
            </h2>
            <%}else if(itemType === 'JUDGMENT'){%>
            <h2 class="pe-question-head-text"><a href="javascript:;" name="judgement"></a>判断题(共<%=pr.ic%>小题，总分<%=pr.tm%>分)
            </h2>
            <%}else if(itemType === 'FILL'){%>
            <h2 class="pe-question-head-text"><a href="javascript:;" name="fill"></a>填空题(共<%=pr.ic%>小题，总分<%=pr.tm%>分)
            </h2>
            <%}else if(itemType === 'QUESTIONS'){%>
            <h2 class="pe-question-head-text"><a href="javascript:;" name="question"></a>问答题(共<%=pr.ic%>小题，总分<%=pr.tm%>分)
            </h2>
            <%}%>
        </div>
        <%_.each(pr.ics,function(ic,index){%>
        <a name="<%=ic.no%>" id="<%=ic.no%>" style="position:relative;top:-140px;display:block;"></a>
        <div class=" pe-answer-content-item-wrap" id="<%=ic.no%>">
            <div class="paper-add-question-content">
                <div class="paper-question-stem">
                    <%if (itemType === 'SINGLE_SELECTION' || itemType === 'MULTI_SELECTION' || itemType ===
                    'INDEFINITE_SELECTION' || itemType === 'JUDGMENT') {if (data.userExamRecordMap[ic.id].realScore >0)
                    {%>
                    <span class="iconfont pe-check-right">&#xe600;</span>
                    <%} else {%>
                    <span class="iconfont pe-check-wrong">&#xe614;</span>
                    <%}} else {%>
                    <span class="pe-check-num"><%=data.userExamRecordMap[ic.id].realScore%><i
                            class="iconfont pe-check-line">&#xe751;</i></span>
                    <%}%>
                    <a name="no_1" class="paper-question-num"><%=ic.no%>、</a>
                    <span class="pe-question-score">(<%=ic.m%>分)</span>
                    <div class="paper-item-detail-stem" <%if (itemType == 'FILL') {%>data-answer="<%=data.userExamRecordMap[ic.id].answer%>"<%}%>><%=ic.ct%>
                    </div>
                    <div class="all-images-wrap ">
                        <div class="swiper-container">
                            <ul class="itemImageViewWrap swiper-wrapper">
                            </ul>
                            <div class="pagination"></div>
                        </div>
                    </div>
                </div>
                <ol class="pe-answer-content-select">
                    <%if (ic.ios && ic.ios.length>0) { _.each(ic.ios,function(io,ioIndex){%>
                    <li class="question-single-item-wrap <%if (itemType === 'SINGLE_SELECTION') {%>pe-exam-radio-wrap<%} else {%>pe-exam-checkbox-wrap<%}%>">
                        <input <%if (itemType === 'SINGLE_SELECTION') {%>type="radio"<%} else {%>type="checkbox"<%}%> id="_<%=itIndex%>_<%=ic.no%>_<%=ioIndex%>" disabled
                        <%if (data.userExamRecordMap[ic.id] && data.userExamRecordMap[ic.id].answer &&
                        (_.contains(data.userExamRecordMap[ic.id].answer.split(','),""+ioIndex))) {%>checked<%}%>/>
                        <label class="pe-exam-radio"
                               for="_<%=itIndex%>_<%=ic.no%>_<%=ioIndex%>">
                            <div class="question-text-wrap">
                                <span class="question-item-letter-order"><%=io.so%>.</span>
                                <div class="question-items-choosen-text"><%=io.ct%>
                                </div>
                            </div>
                        </label>
                    </li>
                    <%});} else if (itemType == 'JUDGMENT') {%>
                    <li class="question-single-item-wrap pe-exam-radio-wrap">
                        <input type="radio" id="_<%=itIndex%>_<%=ic.no%>_0" disabled
                        <%if (data.userExamRecordMap[ic.id] && data.userExamRecordMap[ic.id].answer &&
                        data.userExamRecordMap[ic.id].answer == '1') {%>checked<%}%>>
                        <label class="pe-exam-radio"
                               for="_<%=itIndex%>_<%=ic.no%>_0">
                            <div class="question-text-wrap">
                                <div class="question-items-choosen-text">正确</div>
                            </div>
                        </label>
                    </li>
                    <li class="question-single-item-wrap pe-exam-radio-wrap">
                        <input type="radio" id="_<%=itIndex%>_<%=ic.no%>_1" disabled
                        <%if (data.userExamRecordMap[ic.id] && data.userExamRecordMap[ic.id].answer &&
                        data.userExamRecordMap[ic.id].answer == '0') {%>checked<%}%>>
                        <label class="pe-exam-radio"
                               for="_<%=itIndex%>_<%=ic.no%>_1">
                            <div class="question-text-wrap">
                                <div class="question-items-choosen-text">错误</div>
                            </div>
                        </label>
                    </li>
                    <%} else if(itemType == 'QUESTIONS'){%>
                    <p class="pe-for-question">
                        <label>考生答案：</label>
                                                        <textarea
                                                                placeholder="<%=data.userExamRecordMap[ic.id].answer%>"
                                                                disabled="disabled"
                                                                style="width: 725px;"></textarea>
                    </p>
                    <%}%>
                </ol>
            </div>
            <div class="pe-wrong-answer">
                <P class="pe-wrong-answer-con" style="display: block!important;">答案：<%if (itemType == 'JUDGMENT') { if (ic.t) {%>正确<%} else {%>错误<%}} else
                    {%><%=ic.a%><%}%></P>
                <p class="pe-wrong-parsing" style="display: block!important;">解析：<%=ic.ep%></p>
            </div>
        </div>
        <%});%>
    </div>
    <%}});%>
</script>
<script type="text/template" id="imageTemp">
    <%_.each(data,function(imageUrl,index){%>
    <li class="pe-view-question-detail-img-wrap swiper-slide over-flow-hide" data-index="<%=index%>"
        style="display:inline-block;">
        <img class="pe-question-detail-img-item" data-original="<%=imageUrl%>" src="<%=imageUrl%>" width="auto"
             height="100%"/>
    </li>
    <%});%>
</script>
<script>
    $(function () {
        var viewUserDetail = {
            examId: '${(examResult.exam.id)!}',
            userId: '${(examResult.user.id)!}',
            init: function () {
                var _this = this;
                _this.initData();
                _this.bind();
            },

            bind:function () {
                var _this = this;
                $('.pe-single-detail-item li').on('click',function (e) {
                    var detailId = $(this).data('id');
                    if(!detailId){
                        return false;
                    }

                    _this.requestData(detailId);
                });

                $('.single-test-num').mCustomScrollbar({
                    axis: "y",
                    theme: "dark-3",
                    scrollbarPosition: "outside",
                    setWidth: '100px',
                    advanced: {updateOnContentResize: true},
                    callbacks: {
                        onUpdate: function () {
                        }
                    }
                });
                if($('.mCSB_outside+.mCSB_scrollTools').get(0)){
                    $('.mCSB_outside+.mCSB_scrollTools').css('right','-2px');
                }
            },

            initData: function () {
                var _this = this;
                $('.pe-single-detail-item li').each(function (i,e) {
                    if($(e).data('id')){
                        _this.requestData($(e).data('id'));
                        return false;
                    }
                });

            },

            renderQueNo: function (data) {
                $('.pe-answer-test-num').html(_.template($('#queNoTemp').html())({data:data}));
                //pe-answer-right-contain
                $('.pe-answer-test-num').mCustomScrollbar('destroy').mCustomScrollbar({
                    axis: "y",
                    theme: "dark-3",
                    scrollbarPosition: "inside",
                    setWidth: '273px',
                    advanced: {updateOnContentResize: true}
                });
                PEBASE.renderHeight(0);
                //pe-answer-right-contai
            },

            renderTitleData: function (data) {
                if (data.pass) {
                    $('.pe-result-pass-btn').text('通过');
                } else {
                    $('.pe-result-pass-btn').text('未通过');
                    $('.pe-result-pass-btn').addClass('text-red');
                }

                $('.user-detail-score').text(Number(data.score).toFixed(1));
                $('.user-detail-total-score').text(data.totalScore);
            },

            renderAnswer: function (data) {
                $('.pe-answer-content-left').html(_.template($('#queAnswerTemp').html())({data: data}));
                $('.paper-item-detail-stem').each(function (i, e) {
                    var answer = $(e).data('answer');
                    if (!answer) {
                        return;
                    }

                    var answerStr = answer.toString().split('|');
                    for (var i = 0; i < answerStr.length; i++) {
                        $(e).find('.insert-blank-item:eq(' + i + ')').val(answerStr[i]);
                    }
                });

                $('.paper-add-question-content').each(function (i, wrapDom) {
                    var imageUrls = [];
                    $(wrapDom).find('img.upload-img').each(function (i, e) {
                        imageUrls.push($(e).data('src'));
                        $(e).attr('data-index', i);
                    });

                    var imagesWrap = $(wrapDom).find('.all-images-wrap');
                    if (imageUrls.length > 0) {
                        $(wrapDom).find('.itemImageViewWrap').html(_.template($('#imageTemp').html())({data: imageUrls}));
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
                    }
                    //图片查看轮播
                    PEBASE.swiperInitItem($('body'),i+1);
                }
            },

            requestData: function (detailId) {
                var _this = this;
                var params = {resultDetailId:detailId};
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/examResult/manage/getUserDetail',
                    data: params,
                    success: function (data) {
                        if ($.isEmptyObject(data)) {
                            return false;
                        }

                        _this.renderTitleData(data);
                        _this.renderAnswer(data);
                        _this.renderQueNo(data);
                    }
                });
            }
        };

        viewUserDetail.init();

        //点击更多信息按钮点击事件
        $('.pe-result-score').click(function () {
            if ($(this).find('.iconfont').hasClass('icon-thin-arrow-down')) {
                $('.pe-login-sort').fadeIn();
                $(this).find('.iconfont').removeClass('icon-thin-arrow-down').addClass('icon-thin-arrow-up');
                /*$('.pe-question-top-head').css('border-bottom', '2px solid #e0e0e0');*/
            } else if ($(this).find('.iconfont').hasClass('icon-thin-arrow-up')) {
                $('.pe-login-sort').fadeOut();
                $(this).find('.iconfont').removeClass('icon-thin-arrow-up').addClass('icon-thin-arrow-down');
                /*$('.pe-question-top-head').css('border-bottom', '0px');*/
            }
        });

        $(window).scroll(function () {
            var windowScrollTop = $(window).scrollTop();
            var windowScrollLeft = $(window).scrollLeft();
            if(windowScrollTop <= 64){
                $('.pe-answer-nav-top').css("top",64-windowScrollTop);
                $('.pe-answer-content-right-wrap').css("top",214-windowScrollTop);
            }else{
                $('.pe-answer-nav-top').css("top",0);
                $('.pe-answer-content-right-wrap').css("top",150);
            }
            if(windowScrollLeft >0 ){
                var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
                $('.pe-answer-content-right-wrap').css("left",parseInt(leftPanel,10) - windowScrollLeft);
            }else{
                $('.pe-answer-content-right-wrap').css('left',900 + parseInt($('.pe-answer-content-left-wrap').offset().left) + 'px');
            }
        });

        $(window).resize(function() {
            var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
            var leftPanelOffsetLeft = $('.pe-answer-content-left-wrap').offset().left;
            if(parseInt(leftPanelOffsetLeft) <= 0){
                $('.pe-answer-content-right-wrap').css('left',parseInt(leftPanel) + 'px');
            }else{
                $('.pe-answer-content-right-wrap').css('left',parseInt(leftPanel) + parseInt(leftPanelOffsetLeft) + 'px');
            }

        });

        $(window).scrollTop(0);
        $(window).resize(function () {
            var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
            var leftPanelOffsetLeft = $('.pe-answer-content-left-wrap').offset().left;
            if (parseInt(leftPanelOffsetLeft) <= 0) {
                $('.pe-answer-content-right-wrap').css('left', parseInt(leftPanel) + 'px');
            } else {
                $('.pe-answer-content-right-wrap').css('left', parseInt(leftPanel) + parseInt(leftPanelOffsetLeft) + 'px');
            }

        });
    });
</script>
</@p.pageFrame>
