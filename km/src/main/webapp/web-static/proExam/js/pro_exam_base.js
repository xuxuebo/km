//路由
function getHash(key, url) {
    // 
    var hash;
    if (!!url) {
        hash = url.replace(/^.*?[#](.+?)(?:\?.+)?$/, "$1");
        hash = (hash == url) ? "" : hash;
    } else {
        hash = self.location.hash;
    }

    hash = "" + hash;
    hash = hash.replace(/^[?#]/, '');
    hash = "&" + hash;
    if (key === 'url') {
        var _val = hash.split('&nav=')[0];
        _val = _val.match(new RegExp("[\&]" + key + "=(.+)", "i"));
    } else if (key === 'nav') {
        var _val = hash.match(new RegExp("[\&]" + key + "=([^\&]+)", "i"));
    }

    if (_val == null || _val.length < 1) {
        return null;
    } else {
            return decodeURIComponent(_val[1]);
    }
}

function getDefineHash(key, url) {
    var hash;
    if (!!url) {
        hash = url.replace(/^.*?[#](.+?)(?:\?.+)?$/, "$1");
        hash = (hash == url) ? "" : hash;
    } else {
        hash = self.location.hash;
    }

    hash = "" + hash;
    hash = hash.replace(/^[?#]/, '');
    hash = "&" + hash;
    var _val = hash.match(new RegExp("[\&]" + key + "=(.+)", "i"));
    if (_val == null || _val.length < 1) {
        return null;
    } else {
        return decodeURIComponent(_val[1]);
    }
}
$(window).on("hashchange", function(){
    loadPanel();
});
function loadPanel(noLoad) {
    //
    var url = null;
    var nav = getHash("nav");
    if (nav == null) {
        url = getDefineHash("url");
    } else {
        url = getHash("url");
    }
    if(!nav){
        nav = 'home';
    }
    $('.pe-classify-detail').children('.classify-link').removeClass('cur');
    $('.pe-classify-detail[data-type="' + nav + '"]').children('.classify-link').addClass('cur');
    if(noLoad){
        return;
    }

    if (!url) {
        url = '/pe/front/manage/manageIndex';
    }
    $("#peMainPulickContent").load(url,function(){
        $('.category-show-btn').hide();
        //定义页面所有的checkbox，和radio的模拟点击事件
        PEBASE.peFormEvent('checkbox');
        PEBASE.peFormEvent('radio', {
            func2: function(e) {
                /*编辑公司的里面企业版按钮独有*/
                if(e[0].getAttribute("id") === "PESource") {
                    $('#ELPSource_selectTime').css('display','none');
                    $('#ELPSource_selectTime').find('input').attr('disabled','disabled');
                }
                if(e[0].getAttribute("id") === "ELPSource") {
                    $('#ELPSource_selectTime').css('display','inline-block');
                    $('#ELPSource_selectTime').find('input').removeAttr('disabled');
                }
            }
        });
    });
}
loadPanel();

var PEMO = {
    LOGINOUT:false,
    //弹框
    DIALOG: {
        selectorDialog:function(setting){
            var defaults = {
                type: 2,
                title: false,
                closeBtn: 1, //不显示关闭按钮
                shade: 0.3,
                area: ['900px', '565px'],
                //offset: '30px', //右下角弹出
                time: 0, //2秒后自动关闭
                anim: 2,
                resize:false,
                shadeClose:false,
                scrollbar: false,
                move:'.layui-layer-title',
                content: [], //iframe的url，no代表不显示滚动条
                end: function(){},
                success:function(){

                },
                checkAjaxRequest:function(){
                    /*检测弹框生成之前有无掉线;*/
                    PEBASE.ajaxRequest({
                        url:pageContext.rootPath+'/uc/user/client/checkLogin',
                        async:false
                    });
                }
            };

            $.extend(defaults,setting);
            layer.open(defaults);
        },
        tips: function(setting){
            //layer.js封装的tip提示框
            var defaults = {
                type: 0
                ,closeBtn: 1
                ,skin: 'pe-auto-tips '+setting.skin
                ,title: ''
                ,content: ''
                ,time: 1000
                ,resize:false
                ,scrollbar: true
                ,move:'.layui-layer-title'
                ,shade: 0
                ,end:function(){

                }
            };

            $.extend(defaults,setting);
            layer.open(defaults);
        },
        alert: function(setting){
            //layer.js封装的tip提示框
            var defaults = {
                type: 0
                ,closeBtn: 1
                ,skin: 'pe-layer-alert'
                ,title: ''
                ,content: ''
                ,area:['420px']
                ,resize:false
                ,scrollbar: false
                ,move:'.layui-layer-title'
                ,shade: [0.3,'#000']
                ,yes: function(index){
                    //确认按钮回调函数
                    layer.close(index);
                }
            };

            $.extend(defaults,setting);
            layer.open(defaults);
        },
        confirmL:function(setting){
            //确认按钮在左，取消按钮在右(confirm-Layer)
            var defaults = {
                type: 1
                ,closeBtn: 1
                ,skin: 'pe-layer-confirm pe-layer-has-tree'
                ,area: ['450px']
                ,title: ''
                ,btn: ['确认','取消']
                ,btnAlign: 'c'
                ,content: ''
                ,resize:false
                ,scrollbar: false
                ,move:'.layui-layer-title'
                ,shade: [0.3,'#000']
                ,btn1: function(){
                    //确认按钮的回调函数
                }
                ,btn2: function(){
                    //取消按钮的回调函数
                }
                ,cancel: function(){
                    //右上角关闭回调函数
                }
                ,end: function(){
                    //弹框关闭回调函数
                }
            };

            $.extend(defaults,setting);
            layer.open(defaults);
        },
        confirmR:function(setting){
            //确认按钮在右，取消按钮在左(confirm-Another-Layer)
            var defaults = {
                type: 1
                ,closeBtn: 1
                ,skin: 'pe-layer-confirmA'
                ,area: '450px'
                ,title: ''
                ,btn: ['取消','确认']
                ,content: ''
                ,resize:false
                ,move:'.layui-layer-title'
                ,scrollbar: false
                ,shade: [0.3,'#000']
                ,btn1: function(index){
                    //取消按钮的回调函数
                    layer.close(index);
                }
                ,btn2: function(){
                    //确认按钮的回调函数
                }
                ,cancel: function(){
                    //右上角关闭回调函数
                }
                ,end: function(){
                    //弹框关闭回调函数
                }
            };

            $.extend(defaults,setting);
            layer.open(defaults);
        }
    },

    UPLOAD: function (setting) {

        var $wrap = $('#uploader'),

        // 状态栏，包括进度和控制按钮
            $statusBar = $wrap.find('.pe-uploader-state-wrap'),

        // 文件总体选择信息。
            $info = $statusBar.find('.pe-uploader-complete-info'),

        // 上传按钮
            $uploadBtn = $wrap.find('.pe-begin-uploader-btn'),

        //取消按钮
            $cancelUpBtn = $wrap.find('.pe-uploader-cancel-upload'),

        // 没选择文件之前的内容。
            $placeHolder = $wrap.find('.placeholder'),

        //进度条数字
            $progressNum = $('.pe-uploader-progress-num'),

        // 进度条区域
            $progressWrap = $('.pe-uploader-progress-wrap'),

        // 添加的文件数量
            fileCount = 0,

        // 优化retina, 在retina下这个值是2
            ratio = window.devicePixelRatio || 1,

            // 可能有pedding, ready, uploading, confirm, done,finish.
            state = 'pedding',

            supportTransition = (function () {
                var s = document.createElement('p').style,
                    r = 'transition' in s ||
                        'WebkitTransition' in s ||
                        'MozTransition' in s ||
                        'msTransition' in s ||
                        'OTransition' in s;
                s = null;
                return r;
            })(),

        // WebUploader实例
            uploader;

        if (!WebUploader.Uploader.support()) {
            alert('Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
            throw new Error('WebUploader does not support the browser you are using.');
        }
        //下面的一些上传事件，如果外面调用了，那就无效了
        var defaults = {
            pick: {
                id: '#filePicker',
                label: '选择文件'
            },
            // dnd: '#uploader',
            paste: document.body,
            threads:1,
            duplicate:true,
            // swf文件路径
            swf: pageContext.rootPath + '/web-static/proExam/js/plugins/jquery.uploader.swf',
            disableGlobalDnd: true,
            chunked: false,
            // server: 'http://webuploader.duapp.com/server/fileupload.php',
            server: pageContext.rootPath +'/sfm/uploadFile',
            fileNumLimit: 300,
            //fileSizeLimit: 1 * 1024 * 1024,
            //fileSingleSizeLimit: 1 * 1024 * 1024,
            afterSuccessUploadContent: '',
            afterFailUploadContent: '',
            errorText:'',
            fileVal:'uploadFile'

        };
        $.extend(defaults, setting);
        // 实例化
        uploader = WebUploader.create(defaults);

        //初始化对按钮在禁止状态下点击进行返回的操作
        $('.webuploader-pick').parent('div').click(function () {
            if ($(this).find('.webuploader-pick').hasClass('disabled')) {
                return false;
            }
        });

        /*点击取消文件上传*/
        $cancelUpBtn.on('click',function(){

        });

        /*回复默认上传状态*/
        function recoverUpState(){
            var thisUptype = $('input[name="uploaderType"]').val();
            var thisFileShowName =  $('.pe-uploader-file-show-name');
            uploader.cancelFile($('input[name="fileId"]').data('fileObj'));
            $progressWrap.find('.pe-uploader-progress-num').css('left',0).html('0%');
            $progressWrap.find('.percentage').width(0);
            thisFileShowName.attr('title','').addClass('placeholder-show-name');
            $uploadBtn.addClass('disabled');
            $('.webuploader-pick').removeClass('disabled');
            $('input[name="fileId"]').data('fileObj','');
            if(thisUptype === 'audio'){
                thisFileShowName.html('请选择小于10M音频进行上传');
            }else if(thisUptype === 'video'){
                thisFileShowName.html('请选择小于100M视频进行上传');
            }else{
                thisFileShowName.html('请选择图片进行上传');
            }

        }
        // 负责view的销毁
        function removeFile(file) {
            var $li = $('#' + file.id);
            $li.off().find('.file-panel').off().end().remove();
        }

        //更新上传的状态区域
        function updateStatus() {
            var thisState = $('input[name="uploadState"]').val();
            var text = '', stats;
            if (state === 'ready') {

            } else if (state === 'confirm') {
                stats = uploader.getStats();
                if (stats.uploadFailNum) {
                    text = uploader.options.afterFailUploadContent;
                }

            } else if(state === 'uploading'){
                stats = uploader.getStats();
                // text = setting.afterSuccessUploadContent;
                text = '上传中...';
            }else if(state === 'finish'){
                // stats = uploader.getStats();
                // text = '上传完成';
            }

            if(thisState === 'success'){
                $info.html(uploader.options.afterSuccessUploadContent);
                $('input[name="fileId"]').data('fileObj','');
            }else if(thisState === 'false'){
                $info.html(uploader.options.afterFailUploadContent);
            }

        }

        function setState(val) {
            var file, stats;
            if (val === state) {
                return;
            }

            $uploadBtn.removeClass('state-' + state);
            $uploadBtn.addClass('state-' + val);
            state = val;
            switch (state) {
                /* 未选择文件 */
                case 'pedding':
                    $placeHolder.removeClass('element-invisible');
                    // $('.queueList').removeClass('filled');
                    //$queue.hide();
                    $statusBar.addClass('element-invisible');
                    uploader.refresh();
                    break;
                /* 可以开始上传 */
                case 'ready':
                    $placeHolder.addClass('element-invisible');
                    $statusBar.removeClass('element-invisible');
                    uploader.refresh();
                    break;
                /* 上传中 */
                case 'uploading':
                    $progressWrap.show();
                    $uploadBtn.addClass('disabled');
                    $('.webuploader-pick').addClass('disabled');
                    break;
                /* 暂停上传 */
                case 'paused':
                    $progressWrap.show();
                    break;

                case 'confirm':
                    $progressWrap.hide();

                    stats = uploader.getStats();
                    if (stats.successNum && !stats.uploadFailNum) {
                        setState('finish');
                        $uploadBtn.removeClass('disabled');
                        $('.webuploader-pick').removeClass('disabled');
                        return;
                    }
                    break;
                case 'finish':
                    stats = uploader.getStats();
                    if (stats.successNum) {
                        //alert('上传成功');
                        $uploadBtn.removeClass('disabled');
                        $('.webuploader-pick').removeClass('disabled');
                    } else {
                        // 没有成功的图片，重设
                        state = 'done';
                        location.reload();
                    }
                    break;
            }

            updateStatus();
        }


        //刚选择文件瞬间的事件,
        uploader.onBeforeFileQueued = function (file) {
            $('.pe-uploader-file-show-name').html(file.name).attr('title',file.name).removeClass('placeholder-show-name');
            $uploadBtn.removeClass('disabled');
            $('.pe-uploader-progress-wrap').hide();
            $('.text.pe-uploader-progress-num').html('0%');
            $('.pe-uploader-progress-percentage').width(0);
            $('.pe-uploader-state-wrap .pe-uploader-state-image').removeClass('state-success state-fail');
            $('input[name="uploadState"]').val('update');
            $('.pe-uploader-complete-info').html('');
        };

        //上传进度函数事件
        uploader.onUploadProgress = function (file, percentage) {
            var progressPercent = percentage * 100;
            $progressNum.css('left', (percentage * 100) + '%').html(Math.round((percentage * 100)) + '%');
            $progressWrap.find('.percentage').css('width', progressPercent + '%');
        };
        //上传成功之后事件
        uploader.onUploadSuccess = function(file){};
        uploader.on("error",function (type){
            if (type=="Q_TYPE_DENIED"){
                PEMO.DIALOG.tips({
                    content:defaults.errorText
                });
                return false;
            }else if(type=="F_EXCEED_SIZE" || type === "Q_EXCEED_SIZE_LIMIT"){
                PEMO.DIALOG.tips({
                    content:"文件大小不能超过" + Math.floor(parseInt(Math.round(defaults.fileSingleSizeLimit/1000/1000),10)) + "M"
                });
                return false;
            }
        });


        //当文件加入上传队列时触发
        uploader.onFileQueued = function (file) {
            fileCount++;
            if (fileCount === 1) {
                $placeHolder.addClass('element-invisible');
                $statusBar.show();
            }
            $('input[name="fileId"]').data('fileObj',file);
            setState('ready');
        };

        //当文件从对列中移除后触发
        uploader.onFileDequeued = function (file) {
            fileCount--;
            if (!fileCount) {
                setState('pedding');
            }

            removeFile(file);

        };

        uploader.on('all', function (type) {
            var stats;
            switch (type) {
                case 'uploadFinished':
                    setState('confirm');
                    break;

                case 'startUpload':
                    setState('uploading');
                    break;

                case 'stopUpload':
                    setState('paused');
                    break;

            }
        });


        $uploadBtn.on('click', function () {
            if ($(this).hasClass('disabled')) {
                return false;
            }

            if (state === 'ready') {
                uploader.upload();
            } else if (state === 'paused') {
                uploader.upload();
            } else if (state === 'uploading') {
                uploader.stop();
            }
        });

        $uploadBtn.addClass('state-' + state);

        return uploader;

    },
    //表格
    //树
    ZTREE: {
        //showUrl,addUrl,editUrl,removeUrl,moveUrl
        initTree: function (domId, settingUrl) {
            var tableJson = '';
            var isCheckBoxTree = settingUrl.isCheckbox || false;
            $.ajax({
                url: settingUrl.dataUrl,
                async: false,
                dataType: 'json',
                success: function (data) {
                    tableJson = data;
                },
                error: function (data) {
                    alert('请求出错啦');
                }

            });
            //双击开启编辑参数
            var nodesJson = tableJson;
            var settingDbClick = {
                selfArgu:{
                    isCheckBoxCanEdit: settingUrl.isCheckBoxCanEdit,
                    isNoIcoIcon:settingUrl.isNoIcoIcon,
                    treeType:settingUrl.type || '',
                    width:settingUrl.width || 263,
                    treeSearch:settingUrl.treeSearch,
                    isPeers:settingUrl.isPeers || false,
                    alwaysEdit:settingUrl.alwaysEdit || false
                },
                check:{
                    enable:isCheckBoxTree,
                    chkStyle:'checkbox',
                    chkboxType:settingUrl.checkBoxType || { "Y": "ps", "N": "ps" }
                },
                data: {
                    simpleData: {
                        enable: true
                    }
                },
                async: {
                    enable: false,
                    url: '/ztree/json/rootSmall.json',
                    dataType: 'json',
                    type: 'get'
                },
                view: {
                    addHoverDom: addHoverDom,
                    removeHoverDom: removeHoverDom,
                    selectedMulti: false,
                    dblClickExpand: false,
                    showLine: false,
                    fontCss: getFontCss
                },
                edit: {
                    enable: true,
                    editNameSelectAll: true,
                    showRemoveBtn: showRemoveBtn
                },
                callback: {
                    beforeRemove: beforeRemove,
                    onClick: onClick,
                    beforeDrag: function () {
                        return false;
                    },
                    onCheck:zTreeOnCheck
                }
            };

            var ztreeArgu = {
                newCount: 1,
                zTreeIsEditState: settingUrl.zTreeIsEditState ? settingUrl.zTreeIsEditState : false,
                nodeList: [],
                curDragNodes: '',
                autoExpandNode: '',
                zTreeObj: ''
            };
            //点击‘编辑’按钮进入树状可编辑模式

            var zTree;
            $(function () {
                //ztree 默认展开级别数
                $.fn.zTree.init($('#' + domId), settingDbClick, nodesJson);
                ztreeArgu.zTreeObj  = zTree = $.fn.zTree.getZTreeObj(domId);
                zTree.opt = settingUrl.optUrl;
                zTree.clickNode = settingUrl.clickNode || function(){};
                zTree.saveChecked = settingUrl.saveChecked || function(){};
                zTree.checkboxFuc = settingUrl.checkboxFuc || function(){};

                if(isCheckBoxTree){
                    $('.pe-tree-container .checkbox-node-li .chk').hover(
                        function(){
                            $(this).siblings('.zTree-node').addClass('zTree-node-hover-bg');
                        },
                        function(){
                            $(this).siblings('.zTree-node').removeClass('zTree-node-hover-bg');
                        }
                    )
                }
                if (settingUrl.addNodeFunc) {
                    zTree.addNodeFunc = settingUrl.addNodeFunc;
                }

                if (settingUrl.editNodeFunc) {
                    zTree.editNodeFunc = settingUrl.editNodeFunc;
                }
                if(settingUrl.type === 'organize'){
                    PEMO.ZTREE.addNodeBindEvent($("#addBtn_" + domId + "_1"),domId,zTree,zTree.getNodeByTId(domId + "_1"),settingUrl);
                }
                //延迟渲染滚动条插件
                setTimeout(function () {
                    $('#' + domId).mCustomScrollbar({
                        axis: "y",
                        theme: "dark-3",
                        scrollbarPosition: "outside",
                        setWidth: (settingUrl.width || 235 ) + 'px',
                        advanced: {updateOnContentResize: true},
                        callbacks: {
                            onUpdate: function () {
                            }
                        }
                    });
                }, 100);

                /*树的编辑模式切换函数*/
                $('.pe-control-tree-btn').click(function () {
                    if (ztreeArgu.zTreeIsEditState) {
                        ztreeArgu.zTreeIsEditState = false;
                        $('#peZtreeMain .curSelectedNode').find('.iconfont.button').not('.ico_docu,.ico_open,.ico_close').remove();
                        $(this).removeClass('icon-complete-management').addClass('icon-set');
                        $("#" + zTree.setting.treeId).removeClass('node-edit-status');
                    } else {
                        ztreeArgu.zTreeIsEditState = true;
                        $(this).addClass('icon-complete-management').removeClass('icon-set');
                    }
                });

                //树状里面的搜索节点执行的函数
                $(".pe-tree-form-text").keyup(function (e) {
                    var e = e || window.event;
                        e.stopPropagation();
                    var thisSearchVal = $.trim($(this).val());
                    if(e.keyCode === 13 || e.keyCode === 108){
                        searchNode(null,'peZtreeMain');
                    }
                    if(!thisSearchVal){
                        searchNode(null,'peZtreeMain');
                    }
                });

                /*输入框类型树之搜索树内节点功能*/
                if(settingUrl.treeSearch){
                    settingUrl.treeSearch.keyup(function(){
                        var thisSearchVal = $.trim($(this).val());
                        if($.trim(thisSearchVal)){
                            $(this).next('input[type="hidden"]').val('')
                        }
                            searchNode(settingUrl.treeSearch);
                    });
                    settingUrl.treeSearch.focus(function(){
                        if(!$.trim($(this).val())){
                            searchNode(settingUrl.treeSearch);
                        }
                    })
                }

                //树状里面的搜索框里关闭 及 搜索节点 方法 按钮点击事件
                $('.pe-tree-search-btn').off('click').click(function (e) {
                    var e = e || window.event;
                        e.stopPropagation();
                    if (!$(this).hasClass('icon-search-magnifier')) {
                        $(this).siblings('.pe-tree-form-text').val('');
                    }
                    searchNode(null,'peZtreeMain');
                });

                /*用户管理表格之类别展开收起渲染表格滚动条重新渲染函数*/
                function userManageTableRenderOne(t){
                    if($.isArray(t.options.fixedTableTempId)){
                        $.each(t.options.fixedTableTempId,function(i,v){
                            $('.pe-stand-table-main-panel').append(_.template($('#'+ v).html())({peData: t.data}));
                        });
                    }
                    var _thisScrollTable = $('.userManage-scroll-table');
                    if(_thisScrollTable.get(0)){
                        if($('.pe-fixed-table-panel').get(0)&& (t.data.rows && t.data.rows.length === 0)){
                            $('.pe-fixed-table-panel').hide();
                            $('.pe-scrollTable-wrap').mCustomScrollbar('destroy').mCustomScrollbar({
                                axis: "x",
                                theme: "dark-3",
                                scrollbarPosition: "inside",
                                setWidth: '883px',
                                advanced: {updateOnContentResize: true}
                            });
                            if(!$('.user-manage-empty').get(0)){
                                var emptyDom =  '<div class="user-manage-empty"><div class="pe-result-no-date"></div>'
                                    +'<p class="pe-result-date-warn" style="text-align:center;">暂无数据</p></div>';
                                $('.pe-stand-table-main-panel').append(emptyDom);
                            }else{
                                $('.user-manage-empty').show();
                            }

                            $('.pe-scrollTable-wrap').hide();
                            $('.pe-stand-table-pagination').hide();
                            $('.userMana-right-fixed-table').hide();
                            $('.userMana-left-fixed-table').hide();
                            _thisScrollTable.css('paddingLeft','15px');
                            $('.pe-stand-table-wrap').width(883);
                            $('.mCSB_container').width(883);
                        }else{
                            $('.user-manage-empty').hide();
                            $('.pe-scrollTable-wrap').show();
                            $('.pe-stand-table-pagination').show();
                            $('.userMana-right-fixed-table').show();
                            $('.userMana-left-fixed-table').show();
                            $('.pe-scrollTable-wrap').mCustomScrollbar('destroy').mCustomScrollbar({
                                axis: "x",
                                theme: "dark-3",
                                scrollbarPosition: "inside",
                                setWidth: '500px',
                                advanced: {updateOnContentResize: true}
                            });
                            _thisScrollTable.css('paddingLeft','299px');
                            if($('.pe-stand-table-wrap').width() <= 500){
                                $('.userMana-left-fixed-table').css('borderRight','none');
                                $('.userMana-right-fixed-table').css('borderLeft','none');
                            }
                        }
                        $('.userMana-right-fixed-table').css('left',_thisScrollTable.outerWidth());
                    }
                    PEBASE.peFormEvent('checkbox');
                }
                function userManageTableRenderTwo(t){
                    if($.isArray(t.options.fixedTableTempId)){
                        $.each(t.options.fixedTableTempId,function(i,v){
                            $('.pe-stand-table-main-panel').append(_.template($('#'+ v).html())({peData: t.data}));
                        });
                    }
                    var _thisScrollTable = $('.userManage-scroll-table');
                    if(_thisScrollTable.get(0)){
                        if($('.pe-fixed-table-panel').get(0)&& (t.data.rows && t.data.rows.length === 0)){
                            $('.pe-fixed-table-panel').hide();
                            $('.pe-scrollTable-wrap').mCustomScrollbar('destroy').mCustomScrollbar({
                                axis: "x",
                                theme: "dark-3",
                                scrollbarPosition: "inside",
                                setWidth: '1168px',
                                advanced: {updateOnContentResize: true}
                            });
                            _thisScrollTable.css('paddingLeft','15px');
                            if(!$('.user-manage-empty').get(0)){
                                var emptyDom =  '<div class="user-manage-empty"><div class="pe-result-no-date"></div>'
                                    +'<p class="pe-result-date-warn" style="text-align:center;">暂无数据</p></div>';
                                $('.pe-stand-table-main-panel').append(emptyDom);
                            }else{
                                $('.user-manage-empty').show();
                            }

                            $('.pe-scrollTable-wrap').hide();
                            $('.pe-stand-table-pagination').hide();
                            $('.userMana-right-fixed-table').hide();
                            $('.userMana-left-fixed-table').hide();
                            $('.pe-stand-table-wrap').width(1168);
                            $('.mCSB_container').width(1168);
                        }else{
                            $('.user-manage-empty').hide();
                            $('.pe-scrollTable-wrap').show();
                            $('.pe-stand-table-pagination').show();
                            $('.userMana-right-fixed-table').show();
                            $('.userMana-left-fixed-table').show();
                            $('.pe-scrollTable-wrap').mCustomScrollbar('destroy').mCustomScrollbar({
                                axis: "x",
                                theme: "dark-3",
                                scrollbarPosition: "inside",
                                setWidth: '774px',
                                advanced: {updateOnContentResize: true}
                            });
                            _thisScrollTable.css('paddingLeft','299px');
                            if($('.pe-stand-table-wrap').width() <= 774){
                                $('.userMana-left-fixed-table').css('borderRight','none');
                                $('.userMana-right-fixed-table').css('borderLeft','none');
                            }
                        }
                        $('.userMana-right-fixed-table').css('left',_thisScrollTable.outerWidth());
                    }
                    PEBASE.peFormEvent('checkbox');
                }

                //类别树上的类别收起按钮点击事件
                $('button.icon-hide-category').undelegate('click');
                $('button.category-show-btn').undelegate('click');
                $('body').delegate('button.icon-hide-category','click',function(){
                    var thisTableType = $(this).attr('data-type');
                    $('.pe-classify-wrap').fadeOut(200,'linear',function(){
                        $('.pe-classify-wrap').hide();
                        $('.pe-manage-content-right').animate({
                            marginLeft:0
                        },200,function(){
                            $('.category-show-btn').show();
                            if(thisTableType === 'userManage'){
                                $('.pe-stand-table-wrap').peGrid('userExtendTable',true,userManageTableRenderTwo);
                            }
                        });
                    })


                });
                $('body').delegate('.category-show-btn','click',function(){
                    var thisTableType = $('button.icon-hide-category').attr('data-type');
                    $('.category-show-btn').hide();
                    $('.pe-manage-content-right').animate({
                        marginLeft:285
                    },200,function(){
                        if(thisTableType === 'userManage'){
                            $('.pe-stand-table-wrap').peGrid('userExtendTable',false,userManageTableRenderOne);
                        }
                        $('.pe-classify-wrap').fadeIn(200,'linear',function(){
                            $('.pe-classify-wrap').find('.pe-tree-search-btn').show();
                        })
                    });

                })
            });

            function checkVisibleParentNode(node){
                var thisDom = $('#' + node.tId);
                if(thisDom.get(0)){
                    return true;
                }else{
                    return false;
                }
            }

            //处理搜索结果的样式
            function updateNodes(highlight,val,searchTree) {
                if(ztreeArgu.nodeList.length !== 0){
                    $('.node-search-empty').hide();
                    for (var i = 0, l = ztreeArgu.nodeList.length; i < l; i++) {
                        if(!$.isEmptyObject(ztreeArgu.nodeList[i])){

                            ztreeArgu.nodeList[i].searchMatch = true;
                            var $thisMatchNode =   $('#'+ ztreeArgu.nodeList[i].tId);
                            var level = ztreeArgu.nodeList[i].level;
                            if($thisMatchNode.get(0)){
                                $thisMatchNode.removeClass('node-hide').parents('li').removeClass('node-hide');
                            }else{
                                var matchParentNode = ztreeArgu.nodeList[i].getParentNode();
                                for(var k =0;k<level;k++){
                                    if(checkVisibleParentNode(matchParentNode)){
                                        $('#'+ matchParentNode.tId).removeClass('node-hide').parents('li').removeClass('node-hide');
                                    }else{
                                        matchParentNode = matchParentNode.getParentNode();
                                        continue;
                                    }
                                }
                            }
                        }

                        ztreeArgu.nodeList[i].highlight = highlight;
                        searchTree.updateNode(ztreeArgu.nodeList[i], null, val);
                    }
                }else{
                    $('.node-search-empty').show();
                }

            }

            //在树中搜索函数
            function searchNode(inputSearchDom,zTreePid) {

                var searchTree =  $.fn.zTree.getZTreeObj(zTreePid);
                var value='';
                if(inputSearchDom){
                    value = inputSearchDom.val();
                }else{
                    value = $.trim($(".pe-tree-form-text").get(0).value);
                }

                var keyType = "name";
                ztreeArgu.nodeList = searchTree.getNodesByParamFuzzy(keyType, value,null,'search');
                updateNodes(true,value,searchTree);
            }

            //搜索结果
            function getFontCss(treeId, treeNode) {
                return (!!treeNode.highlight) ? 'match-node' : '';
            }

            //点击展开节点,刷新右边表格数据
            function onClick(e, treeId, treeNode) {
                //往后台传输需要展示的数据的参数
                //var zTree = $.fn.zTree.getZTreeObj(domId);
                zTree.expandNode(treeNode);
                zTree.clickNode(treeNode);
                $('#' + domId).mCustomScrollbar("update");
            }

            //checkbox的点击事件
            function zTreeOnCheck(e,treeId,treeNode){
                zTree.checkboxFuc(zTree,treeNode);
            }


            //beforeRemove删除操作之前的执行的检查
            function beforeRemove(treeId, treeNode) {
                var zTree = $.fn.zTree.getZTreeObj(treeId);
                var opt = zTree.opt;
                //删除前的检查
                var formData = {
                    'id': treeNode.id
                };

                var deleContent = opt.deleContent;
                if (!deleContent) {
                    deleContent = '<div><h3 class="pe-dialog-content-head">确定删除这个类别？</h3><p class="pe-dialog-content-tip">删除后将不能恢复，请谨慎操作！</p></div>';
                }
                PEMO.DIALOG.confirmR({
                    content: deleContent,
                    close: false,
                    height: 90,
                    id: 'deleNodeTip',
                    resize:false,
                    onlyOk: false,//如果为true,就只有确定的按钮;
                    btn2: function () {
                        //zTree.selectNode(treeNode);
                        $.ajax({
                            url: opt.deleUrl,
                            data: formData,
                            dataType: 'json',
                            success: function (data) {
                                if (data.success) {
                                    var thisDelePN = treeNode.getParentNode();
                                    zTree.removeNode(treeNode);
                                    thisDelePN.isParent = true;
                                    thisDelePN.open = false;
                                    if (thisDelePN.children.length === 0) {
                                        thisDelePN.children = null;
                                    }

                                    zTree.updateNode(thisDelePN);
                                    PEMO.DIALOG.tips({
                                        content: data.message,
                                        time: 2000
                                    })
                                } else {
                                    // PEMO.DIALOG.tips({
                                    //     content: data.message,
                                    //     time:2000
                                    // })
                                    PEMO.DIALOG.alert({
                                        content: data.message,
                                        btn: ['我知道了'],
                                        yes: function () {
                                            layer.closeAll();
                                            return false;
                                        }
                                    });

                                }
                            }
                        });
                        return true;
                    },
                    btn1:function(){
                        layer.closeAll();
                    }
                });
                return false;
            }


            //展现节点的删除按钮,返回true展现删除按钮，返回false不展示
            function showRemoveBtn(treeId, treeNode) {

                if (ztreeArgu.zTreeIsEditState) {
                    //domId为本次ztree的主要渲染的ul的id,本次为根目录不允许出现删除按钮
                    if (!treeNode.pId) {
                        return false;
                    } else {
                        return true;
                    }
                }
            }

            //鼠标hover上树节点添加编辑按钮事件
            function addHoverDom(treeId, treeNode) {
                treeNode.opt = settingUrl.optUrl;
                var thisNodeA = $("#" + treeNode.tId +'_a');

                if($("#" + treeId).find('.rename').get(0)){
                    return false;
                }
                if(thisNodeA.hasClass('curSelectedNode_Edit') || thisNodeA.find('.button.okBtn').get(0)){
                    return false;
                }
                //更加path数量判断是几级
                var nodePath = treeNode.getPath();
                if(settingUrl.treePosition === 'inputDropDown'){
                    thisNodeA.addClass('zTree-input-node-hover-bg');//#96e4f9
                }else{
                    thisNodeA.addClass('zTree-node-hover-bg');//#96e4f9
                }


                if (ztreeArgu.zTreeIsEditState){
                    if(settingUrl.treeRenderType === 'organize'){
                        $("#" + treeId).addClass('organize-edit-status');
                    }else{
                        $("#" + treeId).addClass('node-edit-status');
                    }

                    var sObj = $("#" + treeNode.tId + "_span");
                    var optBtnWrap = $("#" + treeNode.tId + "_a").find('.node-opt-btn-wrap');

                    if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0) return;
                    var addStr = '';
                    if (nodePath.length === 6) {
                         addStr = '';
                    } else {
                         addStr = addStr + "<span class='button iconfont icon-new-add add' id='addBtn_" + treeNode.tId + "' title='新增'></span>";
                    }

                    var addStr2 = '';
                    if (treeNode.pId && (!$("#editBtn_" + treeNode.tId).get(0)) && treeNode.canEdit) {
                        addStr = addStr + "<span class='button iconfont icon-edit edit' id='editBtn_" + treeNode.tId + "' title='编辑'></span>";
                    }
                    if (!($("#moveDownBtn_" + treeNode.tId).length > 0) && !treeNode.isLastNode) {
                        addStr2 = "<span class='button iconfont icon-down moveDown' id='moveDownBtn_" + treeNode.tId + "' title='下移'></span>";
                    }
                    if (!($("#moveUpBtn_" + treeNode.tId).length > 0) && !treeNode.isFirstNode) {
                        addStr2 = addStr2 + "<span class='button iconfont icon-up moveUp' id='moveUpBtn_" + treeNode.tId + "' title='上移'></span>";
                    }
                    optBtnWrap.append(addStr2);
                    optBtnWrap.prepend(addStr);

                    // deleObj.after(addStr2);
                    var addBtn = $("#addBtn_" + treeNode.tId);
                    var editBtn = $("#editBtn_" + treeNode.tId);
                    var downBtn = $("#moveDownBtn_" + treeNode.tId);
                    var upBtn = $("#moveUpBtn_" + treeNode.tId);

                    //节点新增函数
                    if (addBtn) {
                        //var zTree = $.fn.zTree.getZTreeObj(domId);
                        PEMO.ZTREE.addNodeBindEvent(addBtn,domId,zTree,treeNode,settingUrl);
                    }
                    //节点编辑函数
                    if (editBtn) {
                        //var zTree = $.fn.zTree.getZTreeObj(domId);
                        editBtn.bind("click", function () {
                            if (settingUrl.editNodeFunc) {
                                zTree.editNodeFunc(zTree, treeNode);
                            } else {
                                PEMO.ZTREE.editNode(treeNode, zTree, settingUrl.optUrl);
                            }
                        })
                    }

                    //节点下移函数
                    if (downBtn) {
                        downBtn.bind("click", function () {
                            ztreeArgu.zTreeObj.moveNode(treeNode.getNextNode(), treeNode, "next");
                        })
                    }

                    //节点上移函数
                    if (upBtn) {
                        upBtn.bind("click", function () {
                            ztreeArgu.zTreeObj.moveNode(treeNode.getPreNode(), treeNode, "prev");
                        })
                    }

                }
            }

            function removeHoverDom(treeId, treeNode) {
                var thisNodeA = $("#" + treeNode.tId + '_a');
                if(settingUrl.treePosition === 'inputDropDown'){
                    thisNodeA.removeClass('zTree-input-node-hover-bg');//#96e4f9
                }else {
                    thisNodeA.removeClass('zTree-node-hover-bg');
                }
                if (ztreeArgu.zTreeIsEditState) {
                    if(!(settingUrl.type === 'organize' && treeNode.level === 0)){
                        $("#addBtn_" + treeNode.tId).unbind().remove();
                    }
                    $("#editBtn_" + treeNode.tId).unbind().remove();
                    $("#deleBtn_" + treeNode.tId).unbind().remove();
                    $("#moveDownBtn_" + treeNode.tId).unbind().remove();
                    $("#moveUpBtn_" + treeNode.tId).unbind().remove();
                    if(settingUrl.type === 'organize' && treeNode.level === 0){
                        thisNodeA.find('.node-opt-btn-wrap').find('.button:not(.add)').remove();
                    }else{
                        thisNodeA.find('.node-opt-btn-wrap').html('');
                    }

                    /*新增节点的时候，似乎先触发新节点的removeHoverDom事件，此时此刻treeNode只向新建的node，在后面触发点击新增按钮的那个节点*/
                    if (treeNode.editNameFlag && !$("#" + treeNode.parentTId).find(".button.cancelBtn").get(0)) {
                        var sObj = $("#" + treeNode.tId + "_span");
                        var addComfir = "<span class='button okBtn' id='okNodeBtn" + treeNode.tId
                            + "' title='确定'>确定</span><span class='button cancelBtn' id='cancelNodeBtn" + treeNode.tId
                            + "' title='取消'>取消</span>";
                        sObj.after(addComfir);
                        $("#" + treeNode.tId + '_a').removeClass('zTree-node-hover-bg');
                        var $okBtn = thisNodeA.find(".button.okBtn");
                        var $cancelBtn = thisNodeA.find(".button.cancelBtn");
                        if($okBtn.get(0)){
                            $okBtn.click(function(){
                                var thisVal = $(this).siblings('.rename').val();
                                PEMO.ZTREE.addNode(treeNode,thisVal,zTree);
                            })
                        }
                        if($cancelBtn.get(0)){
                            $cancelBtn.click(function(){
                                zTree.editObj.cancelNewNode(zTree.setting,treeNode,zTree);
                            });

                        }
                    }
                }
            }
        },

        addNodeBindEvent:function(addBtn,domId,zTree,treeNode,settingUrl){
            var thisNodeA = $("#" + treeNode.tId +'_a');
            addBtn.off().bind("click", function (e) {
                var e = e || window.event;
                    e.stopPropagation();
                if($('#' + domId).find('input[treenode_input]').get(0)){
                    $('#' + domId).find('input[treenode_input]').blur();
                }
                if (settingUrl.addNodeFunc) {
                    //如果有自定义的新增节点函数，则在页面中执行新曾的函数
                    zTree.addNodeFunc(zTree, treeNode);
                } else {
                    zTree.addNodes(treeNode, {
                        id: 'newNodeId',
                        pId: treeNode.id,
                        name: "默认新节点",
                        "isParent": true
                    });
                    var newChildNode = treeNode.children[treeNode.children.length - 1];
                    settingUrl.optUrl.isNewNode = true;
                    zTree.editName(newChildNode, zTree);
                }
                if(!(settingUrl.type === 'organize' && treeNode.level === 0)){
                    thisNodeA.find('.node-opt-btn-wrap').html('');
                }

                return false;
            });
        },
        // //上下移动节点后回调函数用于保存节点
        saveNodeMove: function (targetNode, moveNode, type, zTree) {
            var isUp = type === 'prev';
            var param = {
                id: moveNode.id,
                isUp: isUp
            };
            $.ajax({
                url: zTree.opt.moveUrl,
                data: param,
                dataType: 'json',
                success: function (data) {
                    if (data.success) {
                        zTree.updateNode(moveNode);
                        zTree.updateNode(targetNode);
                        return true;
                    } else {
                        PEMO.DIALOG.tips({
                            content: data.message,
                            time: 3000
                        });
                        return false;
                    }
                }
            })
        },
        addNode: function (node, inputVal, zTree) {
            var thisNode = zTree.getNodeByTId(node.tId);
            var formData = {
                'pId': node.pId,
                'name': inputVal,
                'id': node.id
            };
            if (zTree.opt.isNewNode) {
                if(!inputVal){
                    zTree.removeNode(thisNode);
                    return false;
                }

                $.ajax({
                    url: zTree.opt.addUrl,
                    data: formData,
                    dataType: 'json',
                    success: function (data) {
                        if (data.success) {

                            thisNode.name = inputVal;
                            thisNode.pId = node.pId;
                            thisNode.id = data.data.id;
                            thisNode.canEdit = true;
                            zTree.updateNode(thisNode);
                            var thisNewPre = thisNode.getPreNode();
                            var thisNewNExt = thisNode.getNextNode();
                            zTree.updateNode(thisNewPre);
                            zTree.updateNode(thisNewNExt);
                            zTree.opt.isNewNode =false;
                            zTree.editObj.editNodeBlur = true;
                            zTree.editObj.cancelCurEditNode(zTree.setting,null,null,'okBtn');
                            return true;
                        } else {
                            zTree.removeNode(thisNode);
                            PEMO.DIALOG.tips({
                                content: data.message,
                                time: 2000
                            });
                            return false;
                        }
                        zTree.opt.isNewNode = false;
                    },
                    error:function(){
                    }
                });
            } else {
                if(!inputVal){
                    return false;
                }

                $.ajax({
                    url: zTree.opt.editUrl,
                    data: formData,
                    dataType: 'json',
                    success: function (data) {
                        if (data.success) {
                            var thisNode = zTree.getNodeByTId(node.tId);
                            thisNode.name = inputVal;
                            thisNode.pId = node.pId;
                            thisNode.id = node.id;
                            zTree.updateNode(thisNode);
                            zTree.editObj.editNodeBlur = true;
                            zTree.editObj.cancelCurEditNode(zTree.setting,null,null,'okBtn');
                            return true;
                        } else {
                            PEMO.DIALOG.tips({
                                content: data.message,
                                time: 2000
                            });
                            return false;
                        }
                    },
                    error:function(){
                    }
                });
            }

        },
        editNode: function (treeNode, zTree, opt) {
            zTree.editName(treeNode, zTree);
        },
        searchInput: function () {

        }
    },
    AUDIOOBJ:{
        oldSrc:'',
        obj:{}
    },
    //音视频
    AUDIOPLAYER:function(audioPath,isPlaying,isLoop){
        if(!PEMO.AUDIOOBJ.oldSrc ){
            PEMO.AUDIOOBJ.oldSrc = audioPath;
        }
        /*音频，不在单独弄*/
        if(isPlaying){
            PEMO.AUDIOOBJ.obj.player_.pause();
        }else{
            if(!$('#peAudioPlayer').get(0) || ($('#peAudioPlayer').get(0) && PEMO.AUDIOOBJ.oldSrc !== audioPath)){
                PEMO.AUDIOOBJ.oldSrc = audioPath;
                var audioObj = null;
                // PEMO.AUDIOOBJ.oldSrc = '';
                if(isLoop){
                    var audioDom =  '<video id="peAudioPlayer" loop="true" data-type="audio"  class="video-js music-audio-panel vjs-default-skin pe-video-player-panel" controls preload="none" width="0" height="0" poster="">'
                        +'<source src="'+ audioPath+'" type="audio/mp3" /></video>';
                }else{
                    var audioDom =  '<video id="peAudioPlayer" data-type="audio"  class="video-js music-audio-panel vjs-default-skin pe-video-player-panel" controls preload="none" width="0" height="0" poster="">'
                        +'<source src="'+ audioPath+'" type="audio/mp3" /></video>';
                }
                $('#peAudioPlayer').remove();
                $('body').append(audioDom);
                PEMO.AUDIOOBJ.obj = videojs(document.getElementById('peAudioPlayer'), {autoplay:"autoplay"}, function(e){

                });
            }else{
                PEMO.AUDIOOBJ.obj.player_.play();
            }
        }

    },
    VIDEOPLAYER:function(videoPath,videoDom){
        if(!$.isEmptyObject(PEMO.AUDIOOBJ.obj)){
            PEMO.AUDIOOBJ.obj.player_.pause();
            var audioDoms = $('.image-audio');
            if(audioDoms.get(0)){
                for(var i =0,iLen=audioDoms.length;i<iLen;i++){
                    if($(audioDoms[i]).hasClass('audio-playing')|| $(audioDoms[i]).hasClass('audio-pause')){
                        var audioIconSrc = $(audioDoms[i]).attr('src').replace(/audio_pause.png|audio_playing.gif/ig,'default-music.png');
                        $(audioDoms[i]).removeClass('audio-playing audio-pause');
                        $(audioDoms[i]).attr('src',audioIconSrc);
                    }
                }
            }
        }
         var videoDom =  '<div class="video-mask-panel"></div>'
                        +'<video id="peVideoPlayer" class="video-js vjs-default-skin pe-video-player-panel" controls preload="auto" width="640" height="480" poster="">'
                        +'<source src="'+ videoPath+'" type="video/mp4" /></video>'
                        +'<a class="video-close-btn viewer-button viewer-close iconfont icon-wrong" data-action="mix"><div style="position:relative;"><div class="viewer-ripple"></div></div></a>';
        if(!$('#peVideoPlayer').get(0)){
            $('body').append(videoDom);
            videojs(document.getElementById('peVideoPlayer'), {preload:'none'}, function(e){
                $('.video-mask-panel').height(20000);
            });
        }
        $('.video-close-btn').click(function () {
            $('#peVideoPlayer').remove();
            $('.video-mask-panel').remove();
            $('.video-close-btn').remove();
        })

    }
};

var PEBASE = {
    publickHeader: function (setting) {
        //头部导航hover效果
        $('.pe-classify-detail').hover(
            function (e) {
                var e = e || window.event;
                e.stopPropagation();
                e.preventDefault();
                $(this).find('.pe-classify-sub-nav').show();
                $(this).find('.classify-link').addClass('classify-link-hover');
            },
            function (e) {
                var e = e || window.event;
                e.stopPropagation();
                $(this).find('.pe-classify-sub-nav').hide();
                $(this).find('.classify-link').removeClass('classify-link-hover');
            }
        );
        //头部导航下拉菜单点击事件
        //$('.pe-classify-detail')
    },
    peFormEvent: function (type, obj) {
        // $('body').undelegate('.pe-'+ type + ':not(".pe-check-by-list")','click').delegate('.pe-'+ type + ':not(".pe-check-by-list")','click',function(e){
          $('.pe-' + type).not('.pe-check-by-list').off('click').click(function (e) {
            var e = e || window.event;
            e.stopPropagation();
            e.preventDefault();
              if($(this).hasClass('noClick')){
                  return false;
              }else{

            var clickDom = e.target || e.srcElement;
            var _thisDom = $(this);
            var _thisParent = _thisDom.closest('.pe-stand-table-panel');
            var iconCheck = _thisDom.find('span.iconfont');

            var thisRealCheck = _thisDom.find('input[type="' + type + '"]');
            if(thisRealCheck.attr('disabled')){
                return false;
            }

            if(thisRealCheck.closest('.pe-input-tree-wrap-drop').get(0)){
                if (obj && obj.func1 && !obj.func1(type, thisRealCheck)) {
                    return false;
                }
            }


            if (type === 'checkbox') {
                if (iconCheck.hasClass('icon-unchecked-checkbox')) {
                    iconCheck.removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox');
                    if (!iconCheck.closest('pe-paper-all-check').get(0)) {
                        iconCheck.addClass('peChecked');
                    }
                    thisRealCheck.prop('checked', 'checked');//
                    if (_thisParent.find('.pe-paper-all-check').get(0)) {
                        var thisTableAllchecks = _thisParent.find('.pe-checkbox').not('.pe-paper-all-check');
                        if (!thisTableAllchecks.find('span.icon-unchecked-checkbox').get(0)) {
                            _thisParent.find('.pe-paper-all-check')
                                .find('span.iconfont')
                                .removeClass('icon-unchecked-checkbox')
                                .addClass('icon-checked-checkbox peChecked');
                        }
                    }
                    if ($(clickDom).closest('.pe-paper-all-check').get(0)) {
                        if ($(clickDom).closest('.pe-stand-table-panel').get(0)) {
                            var theseCheckboxs = $(clickDom).closest('.pe-stand-table-panel').find('.pe-checkbox');
                            theseCheckboxs.not('.pe-paper-all-check')
                                .find('span.iconfont')
                                .removeClass('icon-unchecked-checkbox').addClass('icon-checked-checkbox peChecked');
                            theseCheckboxs.not('.pe-paper-all-check').find('input[type="' + type + '"]').prop('checked', 'checked');
                        }
                    }
                } else {
                    iconCheck.removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                    thisRealCheck.removeProp('checked');
                    thisRealCheck.removeAttr('checked');
                    if (!iconCheck.parents('pe-paper-all-check').get(0)) {
                        iconCheck.removeClass('peChecked');
                    }
                    var thisTableAllchecks = _thisParent.find('.pe-checkbox').not('.pe-paper-all-check');
                    if (thisTableAllchecks.find('span.icon-unchecked-checkbox').get(0)) {
                        _thisParent.find('.pe-paper-all-check')
                            .find('span.iconfont')
                            .removeClass('icon-checked-checkbox peChecked')
                            .addClass('icon-unchecked-checkbox ');
                    }

                    if ($(clickDom).closest('.pe-paper-all-check').get(0)) {
                        if ($(clickDom).closest('.pe-stand-table-panel').get(0)) {
                            var theseCheckboxs = $(clickDom).closest('.pe-stand-table-panel').find('.pe-checkbox');
                            theseCheckboxs.not('.pe-paper-all-check')
                                .find('span.iconfont')
                                .addClass('icon-unchecked-checkbox').removeClass('icon-checked-checkbox peChecked');
                            theseCheckboxs.not('.pe-paper-all-check').find('input[type="' + type + '"]').removeProp('checked');
                        }
                    }
                }
            } else {
                var thisRadioName = thisRealCheck.attr('name');
                var thisRadiosIcons = $('input[name="' + thisRadioName + '"]');
                //待选择好radio的图标即可启用
                if (iconCheck.hasClass('icon-unchecked-radio')) {
                    for (var i = 0; i < thisRadiosIcons.length; i++) {
                        $(thisRadiosIcons[i]).closest('.pe-radio').find('span.iconfont').removeClass('icon-checked-radio peChecked').addClass('icon-unchecked-radio');
                        $(thisRadiosIcons[i]).removeAttr('checked');
                    }

                    thisRadiosIcons.removeClass('icon-unchecked-radio');
                    iconCheck.removeClass('icon-unchecked-radio').addClass('icon-checked-radio ');
                    if (!iconCheck.closest('pe-paper-all-check').get(0)) {
                        iconCheck.addClass('peChecked');
                    }
                    thisRealCheck.prop('checked', true);
                } else {

                }

            }
            if (obj && obj.func2) {
                obj.func2(thisRealCheck);
            }

          }
        })
    },
    peSelect: function (domSelect, cutOff, saveDom, tableDom,selfFunc) {
        domSelect.easyDropDown({
            "cutOff": cutOff || 6,//默认展示几行
            "tableDom": tableDom,
            "onChange": function (select) { //框中选择改变时执行的函数

                var thisSelctWrap = domSelect.parents('.pe-stand-pagination').get(0) || domSelect.parents('.layer-page-wrap').get(0);
                if (thisSelctWrap) {
                    tableDom.peGrid('pagiSizeChangeLoad', parseInt(select.value));
                }
                if(saveDom){
                    saveDom.val(select.value);
                }

                if(selfFunc && $.isFunction(selfFunc)){
                    selfFunc(select.value);
                }
            }
        });
    },
    pagiArrowClick: function (dom, tableDom) {
        if(!$(parent.window.document).find('.layui-layer .layer-page-wrap').get(0) && ($(tableDom).siblings('.pe-stand-table-pagination').get(0) || $(tableDom).parents('.pe-scrollTable-wrap').siblings('.pe-stand-table-pagination').get(0))){
            var pagiSelect = $('.pe-stand-pagination .selected');
            var pagiDropDownWrap = $('.pe-stand-pagination .drop-down-wrap');
            var pagiSave = $('.pe-stand-pagination input[name="savePaginationPageSize"]');
        }else{
            var pagiSelect = $(parent.window.document).find('.layer-page-wrap .selected');
            var pagiDropDownWrap = $(parent.window.document).find('.layer-page-wrap .drop-down-wrap');
            var pagiSave = $(parent.window.document).find('.layer-page-wrap input[name="savePaginationPageSize"]');
        }
        var selectPageSize = parseInt(pagiDropDownWrap.find('.active').html());
        if (!dom.isTable && dom.hasClass('pageSize-arrow')) {
            var nowPageSize = 10;
            selectPageSize = parseInt(pagiSelect.html());
            if (selectPageSize === 10) {
                if (dom.hasClass('pagination-down')) {
                    dom.addClass('disabled');
                    return false;
                } else {
                    pagiDropDownWrap.find('.active').removeClass('active').next('li').eq(0).addClass('active');
                    pagiSelect.html(20);
                    pagiSave.val(20);
                    dom.siblings('.pagination-down').removeClass('disabled');
                    nowPageSize = 20;
                }

            } else if (selectPageSize === 20) {
                if (dom.hasClass('pagination-down')) {
                    pagiDropDownWrap.find('.active').removeClass('active').prev('li').eq(0).addClass('active');
                    pagiSelect.html(10);
                    pagiSave.val(10);
                    dom.addClass('disabled');
                    nowPageSize = 10;
                } else {
                    pagiDropDownWrap.find('.active').removeClass('active').next('li').eq(0).addClass('active');
                    pagiSelect.html(50);
                    pagiSave.val(50);
                    nowPageSize = 50;
                }
            } else if (selectPageSize === 50) {
                if (dom.hasClass('pagination-down')) {
                    pagiDropDownWrap.find('.active').removeClass('active').prev('li').eq(0).addClass('active');
                    pagiSelect.html(20);
                    pagiSave.val(20);
                    nowPageSize = 20;
                } else {
                    pagiDropDownWrap.find('.active').removeClass('active').next('li').eq(0).addClass('active');
                    pagiSelect.html(100);
                    pagiSave.val(100);
                    dom.addClass('disabled');
                    nowPageSize = 100;
                }
            } else if (selectPageSize === 100) {
                if (dom.hasClass('pagination-down')) {
                    pagiDropDownWrap.find('.active').removeClass('active').prev('li').eq(0).addClass('active');
                    pagiSelect.html(50);
                    pagiSave.val(50);
                    dom.siblings('.pagination-up').removeClass('disabled');
                    nowPageSize = 50;
                } else {
                    dom.addClass('disabled');
                    return false;
                }
            }
            tableDom.peGrid('pagiSizeChangeLoad', parseInt(nowPageSize));
        } else if (dom && (dom.isTable || dom.hasClass('select-item')) && dom.html) {
            if ((!$(dom).hasClass('select-item') && dom.domData.pageSize === 20) || parseInt(dom.html()) == 20) {
                pagiDropDownWrap.find('li').removeClass('active').eq(1).addClass('active');
                pagiSelect.html(20);
                pagiSave.val(20);
                pagiDropDownWrap.siblings('.pagination-up').removeClass('disabled');
                pagiDropDownWrap.siblings('.pagination-down').removeClass('disabled');
            } else if ((!$(dom).hasClass('select-item') && dom.domData.pageSize === 50) || parseInt(dom.html()) == 50) {
                pagiDropDownWrap.find('li').removeClass('active').eq(2).addClass('active');
                pagiSelect.html(50);
                pagiSave.val(50);
                pagiDropDownWrap.siblings('.pagination-up').removeClass('disabled');
                pagiDropDownWrap.siblings('.pagination-down').removeClass('disabled');
            } else if ((!$(dom).hasClass('select-item') && dom.domData.pageSize === 100) || parseInt(dom.html()) == 100) {
                pagiDropDownWrap.find('li').removeClass('active').eq(3).addClass('active');
                pagiSelect.html(100);
                pagiSave.val(100);
                pagiDropDownWrap.siblings('.pagination-up').addClass('disabled');
            } else if ((!$(dom).hasClass('select-item') && dom.domData.pageSize === 10) || parseInt(dom.html()) == 10) {
                pagiDropDownWrap.find('li').removeClass('active').eq(0).addClass('active');
                pagiSelect.html(10);
                pagiSave.val(10);
                pagiDropDownWrap.siblings('.pagination-down').addClass('disabled');
            }

            if(pagiDropDownWrap.get(0)){
                pagiDropDownWrap.height(0);
                pagiDropDownWrap.addClass('closeWrap');
            }
        }
        //})
    },
    inputTree: function (obj) {
        if (obj) {
            $(obj.dom + ','+ obj.dom +' .pe-input-tree-search-btn').off().click(function (e) {
                var e = e || window.event;
                    e.stopPropagation();
                    e.preventDefault();
                var thisWrapDom = $(this) || $(this).parent(obj.dom);
                var thisDropDown = $(this).find('.pe-input-tree-wrap-drop').get(0) || $(this).siblings('.pe-input-tree-wrap-drop').get(0);
                var visibleDropDown = $(this).find('.pe-input-tree-wrap-drop:visible').get(0) || $(this).siblings('.pe-input-tree-wrap-drop:visible').get(0);
                if(!visibleDropDown){
                    $('.pe-mask-listen').show();
                    $(thisDropDown).show();
                    if (!$(thisDropDown).find('.zTree-node-li').get(0) || obj.isRefresh) {
                        if(!obj.treeParam.width){
                            obj.treeParam.width = 211;
                        }

                        obj.treeParam.treePosition = 'inputDropDown';
                        PEMO.ZTREE.initTree(obj.treeId, obj.treeParam);

                        /*暂时解决 “新增用户”及“角色按人员查看的”的角色input框下拉当数据为空时的处理*/
                        if($('#roleTreeData').get(0)){
                            if(!$('#roleTreeData').find('.zTree-node-li').get(0)){
                                $('#roleTreeData').html('<div style="text-align:center;">暂无</div>');
                            }
                        }
                        if($.isFunction(obj.treeParam.isCheckHasChecked)){
                                obj.treeParam.isCheckHasChecked($.fn.zTree.getZTreeObj(obj.treeId));
                        }
                    }
                }
                if(visibleDropDown && $(this).hasClass('pe-input-tree-search-btn')){
                    $('.pe-mask-listen').hide();
                    $(thisDropDown).hide();
                }

                thisWrapDom.find('.pe-tree-show-name').focus();

                if ($(this).hasClass('pe-stand-filter-form-input') || $(this).parent('.pe-stand-filter-form-input').get(0)) {
                    var thisLabelSpan = $(this).find('.input-tree-choosen-label').find('span').get(0) || $(this).siblings('.input-tree-choosen-label').find('span').get(0);
                    if (thisLabelSpan) {
                        if($(this).hasClass('icon-class-tree')){
                            var thisClickDom = $(this);
                        }else{
                            var thisClickDom = $(this).find('.icon-class-tree');
                        }
                        thisClickDom.hide().siblings('.icon-inputDele').show();
                        // thisClickDom.removeClass('icon-class-tree').addClass('icon-inputDele');
                    }

                }
                if($(obj.dom).find('.pe-input-tree-children-container').get(0)){
                    $(obj.dom).find('.pe-input-tree-children-container').mCustomScrollbar({
                        axis: "y",
                        theme: "dark-3",
                        scrollbarPosition: "inside",
                        setWidth: '198px',
                        advanced: {updateOnContentResize: true}
                    });
                }

            });
            var $showInput = $('.pe-input-tree-wrap-drop').parent('div').find('.pe-tree-show-name');
            $('.pe-mask-listen').click(function () {
                var $thisShowInput = $('.pe-input-tree-wrap-drop:visible').prevAll('.pe-tree-show-name');
                $('.pe-input-tree-wrap-drop:visible').hide();
                if($thisShowInput.next('input[type="hidden"]').get(0) && !$.trim($thisShowInput.next('input[type="hidden"]').val())){
                    $showInput.val('');
                }

                $(this).hide();
                if ($(obj.dom).find('.icon-inputDele').get(0)) {
                    $(obj.dom).find('.icon-inputDele').hide().siblings('.icon-class-tree').show();
                }

            });
            var ua = navigator.userAgent.toLowerCase();
            var s = ua.match(/msie ([\d.]+)/);
            if(s && parseInt(s[1]) == 9){
                $.fn.ieInputChangeListen = function () {
                    return this.each(function () {
                        var $this = $(this);
                        var htmlold = $this.val();
                        $this.bind('blur keyup paste copy cut mouseup', function () {
                            var htmlnew = $this.val();
                            if (htmlold !== htmlnew) {
                                if(!$(this).val()){
                                    $(this).next('input[type="hidden"]').val('');
                                }
                            }
                        })
                    })
                }
                $showInput.ieInputChangeListen();
            }else{
                for(var n =0 ,nLen = $showInput.length;n < nLen;n++){
                    $showInput[n].oninput = $showInput[n].onpropertychange = function(e){
                        var e = e || window.event;
                        if(!$(this).val()){
                            $(this).next('input[type="hidden"]').val('');
                        }
                    };
                }
            }

        }
        if ($('.layui-layer:visible').get(0)) {
            $('.layui-layer:visible').click(function (e) {
                var e = e || window.event;
                var eDom = e.target || e.srcElement;
                if (!($(eDom).hasClass('pe-input-tree-wrap') || $(eDom).parents('.pe-input-tree-wrap').get(0))) {
                    $('.pe-input-tree-wrap-drop').hide();
                    var $showInput = $('.pe-input-tree-wrap-drop').parent('div').find('.pe-tree-show-name');
                    if($showInput.next('input[type="hidden"]').get(0) && !$.trim($showInput.next('input[type="hidden"]').val())){
                        $showInput.val('');
                    }
                    $('.pe-mask-listen').hide();
                }
            })
        }
        $('.pe-mask-listen').width(2000).height(10000);
    },
    ajaxRequest:function(setting){
        var defaults = {
            url : '',
            data : '',
            type : 'post',
            success : function(data){},
            async : true,
            dataType : 'json'
        };

        $.extend(defaults, setting);
        $.ajax({
            type: defaults.type,
            url: defaults.url,
            dataType: defaults.dataType,
            data:defaults.data,
            async:defaults.async,
            success:defaults.success,
            processData:defaults.processData,
            contentType:defaults.contentType
        });
    },
    formatSecond:function(value){
        if(!value){
            return '--';
        }

        var theTime = parseInt(value);
        var theTime1 = 0;
        var theTime2 = 0;
        if(theTime > 60) {
            theTime1 = parseInt(theTime/60);
            theTime = parseInt(theTime%60);
            if(theTime1 > 60) {
                theTime2 = parseInt(theTime1/60);
                theTime1 = parseInt(theTime1%60);
            }
        }
        var result = ""+parseInt(theTime)+"秒";
        if(theTime1 > 0) {
            result = ""+parseInt(theTime1)+"分"+result;
        }
        if(theTime2 > 0) {
            result = ""+parseInt(theTime2)+"时"+result;
        }
        return result;
    },
    serializeObject: function ($form) {
        var a, o, h, i, e;
        a = $form.serializeArray();
        o = {};
        h = o.hasOwnProperty;
        for (i = 0; i < a.length; i++) {
            e = a[i];
            if (!h.call(o, e.name)) {
                o[e.name] = e.value;
            }
        }
        return o;
    },

    /* paginationClickable: true,
     centeredSlide: true,
     freeModeFluid: true,
     grabCursor: true,
     slidesPerView: 'auto',
     updateOnImagesReady: true,
     watchActiveIndex: true,*/
    swiperObj:{},
    swiperBindTimes:0,
    swiperInitItem:function(wrapDom,index,isNeedPagination){
        var swiperDom = '.all-images-wrap'+ index + ' ' + ' .swiper-container';
        if(isNeedPagination){
            PEBASE.swiperObj[index] = new Swiper(swiperDom,{
                centeredSlide:true,
                freeModeFluid:true,
                grabCursor : true,
                updateOnImagesReady: true,
                slidesPerView:'auto',
                watchActiveIndex:true,
                onFirstInit:function(thisViewer,t){
                        $('.itemImageViewWrap').viewer({
                            url:'data-original',
                            title:false,
                            fullscreen:false,
                            show: function (d,t) {
                                $('.pe-answer-nav-top').css("zIndex", "-1");
                                $('.pe-answer-content-right-wrap').css("zIndex", "-1");
                                $('.pe-public-top-nav-header').css("zIndex", "-1");
                                var _thisSwiper = $(d.currentTarget).parent('.swiper-container');
                                $('.swiper-container').not(_thisSwiper).css('z-index','0');

                            },
                            hidden: function (d,t) {
                                $('.pe-answer-nav-top').css("zIndex", "1989");
                                $('.pe-answer-content-right-wrap').css("zIndex", "1989");
                                $('.pe-public-top-nav-header').css("zIndex", "1989");
                                var _thisSwiper = $(d.currentTarget).parent('.swiper-container');
                                $('.swiper-container').css('z-index','1');
                            }
                        });


                }
            });
        }else{
            PEBASE.swiperObj[index] = new Swiper(swiperDom,{
                pagination: '.pagination',
                paginationClickable: true,
                centeredSlide:true,
                freeModeFluid:true,
                grabCursor : true,
                slidesPerView:'auto',
                watchActiveIndex:true,
                onFirstInit:function(){
                        $('.itemImageViewWrap').viewer({
                            url:'data-original',
                            title:false,
                            fullscreen:false,
                            show: function (d,t) {
                                $('.pe-answer-nav-top').css("zIndex", "-1");
                                $('.pe-answer-content-right-wrap').css("zIndex", "-1");
                                $('.pe-public-top-nav-header').css("zIndex", "-1");
                                var _thisSwiper = $(d.currentTarget).parent('.swiper-container');
                                $('.swiper-container').not(_thisSwiper).css('z-index','0');

                            },
                            hidden: function (d,t) {
                                $('.pe-answer-nav-top').css("zIndex", "1989");
                                $('.pe-answer-content-right-wrap').css("zIndex", "1989");
                                $('.pe-public-top-nav-header').css("zIndex", "1989");
                                var _thisSwiper = $(d.currentTarget).parent('.swiper-container');
                                $('.swiper-container').css('z-index','1');
                            }
                        });
                }
            });
        }
        if(PEBASE.swiperBindTimes === 0){
            wrapDom.delegate('.upload-img','click',function(e){
                var e = e || window.event;
                e.stopPropagation();
                var _this = $(this);
                var swiperWrapper = _this.parents('.paper-add-question-content ').find('.swiper-wrapper');
                swiperWrapper.find('li').removeClass('image-icon-cur');
                var thisIdType = $(this).attr('data-index');
                swiperWrapper.find('li[data-index="'+ thisIdType+'"]').addClass('image-icon-cur');
                var thisIconIndex = swiperWrapper.find('li[data-index="'+ thisIdType+'"]').index();
                var thisSwiperIndex = parseInt(swiperWrapper.parents('.all-images-wrap').attr('data-index'));
                PEBASE.swiperObj[thisSwiperIndex].swipeTo(thisIdType);
            });
            PEBASE.swiperBindTimes = 1;
        }

    },
    peBubble:function(elm,setting){
        var $thisDotDom = $(elm);
        for(var i=0;i<$thisDotDom.length;i++){
            $($thisDotDom[i]).dotdotdot();
        }
    },
    isPlaceholder:function(){
        if(!placeholderSupport()){   // 判断浏览器是否支持 placeholder
            $('[placeholder]').focus(function() {
                var input = $(this);
                if (input.val() == input.attr('placeholder')) {
                    input.val('');
                    input.removeClass('placeholder');
                }
            }).blur(function() {
                var input = $(this);
                if (input.val() == '' || input.val() == input.attr('placeholder')) {
                    input.addClass('placeholder');
                    //input.val(input.attr('placeholder'));
                }
            }).blur();
        };
        function placeholderSupport() {
            return 'placeholder' in document.createElement('input');
        }
    },
    renderHeight:function(scrollTop){
        var windowHeight =$(window).height();
        //64头部高度，106是考试标题的panel的outerHeight，40是中间的panel的上下padding，40是中间panel的margin-bottom，60是footer的高度;
        var thisShouldHeight = windowHeight - 64 - 106 - 40 - 60;
        var rightTopHeight = $('.pe-answer-right-top').outerHeight();
        var rightContentTopHeight = $('.pe-answer-right-content-top').outerHeight();
        var stuLeftDownH = $('.pe-wrong-contain').outerHeight();
        var rightItemListHeight = thisShouldHeight - rightTopHeight - 20 - rightContentTopHeight - 5;
        var leftPanel = $('.pe-answer-content-left-wrap').innerWidth();
        var leftPanelOffsetLeft = $('.pe-answer-content-left-wrap').offset().left;
        if(parseInt(stuLeftDownH,10) && parseInt(stuLeftDownH) > thisShouldHeight){
            if(scrollTop < 64){
                $('.pe-answer-test-num').css('height',(rightItemListHeight + 60 - 64 + 13)+ 'px');
            }else{
                $('.pe-answer-test-num').css('height',(rightItemListHeight + 60 + 13 )+ 'px');
            }
        }else{
            $('.pe-making-template-wrap').css('minHeight',(thisShouldHeight - 40) + 'px');//减去40,是因为去除template外面的包围框的上下padding
            $('.pe-answer-test-num').css('height',(rightItemListHeight -40)+ 'px');
        }
    }
};
