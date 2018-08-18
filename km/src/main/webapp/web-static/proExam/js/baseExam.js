var examDialog = {
    close: function (t) {
        if (t == 'submit') {
            $('.pe-exam-sub-mask').hide();
            $('.sub-status-dialog').hide();
        } else {
            $('.pe-box-wrap').not('.sub-status-dialog').remove();
            $('.pe-exam-mask').remove();
        }

    },
    comfire: function (settings) {
        var defaults = {
            content: '',
            btn: ['取消', '确定'],
            btnBlueR: true,
            okBtn: function () {
                //examDialog.close();
            },
            cancelBtn: function () {
                //examDialog.close();
            },
            onLoad: function () {
            }
        };
        $.extend(defaults, settings);
        var dialogDom1 = '<div class="pe-exam-mask"></div><div class="pe-box-wrap ' + defaults.cls + ' ">'
            + '<i class="iconfont pe-box-close">&#xe643;</i>'
            + '<div class="pe-box-contain">'
            + defaults.content
            + '</div>';
        var dialogDom2 = '</div>';
        if (defaults.btnBlueR) {
            var btnDom = '<div class="btns-wrap"><button class="pe-btn pe-btn-purple pe-box-known exam-dailog-cancel-btn">' + defaults.btn[0] + '</button>'
                + '<button class="pe-btn pe-btn-blue pe-box-known exam-dailog-ok-btn">' + defaults.btn[1] + '</button></div>'
        } else {
            var btnDom = '<div class="btns-wrap"><button class="pe-btn  pe-btn-blue  pe-box-known exam-dailog-cancel-btn">' + defaults.btn[0] + '</button>'
                + '<button class="pe-btn pe-btn-purple pe-box-known exam-dailog-ok-btn">' + defaults.btn[1] + '</button></div>'
        }
        var allDialogDom = dialogDom1 + btnDom + dialogDom2;
        $('body').append(allDialogDom);
        $('.exam-dailog-ok-btn').click(function (e) {
            var e = window.event || e;
            if (e.stopPropagation) {
                e.stopPropagation();
            } else {
                e.cancelBubble = true;
            }

            // e.preventDefault();
            defaults.okBtn();
        });
        $('.exam-dailog-cancel-btn').click(function () {
            defaults.cancelBtn();
            examDialog.close();
        });
        $('.pe-box-close').click(function () {
            examDialog.close();
        });
        defaults.onLoad();
    },
    alert: function (settings) {
        examDialog.close("submit");
        if (($('.pe-box-wrap').get(0) && $('.pe-exam-mask').get(0))) {
            return false;
        }
        var defaults = {
            content: '',
            btn: ['我知道了'],
            cls: '',
            okBtn: function () {
                examDialog.close();
            },
            onLoad: function () {
            }
        };
        $.extend(defaults, settings);
        var dialogDom = '<div class="pe-exam-mask"></div><div class="pe-box-wrap">'
            + '<i class="iconfont pe-box-close">&#xe643;</i>'
            + '<div class="pe-box-contain">'
            + defaults.content
            + '</div>'
            + '<div class="btns-wrap"><button class="pe-btn pe-btn-blue pe-box-known exam-dailog-ok-btn">' + defaults.btn[0] + '</button></div>'
            + '</div>';

        if (!($('.pe-box-wrap').get(0) && $('.pe-exam-mask').get(0))) {
            $('body').append(dialogDom);
        }
        $('.exam-dailog-ok-btn').click(function () {
            defaults.okBtn();
        });
        $('.pe-box-close').click(function () {
            examDialog.close();
        });
        defaults.onLoad();
    },
    tips: function (settings) {
        if (($('.pe-box-wrap').get(0) && $('.pe-exam-mask').get(0))) {
            return false;
        }
        var defaults = {
            content: '',
            onLoad: function () {
            }
        };
        $.extend(defaults, settings);
        var dialogDom = '<div class="pe-exam-mask"></div><div class="pe-box-wrap  ' + defaults.cls + ' ">'
            + '<i class="iconfont pe-box-close">&#xe643;</i>'
            + '<div class="pe-box-contain">'
            + defaults.content
            + '</div>'
            + '</div>';
        if (!($('.pe-box-wrap').get(0) && $('.pe-exam-mask').get(0))) {
            $('body').append(dialogDom);
        }
        $('.pe-box-close').click(function () {
            examDialog.close();
        });
        defaults.onLoad();
    },
    subExamIng: function (settings) {
        var defaults = {
            content: '',
            cls: '',
            onLoad: function () {
            }
        };
        if (($('.pe-box-wrap').not('.sub-status-dialog').get(0) && $('.pe-exam-mask').get(0))) {
            examDialog.close();
        }

        $('.pe-exam-sub-mask').show();
        $('.sub-exam-ing.sub-status-dialog').show();
        defaults.onLoad();
    },
    subFail: function (settings) {
        if (($('.pe-box-wrap').not('.sub-status-dialog').get(0) && $('.pe-exam-mask').get(0))) {
            examDialog.close();
        }
        var defaults = {
            content: '',
            subAgainBtn: function () {
            },
            onLoad: function () {
            }
        };
        $.extend(defaults, settings);

        if (defaults.isOffline) {
            $('.sub-fail.sub-status-dialog').find('.sub-ing-text').html('啊哦，惨了！可能网断了！>_<');
        } else {
            $('.sub-fail.sub-status-dialog').find('.sub-ing-text').html('当前网速太慢，提交失败！')
        }


        $('.pe-exam-sub-mask').show();
        $('.sub-fail.sub-status-dialog').show();

        $('.sub-exam-dia-close').click(function () {
            /*当要关闭 考试 提交 这个特定的 弹框时，请加入参数  submit*/
            examDialog.close('submit');
        });
        $('.pe-box-wrap .sub-again-btn').click(function () {
            defaults.subAgainBtn();
        })
        defaults.onLoad();
    },
    countDownTime: function (settings) {
        examDialog.close('submit');
        if (($('.pe-box-wrap').get(0) && $('.pe-exam-mask').get(0))) {
            return false;
        }
        var defaults = {
            content: '',
            downTime: 60,
            width: 470,
            height: 61,
            cls: '',
            close: true,
            onCancel: function () {
            },
            onDownOver: function () {
                //alert('倒计时结束啦');
            },
            onLoad: function () {
            }
        };
        $.extend(defaults, settings);
        var dialogDom = '<div class="pe-exam-mask"></div><div class="pe-box-wrap downTime-box-contain">';
        if (defaults.close) {
            dialogDom += '<i class="iconfont icon-dialog-close-btn pe-box-close"></i>';
        } else {
            dialogDom += '<i class="iconfont pe-box-close"></i>';
        }

        dialogDom += '<div class="pe-box-contain floatL" style="width:' + defaults.width + 'px;height:' + defaults.height + 'px;"><div style="width:86%;margin-left:60px;line-height:25px;text-align: left;">'
            + defaults.content
            + '</div></div>'
            + '<div class="floatL downTime-panel-wrap" style="height:' + defaults.height + 'px;"><div class="downTime-panel">' + defaults.downTime + 's</div></div>'
            + '</div>';
        if (!($('.pe-box-wrap').get(0) && $('.pe-exam-mask').get(0))) {
            $('body').append(dialogDom);
            var allTime = defaults.downTime - 1;
            var downTimeInterval = setInterval(function () {
                if (allTime > 0) {
                    $('.downTime-panel-wrap').find('.downTime-panel').html(allTime-- + "s");
                } else {
                    $('.downTime-panel-wrap').find('.downTime-panel').html("0s");
                    defaults.onDownOver();
                    clearInterval(downTimeInterval);
                    if (defaults.close) {
                        examDialog.close();
                    }
                }
            }, 1000)

        }
        $('.icon-dialog-close-btn').click(function () {
            defaults.onCancel();
            clearInterval(downTimeInterval);
            examDialog.close();
        });
        defaults.onLoad();
    }
};

var userId = CFG.userId;
var BaseExam = {
    examId: CFG.examId,
    answerQueNos: {},
    timeSegment: '', //当前时间段
    transTime: 180 * 1000,//单位秒
    examInterval: '', //定时时间
    checkExamInterval: '',//定时检测考试信息合法
    webSocket: null, //websocket
    totalAnswer: 0,
    lessTime: 0,//单位S
    pos: 0,
    submitLock:false,
    image: [],
    flag: true,
    saveCB: function () {
    },
    canvasCtx: '',
    exam: {},
    es: {},
    ps: {},
    isWebCam: false,
    AUDIOOBJ: {
        oldSrc: '',
        obj: {}
    },
    swiperObj: {},
    swiperBindTimes: 0,
    storeAnswer: {
        suffix: 'qguExam_' + userId + "_",
        get: function (examId) {
            return JSON.parse(localStorage.getItem(this.suffix + examId));
        },
        set: function (examId, answer) {
            localStorage.setItem(this.suffix + examId, JSON.stringify(answer));
        },
        //保存更新时间
        setUt: function (examId, updateTime) {
            localStorage.setItem(this.suffix + 'ut_' + examId, updateTime);
        },
        getUt: function (examId) {
            return localStorage.getItem(this.suffix + 'ut_' + examId);
        },
        clear: function (examId) {
            if (examId) {
                localStorage.removeItem(this.suffix + examId);
                localStorage.removeItem(this.suffix + 'ut_' + examId);
            }
        }
    },
    //音视频
    AUDIOPLAYER: function (audioPath, isPlaying, isLoop) {
        if (!BaseExam.AUDIOOBJ.oldSrc || BaseExam.AUDIOOBJ.oldSrc !== audioPath) {
            BaseExam.AUDIOOBJ.oldSrc = audioPath;
        }
        /*音频，不在单独弄*/
        if (isPlaying) {
            // $('.music-audio-panel').find('video').get(0).stop();
            BaseExam.AUDIOOBJ.obj.player_.pause();
        } else {
            var audioObj = null;
            BaseExam.AUDIOOBJ.oldSrc = '';
            if (isLoop) {
                var audioDom = '<video id="peAudioPlayer" loop="true" data-type="audio"  class="video-js music-audio-panel vjs-default-skin pe-video-player-panel" controls preload="none" width="0" height="0" poster="">'
                    + '<source src="' + audioPath + '" type="audio/mp3" /></video>';
            } else {
                audioDom = '<video id="peAudioPlayer" data-type="audio"  class="video-js music-audio-panel vjs-default-skin pe-video-player-panel" controls preload="none" width="0" height="0" poster="">'
                    + '<source src="' + audioPath + '" type="audio/mp3" /></video>';
            }

            if (!$('#peAudioPlayer').get(0) || ($('#peAudioPlayer').get(0) && BaseExam.AUDIOOBJ.oldSrc !== audioPath)) {
                $('#peAudioPlayer').remove();
                $('body').append(audioDom);
                BaseExam.AUDIOOBJ.obj = videojs(document.getElementById('peAudioPlayer'), {autoplay: "autoplay"}, function (e) {

                });
            } else {
                BaseExam.AUDIOOBJ.obj.player_.play();
            }
        }

    },
    VIDEOPLAYER: function (videoPath, videoDom) {
        if (!$.isEmptyObject(BaseExam.AUDIOOBJ.obj)) {
            BaseExam.AUDIOOBJ.obj.player_.pause();
            var audioDoms = $('.image-audio');
            if (audioDoms.get(0)) {
                for (var i = 0, iLen = audioDoms.length; i < iLen; i++) {
                    if ($(audioDoms[i]).hasClass('audio-playing') || $(audioDoms[i]).hasClass('audio-pause')) {
                        var audioIconSrc = $(audioDoms[i]).attr('src').replace(/audio_pause.png|audio_playing.gif/ig, 'default-music.png');
                        $(audioDoms[i]).removeClass('audio-playing audio-pause');
                        $(audioDoms[i]).attr('src', audioIconSrc);
                    }
                }
            }
        }

        var videoDom = '<div class="video-mask-panel"></div>'
            + '<video id="peVideoPlayer" class="video-js vjs-default-skin pe-video-player-panel" controls preload="auto" width="640" height="480" poster="">'
            + '<source src="' + videoPath + '" type="video/mp4" /></video>'
            // + '<a href="javascript:;" class="video-close-btn iconfont icon-dialog-close-btn"></a>';
            + '<a class="video-close-btn viewer-button viewer-close iconfont icon-wrong" data-action="mix"><div style="position:relative;"><div class="viewer-ripple"></div></div></a>';
        if (!$('#peVideoPlayer').get(0)) {
            $('body').append(videoDom);
            videojs(document.getElementById('peVideoPlayer'), {preload: 'none'}, function (e) {
                $('.video-mask-panel').height(20000);
            });
        }
        $('.video-close-btn').click(function () {
            $('#peVideoPlayer').remove();
            $('.video-mask-panel').remove();
            $('.video-close-btn').remove();
        })
    },
    ajaxUserAnswer: function (renderAnswer) {
        var updateTime = BaseExam.storeAnswer.getUt(BaseExam.examId);
        BaseExam.findUserAnswer(updateTime, renderAnswer);
    },

    clearInterval: function () {
        if (BaseExam.examInterval) {
            clearInterval(BaseExam.examInterval);
        }

        if (BaseExam.checkExamInterval) {
            clearInterval(BaseExam.checkExamInterval);
        }
    },

    findUserAnswer: function (updateTime, renderAnswer) {
        $.ajax({
            url: CFG.ctx + '/ems/exam/client/findUserAnswer',
            data: {examId: BaseExam.examId, updateTime: updateTime},
            dataType: 'json',
            success: function (data) {
                if ($.isEmptyObject(data)) {
                    var answer = BaseExam.storeAnswer.get(BaseExam.examId);
                    if (answer) {
                        renderAnswer(answer);
                    } else if (updateTime) {
                        BaseExam.storeAnswer.clear(BaseExam.examId);
                        BaseExam.findUserAnswer(null, renderAnswer);
                    }

                } else {
                    BaseExam.storeAnswer.clear(BaseExam.examId);
                    renderAnswer(data);
                    BaseExam.storeAnswer.set(BaseExam.examId, data);
                }

            }
        });
    },
    initExamInfo: function () {
        $.ajax({
            url: CFG.ctx + '/ems/exam/client/getExam',
            data: {examId: BaseExam.examId},
            dataType: 'json',
            async: false,
            success: function (data) {
                BaseExam.exam = data;
                BaseExam.es = data.examSetting.examSetting;
                BaseExam.ps = data.examSetting.preventSetting;
            }
        });
    },

    scrollBar: function (totalAnswer, doneLength) {
        var completeInfo = ((doneLength / totalAnswer) * 100).toFixed(0) + "%";
        $('.exam-answer-top-header').find('.pe-answer-progress').get(0).style.width = completeInfo;
        $('.exam-answer-top-header').find('.complete-info').html(completeInfo);
        var hasAnswerNum = $('.pe-answer-test-num').find('.pe-answer-right-num.done').size();
        $('.has-answer-num').html(hasAnswerNum);
        if (completeInfo && parseInt(completeInfo) >= 50 && webcam && webcam.capture && !BaseExam.isWebCam) {
            webcam.capture();
            BaseExam.isWebCam = true;
        }
    },

    //定时更新数据到后台
    timingTrans: function () {
        BaseExam.examInterval = setInterval(BaseExam.transData, BaseExam.transTime);
    },

    initAnswerData: function () {
        if ($.isEmptyObject(BaseExam.answerQueNos[BaseExam.timeSegment]) || BaseExam.timeSegment <= 0) {
            return;
        }

        BaseExam.timeSegment = new Date().getTime();
        BaseExam.answerQueNos[BaseExam.timeSegment] = [];
    },

    //传输方法实现
    transData: function () {
        BaseExam.initAnswerData();
        if (BaseExam.webSocket) {
            BaseExam.socketSaveProcess();
        } else {
            BaseExam.ajaxSaveProcess();
        }
    },

    ajaxSaveProcess: function () {
        $.each(BaseExam.answerQueNos, function (ts, value) {
            try {
                var userAnswer = BaseExam.storeAnswer.get(BaseExam.examId);
            } catch (e) {
                return;
            }

            var data = {}, am = {}, ur = {};
            ur.am = am;
            data.key = 'ANSWER';
            if (!userAnswer) {
                return;
            }

            $.each(value, function (index, answerNo) {
                am[answerNo] = userAnswer[answerNo];
            });

            ur.id = BaseExam.examId;
            data.value = JSON.stringify(ur);
            $.ajax({
                url: CFG.ctx + '/ems/exam/client/saveAnswerProcess',
                data: {key: 'ANSWER', value: JSON.stringify(ur)},
                type: 'post',
                dataType: 'json',
                timeout: 3000,
                success: function (data) {
                    BaseExam.processResult(data);
                }
            });

        });
    },

    socketSaveProcess: function () {
        if (BaseExam.webSocket.readyState !== 1) {
            BaseExam.reconnectWebSocket();
        }

        if (BaseExam.webSocket.readyState !== 1) {
            BaseExam.ajaxSaveProcess();
            return;
        }

        $.each(BaseExam.answerQueNos, function (ts, value) {
            var userAnswer = BaseExam.storeAnswer.get(BaseExam.examId);
            var data = {}, am = {}, ur = {};
            ur.am = am;
            data.key = 'ANSWER';
            $.each(value, function (index, answerNo) {
                am[answerNo] = userAnswer[answerNo];
            });

            ur.id = BaseExam.examId;
            data.value = JSON.stringify(ur);
            BaseExam.webSocket.send(JSON.stringify(data));
        });
    },

    initSuccessPage: function () {
        setTimeout(function () {
            location.replace(CFG.ctx + '/ems/exam/client/initSuccessPage?openTab=' + CFG.openTab + '&examId=' + CFG.examId);
        }, 3000);
    },

    initOperateTime: function () {
        if (!BaseExam.ps.no || BaseExam.ps.noD <= 0) {
            return false;
        }

        var down_time, key_time, keyInterval, mouseInterval;
        $('body').keydown(function () {
            if (null != down_time) {
                clearInterval(down_time);
            }
            if (null != key_time) {
                clearInterval(key_time);
            }
            if (null != keyInterval) {
                clearInterval(keyInterval);
            }
            if (null != mouseInterval) {
                clearInterval(mouseInterval);
            }

            if ($('body').find('.psNod').length > 0) {
                examDialog.close();
            }

            key_time = setTimeout(function () {
                examDialog.countDownTime({
                    content: '<p style="font-size: 15px;">本场考试设置了' + BaseExam.ps.noD + '分钟不操作算舞弊并且强制交卷，目前还剩:</p><p style="color: #999;">请尽快点击操作</p>',
                    onDownOver: function () {
                        BaseExam.submitExam(function () {
                            BaseExam.initSuccessPage();
                        });
                    }
                });
            }, BaseExam.ps.noD * 60000);
        });

        var mouseX = 0, mouseY = 0;
        $('body').mousemove(function (e) {
            if (mouseX === e.pageX && mouseY === e.pageY) {
                return false;
            }
            mouseX = e.pageX, mouseY = e.pageY;
            if (null != down_time) {
                clearInterval(down_time);
            }
            if (null != key_time) {
                clearInterval(key_time);
            }
            if (null != keyInterval) {
                clearInterval(keyInterval);
            }
            if (null != mouseInterval) {
                clearInterval(mouseInterval);
            }

            if ($('body').find('.psNod').length > 0) {
                examDialog.close();
            }

            //60妙不操作就跳转
            down_time = setTimeout(function () {
                examDialog.countDownTime({
                    content: '<p style="font-size: 15px;">本场考试设置了' + BaseExam.ps.noD + '分钟不操作算舞弊并且强制交卷，目前还剩:</p><p style="color: #999;">请尽快点击操作</p>',
                    onDownOver: function () {
                        BaseExam.submitExam(function () {
                            BaseExam.initSuccessPage();
                        });
                    }
                });
            }, BaseExam.ps.noD * 60000);
        });
    },

    parseTime: function (t) {
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

    formatData: function (data, format) {
        var o = {
            "M+": data.getMonth() + 1, // month
            "d+": data.getDate(), // day
            "h+": data.getHours(), // hour
            "m+": data.getMinutes(), // minute
            "s+": data.getSeconds(), // second
            "q+": Math.floor((data.getMonth() + 3) / 3), // quarter
            "S": data.getMilliseconds()
        };

        if (/(y+)/.test(format)) {
            format = format.replace(RegExp.$1, (data.getFullYear() + "").substr(4
                - RegExp.$1.length));
        }

        for (var k in o) {
            if (new RegExp("(" + k + ")").test(format)) {
                format = format.replace(RegExp.$1, RegExp.$1.length == 1
                    ? o[k]
                    : ("00" + o[k]).substr(("" + o[k]).length));
            }
        }

        return format;
    },

    submitExam: function (callback) {
        if(BaseExam.submitLock){
            return false;
        }

        BaseExam.submitLock = true;
        examDialog.close();
        examDialog.close('submit');
        examDialog.subExamIng({
            onLoad: function () {
                // console.log('sub_ing');
            }
        });

        var userAnswer = BaseExam.storeAnswer.get(BaseExam.examId);
        if (userAnswer) {
            var markNo = [];
            $.each(userAnswer, function (queNo, answer) {
                if (answer.m) {
                    markNo.push(queNo);
                }
            });

            $('input[name="markNum"]').val(markNo.join(','));
        }

        if (webcam && webcam.capture) {
            webcam.capture();
        }

        BaseExam.clearInterval();
        var $examForm = $('#examForm');
        $examForm.find('input[name ^="insertPeSimpleBlankValueByTomFill"]').remove();
        var examData = LZString144.compressToBase64($examForm.serialize());
        /*数据压缩提交如果出错则原样提交*/
        BaseExam.submitUserAnswer({examData: examData, compress: true}, function (data) {
            if (data.success) {
                if (callback) {
                    callback();
                }
                return false;
            }

            BaseExam.submitUserAnswer($examForm.serialize(), function (data) {
                if (!data.success) {
                    examDialog.countDownTime({
                        content: '<p style="font-size: 15px;">' + data.message + '</p><p style="color: #999;">请及时联系管理员！</p>'
                    });
                    return false;
                }

                if (callback) {
                    callback();
                }
            });
        });
    },

    submitUserAnswer: function (params, callback) {
        $.ajax({
            url: CFG.ctx + '/ems/exam/client/submitUserAnswer',
            data: params,
            type: 'post',
            dataType: 'json',
            timeout: 120 * 1000,
            success: function (data) {
                if (data.success) {
                    BaseExam.storeAnswer.clear(BaseExam.examId);
                }

                if (callback) {
                    callback(data);
                }
            },
            complete: function (XMLHttpRequest, status) {
                if (status === 'timeout') {
                    BaseExam.submitLock = false;
                    examDialog.close('submit');
                    examDialog.subFail({
                        subAgainBtn: function () {
                            BaseExam.submitExam(function () {
                                BaseExam.initSuccessPage();
                            });
                        }
                    });
                }
            },
            error: function () {
                BaseExam.submitLock = false;
                setTimeout(function () {
                    examDialog.close('submit');
                    examDialog.subFail({
                        isOffline: true,
                        subAgainBtn: function () {
                            BaseExam.submitExam(function () {
                                BaseExam.initSuccessPage();
                            });

                        }
                    });
                }, 3000);
            }
        });
    },

    //后台请求记录切屏的次数
    cutScreen: function () {
        if (BaseExam.ps.csN <= 0) {
            return false;
        }
        if (!BaseExam.ps.cs) {
            window.onblur = function (e) {
                var e = e || window.event;
                if (e.stopPropagation) {
                    e.stopPropagation();
                } else {
                    e.cancelBubble = true;
                }

                $.ajax({
                    url: CFG.ctx + '/ems/exam/client/updateCutScreen',
                    data: {examId: BaseExam.examId},
                    success: function (data) {
                        return false;
                    }
                });
            };
        } else {
            window.onblur = function (e) {
                var e = e || window.event;
                if (e.stopPropagation) {
                    e.stopPropagation();
                } else {
                    e.cancelBubble = true;
                }
                $.ajax({
                    url: CFG.ctx + '/ems/exam/client/updateCutScreen',
                    data: {examId: BaseExam.examId},
                    success: function (data) {
                        if ((parseInt(data) + 1) < BaseExam.ps.csN) {
                            examDialog.alert({

                                content: '<p>请你不要随意切屏，切屏次数超过限制后，系统将会强制提交您的试卷。</p>'
                            });

                            return false;
                        }

                        if ((parseInt(data) + 1) === BaseExam.ps.csN) {
                            examDialog.alert({
                                content: '<p>您已经切屏' + data + '次，请注意！</p><p>如果您再次切屏，系统会强制交卷。</p>'
                            });

                            return false;
                        }

                        examDialog.close();
                        if (parseInt(data) >= BaseExam.ps.csN) {
                            BaseExam.submitExam();
                            examDialog.countDownTime({
                                content: '<p style="font-size: 15px;">由于你违反本场考试的如下规则：<span style="color: #999;">切屏超过' + data + '次。</span></p><p style="color: #999;">如有疑问请联系管理员！</p>',
                                close: false,
                                onDownOver: function () {
                                    BaseExam.initSuccessPage();
                                }
                            });
                        }
                    }
                });
            };
        }
    },

    processResult: function (data) {
        if (data.status === 'DOING') {
            if (data.value) {
                BaseExam.storeAnswer.setUt(BaseExam.examId, data.value);
            }

            delete BaseExam.answerQueNos[data.key];
            var newEndTime = new Date(data.et).getTime(), oldEndTime = new Date(BaseExam.exam.endTime).getTime(),
                nowTime = new Date(data.nt).getTime();
            if (oldEndTime === newEndTime) {
                return false;
            }

            BaseExam.exam.endTime = data.et;
            if (BaseExam.es.elt === 'NO_LIMIT') {
                var examTimes = (newEndTime - oldEndTime) / 1000;
                BaseExam.exam.endTimeLength = BaseExam.exam.endTimeLength + examTimes;
                return false;
            }

            if (oldEndTime > newEndTime) {
                if ((nowTime / 1000) + CFG.residualTime <= (newEndTime / 1000)) {
                    return false;
                }

                CFG.residualTime = (newEndTime / 1000) - (nowTime / 1000);
                return false;
            }

            if (BaseExam.lessTime <= 0) {
                return false;
            }

            if ((newEndTime - oldEndTime) / 1000 <= BaseExam.lessTime) {
                CFG.residualTime = CFG.residualTime + (newEndTime - oldEndTime) / 1000;
                return false;
            }

            CFG.residualTime = CFG.residualTime + BaseExam.lessTime;
        } else if (data.status === 'EXAM_OVER') {
            BaseExam.submitExam();
            examDialog.countDownTime({
                content: '<p style="font-size: 15px;">本场考试已经结束。</p><p style="color: #999;">如有疑问请联系管理员！</p>',
                close: false,
                onDownOver: function () {
                    BaseExam.initSuccessPage();
                }
            });
            //考试被取消
        } else if (data.status === 'INVALID') {
            BaseExam.submitExam(function () {
                if (!CFG.openTab || CFG.openTab === 'false') {
                    window.opener.location.reload();
                }
            });

            examDialog.countDownTime({
                content: '<p style="font-size: 15px;">本场考试被取消安排。</p><p style="color: #999;">如有疑问请联系管理员！</p>',
                close: false,
                onDownOver: function () {
                    if (CFG.openTab && CFG.openTab === 'true') {
                        location.replace(CFG.ctx + '/front/initPage');
                    } else {
                        window.close();
                    }

                }
            });
            //强制交卷
        } else if (data.status === 'FORCESUBMIT') {
            BaseExam.submitExam();
            examDialog.countDownTime({
                content: '<p style="font-size: 15px;">管理员已提交你的试卷。</p><p style="color: #999;">如有疑问请联系管理员！</p>',
                close: false,
                onDownOver: function () {
                    BaseExam.initSuccessPage();
                }
            });
        }
    },

    checkExam: function () {
        BaseExam.checkExamInterval = setInterval(function () {
            $.ajax({
                url: CFG.ctx + '/ems/exam/client/checkExam',
                data: {examId: BaseExam.examId},
                dataType: 'json',
                success: function (data) {
                    BaseExam.processResult(data);
                }
                /*todo 断网没有提示*/
            })
        }, 10000);
    },


    bind: function () {
        $('body').css('background', '#edf0f4');
        var _this = this;
        $(document).ajaxComplete(function (event, jqXHR, options) {
            var ajaxRequestStatus = jqXHR.getResponseHeader("ajaxRequest");
            if (ajaxRequestStatus === 'loginFailed') {
                window.close();
            }
        });
        //视频
        $('.image-video').on('click', function () {
            var thisVideoSrc = $(this).attr('data-src');
            _this.VIDEOPLAYER(thisVideoSrc);
        });
        //音频
        $('.image-audio').on('click', function (e) {
            var _thisIcon = $(this);
            if ($('.image-audio').not(_thisIcon).hasClass('audio-playing') || $('.image-audio').not(_thisIcon).hasClass('audio-pause')) {
                _this.AUDIOOBJ.obj.player_.pause();
                _this.AUDIOOBJ.oldSrc = '';
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
            var thisVideoSrc = _thisIcon.attr('data-src');
            if (_thisIcon.hasClass('audio-playing')) {
                //已经在播放，这里执行暂停
                _this.AUDIOPLAYER(thisVideoSrc, true);
                _thisIcon.removeClass('audio-playing').addClass('audio-pause');
                var newSrc = _thisIcon.attr('src').replace(/audio_playing.gif/ig, 'audio_pause.png');
                _thisIcon.attr('src', newSrc);
            } else {
                _this.AUDIOPLAYER(thisVideoSrc, false);
                _thisIcon.addClass('audio-playing').removeClass('audio-pause');
                var newSrc = _thisIcon.attr('src').replace(/audio_pause.png|default-music.png/ig, 'audio_playing.gif');
                _thisIcon.attr('src', newSrc);
            }
            /*监听音频播放结束*/
            _this.AUDIOOBJ.obj.on('ended', function () {
                $('.image-audio.audio-playing').removeClass('audio-playing audio-pause');
                var newSrc = _thisIcon.attr('src').replace(/audio_pause.png|audio_playing.gif/ig, 'default-music.png');
                _thisIcon.attr('src', newSrc);
            })
        });

        $(".pe-star-container .pe-star").on('click', function () {
            var index = $(this).data("so");
            var $thisStar = $(this);
            $(this).toggleClass("pe-checked-star");
            if ($thisStar.hasClass('icon-un-mark-star')) {
                $thisStar.removeClass('icon-un-mark-star').addClass('icon-has-mark-star pe-checked-star');
            } else {
                $thisStar.removeClass('icon-has-mark-star pe-checked-star').addClass('icon-un-mark-star');
            }
            var userAnswer = BaseExam.storeAnswer.get(BaseExam.examId);
            if (!userAnswer) {
                userAnswer = {};
            }

            if (!userAnswer[index]) {
                userAnswer[index] = {}
            }

            if ($(this).hasClass('pe-checked-star')) {
                userAnswer[index].m = true;
            } else {
                userAnswer[index].m = false;
            }

            BaseExam.answerQueNos[BaseExam.timeSegment].push(index);
            BaseExam.storeAnswer.set(BaseExam.examId, userAnswer);
            $("a.no_" + index + " span").toggle();
        });

        if (!$('.marking-container-wrap').get(0)) {
            BaseExam.renderHeight(0);
        } else {
            BaseExam.markingRenderHeight(0);
        }
        //实时监听信息
        if (BaseExam.webSocket) {
            BaseExam.webSocket.onmessage = function (event) {
                var data = JSON.parse(event.data);
                BaseExam.processResult(data);
            };
        }

        if (BaseExam.ps.rc) {
            var canvas = document.getElementById("canvas");
            if (canvas) {
                if (canvas.toDataURL) {
                    BaseExam.canvasCtx = canvas.getContext("2d");
                    BaseExam.image = BaseExam.canvasCtx.getImageData(0, 0, 320, 240);
                    BaseExam.saveCB = function (data) {
                        var col = data.split(";");
                        var img = BaseExam.image;
                        for (var i = 0; i < 320; i++) {
                            var tmp = parseInt(col[i]);
                            img.data[BaseExam.pos] = (tmp >> 16) & 0xff;
                            img.data[BaseExam.pos + 1] = (tmp >> 8) & 0xff;
                            img.data[BaseExam.pos + 2] = tmp & 0xff;
                            img.data[BaseExam.pos + 3] = 0xff;
                            BaseExam.pos += 4;
                        }

                        if (BaseExam.pos >= 4 * 320 * 240) {
                            BaseExam.canvasCtx.putImageData(img, 0, 0);
                            $.ajax({
                                url: CFG.ctx + '/ems/exam/client/uploadUserImage',
                                data: {examId: BaseExam.examId, image: canvas.toDataURL()},
                                dataType: 'json',
                                async: false,
                                type: 'post'
                            });

                            BaseExam.pos = 0;
                            BaseExam.image = BaseExam.canvasCtx.getImageData(0, 0, 320, 240);
                        }
                    };
                } else {
                    BaseExam.saveCB = function (data) {
                        BaseExam.image.push(data);
                        BaseExam.pos += 4 * 320;
                        if (BaseExam.pos >= 4 * 320 * 240) {
                            $.ajax({
                                url: CFG.ctx + '/ems/exam/client/uploadUserImage',
                                type: 'post',
                                data: {examId: BaseExam.examId, image: BaseExam.image.join('|')},
                                dataType: 'json',
                                async: false
                            });

                            BaseExam.pos = 0;
                        }
                    };
                }

            }
            $(window).scrollTop(0);
            if ($('#webcam').find('object').get(0)) {
                $('#webcam').html('');
            }
            $('.answer-video-cla').show();
            $('.camera-before-mask').show();
            $('.camera-before-mask').width($(window).width()).height($(window).height());
            var rightWrapLeft = Math.abs(parseInt($('.pe-answer-content-right-wrap').css('left'), 10));
            $('body').css('overflow', 'hidden');
            $('.un-ready-camera').css({
                'width': $(window).width(),
                'height': $(window).height(),
                'marginLeft': -(rightWrapLeft + 32),
                'marginTop': '-190px'
            });
            var camTimes = (new Date()).getTime() + Math.floor(Math.random() * 10000);
            var isCameraOk = false;
            //去除摄像头
            $("#webcam").webcam({
                width: 320,
                height: 240,
                mode: "callback",
                swffile: CFG.resourcePath + "/web-static/proExam/carmera/jscam.swf?_t=" + camTimes, // canvas only doesn't implement a jpeg encoder, so the file is much smaller
                onTick: function (remain, t) {
                },
                onSave: BaseExam.saveCB,
                onCapture: function () {
                    webcam.save();
                },
                onReady: function (t, j) {
                    $("#webcam").removeClass('fixed').addClass('pos');
                    $('.answer-video-cla').removeClass('un-ready-camera').width(100).height(100)
                        .css({'marginLeft': '14px', 'marginTop': '0'});
                    $('body').css('overflow', 'auto');
                    $('.camera-before-mask').hide();
                    if (!$('.marking-container-wrap').get(0)) {
                        BaseExam.renderHeight(0);
                    } else {
                        BaseExam.markingRenderHeight(0);
                    }
                    if (BaseExam.ps.rc) {
                        BaseExam.cutScreen();
                    }

                    if (webcam && webcam.capture) {
                        var countdown = 10;
                        var timeInterval = setInterval(function () {
                            if (countdown === 0) {
                                clearInterval(timeInterval);
                                webcam.capture();
                            }

                            countdown--;
                        }, 1000);
                    }
                },
                captureFinish: function (t, j) {

                },
                debug: function (type, string) {
                    var camStartedReg = /Camera started/ig,
                        camStopReg = /Camera stopped/ig,
                        camErrordReg = /No camera was detected/ig;
                    if (type === 'notify' && camStopReg.test(string)) {
                        //点击摄像头“拒绝”触发的事件
                        BaseExam.submitLock = true;
                        window.location.href = CFG.ctx + '/ems/exam/client/initVerifyUser?examId=' + BaseExam.examId + '&openTab=' + CFG.openTab;
                    } else if (type === 'error' && camErrordReg.test(string)) {
                        //一开始 没有摄像头 的状态
                        alert('没有检测到摄像头');
                        return false;
                    }
                },
                onLoad: function () {
                    isCameraOk = true;
                    $('.exam-loading-mask').hide();
                    $('.exam-loading-opacity-mask').hide();
                },
                onGetCameraList: function () {

                }
            });
        } else {
            $('.camera-before-mask').hide();
            $('.exam-loading-mask').hide();
            $('.exam-loading-opacity-mask').hide();
        }


        /*检测浏览器关闭刷新事件*/
        window.onbeforeunload = function (e) {
            if (!BaseExam.submitLock) {
                e = e || window.event;
                var y = e.clientY;
                if (y <= 0 || y >= Math.max(document.body ? document.body.clientHeight : 0, document.documentElement ? document.documentElement.clientHeight : 0)) {
                    //IE 和 Firefox
                    e.returnValue = "确定要刷新或关闭浏览器窗口？";
                }

                BaseExam.transData();
                return "";
            }
        };
    },

    reconnectWebSocket: function () {
        if (BaseExam.webSocket.readyState === 1) {
            return;
        }

        BaseExam.webSocket.close();
        BaseExam.initWebSocket();
    },

    initWebSocket: function () {
        try {
            BaseExam.webSocket = new WebSocket('ws://' + location.host + '/pe/webSocketServer');
            BaseExam.webSocket.onerror = function (event) {
                BaseExam.webSocket.close();
                BaseExam.webSocket = null;
            };
        } catch (e) {
            BaseExam.webSocket = null;
        }
    },

    initData: function () {
        $(document).ajaxSend(function (event, jqxhr, settings) {
            var times = (new Date()).getTime() + Math.floor(Math.random() * 10000);
            if (settings.url.indexOf('?') > -1) {
                settings.url = settings.url + '&_t=' + times;
            } else {
                settings.url = settings.url + '?_t=' + times;
            }

        });

        BaseExam.checkExam();
        var imagesWrap = $('.all-images-wrap');
        for (var i = 0, ILen = imagesWrap.length; i < ILen; i++) {
            $(imagesWrap[i]).addClass('all-images-wrap' + (i + 1)).attr('data-index', i + 1);
            if (!$(imagesWrap[i]).find('.swiper-wrapper img').get(0)) {
                $(imagesWrap[i]).hide();
            } else {
                $(imagesWrap[i]).find('.swiper-wrapper').css('transform', 'translate3d(0px, 0px, 0px)');
                $(imagesWrap[i]).find('.swiper-wrapper').css('-webkit-transform', 'translate3d(0px, 0px, 0px)');
                //图片轮播的样式和功能
                BaseExam.swiperInitItem($('body'), i + 1);
            }
        }

        BaseExam.initWebSocket();
        BaseExam.initExamInfo();
        //摄像头开启
        if (!BaseExam.ps.rc) {
            $('.answer-video-cla').remove();
            BaseExam.cutScreen();
        }

        BaseExam.bind();
        BaseExam.initOperateTime();
        BaseExam.timingTrans();
        BaseExam.timeSegment = new Date().getTime();
        BaseExam.answerQueNos[BaseExam.timeSegment] = [];
        BaseExam.totalAnswer = $('.pe-answer-right-num').length;
        var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
        var leftPanelOffsetLeft = $('.pe-answer-content-left-wrap').offset().left;
        var $thisRightWrap = $('.pe-answer-content-right-wrap');

        //动态计算考试的试卷的头部的文字区域的宽度
        $(window).scroll(function () {
            var windowScrollTop = $(window).scrollTop();
            var windowScrollLeft = $(window).scrollLeft();
            if (!$('.marking-container-wrap').get(0)) {
                BaseExam.renderHeight(windowScrollTop);
            }

        });

        //pe-answer-right-contain
        $('.pe-answer-test-num').mCustomScrollbar('destroy').mCustomScrollbar({
            axis: "y",
            theme: "dark-3",
            scrollbarPosition: "inside",
            setWidth: '273px',
            advanced: {updateOnContentResize: true}
        });
        $('.stu-content-left').delegate('.pe-answer-content-text textarea', 'focus', function () {
            $(this).css('background', '#fff');
        })
        $('.stu-content-left').delegate('.pe-answer-content-text textarea', 'blur', function () {
            $(this).css('background', '#fafafa');
        })

        $(window).resize(function () {
            var windowScrollTop = $(window).scrollTop();
            var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
            var leftPanelOffsetLeft = $('.pe-answer-content-left-wrap').offset().left;
            if (parseInt(leftPanelOffsetLeft) <= 0) {
                $thisRightWrap.css('left', parseInt(leftPanel) + 'px');
            } else {
                $thisRightWrap.css('left', (parseInt(leftPanel) + parseInt(leftPanelOffsetLeft) + 22) + 'px');
            }
            if (!$('.marking-container-wrap').get(0)) {
                BaseExam.renderHeight(windowScrollTop);
            }
        });

        //获取考试时间
        if (BaseExam.es.elt === 'LIMIT' && BaseExam.exam.endTimeLength < CFG.residualTime) {
            examDialog.alert({
                content: '<p>本场考试您的实际考试时长为：' + (BaseExam.exam.endTimeLength / 60).toFixed(0) + '分钟</p><p>原时长为' + BaseExam.es.el + '分钟，时长变短是因为距离本场考试结束时间是' +
                BaseExam.formatData(new Date(BaseExam.exam.endTime), "yyyy-MM-dd hh:mm") + '</p>'
            });

            BaseExam.lessTime = CFG.residualTime - BaseExam.exam.endTimeLength;
            CFG.residualTime = parseInt(BaseExam.exam.endTimeLength);
        }

        //倒计时相关交互
        var endTimeInterval, timeInterval;
        if (CFG.residualTime && parseInt(CFG.residualTime) > 0) {
            timeInterval = setInterval(function () {
                if (CFG.residualTime <= 0) {
                    clearInterval(timeInterval);
                    if (endTimeInterval) {
                        clearInterval(endTimeInterval);
                    }

                    BaseExam.submitExam();
                    examDialog.countDownTime({
                        content: '<p style="font-size: 15px;">本场考试已经结束。</p><p style="color: #999;">如有疑问请联系管理员！</p>',
                        close: false,
                        onDownOver: function () {
                            BaseExam.initSuccessPage();
                        }
                    });
                    return;
                }

                BaseExam.parseTime(--CFG.residualTime);
            }, 1000);
        } else {
            $(".count-down-panel").hide();
        }

        //清除没有数据的人员信息
        $('.pe-answer-num').each(function (index, ele) {
            if ($(ele).text()) {
                return;
            }

            $(ele).parents('dl').remove();
        });

        //结束时间
        if (BaseExam.es.elt === 'NO_LIMIT') {
            endTimeInterval = setInterval(function () {
                if (BaseExam.exam.endTimeLength <= 0) {
                    clearInterval(endTimeInterval);
                    if (timeInterval) {
                        clearInterval(timeInterval);
                    }

                    BaseExam.submitExam();
                    examDialog.countDownTime({
                        content: '<p style="font-size: 15px;">本场考试已经结束。</p><p style="color: #999;">如有疑问请联系管理员！</p>',
                        close: false,
                        onDownOver: function () {
                            BaseExam.initSuccessPage();
                        }
                    });

                    return;
                }

                BaseExam.exam.endTimeLength--;
            }, 1000);
        }

        //填空题去除readonly
        $('.insert-blank-item').each(function (i, e) {
            $(e).removeAttr('readonly');
        });

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
    },

    swiperInitItem: function (wrapDom, index) {
        var swiperDom = '.all-images-wrap' + index + ' ' + ' .swiper-container';
        BaseExam.swiperObj[index] = new Swiper(swiperDom, {
            pagination: '.pagination',
            paginationClickable: true,
            centeredSlide: true,
            freeModeFluid: true,
            grabCursor: true,
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
        if (BaseExam.swiperBindTimes === 0) {
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
                BaseExam.swiperObj[thisSwiperIndex].swipeTo(thisIdType);
            });
            BaseExam.swiperBindTimes = 1;
        }

    },
    answerListScroll: function (nextItemNum) {
        var $numListWrap = $('.pe-answer-test-num');
        var lineNum = 5;
        //总题数
        var totalNum = $numListWrap.find('.pe-answer-right-num').length;
        //7是页面list的每行的标签数量，这是页面写死的，就7个;
        var totalLines = Math.ceil(totalNum / lineNum);
        //每个小数字标签的高度;这里也基本写死的45,$('.pe-answer-right-num').outerHeight() + 15(下margin的值) + 2()；
        var itemH = $('.pe-answer-right-num').outerHeight() + 15;
        //数字列表的包围框的高度
        var numListWrapH = $numListWrap.height();
        //可见区域能显示几行完整的数字item; y3
        var x1 = Math.floor((numListWrapH + 15) / itemH);
        //可见区域有几个数字item;Y3
        var y1 = x1 * lineNum;
        //已经向上滚动的行数，round是为了顶部的item,如果过了自身高度的一半，就算不完整显示了,算在向上滚动的行数范围之内;y2
        var x2 = Math.abs(Math.round(parseInt($('.pe-answer-test-num .mCSB_container').css('top')) / itemH));
        //已经向上滚动的item个数; Y2;
        var y2 = x2 * lineNum;
        //下一题所在的行数
        var nowStayLine = Math.ceil(nextItemNum / lineNum);
        //如果下一题在 不可见的下方
        if (nowStayLine > (x1 + x2)) {
            $('.pe-answer-test-num .mCSB_container').css('top', (nowStayLine - 2) * (-itemH));
        }

    },
    renderHeight: function (scrollTop) {
        var windowHeight = $(window).height();
        //64头部高度，106是考试标题的panel的outerHeight，40是中间的panel的上下padding，40是中间panel的margin-bottom，60是footer的高度;
        var thisShouldHeight = windowHeight - 64 - 20 - 10 - 30 - 5;
        var rightTopHeight = $('.pe-answer-right-top').outerHeight();
        var rightContentTopHeight = $('.pe-answer-right-content-top').outerHeight();
        var rightBtnHeight = $('.pe-answer-sure').outerHeight();
        var rightItemListHeight = thisShouldHeight - rightTopHeight - rightContentTopHeight - rightBtnHeight - 20 - 40;
        var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
        var leftPanelOffsetLeft = $('.pe-answer-content-left-wrap').offset().left;
        $('.pe-answer-test-num').css('height', (rightItemListHeight) + 'px');
        $('.pe-answer-content-right-wrap').css('left', (parseInt(leftPanel) + parseInt(leftPanelOffsetLeft) + 8) + 'px');
        $('.pe-answer-content-right-wrap').css('top', $('.stu-content-left').offset().top);
    },
    markingRenderHeight: function () {
        var windowHeight = $(window).height();
        //64头部高度，106是考试标题的panel的outerHeight，40是中间的panel的上下padding，40是中间panel的margin-bottom，60是footer的高度;
        var thisShouldHeight = windowHeight - 64 - 20 - 5;
        var rightTopHeight = $('.marking-container-wrap .pe-answer-right-top').outerHeight();
        var rightContentTopHeight = $('.marking-container-wrap .pe-answer-right-content-top').outerHeight();
        // var rightProgressTopHeight = $('.marking-container-wrap .pe-answer-progress-panel').outerHeight();
        var rightBtnHeight = $('.marking-container-wrap .pe-answer-sure').outerHeight();
        var stuLeftDownH = $('.stu-content-left').outerHeight();
        var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
        var leftPanelOffsetLeft = $('.pe-answer-content-left-wrap').offset().left;
        var rightItemListHeight = thisShouldHeight - rightTopHeight - rightContentTopHeight - rightBtnHeight;
        $('.marking-container-wrap .pe-making-template-wrap').css('minHeight', (thisShouldHeight - 40 - 2) + 'px');//减去40,是因为去除template外面的包围框的上下padding
        $('.marking-container-wrap .pe-answer-test-num').css('height', (rightItemListHeight - 40 - 58) + 'px');
        $('.pe-answer-content-right-wrap').css('left', (parseInt(leftPanel) + parseInt($('.pe-answer-content-left-wrap').offset().left) + 20) + 'px');
        var rightWrapLeft = Math.abs(parseInt($('.pe-answer-content-right-wrap').css('left'), 10));
        if ($('.un-ready-camera').get(0)) {
            $('.un-ready-camera').css({
                'width': $(window).width(),
                'height': $(window).height(),
                'marginLeft': -(rightWrapLeft + 44),
                'marginTop': '-190px'
            });
        }

    }

};