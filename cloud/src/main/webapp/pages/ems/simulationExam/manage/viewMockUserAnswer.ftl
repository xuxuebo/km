<#assign ctx=request.contextPath/>
<#--todo开发开始做这个页面的跳转时记得把下面的import和p.pageFrame删除-->
<#import "../../../noNavTop.ftl" as p>
<@p.pageFrame>
<#--公用头部-->
<div class="pe-public-top-nav-header">
    <div class="pe-top-nav-container">
        <ul class="clearF">
            <li class="pe-logo floatL"></li>
        </ul>
    </div>
</div>
<div class="pe-container-main">
    <div class="pe-answer-nav-top">
        <h2 class="pe-answer-title">${(examResult.exam.examName)!}</h2>
        <dl>
            <dt>总题数：</dt>
            <dd>${(examResult.paper.itemCount)!}道</dd>
        </dl>
        <dl>
            <dt class="pe-answer-time">答题时长：</dt>
            <dd><#if examResult.exam?? && examResult.exam.examSetting??  && examResult.exam.examSetting.examLength?? > ${(examResult.exam.examSetting.examLength)!}
                分钟<#else>无限制</#if></dd>
        </dl>
    </div>
    <div class="pe-answer-content-left-wrap">
        <div class="pe-wrong-nav"
             <#if !(examResult.pass)>style="background-color: #fff9f8;border-color: #fb605f;"</#if>>
            <p class="pe-wrong-pass">
                <button type="button" <#if !(examResult.pass)> style="color: #fb605f;border-color:#fb605f;" </#if>
                        class="pe-wrong-pass-btn"><#if examResult.pass>通过<#else>未通过</#if></button>
            </p>
            <div class="pe-wrong-item">
                <dl>
                    <dt class="pe-wrong-test">考试成绩:</dt>
                    <dd class="pe-wrong-test">${(examResult.score)!}分</dd>
                </dl>
                <dl>
                    <dt class="pe-wrong-score">满分:</dt>
                    <dd class="pe-wrong-score">${(examResult.totalScore)!}分</dd>
                </dl>
            <#--<dl>-->
            <#--<dt class="pe-wrong-score">当前排名:</dt>-->
            <#--<dd class="pe-wrong-test">2</dd>-->
            <#--&lt;#&ndash;<dd class="iconfont">&#xe6f4;</dd>&ndash;&gt;-->
            <#--</dl>-->
                <dl class="clear"></dl>
            </div>
        </div>
        <div class="pe-wrong-contain">
            <div class="pe-wrong-content-wrap">
                <#assign examSetting= examResult.exam.examSetting/>
                以下为完整答卷以及正确答案
            </div>
            <#list ['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'] as itemType>
                <#if prm[itemType]??>
                    <#assign pr = prm[itemType]/>
                    <div class="pe-paper-preview-content">
                        <div class="pe-question-top-head">
                            <h2 class="pe-question-head-text">
                                <a href="javascript:;" class="anchor" name="single"></a>
                                <#if itemType == 'SINGLE_SELECTION'>单选题<#elseif itemType == 'MULTI_SELECTION'>
                                    多选题<#elseif itemType == 'INDEFINITE_SELECTION'>
                                    不定项选择题<#elseif itemType == 'JUDGMENT'>判断题<#elseif itemType == 'FILL'>
                                    填空题<#elseif itemType == 'QUESTIONS'>问答题</#if>
                            </h2>
                        </div>
                        <#list pr.ics as ic>
                            <#if ( recordMap[ic.id]??)>
                                <div class="add-paper-question-item-wrap pe-answer-content-item-wrap" id="${ic_index}"
                                     style="border-bottom: none;">
                                    <div class="paper-add-question-content ">
                                        <div class="paper-question-stem">
                                            <#if itemType!='FILL' && itemType !='QUESTIONS'>
                                                <#if recordMap[ic.id]?? && (recordMap[ic.id].score>0)>
                                                    <span class="iconfont pe-check-right">&#xe600;</span>
                                                <#else>
                                                    <span class="iconfont pe-check-wrong">&#xe614;</span>
                                                </#if>
                                            <#else>
                                                <span class="pe-check-num">${(recordMap[ic.id].score)!}<i
                                                        class="iconfont pe-check-line">&#xe751;</i></span>
                                            </#if>
                                            <span class="paper-question-num">${(ic_index+1)!}、</span>
                                            <span class="pe-question-score">(${(ic.m)!}分）</span>
                                            <div class="paper-item-detail-stem"
                                                 <#if itemType == 'FILL'>data-answer="${(recordMap[ic.id].answer)!}"</#if>>
                                                <div class="pe-for-step">${(ic.ct)!}
                                                </div>
                                            </div>
                                            <div class="all-images-wrap all-images-wrap${(ic_index+1)!}">
                                                <div class="swiper-container">
                                                    <ul class="itemImageViewWrap swiper-wrapper">
                                                    </ul>
                                                    <div class="pagination"></div>
                                                </div>
                                            </div>
                                            <div class="pe-question-item-level">
                                                <div class="pe-star-wrap">
                                                <span class="pe-star-container">
                                                      <span class="pe-star iconfont icon-start-difficulty <#if recordMap[ic.id]?? && recordMap[ic.id].sign>pe-checked-star</#if>"></span>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                        <ol class="pe-answer-content-select">
                                            <#if ic.ios?? && (ic.ios?size>0)>
                                                <#list ic.ios as io>
                                                    <li class="question-single-item-wrap <#if itemType == 'SINGLE_SELECTION'>pe-exam-radio-wrap<#else>pe-exam-checkbox-wrap</#if>">
                                                        <input <#if itemType == 'SINGLE_SELECTION'>type="radio"
                                                               <#else>type="checkbox"</#if>
                                                               id="_${(itemType_index)}_${(ic_index+1)!}_${(io_index)!}"
                                                               disabled
                                                            <#if recordMap[ic.id]?? && recordMap[ic.id].answer?? && (recordMap[ic.id].answer?split(",")?seq_contains(""+io_index))>
                                                               checked</#if>/>
                                                        <label class="pe-exam-radio"
                                                               for="_${(itemType_index)}_${(ic_index)!}_${(io_index)!}">
                                                            <div class="question-text-wrap">
                                                                <span class="question-item-letter-order">${(io.so)!}
                                                                    .</span>
                                                                <div class="question-items-choosen-text">${(io.ct)}
                                                                </div>
                                                            </div>
                                                        </label>
                                                    </li>
                                                </#list>
                                            <#elseif itemType == 'JUDGMENT'>
                                                <li class="question-single-item-wrap pe-exam-radio-wrap">
                                                    <input type="radio" id="_${(itemType_index)}_${(ic_index+1)}_0"
                                                           disabled
                                                           <#if recordMap[ic.id]?? && recordMap[ic.id].answer?? && recordMap[ic.id].answer == '1'>checked</#if>>
                                                    <label class="pe-exam-radio"
                                                           for="_${(itemType_index)}_${(ic_index+1)}_0">
                                                        <div class="question-text-wrap">
                                                            <div class="question-items-choosen-text">正确</div>
                                                        </div>
                                                    </label>
                                                </li>
                                                <li class="question-single-item-wrap pe-exam-radio-wrap">
                                                    <input type="radio" id="_${(itemType_index)}_${(ic_index+1)}_1"
                                                           disabled
                                                           <#if recordMap[ic.id]?? && recordMap[ic.id].answer?? && recordMap[ic.id].answer == '0'>checked</#if>>
                                                    <label class="pe-exam-radio"
                                                           for="_${(itemType_index)}_${(ic_index+1)}_1">
                                                        <div class="question-text-wrap">
                                                            <div class="question-items-choosen-text">错误</div>
                                                        </div>
                                                    </label>
                                                </li>
                                            <#elseif itemType == 'QUESTIONS'>
                                                <p class="pe-for-question">
                                                    <label>考生答案：</label>
                                                        <textarea placeholder="${(recordMap[ic.id].answer)!}"
                                                                  disabled="disabled"
                                                                  style="width: 725px;">
                                                        </textarea>
                                                </p>
                                            </#if>
                                        </ol>
                                    </div>
                                    <div class="pe-wrong-answer">
                                        <h2 class="pe-wrong-answer-con">
                                            答案：<#if itemType == 'JUDGMENT'><#if ic.t?? && ic.t>
                                            正确<#else>错误</#if><#else>${(ic.a)!}</#if></h2>
                                        <p class="pe-wrong-parsing">解析：${(ic.ep)!}
                                        </p>
                                    </div>
                                </div>
                            </#if>
                        </#list>
                    </div>
                </#if>
            </#list>

        </div>
    </div>
    <div class="pe-answer-content-right-wrap">
        <div class="pe-answer-right-top" style="padding: 20px 9px;overflow: hidden;">
            <div class="pe-online-img" style="float: left;">
                <img src="${(user.facePath)!'${resourcePath!}/web-static/proExam/images/pe-ans-nav-fir.png'}">
            </div>
            <div class="pe-wrong-true-inf">
                <h2 class="pe-wrong-title">真实姓名</h2>
                <dl>
                    <dt><i class="iconfont">&#xe735;</i></dt>
                    <dd class="pe-online-examing">${(user.userName)!}</dd>
                </dl>
                <#if user.idCard??>
                    <dl>
                        <dt><i class="iconfont">&#xe732;</i></dt>
                        <dd class="pe-answer-num" style="width: 148px;">${(user.idCard)!}</dd>
                    </dl>
                </#if>
            </div>
        </div>
        <div class="pe-answer-right-content">
            <div class="pe-answer-right-content-top">
                <h2>答题情况</h2>
            </div>
            <div class="pe-answer-right-contain">
                <div class="pe-answer-test-num">
                    <#list ['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'] as itemType>
                        <#if prm[itemType]??>
                            <#assign pr = prm[itemType]/>
                            <#list pr.ics as ic>
                                <#if (recordMap[ic.id]??)>
                                    <a class="pe-wrong-answer-item" href="#_${(ic_index+1)!}">
                                        <span class="pe-answer-right-num">${(ic_index+1)!}</span>
                                        <#if (!recordMap[ic.id]??)>
                                            <span class="pe-result-empty"></span>
                                        <#else>
                                            <#if recordMap[ic.id].sign>
                                                <span class="pe-star iconfont icon-start-difficulty pe-wrong-start"></span>
                                            </#if>
                                            <#if itemType!='FILL' && itemType !='QUESTIONS'>
                                                <#if recordMap[ic.id]?? && (recordMap[ic.id].score>0)>
                                                    <span class="iconfont pe-right">&#xe600;</span>
                                                <#else>
                                                    <span class="iconfont pe-wrong-con">&#xe614;</span>
                                                </#if>
                                            <#else>
                                                <#if (recordMap[ic.id].score>0)>
                                                    <span class="iconfont pe-right">${(recordMap[ic.id].score)!}</span>
                                                <#else>
                                                    <span class="iconfont pe-wrong-coning ">0</span>
                                                </#if>
                                            </#if>
                                        </#if>
                                    </a>
                                </#if>
                            </#list>
                        </#if>
                    </#list>
                </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
    <script type="text/template" id="imageTemp">
        <%_.each(data,function(imageUrl,index){%>
        <li class="pe-view-question-detail-img-wrap swiper-slide over-flow-hide" data-index="<%=index%>"
            style="display:inline-block;">
            <img class="pe-question-detail-img-item" data-original="<%=imageUrl%>" src="<%=imageUrl%>" width="auto"
                 height="100%"/>
        </li>
        <%});%>
    </script>
    <script type="text/javascript">
        $(function () {
            $('.add-paper-question-item-wrap').each(function (i, wrapDom) {
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
            for (var i = 0, ILen = imagesWrap.length; i < ILen; i++) {
                $(imagesWrap[i]).addClass('all-images-wrap' + (i + 1)).attr('data-index', i + 1);
                if (!$(imagesWrap[i]).find('.swiper-wrapper img').get(0)) {
                    $(imagesWrap[i]).hide();
                } else {
                    $(imagesWrap[i]).find('.swiper-wrapper').css('transform', 'translate3d(0px, 0px, 0px)');
                    $(imagesWrap[i]).find('.swiper-wrapper').css('-webkit-transform', 'translate3d(0px, 0px, 0px)');
                    PEBASE.swiperInitItem($('body'), i + 1);
                }
            }
            $('.pe-paper-preview-content').each(function (index, ele) {
                var $itemWrap = $(this).find('.pe-answer-content-item-wrap');
                if (!$itemWrap || $itemWrap.length <= 0) {
                    $(this).hide();
                }
            });


            $('.paper-item-detail-stem').each(function (i, e) {
                //    var answer = $(e).data('answer');
                //    var answer =  $(e).attr("data-answer");
                var answer = $(this).attr("data-answer");
                if (!answer) {
                    return;
                }
                alert(answer);
                var answerStr = answer.split('、');
                for (var i = 0; i < answerStr.length; i++) {
                    $(e).find('.insert-blank-item:eq(' + i + ')').val(answerStr[i]);
                }
            });

            //视频
            $('.image-video').on('click', function () {
                var thisVideoSrc = $(this).attr('data-src');
                PEMO.VIDEOPLAYER(thisVideoSrc);
            });
            //音频
            $('.image-audio').on('click', function (e) {
                var _this = $(this);
                if ($('.image-audio').not(_this).hasClass('audio-playing') || $('.image-audio').not($(this)).hasClass('audio-pause')) {
                    PEMO.AUDIOOBJ.obj.player_.pause();
                    PEMO.AUDIOOBJ.oldSrc = '';
                    var $audioPlayingDom = $('.image-audio.audio-playing');
                    var $audioPauseDom = $('.image-audio.audio-pause');
                    if ($audioPlayingDom.get(0)) {
                        var playingSrc = $audioPlayingDom.attr('src').replace(/audio_playing.gif/ig, 'default-music.png');
                        $audioPlayingDom.attr('src', playingSrc);
                    }
                    if ($audioPauseDom.get(0)) {
                        var pauseSrc = $audioPauseDom.attr('src').replace(/audio_pause.png/ig, 'default-music.png');
                        $audioPauseDom.attr('src', pauseSrc);
                    }
                    $audioPlayingDom.removeClass('audio-playing');
                    $audioPauseDom.removeClass('audio-pause');
                }
                var thisVideoSrc = _this.attr('data-src');
                if (_this.hasClass('audio-playing')) {
                    //已经在播放，这里执行暂停
                    PEMO.AUDIOPLAYER(thisVideoSrc, true);
                    _this.removeClass('audio-playing').addClass('audio-pause');
                    var newSrc = _this.attr('src').replace(/audio_playing.gif/ig, 'audio_pause.png');
                    _this.attr('src', newSrc);
                } else {
                    PEMO.AUDIOPLAYER(thisVideoSrc, false);
                    _this.addClass('audio-playing').removeClass('audio-pause');
                    var newSrc = _this.attr('src').replace(/audio_pause.png|default-music.png/ig, 'audio_playing.gif');
                    _this.attr('src', newSrc);
                }
                /*监听音频播放结束*/
                PEMO.AUDIOOBJ.obj.on('ended', function () {
                    $('.image-audio.audio-playing').removeClass('audio-playing audio-pause');
                    var newSrc = _this.attr('src').replace(/audio_pause.png|audio_playing.gif/ig, 'default-music.png');
                    _this.attr('src', newSrc);
                })
            });

            /*初始化屏幕计算右边头像，题目等面板的位置*/
            var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
            var leftPanelOffsetLeft = $('.pe-answer-content-left-wrap').offset().left;
            $('.pe-answer-content-right-wrap').css('left', parseInt(leftPanel) + parseInt(leftPanelOffsetLeft) + 'px');
            console.log(parseInt(leftPanel) + parseInt(leftPanelOffsetLeft));
            $(window).scroll(function () {
                var windowScrollTop = $(window).scrollTop();
                var windowScrollLeft = $(window).scrollLeft();
                if (windowScrollTop <= 64) {
                    $('.pe-answer-nav-top').css("top", 64 - windowScrollTop);
                    $('.pe-answer-content-right-wrap').css("top", 170 - windowScrollTop);
                } else {
                    $('.pe-answer-nav-top').css("top", 0);
                    $('.pe-answer-content-right-wrap').css("top", 106);
                }
                if (windowScrollLeft > 0) {
                    var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
                    $('.pe-answer-content-right-wrap').css("left", parseInt(leftPanel, 10) - windowScrollLeft);
                } else {
                    $('.pe-answer-content-right-wrap').css('left', 900 + parseInt(leftPanelOffsetLeft) + 'px');
                }
            });

            $(window).resize(function () {
                var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
                var leftPanelOffsetLeft = $('.pe-answer-content-left-wrap').offset().left;
                if (parseInt(leftPanelOffsetLeft) <= 0) {
                    $('.pe-answer-content-right-wrap').css('left', parseInt(leftPanel) + 'px');
                } else {
                    $('.pe-answer-content-right-wrap').css('left', parseInt(leftPanel) + parseInt(leftPanelOffsetLeft) + 'px');
                }

            });
        })
    </script>
</@p.pageFrame>