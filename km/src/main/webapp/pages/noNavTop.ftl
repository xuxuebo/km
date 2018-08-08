<#assign ctx=request.contextPath/>
<#macro pageFrame  title=''>
<!DOCTYPE html>
<html>
<head>
    <title>${(titleName)!'智慧云'}</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="renderer" content="webkit" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" href="${(resourcePath+icoUrl)!'${resourcePath!}/web-static/proExam/images/pe_ico_32.ico'}" type="image/x-icon" />
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css">
    <#--<link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/exam.css" type="text/css">-->
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/js/plugins/layer/skin/default/layer.css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/exercise.css?_v=${(resourceVersion)!}">
    <#--前端调试-->
    <script type="text/javascript">
        var pageContext = {
            rootPath:'${ctx!}',
            resourcePath: '${resourcePath!}'
        };
    </script>
    <#--<script type="text/javascript" src="http://hf.21tb.com/web-static/assets/proExam/js/jquery-1.9.1.min.js"></script>-->
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js"></script>
    <#--开发引用-->
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.core.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.excheck.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.exedit.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.underscore-min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.pagination.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-peGrid.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/viewer.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/sui_datepicker.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.mCustomScrollbar.concat.min.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.easydropdown.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.webuploader.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.validate.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.moment.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/highcharts.src.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/highcharts-more.src.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/drilldown.src.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/exporting.src.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-peGrid.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/media/video_dev.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/idangerous.swiper2.7.6.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/recordRTC.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/environment_check.js?_v=${(resourceVersion)!}"></script>
    <#--<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/compressJs/examIng_plugin_min.js?_v=${(resourceVersion)!}"></script>-->
    <script type="text/javascript">
        $(function () {
            $(document).ajaxComplete(function (event, jqXHR, options) {
                var ajaxRequestStatus = jqXHR.getResponseHeader("ajaxRequest");
                if (ajaxRequestStatus === 'loginFailed') {
                    location.href = pageContext.rootPath + '/client/logout';
                }
            });

            $(document).ajaxSend(function (event, jqxhr, settings) {
                var times = (new Date()).getTime() + Math.floor(Math.random() * 10000);
                if (settings.url.indexOf('?') > -1) {
                    settings.url = settings.url + '&_t=' + times;
                } else {
                    settings.url = settings.url + '?_t=' + times;
                }

            });
        });
    </script>
</head>

<body>
    <#nested>
<div class="pe-mask-listen"></div>
<#--公用部分尾部版权-->
<footer class="pe-footer-wrap">
    <div class="pe-footer-copyright"> ${(footExplain)!'Copyright &copy${.now?string("yyyy")} 国家电网江苏省电力公司 ©苏ICP备15007035号-1'}</div>
</footer>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>

<script>
    $(function(){
        PEBASE.publickHeader();
        //定义页面所有的checkbox，和radio的模拟点击事
        PEBASE.peFormEvent('checkbox');
        PEBASE.peFormEvent('radio');
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
    })
</script>
</body>
</html>
</#macro>