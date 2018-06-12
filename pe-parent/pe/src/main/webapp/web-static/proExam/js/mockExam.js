var examDialog = {
    close: function () {
        $('.pe-box-wrap').remove();
        $('.pe-exam-mask').remove();
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
        var dialogDom1 = '<div class="pe-exam-mask"></div><div class="pe-box-wrap">'
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
            e.stopPropagation();
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
        if (($('.pe-box-wrap').get(0) && $('.pe-exam-mask').get(0))) {
            return false;
        }
        var defaults = {
            content: '',
            btn: ['我知道了'],
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
        var dialogDom = '<div class="pe-exam-mask"></div><div class="pe-box-wrap">'
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
    countDownTime: function (settings) {
        if (($('.pe-box-wrap').get(0) && $('.pe-exam-mask').get(0))) {
            return false;
        }
        var defaults = {
            content: '',
            downTime: 60,
            width: 470,
            height: 61,
            onCancel: function () {
            },
            onDownOver: function () {
                //alert('倒计时结束啦');
            },
            onLoad: function () {
            }
        };
        $.extend(defaults, settings);
        var dialogDom = '<div class="pe-exam-mask"></div><div class="pe-box-wrap downTime-box-contain">'
            + '<i class="iconfont pe-box-close">&#xe643;</i>'
            + '<div class="pe-box-contain floatL" style="width:' + defaults.width + 'px;height:' + defaults.height + 'px;"><div style="width:86%;margin-left:60px;line-height:25px;text-align: left;">'
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
                    defaults.onDownOver();
                    clearInterval(downTimeInterval);
                    examDialog.close();
                }
            }, 1000)

        }
        $('.pe-box-close').click(function () {
            defaults.onCancel();
            clearInterval(downTimeInterval);
            examDialog.close();
        });
        defaults.onLoad();
    }
};

var userId = CFG.userId;
var MockExam = {
    renderAnswer: function (answer) {
        var answerInfoPanel = $('#peAnswerInfoPanel');
        var numElems = answerInfoPanel.find('.pe-answer-right-num');
        var totalAnswer = 0;

        for (var item in numElems) {
            var answer = answer;
            var itemElem = $('.paper-add-question-content:eq(' + (item - 1) + ')');
            var itemType = itemElem.attr('data-type');
            var itemId = itemElem.find("input:eq(0)").val();
            if (answer[itemId] == undefined || answer[itemId].a == undefined) {
                continue;
            }
            if (itemType === 'INDEFINITE_SELECTION' || itemType === 'MULTI_SELECTION') {//不定向选择
                var answerArr = answer[itemId].a.split(',');
                for (var i = 0; i < answerArr.length; i++) {
                    var num = parseInt(answerArr[i]) + 1;
                    itemElem.find('input:eq(' + num + ')').get(0).checked = 'checked';
                }
            } else if (itemType === 'SINGLE_SELECTION') {//单选
                itemElem.find('input:eq(' + (answer[itemId].a + 1) + ')').get(0).checked = 'checked';
            } else if (itemType === 'JUDGMENT') {//判断
                if (answer[itemId].a == 0) {
                    itemElem.find('input:eq(1)').get(0).checked = 'checked';
                } else {
                    itemElem.find('input:eq(0)').get(0).checked = 'checked';
                }
            } else if (itemType === 'QUESTIONS') {
                itemElem.find('textarea').val(answer[itemId].a);
            } else if (itemType === 'FILL' && answer[itemId].a) {
                answerArr = answer[itemId].a.split('、');
                for (var i = 0; i < answerArr.length; i++) {
                    itemElem.find('.insert-blank-item:eq(' + i + ')').val(answerArr[i]);
                }
            }

            if (answer[itemId].a) {
             totalAnswer++;
             numElems.eq(item - 1).addClass('done');
             }
            if (answer[itemId].m) {
             itemElem.find('.icon-start-difficulty').toggleClass("pe-checked-star");
             $("a.no_" + item + " span").toggle();
            }
        }

        var completeInfo = ((totalAnswer / numElems.size()) * 100).toFixed(0) + "%";
        answerInfoPanel.find('.pe-answer-progress').get(0).style.width = completeInfo;
        answerInfoPanel.find('.complete-info').html(completeInfo);
    },
    examId: CFG.examId,
    rootPath: '/pe',
    answerQueNos: {},
    timeSegment: '', //当前时间段
    transTime: 60 * 1000,//单位秒
    examInterval: '', //定时时间
    webSocket: null, //websocket
    totalAnswer: 0,
    lessTime: 0,//单位S
    pos: 0,
    image: [],
    saveCB: function () {
    },
    ctx: '',
    exam: {},
    es: {},
    ps: {},
    AUDIOOBJ: {
        oldSrc: '',
        obj: {}
    },
    //音视频
    AUDIOPLAYER: function (audioPath, isPlaying, isLoop) {
        if (!MockExam.AUDIOOBJ.oldSrc || MockExam.AUDIOOBJ.oldSrc !== audioPath) {
            MockExam.AUDIOOBJ.oldSrc = audioPath;
        }
        /*音频，不在单独弄*/
        if (isPlaying) {
            console.log(MockExam.AUDIOOBJ);
            // $('.music-audio-panel').find('video').get(0).stop();
            MockExam.AUDIOOBJ.obj.player_.pause();
        } else {
            var audioObj = null;
            MockExam.AUDIOOBJ.oldSrc = '';
            if (isLoop) {
                var audioDom = '<video id="peAudioPlayer" loop="true" data-type="audio"  class="video-js music-audio-panel vjs-default-skin pe-video-player-panel" controls preload="none" width="0" height="0" poster="">'
                    + '<source src="' + audioPath + '" type="audio/mp3" /></video>';
            } else {
                var audioDom = '<video id="peAudioPlayer" data-type="audio"  class="video-js music-audio-panel vjs-default-skin pe-video-player-panel" controls preload="none" width="0" height="0" poster="">'
                    + '<source src="' + audioPath + '" type="audio/mp3" /></video>';
            }

            if (!$('#peAudioPlayer').get(0) || ($('#peAudioPlayer').get(0) && MockExam.AUDIOOBJ.oldSrc !== audioPath)) {
                $('#peAudioPlayer').remove();
                $('body').append(audioDom);
                MockExam.AUDIOOBJ.obj = videojs(document.getElementById('peAudioPlayer'), {autoplay: "autoplay"}, function (e) {

                });
            } else {
                MockExam.AUDIOOBJ.obj.player_.play();
            }
        }

    },
    VIDEOPLAYER: function (videoPath, videoDom) {
        if (!$.isEmptyObject(MockExam.AUDIOOBJ.obj)) {
            MockExam.AUDIOOBJ.obj.player_.pause();
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

        var videoDom = '<div class="video-mask-panel"><a href="javascript:;" class="video-close-btn iconfont icon-dialog-close-btn"></a></div>'
            + '<video id="peVideoPlayer" class="video-js vjs-default-skin pe-video-player-panel" controls preload="auto" width="640" height="480" poster="">'
            + '<source src="' + videoPath + '" type="video/mp4" /></video>';
        if (!$('#peVideoPlayer').get(0)) {
            $('body').append(videoDom);
            videojs(document.getElementById('peVideoPlayer'), {preload: 'none'}, function (e) {
                $('.video-mask-panel').height(20000);
            });
        }
        $('.video-close-btn').click(function () {
            $('#peVideoPlayer').remove();
            $('.video-mask-panel').remove();
        })
    },
    ajaxUserAnswer: function (renderAnswer) {
        var updateTime = MockExam.storeAnswer.getUt(MockExam.examId);
        MockExam.findUserAnswer(updateTime, renderAnswer);
    },


    getExamLength: function () {
        var timeLength = 0;
        $.ajax({
            url: MockExam.rootPath + '/ems/exam/client/getAnswerLength',
            data: {examId: MockExam.examId},
            dataType: 'json',
            async: false,
            success: function (data) {
                timeLength = data;
            },
            error: function () {
                examDialog.alert({
                    content: '请求考试信息出错，请重新进入考试！'
                });
            }
        });

        return timeLength;
    },

    findUserAnswer: function (updateTime, renderAnswer) {
        $.ajax({
            url: MockExam.rootPath + '/ems/simulationExam/client/findUserAnswer',
            data: {examId: MockExam.examId, updateTime: updateTime},
            dataType: 'json',
            success: function (data) {
                if ($.isEmptyObject(data)) {
                    var answer = MockExam.storeAnswer.get(MockExam.examId);
                    if (answer) {
                        renderAnswer(answer);
                    } else if (updateTime) {
                        MockExam.storeAnswer.clear(MockExam.examId);
                        MockExam.findUserAnswer(null, renderAnswer);
                    }

                } else {
                    renderAnswer(data);
                    MockExam.storeAnswer.set(MockExam.examId, data);
                }

            },
            error: function () {
                examDialog.alert({
                    content: '请求学员信息出错，请重新进入考试！'
                });
            }
        });
    },
    initExamInfo: function () {
        /*  $.ajax({
         url: MockExam.rootPath + '/ems/exam/client/getExam',
         data: {examId: MockExam.examId},
         dataType: 'json',
         async: false,
         success: function (data) {
         MockExam.exam = data;
         MockExam.es = data.examSetting.examSetting;
         MockExam.ps = data.examSetting.preventSetting;
         },
         error: function () {
         examDialog.alert({
         content: '请求考试信息出错，请重新进入考试！'
         });
         }
         });*/
    },

    isSupportStorage: function () {
        return window.localStorage;
    },
    getStorageCapacity: function () {
        var size = 0;
        for (var item in window.localStorage) {
            if (window.localStorage.hasOwnProperty(item)) {
                size += window.localStorage.getItem(item).length;
            }
        }
        return size;
    },

    scrollBar: function (totalAnswer, doneLength) {
        var completeInfo = ((doneLength / totalAnswer) * 100).toFixed(0) + "%";
        $('#peAnswerInfoPanel').find('.pe-answer-progress').get(0).style.width = completeInfo;
        $('#peAnswerInfoPanel').find('.complete-info').html(completeInfo);
    },

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

    //定时更新数据到后台
    timingTrans: function () {
        MockExam.examInterval = setInterval(MockExam.transData, MockExam.transTime);
    },

    initAnswerData: function () {
        if ($.isEmptyObject(MockExam.answerQueNos[MockExam.timeSegment]) || MockExam.timeSegment <= 0) {
            return;
        }

        MockExam.timeSegment = new Date().getTime();
        MockExam.answerQueNos[MockExam.timeSegment] = [];
    },

    //传输方法实现
    transData: function () {
        MockExam.initAnswerData();
        if (MockExam.webSocket) {
            MockExam.socketSaveProcess();
        } else {
            MockExam.ajaxSaveProcess();
        }
    },

    ajaxSaveProcess: function () {
        $.each(MockExam.answerQueNos, function (ts, value) {
            var userAnswer = MockExam.storeAnswer.get(MockExam.examId);
            var data = {}, am = {}, ur = {};
            ur.am = am;
            data.key = 'ANSWER';
            $.each(value, function (index, answerNo) {
                am[answerNo] = userAnswer[answerNo];
            });

            ur.id = MockExam.examId;
            data.value = JSON.stringify(ur);
            //   MockExam.saveTransientAnswer();
            $.ajax({
                url: MockExam.rootPath + '/ems/simulationExam/client/saveAnswerProcess' + '?' + $('#examForm').serialize(),
                dataType: 'json',
                timeout: 3000,
                type: "post",
                success: function (data) {
                    MockExam.processResult(data);
                },
                error: function () {
                    //examDialog.alert({
                    //    content: '您与服务器断开连接，为了保证考试正常，请重新进入考试！'
                    //});
                }
            });

        });
    },

    socketSaveProcess: function () {
        if (MockExam.webSocket.readyState != 1) {
            MockExam.reconnectWebSocket();
        }

        if (MockExam.webSocket.readyState != 1) {
            MockExam.ajaxSaveProcess();
            return;
        }

        $.each(MockExam.answerQueNos, function (ts, value) {
            var userAnswer = MockExam.storeAnswer.get(MockExam.examId);
            var data = {}, am = {}, ur = {};
            ur.am = am;
            data.key = 'ANSWER';
            $.each(value, function (index, answerNo) {
                am[answerNo] = userAnswer[answerNo];
            });

            ur.id = MockExam.examId;
            data.value = JSON.stringify(ur);
            MockExam.webSocket.send(JSON.stringify(data));
        });
    },

    initOperateTime: function () {
        if (!MockExam.ps.no || MockExam.ps.noD <= 0) {
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
                    content: '<p style="font-size: 15px;">本场考试设置了' + MockExam.ps.noD + '分钟不操作算舞弊并且强制交卷，目前还剩:</p><p style="color: #999;">请尽快点击操作</p>',
                    onDownOver: function () {
                        MockExam.submitExam();
                    }
                });
            }, MockExam.ps.noD * 60000);
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
                    content: '<p style="font-size: 15px;">本场考试设置了' + MockExam.ps.noD + '分钟不操作算舞弊并且强制交卷，目前还剩:</p><p style="color: #999;">请尽快点击操作</p>',
                    onDownOver: function () {
                        MockExam.submitExam();
                    }
                });
            }, MockExam.ps.noD * 60000);
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

    saveTransientAnswer: function () {
        var userAnswer = MockExam.storeAnswer.get(MockExam.examId);
        if (userAnswer) {
            var markNo = [];
            $.each(userAnswer, function (queNo, answer) {
                if (answer.m) {
                    markNo.push(queNo);
                }
            });

            $('input[name="markNum"]').val(markNo.join(','));
        }
        var fills = $('.paper-add-question-content[data-type="FILL"] ');
        var map = {};
        for (var i = 0; i < fills.length; i++) {
            var itemId = $('.paper-add-question-content[data-type="FILL"]:eq(i)>div.paper-question-stem').attr("data-index");
            var itemValues = $('.paper-add-question-content[data-type="FILL"]:eq(i) input.insert-blank-item').val();
            map.itemId = itemValues;
        }


        MockExam.storeAnswer.clear(MockExam.examId);
        if (webcam && webcam.capture) {
            webcam.capture();
        }

        document.examForm.setAttribute('action', MockExam.rootPath + '/ems/simulationExam/client/saveAnswerProcess');
        document.examForm.submit();
    },

    submitExam: function () {
        var userAnswer = MockExam.storeAnswer.get(MockExam.examId);
        if (userAnswer) {
            var markNo = [];
            $.each(userAnswer, function (queNo, answer) {
                if (answer.m) {
                    markNo.push(queNo);
                }
            });

            $('input[name="markNum"]').val(markNo.join(','));
        }

        var fills = $('.paper-add-question-content[data-type="FILL"] ');
        var map = {};
        for (var i = 0; i < fills.length; i++) {
            var itemId = $('.paper-add-question-content[data-type="FILL"]:eq(i)>div.paper-question-stem').attr("data-index");
            var itemValues = $('.paper-add-question-content[data-type="FILL"]:eq(i) input.insert-blank-item').val();
            map.itemId = itemValues;
        }


        MockExam.storeAnswer.clear(MockExam.examId);
        if (webcam && webcam.capture) {
            webcam.capture();
        }

        document.examForm.setAttribute('action', MockExam.rootPath + '/ems/simulationExam/client/submitUserAnswer');
        document.examForm.submit();
    },

    processResult: function (data) {
        if (data.status === 'DOING') {
            if (data.value) {
                MockExam.storeAnswer.setUt(MockExam.examId, data.value);
            }

            delete MockExam.answerQueNos[data.key];
            var newEndTime = new Date(data.et).getTime(), oldEndTime = new Date(MockExam.exam.endTime).getTime(), nowTime = new Date(data.nt).getTime();
            if (oldEndTime === newEndTime) {
                return false;
            }

            if (MockExam.es.elt === 'NO_LIMIT') {
                var examTimes = (newEndTime - oldEndTime) / 1000;
                MockExam.exam.endTimeLength = MockExam.exam.endTimeLength + examTimes;
                return false;
            }

            if (oldEndTime > newEndTime) {
                if ((nowTime / 1000) + CFG.residualTime <= (newEndTime / 1000)) {
                    return false;
                }

                CFG.residualTime = (newEndTime / 1000) - (nowTime / 1000);
                return false;
            }

            if (MockExam.lessTime <= 0) {
                return false;
            }

            if ((newEndTime - oldEndTime) / 1000 <= MockExam.lessTime) {
                CFG.residualTime = CFG.residualTime + (newEndTime - oldEndTime) / 1000;
                return false;
            }

            CFG.residualTime = CFG.residualTime + MockExam.lessTime;
        } else if (data.status === 'FORCE') {
            examDialog.alert({
                content: '本场考试被管理员强制提交，如有疑问请联系管理员！'
            });
            MockExam.submitExam();
            document.examForm.submit();
            //强制交卷
        } else if (data.status === 'INVALID') {
            //失效
            examDialog.alert({
                content: '本场考试被取消安排，如有疑问请联系管理员！'
            });
            window.close();
        } else if (data.status === "FORCESUBMIT") {
            examDialog.alert({
                content: "管理员已提交你的试卷，如有疑问请联系管理员！"
            });
            MockExam.submitExam();
            document.examForm.submit();
        }
    },

    bind: function () {
        var _this = this;
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

        $(".icon-start-difficulty").on('click', function () {
            var index = $(this).data("so");
            $(this).toggleClass("pe-checked-star");
            var userAnswer = MockExam.storeAnswer.get(MockExam.examId);
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

            MockExam.answerQueNos[MockExam.timeSegment].push(index);
            MockExam.storeAnswer.set(MockExam.examId, userAnswer);
            $("a.no_" + index + " span").toggle();
        });

        $('#countDownPanel').on('click', function () {
            var _this = $(this);
            if (_this.hasClass('close')) {
                _this.find('.count-down').addClass('show-count');
                _this.find('.show-count-down-text').removeClass('show-count');
                _this.removeClass('close')
            } else {
                _this.find('.count-down').removeClass('show-count');
                _this.find('.show-count-down-text').addClass('show-count');
                _this.addClass('close');
            }
        });

        //实时监听信息
        if (MockExam.webSocket) {
            MockExam.webSocket.onmessage = function (event) {
                var data = JSON.parse(event.data);
                MockExam.processResult(data);
            };
        }

        var canvas = document.getElementById("canvas");
        if (canvas) {
            if (canvas.toDataURL) {
                MockExam.ctx = canvas.getContext("2d");
                MockExam.image = MockExam.ctx.getImageData(0, 0, 240, 160);
                MockExam.saveCB = function (data) {
                    var col = data.split(";");
                    var img = MockExam.image;
                    for (var i = 0; i < 240; i++) {
                        var tmp = parseInt(col[i]);
                        img.data[MockExam.pos] = (tmp >> 16) & 0xff;
                        img.data[MockExam.pos + 1] = (tmp >> 8) & 0xff;
                        img.data[MockExam.pos + 2] = tmp & 0xff;
                        img.data[MockExam.pos + 3] = 0xff;
                        MockExam.pos += 4;
                    }

                    if (MockExam.pos >= 4 * 240 * 160) {
                        MockExam.ctx.putImageData(img, 0, 0);
                        $.ajax({
                            url: MockExam.rootPath + '/ems/exam/client/uploadUserImage',
                            data: {examId: MockExam.examId, image: canvas.toDataURL()},
                            dataType: 'json',
                            async: false,
                            type: 'post'
                        });

                        MockExam.pos = 0;
                        MockExam.image = MockExam.ctx.getImageData(0, 0, 240, 160);
                    }
                };
            } else {
                MockExam.saveCB = function (data) {
                    MockExam.image.push(data);
                    MockExam.pos += 4 * 240;
                    if (MockExam.pos >= 4 * 240 * 160) {
                        $.ajax({
                            url: MockExam.rootPath + '/ems/exam/client/uploadUserImage',
                            type: 'post',
                            data: {examId: MockExam.examId, image: MockExam.image.join('|')},
                            dataType: 'json',
                            async: false
                        });

                        MockExam.pos = 0;
                    }
                };
            }

        }
        //去除摄像头
        $("#webcam").webcam({
            width: 240,
            height: 160,
            mode: "callback",
            swffile: MockExam.rootPath + "/web-static/proExam/carmera/jscam_canvas_only.swf", // canvas only doesn't implement a jpeg encoder, so the file is much smaller
            onTick: function (remain) {
                if (0 == remain) {
                    jQuery("#status").text("Cheese!");
                } else {
                    jQuery("#status").text(remain + " seconds remaining...");
                }
            },
            onSave: MockExam.saveCB,
            onCapture: function () {
                webcam.save();
            },
            debug: function (type, string) {
                if (type === 'notify' && string === 'Camera started') {
                    $("#webcam").removeClass('fixed').addClass('pos');
                }
            },
            onLoad: function () {
            }
        });

        var countdown = 60;
        var timeInterval = setInterval(function () {
            if (countdown == 0) {
                clearInterval(timeInterval);
                if (webcam && webcam.capture) {
                    webcam.capture();
                }

            }

            countdown--;
        }, 1000);

    },

    reconnectWebSocket: function () {
        if (MockExam.webSocket.readyState === 1) {
            return;
        }

        MockExam.webSocket.close();
        MockExam.initWebSocket();
    },

    initWebSocket: function () {
        /* try {
         MockExam.webSocket = new WebSocket('ws://' + location.host + '/pe/webSocketServer');
         MockExam.webSocket.onerror = function (event) {
         MockExam.webSocket.close();
         MockExam.webSocket = null;
         };
         } catch (e) {
         MockExam.webSocket = null;
         }*/
    },

    initData: function () {
        MockExam.ajaxUserAnswer(MockExam.renderAnswer);
        var imagesWrap = $('.all-images-wrap');
        for (var i = 0, ILen = imagesWrap.length; i < ILen; i++) {
            $(imagesWrap[i]).addClass('all-images-wrap' + (i + 1)).attr('data-index', i + 1);
            if (!$(imagesWrap[i]).find('.swiper-wrapper img').get(0)) {
                $(imagesWrap[i]).hide();
            } else {
                $(imagesWrap[i]).find('.swiper-wrapper').css('transform', 'translate3d(0px, 0px, 0px)');
                $(imagesWrap[i]).find('.swiper-wrapper').css('-webkit-transform', 'translate3d(0px, 0px, 0px)');
                //图片轮播的样式和功能
                MockExam.swiperInitItem($('body'), i + 1);
            }
        }

        MockExam.initWebSocket();
        MockExam.initExamInfo();
        //摄像头开启
        if (!MockExam.ps.rc) {
            $('.answer-video-cla').remove();
        }

        MockExam.bind();
        MockExam.initOperateTime();
        MockExam.timingTrans();
        MockExam.timeSegment = new Date().getTime();
        MockExam.answerQueNos[MockExam.timeSegment] = [];
        MockExam.totalAnswer = $('.pe-answer-right-num').length;
        var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
        var leftPanelOffsetLeft = $('.pe-answer-content-left-wrap').offset().left;
        $('.pe-answer-content-right-wrap').css('left', parseInt(leftPanel) + parseInt(leftPanelOffsetLeft) + 'px');
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

        //获取考试时间
        if (MockExam.es.elt === 'LIMIT' && MockExam.exam.endTimeLength < CFG.residualTime) {
            examDialog.alert({
                content: '<p>本场考试您的实际考试时长为：' + (MockExam.exam.endTimeLength / 60).toFixed(0) + '分钟</p><p>原时长为' + MockExam.es.el + '分钟，时长变短是因为距离本场考试结束时间是' +
                MockExam.formatData(new Date(MockExam.exam.endTime), "yyyy-MM-dd hh:mm") + '</p>'
            });

            MockExam.lessTime = CFG.residualTime - MockExam.exam.endTimeLength;
            CFG.residualTime = parseInt(MockExam.exam.endTimeLength);
        }

        //倒计时相关交互
        if (CFG.residualTime && parseInt(CFG.residualTime) > 0) {
            var timeInterval = setInterval(function () {
                if (CFG.residualTime === 0) {
                    clearInterval(timeInterval);
                    MockExam.submitExam();
                    return;
                }

                MockExam.parseTime(--CFG.residualTime);
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
        if (MockExam.es.elt === 'NO_LIMIT') {
            var endTimeInterval = setInterval(function () {
                if (MockExam.exam.endTimeLength === 0) {
                    clearInterval(endTimeInterval);
                    examDialog.alert({
                        content: '本场考试已经结束，如有疑问请联系管理员！'
                    });

                    MockExam.submitExam();
                    return;
                }

                MockExam.exam.endTimeLength--;
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
    swiperObj: {},
    swiperInitItem: function (wrapDom, index) {
        var swiperDom = '.all-images-wrap' + index + ' ' + ' .swiper-container';
        MockExam.swiperObj[index] = new Swiper(swiperDom, {
            pagination: '.pagination',
            paginationClickable: true,
            centeredSlide: true,
            freeModeFluid: true,
            grabCursor: true,
            slidesPerView: 'auto',
            watchActiveIndex: true,
            onFirstInit: function () {
                $('.itemImageViewWrap').viewer({
                    url: 'data-original',
                    title: false,
                    fullscreen: false,
                    show: function () {
                        $('.pe-answer-nav-top').css("zIndex", "0");
                        $('.pe-answer-content-right-wrap').css("zIndex", "0");
                        $('.pe-public-top-nav-header').css("zIndex", "0");
                    },
                    hidden: function () {
                        $('.pe-answer-nav-top').css("zIndex", "1989");
                        $('.pe-answer-content-right-wrap').css("zIndex", "1989");
                        $('.pe-public-top-nav-header').css("zIndex", "1989");
                    }
                });
            }
        });
        wrapDom.delegate('.upload-img', 'click', function () {
            var _this = $(this);
            var swiperWrapper = _this.parents('.paper-add-question-content ').find('.swiper-wrapper');
            swiperWrapper.find('li').removeClass('image-icon-cur');
            var thisIdType = $(this).attr('data-index');
            swiperWrapper.find('li[data-index="' + thisIdType + '"]').addClass('image-icon-cur');
            var thisIconIndex = swiperWrapper.find('li[data-index="' + thisIdType + '"]').index();
            var thisSwiperIndex = parseInt(swiperWrapper.parents('.all-images-wrap').attr('data-index'));
            MockExam.swiperObj[thisSwiperIndex].swipeTo(thisIconIndex);
        });
    }

};