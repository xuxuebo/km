<#assign ctx=request.contextPath/>
<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<div class="pe-public-top-nav-header ztj-single-monitor-header">
    <h3 class="paper-add-accredit-title">[实时监控] ${(examArrange.batchName)!}
        <span class="floatR">当前时间:&nbsp;<span class="current-time-span">${(nowTime?string('yyyy-MM-dd'))!}</span></span>
    </h3>
</div>
<div class="pe-manage-content-right paper-add-accredit-wrap ztj-single-monitor-wrap">
    <div class="pe-manage-panel pe-manage-default" style="min-height:647px;border:none;">
        <div class="top-monitor-panel over-flow-hide">
            <div class="base-monitor-msg floatL">
                <div class="monitor-user-num">基本情况:&nbsp;
                    <span style="color:#444;">应到</span><span class="yellow-icon">&nbsp;${(examArrange.testCount)!'0'}&nbsp;</span>人
                    <span style="color:#444;">实到</span><span class="yellow-icon">&nbsp;${(examArrange.joinedCount)!'0'}&nbsp;</span>人
                    <span style="color:#444;">交卷</span><span class="yellow-icon">&nbsp;${(examArrange.submitCount)!'0'}&nbsp;</span>人
                </div>
                <div class="monitor-teacher">监考老师:&nbsp;
                ${(user.userName)!}
                </div>
            </div>

            <div class="pe-tree-search-wrap floatR">
                <input class="pe-tree-form-text" type="text" placeholder="通知监考老师" maxlength="50" name="message">
                <button type="button" class="sent-btn pe-btn pe-btn-blue">发送</button>
            </div>
            <div class="pe-tree-search-wrap floatR" style="margin-right:10px;">
                <a class=" fontC6 iconfont icon-monitoring-data" title="监控数据" style="cursor: pointer" data-id="${(examArrange.id)!}"></a>
                <a class=" fontC6 iconfont icon-view-screenshots" style="cursor: pointer;margin-left: 20px;" title="查看截图" data-id="${(examArrange.id)!}"></a>
            </div>
        </div>
        <div class="monitor-camera-wrap">
            <div class="camera-show-area">
                <video id="video" autoplay width="100%" height="100%" controls style="object-fit:fill;"></video>
            </div>
            <#--<div class="monitor-item-name">${(examArrange.batchName)!}</div>-->
        </div>
    </div>
    <div class="cut-camera-img-wrap">
        <div class="iconfont icon-screenshot"></div>
        截图存档
    </div>
</div>
<div class="pe-btns-group-wrap" style="text-align:center;">
    <button type="button" class="pe-btn pe-btn-blue pe-step-next-btn save-next">关闭页面</button>
</div>
<div id="imageUrl"></div>
<script src="${resourcePath!}/web-static/proExam/js/plugins/dist/peer.js"></script>
<script type="text/template" id="cutImgTemp">
    <div class="monitor-cut-img-wrap">
        <div class="monitor-cut-img">
            <img src="<%=data.src%>" height="100%" width="100%" alt="" />
        </div>
        <#--<div class="cut-img-tip"><span class="iconfont icon-right"></span>裁图成功</div>-->
        <label class="floatL" style="margin-top: 20px">
            <span class="pe-label-name floatL" style="width:38px;text-align:left;line-height:40px;">备注:</span>
            <input class="pe-stand-filter-form-input" autocomplete="off" type="text" placeholder="添加备注" name="cutImgTipText" maxlength="50" style="width: 462px;box-sizing:border-box;">
        </label>
    </div>
</script>
<script type="text/template" id="browserLowerTemp">
    <div class="browser-dialog-wrap" style="margin-top: 150px;">
        <div style="text-align: center;">
            <img src="${resourcePath}/web-static/proExam/images/monitor_disable.png" style="width: 100px;height: 83px;">
        </div>
        <p class="browser-dialog-bq">抱歉</p>
        <p class="browser-dialog-name">您当前的浏览器不支持视频监控功能！</p>
        <p class="browser-dialog-content" style="color: #bbb;">浏览器监控支持Chrome35.0和Firefox30.0以上版本的浏览器</p>
    </div>
</script>
<script>
    $(function () {
        var monitorDetailConsole = {
            arrangeId: '${(examArrange.id)!}',
            userId: '${(user.id)!}',
            peerOpen : false,
            init: function () {
                var _this = this;
                _this.bind();
                _this.initData();
            },

            bind: function () {
                $('.cut-camera-img-wrap').on('click',function () {
                    if($('.icon-screenshot').attr('disabled')){
                        return false;
                    }

                    if(!monitorDetailConsole.peerOpen){
                        PEMO.DIALOG.tips({
                            content: '对方已经断线，请及时联系监考考试并且刷新本页面',
                            time: 1500,
                            scrollbar:true
                        });

                        return false;
                    }

                    var video = $('#video').get(0);
                    var canvas = document.createElement("canvas");
                    canvas.width = video.videoWidth * 0.5;
                    canvas.height = video.videoHeight * 0.5;
                    canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);
                    var dataUrl = canvas.toDataURL();
                    PEMO.DIALOG.confirmR({
                        content:_.template($('#cutImgTemp').html())({data:{"src":dataUrl}}),
                        area:['600px'],
                        skin: 'pe-layer-confirmA monitor-cut-dialog',
                        btn: ['取消','保存'],
                        scrollbar:true,
                        btn2:function(){
                            PEBASE.ajaxRequest({
                                url : pageContext.rootPath + '/ems/examMonitor/manage/uploadPrintImage',
                                data:{'arrangeId':monitorDetailConsole.arrangeId,userId:monitorDetailConsole.userId,comment:$('input[name="cutImgTipText"]').val(),dataUrl:dataUrl},
                                success:function (data) {
                                    if(data.success){
                                        layer.closeAll();
                                        PEMO.DIALOG.tips({
                                            content: '截屏成功',
                                            time: 1500,
                                            scrollbar:true
                                        });
                                    }
                                }
                            })
                        }
                    });
                });

                $('.pe-step-next-btn').on('click', function () {
                    window.close();
                });

                $('.top-monitor-panel').delegate('.icon-monitoring-data', 'click', function () {
                    var id = $(this).data('id');
                    window.open(pageContext.rootPath + '/ems/examMonitor/manage/initMonitorDetailPage?arrangeId=' + id);
                });

                $('.top-monitor-panel').delegate('.icon-view-screenshots', 'click', function () {
                    var id = $(this).data('id');
                    window.open(pageContext.rootPath + '/ems/examMonitor/manage/initPrintScreenPage?arrangeId=' + id);
                });

                $('.sent-btn').on('click', function () {
                    if(!monitorDetailConsole.peerOpen){
                        PEMO.DIALOG.tips({
                            content: '对方已经断线，请及时联系监考考试并且刷新本页面',
                            time: 1500,
                            scrollbar:true
                        });

                        return false;
                    }

                    var message = $('input[name="message"]').val();
                    if (!message) {
                        PEMO.DIALOG.tips({
                            content: '请输入要通知的信息',
                            time: 1500
                        });

                        return false;
                    }

                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/examMonitor/manage/sendMessage',
                        data: {
                            message: message,
                            arrangeId: monitorDetailConsole.arrangeId,
                            userId: monitorDetailConsole.userId
                        },
                        success:function (data) {
                            if(data.success){
                                $('input[name="message"]').val('');
                                PEMO.DIALOG.tips({
                                    content: '发送成功',
                                    time: 1500
                                });
                            }
                        }
                    })
                });
            },

            initData: function () {
                var _this = this;
                var valid =  _this.checkBrowser();
                if(valid){
                    _this.openCarame();
                }

                var nowDate = new Date('${(nowTime?string('yyyy-MM-dd HH:mm:ss'))!}');
                setInterval(function () {
                    nowDate.setSeconds(nowDate.getSeconds() + 1);
                    $('.current-time-span').text(moment(nowDate).format('YYYY-MM-DD HH:mm:ss'));
                }, 1000);
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
            openCarame: function () {
                var videoId = 'video';
                var serverId = monitorDetailConsole.arrangeId + '_' + monitorDetailConsole.userId;
                var clientId = monitorDetailConsole.userId + '_' + (new Date().getTime()) + '_' + (Math.random().toString()).split('.')[1];
                var peer = new Peer(clientId, {
                    host: 'rec.veln.cn',
                    config: {
                        "iceServers": [{
                            "url": "turn:rec.veln.cn",
                            "username": "veln",
                            "credential": "veln-bek-pass"
                        }]
                    },
                    port: 443
                });

                var conn = peer.connect(serverId);
                conn.on('open', function () {
                    conn.send(clientId);
                });

                peer.on('call', function (call) {
                    call.answer();
                    call.on('stream', function (remoteStream) {
                        var video = document.getElementById(videoId);
                        if (window.URL) {
                            video.src = window.URL.createObjectURL(remoteStream);
                        } else {
                            video.src = remoteStream;
                        }

                        monitorDetailConsole.peerOpen = true;
                    });

                    call.on('close', function () {
                        monitorDetailConsole.peerOpen = false;
                    });
                });
            }
        };

        monitorDetailConsole.init();
    });
</script>
</@p.pageFrame>