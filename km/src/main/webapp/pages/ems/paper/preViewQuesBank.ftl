<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<div class="pe-public-top-nav-header">
    <div class="pe-detail-top-head over-flow-hide">
        <h3 class="pre-bank-items-name">${(itemBank.bankName)!}</h3>
        <ul class="bank-items-detail-num-wrap over-flow-hide">
            <li class="item-bank-num floatL item-bank-all-num"><a href="javascript:;"
                                                                  class="bank-item-nav-link">总题数：${(itemBank.allNumber)!''}</a>
            </li>
            <li class="item-bank-num floatL"><a href="#single"
                                                class="bank-item-nav-link">单选题：${(itemBank.singleNumber)!}</a></li>
            <li class="item-bank-num floatL"><a href="#multi"
                                                class="bank-item-nav-link">多选题：${(itemBank.multiNumber)!}</a></li>
            <li class="item-bank-num floatL"><a href="#indefinite"
                                                class="bank-item-nav-link">不定项选择题：${(itemBank.indefiniteNumber)!}</a>
            </li>
            <li class="item-bank-num floatL"><a href="#judgement"
                                                class="bank-item-nav-link">判断题：${(itemBank.judgmentNumber)!}</a></li>
            <li class="item-bank-num floatL"><a href="#fill"
                                                class="bank-item-nav-link">填空题：${(itemBank.fillNumber)!}</a></li>
            <li class="item-bank-num floatL"><a href="#question"
                                                class="bank-item-nav-link">问答题：${(itemBank.questionsNumber)!}</a></li>
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
<script type="text/template" id="paperPreviewBank">
    <%_.each(['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'], function(itemType){ if (data[itemType]) {%>
    <div class="pe-question-top-head">
        <%if(itemType === 'SINGLE_SELECTION'){%>
        <h2 class="pe-question-head-text"><a href="javascript:;" class="anchor" name="single"></a>单选题(共<%=data[itemType].itemCount%>小题，总分<%=Number(data[itemType].totalMark).toFixed(1)%>分)
        </h2>
        <%}else if(itemType === 'MULTI_SELECTION'){%>
        <h2 class="pe-question-head-text"><a href="javascript:;" name="multi"></a>多选题(共<%=data[itemType].itemCount%>小题，总分<%=Number(data[itemType].totalMark).toFixed(1)%>分)
        </h2>
        <%}else if(itemType === 'INDEFINITE_SELECTION'){%>
        <h2 class="pe-question-head-text"><a href="javascript:;" name="indefinite"></a>不定项选择(共<%=data[itemType].itemCount%>小题，总分<%=Number(data[itemType].totalMark).toFixed(1)%>分)
        </h2>
        <%}else if(itemType === 'JUDGMENT'){%>
        <h2 class="pe-question-head-text"><a href="javascript:;" name="judgement"></a>判断题(共<%=data[itemType].itemCount%>小题，总分<%=Number(data[itemType].totalMark).toFixed(1)%>分)
        </h2>
        <%}else if(itemType === 'FILL'){%>
        <h2 class="pe-question-head-text"><a href="javascript:;" name="fill"></a>填空题(共<%=data[itemType].itemCount%>小题，总分<%=Number(data[itemType].totalMark).toFixed(1)%>分)
        </h2>
        <%}else if(itemType === 'QUESTIONS'){%>
        <h2 class="pe-question-head-text"><a href="javascript:;" name="question"></a>问答题(共<%=data[itemType].itemCount%>小题，总分<%=Number(data[itemType].totalMark).toFixed(1)%>分)
        </h2>
        <%}%>
    </div>
    <%_.each(data[itemType].items, function(item,index) {%>
    <div class="add-paper-question-item-wrap">
        <div class="paper-add-question-content ">
            <div class="paper-question-stem">
                <span class="paper-question-num"><%=(index+1)%>.</span>
                <span class="pe-question-score">(<%=Number(item.mark).toFixed(1)%>分)</span>
            <#--题干-->
                <div class="paper-item-detail-stem">
                    <%=item.itemDetail.ics.ct%>
                </div>
                <div class="all-images-wrap " style="width:700px;margin-left:0;">
                    <div class="swiper-container">
                        <ul class="itemImageViewWrap swiper-wrapper">
                        </ul>
                        <div class="pagination"></div>
                    </div>
                </div>
                <div class="pe-question-item-level" style="top:2px;">
                    <span class="floatL" style="height:20px;line-height:20px;font-size:16px;">难度:</span>
                    <div class="pe-star-wrap">
                        <span class="pe-star-container">
                    <#--SIMPLE / RELATIVELY_SIMPLE / MEDIUM / MORE_DIFFICULT / DIFFICULT -->
                        <%if(item.level == 'SIMPLE'){%>
                            <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                            <span class="pe-star iconfont icon-start-difficulty"></span>
                            <span class="pe-star iconfont icon-start-difficulty"></span>
                            <span class="pe-star iconfont icon-start-difficulty"></span>
                            <span class="pe-star iconfont icon-start-difficulty"></span>
                        <%}else if(item.level == 'RELATIVELY_SIMPLE'){%>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty"></span>
                        <span class="pe-star iconfont icon-start-difficulty"></span>
                        <span class="pe-star iconfont icon-start-difficulty"></span>
                        <%}else if(item.level == 'MEDIUM'){%>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty"></span>
                        <span class="pe-star iconfont icon-start-difficulty"></span>
                        <%}else if(item.level == 'MORE_DIFFICULT'){%>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty"></span>
                        <%}else {%>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <span class="pe-star iconfont icon-start-difficulty pe-checked-star"></span>
                        <%}%>
                         </span>
                    </div>
                </div>
            </div>
        <#--题目选项-->
            <%if (itemType === 'SINGLE_SELECTION' || itemType === 'MULTI_SELECTION' || itemType ===
            'INDEFINITE_SELECTION') {%>
            <ul>
                <%_.each(item.itemDetail.ics.ios, function(option,index) {%>
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
                        <span class="iconfont <%if (item.itemDetail.ics.t) {%>icon-checked-radio<%} else{%>icon-unchecked-radio<%}%> floatL"></span>
                        <div class="question-text-wrap">
                            <div class="question-items-choosen-text">正确</div>
                        </div>
                    </div>
                </li>
                <li class="question-single-item-wrap">
                    <div class="pe-radio over-flow-hide">
                        <span class="iconfont <%if (!item.itemDetail.ics.t) {%>icon-checked-radio<%} else{%>icon-unchecked-radio<%}%> floatL"></span>
                        <div class="question-text-wrap">
                            <span class="question-items-choosen-text">错误</span>
                        </div>
                    </div>
                </li>
            </ul>
            <%} else if(itemType === 'QUESTIONS'){%>
            <div class="pe-paper-question-answer-wrap">
                <%=item.itemDetail.ics.a%>
            </div>
            <%}else{%>
            <div>
                <%=item.itemDetail.ics.a%>
            </div>
            <%}%>
            <div class="pe-add-paper-true-answer-wrap">
                <span class="floatL" style="color:#444;margin-right:4px;">解析:</span>
                <%if(item.itemDetail.ics.ep || (item.itemDetail.ics.epImgUrls && item.itemDetail.ics.epImgUrls.length !==0)){%>
                <div class="paper-item-detail-stem">
                    <%=item.itemDetail.ics.ep%>
                </div>
                <%}else{%>
                <span style="margin-left:6px;font-size:16px;line-height:1.68;">暂无</span>
                <%}%>
            </div>
        </div>
    </div>
    <%});%>
    <%}})%>
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
        PEBASE.ajaxRequest({
            url: pageContext.rootPath + '/ems/template/manage/findItem',
            data: {bankId: '${(itemBank.id)!}',itemAttribute:'${(itemBank.itemAttribute)}'},
            success: function (data) {
                if ($.isEmptyObject(data)) {
                    $('.pe-paper-preview-content').html('<p style="margin:0 auto;text-align:center;font-size:20px;color:#666;margin-top:20px;">暂时没有题目哦，赶快去添加吧!</p>')
                    return false;
                }
                //取出总的题数
                var nums = 0;
                for (var a in data) {
                    nums += data[a].itemCount;
                }
                $('.bank-items-detail-num-wrap a:first').text("总题数:" + nums);
                $('.pe-paper-preview-content').html(_.template($('#paperPreviewBank').html())({data: data}));
                $('.add-paper-question-item-wrap').each(function(i,wrapDom){
                    var imageUrls = [];
                    $(wrapDom).find('img.upload-img').each(function (i, e) {
                        imageUrls.push($(e).data('src'));
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
                        //图片查看轮播
                        PEBASE.swiperInitItem($('.pe-paper-preview-bank-wrap'),i+1);
                    }
                }

            }
        });

        $('.pe-preview-close-btn').click(function () {
            window.close();
        });
        /*回到头部*/
        $('.icon-go-top').click(function () {
            $(window).scrollTop(0);
        });

        $(window).scroll(function(){
            if($(window).scrollTop() >= 1000){
                $('.go-top-btn').fadeIn();
            }else{
                $('.go-top-btn').fadeOut();
            }

        })
        //视频
        $('.pe-paper-preview-content').delegate('.image-video','click', function () {
            var thisVideoSrc = $(this).attr('data-src');
            PEMO.VIDEOPLAYER(thisVideoSrc);
        });
        //音频
        $('.pe-paper-preview-content').delegate('.image-audio','click', function (e) {
            var _this = $(this);
            if($('.image-audio').not(_this).hasClass('audio-playing') || $('.image-audio').not($(this)).hasClass('audio-pause')){
                PEMO.AUDIOOBJ.obj.player_.pause();
//                PEMO.AUDIOOBJ.oldSrc = '';
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
    })

</script>
</@p.pageFrame>