<#assign ctx=request.contextPath/>
<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<div class="pe-public-top-nav-header ztj-single-monitor-header">
    <h3 class="monitor-header-title" >
        <span class="long-monitor">[监控录像]&nbsp;<span class="iconfont icon-tree-dot">
        </span>&nbsp;</span>${(examArrange.batchName)!}&nbsp;[已结束]
        <span class="floatR">考试时间:&nbsp;${(examArrange.startTime?string('yyyy-MM-dd HH:mm'))!}~${(examArrange.endTime?string('yyyy-MM-dd HH:mm'))!}</span>
    </h3>
</div>
<div class="pe-manage-content-right paper-add-accredit-wrap ztj-single-monitor-wrap monitor-video-detail-wrap">
    <div class="pe-manage-panel pe-manage-default floatL">
        <div class="top-monitor-panel over-flow-hide floatL" style="height: 70px;width: 1002px;">
            <div class="base-monitor-msg floatL">
                <div class="monitor-user-num">基本情况:&nbsp;
                    <span style="color:#444;">应到</span><span class="yellow-icon">&nbsp;${(examArrange.testCount)!'0'}&nbsp;</span>人
                    <span style="color:#444;">实到</span><span class="yellow-icon">&nbsp;${(examArrange.joinedCount)!'0'}&nbsp;</span>人
                    <span style="color:#444;">交卷</span><span class="yellow-icon">&nbsp;${(examArrange.submitCount)!'0'}&nbsp;</span>人
                </div>
                <div class="monitor-teacher">
                    监考老师:&nbsp;${(user.userName)!}
                </div>
            </div>
            <div class="pe-tree-search-wrap floatR" style="text-align: right;padding-top: 20px;">
                <a class=" fontC6 iconfont icon-monitoring-data" title="监控数据" style="cursor: pointer;font-size:18px;"></a>
                <a class=" fontC6 iconfont icon-view-screenshots" style="cursor: pointer;margin-left: 20px;font-size:18px;" title="查看截图"></a>
            </div>
        </div>
        <div class="record-total-clas floatR">
            共<span class="record-total-span"></span>节录像
        </div>
        <div class="monitor-camera-wrap">
            <div class="camera-show-area floatL" style="width: 1000px;">
                <#--<video id="video" width="100%" height="100%" style="object-fit:fill;" controls></video>-->
            </div>
            <div class="floatR swiper-container-wrap">
                <div class="swiper-carousel-top-btn disabled">
                    <a class="iconfont icon-thin-arrow-up"></a>
                </div>
                <div class="swiper-container" style="height: 600px!important;">
                    <div class="swiper-wrapper">
                    </div>
                </div>
                <div class="swiper-carousel-bottom-btn">
                    <a class="iconfont icon-thin-arrow-down"></a>
                </div>
            </div>

        </div>
    </div>
</div>
<div class="pe-btns-group-wrap clear" style="text-align:center;">
    <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-next">关闭页面</button>
</div>
<div id="imageUrl"></div>
<script src="${resourcePath!}/web-static/proExam/js/plugins/dist/peer.js"></script>
<script type="text/template" id="videoTemp">
    <%_.each(data,function(monitorData,index){%>
    <div class="swiper-slide <%if (index === 0) {%>active-nav<%}%>" style="">
        <div class="video-item">
            <span class="swiper-slide-tip"><%=index+1%></span>
            <img src="<%=monitorData.coverPath%>" data-url="<%=monitorData.filePath%>" width="100%" height="100%"
                 style="cursor: pointer;">
            <span class="swiper-slide-msg"><%=monitorData.fileName%></span>
        </div>
    </div>
    <%});%>
</script>
<script type="text/template" id="playVideoTemp">
    <video id="peVideoPlayer" class="video-js vjs-default-skin" poster="<%=coverPath%>"  style="object-fit:fill;" controls preload="auto" width="1000" height="660">
            <source src="<%=videoPath%>" type="video/webm"/>
    </video>
</script>
<script type="text/template" id="browserLowerTemp">
    <div class="browser-dialog-wrap" style="margin-top: 150px;width: 410px;">
        <div style="text-align: center;">
            <img src="${resourcePath}/web-static/proExam/images/monitor_disable.png" style="width: 120px;height: 90px;">
        </div>
        <p class="browser-dialog-bq">抱歉</p>
        <p class="browser-dialog-name">您当前的浏览器不支持监控视频播放功能！</p>
        <p class="browser-dialog-content" style="color: #bbb;">浏览器监控播放支持Chrome35.0和Firefox30.0以上版本的浏览器</p>
    </div>
</script>
<script>
    $(function () {
        var monitorDetailConsole = {
            arrangeId: '${(examArrange.id)!}',
            userId: '${(user.id)!}',
            peerOpen: false,
            canPlay:true,
            init: function () {
                var _this = this;
                _this.bind();
                _this.initData();
            },

            bind: function () {
                var _this = this;
                $('.pe-step-next-btn').on('click', function () {
                    window.close();
                });

                $('.swiper-wrapper').delegate('img', 'click', function () {
                    $('.swiper-slide').removeClass('active-nav');
                    _this.playVideo($(this).data('url'),$(this).attr('src'));
                    $(this).parents('.swiper-slide').addClass('active-nav');
                });

                $('.icon-monitoring-data').on('click', function () {
                    window.open(pageContext.rootPath + '/ems/examMonitor/manage/initMonitorDetailPage?arrangeId=' + _this.arrangeId);
                });
                $('.icon-view-screenshots').on('click', function () {
                    window.open(pageContext.rootPath + '/ems/examMonitor/manage/initPrintScreenPage?arrangeId=' + _this.arrangeId + '&userId=' + _this.userId);
                });
            },

            checkBrowser:function () {
                var firBrowserReg = /FIREFOX_\d/ig;
                var chromeBrowserReg = /CHROME_\d/ig;
                if(EnCheck.browserName && EnCheck.browserNum && ((firBrowserReg.test(EnCheck.browserName) && EnCheck.browserNum >= 30)
                        || (chromeBrowserReg.test(EnCheck.browserName) && EnCheck.browserNum >= 35))){
                    return true;
                }

                $('.camera-show-area').addClass('camera-no-support-area');
                $('.camera-show-area').html(_.template($('#browserLowerTemp').html())({}));
                $('.icon-screenshot').attr('disabled','disabled');
                $('.icon-screenshot').css('color','#cbcbcb');
                return false;
            },

            playVideo:function (videoPath,coverPath) {
                if(!monitorDetailConsole.canPlay){
                    $('.camera-show-area').addClass('camera-no-support-area');
                    $('.camera-show-area').html(_.template($('#browserLowerTemp').html())({}));
                    return false;
                }

                $('#peVideoPlayer').remove();
                $('.camera-show-area').html(_.template($('#playVideoTemp').html())({videoPath:videoPath,coverPath:coverPath}));
                videojs(document.getElementById('peVideoPlayer'), {muted:true},function () {
                    $('#peVideoPlayer').css('position','absolute');
                    $('.vjs-poster').css('position','initial');
                    $('.vjs-fullscreen-control').css('visibility','visible');
                });
            },

            swiperOpt:{
                singleDis:0,
                maxLength:0,
                maxDistance:0
            },
            initData: function () {
                var _this = this;
                _this.canPlay = _this.checkBrowser();
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/examMonitor/manage/listMonitorVideo',
                    data: {'arrangeId': _this.arrangeId, 'userId': _this.userId},
                    success: function (data) {
                        $('.record-total-span').text(data.length);
                        if (!data || data.length <= 0) {
                            return false;
                        }

                        _this.playVideo(data[0].filePath,data[0].coverPath);
                        $('.swiper-wrapper').html(_.template($('#videoTemp').html())({data: data}));
                        var mySwiper = new Swiper('.swiper-container', {
                            paginationClickable: true,
                            mode: 'vertical',
                            slidesPerView: 6,
                            loop: false,
                            speed: 1000,
                            loopedSlides: 6,
                            loopAdditionalSlides: 6,
                            slidesPerGroup: 6,
                            mousewheelControl:true,
                            prevButton:'.swiper-carousel-top-btn',
                            nextButton:'.swiper-carousel-bottom-btn',
                            onFirstInit:function(){
                               /*最大可滑行距离*/
                               _this.singleDis = 100,
                               _this.maxLength = $('.swiper-wrapper .swiper-slide').length,
                               _this.maxDistance = (_this.maxLength - 6)*100;//最大可以滑动的距离
//                                console.log('thjsmaxDistance',_this.maxDistance);
                                if(_this.maxLength <= 6){
                                    $('.swiper-carousel-bottom-btn').addClass('disabled');
                                }
                            },
                            onSlideNext:function(){
                                if(_this.maxLength > 6){
                                    $('.swiper-carousel-top-btn').removeClass('disabled');
                                }
                                setTimeout(function(){
                                    if(Math.abs(mySwiper.getWrapperTranslate('y')) >= Math.abs(_this.maxDistance)){
                                        $('.swiper-carousel-bottom-btn').addClass('disabled');
                                    }
                                },1000);
                            },
                            onSlidePrev:function(){
                                setTimeout(function(){
//                                    console.log('mySwoperLOng',mySwiper.getWrapperTranslate('y'));
//                                    console.log('maxDistance',_this.maxDistance);
                                    if((Math.abs(mySwiper.getWrapperTranslate('y')) > 0) && (Math.abs(mySwiper.getWrapperTranslate('y')) <= Math.abs(_this.maxDistance))){
                                        $('.swiper-carousel-bottom-btn').removeClass('disabled');
                                    }
                                    if(Math.abs(mySwiper.getWrapperTranslate('y')) == 0){
                                        $('.swiper-carousel-top-btn').addClass('disabled');
                                    }
                                },1000);
                            }
                        });

                        $('.swiper-carousel-top-btn').on('click', function (e) {
                            mySwiper.swipePrev();
                        });

                        $('.swiper-carousel-bottom-btn').on('click', function (e) {
                            mySwiper.swipeNext();
                        });
                    }
                })
            }
        };

        monitorDetailConsole.init();
    });
</script>
</@p.pageFrame>