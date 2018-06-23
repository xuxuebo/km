var EnCheck = {
    browserName: '',
    browserNum: '',
    browser: function () {
        var ua = navigator.userAgent.toLowerCase();
        var s;
        (s = ua.match(/msie ([\d.]+)/)) ? ua.match(/msie ([\d.]+)/) :

            (s = ua.match(/firefox\/([\d.]+)/)) ? ua.match(/firefox\/([\d.]+)/) :

                (s = ua.match(/chrome\/([\d.]+)/)) ? ua.match(/chrome\/([\d.]+)/) :

                    (s = ua.match(/opera.([\d.]+)/)) ? ua.match(/opera.([\d.]+)/) :

                        (s = ua.match(/version\/([\d.]+).*safari/)) ? ua.match(/version\/([\d.]+).*safari/) : 0;
        if (ua.match(/msie ([\d.]+)/)) {
            s = ua.match(/msie ([\d.]+)/);
            EnCheck.browserName = 'IE_' + parseInt(s[1]);
            EnCheck.browserNum = parseInt(s[1]);
            if (parseInt(s[1]) < 8) {
                PEMO.DIALOG.alert({
                    content: '您的IE内核浏览器版本太低啦',
                    yes: function () {
                        layer.closeAll();
                        return false;
                    }
                });
            } else {
                return true;
            }
        } else if (ua.match(/firefox\/([\d.]+)/)) {
            s = ua.match(/firefox\/([\d.]+)/);
            EnCheck.browserName = 'FIREFOX_' + parseInt(s[1]);
            EnCheck.browserNum = parseInt(s[1]);
            if (parseInt(s[1]) < 30) {
                PEMO.DIALOG.alert({
                    content: '您的火狐浏览器版本太低啦',
                    yes: function () {
                        layer.closeAll();
                        return false;
                    }
                });

            } else {
                return true;
            }
        } else if (ua.match(/chrome\/([\d.]+)/)) {
            s = ua.match(/chrome\/([\d.]+)/);
            EnCheck.browserName = 'CHROME_' + parseInt(s[1]);
            EnCheck.browserNum = parseInt(s[1]);
            if (parseInt(s[1]) < 35) {
                PEMO.DIALOG.alert({
                    content: '您的Chrome浏览器版本或者weikit内核版本太低啦',
                    yes: function () {
                        layer.closeAll();
                        return false;
                    }
                });

            } else {
                return true;
            }

        } else if (ua.indexOf('Edge') > -1 || ua.indexOf('rv') > -1) {
            /*说明是edge浏览器和至少是ie11浏览器*/
            EnCheck.browserName = "IE11orEdge";
            return true;
        }
    },
    fullScree: function () {
        var bv = navigator.userAgent.toLowerCase();
        var isIE = EnCheck.browserName.indexOf('IE') > -1;
        var isIE11orEdge = EnCheck.browserName.indexOf('IE11orEdge') > -1;
        var isWin7 = bv.indexOf('windows nt 6.1');
        //win7 系统是 windows NT 6.1
        if (EnCheck.browser && ((!isIE && EnCheck.browserNum > 35) || (isIE11orEdge && isWin7))) {
            var docElm = document.documentElement;
            if (docElm.requestFullscreen) {
                // docElm.requestFullscreen();
                return true;
            }
            else if (docElm.mozRequestFullScreen) {
                // docElm.mozRequestFullScreen();
                return true;
            }
            else if (docElm.webkitRequestFullScreen) {
                // docElm.webkitRequestFullScreen();
                return true;
            }
            else if (docElm.msRequestFullscreen) {
                // elem.msRequestFullscreen();
                return true;
            }
        } else {
            return false;
        }

    },
    video: function () {

    },
    flash: function () {
        var hasFlash = 0;         //是否安装了flash
        var flashVersion = 0; //flash版本
        var isIE = EnCheck.browserName.indexOf("IE") > -1;      //是否IE浏览器

        if (isIE) {
            var swf = new ActiveXObject('ShockwaveFlash.ShockwaveFlash');
            if (swf) {
                hasFlash = 1;
                VSwf = swf.GetVariable("$version");
                flashVersion = parseInt(VSwf.split(" ")[1].split(",")[0]);
            }
        } else {
            if (navigator.plugins && navigator.plugins.length > 0) {
                swf = navigator.plugins["Shockwave Flash"];
                if (swf) {
                    hasFlash = 1;
                    var words = swf.description.split(" ");
                    for (var i = 0; i < words.length; ++i) {
                        if (isNaN(parseInt(words[i]))) continue;
                        flashVersion = parseInt(words[i]);
                    }
                }
            }
        }
        return {isFlash: hasFlash, version: flashVersion};
    },
    network: function () {
        var startTime = new Date().getTime();
        var testImg = '<img  id="netTestImg" alt="测试图片" width=0 height=0 src="/web-static/proExam/images/test-network.jpg"  onload="EnCheck.testNetWork(' + startTime + ');">';
        $('body').append(testImg);
    },
    testNetWork: function (startTime) {
        var arr = [50, 150, 300, 500, 800];
        var filesize = 35.4;    //测试图片的大小，用KB单位来表示;
        var et = new Date();
        var speed = Math.round(filesize * 1000) / (et - startTime);
        var scope = (speed > 0 && speed <= 50) ? 0 : (speed > 50 && speed <= 150) ? 1 : (speed > 150 && speed <= 300) ? 2 : (speed > 300 && speed <= 500) ? 3 : 4;

        if (arr[scope] === 50) {
            $('#netTestImg').remove();
            return false;
        } else {
            $('#netTestImg').remove();
            return true;
        }
    },
    audioCheck: function (dom, audioPath, bt1, bt2) {
        PEMO.DIALOG.confirmL({
            content: dom,
            closeBtn: 0,
            skin: 'pe-layer-confirm pe-layer-has-tree audio-check-dialog',
            area: ["342", "180"],
            btn: ["我听到了", "听不到声音"],
            btn1: bt1,
            btn2: bt2,
            end: function () {
                videojs = {};
                $('#peAudioPlayer').remove();
            },
            success: function () {
                $('.audio-check-dialog').css('left', ($(window).width() / 2 - 242) + 'px');
                var dialogLeft = $('.audio-check-dialog').offset().left;
                var volumnLeft = $('.volumn-control-panel').position().left;
                var allVolumnLeft = parseInt(dialogLeft, 10) + parseInt(volumnLeft, 10);
                $('body').delegate('.audio-check-btn', 'click', function () {
                    // PEMO.AUDIOPLAYER(audioPath,null,true)
                    var $testAudioDom = $('#audioTest');
                    $testAudioDom.attr('src', audioPath);
                    $testAudioDom.get(0).play();
                    $('.audio-stream-dance').show();
                });
                $('body').delegate('.volumn-control-panel', 'click', function (e) {
                    var e = e || window.event;
                    e.stopPropagation();
                    var thisClickX = parseInt(e.clientX);
                    var dialogLeft = $('.audio-check-dialog').offset().left;
                    var volumnLeft = $('.volumn-control-panel').position().left;
                    var allVolumnLeft = parseInt(dialogLeft, 10) + parseInt(volumnLeft, 10);
                    var changeSection = parseInt(thisClickX) - allVolumnLeft;
                    $('.volumn-under-progress').css('width', Math.round(changeSection / 200 * 100) + '%');
                    var audioDom = $('#audioTest').get(0);
                    if (audioDom) {
                        if (changeSection > 0 && changeSection <= 20) {
                            audioDom.volume = 0.1;
                        } else if (changeSection > 20 && changeSection <= 40) {
                            audioDom.volume = 0.3;
                        } else if (changeSection > 40 && changeSection <= 60) {
                            audioDom.volume = 0.55;
                        } else if (changeSection > 60 && changeSection <= 80) {
                            audioDom.volume = 0.8;
                        } else if (changeSection > 80 && changeSection <= 200) {
                            audioDom.volume = 1;
                        }
                    }


                });

                //向上的动画
                function audioUpAnimate(dom) {
                    var thisDom = dom;
                    $(thisDom).animate({
                        top: -40
                    }, 500, function () {
                        audioDownAnimate(thisDom);
                    });
                }

                //向下的动画
                function audioDownAnimate(dom) {
                    var thisDom = dom;
                    $(thisDom).animate({
                        top: 0
                    }, 500, function () {
                        audioUpAnimate(thisDom);
                    })
                }
            }
        })
    },
    camStateNum: 0,
    camera: function () {
        var cameraList = '';
        //检测摄像头
        if ($('#webcam').find('object').get(0)) {
            $('#webcam').html('');
        }
        var camTimes = (new Date()).getTime() + Math.floor(Math.random() * 10000);
        $("#webcam").webcam({
            width: 320,
            height: 240,
            mode: "callback",
            swffile: "/pe/web-static/proExam/carmera/jscam.swf?_t=" + camTimes, // canvas only doesn't implement a jpeg encoder, so the file is much smaller
            onTick: function (remain) {
                if (0 == remain) {
                    jQuery("#status").text("Cheese!");
                } else {
                    jQuery("#status").text(remain + " seconds remaining...");
                }
            },
            debug: function (type, string) {
                var camStartedReg = /Camera started/ig,
                    camStopReg = /Camera stopped/ig,
                    camCapturingReg = /[Capturing started | Capturing finished]/ig,
                    camErrordReg = /No camera was detected/ig;
                if (type === 'notify' && camStartedReg.test(string)) {
                    $("#webcam").removeClass('fixed').addClass('pos');
                } else if (type === 'error' && camErrordReg.test(string)) {
                    //一开始 没有摄像头 的状态
                    EnCheck.camStateNum = 2;
                    return false;
                }
            },
            onLoad: function () {
                cameraList = webcam.getCameraList();
            }
        });

        setTimeout(function () {
            if (cameraList && cameraList.length !== 0) {
                EnCheck.camStateNum = 1;
            } else {
                EnCheck.camStateNum = 2;
            }
        }, 5000)
    }
};

EnCheck.browser();
EnCheck.flash();
EnCheck.network();