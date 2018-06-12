$(function () {
    $(document).ajaxComplete(function (event, jqXHR, options) {
        var ajaxRequestStatus = jqXHR.getResponseHeader("ajaxRequest");
        if (ajaxRequestStatus === 'loginFailed') {
            location.href = CFG.ctx + '/client/logout';
        }
    });
    var exerciseModel = {
        topTimeInterval: 0,
        exerciseSettingId: $("input[name='exerciseSettingId']").val(),
        renderHeight: function (scrollTop) {
            var windowHeight = $(window).height();
            //64头部高度，106是考试标题的panel的outerHeight，40是中间的panel的上下padding，40是中间panel的margin-bottom，60是footer的高度;
            var thisShouldHeight = windowHeight - 64 - 20 - 10 - 30 - 5;
            var rightTopHeight = $('.pe-answer-right-top').outerHeight();
            var rightContentTopHeight = $('.pe-answer-right-content-top').outerHeight();
            var rightBtnHeight = $('.pe-answer-sure').outerHeight();
            var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
            var rightItemListHeight = thisShouldHeight - rightTopHeight - rightContentTopHeight - rightBtnHeight - 20 - 40;
            $('.pe-answer-test-num').css('height', (rightItemListHeight) + 'px');
            $('.pe-answer-content-right-wrap').css('left', (parseInt(leftPanel) + parseInt($('.pe-answer-content-left-wrap').offset().left) + 20) + 'px');
            $('.pe-answer-content-right-wrap').css('top',$('.stu-content-left').offset().top);
            $('.pe-answer-content-left-wrap').css({'minHeight':'650px'});
        },
        //处理答题进度以及显示题号样式问题
        checkAnswer: function ($mtWrap) {
            var itemType = $mtWrap.data('type'), no = $mtWrap.data('no');
            var $noItemDom = $('.pe-wrong-answer-item[name="no_' + no + '"]');
            $noItemDom.find('.pe-answer-right-num').addClass('done');
            if (itemType === 'FILL' || itemType === 'QUESTIONS') {
                $noItemDom.find('.iconfont').removeClass('pe-result-empty').addClass('pe-wrong-con').text('0');
                return false;
            }

            var isRight = true;
            $($mtWrap.find('.right-option-wrap')).each(function (i, e) {
                if (!$(e).find('input').is(':checked')) {
                    isRight = false;
                }
            });
            $($mtWrap.find(".question-single-item-wrap").not(".right-option-wrap")).each(function (index, dobj) {
                if ($(dobj).find('input').is(':checked')) {
                    isRight = false;
                }
            });

            if (isRight) {
                $noItemDom.find('.pe-result-empty').removeClass('pe-result-empty').addClass('pe-right').addClass('icon-right');
                return false;
            }

            $noItemDom.find('.pe-result-empty').removeClass('pe-result-empty').addClass('pe-wrong-con').addClass('icon-wrong');
        },

        tips: function (setting) {
            //layer.js封装的tip提示框
            var defaults = {
                type: 0
                , closeBtn: 1
                , skin: 'pe-auto-tips ' + setting.skin
                , title: ''
                , content: ''
                , time: 1000
                , resize: false
                , scrollbar: true
                , move: '.layui-layer-title'
                , shade: 0
                , end: function () {

                }
            };

            $.extend(defaults, setting);
            layer.open(defaults);
        },
        alert: function (setting) {
            //layer.js封装的tip提示框
            var defaults = {
                type: 0
                , closeBtn: 1
                , skin: 'pe-layer-alert'
                , title: ''
                , content: ''
                , area: ['420px']
                , resize: false
                , scrollbar: false
                , move: '.layui-layer-title'
                , shade: [0.3, '#000']
                , yes: function (index) {
                    //确认按钮回调函数
                    layer.close(index);
                }
            };

            $.extend(defaults, setting);
            layer.open(defaults);
        },
        confirmL: function (setting) {
            //确认按钮在左，取消按钮在右(confirm-Layer)
            var defaults = {
                type: 1
                , closeBtn: 1
                , skin: 'pe-layer-confirm pe-layer-has-tree'
                , area: ['450px']
                , title: ''
                , btn: ['确认', '取消']
                , btnAlign: 'c'
                , content: ''
                , resize: false
                , scrollbar: false
                , move: '.layui-layer-title'
                , shade: [0.3, '#000']
                , btn1: function () {
                    //确认按钮的回调函数
                }
                , btn2: function () {
                    //取消按钮的回调函数
                }
                , cancel: function () {
                    //右上角关闭回调函数
                }
                , end: function () {
                    //弹框关闭回调函数
                }
            };

            $.extend(defaults, setting);
            layer.open(defaults);
        },
        confirmR: function (setting) {
            //确认按钮在右，取消按钮在左(confirm-Another-Layer)
            var defaults = {
                type: 1
                , closeBtn: 1
                , skin: 'pe-layer-confirmA'
                , area: '450px'
                , title: ''
                , btn: ['取消', '确认']
                , content: ''
                , resize: false
                , move: '.layui-layer-title'
                , scrollbar: false
                , shade: [0.3, '#000']
                , btn1: function (index) {
                    //取消按钮的回调函数
                    layer.close(index);
                }
                , btn2: function () {
                    //确认按钮的回调函数
                }
                , cancel: function () {
                    //右上角关闭回调函数
                }
                , end: function () {
                    //弹框关闭回调函数
                }
            };

            $.extend(defaults, setting);
            layer.open(defaults);
        },
        getUserAnswer: function ($mtWrap) {
            var itemType = $mtWrap.data('type'), no = $mtWrap.data('no');
            if (itemType === 'SINGLE_SELECTION' || itemType === 'JUDGMENT') {
                //单选题 判断题
                if ($mtWrap.find('.pe-exam-radio-wrap input:checked').parents('.question-single-item-wrap').hasClass('right-option-wrap')) {
                    isRight = true;
                }

                $mtWrap.find('.pe-exam-radio-wrap input').removeAttr('id');
                return $mtWrap.find('.pe-exam-radio-wrap input:checked').val();
            }

            if (itemType === 'FILL') {
                var data = [];
                $mtWrap.find('.insert-blank-item').each(function () {
                    $(this).attr('readonly', 'readonly');
                    data.push($(this).val());
                });

                return data.join("|");
            }

            if (itemType === 'MULTI_SELECTION' || itemType === 'INDEFINITE_SELECTION') {
                var arrValue = [];
                $('input[name="_' + no + '"]').each(function (i, e) {
                    if ($(e).is(':checked')) {
                        arrValue.push($(this).val());
                    }
                });

                $('input[name="_' + no + '"]').removeAttr('id');
                return arrValue.join(',');
            }

            var $thisAreaDom = $mtWrap.find('.pe-answer-content-text textarea');

            if($thisAreaDom.get(0)){
                $thisAreaDom.attr('readonly', 'readonly');
                $thisAreaDom.val($thisAreaDom.val().replace(/\s/g,""));
            }
            return $thisAreaDom.val();
        },
        renderLeftPanel: function () {
            var thisShouldBeHeight = $(window).height() - 64 - 20 - 15 + 2;//64头部高度，20是answer-exam-nav-top的高度,60是footer的高度,70是form表单的margin-bottom的值
            if (thisShouldBeHeight > $('.pe-answer-content-left-wrap').height()) {
                $('.pe-answer-content-left-wrap').css('minHeight', thisShouldBeHeight);
                $('.pe-answer-test-num').height($('.pe-answer-test-num').height());
            }
        },

        calculateTop: function () {
            if (!CFG.speedType || CFG.speedType === 'UNLIMIT' || parseInt(CFG.speed) <= 0) {
                $('.count-down-panel').hide();
                return false;
            }

            var speed = CFG.speed;
            exerciseModel.renderTopTime(speed);
            exerciseModel.topTimeInterval = setInterval(function () {
                if (speed === 0) {
                    clearInterval(exerciseModel.topTimeInterval);
                    var $submitBtn = $('.pe-making-template-wrap:not(.hideSingle)').find(".pe-complete-btn");
                    if($submitBtn.length>0){
                        $submitBtn.hide();
                    }
                    exerciseModel.submitAnswer($('.pe-making-template-wrap:not(.hideSingle)'));
                    return false;
                }

                speed--;
                exerciseModel.renderTopTime(speed);
            }, 1000);
        },
        renderTopTime: function (t) {
            var timeArr = [];
            timeArr.push(Math.floor(t / 60 / 60));
            timeArr.push(Math.floor((t - timeArr[0] * 60 * 60) / 60));
            timeArr.push(t - timeArr[0] * 60 * 60 - timeArr[1] * 60);
            for (var i = 0; i < timeArr.length; i++) {
                if (timeArr[i] < 10) {
                    timeArr[i] = "0" + timeArr[i];
                }
            }

            $('#countDownPanel').find('.count-down').html(timeArr.join(':'));
        },
        showAnswer: function () {
            if (CFG.startNo == CFG.totalNo) {
                $(".pe-making-template-wrap[data-no=" + CFG.startNo + "] .pe-wrong-answer").css("display", "block");
            }
        },
        scrollBar: function () {
            var doneLength = parseInt($('.has-answer-num').text());
            var totalAnswer = parseInt($('.total-answer-num').text());
            var completeInfo = ((doneLength / totalAnswer) * 100).toFixed(0) + "%";
            $('.exam-answer-top-header').find('.pe-answer-progress').get(0).style.width = completeInfo;
            $('.exam-answer-top-header').find('.complete-info').html(completeInfo);
            $('.pe-answer-test-num').mCustomScrollbar('destroy').mCustomScrollbar({
                axis: "y",
                theme: "dark-3",
                scrollbarPosition: "inside",
                setWidth: '273px',
                advanced: {updateOnContentResize: true}
            });
        },
        clearTopTime: function () {
            if (exerciseModel.topTimeInterval) {
                clearInterval(exerciseModel.topTimeInterval);
            }

            exerciseModel.renderTopTime(0);
        },
        ajaxRequest: function (setting) {
            var defaults = {
                url: '',
                data: '',
                type: 'post',
                success: function (data) {
                },
                async: true,
                dataType: 'json'
            };

            $.extend(defaults, setting);
            $.ajax({
                type: defaults.type,
                url: defaults.url,
                dataType: defaults.dataType,
                data: defaults.data,
                async: defaults.async,
                success: defaults.success,
                processData: defaults.processData,
                contentType: defaults.contentType
            });
        },
        packageUserAnswers: function ($answerContainers) {
            var userAnswers = {};
            $.each($(".pe-making-template-wrap"), function (t, i) {
                var itemId = $(i).data("id");
                var answer = exerciseModel.getUserAnswer($(i));
                var $starSign = $(i).find(".pe-star");
                if ($starSign.hasClass("pe-checked-star")) {
                    answer = answer + "_" + "1";
                } else {
                    answer = answer + "_" + "0";
                }
                userAnswers[itemId] = answer;
            });
            return JSON.stringify(userAnswers);
        },
        showExplainImgs:function($imageContainer){
                var $img = $imageContainer.find("img");
                $img.each(function(i,imgDom){
                    if($(imgDom).attr("img-url")){
                        var imgUrl =  $(imgDom).attr("img-url");
                        $(imgDom).attr("data-original",imgUrl);
                        $(imgDom).attr("src",imgUrl);
                        $(imgDom).parent("li").show();
                        $(imgDom).css("display",'inline-block');
                    }
                });

            var $thisImagesWrap = $imageContainer.parents(".pe-making-template-wrap").find('.all-images-wrap');
            var thisImagesNumber = parseInt($thisImagesWrap.attr('data-index'));
            //确认后，重新渲染当前是显示的all-images-wrap的swiper功能；
            //exerciseModel.swiperInitItem($('body'),thisImagesNumber);
        },
        hideExplainImg:function(thisDom){
            var index = thisDom.data("index");
            var itemExplain = thisDom.parent(".paper-add-question-content").find(".pe-wrong-answer");
            if(itemExplain.css("display")=='none'){
                var images = itemExplain.find('.pe-wrong-parsing img');
                images.each(function(i,imageDom){
                    var imageIndex = $(imageDom).data("index");
                    var image =thisDom.find("li[data-index='"+imageIndex+"']").find("img");
                    var url = image.attr("src");
                    image.attr("src",'');
                    image.attr("data-original",'');
                    image.attr("img-url",url);
                });

            }
        },
        swiperObj: {},
        swiperBindTimes: 0,
        swiperInitItem: function (wrapDom, index) {
            var swiperDom = '.all-images-wrap' + index + ' ' + ' .swiper-container';
            exerciseModel.swiperObj[index] = new Swiper(swiperDom, {
                pagination: '.pagination',
                paginationClickable: true,
                centeredSlide: true,
                freeModeFluid: true,
                grabCursor: true,
                slidesPerView: 'auto',
                updateOnImagesReady: true,
                watchActiveIndex: true,
                onFirstInit: function () {
                    $(swiperDom).find('.itemImageViewWrap').viewer({
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
            if (exerciseModel.swiperBindTimes === 0) {
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
                    exerciseModel.swiperObj[thisSwiperIndex].swipeTo(thisIdType);
                });
                exerciseModel.swiperBindTimes = 1;
            }

        },
        submitAnswer: function ($makingTemplateWrap) {
            var itemId = $makingTemplateWrap.data("id");
            var userAnswer = exerciseModel.getUserAnswer($makingTemplateWrap);
            exerciseModel.checkAnswer($makingTemplateWrap);
            $makingTemplateWrap.find('.pe-next-btn').show();
            if (CFG.questionAnswer && CFG.questionAnswer === 'SHOW') {
                $makingTemplateWrap.find('.pe-wrong-answer').slideDown();
            }
            var hasAnswerNum = $('.pe-answer-test-num').find('.pe-answer-right-num.done').size();
            $('.has-answer-num').html(hasAnswerNum);
            exerciseModel.scrollBar();
            var itemNo = $makingTemplateWrap.data('no');
            var $noItemDom = $('.pe-wrong-answer-item[name="no_' + itemNo + '"]');
            var $starSign = $makingTemplateWrap.find(".pe-star");
            var hasSigned = false;
            if ($starSign.hasClass("pe-checked-star")) {
                hasSigned = true;
            }
            var $submitBtn = $makingTemplateWrap.find(".pe-complete-btn");
            if ($submitBtn.hasClass("pe-btn-green")) {
                $submitBtn.removeClass("pe-btn-green").addClass("pe-btn-purple").attr("disabled", "true");
            }

            exerciseModel.ajaxRequest({
                url: CFG.ctx + '/ems/exercise/client/submitAnswer',
                data: {
                    'exerciseSetting.id': exerciseModel.exerciseSettingId,
                    'item.id': itemId,
                    'answer': userAnswer,
                    'sign': hasSigned
                }
            });

        },
        bind: function () {
            $('body').css('background', '#edf0f4');
            var _this = this;
            $(".pe-prev-btn").click(function () {
                var $audioPlayingDom = $('.image-audio.audio-playing');
                var $audioPauseDom = $('.image-audio.audio-pause');
                $audioPlayingDom.each(function(i,audioBtn){
                    PEMO.AUDIOOBJ.obj.player_.pause();
                    $(audioBtn).removeClass("audio-playing");
                });

                var _thisParentMarking = $(this).parent(".marking-btn-wrap").parent(".pe-making-template-wrap"),_thisPrevMarking = _thisParentMarking.prev('.pe-making-template-wrap').eq(0);
                _this.clearTopTime();

                var $currentTemplateWrap = $(this).parents(".pe-making-template-wrap"), no = $currentTemplateWrap.data('no');
                $currentTemplateWrap.addClass('hideSingle');
                $currentTemplateWrap.prev().removeClass('hideSingle');

                var $noItemDom = $('.pe-wrong-answer-item[name="no_' + (no - 1) + '"]');
                if (!$noItemDom.find('.pe-answer-right-num').hasClass('done')) {
                    _this.calculateTop();
                }
                $('.pe-making-template-wrap[data-no="' + (no - 1) + '"] .pe-wrong-answer').css("display", "block");
                    exerciseModel.showExplainImgs($('.pe-making-template-wrap[data-no="' + (no - 1) + '"]').find('.itemImageViewWrap'));

                if (exerciseSetting.questionAnswer == 'NOSHOW'||no==2) {
                    $(".pe-making-template-wrap[data-no=" + (no - 1) + "]").find(".pe-next-btn").show();
                }
            });
            $(".pe-leave-temporary").on("click", function () {
                var answer = exerciseModel.getUserAnswer($(this).parents('.pe-making-template-wrap'));
                if(answer!=undefined&&answer!=""){
                   exerciseModel.submitAnswer($(this).parents('.pe-making-template-wrap'));
                }

                exerciseModel.tips({
                    content: "练习暂存成功!",
                    end: function () {
                        window.opener.location.href = CFG.ctx + '/front/initPage';
                        window.close();
                    }
                });
            });
            $(".pe-wrong-answer-item").on("click",function(){
                var selectDom = $(this).children(".pe-answer-right-num");
                if(selectDom.hasClass("done")){
                    var no = selectDom.html();
                    $(".pe-making-template-wrap:not(.hideSingle)").addClass("hideSingle");
                    $(".pe-making-template-wrap[data-no='" + no + "']").removeClass("hideSingle");
                }else{
                    exerciseModel.tips({
                        content: '无法查看!',
                        time: 1000
                    });
                }
            });

            $(".pe-next-btn").click(function () {
                _this.clearTopTime();
                var $audioPlayingDom = $('.image-audio.audio-playing');
                var $audioPauseDom = $('.image-audio.audio-pause');
                $audioPlayingDom.each(function(i,audioBtn){
                    PEMO.AUDIOOBJ.obj.player_.pause();
                    $(audioBtn).removeClass("audio-playing");
                });
                var $currentTemplateWrap = $(this).parents(".pe-making-template-wrap"), no = $currentTemplateWrap.data('no');
                $currentTemplateWrap.addClass('hideSingle');
                $currentTemplateWrap.next().removeClass('hideSingle');
                if($currentTemplateWrap.next().find('.itemImageViewWrap li').get(0)){
                    exerciseModel.swiperInitItem($('body'),parseInt($currentTemplateWrap.next().attr('data-no')));
                }
                var $noItemDom = $('.pe-wrong-answer-item[name="no_' + (no + 1) + '"]');
                if (!$noItemDom.find('.pe-answer-right-num').hasClass('done')) {
                    _this.calculateTop();
                }

                if (exerciseSetting.questionAnswer == 'NOSHOW') {
                    var $imgContainer = $(this).parent(".marking-btn-wrap").parent(".pe-making-template-wrap").find(".itemImageViewWrap li");
                    _this.showExplainImgs($imgContainer);
                    _this.submitAnswer($(this).parents('.pe-making-template-wrap'));
                }
            });
            /*标记关注start*/
            $(".pe-star.pe-mark-star").on("click", function () {
                var index = $(this).data("so");
                var $thisStar = $(this);
                if ($thisStar.hasClass("icon-un-mark-star")) {
                    $thisStar.removeClass("icon-un-mark-star").addClass('icon-has-mark-star pe-checked-star');
                    $(".pe-wrong-answer-item[name='no_" + index + "'] .pe-wrong-start").css("display", "block");
                } else {
                    $thisStar.removeClass('icon-has-mark-star pe-checked-star').addClass('icon-un-mark-star');
                    $(".pe-wrong-answer-item[name='no_" + index + "'] .pe-wrong-start").css("display", "none");
                }
            });

            $(".pe-complete-btn").on('click', function () {
                var _thisParentMarking = $(this).parents(".pe-making-template-wrap"),_thisNextMarking = _thisParentMarking.next('.pe-making-template-wrap').eq(0);
                _this.clearTopTime();
                _this.submitAnswer($(this).parents('.pe-making-template-wrap'));
                var $audioPlayingDom = $('.image-audio.audio-playing');
                var $audioPauseDom = $('.image-audio.audio-pause');
                $audioPlayingDom.each(function(i,audioBtn){
                    PEMO.AUDIOOBJ.obj.player_.pause();
                    $(audioBtn).removeClass("audio-playing");
                });
                $(this).attr("disabled", true);
                $(this).css("display", "none");
                var $imgContainer = _thisParentMarking.find(".itemImageViewWrap li");
                _this.showExplainImgs($imgContainer);
            });
            $('.pe-answer-sure-btn,.pe-last-submit-btn').click(function () {
                if (exerciseSetting.questionAnswer == "NOSHOW") {
                    _this.clearTopTime();
                //    _this.submitAnswer($(this).parents('.pe-making-template-wrap'));
                }

                var totalSize = $(".pe-answer-test-num .pe-answer-right-num").length;
                var doneSize = $(".pe-answer-test-num .pe-answer-right-num.done").length;
                var leftSize = totalSize - doneSize;
                var checkNum = doneSize+1;
                var answer = exerciseModel.getUserAnswer($(".pe-making-template-wrap[data-no='"+checkNum+"']"));
                if(answer!=undefined&&answer!=""){
                    leftSize=leftSize-1;
                }

                if (leftSize < 1) {
                    exerciseModel.submitExercise();
                    return;
                }

                exerciseModel.confirmR({
                    content: '<span>还有' + leftSize + '题未作答，是否继续提交结果？</span><div>你可以下次进来完成未做的试题</div>',
                    btnAlign: 'r',
                    btn: ['继续答题', '确认提交'],
                    btn1: function () {
                        window.opener.location.href = CFG.ctx + '/front/initPage';
                        layer.closeAll();
                    },
                    btn2: function () {
                        exerciseModel.submitExercise();
                    }
                });

            });
            var $thisRightWrap = $('.pe-answer-content-right-wrap');
            $(window).resize(function () {
                var windowScrollTop = $(window).scrollTop();
                var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
                var leftPanelOffsetLeft = $('.pe-answer-content-left-wrap').offset().left;
                if (!$('.marking-container-wrap').get(0)) {
                    BaseExam.renderHeight(windowScrollTop);
                }else{
                    exerciseModel.renderHeight();
                }
            });
            $('.pe-making-template-wrap').delegate('.image-video', 'click', function () {
                var thisVideoSrc = $(this).attr('data-src');
                PEMO.VIDEOPLAYER(thisVideoSrc);
            });
            $('.pe-making-template-wrap').delegate('.image-audio','click',function(e){
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
        init: function () {
            var _this = this;
           // _this.initData();
            _this.bind();
            setTimeout(function(){
                $('.loading-before-mask').hide();
                _this.initData();
            },4000);
        },
        initData: function () {
            var _this = this;
            _this.renderLeftPanel();
            _this.renderHeight(0);
            _this.calculateTop();
            _this.scrollBar();
            _this.showAnswer();
            $('.insert-blank-item').each(function (i, e) {
                $(e).removeAttr('readonly');
            });
            $('.pe-making-template-wrap').each(function(i,wrapDom){
                var imgHtml = '';
                $(wrapDom).find('img.upload-img').each(function (k, e) {
                    imgHtml = imgHtml + '<li class="pe-view-question-detail-img-wrap swiper-slide over-flow-hide" data-index="'+k+'"style="display:inline-block;"><img class="pe-question-detail-img-item" data-original="'+$(e).data('src')+'" src="'+$(e).data('src')+'" width="auto" height="100%"/></li>';
                    $(e).attr('data-index', k);
                });

                var imagesWrap = $(wrapDom).find('.all-images-wrap');
                if(imgHtml != ''){
                    $(wrapDom).find('.itemImageViewWrap').append(imgHtml);
                    imagesWrap.show();
                    renderImagesWrap(imagesWrap,i);
                }
            });
            var imagesWrap = $('.all-images-wrap');
            function renderImagesWrap(imagesWrap,i){
                $(imagesWrap).addClass('all-images-wrap' + (i + 1)).attr('data-index', i + 1);
                if (!$(imagesWrap).find('.swiper-wrapper img').get(0)) {
                    $(imagesWrap).hide();
                } else {
                    $(imagesWrap).find('.swiper-wrapper').css('transform', 'translate3d(0px, 0px, 0px)');
                    $(imagesWrap).find('.swiper-wrapper').css('-webkit-transform', 'translate3d(0px, 0px, 0px)');
                    //图片轮播的样式和功能
                    exerciseModel.swiperInitItem($('body'), i + 1);
                    if($(imagesWrap).parents('.pe-making-template-wrap').find('.pe-wrong-answer:visible').get(0)){
                        var $imgContainer = $(imagesWrap).find(".itemImageViewWrap li");
                        exerciseModel.showExplainImgs($imgContainer);
                    }else{
                        exerciseModel.hideExplainImg($(imagesWrap));
                    }
                }
            }
        },
        submitExercise: function () {
            var exerciseData = exerciseModel.packageUserAnswers();
            exerciseModel.ajaxRequest({
                url: CFG.ctx + '/ems/exercise/client/submitExercise',
                data: {
                    'exerciseSettingId': exerciseModel.exerciseSettingId,
                    exerciseData: exerciseData
                },
                success: function (data) {
                    if(data.success){
                        exerciseModel.tips({
                            content: '提交成功',
                            time: 3000,
                            end: function () {
                                window.opener.location.href = CFG.ctx + '/front/initPage';
                                window.close();
                            }
                        });
                    }

                }
            });
        }
    };

    exerciseModel.init();
});