<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zn-CH">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="renderer" content="webkit" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>参加考试</title>
    <link rel="shortcut icon" href="${(resourcePath+icoUrl)!'${resourcePath!}/web-static/proExam/images/pe_ico_32.ico'}" type="image/x-icon"/>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/user.css?_v=${(resourceVersion)!}" type="text/css">
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/media/video_dev.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/carmera/jquery.webcam.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/user_control.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/html5.js?_v=${(resourceVersion)!}"></script>
    <script>
        var pageContext = {
            resourcePath: '${resourcePath!}',
            rootPath:'${ctx!}'
        }
    </script>
</head>
<body>
<#--公用头部-->
<div class="pe-public-top-nav-header" style="min-width:1000px;">
    <div class="pe-top-nav-container" style="min-width:1000px;max-width:1200px;width:auto;">
        <ul class="clearF">
            <li class="pe-logo floatL">
                <img src="${(resourcePath+logoUrl)!'${resourcePath!}/web-static/proExam/images/long_logo_pure.png'}" class="floatL" width="100%" alt="LOGO">
            </li>
        </ul>
    </div>
</div>
<#assign examSetting = exam.examSetting/>
<#assign paper = exam.paper/>
<div class="pe-main-wrap online-environment-wrap" style="padding-bottom:30px;<#if (examSetting.preventSetting?? && examSetting.preventSetting.rc?? && examSetting.preventSetting.rc) || paper.audio>display:none;</#if>">
<#--<#assign examResult = exam.examResult/>-->
    <div class="pe-main-content">
        <div class="pe-manage-panel" style="background: none;border: none; ">
        <#if message??>
            <p class="pe-online-exam-top">
                ${(message)!}
                <span class="iconfont icon-dialog-close-btn pe-online-close"></span>
            </p>
        <#elseif ((examSetting.preventSetting?? && examSetting.preventSetting.rc?? && examSetting.preventSetting.rc) || paper.audio) && limitExam?? && !limitExam>
            <p class="pe-online-exam-top"><#if (examSetting.preventSetting?? && examSetting.preventSetting.rc?? && examSetting.preventSetting.rc)>
                本次考试需要摄像头监考，请在安装了的电脑上作答
            </#if><#if paper.audio><#if (examSetting.preventSetting?? && examSetting.preventSetting.rc?? && examSetting.preventSetting.rc)>
                ；</#if>本次考试包含音频文件，请在能够听到音频的电脑上作答</#if>。
                <span class="iconfont icon-dialog-close-btn pe-online-close"></span>
            </p>
        </#if>
            <div class="pe-online-contain" style="margin-top: 20px;">
                <h2 class="pe-online-title">${(exam.examName)!}</h2>
            <#if exam.examResult?? && exam.examResult.status??>
                <div class="pe-admin-explain">
                        <#if exam.examResult.status == 'RELEASE'>
                            <#if exam.examResult.pass?? && exam.examResult.pass><span class="pe-wrong-pass-btn">已通过</span><#else><span class="pe-wrong-nopass-btn">未通过</span></#if>
                        <#elseif exam.examResult.status == 'MARKING' || exam.examResult.status == 'WAIT_RELEASE'>
                        <span class="pe-wrong-nopass-btn">评卷中</span>
                        <#elseif exam.examResult.status == 'MISS_EXAM'>
                        <span class="pe-wrong-nopass-btn">缺考</span>
                        </#if>

                    <div class="pe-wrong-item" <#if exam.examResult.status == 'MARKING' || exam.examResult.status == 'WAIT_RELEASE' || (exam.examResult.status == 'MISS_EXAM' && !limitExam)>style="display: none" </#if>>
                        <dl>
                            <dt class="pe-wrong-test">成绩:</dt>
                            <dd class="pe-wrong-test">${(exam.examResult.score)!'0'}分</dd>
                        </dl>
                        <dl>
                            <dt class="pe-wrong-score">满分:</dt>
                            <dd class="pe-wrong-score">${(paper.mark)!'0'}分</dd>
                        </dl>
                        <dl class="clear"></dl>
                    </div>
                </div>
            <#elseif (exam.residualTime>0)>
            <div class="pe-admin-explain">
                <span class="pe-wrong-nopass-btn">未开始，请耐心等待</span>
            </div>
            <#elseif exam.status?? && exam.status == 'MARKING'>
                <div class="pe-admin-explain">
                    <span class="pe-wrong-marking-btn">评卷中</span>
                </div>
            <#elseif exam.status?? && exam.status == 'OVER'>
                <div class="pe-admin-explain">
                    <span class="pe-wrong-marking-btn">已结束</span>
                </div>
            </#if>
                <dl>
                    <dt class="pe-online-test">考试时间</dt>
                    <dd class="pe-online-item pe-exam-time"
                        data-endTime=" ${(exam.endTime?string("yyyy-MM-dd HH:mm:ss"))!}">${(exam.startTime?string("yyyy年MM月dd日 HH:mm"))!}
                        ~ ${(exam.endTime?string("yyyy年MM月dd日 HH:mm"))!}</dd>
                </dl>
            <#if exam.paper??>
                <dl>
                    <dt class="pe-online-test" style="text-align:justify;text-align-last: justify;">总试题数</dt>
                    <dd class="pe-online-item">${(paper.itemCount)!}道</dd>
                </dl>
                <dl>
                    <dt class="pe-online-test">答题时长</dt>
                    <dd class="pe-online-item">
                        <#if examSetting.examSetting?? && examSetting.examSetting.elt?? && examSetting.examSetting.elt == 'NO_LIMIT'>
                            无限制
                        <#else>
                        ${(examSetting.examSetting.el)!}分钟
                        </#if>
                    </dd>
                </dl>
                <#--<#if !(exam.examResult??)>-->
                    <dl class="pe-online-item-wrap">
                        <dt class="pe-online-test">试卷满分</dt>
                        <dd class="pe-online-score">${(paper.mark)!}分</dd>
                    </dl>
                    <dl class="pe-online-item-wrap" >
                        <dt class="pe-online-test" style="text-align:justify;text-align-last: justify;">及&emsp;&emsp;格</dt>
                        <dd class="pe-online-score">${(exam.passMark)!}分</dd>
                    </dl>
                <#--</#if>-->
            </#if>
                <dl class="clear"></dl>
            <#if examSetting.examSetting?? && examSetting.examSetting.mt?? && examSetting.examSetting.mt == 'NO_MAKEUP'>
                <p class="pe-online-tip"><i class="iconfont">&#xe640;</i>本场考试设置为不允许补考！</p>
            </#if>
            </div>
        <#if limitExam?? && !limitExam>
            <div class="pe-online-contain pe-online-inf">
                <h2 class="pe-online-stu">考生身份验证</h2>
                <div class="pe-online-inf-item">
                    <dl>
                        <dt class="pe-online-test" style="text-align:justify;text-align-last: justify;">姓&emsp;&emsp;名</dt>
                        <dd>${(user.userName)!}</dd>
                    </dl>
                    <#if user.employeeCode??>
                        <dl>
                            <dt>工&emsp;&emsp;号</dt>
                            <dd>${(user.employeeCode)!}</dd>
                        </dl>
                    </#if>
                    <#if user.idCard??>
                        <dl>
                            <dt>身份证号</dt>
                            <dd>${(user.idCard)!}</dd>
                        </dl>
                    </#if>
                    <#if exam.ticket??>
                    <dl>
                        <dt>准考证号</dt>
                        <dd>${(exam.ticket)!}</dd>
                    </dl>
                    </#if>
                    <#if user.mobile??>
                        <dl>
                            <dt>手机号码</dt>
                            <dd>${(user.mobile)!}<span class="pe-online-mody">＊若手机号有误请联系管理员修改</span></dd>
                        </dl>
                        <#if examSetting.preventSetting?? && examSetting.preventSetting.sv?? && examSetting.preventSetting.sv>
                            <dl>
                                <dt>手机验证</dt>
                                <dd class="validate-form-cell">
                                    <input class="pe-online-check-num" name="numCode"/>
                                    <button type="button" class="exam-user-verify-btn pe-online-btn">获取验证码</button>
                                    <em class="error" style="display: none"></em>
                                    <em class="iconfont icon-solid-circle-chekced success"
                                        style="color: #5cc83e;font-size: 15px;display: none;"></em>
                                </dd>
                            </dl>
                            <p><i class="iconfont"></i></p>
                        </#if>
                    </#if>
                    <#if (examSetting.preventSetting?? && examSetting.preventSetting.rc?? && examSetting.preventSetting.rc) || paper.audio>
                        <#--<p class="pe-online-text" style="color: red;padding-left:50px;"><i class="iconfont icon-caution-tip"-->
                                                                         <#--style="color: red;font-size: 14px;"></i>为了您能正常考试，请先对考试环境进行检测!&nbsp;-->
                            <#--<a data-id="${(exam.id)!}" class="online-exam-check-environment"-->
                               <#--href="javascript:;" style="font-size:15px;font-weight:bold;color:red;text-decoration:underline;">立即检测</a>-->
                        <#--</p>-->
                        <p class="pe-online-text test-pass" style="display:none;"><i class="iconfont">&#xe74f;</i>考试环境正常
                        </p>
                    </#if>
                    <div style="padding-top: 15px;">
                        <button type="button" style="font-size:16px;"
                                class="pe-btn pe-btn-blue pe-for-submit pe-online-sure forbid-take-exam-btn">
                            <#if exam.examResult?? && exam.examResult.needMakeUp?? && exam.examResult.needMakeUp>立即补考<#else>参加考试</#if>
                        </button>
                        <#if !(openTab?? && openTab)>
                        <button style="font-size:16px;" type="button" class="pe-btn pe-btn-purple pe-for-continue">下次再考</button>
                        </#if>
                        <#if examSetting.preventSetting?? && examSetting.preventSetting.sv?? && examSetting.preventSetting.sv&&(!user.mobile??)>
                            <p class="pe-online-mobile"><i class="iconfont icon-caution-tip"
                                                           style="color: red;font-size: 12px;"></i>本次考试需进行手机号码验证，可在个人中心进行手机号码的绑定!
                            </p>
                        </#if>
                    </div>
                </div>
                <div class="pe-online-img">
                    <img onerror="javascript:this.src='${resourcePath!}/web-static/proExam/images/default/default_face.png'" src="${(user.facePath)!'${resourcePath!}/web-static/proExam/images/default_face.png'}">
                </div>
            </div>
        </#if>
        </div>
    </div>
</div>
<#--环境检测页面-->
<#if (examSetting.preventSetting?? && examSetting.preventSetting.rc?? && examSetting.preventSetting.rc) && limitExam?? && !limitExam>
<div class="pe-environment-check" style="display:none;" <#if !(examSetting.preventSetting?? && examSetting.preventSetting.rc?? && examSetting.preventSetting.rc)></#if> >
   <div class="check-loading">
       <img src="${resourcePath!}/web-static/proExam/images/check_enviroment.gif" height="100%" alt="" />
   </div>
    <p>正在进行环境检测</p>
    <i>请您耐心等待，检测完毕后将自动关闭页面</i>
    <div class="check-dom-wrap">
        <#--摄像头dom-->
    </div>
</div>
<div id="testCamWrapDiv" style="width:0;height:0!important;position:absolute;z-index:-1;opacity:0;top:-4000px;">
    <div id="webcam"></div>
</div>
</#if>

<div class="check-wrong-wrap" style="display:none;">
    <div class="pe-result-contain">
        <div class="pe-result-wrap">
            <ul>
                <#if examSetting.preventSetting?? && examSetting.preventSetting.rc?? && examSetting.preventSetting.rc && limitExam?? && !limitExam>
                    <li class="pe-result-show">
                        <div class="pe-result-camera">
                        </div>
                        <div class="pe-result-ask" style="padding-top: 5px;">
                            <h2>摄像头</h2>
                            <p>如果管理员要求考试时实时摄像，检测摄像头工作是否正常</p>
                        </div>
                        <div class="pe-result-status camera-success" style="display: none;">
                            <i class="iconfont" style="color: #5bc83d;">&#xe634;</i>
                            <span style="color: #5bc83d;">成功</span>
                        </div>
                        <div class="pe-result-status camera-loading" >
                            <i class="cam-check-loading"></i>
                            <span style="color: #199ae2;">检测中...</span>
                        </div>
                        <div class="pe-result-status camera-failed" style="display: none;">
                            <i class="iconfont">&#xe640;</i>
                            <span>失败</span>
                        <#--<a href="javascript:;">解决办法</a>-->
                        </div>
                    </li>
                </#if>
                <#if paper.audio?? && paper.audio>
                    <li class="pe-result-show">
                        <div class="pe-result-speaker">
                        </div>
                        <div class="pe-result-ask">
                            <h2>扬声器（耳机）</h2>
                            <p>如果试卷中有音频或者视频，检测扬声器工作是否正常</p>
                        </div>
                        <div class="pe-result-status speaker-success" style="display: none;">
                            <i class="iconfont" style="color: #5bc83d;">&#xe634;</i>
                            <span style="color: #5bc83d;">成功</span>
                        </div>
                        <div class="pe-result-status speaker-failed" style="display: none;">
                            <i class="iconfont">&#xe640;</i>
                            <span>失败</span>
                        <#--<a href="javascript:;">解决办法</a>-->
                        </div>
                    </li>
                </#if>
            </ul>
            <p class="pe-result-next">*请解决完以上所有故障，然后再进行考试</p>
            <div style="padding-bottom: 35px;">
                <#if openTab?? && openTab>
                    <button type="button" class="pe-btn pe-btn-white environment-result-reflash">重新检测</button>
                    <#else>
                        <button type="button" class="pe-btn pe-btn-white environment-result-close">关闭</button>
                </#if>
            </div>
        </div>
    </div>
    <div class="pe-result-down">
        <div class="pe-result-way">
            <p class="pe-result-way-title">常见故障解决办法</p>
            <ul>
                <li class="solve-msg-li">一、浏览器版本过低，如何升级浏览器？<i class="iconfont icon-thin-arrow-up"></i>
                    <div class="problem-solve-block">
                        <ul>
                            <li>1.如果你用的是360浏览器,QQ浏览器或猎豹等国内浏览器，请查看浏览器是否启用了兼容模式，为了保证正常顺利的考试，建议关闭该页面，切换为极速模式重新进入,感谢您的配合;</li>
                            <li>2.为了保证正常顺利的考试,如果你用的是chrome或者firefox浏览器，请确保<strong style="color:red;">chrome的版本在35及</strong>以上，<strong style="color:red;">firefox在30以上</strong>,感谢您的配合</li>
                            <li>3.为了保证正常顺利的考试,如果你用的ie浏览器，请确保ie的版本在<strong style="color:red;">ie9及以上</strong>,感谢您的配合</li>
                        </ul>
                    </div>
                </li>
                <li class="solve-msg-li">二、网络不稳定?<i class="iconfont icon-thin-arrow-up"></i>
                    <div class="problem-solve-block">
                        <ul>
                            <li>1.请用相关的测速软件，测一下当前的网络，如果网速小于50k，当考试试题包含 大量图片，音频或视频时，可能会比较慢,感谢您的配合</li>
                        </ul>
                    </div>
                </li>
                <li class="solve-msg-li">三、摄像头无法正常工作？<i class="iconfont icon-thin-arrow-up"></i>
                    <div class="problem-solve-block">
                        <ul>
                            <li>1.请检查浏览器是否安装了比较新版的flash插件<strong style="color:red;">(版本大于11)</strong>，或者 浏览器是否<strong style="color:red;">禁用了flash</strong>功能，因为我们的摄像头依赖flash，感谢您的配合;</li>
                            <li>2.当进入页面时，某些浏览器顶部会有提示用户<strong style="color:red;">是否允许加载flash，请您点击允许</strong>，不然摄像头功能会失效,感谢您的配合;</li>
                            <li>3.如果你用的是360浏览器,QQ浏览器,猎豹或搜狗等国内浏览器且您本机安装了<strong style="color:red;">IE8</strong>，请查看浏览器是否启用了<strong style="color:red;">兼容模式</strong>，为了保证正常顺利的考试，建议关闭该页面，切换为<strong style="color:red;">极速模式</strong>重新进入，感谢您的配合;</li>
                            <li>4.请检查您是否同时打开了除这个浏览器之外，另外的浏览器并且另外一个浏览器正在使用摄像头，如果是这样，请关闭另外一个浏览器或者在另外一个浏览器进入我们的系统，感谢您的配合</li>
                            <li>5.请检查摄像头接口与电脑是否接触良好，或者摄像头在其它能打开摄像头的电脑端试试，看是否是 摄像头本身的原因,感谢您的配合</li>
                        </ul>
                    </div>
                </li>
                <li class="solve-msg-li">四、扬声器无法正常工作？<i class="iconfont icon-thin-arrow-up"></i>
                    <div class="problem-solve-block">
                        <ul>
                            <li>1.请检测是否插入了耳机或者电脑声音是否处于静音/音量很小的状态;</li>
                            <li>2.请查看电脑的声卡驱动等是否正确安装;</li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>

<#--公用部分尾部版权-->
<footer class="pe-footer-wrap" style="min-width:1000px;">
    <div class="pe-footer-copyright" style="width:auto;"> ${(footExplain)!'Copyright &copy${.now?string("yyyy")} 青谷科技专业考试系统 All Rights Reserved 皖ICP备16015686号-2'}</div>
</footer>
</body>
<#--音频检测弹框-->
<script type="text/template" id="audioCheckTemp">
    <div class="audio-check-box">
        <audio src="" id="audioTest" loop = "true" width="0" height="0" style="display:none;"></audio>
        <div class="volumn-control-wrap">
            <div style="display:inline-block;width:30px;color:#444;">音量</div>
            <div class="volumn-control-panel" style="margin-left:0;">
                <div class="volumn-under-progress">
                    <div class="volumn-up-progress">
                        <i class="control-circle-point"></i>
                    </div>
                </div>
            </div>
        </div>
        <p class="check-tips-text">请点击播放测试，试试能否听到声音</p>
        <div class="audio-main-panel over-flow-hide">
            <button class=" audio-check-btn pe-btn pe-btn-green pe-large-btn">
                <span class="iconfont icon-pe-audio"></span>播放测试声音
            </button>
            <div class="audio-stream-dance floatR" style="display:none;">
                <div class="test-music">
                    <ul id="waves" class="music-movement">
                        <li class="li1"><span class="ani-li"></span></li>
                        <li class="li2"><span class="ani-li"></span></li>
                        <li class="li3"><span class="ani-li"></span></li>
                        <li class="li4"><span class="ani-li"></span></li>
                        <li class="li5"><span class="ani-li"></span></li>
                        <li class="li6"><span class="ani-li"></span></li>
                        <li class="li7"><span class="ani-li"></span></li>
                        <li class="li8"><span class="ani-li"></span></li>
                        <li class="li9"><span class="ani-li"></span></li>
                        <li class="li10"><span class="ani-li"></span></li>
                        <li class="li11"><span class="ani-li"></span></li>
                        <li class="li12"><span class="ani-li"></span></li>
                        <li class="li13"><span class="ani-li"></span></li>
                        <li class="li14"><span class="ani-li"></span></li>
                    </ul>
                </div>
            </div>
        </div>

    </div>
</script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/environment_check.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript">
    var msgValid= false,enviromentValid=false,audioValid = false,examTime = false;
    var residualTime = parseInt('${(exam.residualTime)!'0'}');
    var openTab=${(openTab?string('true','false'))!}
    $(function () {
        $('.online-environment-wrap').css('minHeight',window.innerHeight - 64-20-60-30);
        var examId = '${(exam.id)!}';
        <#if !(examSetting.preventSetting?? && examSetting.preventSetting.sv?? && examSetting.preventSetting.sv)>
           msgValid = true;
        </#if>

        <#if !(examSetting.preventSetting?? && examSetting.preventSetting.rc?? && examSetting.preventSetting.rc) && !paper.audio>
            enviromentValid = true;
        </#if>

         userControl.environmentCheck.init(examId,msgValid,enviromentValid);
    });
</script>
</html>