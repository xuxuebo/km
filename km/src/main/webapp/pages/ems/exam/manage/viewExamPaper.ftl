<#import "../../../noNavTop.ftl" as p>
<@p.pageFrame>
<div class="pe-public-top-nav-header" style="position:relative;">
<#--TODO判断是否绝密-->
    <#if paper.paperTemplate.security?? && paper.paperTemplate.security>
        <span class="iconfont icon-top-secret-back"></span>
        <span class="iconfont icon-secret-label"></span>
    </#if>
<#--判断是否绝密结束-->
    <div class="pe-detail-top-head over-flow-hide">
        <h3 class="pre-bank-items-name">${(paper.paperTemplate.paperName)!}</h3>
        <ul class="bank-items-detail-num-wrap over-flow-hide">
            <li class="item-bank-num floatL item-bank-all-num"><a href="javascript:;" class="bank-item-nav-link">共<span class="item-count">${(paper.itemCount)!'0'}</span>小题</a></li>
            <li class="item-bank-num floatL"><a href="javascript:;" class="bank-item-nav-link">满分：<span class="item-mark">${(paper.mark)!'0'}</span>分</a></li>
            <li class="item-bank-num floatL">
                <a href="javascript:;" class="bank-item-nav-link preview-paper-analysis-btn" style="margin-left:18px;">
                    <span class="iconfont preview-paper-analysis-icon icon-hide-analysis"></span>
                    <span class="showtext">隐藏答题解析</span>
                </a>
            </li>
        </ul>
    </div>
</div>
<div class="pe-main-wrap">
    <div class="pe-no-nav-main-wrap" style="width:1168px;">
        <div class="pe-paper-preview-bank-wrap">
            <button type="button" class="pe-btn pe-btn-primary go-top-btn iconfont icon-go-top" style="display:none;"></button>
            <div class="pe-paper-preview-content"></div>
            <div class="pe-add-paper-step-btns" style="text-align:center;">
                <button type="button" class="pe-btn pe-btn-blue pe-preview-close-btn">关闭</button>
            </div>
        </div>
    </div>
</div>
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
    <div class="pe-question-top-head">
        <%if(itemType === 'SINGLE_SELECTION'){%>
        <h2 class="pe-question-head-text"><a href="javascript:;" class="anchor" name="single"></a>单选题(共<%=data[itemType].ic%>小题，总分<%=Number(data[itemType].tm).toFixed(1)%>分)</h2>
        <%}else if(itemType === 'MULTI_SELECTION'){%>
        <h2 class="pe-question-head-text"><a href="javascript:;" name="multi"></a>多选题(共<%=data[itemType].ic%>小题，总分<%=Number(data[itemType].tm).toFixed(1)%>分)</h2>
        <%}else if(itemType === 'INDEFINITE_SELECTION'){%>
        <h2 class="pe-question-head-text"><a href="javascript:;" name="indefinite"></a>不定项选择(共<%=data[itemType].ic%>小题，总分<%=Number(data[itemType].tm).toFixed(1)%>分)</h2>
        <%}else if(itemType === 'JUDGMENT'){%>
        <h2 class="pe-question-head-text"><a href="javascript:;" name="judgement"></a>判断题(共<%=data[itemType].ic%>小题，总分<%=Number(data[itemType].tm).toFixed(1)%>分)</h2>
        <%}else if(itemType === 'FILL'){%>
        <h2 class="pe-question-head-text"><a href="javascript:;" name="fill"></a>填空题(共<%=data[itemType].ic%>小题，总分<%=Number(data[itemType].tm).toFixed(1)%>分)</h2>
        <%}else if(itemType === 'QUESTIONS'){%>
        <h2 class="pe-question-head-text"><a href="javascript:;" name="question"></a>问答题(共<%=data[itemType].ic%>小题，总分<%=Number(data[itemType].tm).toFixed(1)%>分)</h2>
        <%}%>
    </div>
    <%_.each(data[itemType].ics, function(ic,index) {%>
    <div class="add-paper-question-item-wrap">
        <div class="paper-add-question-content ">
            <div class="paper-question-stem">
                <span class="paper-question-num"><%=(index+1)%>.</span>
                <span class="pe-question-score">(<%=Number(ic.m).toFixed(1)%>分)</span>
            <#--题干-->
                <div class="paper-item-detail-stem">
                    <%=ic.ct%>
                </div>
            </div>
            <div class="all-images-wrap" style="margin-left:32px;">
                <div class="swiper-container">
                    <ul class="itemImageViewWrap swiper-wrapper">
                    </ul>
                    <div class="pagination"></div>
                </div>
            </div>
        <#--题目选项-->
            <%if (itemType === 'SINGLE_SELECTION' || itemType === 'MULTI_SELECTION' || itemType === 'INDEFINITE_SELECTION') {%>
            <ul>
                <%_.each(ic.ios, function(option,index) {%>
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
    <%}})%>
</script>
<script>
    $(function(){
        PEBASE.ajaxRequest({
            url : pageContext.rootPath+'/ems/exam/manage/viewPaperItem',
            data:{paperId:'${(paper.id)!}'},
            success:function(data){
                if($.isEmptyObject(data)){
                    $('.pe-paper-preview-content').html('<p style="margin:0 auto;text-align:center;font-size:20px;color:#666;margin-top:20px;">暂时没有题目哦，赶快去添加吧!</p>')
                    return false;
                }
                $('.pe-paper-preview-content').html(_.template($('#paperPreviewBank').html())({data:data}));
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
//        $('.pe-detail-top-head').html('111');
        $('.pe-preview-close-btn').click(function(){
            window.close();
        });
        /*回到头部*/
        $('.icon-go-top').click(function(){
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
        $('.preview-paper-analysis-btn').click(function(){
            var $thisIcon = $(this).find('.preview-paper-analysis-icon');
            if($thisIcon.hasClass('icon-hide-analysis')){
                $('.pe-add-paper-true-answer-wrap').slideUp();
                $thisIcon.removeClass('icon-hide-analysis').addClass('icon-show-analysis');
                $('.explain-img').hide();
                hideExplainImgs();
                $('.showtext').text("显示答题解析");
            }else{
                $('.pe-add-paper-true-answer-wrap').slideDown();
                $thisIcon.removeClass('icon-show-analysis').addClass('icon-hide-analysis');
                $('.explain-img').show();
                showExplainImgs();
                $('.showtext').text("隐藏答题解析");
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
        //视频
        $('.pe-paper-preview-bank-wrap').delegate('.image-video','click',function(e){
            var thisVideoSrc = $(this).attr('data-src');
            PEMO.VIDEOPLAYER(thisVideoSrc);
//            PEMO.VIDEOPLAYER(thisVideoSrc);
        });
        //音频
        $('.pe-paper-preview-bank-wrap').delegate('.image-audio','click',function(e){
            var _this = $(this);
            if($('.image-audio').not(_this).hasClass('audio-playing') || $('.image-audio').not($(this)).hasClass('audio-pause')){
                PEMO.AUDIOOBJ.obj.player_.pause();
//                PEMO.AUDIOOBJ.oldSrc = '';  /
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
        })
    })

</script>
</@p.pageFrame>