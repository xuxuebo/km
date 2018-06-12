<#assign ctx=request.contextPath/>
<#import "../../noNavTop.ftl" as p>
<@p.pageFrame>
<div class="pe-public-top-nav-header">
    <div class="pe-detail-top-head over-flow-hide">
        <div class="pe-top-nav-container monitor-top-nav-detail">
            监控详情&emsp;${(exam.examName)!}&nbsp;<em class="pe-monitor-status">[<#if exam.status == 'PROCESS'>
            考试中<#else>已结束</#if>]</em>
        </div>
    </div>
</div>
<div class="pe-main-wrap">
    <div class="pe-main-content monitor-main-wrap">
        <div class="ztj-monitor-detail-wrap" <#if !(exam.examType?? && exam.examType == 'ONLINE' && canMonitor?? && canMonitor)>
             style="height: 134px;" </#if>>
            <#if exam.examType?? && exam.examType == 'ONLINE' && canMonitor?? && canMonitor>
                <div class="monitor-camera-panel ztj-m-d-left floatL pos"
                     style="position: absolute;z-index: 9999;top: 0;">
                    <video id="video" autoplay width="100%" height="100%"></video>
                </div>
            </#if>
                <div class="ztj-m-d-right <#if exam.examType?? && exam.examType == 'ONLINE' && canMonitor?? && canMonitor>floatR"<#else>"
            style="width: 1198px;"</#if>>
            <#if exam.examType?? && exam.examType == 'ONLINE' && canMonitor?? && canMonitor>
                <div class="monitor-tip-panel">
                    <span class="tip-mask-panel"></span>
                    <div class="monitor-states tip-mask-panel monitor-ing">
                        <div class="ing-waves">
                            <div class="item loading2"></div>
                            <div class="item loading3"></div>
                            <div class="item loading1"></div>
                        </div>
                        正在摄像监控
                    </div>
                    <div class="monitor-tip-text">
                        <div class="swiper-container">
                            <div class="swiper-wrapper">

                            </div>
                        </div>

                    </div>
                </div>
            </#if>
            <div class="pe-manage-panel-head">
                <form id="examManageForm">
                    <input type="hidden" name="exam.id" value="${(exam.id)!}"/>
                    <input type="hidden" name="examArrange.id" value="${(examArrange.id)!}"/>
                    <input type="hidden" name="examArrange.exam.id" value="${(examArrange.exam.id)!}"/>
                    <input type="hidden" name="user.organize.id" value=""/>
                    <input type="hidden" name="user.positionId" value=""/>
                    <div class="pe-stand-filter-form">
                        <div class="pe-stand-form-cell">
                            <label class="pe-form-label floatL" for="peMainKeyText">
                                <span class="pe-label-name floatL">关键字:</span>
                                <input id="peMainKeyText" class="pe-stand-filter-form-input" type="text"
                                       placeholder="姓名/用户名/工号/手机号" name="user.keyword">
                            </label>
                            <div class="" style="margin-right:20px;">
                                <span class="pe-label-name floatL" style="margin-right:5px;">部&emsp;门:</span>
                                <div class="pe-organize-tree-wrap pe-input-tree-wrap pe-stand-filter-form-input">
                                    <input class="pe-tree-show-name show-organize-name" value=""
                                           name="organizeName"/>
                                    <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                                    <div class="pe-select-tree-wrap  pe-input-tree-wrap-drop" style="display:none;">
                                        <div class="node-search-empty">暂无该关键字相关信息</div>
                                        <ul id="organizeTree" class="ztree pe-tree-container"></ul>
                                    </div>
                                </div>
                            </div>
                            <button type="button"
                                    class=" floatR pe-btn pe-btn-blue pe-question-choosen-btn exam-manage-choosen-btn floatL">
                                筛选
                            </button>
                        </div>
                        <div class="pe-stand-form-cell">
                            <div class="floatL" style="margin-right:29px;">
                                <span class="pe-label-name floatL">岗&emsp;位:</span>
                                <div class="pe-position-tree-wrap pe-input-tree-wrap pe-stand-filter-form-input">
                                    <input class="pe-tree-show-name show-position-name" value=""
                                           name="positionName"/>
                                    <span class="pe-input-tree-search-btn input-icon iconfont icon-class-tree"></span>
                                    <div class="pe-select-tree-wrap  pe-input-tree-wrap-drop" style="display:none;">
                                        <div class="node-search-empty">暂无该关键字相关信息</div>
                                        <ul id="positionTree" class="ztree pe-tree-container"></ul>
                                    </div>
                                </div>
                            </div>
                            <dl class="over-flow-hide">
                                <dt class="pe-label-name floatL">状&emsp;态:</dt>
                                <dd class="pe-stand-filter-label-wrap">
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                    <#--右侧头部筛选的checkbox框，name还没定义，判断是否选中，用.prop('checked')是否为true-->
                                        <input id="peFormEleStart" class="pe-form-ele" checked="checked"
                                               type="checkbox"
                                               name="answerStatuses" value="NO_ANSWER"/>未作答
                                    </label>
                                    <label class="floatL pe-checkbox" for="" style="margin-right:15px;">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleDraft" class="pe-form-ele" checked="checked"
                                               type="checkbox"
                                               name="answerStatuses" value="ANSWERING"/>正在作答
                                    </label>
                                    <label class="floatL pe-checkbox" for="">
                                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                                        <input id="peFormEleStop" class="pe-form-ele" checked="checked"
                                               type="checkbox"
                                               name="answerStatuses" value="SUBMIT_EXAM"/>已交卷
                                    </label>
                                </dd>
                            </dl>
                        </div>
                    </div>
            </div>
        </div>
    </div>
    </form>
</div>
<div class="pe-manage-panel pe-manage-default pe-ztj-table-wrap">
    <div class="pe-stand-table-panel">
        <div class="pe-stand-table-top-panel">
            <button type="button" class="pe-btn pe-btn-green create-online-btn notice-user">提醒学员</button>
            <#if !((exam.subject?? && exam.subject) || (exam.markUpId??)) && !(exam.enableTicket?? && exam.enableTicket)>
                <button type="button"
                        class="pe-btn pe-btn-white comprehensive-btn creat-offline-btn add-user">添加考生
                </button>
            </#if>
            <#if exam.examType?? && exam.examType == 'ONLINE' && canMonitor?? && canMonitor>
                <button type="button"
                        class="pe-btn pe-btn-white comprehensive-btn creat-offline-btn upload-record-cla">结束并上传录像
                </button>
            </#if>
            <span class="pe-monitor-icon" title="刷新数据" style="cursor: pointer;">
                                        <i class="iconfont icon-renovate pe-monitor-refresh"></i>
                                    </span>
            <div class="pe-monitor-tip">应到<span class="pe-monitor-num">${(joinNum)!}</span>人，实到<span class="pe-monitor-num">${(joinedNum)!}</span>人</div>
        </div>
    <#--表格包裹的div-->
        <div class="pe-stand-table-main-panel">
            <div class="pe-stand-table-wrap"></div>
            <div class="pe-stand-table-pagination"></div>
        </div>
    </div>
</div>
</div>
<script type="text/template" id="downBrowserTemp">
    <span class="iconfont icon-warning-sign"></span>
    <p>当前浏览器不支持视频监控功能！</p>
    <div class="no-support-tip-wrap" style="color: #c8c8c8;">
        浏览器监控支持Chrome35.0和Firefox30.0以上版本的浏览器
        <#--<button type="button" class="down-browser-btn">下载浏览器</button>-->
        <#--<span class="iconfont icon-tip" title=""></span>-->
        <#--<div class="tip-panel"><div style="position:relative;"><i class="tip-arrow"></i><i class="tip-arrow up"></i>浏览器监控支持Chrome35.0和Firefox30.0以上版本的浏览器，如有需要，请下载浏览器！</div></div>-->
    </div>
</script>
<script type="text/template" id="browserLowerTemp">
    <div class="monitor-browwer-lower-wrap"><span class="iconfont icon-small-dot floatL"></span>监控摄像无法正常使用</div>
</script>
<script type="text/template" id="browserLowerDialogTemp">
    <div class="browser-dialog-wrap">
        <div style="text-align: center;">
            <img src="${resourcePath}/web-static/proExam/images/monitor_disable.png" />
        </div>
        <p class="browser-dialog-bq">抱歉</p>
        <p class="browser-dialog-name">您当前的浏览器不支持视频监控功能！</p>
        <p class="browser-dialog-content">浏览器监控支持Chrome35.0和Firefox30.0以上版本的浏览器</p>
    </div>
</script>
<script type="text/template" id="peExamManaTemp">
    <table class="pe-stand-table pe-stand-table-default">
        <thead>
        <tr>
            <%for(var i =0,lenI = peData.tableTitles.length;i
            <lenI ;i++){%>
                <%if(peData.tableTitles[i].title==='checkbox'){%>
                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <label class="pe-checkbox pe-paper-all-check">
                        <span class="iconfont icon-unchecked-checkbox"></span>
                        <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheckAll"/>
                    </label>
                </th>
                <%}else{%>

                <th style="width:<%=peData.tableTitles[i].width?peData.tableTitles[i].width+'%':'auto'%>">
                    <%if(peData.tableTitles[i].order){%>
                    <div class="pe-th-wrap" data-type="startTime">
                        <%=peData.tableTitles[i].title%>
                        <span class="pageSize-arrow level-order-up iconfont icon-pageUp"
                              style="position:absolute;"></span>
                        <span class="pageSize-arrow level-order-down iconfont icon-pageDown"
                              style="position:absolute;"></span>
                    </div>
                    <%}else{%>
                    <%=peData.tableTitles[i].title%>
                    <%}%>
                </th>
                <%}%>
                <%}%>
        </tr>
        </thead>
        <tbody>
        <%if(peData.rows.length !== 0){%>
        <%_.each(peData.rows,function(examMonitor){%>
        <tr>
            <td><label class="floatL pe-checkbox" for="" data-id="<%=examMonitor.user.id%>">
                <span class="iconfont icon-unchecked-checkbox"></span>
                <input class="pe-form-ele" value="ENABLE" type="checkbox" name="paperCheck"/>
            </label>
            </td>
            <%if (peData.tableTitles[1].name === 'ticket') {%>
            <td title="<%=examMonitor.ticket%>"><%=examMonitor.ticket%></td>
            <%}%>
            <td>
                <div class="pe-ellipsis" title="<%=examMonitor.user.loginName%>"><%=examMonitor.user.loginName%>
            </td>
            <td>
                <div class="pe-ellipsis" title="<%=examMonitor.user.userName%>"><%=examMonitor.user.userName%></div>
            </td>
            <td><%=examMonitor.examTime?moment(examMonitor.examTime).format('YYYY-MM-DD HH:mm:ss'):'--'%></td>
            <td><%=examMonitor.submitTime?moment(examMonitor.submitTime).format('YYYY-MM-DD HH:mm:ss'):'--'%></td>
            <td><%=PEBASE.formatSecond(examMonitor.duration)%></td>
            <td><%=examMonitor.exitTimes%></td>
            <td><%=examMonitor.cutScreenCount%></td>
            <td><%=examMonitor.illegalCount%></td>
            <td>
                <%if(examMonitor.answerStatus === 'ANSWERING'){%>
                <div class="pe-stand-table-btn-group">
                    <a title="违纪处理" class="break_rule_btn pe-btn pe-icon-btn iconfont icon-handling-discipline"
                       data-id="<%=examMonitor.id%>">
                    </a>
                    <a title="强制交卷" class="pe-btn pe-icon-btn iconfont icon-forced-assignment"
                       data-arrangeId="<%=examMonitor.id%>" data-user="<%=examMonitor.user.id%>"></a>
                    <a class="stop-btn pe-icon-btn iconfont icon-view-detail" target="_blank"
                       href="${ctx!}/ems/examMonitor/manage/initDetail?examId=${(exam.id)!}&userId=<%=examMonitor.user.id%>"
                       title="查看详情"></a>
                    <%}else if(examMonitor.answerStatus ==='SUBMIT_EXAM'){%>
                    <div class="pe-stand-table-btn-group">
                        <a title="删除试卷" class="pe-btn pe-icon-btn iconfont icon-delete"
                           data-arrangeId="<%=examMonitor.id%>" data-user="<%=examMonitor.user.id%>"></a>
                        <a class="stop-btn pe-icon-btn iconfont icon-view-detail force-submit" target="_blank"
                           href="${ctx!}/ems/examMonitor/manage/initDetail?examId=${(exam.id)!}&userId=<%=examMonitor.user.id%>"
                           title="查看详情"></a>
                    </div>
                    <%}%>
                </div>
            </td>
        </tr>
        <%});%>
        <%} else {%>
        <tr>
            <td class="pe-td pe-stand-table-empty" colspan="<%=peData.tableTitles.length%>">
                <div class="pe-result-no-date"></div>
                <p class="pe-result-date-warn">暂无数据</p>
            </td>
        </tr>
        <%}%>
        </tbody>
    </table>
</script>
<script type="text/template" id="breakRuleTemp">
    <form id="illegalForm">
        <div style="width: 100%;">
            <ul class="over-flow-hide exam-manage-copy-ul">
                <li class="exam-dialog-copy-li" style="width: 100%;">
                    <label class="pe-radio">
                        <span class="iconfont icon-checked-radio peChecked"></span>
                        <input class="pe-form-ele" type="radio" value="STATUS"
                               checked="checked"
                               name="illegalType"/>
                        考试状态异常
                    </label>
                </li>
                <li class="exam-dialog-copy-li" style="width: 100%;">
                    <label class="pe-radio">
                        <span class="iconfont icon-unchecked-radio"></span>
                        <input class="pe-form-ele" type="radio" value="IDENTITY"
                               name="illegalType"/>
                        考生身份异常
                    </label>
                </li>
                <li class="exam-dialog-copy-li" style="width: 100%;">
                    <label class="pe-radio">
                        <span class="iconfont icon-unchecked-radio"></span>
                        <input class="pe-form-ele" type="radio" value="OTHER"
                               name="illegalType"/>
                        其他
                    </label>
                    <label>
                        <input type="text"
                               style="border: 2px solid #eaeaea;margin-left: 5px;height: 25px;width: 250px;"
                               name="illegalContent"/>
                    </label>
                </li>
            </ul>
        </div>
    </form>
</script>
<#--通知学院弹框-->
<script type="text/template" id="noteTemp">
    <form id="examTmpForm">
        <h3 style="margin-bottom:10px;font-size:14px;color:#444;margin-top:10px;">确定要发送消息提醒未作答的人参加考试么？</h3>
        <div style="width: 100%;">
            <ul class="over-flow-hide exam-manage-copy-ul">
                <li class="floatL exam-dialog-copy-li">
                    <label class="floatL pe-checkbox">
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                        <input name="msgInfos" class="pe-form-ele" type="checkbox" checked="checked"
                               value="EMAIL_MSG"/>电子邮件
                    </label>
                </li>
                <li class="floatL exam-dialog-copy-li">
                    <label class="floatL pe-checkbox" for="">
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                        <input name="msgInfos" class="pe-form-ele" type="checkbox" checked="checked"
                               value="INTERNAL_MSG"/>站内信
                    </label>
                </li>
                <li class="floatL exam-dialog-copy-li">
                    <label class="floatL pe-checkbox">
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                        <input name="msgInfos" class="pe-form-ele" type="checkbox" checked="checked"
                               value="MESSAGE_MSG"/>手机短信
                    </label>
                </li>
            </ul>
        </div>
    </form>
</script>
<#--监控通知消息小模板-->
<script type="text/template" id="monitorTipItemTemp">
    <%_.each(data,function(item,index){%>
    <div class="swiper-slide">
        <div class="monitor-tip-item">
            <div class="tip-msg-wrap" style="color: #000;">
                <span style="color:#fc4e51;">[提醒]&nbsp;</span><%=item%>
            </div>
        <#--<i class="tip-close iconfont icon-dialog-close-btn"></i>-->
        </div>
    </div>
    <%});%>
</script>
<script src="${resourcePath!}/web-static/proExam/js/plugins/dist/peer.js"></script>
<script>
    $(function () {
        var detailMonitor = {
            arrangeId: '${(arrangeId)!}',
            examId: '${(exam.id)!}',
            nowDate: new Date('${(nowDate?string("yyyy-MM-dd HH:mm:ss"))!}'),
            duration:0,//视频播放时间秒
            durationInterval:'',
            startTime:'',
            coverId:'',
            monitorInterval:'',
            onMediaCaptured: function (stream) {
                var video = document.getElementById('video');
                if (window.URL) {
                    video.src = window.URL.createObjectURL(stream);
                } else {
                    video.src = stream;
                }

                window.stream = stream;
                var mediaStream = window.stream;
                if (detailMonitor.mediaCapturedCallback) {
                    detailMonitor.mediaCapturedCallback();
                }

            },
            //获取好摄像头后执行
            initMonitorDate: function () {
                    if(window.recordRTC && window.recordRTC.state && window.recordRTC.state === 'recording'){
                        var dataUrl = detailMonitor.getImageStream();
                        PEBASE.ajaxRequest({
                            url: pageContext.rootPath + '/ems/examMonitor/manage/uploadCoverImage',
                            data: {
                                arrangeId: detailMonitor.arrangeId,
                                dataUrl: dataUrl,
                                examId: detailMonitor.examId
                            }
                        });

                        detailMonitor.countDuration();
                        detailMonitor.saveStream();
                    }
            },
            alertErrorMessage:function(){
                PEMO.DIALOG.alert({
                    content: "摄像头打开失败！请检测摄像头能否打开或者被其他设备占用，重新刷新浏览器。",
                    btn: ['我知道了'],
                    yes: function () {
                        layer.closeAll();
                    }
                })
            },
            checkTimeLimited:function(){
                var recordTime = detailMonitor.duration;//获取record
                if(recordTime<60){
                    PEMO.DIALOG.alert({
                        content: "录像小于1分钟，禁止上传！",
                        btn: ['我知道了'],
                        yes: function () {
                            layer.closeAll();
                        }
                    });
                    return false;
                }else{
                    return true;
                }
            },

            getImageStream: function () {
                var video = $('#video').get(0);
                var canvas = document.createElement("canvas");
                canvas.width = video.videoWidth * 0.5;
                canvas.height = video.videoHeight * 0.5;
                canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);
                return canvas.toDataURL();
            },

            onMediaCapturingFailed: function (error) {
                if (error.name === 'PermissionDeniedError' && !!navigator.mozGetUserMedia) {
                    InstallTrigger.install({
                        'Foo': {
                            // https://addons.mozilla.org/firefox/downloads/latest/655146/addon-655146-latest.xpi?src=dp-btn-primary
                            URL: 'https://addons.mozilla.org/en-US/firefox/addon/enable-screen-capturing/',
                            toString: function () {
                                return this.URL;
                            }
                        }
                    });
                }
            },
            uploadToServer: function (callback) {
                var blob = window.recordRTC instanceof Blob ? window.recordRTC : window.recordRTC.blob;
                var formData = new FormData();
                formData.append('uploadFile', blob);
                formData.append('startTime', moment(detailMonitor.startTime).format('YYYY-MM-DD HH:mm:ss'));
                formData.append('duration', detailMonitor.duration);
                formData.append('examArrange.id', detailMonitor.arrangeId);
                formData.append('exam.id', detailMonitor.examId);
                formData.append('coverId', detailMonitor.coverId);
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/examMonitor/manage/uploadMonitorFile',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success:function (data) {
                        if(callback && data.success){
                            $('.monitor-states').html("<div class='monitor-browwer-lower-wrap'style='color: #6c6c6c'><span class='iconfont icon-tree-dot floatL' style='color: #6c6c6c'></span>监控已关闭</div>");
                            callback();
                        }
                    }
                })
            },

            mediaCapturedCallback: function () {
                window.recordRTC = RecordRTC(window.stream, {
                    mimeType: 'video/webm\;codecs=vp9',
                    fileExtension: 'webm',
                    disableLogs: params.disableLogs || false,
                    canvas: {
                        width: params.canvas_width || 320,
                        height: params.canvas_height || 240
                    },
                    frameInterval: typeof params.frameInterval !== 'undefined' ? parseInt(params.frameInterval) : 20 // minimum time between pushing frames to Whammy (in milliseconds)
                });

                window.recordRTC.startRecording();
            },
            initParam: function () {
                var params = {},
                        r = /([^&=]+)=?([^&]*)/g;

                function d(s) {
                    return decodeURIComponent(s.replace(/\+/g, ' '));
                }

                var match, search = window.location.search;
                while (match = r.exec(search.substring(1))) {
                    params[d(match[1])] = d(match[2]);

                    if (d(match[2]) === 'true' || d(match[2]) === 'false') {
                        params[d(match[1])] = d(match[2]) === 'true';
                    }
                }

                window.params = params;
            },
            stopStream:function () {
                if(window.stream && window.stream.stop) {
                    window.stream.stop();
                    window.stream = null;
                }
            },
            saveStream: function () {
                if (!window.recordRTC) {
                    return false;
                }

                var dataUrl = detailMonitor.getImageStream();
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/examMonitor/manage/uploadEveryCoverImage',
                    data: {
                        arrangeId: detailMonitor.arrangeId,
                        dataUrl: dataUrl,
                        examId:detailMonitor.examId
                    },
                    success:function (data) {
                        detailMonitor.coverId = data.data;
                    }
                });

                setTimeout(function () {
                    window.recordRTC.stopRecording(function (url) {
                        detailMonitor.stopCountDuration();
                        detailMonitor.uploadToServer();
                        detailMonitor.countDuration();
                        window.recordRTC.startRecording();
                        detailMonitor.saveStream();
                    });
                },1000 * 60 *10 );
            },
            countDuration:function () {
                detailMonitor.duration = 0;
                detailMonitor.startTime = new Date(detailMonitor.nowDate);
                detailMonitor.durationInterval = setInterval(function () {
                    detailMonitor.duration += 1;
                }, 1000);
            },

            stopCountDuration:function () {
                if(detailMonitor.durationInterval){
                    clearInterval(detailMonitor.durationInterval);
                }
            },
            checkBrowser:function () {
                var firBrowserReg = /FIREFOX_\d/ig;
                var chromeBrowserReg = /CHROME_\d/ig;
                if(EnCheck.browserName && EnCheck.browserNum && ((firBrowserReg.test(EnCheck.browserName) && EnCheck.browserNum >= 30)
                        || (chromeBrowserReg.test(EnCheck.browserName) && EnCheck.browserNum >= 35))){
                    return true;
                }

                $('.monitor-camera-panel').removeClass('pos').addClass('monitor-no-camera-panel');
                $('.monitor-camera-panel').html(_.template($('#downBrowserTemp').html())({}));
                $('.monitor-states').html(_.template($('#browserLowerTemp').html())({}));
                $('.monitor-camera-panel').delegate('.icon-tip','mouseover',function(){
                    $(this).next('.tip-panel').fadeIn();
                });
                $('.monitor-camera-panel').delegate('.icon-tip','mouseout',function(){
                    $(this).next('.tip-panel').fadeOut();
                });

                return false;
            },
            initMonitorManage: function () {
                var serverId = '${(arrangeId)!}' + '_' + '${(userId)!}';
                var peer = new Peer(serverId, {
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

                navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;
                var constraints = {
                    audio: false,
                    video: true
                };

                navigator.getUserMedia(constraints, function (stream) {
                    detailMonitor.onMediaCaptured(stream);
                }, function (err) {
                    detailMonitor.onMediaCapturingFailed(err);
                    detailMonitor.alertErrorMessage();
                });

                peer.on('open', function (id){
                    var getCamera = true;
                    setTimeout(function () {
                        var mediaStream = window.stream;
                        var userAgent = navigator.userAgent;
                        if(userAgent.indexOf("Firefox")>-1){
                            var videoState = $("#video").get(0).readyState;
                            if(4!=videoState){
                                getCamera = false;
                                detailMonitor.alertErrorMessage();
                            }
                        }else{
                            var mediaStatus = mediaStream.getVideoTracks()[0]["readyState"];
                            if(!mediaStatus || mediaStatus!=="live"){
                                getCamera = false;
                                detailMonitor.alertErrorMessage();
                            }
                        }

                        if(getCamera){
                            detailMonitor.initMonitorDate();
                            detailMonitor.monitorInterval = setInterval(function () {
                                if(window.recordRTC && window.recordRTC.state && window.recordRTC.state === 'recording'){
                                    PEBASE.ajaxRequest({
                                        url: pageContext.rootPath + '/ems/examMonitor/manage/checkMonitorImage',
                                        data: {arrangeId: detailMonitor.arrangeId},
                                        success: function (data) {
                                            if (!data.success) {
                                                return false;
                                            }

                                            var image = detailMonitor.getImageStream();
                                            PEBASE.ajaxRequest({
                                                url: pageContext.rootPath + '/ems/examMonitor/manage/uploadMonitorImage',
                                                data: {
                                                    arrangeId: detailMonitor.arrangeId,
                                                    image: image,
                                                    examId: detailMonitor.examId
                                                }
                                            });
                                        }
                                    });
                                }
                            }, 5000);
                        }
                    }, 10000);
                });

                peer.on('connection', function (conn) {
                    conn.on('data', function (clientId) {
                        peer.call(clientId, window.stream);
                    });
                });
            },

            initData: function () {
                //ie9不支持Placeholder问题
                //   PEBASE.isPlaceholder();
                clearInterval( detailMonitor.monitorInterval);
                var _this = this;
                setInterval(function () {
                    _this.nowDate.setSeconds(_this.nowDate.getSeconds() + 1);
                }, 1000);
                //岗位
                var settingInputPositionTree = {
                    dataUrl: pageContext.rootPath + '/uc/position/manage/listPositionTree',
                    clickNode: function (treeNode) {
                        if (treeNode.pId == null) {
                            $('.show-position-name').val(null);
                        }

                        if (!treeNode || treeNode.isParent) {
                            return false;
                        }

                        $('input[name="user.positionId"]').val(treeNode.id);
                        $('.show-position-name').val(treeNode.name);
                    },
                    width: 218,
                    treeSearch: $('input[name="positionName"]')
                };
                PEBASE.inputTree({
                    dom: '.pe-position-tree-wrap',
                    treeId: 'positionTree',
                    treeParam: settingInputPositionTree
                });

                //部门
                var organizeTreeData = {
                    dataUrl: pageContext.rootPath + '/uc/user/manage/listTree',
                    clickNode: function (treeNode) {
                        if (!treeNode.pId) {
                            $('.show-organize-name').val(null);
                            return false;
                        }

                        $('.pe-organize-tree-wrap').find('.pe-tree-show-name').val(treeNode.name);
                        $('input[name="user.organize.id"]').val(treeNode.id);
                    },
                    width: 218,
                    treeSearch: $('input[name="organizeName"]')
                };
                PEBASE.inputTree({dom: '.pe-organize-tree-wrap', treeId: 'organizeTree', treeParam: organizeTreeData});
                <#if exam.enableTicket?? && exam.enableTicket>
                    var peTableTitle = [
                        {'title': "checkbox", 'width': 5},
                        {'title': '准考证号', 'name': 'ticket', 'width': 10},
                        {'title': '用户名', 'width': 10},
                        {'title': '姓名', 'width': 10},
                        {'title': '进入时间', 'width': 15},
                        {'title': '交卷时间', 'width': 15},
                        {'title': '答题时长', 'width': 10},
                        {'title': '退出', 'width': 5},
                        {'title': '切屏', 'width': 5},
                        {'title': '违纪', 'width': 5},
                        {'title': '操作', 'width': 10}
                    ];
                <#else>
                    peTableTitle = [
                        {'title': "checkbox", 'width': 4},
                        {'title': '用户名', 'width': 10},
                        {'title': '姓名', 'width': 10},
                        {'title': '进入时间', 'width': 18},
                        {'title': '交卷时间', 'width': 18},
                        {'title': '答题时长', 'width': 10},
                        {'title': '退出', 'width': 7},
                        {'title': '切屏', 'width': 7},
                        {'title': '违纪', 'width': 7},
                        {'title': '操作', 'width': 10}
                    ];
                </#if>


                /*表格生成*/
                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/ems/examMonitor/manage/search',
                    formParam: $('#examManageForm').serialize(),//表格上方表单的提交参数
                    tempId: 'peExamManaTemp',//表格模板的id
                    showTotalDomId: 'showTotal',
                    title: peTableTitle //表格头部的数量及名称数组;
                });

                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/examMonitor/manage/searchExamUserCount',
                    data: {
                        arrangeId: detailMonitor.arrangeId
                    },
                    success:function(data){
                        if(data.success){
                            var monitorCount = JSON.parse(data.message);
                            var joinNum = monitorCount["joinNum"];
                            var joinedNum = monitorCount["joinedNum"];
                            $(".pe-monitor-tip span:first").html(joinNum);
                            $(".pe-monitor-tip span:last").html(joinedNum);
                        }
                    }
                });
            },
            monitorSwiperObj: {},
            isSwiperStop: false,
            bind: function () {
                <#if exam.examType?? && exam.examType == 'ONLINE' && canMonitor?? && canMonitor>
                    window.onbeforeunload = function (e) {
                        e = e || window.event;
                        var _msg = '请先上传并且保存视频录像！';
                        // For IE and Firefox prior to version 4
                        if (e) {
                            e.returnValue = _msg;
                        }
                        // For Safari
                        return _msg;
                    };

                    $('.upload-record-cla').on('click',function () {
                        var checkTime = detailMonitor.checkTimeLimited();
                        if(!checkTime){
                            return;
                        }
                        window.recordRTC.stopRecording(function (url) {
                            detailMonitor.stopCountDuration();
                            detailMonitor.uploadToServer(function () {
                                PEMO.DIALOG.tips({
                                    content: '上传成功',
                                    time:2000
                                });

                                detailMonitor.stopStream();
                            });
                        });
                    });
                </#if>
                $(".pe-monitor-refresh").on('click',function(){
                    detailMonitor.initData();
                });

                $('.exam-manage-choosen-btn').on('click', function () {
                    var organizeVal = $('.show-organize-name').val();
                    var positionVal = $('.show-position-name').val();
                    if (!organizeVal) {
                        $('input[name="user.organize.id"]').val('');
                    }
                    if (!positionVal) {
                        $('input[name="user.positionId"]').val('');
                    }

                    $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
                });
                //强制交卷
                $('.pe-stand-table-wrap').delegate('.icon-forced-assignment', 'click', function () {
                    var id = $(this).attr('data-arrangeId');
                    var userId = $(this).attr('data-user');
                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定要强制提交选中的考生的试卷么？</h3><p class="pe-dialog-content-tip">强制提交后，考生则不能继续答题！请谨慎操作！</p></div>',
                        btn2: function () {
                            $.post(pageContext.rootPath + '/ems/examMonitor/manage/forceSubmitExam', {
                                'id': id,
                                'userId': userId
                            }, function (data) {
                                if (data.success) {
                                    PEMO.DIALOG.tips({
                                        content: '强制交卷成功',
                                        end: function () {
                                            $('.pe-stand-table-wrap').peGrid('refresh');
                                        }
                                    });

                                    return false;
                                }


                                PEMO.DIALOG.alert({
                                    content: data.message,
                                    btn: ['我知道了'],
                                    yes: function () {
                                        layer.closeAll();
                                    }
                                })
                            }, 'json');
                        }
                    });
                });
                //设置定时器获取消息；
                //提醒学员
                $('.notice-user').on('click', function () {
                    var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
                    if (!rows || rows.length <= 0) {
                        PEMO.DIALOG.alert({
                            content: '请至少先选择一个学员',
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });
                        return false;
                    }
                    var examId = $("input[name='exam.id']").val();
                    var arrangeId = $("input[name='examArrange.id']").val();
                    var userIds = JSON.stringify(rows);
                    PEMO.DIALOG.confirmR({
                        content: _.template($('#noteTemp').html())(),
                        btn2: function () {
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/exam/manage/noticeExamUser?arrangeId=' + arrangeId + '&exam.id=' + examId + '&userIds=' + userIds,
                                data: $('#examTmpForm').serializeArray(),
                                success: function (data) {
                                    if (data.success) {
                                        PEMO.DIALOG.tips({
                                            content: '发送成功',
                                            time: 1000,
                                            end: function () {
                                                $('.pe-stand-table-wrap').peGrid('load', $('#monitorNoStartTemp').serializeArray());
                                            }
                                        });
                                        return false;
                                    } else {
                                        PEMO.DIALOG.tips({
                                            content: data.message,
                                            time: 1000
                                        });
                                    }
                                }
                            });
                        },
                        success: function () {
                            PEBASE.peFormEvent('checkbox');
                        }
                    });
                });

                // 延长考试时间
                $('.pe-stand-table-wrap').delegate('.remove-btn', 'click', function () {
                    var arrangeId = $(this).attr('data-arrangeId');
                    var userId = $(this).attr('data-user');
                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定要移除选中的考生么？</h3><p class="pe-dialog-content-tip">移除后，考生则不能参加该场考试！请谨慎操作！</p></div>',
                        btn2: function () {
                            $.post(pageContext.rootPath + '/ems/examMonitor/manage/removeExamUser', {
                                'id': arrangeId,
                                'userId': userId
                            }, function (data) {
                                if (data.success) {
                                    PEMO.DIALOG.tips({
                                        content: '延长成功',
                                        end: function () {
                                            $('.pe-stand-table-wrap').peGrid('refresh');
                                        }
                                    });

                                    return false;
                                }


                                PEMO.DIALOG.alert({
                                    content: data.message,
                                    btn: ['我知道了'],
                                    yes: function () {
                                        layer.closeAll();
                                    }
                                })
                            }, 'json');
                        }
                    });
                });
                //删除答卷
                $('.pe-stand-table-wrap').delegate('.icon-delete', 'click', function () {
                    var arrangeId = $("input[name='examArrange.id']").val();
                    var userId = $(this).attr('data-user');
                    //   alert("批次id为:"+arrangeId+",用户id为"+userId);
                    PEMO.DIALOG.confirmR({
                        content: '<div><h3 class="pe-dialog-content-head">确定要删除考生的答卷么？</h3><p class="pe-dialog-content-tip">删除答卷后，考生可以再次进行考试！！</p></div>',
                        btn2: function () {
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/examMonitor/manage/deleteUserPaper',
                                data: {id: arrangeId, userId: userId},
                                success: function (data) {
                                    if (data.success) {
                                        PEMO.DIALOG.tips({
                                            content: '删除成功',
                                            end: function () {
                                                $('.pe-stand-table-wrap').peGrid('refresh');
                                            }
                                        });

                                        return false;
                                    }


                                    PEMO.DIALOG.alert({
                                        content: data.message,
                                        btn: ['我知道了'],
                                        yes: function () {
                                            layer.closeAll();
                                        }
                                    })
                                }
                            });
                        },
                        btn1: function () {
                            layer.closeAll();
                        }
                    });
                });
                //删除答卷end

                //增加学员
                var examId = $("input[name='examArrange.exam.id']").val();
                var arrangeId = $("input[name='examArrange.id']").val();
                $('.add-user').on('click', function () {
                    PEMO.DIALOG.selectorDialog({
                        title: '按人员添加',
                        area: ['970px', '580px'],
                        content: [pageContext.rootPath + '/ems/exam/manage/initSelectMonitorUserPage?id=' + arrangeId + '&exam.id=' + examId, 'no'],
                        btn: ['关闭'],
                        btn1: function (index) {
                            layer.close(index);
                            detailMonitor.initData();
                        }
                    });
                });

                $('.pe-stand-table-wrap').delegate('.break_rule_btn', 'click', function () {
                    var monitorId = $(this).data('id');
                    PEMO.DIALOG.confirmR({
                        content: _.template($('#breakRuleTemp').html())(),
                        title: '违纪处理',
                        btn2: function () {
                            PEBASE.ajaxRequest({
                                url: '${ctx!}/ems/examMonitor/manage/saveIllegalRecord?examMonitor.id=' + monitorId,
                                data: $('#illegalForm').serialize(),
                                success: function () {
                                    layer.closeAll();
                                    PEMO.DIALOG.tips({
                                        content: '处理成功',
                                        time: 1000,
                                        end: function () {
                                            $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serializeArray());
                                        }
                                    });
                                }
                            })
                        },
                        success: function () {
                            PEBASE.peFormEvent('radio');
                        }
                    });
                });
            },
            messages: [],
            searchMessage: function () {
                var _this = this;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/examMonitor/manage/searchMonitorMessage?arrangeId=' + detailMonitor.arrangeId,
                    success: function (data) {
                        if (data && data.length > 0) {
                            _this.messages = data;
                            var swiperTipDom = _.template($('#monitorTipItemTemp').html())({data: _this.messages});
                            $('.monitor-tip-text').show();
                            $('.monitor-tip-text .swiper-wrapper').append(swiperTipDom);
                            if (data.length > 1) {
                                _this.initSwiper();
                            }
                        }

                        _this.repeatMessage();
                    }
                });
            },
            initSwiper: function () {
                detailMonitor.monitorSwiperObj = new Swiper('.swiper-container', {
                    freeModeFluid: true,
                    grabCursor: false,
                    autoplay: 2000,
                    speed: 5000,
                    loop: true,
                    onFirstInit: function () {
                        $('.swiper-container').delegate('.monitor-tip-item', 'mouseover', function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                            detailMonitor.monitorSwiperObj.stopAutoplay();
                            detailMonitor.isSwiperStop = true;
                        });

                        $('.swiper-container').delegate('.monitor-tip-item', 'mouseout', function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                            detailMonitor.monitorSwiperObj.startAutoplay();
                            detailMonitor.isSwiperStop = false;
                        });

                        $('.swiper-container').delegate('.tip-close', 'click', function (e) {
                            var e = e || window.event;
                            e.stopPropagation();
                            var thisActiveIndex = _this.monitorSwiperObj.activeLoopIndex;
                            detailMonitor.monitorSwiperObj.removeSlide(thisActiveIndex);
                            detailMonitor.monitorSwiperObj.reInit();
                            PEMO.DIALOG.tips({
                                content: '删除成功',
                                time: 1500
                            })
                        });
                    }
                });
            },
            repeatMessage: function () {
                var _this = this;
                var repeatTime = 5000;
                setInterval(function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/examMonitor/manage/getMonitorMessage?arrangeId=' + detailMonitor.arrangeId,
                        success: function (data) {
                            if (!data.success) {
                                return false;
                            }

                            _this.messages.push(data.data);
                            if (_this.messages.length > 5) {
                                _this.messages.splice(0, 1);
                                detailMonitor.monitorSwiperObj.removeSlide(0);
                            }

                            $('.monitor-tip-text').show();
                            var thisNewTipDom = _.template($('#monitorTipItemTemp').html())({data: [data.data]});
                            if (_this.messages.length === 1) {
                                $('.monitor-tip-text .swiper-wrapper').append(thisNewTipDom);
                                return false;
                            }

                            if ($.isEmptyObject(detailMonitor.monitorSwiperObj)) {
                                detailMonitor.initSwiper();
                            }

                            detailMonitor.monitorSwiperObj.appendSlide(thisNewTipDom);
                        }
                    });
                }, repeatTime);
            },
            init: function () {
                /*如果此处的监控不支持ie，要不要给个提示*/
                var _this = this;
                _this.initData();
                _this.bind();
                <#if exam.examType?? && exam.examType == 'ONLINE' && canMonitor?? && canMonitor>
                    var valid = _this.checkBrowser();
                    if(valid){
//                        $('.ing-waves .item').width(20).height(20);
                        detailMonitor.initParam();
                        detailMonitor.initMonitorManage();
                    } else {
                        PEMO.DIALOG.alert({
                            content: _.template($('#browserLowerDialogTemp').html())({}),
                            area:['600px','380px'],
                            btn:''
                        });
                    }

                    _this.searchMessage();
                </#if>
            }
        };

        detailMonitor.init();
    });
    //考试作废
</script>
</@p.pageFrame>