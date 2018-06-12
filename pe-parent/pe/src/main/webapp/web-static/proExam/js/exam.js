$(function () {
    var Exam = {
        renderAnswer: function (answer) {
            var answerInfoPanel = $('#peAnswerInfoPanel');
            var numElems = answerInfoPanel.find('.pe-answer-right-num');
            var totalAnswer = 0;
            for (var item in answer) {
                var itemElem = $('.paper-add-question-content:eq(' + (item - 1) + ')');
                var itemType = itemElem.attr('data-type');
                if (itemType === 'INDEFINITE_SELECTION' || itemType === 'MULTI_SELECTION') {//不定向选择
                    var answerArr = answer[item].a.split(',');
                    for (var i = 0; i < answerArr.length; i++) {
                        itemElem.find('input:eq(' + answerArr[i] + ')').get(0).checked = 'checked';
                    }
                } else if (itemType === 'SINGLE_SELECTION') {//单选
                    itemElem.find('input:eq(' + answer[item].a + ')').get(0).checked = 'checked';
                } else if (itemType === 'JUDGMENT') {//判断
                    if (answer[item].a == 0) {
                        itemElem.find('input:eq(1)').get(0).checked = 'checked';
                    } else {
                        itemElem.find('input:eq(0)').get(0).checked = 'checked';
                    }
                } else if (itemType === 'QUESTIONS') {
                    itemElem.find('textarea').val(answer[item].a);
                } else if (itemType === 'FILL' && answer[item].a) {
                    answerArr = answer[item].a.split('|');
                    for (var i = 0; i < answerArr.length; i++) {
                        itemElem.find('.insert-blank-item:eq(' + i + ')').val(answerArr[i]);
                    }
                }

                if (answer[item].a) {
                    totalAnswer++;
                    numElems.eq(item - 1).addClass('done');
                }

                if (answer[item].m) {
                    itemElem.find('.icon-start-difficulty').toggleClass("pe-checked-star");
                    $("a.no_" + item + " span").toggle();
                }
            }

            var completeInfo = ((totalAnswer / numElems.size()) * 100).toFixed(0) + "%";
            $('.exam-answer-top-header').find('.pe-answer-progress').get(0).style.width = completeInfo;
            $('.exam-answer-top-header').find('.complete-info').html(completeInfo);
            var hasAnswerNum = $('.pe-answer-test-num').find('.pe-answer-right-num.done').size();
            $('.has-answer-num').html(hasAnswerNum);
        },

        setUserAnswer: function (name, value) {
            try {
                var userAnswer = BaseExam.storeAnswer.get(BaseExam.examId);
            } catch (e) {
            }

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

            $('.insert-blank-item').on('blur', function () {
                var name = $(this).parents('.paper-question-stem').data('index'), data = [], done = false;
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
            $('.pe-answer-sure-btn').on('click', function () {
                if (BaseExam.ps.bs && BaseExam.ps.bsD > 0) {
                    var useTime = CFG.answeredTime;
                    if (!useTime || BaseExam.ps.bsD*60 > parseInt(useTime)) {
                        examDialog.alert({
                            content: '本场考试答题时间少于' + BaseExam.ps.bsD + '分钟，禁止交卷'
                        });
                        return false;
                    }
                }
                var totalAnswer = answerInfoPanel.find('.pe-answer-right-num').size();
                var doneLength = $('.pe-answer-right-num.done').length;
                var noDoneCount = totalAnswer - doneLength;
                if (noDoneCount > 0) {
                    var content = "还有" + noDoneCount + "题未作答，交卷后无法作答。";
                    examDialog.comfire({
                        btn: ['继续答题', '确定交卷'],
                        content: content,
                        btnBlueR: false,
                        okBtn: function () {
                            examDialog.close();
                            examDialog.comfire({
                                content: '再次确认，交卷后无法再答题，您确定要交卷吗？',
                                okBtn: function () {
                                    examDialog.close();
                                    BaseExam.submitExam(function () {
                                        BaseExam.initSuccessPage();
                                    });
                                }
                            });
                        }
                    });

                    return false;
                }
                examDialog.comfire({
                    content: '交卷后无法再答题，您确定要交卷吗？',
                    okBtn: function () {
                        examDialog.close();
                        BaseExam.submitExam(function () {
                            BaseExam.initSuccessPage();
                        });
                        //self.opener.location.reload();
                    }
                });
            });

            $(".change-answer-checkbox").on('click', function () {
                var $this = $(this);
                if ($this.hasClass('icon-unchecked-checkbox')) {
                    $this.removeClass('icon-unchecked-checkbox');
                    $this.addClass('icon-checked-checkbox');
                    $('.pe-answer-right-num.done').hide();
                    $('.pe-answer-right-num.done').each(function (index, ele) {
                        var number = $(ele).text();
                        var $questionContent = $(".paper-add-question-content:eq(" + (parseInt(number) - 1) + ")");
                        $questionContent.hide();
                        var isVal = false;
                        $questionContent.parents('.pe-paper-preview-content').find('.paper-add-question-content').each(function (index, ele) {
                            if ($(ele).is(':visible')) {
                                isVal = true;
                            }
                        });

                        if (!isVal) {
                            $questionContent.parents('.pe-paper-preview-content').hide();
                        }
                    });

                    if (!$('.pe-answer-content-left').find('.pe-paper-preview-content:visible').get(0)) {
                        $('.all-item-has-answer').show();
                        $('.all-item-has-answer-a').show();
                    }
                    return false;
                }
                $('.all-item-has-answer').hide();
                $('.all-item-has-answer-a').hide();
                $this.removeClass('icon-checked-checkbox');
                $this.addClass('icon-unchecked-checkbox');
                $('.pe-answer-right-num').show();
                $('.paper-add-question-content').show();
                $('.pe-paper-preview-content').show();
            });


            var thisShouldBeHeight = $(window).height() - 64 - 20 - 15 + 2;//64头部高度，20是answer-exam-nav-top的高度,60是footer的高度,70是form表单的margin-bottom的值
            if (thisShouldBeHeight > $('.pe-answer-content-left-wrap').height()) {
                $('.pe-answer-content-left-wrap').css('minHeight', thisShouldBeHeight);
                $('.pe-answer-test-num').height($('.pe-answer-test-num').height());
            }


        },

        //初始化数据
        initData: function () {
            BaseExam.ajaxUserAnswer(Exam.renderAnswer);
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
            BaseExam.initData();
            var hasAnswerNum = $('.pe-answer-test-num').find('.pe-answer-right-num.done').size();
            $('.has-answer-num').html(hasAnswerNum);
        },

        init: function () {
            Exam.initData();
            Exam.bind();
        }
    };

    Exam.init();
});
$(function () {
    if (!placeholderSupport()) {   // 判断浏览器是否支持 placeholder
        $('[placeholder]').focus(function () {
            var input = $(this);
            if (input.val() == input.attr('placeholder')) {
                input.val('');
                input.removeClass('placeholder');
            }
        }).blur(function () {
            var input = $(this);
            if (input.val() == '' || input.val() == input.attr('placeholder')) {
                input.addClass('placeholder');
                input.val(input.attr('placeholder'));
            }
        }).blur();
    }
    //兼容IE8的空console对象
    window.console = window.console || {
            log: $.noop,
            debug: $.noop,
            info: $.noop,
            warn: $.noop,
            exception: $.noop,
            assert: $.noop,
            dir: $.noop,
            dirxml: $.noop,
            trace: $.noop,
            group: $.noop,
            groupCollapsed: $.noop,
            groupEnd: $.noop,
            profile: $.noop,
            profileEnd: $.noop,
            count: $.noop,
            clear: $.noop,
            time: $.noop,
            timeEnd: $.noop,
            timeStamp: $.noop,
            table: $.noop,
            error: $.noop
        };
});
function placeholderSupport() {
    return 'placeholder' in document.createElement('input');
}

