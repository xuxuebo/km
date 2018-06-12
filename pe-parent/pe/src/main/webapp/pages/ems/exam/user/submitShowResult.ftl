<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zn-CH">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>${(titleName)!'博易考'}登录</title>
    <link rel="shortcut icon" href="${(resourcePath+icoUrl)!'${resourcePath!}/web-static/proExam/images/pe_ico_32.ico'}" type="image/x-icon" />
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
<#--<link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css" type="text/css">-->
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/user.css?_v=${(resourceVersion)!}" type="text/css">
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/sonic.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js?_v=${(resourceVersion)!}"></script>
</head>
<body class="exam-submit-wrap">
<#--公用头部-->
<div class="pe-public-top-nav-header" data-id="">
    <div class="pe-top-nav-container">
        <ul class="clearF">
            <li class="pe-logo floatL">${(exam.examName)!}</li>
        </ul>
    </div>
</div>
<div class="pe-submit-wrapper">
    <div class="pe-submit-contain">
        <div style="position: relative;width: 60px;margin: 0 auto;display:none;">
        </div>
    </div>
    <div class="pe-submit-content rec-get-score-wrap">
        <div class="exam-success" style="display:none;">
            <div class="exam-score-panel" >
                <span class="score-num">0</span>分
            </div>
            <div class="exam-tips">恭喜您通过考试。</div>
        </div>
        <div class="waite-tips" >
            <div class="loading-wrap"></div>
            <div style="font-size:20px;padding-top:30px;">正在评卷中，请稍等...</div>
        </div>
        <div class="pe-submit-btn">
        <#if openTab??&&openTab>
            <button type="button" style="font-size:16px;margin:0 auto;"
                    class="pe-btn pe-btn-blue pe-submit-close pe-large-btn">返回首页
            </button>
        <#else>
            <button type="button" style="font-size:16px;margin:0 auto;"
                    class="pe-btn pe-btn-blue pe-submit-close pe-large-btn">关闭页面
            </button>
        </#if>
        </div>
    </div>
</div>
</body>
<script>
    $(function () {
        var openTab = '${(openTab?string('true','false'))!}';
        if(!openTab || openTab === 'false'){
            window.opener.location.reload();
        }

        var submitExam = {
            examId: '${(exam.id)!}',
            interval: '',
            init: function () {
                var _this = this;
                _this.bind();
                _this.initData();
            },
            initData: function () {
                var shouldBeHeight = $(window).height()-64-55 -145 + 5; //64为头部的高度，55是pe-submit-contain的marginTop，145是rec-get-score-wrap的paddingBottom ,4是弥补marginTop负4;
                $('.pe-submit-contain').height($(window).width() / 4.19);//5.16为背景图片的长宽比例;
                $('.rec-get-score-wrap').height(shouldBeHeight - ($(window).width() / 4.19) );
                submitExam.interval = setInterval(submitExam.processExamResult, 3000);
                if(history.pushState){
                    history.pushState(null, null, document.URL);
                    window.addEventListener('popstate', function () {
                        history.pushState(null, null, document.URL);
                    });
                }
            },
            bind: function () {
                $(window).resize(function(){
                    var shouldBeHeight = $(window).height()-64-55 -145 + 5;
                    $('.pe-submit-contain').height($(window).width() / 4.19);//5.16为背景图片的长宽比例;
                    $('.rec-get-score-wrap').height(shouldBeHeight - ($(window).width() / 4.19) );
                    if($('.rec-exam-submit-wrap .layui-layer-loading').get(0)){
                        $('.rec-exam-submit-wrap .layui-layer-loading').css('top',($(window).width() / 4.19) - 55 +150);
                        $('.rec-exam-submit-wrap .layui-layer-loading').css('left',($(window).width()/2 - 16));
                    }

                });

                $('.pe-submit-close').on('click', function () {
                    if(!openTab || openTab === 'false'){
                        window.close();
                    } else {
                        location.replace('${ctx!}/front/initPage');
                    }
                });

                /*canvas的loading代码*/
                var aLoading, loaders = [
                    {
                        width: 100,
                        height: 100,

                        stepsPerFrame: 1,
                        trailLength: 1,
                        pointDistance: .02,
                        fps: 30,

                        fillColor: '#199ae2',

                        step: function(point, index) {

                            this._.beginPath();
                            this._.moveTo(point.x, point.y);
                            this._.arc(point.x, point.y, index * 7, 0, Math.PI*2, false);
                            this._.closePath();
                            this._.fill();

                        },
                        path: [
                            ['arc', 50, 50, 30, 0, 360]
                        ]
                    }
                ];
                aLoading = new Sonic(loaders[0]);
                $('.loading-wrap').append(aLoading.canvas);
                aLoading.play();
            },
            processExamResult: function () {
                PEBASE.ajaxRequest({
                    url: '${ctx!}/ems/examResult/client/getExamResult?_t=' + new Date().getMilliseconds(),
                    data: {examId: submitExam.examId},
                    success: function (data) {
                        if (!data) {
                            $('.exam-success').hide();
                            $('.waite-tips').show();
                            return false;
                        }

                        $('.waite-tips').hide();
                        $(".exam-success").show();
                        layer.closeAll('loading');
                        $("span.score-num").text(Number(data.score).toFixed(1));
                        if (!data.pass) {
                            $(".exam-tips").text("很遗憾,本次考试未通过，请再接再厉！");
                            $("span.score-num").attr("style", "color:#fc4e51");
                        }

                        clearInterval(submitExam.interval);
                    }
                });
            }
        };
        submitExam.init();

    });
</script>
</html>
