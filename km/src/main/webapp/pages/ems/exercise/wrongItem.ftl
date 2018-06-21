<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zn-CH">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="renderer" content="webkit"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>${(paper.exam.examName)!}</title>
    <link rel="shortcut icon" href="${(resourcePath+icoUrl)!'${resourcePath!}/web-static/proExam/images/pe_ico_32.ico'}"
          type="image/x-icon"/>
    <link rel="stylesheet"
          href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}"
          type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/exam.css?_v=${(resourceVersion)!}" type="text/css">
    <!--[if lgt IE 9]>
    <style type="text/css">
        .count-down-panel .show-count {
            line-height: 71px;
        }

        .complete-info {
            margin-top: -2px;
        }
    </style>
    <![endif]-->
    <script>
        var pageContext = {
            userId: '${(user.id)!}',
            exeriseId: '${(exercise.id)!}',
            ctx: '${ctx!}',
            rootPath:'${ctx!}',
            resourcePath: '${resourcePath!}'
        };
    </script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/compressJs/examIng_plugin_min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${ctx!}/web-static/proExam/js/plugins/layer/layer.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>

</head>
<body class="view-exercise-body">
<div class="loading-before-mask" ><div class="loadingText">Loading...</div></div>
<#--公用头部-->
<div class="pe-public-top-nav-header has-exam-name-top">
    <div class="pe-top-nav-container">
        <ul class="clearF">
            <li class="exam-name floatL">${(exercise.exerciseName)!}</li>
        </ul>
    </div>
</div>
<div class="pe-container-main">
    <div class="pe-exercise-nav-top">
        <div class="pe-exercise-complete-left">
            <input name="exerciseSettingId" value="${(exerciseSetting.id)!}" type="hidden"/>
            <input name="exerciseId" value="${(exercise.id)!}" type="hidden"/>
        </div>
    </div>
    <div class="pe-answer-content-right-wrap">
        <div class="pe-answer-right-top blue-shadow" style="padding: 20px 9px;overflow: hidden;">
            <div class="pe-online-img floatL">
                <img onerror="javascript:this.src='${resourcePath!}/web-static/proExam/images/default/default_face.png'"
                     src="${(user.facePath)!'${resourcePath!}/web-static/proExam/images/default_face.png'}">
            </div>
            <div class="pe-wrong-true-inf" style="margin-left:95px;">
                <h2 class="pe-wrong-title">真实姓名</h2>
                <dl>
                    <dt><i class="iconfont">&#xe735;</i></dt>
                    <dd class="pe-online-examing" title="${(user.userName)!}">${(user.userName)!}
                    </dd>
                </dl>
                <dl>
                    <dt><i class="iconfont">&#xe732;</i></dt>
                    <dd class="pe-answer-num" style="width:148px;" title="${(user.idCard)!}">${(user.idCard)!}</dd>
                </dl>
            </div>
        </div>
        <div class="pe-answer-right-content blue-shadow">
            <div class="pe-answer-right-content-top">
                <h2>答题情况</h2>
            </div>
            <div class="pe-answer-right-contain">
                <div class="pe-answer-test-num">
                <#list ['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'] as itemType>
                    <#if exercise.exerciseContent?? && exercise.exerciseContent.prm?? && exercise.exerciseContent.prm[itemType]??>
                        <#assign pr = exercise.exerciseContent.prm[itemType]/>
                        <#list pr.ics as ic>
                            <a class="pe-wrong-answer-item" href="#_${(ic.no)!}">
                                <span class="pe-answer-right-num">${(ic.no)!}</span>
                                <#if (!recordMap[ic.id]??)>
                                    <span class="pe-result-empty"></span>
                                <#else>
                                    <#if recordMap[ic.id].sign?string("true","false")=='true'>
                                        <span class="pe-star iconfont icon-start-difficulty pe-wrong-start"></span>
                                    </#if>
                                    <#if itemType!='FILL' && itemType !='QUESTIONS'>
                                        <#if recordMap[ic.id]?? >
                                            <span class="iconfont pe-wrong-con">&#xe614;</span>
                                        </#if>
                                    <#else>
                                        <span class="iconfont pe-wrong-con">0</span>
                                    </#if>
                                </#if>
                            </a>
                        </#list>
                    </#if>
                </#list>
                </div>
            </div>
        </div>
    </div>
    <div class="pe-answer-content-left-wrap stu-content-left" style="position:relative;overflow:visible;">
        <div class="pe-wrong-nav">
            <p class="pe-wrong-pass">
                错误题数：${(exercise.itemCount)!}道
            </p>
            <lable class="pe-wrong-switch pe-checkbox pe-check-by-list">
                <span class="iconfont icon-checked-checkbox peChecked"></span>
                <input  class="pe-form-ele" checked="checked" type="checkbox" name="show" value="">显示正确答案和解析
            </lable>

        </div>
        <div class="pe-wrong-contain">
            <div class="pe-wrong-content-wrap">
            </div>
            <#list ['SINGLE_SELECTION','MULTI_SELECTION','INDEFINITE_SELECTION','JUDGMENT','FILL','QUESTIONS'] as itemType>
                <#if exercise.exerciseContent?? && exercise.exerciseContent.prm?? && exercise.exerciseContent.prm[itemType]??>
                    <#assign pr = exercise.exerciseContent.prm[itemType]/>
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
                            <a name="no_${(ic.no)!}" id="_${(ic.no)!}" style="position:relative;top:-84px;display:block;"></a>
                            <div class="add-paper-question-item-wrap pe-answer-content-item-wrap" id="_${(ic.no)!}"
                                     style="border-bottom: none;">
                                    <div class="paper-add-question-content " style="border:none;border-bottom:1px solid #cbcbcb;">
                                        <div class="paper-question-stem">
                                            <span class="paper-question-num">${(ic.no)!}、</span>
                                            <span class="pe-question-score">(${(ic.m)!}分）</span>
                                            <div class="paper-item-detail-stem"
                                                 <#if itemType == 'FILL'>data-answer="${(recordMap[ic.id].answer)!}"</#if>>
                                            <p class="pe-for-step">${(ic.ct)!}
                                                </p>
                                            </div>
                                            <div class="all-images-wrap">
                                                <div class="swiper-container">
                                                    <ul class="itemImageViewWrap swiper-wrapper">
                                                    </ul>
                                                    <div class="pagination"></div>
                                                </div>
                                            </div>
                                            <div class="pe-question-item-level" style="right:0;">
                                                <div class="pe-star-wrap">
                                                    <input name="itemId" value="${(ic.id)!}" type="hidden"/>
                                                <span class="pe-star-container pe-wrong-item-recycle">
                                                      <span class="pe-star iconfont icon-lajitong"></span>
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
                                                                <div class="question-items-choosen-text">${(io.ct)}
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
                                                        <textarea placeholder="${(recordMap[ic.id].answer)!}"
                                                                  disabled="disabled"
                                                                  style="width: 725px;">
                                                        ${(recordMap[ic.id].answer)!}
                                                        </textarea>
                                                </p>
                                            </#if>
                                        </ol>
                                        <div class="pe-wrong-answer">
                                            <h2 class="pe-wrong-answer-con">
                                                答案：<#if itemType == 'JUDGMENT'><#if ic.t?? && ic.t>
                                                正确<#else>错误</#if><#else>${(ic.a)!}</#if></h2>
                                            <p class="pe-wrong-parsing">解析：${(ic.ep)!}
                                            </p>
                                        </div>
                                    </div>
                                </div>
                        </#list>
                    </div>
                </#if>
            </#list>
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

    <script>
        $(function () {
            var swipObj = {
                swiperObj: {},
                swiperBindTimes: 0,
                swiperInitItem: function (wrapDom, index) {
                    var swiperDom = '.all-images-wrap' + index + ' ' + ' .swiper-container';
                    swipObj.swiperObj[index] = new Swiper(swiperDom, {
                        pagination: '.pagination',
                        paginationClickable: true,
                        centeredSlide: true,
                        freeModeFluid: true,
                        grabCursor: true,
                        observer: true,//修改swiper自己或子元素时，自动初始化swiper
                        observeParents: true,
                        slidesPerView: 'auto',
                        updateOnImagesReady: true,
                        watchActiveIndex: true,
                        onFirstInit: function () {
                            $('.itemImageViewWrap').viewer({
                                url: 'data-original',
                                title: false,
                                fullscreen: false,
                                show: function (d, t) {
                                    $('.pe-answer-nav-top').css("zIndex", "-1");
                                    $('.pe-answer-content-right-wrap').css("zIndex", "-1");
                                    $('.pe-public-top-nav-header').css("zIndex", "-1");
                                    var _thisSwiper = $(d.currentTarget).parent('.swiper-container');
                                    $('.swiper-container').not(_thisSwiper).css('z-index', '0');


                                },
                                shown: function () {
                                },
                                hidden: function (d, t) {
                                    $('.pe-answer-nav-top').css("zIndex", "1989");
                                    $('.pe-answer-content-right-wrap').css("zIndex", "1989");
                                    $('.pe-public-top-nav-header').css("zIndex", "1989");
                                    var _thisSwiper = $(d.currentTarget).parent('.swiper-container');
                                    $('.swiper-container').not(_thisSwiper).css('z-index', '1');
                                }
                            });
                        }
                    });
                    $('.upload-img').undelegate();
                    if (swipObj.swiperBindTimes === 0) {
                        wrapDom.delegate('.upload-img', 'click', function (e) {
                            var e = e || window.event;
                            if (e.stopPropagation) {
                                e.stopPropagation();
                            } else {
                                e.cancelBubble = true;
                            }
                            // e.preventDefault();
                            var _this = $(this);
                            var swiperWrapper = _this.parents('.paper-add-question-content ').find('.swiper-wrapper');
                            swiperWrapper.find('li').removeClass('image-icon-cur');
                            var thisIdType = $(this).attr('data-index');
                            swiperWrapper.find('li[data-index="' + thisIdType + '"]').addClass('image-icon-cur');
                            var thisIconIndex = swiperWrapper.find('li[data-index="' + thisIdType + '"]').index();
                            var thisSwiperIndex = parseInt(swiperWrapper.parents('.all-images-wrap').attr('data-index'));
                            swipObj.swiperObj[thisSwiperIndex].swipeTo(thisIdType);
                        });
                        swipObj.swiperBindTimes = 1;
                    }

                }
            }

            $('.paper-add-question-content').each(function (i, wrapDom) {
                var imgHtml = '';
                $(wrapDom).find('img.upload-img').each(function (i, e) {
                    imgHtml = imgHtml + '<li class="pe-view-question-detail-img-wrap swiper-slide over-flow-hide" data-index="' + i + '"style="display:inline-block;"><img class="pe-question-detail-img-item" data-original="' + $(e).data('src') + '" src="' + $(e).data('src') + '" width="auto" height="100%"/></li>'
                    $(e).attr('data-index', i);
                });

                var imagesWrap = $(wrapDom).find('.all-images-wrap');
                if (imgHtml != '') {
                    $(wrapDom).find('.itemImageViewWrap').append(imgHtml);
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
                    //图片轮播的样式和功能
                    swipObj.swiperInitItem($('body'), i + 1);
                }
            }

            setTimeout(function(){
                $('.loading-before-mask').hide();
            },4000);

            $('.pe-answer-test-num').mCustomScrollbar('destroy').mCustomScrollbar({
                axis: "y",
                theme: "dark-3",
                scrollbarPosition: "inside",
                setWidth: '273px',
                advanced: {updateOnContentResize: true}
            });

            var windowHeight = $(window).height();
            //64头部高度，106是考试标题的panel的outerHeight，40是中间的panel的上下padding，40是中间panel的margin-bottom，60是footer的高度;
            var thisShouldHeight = windowHeight - 64 - 132 - 40;
            var rightTopHeight = $('.pe-answer-right-top').outerHeight();
            var rightContentTopHeight = $('.pe-answer-right-content-top').outerHeight();
            var rightItemListHeight = thisShouldHeight - rightTopHeight - rightContentTopHeight  - 20 - 40;
            $('.pe-answer-test-num').css('height', (rightItemListHeight) + 'px');
            var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
            $('.pe-answer-content-right-wrap').css('left', (parseInt(leftPanel) + parseInt($('.pe-answer-content-left-wrap').offset().left) + 20) + 'px');

            $(window).resize(function(){
                var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
                $('.pe-answer-content-right-wrap').css('left', (parseInt(leftPanel) + parseInt($('.pe-answer-content-left-wrap').offset().left) + 20) + 'px');
            })
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

                var answerStr = answer.toString().split("|");
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
//            $('.pe-music-type-icon').on('click', function (e) {
            $(".image-audio").on('click',function(e){
                if ($('.pe-music-type-icon').not($(this)).hasClass('audio-playing')) {
                    PEMO.AUDIOOBJ.obj.player_.pause();
                    $('.pe-music-type-icon.audio-playing').removeClass('audio-playing audio-pause');
                }
                var thisVideoSrc = $(this).attr('data-src');
                if ($(this).hasClass('audio-playing')) {
                    //已经在播放，这里执行暂停
                    PEMO.AUDIOPLAYER(thisVideoSrc, true);
                    $(this).removeClass('audio-playing').addClass('audio-pause');
                } else {
                    PEMO.AUDIOPLAYER(thisVideoSrc, false);
                    $(this).addClass('audio-playing').removeClass('audio-pause');
                }
                /*监听音频播放结束*/
                PEMO.AUDIOOBJ.obj.on('ended', function () {
                    $('.pe-music-type-icon.audio-playing').removeClass('audio-playing audio-pause');
                })
            });

            $(".pe-wrong-item-recycle").click(function(){
                var $itemWrap = $(this).parents(".pe-answer-content-item-wrap");
                var itemId = $(this).parent(".pe-star-wrap").find("input[name='itemId']").val();
                var exerciseId = $("input[name='exerciseId']").val();
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exercise/client/deleteWrongItem',
                    data:{exerciseId:exerciseId,itemId:itemId},
                    success: function (data) {
                        if(data.success){
                            PEMO.DIALOG.tips({
                                content: '移除成功',
                                time: 1000,
                                end: function () {
                                    location.reload();
                                }
                            });

                        }
                    }
                });

            });
            function getImgNums(){
                var imagesWrap = $('.all-images-wrap:visible');
                if(imagesWrap.size()<=0){
                    return ;
                }

                var imgNums =[];
                imagesWrap.each(function(i,wrapDom){
                    var index = $(this).data("index");
                    imgNums.push(index);
                });
                return imgNums;
            };
            //点击隐藏答案解析图片；
            function hideExplainImgs() {
               var imgNums = getImgNums();
                if(typeof imgNums =="object"){
                    for(var i=0;i<imgNums.length;i++){
                       var imgNum =  imgNums[i];
                        var $imgsWrap = $(".all-images-wrap"+imgNum);
                        var $imgs =  $imgsWrap.parents(".paper-add-question-content").find(".pe-wrong-answer img");
                        if($imgs.length>0){
                            $imgs.each(function(i,imageDom){
                                var imageIndex = $(imageDom).data("index");
                                var image =$imgsWrap.find("li[data-index='"+imageIndex+"']").find("img");
                                var url = image.attr("src");
                                image.attr("src",'');
                                image.attr("data-original",'');
                                image.attr("img-url",url);
                            });
                        }
                    }
                }
            };
            //点击显示答案解析图片；
            function showExplainImgs() {
                var imgNums = getImgNums();
                if(typeof imgNums =="object"){
                    for(var i=0;i<imgNums.length;i++){
                        var imgNum =  imgNums[i];
                        var $imgsWrap = $(".all-images-wrap"+imgNum);
                        var $imgs =  $imgsWrap.parents(".paper-add-question-content").find(".pe-wrong-answer img");
                        if($imgs.length>0){
                            $imgs.each(function(i,imageDom){
                                var imageIndex = $(imageDom).data("index");
                                var image =$imgsWrap.find("li[data-index='"+imageIndex+"']").find("img");
                                var url = image.attr("img-url");
                                image.attr("src",url);
                                image.attr("data-original",url);
                                image.removeAttr("img-url");
                            });
                        }

                        PEBASE.swiperInitItem($('body'),imgNum);
                    }
                }
            };
            $(".pe-wrong-switch").off().click(function(){
                var $this = $(this);
                var iconCheck = $(this).find('span.iconfont');
                var itemAnswer = $(".pe-wrong-answer");
                if(iconCheck.hasClass("icon-checked-checkbox peChecked")){
                    iconCheck.removeClass("icon-checked-checkbox peChecked").addClass("icon-unchecked-checkbox");
                    itemAnswer.prop("hidden",true);
                    hideExplainImgs();
                }else{
                    iconCheck.removeClass("icon-unchecked-checkbox").addClass("icon-checked-checkbox peChecked");
                    itemAnswer.prop("hidden",false);
                    showExplainImgs();
                }
            });

        })
    </script>
</body>
</html>