<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>试题详情</title>
    <link rel="shortcut icon" href="${(resourcePath+icoUrl)!'${resourcePath!}/web-static/proExam/images/pe_ico_32.ico'}" type="image/x-icon"/>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/iconfont.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/plugins/viewer.min.css?_v=${(resourceVersion)!}" type="text/css"/>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/plugins/video-js.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/plugins/video-js.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css"/>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/media/video_dev.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.pagination.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.easydropdown.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/idangerous.swiper2.7.6.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/jquery.mCustomScrollbar.concat.min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/viewer.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-peGrid.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>
    <script>
        var pageContext = {
            rootPath: '${ctx!}'
        }
    </script>
    <style type="text/css">
        #peVideoPlayer5 {
            display: none;
        }
    </style>
</head>
<div class="pe-public-top-nav-header">
    <div class="pe-detail-top-head" style="left: 15px;">
        试题详情
    </div>
</div>
<div class="pe-main-wrap">
    <div class="pe-no-nav-main-wrap">
        <div class="pe-view-detail-all-wrap paper-add-question-content">
            <div class="view-question-wrap">
                <div class="pe-question-top-head" style="border-bottom: 2px solid #e7e7e7;">
                    <h2 class="pe-question-head-text">试题内容</h2>
                </div>
            </div>
            <div class="pe-view-question-item-wrap">
                <div class="pe-single-item">
            <span class="pe-ques-detail-type floatL">
                [
            <#if item.type == 'SINGLE_SELECTION'>
                单选题
            <#elseif item.type == 'MULTI_SELECTION'>
                多选题
            <#elseif item.type == 'INDEFINITE_SELECTION'>
                不定项选择
            <#elseif item.type == 'JUDGMENT'>
                判断题
            <#elseif item.type == 'FILL'>
                填空题
            <#elseif item.type == 'QUESTIONS'>
                问答题
            </#if>
                ]
            </span>
                    <span class="pe-question-score">(${(item.mark)!}分)</span>
                ${(ic.ct)!}
                </div>
                <div class="all-images-wrap all-images-wrap0">
                    <div class="swiper-container">
                        <ul class="itemImageViewWrap swiper-wrapper">
                        </ul>
                        <div class="pagination"></div>
                    </div>
                </div>
                <div class="question-item-choosen-items">
                <#if item.type == 'SINGLE_SELECTION' ||  item.type == 'MULTI_SELECTION' || item.type == 'INDEFINITE_SELECTION' || ic.ios?? && (ic.ios?size>0)>
                    <ul>
                        <#list ic.ios as io>
                            <li class="question-single-item-wrap">
                                <div class="<#if item.type == 'SINGLE_SELECTION'>pe-radio<#else>pe-checkbox</#if> over-flow-hide">
                                    <#if io.t?? && io.t>
                                        <span class="iconfont <#if item.type == 'SINGLE_SELECTION'>icon-checked-radio<#else>icon-checked-checkbox</#if> floatL"
                                              style="margin:2px 0 0 3px;"></span>
                                    <#else>
                                        <span class="iconfont <#if item.type == 'SINGLE_SELECTION'>icon-unchecked-radio<#else>icon-unchecked-checkbox</#if> floatL"
                                              style="margin:2px 0 0 3px;"></span>
                                    </#if>
                                    <div class="question-text-wrap" style="padding-top: 7px;">
                                        <span class="question-item-letter-order">${(io.so)!}.&nbsp;</span>
                                        <div class="question-items-choosen-text">
                                        ${(io.ct)!}
                                        <#--选项的小图标渲染-->
                                            <ul class="image-small-icon-wrap">
                                                <#if io.ctImgUrls?? && (io.ctImgUrls?size>0)>
                                                    <#list io.ctImgUrls as ctImgUrl>
                                                        <li class="icon-picture-icon iconfont option-image-icon"
                                                            data-index="option${io_index}${ctImgUrl_index}"></li>
                                                    </#list>
                                                </#if>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                            </li>
                        </#list>
                    </ul>
                </#if>
                    <div class="pe-question-item-answer-area">
                    <#if item.type == 'FILL'||item.type == 'QUESTIONS'>
                        参考答案：${(ic.a)!}
                    <#else>
                        正确答案：<#if item.type == 'JUDGMENT'><#if ic.t?? && ic.t>正确<#else>
                        错误</#if><#else>${(ic.a)!}</#if></#if>
                    </div>
                </div>
            </div>
            <div class="pe-question-top-head" style="border-bottom: 2px solid #e7e7e7;">
                <h2 class="pe-question-head-text">试题解析</h2>
            </div>
            <div class="pe-view-question-item-wrap">
                <p class="question-item-analysis-text"><#if ic?? && (!(ic.ep??)||(ic.ep?? && ic.ep == ''))>
                    无<#else >${(ic.ep)!}</#if></p>
            <#--试题解析的小图标渲染-->
                <ul class="image-small-icon-wrap">
                <#if ic.epImgUrls?? && (ic.epImgUrls?size>0)>
                    <#list ic.epImgUrls as epImgUrl>
                        <li class="icon-picture-icon iconfont analyze-image-icon"
                            data-index="analyze${epImgUrl_index}"></li>
                    </#list>
                </#if>
                </ul>

            </div>
            <div class="pe-question-top-head" style="border-bottom: 2px solid #e7e7e7;">
                <h2 class="pe-question-head-text">基本信息</h2>
            </div>
            <div class=" pe-view-question-item-wrap">
                <ul class="pe-question-item-base-msg over-flow-hide">
                    <li class="pq-question-item-msg-container floatL">
                        <span class="floatL">所属题库:</span>
                        <span class="pe-question-item-msg  floatL"
                              style="width: 80%;">${(item.itemBank.bankName)!}</span>
                    </li>
                    <li class="pq-question-item-msg-container floatL">
                        <span class="floatL">创建日期:</span>
                        <span class="pe-question-item-msg  floatL">${item.createTime?string('yyyy-MM-dd')}</span>
                    </li>
                    <li class="pq-question-item-msg-container floatL">
                        <span class="floatL">试题难度:</span>
            <span class="pe-question-item-msg  floatL">
            <#if item.level == 'SIMPLE'>
                简单
            <#elseif item.level == 'RELATIVELY_SIMPLE'>
                较简单
            <#elseif item.level == 'MEDIUM'>
                中等
            <#elseif item.level == 'MORE_DIFFICULT'>
                较难
            <#elseif item.level == 'DIFFICULT'>
                困难
            </#if></span>
                    </li>
                    <li class="pq-question-item-msg-container floatL">
                        <span class="floatL">过期日期:</span>
                        <span class="pe-question-item-msg  floatL">${(item.expireDate)!}</span>
                    </li>
                    <li class="pq-question-item-msg-container floatL">
                        <span class="floatL">语言属性:</span>
            <span class="pe-question-item-msg floatL">
            <#if item.languageType == 'CHINESE'>
                中文
            <#elseif item.languageType == 'ENGLISH'>
                英文
            <#elseif item.languageType == 'TRADITIONAL_CHINESE'>
                繁体中文
            <#elseif item.languageType == 'JAPANESE'>
                日文
            <#elseif item.languageType == 'KOREAN'>
                韩语
            </#if></span>
                    </li>
                    <li class="pq-question-item-msg-container floatL">
                        <span class="floatL">是否绝密:</span>
                        <span class="pe-question-item-msg floatL"><#if item.security?? && item.security>是<#else>
                            否</#if></span>
                    </li>
                    <li class="pq-question-item-msg-container floatL">
                        <span class="floatL">所属知识点:</span>
                <span class=" pe-question-item-msg">
                <#if item.knowledges?? && (item.knowledges?size>0)>
                    <#list item.knowledges as knowledge>
                        <#if knowledge_index != 0>
                            ,
                        </#if>
                    ${(knowledge.knowledgeName)!}
                    </#list>
                </#if>
                </span>
                    </li>
                    <li class="pq-question-item-msg-container floatL">
                        <span class="floatL" style="letter-spacing:5px;">出题人:</span>
                        <span class="pe-question-item-msg floatL">${(item.createBy)!}</span>
                    </li>
                </ul>
            </div>
        </div>

        <button type="button" class="pe-btn pe-btn-blue pe-large-btn pe-view-question-close-btn">关闭</button>
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
<#--公用部分尾部版权-->
<footer class="pe-footer-wrap">
    <div class="pe-footer-copyright"> ${(footExplain)!'Copyright &copy${.now?string("yyyy")} 青谷科技专业考试系统 All Rights Reserved 皖ICP备16015686号-2'}</div>
</footer>
<script>
    $(function () {
        var imageUrls = [];
        $('img.upload-img').each(function (i, e) {
            imageUrls.push($(e).data('src'));
            $(e).attr('data-index', i);
        });

        if (imageUrls.length > 0) {
            $('.itemImageViewWrap').html(_.template($('#imageTemp').html())({data:imageUrls}));
            $('.all-images-wrap').show();
        }

        var imagesWrap = $('.all-images-wrap');
        for (var i = 0, ILen = imagesWrap.length; i < ILen; i++) {
            $(imagesWrap[i]).addClass('all-images-wrap' + (i + 1)).attr('data-index',i+1);
            if (!$(imagesWrap[i]).find('.swiper-wrapper img').get(0)) {
                $(imagesWrap[i]).hide();
            } else {
                $(imagesWrap[i]).find('.swiper-wrapper').css('transform', 'translate3d(0px, 0px, 0px)');
                $(imagesWrap[i]).find('.swiper-wrapper').css('-webkit-transform', 'translate3d(0px, 0px, 0px)');

                PEBASE.swiperInitItem($('body'),i+1);
            }
        }

        $('.all-images-wrap .swiper-wrapper').css('transform', 'translate3d(0px, 0px, 0px)');
        $('.pe-view-question-close-btn').on('click', function () {
            window.close();
        });

        //视频
        $('.pe-view-detail-all-wrap').delegate('.image-video', 'click', function () {
            var thisVideoSrc = $(this).attr('data-src');
            PEMO.VIDEOPLAYER(thisVideoSrc);
        });
        //音频
        $('.pe-view-detail-all-wrap').delegate('.image-audio', 'click', function (e) {
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
