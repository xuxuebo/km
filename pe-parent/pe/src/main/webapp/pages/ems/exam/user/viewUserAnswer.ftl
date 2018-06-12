<#--<#assign ctx=request.contextPath/>-->
<#--&lt;#&ndash;todo开发开始做这个页面的跳转时记得把下面的import和p.pageFrame删除&ndash;&gt;-->
<#--<#import "../../../noNavTop.ftl" as p>-->

<!doctype html>
<html lang="zn-CH">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="renderer" content="webkit" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>${(paper.exam.examName)!}</title>
    <link rel="shortcut icon" href="${resourcePath!}/web-static/proExam/images/pe_ico_32.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/exam_min.css?_v=${(resourceVersion)!}" type="text/css">
    <script>

    </script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/compressJs/examIng_plugin_min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>
</head>
<body class="u-view-exam-paper-body" style="background:#edf0f4;">
<#--公用头部-->
<div class="pe-public-top-nav-header has-exam-name-top tom">
    <div class="pe-top-nav-container">
        <ul class="clearF">
            <li class="exam-name floatL">${(examResult.exam.examName)!}</li>
        </ul>
    </div>
</div>
<div class="pe-container-main view-user-answer" style="width:1204px;overflow:visible;">
    <div class="pe-answer-content-left-wrap" style="position:relative;overflow:visible;">
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
                <dl class="clear"></dl>
            </div>
        </div>
        <div class="pe-wrong-contain">
            <div class="pe-wrong-content-wrap">
                <#assign examSetting= examResult.exam.examSetting/>
                <#if examSetting.examAuthType == 'SEE_PAPER_NO_ANSWER'>
                    以下为完整答卷
                <#elseif examSetting.examAuthType == 'JUDGE_AND_SEE_ALL'>
                    以下为完整答卷以及正确答案
                <#elseif examSetting.examAuthType == 'SEE_ERROR_NO_ANSWER'>
                    以下为错题答卷
                <#elseif examSetting.examAuthType == 'SEE_ERROR_AND_ANSWER'>
                    以下为错题答卷及正确答案
                </#if>
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
                            <#if !((examSetting.examAuthType == 'SEE_ERROR_NO_ANSWER' || examSetting.examAuthType == 'SEE_ERROR_AND_ANSWER') && recordMap[ic.id]?? && (recordMap[ic.id].score>0))>
                                <a name="_${(ic.no)!}" id="_${(ic.no)!}" style="position:relative;top:-84px;display:block;"></a>
                                <div class="add-paper-question-item-wrap pe-answer-content-item-wrap" id="_${(ic.no)!}"
                                     style="<#if pr.ics?size == (ic_index +1)>border-bottom:1px dashed #babfc6 <#else>border-bottom: none;</#if>">
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
                                            <span class="paper-question-num">${(ic.no)!}、</span>
                                            <span class="pe-question-score">(${(recordMap[ic.id].totalScore)!}分）</span>
                                            <div class="paper-item-detail-stem"
                                                 <#if itemType == 'FILL'>data-answer="${(recordMap[ic.id].answer)!}"</#if>>
                                              ${(ic.ct)!}
                                            </div>
                                            <div class="all-images-wrap">
                                                <div class="swiper-container">
                                                    <ul class="itemImageViewWrap swiper-wrapper">
                                                    </ul>
                                                    <div class="pagination"></div>
                                                </div>
                                            </div>
                                            <div class="pe-question-item-level">
                                                <div class="pe-star-wrap">
                                                <span class="pe-star-container">
                                                      <#if recordMap[ic.id]?? && recordMap[ic.id].sign>
                                                       <span class="pe-star iconfont pe-checked-star icon-has-mark-star"></span>
                                                     </#if>
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
                                                               id="_${(itemType_index)}_${(ic.no)!}_${(io_index)!}"
                                                               disabled
                                                            <#if recordMap[ic.id]?? && recordMap[ic.id].answer?? && (recordMap[ic.id].answer?split(",")?seq_contains(""+io_index))>
                                                               checked</#if>/>
                                                        <label class="pe-exam-radio"
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
                                                                  style="width: 725px;">${(recordMap[ic.id].answer)!}
                                                        </textarea>
                                                </p>
                                            </#if>
                                        </ol>
                                    </div>
                                    <div class="pe-wrong-answer">
                                        <#if examSetting.examAuthType == 'JUDGE_AND_SEE_ALL' || examSetting.examAuthType == 'SEE_ERROR_AND_ANSWER'>
                                            <h2 class="pe-wrong-answer-con">
                                                答案：<#if itemType == 'JUDGMENT'><#if ic.t?? && ic.t>
                                                正确<#else>错误</#if><#else>${(ic.a)!}</#if></h2>
                                            <p class="pe-wrong-parsing">解析：${(ic.ep)!}
                                            </p>
                                        </#if>
                                    </div>
                                </div>
                            </#if>
                        </#list>
                    </div>
                </#if>
            </#list>

        </div>
        <div class="pe-answer-content-right-wrap" style="position:absolute;left:900px;top:0;">
            <div class="pe-answer-right-top blue-shadow" style="padding: 20px 9px;overflow: hidden;">
                <div class="pe-online-img" style="float: left;">
                    <img src="${(user.facePath)!'${resourcePath!}/web-static/proExam/images/default_face.png'}">
                </div>
                <div class="pe-wrong-true-inf">
                    <h2 class="pe-wrong-title">${(user.userName)!}</h2>
                    <dl>
                        <dt><i class="iconfont">&#xe735;</i></dt>
                        <dd class="pe-online-examing">${(user.loginName)!}</dd>
                    </dl>
                <#if user.idCard??>
                    <dl>
                        <dt><i class="iconfont">&#xe732;</i></dt>
                        <dd class="pe-answer-num" title="${(user.idCard)!}" style="width: 148px;">${(user.idCard)!}</dd>
                    </dl>
                </#if>
                </div>
            </div>
            <div class="pe-answer-right-content blue-shadow">
                <div class="pe-answer-right-content-top">
                    <h2>答题情况</h2>
                </div>
                <div class="pe-answer-right-contain">
                    <div class="pe-answer-test-num">
                    <#list ['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'] as itemType>
                        <#if prm[itemType]??>
                            <#assign pr = prm[itemType]/>
                            <#list pr.ics as ic>
                                <#if !((examSetting.examAuthType == 'SEE_ERROR_NO_ANSWER' || examSetting.examAuthType == 'SEE_ERROR_AND_ANSWER') && recordMap[ic.id]?? && (recordMap[ic.id].score>0))>
                                    <a class="pe-wrong-answer-item" href="#_${(ic.no)!}">
                                        <span class="pe-answer-right-num"
                                              <#if (!(recordMap[ic.id]??) || (recordMap[ic.id].score == 0 && !(recordMap[ic.id].answer??)))>style="border:1px dashed #cbcbcb;border-bottom:none;"</#if>>${(ic.no)!}</span>
                                        <#if (!(recordMap[ic.id]??) || (recordMap[ic.id].score == 0 && !(recordMap[ic.id].answer??)))>
                                        <#--<span class="pe-result-empty">0</span>-->
                                            <#if itemType!='FILL' && itemType !='QUESTIONS'>
                                                <span class="iconfont pe-wrong-con">&#xe614;</span>
                                            <#else>
                                                <span class="iconfont pe-wrong-con">0</span>
                                            </#if>
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
                                                    <span class="iconfont pe-wrong-con">0</span>
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
    </div>

    <div class="clear"></div>
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
    <script type="text/javascript">
        $(function () {
            var viewUserPaper = {
                init:function(){
                    viewUserPaper.bind();
                    $(window).scrollTop(0);
                    PEBASE.renderHeight(0);
                },
                bind:function(){
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
                    $('.pe-paper-preview-content').each(function (index, ele) {
                        var $itemWrap = $(this).find('.pe-answer-content-item-wrap');
                        if (!$itemWrap || $itemWrap.length <= 0) {
                            $(this).hide();
                        }
                    });


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

                    //视频
                    $('.image-video').on('click', function () {
                        var thisVideoSrc = $(this).attr('data-src');
                        PEMO.VIDEOPLAYER(thisVideoSrc);
                    });
                    //音频
                    $('.image-audio').on('click', function (e) {
                        var _this = $(this);
                        if($('.image-audio').not(_this).hasClass('audio-playing') || $('.image-audio').not($(this)).hasClass('audio-pause')){
                            PEMO.AUDIOOBJ.obj.player_.pause();
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


                    /*初始化屏幕计算右边头像，题目等面板的位置*/
                    var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
                    var leftPanelOffsetLeft = $('.pe-answer-content-left-wrap').offset().left;

                    $('.pe-answer-test-num').mCustomScrollbar('destroy').mCustomScrollbar({
                        axis: "y",
                        theme: "dark-3",
                        scrollbarPosition: "inside",
                        setWidth: '273px',
                        advanced: {updateOnContentResize: true}
                    });

                    $(window).scroll(function () {
                        var windowScrollTop = $(window).scrollTop();
                        var windowScrollLeft = $(window).scrollLeft();
                        $('.pe-answer-content-right-wrap').css("top",windowScrollTop);
                            PEBASE.renderHeight(0);
                    });

                }
            }

            viewUserPaper.init();
        })
    </script>
</body>
</html>