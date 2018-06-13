<#assign ctx=request.contextPath/>
<div class="pe-answer-content-left">
    <div class="pe-review-item">
        <ul>
        <#list ['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'] as itemType>
            <#if prm?? && prm[itemType]??>
                <a href="#${(itemType)}_wrap">
                    <#if itemType == 'SINGLE_SELECTION'>
                        <li class="pe-review-sort">单选题</li>
                    <#elseif itemType == 'MULTI_SELECTION'>
                        <li class="pe-review-sort">多选题</li>
                    <#elseif itemType == 'INDEFINITE_SELECTION'>
                        <li class="pe-review-sort">不定项选择题</li>
                    <#elseif itemType == 'JUDGMENT'>
                        <li class="pe-review-sort">判断题</li>
                    <#elseif itemType == 'FILL'>
                        <li class="pe-review-sort">填空题</li>
                    <#elseif itemType == 'QUESTIONS'>
                        <li class="pe-review-sort">问答题</li>
                    </#if>
                </a>
            </#if>
        </#list>
        </ul>
    </div>
    <form id="reviewResultForm">
        <input type="hidden" name="exam.id" value="${(examId)!}"/>
        <input type="hidden" name="user.id" value="${(userId)!}"/>
        <div class="pe-paper-preview-content pe-for-preview">
        <#list ['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'] as itemType>
            <#if prm?? && prm[itemType]??>
                <#assign pr = prm[itemType]/>
                <a name="${(itemType)}_wrap" id="${(itemType)}_wrap" style="position:relative;top:-100px;display:block;""></a>
                <div class="pe-question-top-head" id="${(itemType)}_wrap">
                    <h2 class="pe-question-head-text">
                        <#if itemType == 'SINGLE_SELECTION'>单选题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：只有一个选项是正确答案。）<#elseif itemType == 'MULTI_SELECTION'>
                            多选题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：至少有两个选项是正确答案。）<#elseif itemType == 'INDEFINITE_SELECTION'>不定项选择 （共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：至少有一个选项是正确答案。）<#elseif itemType == 'JUDGMENT'>
                            判断题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：判断下列说法是否正确。）<#elseif itemType == 'FILL'>填空题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：在对应的空格中填写答案。）<#elseif itemType == 'QUESTIONS'>问答题（共${(pr.ic)!}小题，总分${(pr.tm)!}分。答题规则：在输入框中填写答案。）</#if>
                    </h2>
                </div>
                <#if pr.ics?? && (pr.ics?size>0)>
                    <#list pr.ics as ic>
                        <div class="pe-for-item-wrap">
                            <div class="paper-add-question-content">
                                <div class="pe-for-question-stem">
                                    <p class="pe-review-get">
                                        <label>得分：</label>
                                        <input class="pe-for-score" data-mark="${(ic.m)!}" name="markScoreMap[${(ic.id)}]"
                                               value="${(recordMap[ic.id].realScore)!}">
                                    </p>
                                    <div class="paper-question-stem pe-for-stem">
                                        <#if itemType!='FILL' && itemType !='QUESTIONS'>
                                            <#if recordMap[ic.id]?? && (recordMap[ic.id].realScore>0)>
                                                <span class="iconfont pe-check-right">&#xe600;</span>
                                            <#else>
                                                <span class="iconfont pe-check-wrong">&#xe614;</span>
                                            </#if>
                                        </#if>
                                        <a name="no_1" class="paper-question-num">${(ic.no)!}、</a>
                                        <span class="pe-question-score">(${(ic.m)!}分)</span>
                                        <div class="paper-item-detail-stem" <#if itemType == 'FILL'>data-answer="${(recordMap[ic.id].answer)!}"</#if>>${(ic.ct)!}
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
                                        <#if ic.ios?? && (ic.ios?size>0)>
                                            <#list ic.ios as io>
                                                <li class="question-single-item-wrap <#if itemType == 'SINGLE_SELECTION'>pe-exam-radio-wrap<#else>pe-exam-checkbox-wrap</#if>">
                                                    <input <#if itemType == 'SINGLE_SELECTION'>type="radio"<#else>type="checkbox"</#if>
                                                           id="_${(itemType_index)}_${(ic.no)!}_${(io_index)!}"
                                                           disabled
                                                        <#if recordMap[ic.id]?? && recordMap[ic.id].answer?? && (recordMap[ic.id].answer?split(",")?seq_contains(""+io_index))>
                                                           checked</#if>/>
                                                    <label <#if itemType == 'SINGLE_SELECTION'>class="pe-exam-radio"<#else>class="pe-exam-box"</#if>
                                                           for="_${(itemType_index)}_${(ic.no)!}_${(io_index)!}">
                                                        <div class="question-text-wrap">
                                                                <span class="question-item-letter-order">${(io.so)!}
                                                                    .</span>
                                                            <div class="question-items-choosen-text">${(io.ct)!}
                                                            </div>
                                                        </div>
                                                    </label>
                                                </li>
                                            </#list>
                                        <#elseif itemType == 'JUDGMENT'>
                                            <li class="question-single-item-wrap pe-exam-radio-wrap">
                                                <input type="radio" id="_${(itemType_index)}_${(ic.no)}_0" disabled
                                                       <#if recordMap[ic.id]?? && recordMap[ic.id].answer?? && recordMap[ic.id].answer == '1'>checked</#if>>
                                                <label class="pe-exam-radio"
                                                       for="_${(itemType_index)}_${(ic.no)}_0">
                                                    <div class="question-text-wrap">
                                                        <div class="question-items-choosen-text">正确</div>
                                                    </div>
                                                </label>
                                            </li>
                                            <li class="question-single-item-wrap pe-exam-radio-wrap">
                                                <input type="radio" id="_${(itemType_index)}_${(ic.no)}_1" disabled
                                                       <#if recordMap[ic.id]?? && recordMap[ic.id].answer?? && recordMap[ic.id].answer == '0'>checked</#if>>
                                                <label class="pe-exam-radio"
                                                       for="_${(itemType_index)}_${(ic.no)}_1">
                                                    <div class="question-text-wrap">
                                                        <div class="question-items-choosen-text">错误</div>
                                                    </div>
                                                </label>
                                            </li>
                                        <#elseif itemType == 'QUESTIONS'>
                                            <p class="pe-for-question">
                                                <label>考生答案：</label>
                                                        <textarea placeholder=""
                                                                  disabled="disabled"
                                                                  style="width: 725px;">${(recordMap[ic.id].answer)!}</textarea>
                                            </p>
                                        </#if>
                                    </ol>
                                    <p class="pe-for-key">
                                        正确答案：<#if itemType == 'JUDGMENT'><#if ic.t?? && ic.t>
                                        正确<#else>错误</#if><#else>${(ic.a)!}</#if></p>
                                </div>
                            </div>
                        </div>
                    </#list>
                </#if>
            </#if>
        </#list>
        </div>
    </form>
    <div class="pe-for-btn">
    <#--<button type="button" class="pe-btn pe-btn-purple pe-for-continue">提交并继续</button>-->
        <button type="button" class="pe-btn pe-btn-blue pe-for-submit">保存</button>
        <button type="button" class="pe-btn pe-for-close pe-btn-white">关闭</button>
    </div>
</div>
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
        $('.pe-for-item-wrap').each(function(i,wrapDom){
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
                PEBASE.swiperInitItem($('body'),i+1,true);
            }
        }

        var reviewResult = {
            userId: '${(userId)}',
            examId: '${(examId)}',
            init: function () {
                var _this = this;
                _this.bind();
                _this.initData();
            },

            initData :function(){
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
            },

            bind: function () {
                var _this = this;
                $('.pe-for-close').on('click', function () {
                    window.close();
                });

                $('.pe-for-score').on('blur', function () {
                    var itemMark = $(this).data('mark'), mark = $(this).val();
                    if (!mark) {
                        return false;
                    }

                    mark = _this.formatNumber(mark);
                    if (mark > itemMark) {
                        mark = itemMark;
                    }

                    $(this).val(mark);
                });

                //视频
                $('.image-video').on('click',function(){
                    var thisVideoSrc = $(this).attr('data-src');
                    PEMO.VIDEOPLAYER(thisVideoSrc);
                });
                //音频
                $('.image-audio').on('click',function(e){
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

            formatNumber: function (mark) {
                var reg = /^\d+$/;
                var regFloat = /^\d+.?\d*$/;
                if (reg.test(mark)) {
                    return mark;
                } else if (regFloat.test(mark)) {
                    return String(mark).split('.')[0] + '.' + String(mark).split('.')[1].substr(0, 1);
                }

                return 0;
            }
        };

        reviewResult.init();
    });
</script>