$(function () {
    var Exam = {
        maxNo: 0,
        renderHeight:function(){
            var windowHeight =$(window).height();
            //64头部高度，106是考试标题的panel的outerHeight，40是中间的panel的上下padding，40是中间panel的margin-bottom，60是footer的高度;
            var thisShouldHeight = windowHeight - 64 - 20 -5;
            var rightTopHeight = $('.marking-container-wrap .pe-answer-right-top').outerHeight();
            var rightContentTopHeight = $('.marking-container-wrap .pe-answer-right-content-top').outerHeight();
            var rightBtnHeight = $('.marking-container-wrap .pe-answer-sure').outerHeight();
            var stuLeftDownH = $('.stu-content-left').outerHeight();
            var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
            var leftPanelOffsetLeft = $('.pe-answer-content-left-wrap').offset().left;
            var rightItemListHeight = thisShouldHeight - rightTopHeight- rightContentTopHeight - rightBtnHeight;
            $('.marking-container-wrap .pe-making-template-wrap').css('minHeight',(thisShouldHeight - 40-5) + 'px');//减去40,是因为去除template外面的包围框的上下padding
            $('.marking-container-wrap .pe-answer-test-num').css('height',(rightItemListHeight -40-58)+ 'px');
                $('.pe-answer-content-right-wrap').css('left', (parseInt(leftPanel) + parseInt($('.pe-answer-content-left-wrap').offset().left) + 20) + 'px');
            var rightWrapLeft = Math.abs(parseInt($('.pe-answer-content-right-wrap').css('left'),10));
            if($('.un-ready-camera').get(0)){
                $('.un-ready-camera').css({'width':$(window).width(),'height':$(window).height(),'marginLeft':-(rightWrapLeft + 32),'marginTop':'-190px'});
            }
            $('.pe-answer-content-right-wrap').css('top',$('.stu-content-left').offset().top);

        },
        renderAnswer: function (answer) {
            var answerInfoPanel = $('#peAnswerInfoPanel'), numElems = answerInfoPanel.find('.pe-answer-right-num'), totalAnswer = 0, lastItem;
            for (var item in answer) {
                var itemElem = $('.paper-add-question-content:eq(' + (item - 1) + ')');
                var itemType = itemElem.attr('data-type');
                if ((itemType === 'INDEFINITE_SELECTION' || itemType === 'MULTI_SELECTION') && answer[item].a) {//不定向选择
                    var answerArr = answer[item].a.split(',');
                    for (var i = 0; i < answerArr.length; i++) {
                        itemElem.find('input:eq(' + answerArr[i] + ')').get(0).checked = 'checked';
                    }
                } else if (itemType === 'SINGLE_SELECTION' && answer[item].a) {//单选
                    itemElem.find('input:eq(' + answer[item].a + ')').get(0).checked = 'checked';
                } else if (itemType === 'JUDGMENT' && answer[item].a) {//判断
                    if (answer[item].a == 0) {
                        itemElem.find('input:eq(1)').get(0).checked = 'checked';
                    } else {
                        itemElem.find('input:eq(0)').get(0).checked = 'checked';
                    }
                } else if (itemType === 'QUESTIONS' && answer[item].a) {
                    itemElem.find('textarea').val(answer[item].a);
                } else if (itemType === 'FILL' && answer[item].a) {
                    answerArr = answer[item].a.split('|');
                    for (var i = 0; i < answerArr.length; i++) {
                        itemElem.find('.insert-blank-item:eq(' + i + ')').val(answerArr[i]);
                    }
                }

                if (!BaseExam.es.ce) {
                    itemElem.find(".pe-exam-radio").removeAttr('for');
                    itemElem.find('textarea').prop('readonly', 'readonly');
                }

                if (answer[item].a) {
                    totalAnswer++;
                    numElems.eq(item - 1).addClass('done');
                }

                if (answer[item].m) {
                    itemElem.find('.icon-start-difficulty').toggleClass("pe-checked-star");
                    $("a.no_" + item + " span").toggle();
                }

                lastItem = item;
            }

            if (parseInt(lastItem) === $('.pe-answer-right-num').length) {
                lastItem = parseInt(lastItem) - 1;
            }

            var completeInfo = ((totalAnswer / numElems.size()) * 100).toFixed(0) + "%";
            $('.exam-answer-top-header').find('.pe-answer-progress').get(0).style.width = completeInfo;
            $('.exam-answer-top-header').find('.complete-info').html(completeInfo);
            var hasAnswerNum = $('.pe-answer-test-num').find('.pe-answer-right-num.done').size();
            $('.has-answer-num').html(hasAnswerNum);
            // $('.pe-making-template-wrap').hide();
            $('.pe-making-template-wrap').addClass('hide');
            $('.pe-making-template-wrap:eq(' + lastItem + ')').removeClass('hide');
            Exam.maxNo = parseInt(lastItem) + 1;
            Exam.renderHeight();
        },

        setUserAnswer: function (name, value) {
            var userAnswer = BaseExam.storeAnswer.get(BaseExam.examId);
            if (!userAnswer) {
                userAnswer = {};
            }

            if (!userAnswer[name]) {
                userAnswer[name] = {}
            }

            userAnswer[name].a = value;
            //放入修改段内
            BaseExam.answerQueNos[BaseExam.timeSegment].push(name);
            BaseExam.storeAnswer.set(BaseExam.examId, userAnswer);
            var numElems = $('#peAnswerInfoPanel').find('.pe-answer-right-num');
            if (value) {
                numElems.eq(name - 1).addClass('done');
            } else {
                numElems.eq(name - 1).removeClass('done');
            }

            BaseExam.scrollBar(BaseExam.totalAnswer, $('.pe-answer-right-num.done').length);
        },

        getUserAnswer: function ($mtWrap) {
            var itemType = $mtWrap.data('type'), name = $mtWrap.data('id');
            if (itemType === 'SINGLE_SELECTION' || itemType === 'JUDGMENT') {
                //单选题 判断题
                return $mtWrap.find('.pe-exam-radio-wrap input:checked').val();
            }

            if (itemType === 'FILL') {
                var data = [], done = false;
                $mtWrap.find('.insert-blank-item').each(function () {
                    data.push($(this).val());
                    if ($(this).val()) {
                        done = true;
                    }
                });

                var value = '';
                if (done) {
                    value = data.join("|");
                }

                return value;
            }

            if (itemType === 'MULTI_SELECTION' || itemType === 'INDEFINITE_SELECTION') {
                var arrValue = [];
                var elemArr = $('#examForm').find('input[name="_' + name + '"]');
                for (var i = 0; i < elemArr.length; i++) {
                    if ($(elemArr[i]).is(':checked')) {
                        arrValue.push(elemArr[i].value);
                    }
                }

                return arrValue.join(',');
            }

            return $mtWrap.find('.pe-answer-content-text textarea').val();
        },

        bind: function () {
            var answerInfoPanel = $('#peAnswerInfoPanel');
            var numElems = answerInfoPanel.find('.pe-answer-right-num');
            //单选题 判断题
            $('.pe-exam-radio-wrap input').on('change', function () {
                var $radio = $(this);
                var name = $radio.attr('name').substring(1);
                numElems.eq(name - 1).addClass('done');
                Exam.setUserAnswer(name, $radio.val());
                BaseExam.scrollBar(BaseExam.totalAnswer, $('.pe-answer-right-num.done').length);
            });

            //问答题
            $('.pe-answer-content-text textarea').on('blur', function () {
                var name = $(this).attr('name').substring(1);
                if ($(this).val().trim().length > 0) {
                    numElems.eq(name - 1).addClass('done');
                } else {
                    numElems.eq(name - 1).removeClass('done');
                }

                Exam.setUserAnswer(name, $(this).val());
                BaseExam.scrollBar(BaseExam.totalAnswer, $('.pe-answer-right-num.done').length);
            });

            // $('.marking-container-wrap').delegate('.insert-blank-item','blur',function(){
            $('.insert-blank-item').on('blur',function(){
                var name = $(this).parents('.pe-making-template-wrap').data('id'), data = [], done = false;
                $(this).parents('.paper-question-stem').find('.insert-blank-item').each(function () {
                    data.push($(this).val());
                    if ($(this).val()) {
                        done = true;
                    }
                });
                var value = '';
                if (done) {
                    value = data.join("|");
                    numElems.eq(name - 1).addClass('done');
                } else {
                    numElems.eq(name - 1).removeClass('done');
                }

                $('input[name=_' + name + ']').val(value);
                Exam.setUserAnswer(name, value);
                BaseExam.scrollBar(BaseExam.totalAnswer, $('.pe-answer-right-num.done').length);
            });

            //多选题 不定项选择题
            $('.pe-exam-checkbox-wrap input').on('change', function () {
                var $checkbox = $(this);
                var name = $checkbox.attr('name').substring(1);
                var arrValue = [];
                var elemArr = $('#examForm').find('input[name="_' + name + '"]');
                for (var i = 0; i < elemArr.length; i++) {
                    if ($(elemArr[i]).is(':checked')) {
                        arrValue.push(elemArr[i].value);
                    }
                }
                if (arrValue.length > 0) {
                    numElems.eq(name - 1).addClass('done');
                } else {
                    numElems.eq(name - 1).removeClass('done');
                }

                Exam.setUserAnswer(name, arrValue.join(','));
                BaseExam.scrollBar(BaseExam.totalAnswer, $('.pe-answer-right-num.done').length);
            });
            //提交试卷
            $('.marking-container-wrap').delegate('.pe-answer-sure-btn,.pe-last-submit-btn','click',function(){
            // $('.pe-answer-sure-btn').on('click',function () {
                if (BaseExam.ps.bs && BaseExam.ps.bsD > 0) {
                    var useTime = CFG.answeredTime;
                    if (BaseExam.ps.bsD*60 > parseInt(useTime)) {
                        examDialog.alert({
                            content: '本场考试答题时间少于' + BaseExam.ps.bsD + '分钟，禁止交卷'
                        });
                        return false;
                    }
                }
                //保存最后一题
                var $mtWrap = $('.pe-making-template-wrap:visible'), lastAnswer = Exam.getUserAnswer($mtWrap);
                Exam.setUserAnswer($mtWrap.data("id"), lastAnswer);
                var itemCount = $('.pe-answer-right-num').length, userAnswer = BaseExam.storeAnswer.get(BaseExam.examId), doneCount = 0;
                if (!BaseExam.es.ce) {
                    $.each(userAnswer, function (key, value) {
                        doneCount++;
                    });

                    var noDoneCount = itemCount - doneCount;
                } else {
                    noDoneCount = itemCount - $('.pe-answer-right-num.done').length;
                }

                if (noDoneCount > 0) {
                    var content = "还有" + noDoneCount + "题未作答，交卷后无法作答。";
                    examDialog.comfire({
                        btn: ['继续答题', '确定交卷'],
                        content: content,
                        btnBlueR: false,
                        okBtn: function (index) {
                            examDialog.close();
                            examDialog.comfire({
                                content: '再次确认，交卷后无法再答题，您确定要交卷吗？',
                                okBtn: function () {
                                    examDialog.close();
                                    BaseExam.submitExam(function(){
                                        BaseExam.initSuccessPage();
                                    });
                                }
                            });
                        }
                    });

                    return false;
                }

                content = "交卷后无法答题，您确定交卷吗？";
                examDialog.comfire({
                    content: content,
                    okBtn: function () {
                        examDialog.close();
                        examDialog.comfire({
                            content: '再次确认，交卷后无法再答题，您确定要交卷吗？',
                            okBtn: function () {
                                examDialog.close();
                                BaseExam.submitExam(function(){
                                    BaseExam.initSuccessPage();
                                });
                            }
                        });
                    }
                });
            });

            $(".pe-next-btn").click(function () {
                if($('#peAudioPlayer').get(0)){
                    var $thisAudioIcon = $(this).parents('.pe-making-template-wrap').find('.audio-playing:visible,.audio-pause');
                    var playAudioIconSrc = $thisAudioIcon.attr('src');
                    var newSrc ='';
                    if(playAudioIconSrc){
                        newSrc =playAudioIconSrc.replace(/audio_pause.png|audio_playing.gif/ig,'default-music.png');
                        $thisAudioIcon.attr('src',newSrc).removeClass('audio-playing').removeClass('audio-pause');
                    }
                    $('#peAudioPlayer').remove();
                }
                var name = $($(this).parents(".pe-making-template-wrap")[0]).data("id"), answered = BaseExam.storeAnswer.get(BaseExam.examId),
                    $nextWrap = $(".pe-making-template-wrap:eq(" + name + ")");
                var $nowWrap = $(".pe-making-template-wrap:eq(" + (parseInt(name)-1) + ")");
                if (Exam.maxNo < parseInt(name)) {
                    Exam.maxNo = parseInt(name);
                }

                if (!BaseExam.es.ce && answered && answered[name] && ('a' in answered[name])) {
                    //当 下一题是已经回答过且是设置不可返回修改答案时的时候
                    if(answered[name + 1] && !$nextWrap.find('.pe-exam-radio').attr('for')){
                        $nextWrap.find('input[type="radio"],input[type="checkbox"]').attr('disabled','true');
                    }
                    $(".pe-making-template-wrap").addClass('hide');
                    $nextWrap.removeClass('hide');
                    //检查 前一题是否已经是回答过的，且是否是已经添加了disabled属性的，如果有责去除
                    if($nowWrap.find('input[type="radio"]:disabled,input[type="checkbox" ]:disabled').get(0)){
                        $nowWrap.find('input[type="radio"]:disabled,input[type="checkbox"]:disabled').removeAttr('disabled');
                    }

                    $nowWrap.find(".pe-exam-radio").removeAttr('for');
                    $nowWrap.find("textarea").prop('readonly', 'readonly');
                    $nowWrap.find(".insert-blank-item").prop('readonly', 'readonly');
                    BaseExam.answerListScroll(name +1);
                    Exam.renderHeight();
                    return false;
                }

                var userAnswer = Exam.getUserAnswer($(this).parents('.pe-making-template-wrap'));
                if (!BaseExam.es.ce && !userAnswer) {
                    examDialog.comfire({
                        content: '<p>您确定跳到下一题吗？</p></p>本场考试不允许回退修改答案，您本题未作答。</p>',
                        btn: ['留在本题', '答下一题'],
                        okBtn: function () {
                            examDialog.close();
                            if($nowWrap.find('input[type="radio"]:disabled,input[type="checkbox" ]:disabled').get(0)){
                                $nowWrap.find('input[type="radio"]:disabled,input[type="checkbox"]:disabled').removeAttr('disabled');
                            }

                            $nowWrap.find(".pe-exam-radio").removeAttr('for');
                            $nowWrap.find("textarea").prop('readonly', 'readonly');
                            $nowWrap.find(".insert-blank-item").prop('readonly', 'readonly');
                            // $(".pe-making-template-wrap").hide();
                            $(".pe-making-template-wrap").addClass('hide');
                            Exam.setUserAnswer(name, '');
                            // $mtWrap.show();
                            $nextWrap.removeClass('hide');
                            Exam.renderHeight();
                        }
                    });
                    BaseExam.answerListScroll(name +1);
                    return false;
                }

                // Exam.setUserAnswer(name, userAnswer);
                $(".pe-making-template-wrap").addClass('hide');
                $nextWrap.removeClass('hide');

                BaseExam.answerListScroll(name +1);
                Exam.renderHeight();
            });

            $(".pe-prev-btn").click(function () {
                if($('#peAudioPlayer').get(0)){
                    var $thisAudioIcon = $(this).parents('.pe-making-template-wrap').find('.audio-playing:visible,.audio-pause');
                    var playAudioIconSrc = $thisAudioIcon.attr('src');
                    var newSrc ='';
                    if(playAudioIconSrc){
                        newSrc =playAudioIconSrc.replace(/audio_pause.png|audio_playing.gif/ig,'default-music.png');
                        $thisAudioIcon.attr('src',newSrc).removeClass('audio-playing').removeClass('audio-pause');
                    }
                    $('#peAudioPlayer').remove();
                }
                var $thisWrap = $($(this).parents(".pe-making-template-wrap")[0]);
                var index = $thisWrap.attr("data-id");
                //去上一题之前，检测目前所在题目的input是否有disabled属性，有则去除
                if($thisWrap.find('input[type="radio"]:disabled,input[type="checkbox"]:disabled').get(0)){
                    $thisWrap.find('input[type="radio"]:disabled,input[type="checkbox"]:disabled').removeAttr('disabled');
                }

                $(".pe-making-template-wrap").addClass('hide');
                var $prevItem = $(".pe-making-template-wrap:eq(" + (parseInt(index) - 2) + ")"),answered = BaseExam.storeAnswer.get(BaseExam.examId);

                //当不可修改答案时，给之前一题的input添加disabled属性;
                if(!BaseExam.es.ce && answered && answered[parseInt(index) - 1]){
                    $prevItem.find('input[type="radio"],input[type="checkbox"]').attr('disabled','true');
                }

                $prevItem.removeClass('hide');
                BaseExam.answerListScroll(index - 1);
                Exam.renderHeight();
            });

            $('.marking-right-num').on('click', function () {
                if (BaseExam.es.ce) {
                    return false;
                }

                var number = $(this).text();
                if ($(this).hasClass('done')) {
                    // $(".pe-making-template-wrap").hide();
                    $(".pe-making-template-wrap").addClass('hide');
                    // $(".pe-making-template-wrap:eq(" + (parseInt(number) - 1) + ")").show();
                    $(".pe-making-template-wrap:eq(" + (parseInt(number) - 1) + ")").removeClass('hide');
                    return false;
                }
            });

            // $(".change-answer-checkbox").on('click', function () {
            //     var $this = $(this);
            //     if ($this.hasClass('icon-unchecked-checkbox')) {
            //         $this.removeClass('icon-unchecked-checkbox');
            //         $this.addClass('icon-checked-checkbox');
            //         $('.pe-answer-right-num.done').hide();
            //         $('.pe-answer-right-num.done').each(function (index, ele) {
            //             var number = $(ele).text();
            //             var $questionContent = $(".paper-add-question-content:eq(" + (parseInt(number) - 1) + ")");
            //             $questionContent.hide();
            //             var isVal = false;
            //             $questionContent.parents('.pe-paper-preview-content').find('.paper-add-question-content').each(function (index, ele) {
            //                 if ($(ele).is(':visible')) {
            //                     isVal = true;
            //                 }
            //             });
            //
            //             if (!isVal) {
            //                 $questionContent.parents('.pe-paper-preview-content').hide();
            //             }
            //
            //         });
            //
            //         return false;
            //     }
            //
            //     $this.removeClass('icon-checked-checkbox');
            //     $this.addClass('icon-unchecked-checkbox');
            //     $('.pe-answer-right-num').show();
            //     $('.paper-add-question-content').show();
            //     $('.pe-paper-preview-content').show();
            //     if(!$('.pe-answer-content-left').find('.pe-paper-preview-content:visible').get(0)){
            //         $('.all-item-has-answer').show();
            //         $('.all-item-has-answer-a').show();
            //     }
            // });

            $('.pe-answer-right-num').on('click', function () {
                var name = parseInt($(this).text());
                if (parseInt(Exam.maxNo) < name) {
                    return false;
                }

                if($('#peAudioPlayer').get(0)){
                    var $thisAudioIcon = $(this).parents('.pe-making-template-wrap').find('.audio-playing:visible,.audio-pause');
                    var playAudioIconSrc = $thisAudioIcon.attr('src');
                    var newSrc ='';
                    if(playAudioIconSrc){
                        newSrc =playAudioIconSrc.replace(/audio_pause.png|audio_playing.gif/ig,'default-music.png');
                        $thisAudioIcon.attr('src',newSrc).removeClass('audio-playing').removeClass('audio-pause');
                    }
                    $('#peAudioPlayer').remove();
                }
                //在去任意第几题时，先检查当前题目是否有disabled属性,有则去除
                var $noHideWrap = $('.pe-making-template-wrap:not(".hide")');
                if($noHideWrap.find('input[type="radio"]:disabled,input[type="checkbox"]:disabled').get(0)){
                    $noHideWrap.find('input[type="radio"]:disabled,input[type="checkbox"]:disabled').removeAttr('disabled');
                }

                var $goNameWrap = $(".pe-making-template-wrap:eq(" + (name - 1) + ")");
                //去任意第几题之前，检查所点击题目的input是否有disabled属性，如果是不可修改答案的，则加上
                if(!BaseExam.es.ce){
                    if($goNameWrap.find('input[type="radio"],input[type="checkbox"]').get(0)){
                        $goNameWrap.find('input[type="radio"],input[type="checkbox"]').attr('disabled','true');
                    }
                }

                $(".pe-making-template-wrap").addClass('hide');
                // $(".pe-making-template-wrap:eq(" + (name - 1) + ")").show();
                $goNameWrap.removeClass('hide');

                Exam.renderHeight();
            });

            Exam.renderHeight();
        },
        //初始化数据
        initData: function () {
            BaseExam.ajaxUserAnswer(Exam.renderAnswer);
            $('.pe-making-template-wrap').each(function(i,wrapDom){
                var imgHtml = '';
                $(wrapDom).find('img.upload-img').each(function (i, e) {
                    imgHtml = imgHtml + '<li class="pe-view-question-detail-img-wrap swiper-slide over-flow-hide" data-index="'+i+'"style="display:inline-block;"><img class="pe-question-detail-img-item" data-original="'+$(e).data('src')+'" src="'+$(e).data('src')+'" width="auto" height="100%"/></li>'
                    $(e).attr('data-index', i);
                });

                var imagesWrap = $(wrapDom).find('.all-images-wrap');
                if(imgHtml != ''){
                    $(wrapDom).find('.itemImageViewWrap').append(imgHtml);
                    imagesWrap.show();
                }
            });

            BaseExam.initData();
            var hasAnswerNum = $('.pe-answer-test-num').find('.pe-answer-right-num.done').size();
            $('.has-answer-num').html(hasAnswerNum);
        },

        init: function () {
            Exam.initData();
            Exam.bind();
        }
    };

    $(window).resize(function(){
        Exam.renderHeight();
    });
    Exam.init();
});