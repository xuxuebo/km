<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>修改头像</title>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/iconfont.css?_v=${(resourceVersion)!}" type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/js/plugins/Jcrop/css/jquery.Jcrop.css?_v=${(resourceVersion)!}" type="text/css"/>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css"/>
    <style type="text/css">
        body{
            background:#fff;
        }
        .tbc-u-edit-face-panel{
            padding:0;
            margin-top:26px;
        }
        .tbc-u-edit-face-panel .jc-demo-box{
            width:400px;
            height:200px;
        }
        .tbc-u-crop-box-default{
            width: 90%;
            height: 170px;
            text-align: center;
            padding: 30px 5% 0 5%;
            box-sizing: content-box;
        }
        #previewPanel{
            width: 175px;
            height:202px;
            float: right;
            background: #f5f5f5;
            margin-right: 20px;
        }
        .tbc-u-edit-face-panel .preview-container{
            width: 100px;
            height: 100px;
            overflow: hidden;
            -webkit-border-radius: 50%;
            -moz-border-radius: 50%;
            border-radius: 50%;
            margin: 0 auto;
            border: 2px solid #e0e0e0;
        }
        .tbc-u-crop-box-default .iconfont{
            position:relative;
            cursor:pointer;
        }
        .tbc-u-re-upload-wrap.head-up-btn{
            position: absolute;
            top: 0;
            margin: 0;
            left: 0;
            width: 360px;
            height: 200px;
            text-align: center;
            padding: 0;
            font-size: 0;
            color: transparent;
            border: none;
            overflow:hidden;
            white-space:nowrap;
            min-width: 50px;
            /*opacity: 0;*/
            z-index: 9999;
            cursor:pointer;
        }
        .tbc-u-re-upload-wrap.head-up-btn form{
            position:relative;
            width:100%;
            height:100%;
        }
        .tbc-u-re-upload-wrap.head-up-btn  input[name='uploadFile']{
            height:200px;
            width:70px;
            cursor:pointer;
            position:absolute;
            left:0;
            top:0;
            opacity: 0;
            filter: alpha(opacity=0);
            color:transparent;
        }

    </style>
</head>
<body style="background-color: #fff">
<div class="tbc-u-edit-face-panel" style="padding: 0;">
    <div id="previewPanel">
        <p style="color: #666666;line-height: 32px;margin-bottom: 10px;padding-left:10px;">预览</p>
        <div class="preview-container">
            <img src="${(targetUrl)!'${resourcePath!}/web-static/proExam/images/default/default_face.png'}" class="jcrop-preview"
                 alt="Preview"/>
        </div>
        <p style="text-align: center;line-height: 36px;color: #333333;font-size: 12px;">80x80</p>

    </div>
    <div class="jc-demo-box" style="height:200px;width:360px;">
        <img onerror="javascript:this.src='${resourcePath!}/web-static/proExam/images/default/default_face.png'"
             src="${(sourceUrl)!'${resourcePath!}/web-static/proExam/images/default/default_face.png'}" id="target"
             style="display: none"/>
        <div class="tbc-u-crop-box-default">
            <span class="iconfont icon-upload-picture">
            </span>
            <p class="tip1">你可以选择本地照片作为头像</p>
            <p class="tip2">支持jpg、png或bmp格式的图片，建议文件大小小于1M(像素不能小于80 x 80)</p>
            <div class="tbc-u-re-upload-wrap head-up-btn">
                <form target="frm" class="upLoadForm"
                      action="${ctx}/sfm/uploadFile" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="fsType" value="COMMON"/>
                    <input type="hidden" name="processorType" value="IMAGE"/>
                    <input type="hidden" name="templateType" value="USER"/>
                    <input type='file' hidefocus="hidefocus" autofocus="off" accept="image/jpeg,image/png,image/jpg,image/gif" name="uploadFile"
                           onchange="uploadImg(this)"/>
                </form>
            </div>
        </div>
    </div>
</div>
<form target="frm" class="tbc-u-re-upload-wrap upLoadForm" style="margin-top: 15px;"
      action="${ctx}/sfm/uploadFile" method="post" enctype="multipart/form-data">
    <input type="hidden" name="fsType" value="COMMON"/>
    <input type="hidden" name="processorType" value="IMAGE"/>
    <input type="hidden" name="templateType" value="USER"/>
    <input type='file' accept="image/jpeg,image/png,image/jpg,image/gif" name="uploadFile"
           onchange="uploadImg(this)"/>
    <span>本地上传</span>
</form>
<iframe id='frm' name='frm'></iframe>
<div class="tbc-u-edit-opt-bar text-right">
    <button type="button" class="pe-btn pe-btn-primary-light" onclick="cancel()">取消</button>
    <button type="button" class="pe-btn pe-btn-blue" onclick="save()">确定</button>
</div>
<input type="hidden" id="x"/>
<input type="hidden" id="y"/>
<input type="hidden" id="w"/>
<input type="hidden" id="h"/>
<input type="hidden" id="totalH"/>
<input type="hidden" id="totalW"/>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/Jcrop/js/jquery.Jcrop.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js?_v=${(resourceVersion)!}"></script>
<script type="text/javascript">
    function uploadImg(e,file) {
        var sub = e.value.substring(e.value.lastIndexOf('.') + 1);
        if(sub){
            sub = sub.toString().toLowerCase();
        }
        if (sub !== 'jpg' && sub !== 'jpeg' && sub !== 'png' && sub !== 'gif' && sub !== 'bmp') {
            var upLoadInput = $('input[name="uploadFile"]:file');
            upLoadInput.val('');
            var cloneInput =upLoadInput.clone(true);
            upLoadInput.remove();
            $('.upLoadForm').append(cloneInput);
            PEMO.DIALOG.tips({
                content: '图片格式仅支持jpg、jpeg、bmp、png',
                time:2000
            });

            return false;
        }

        $(e.form).submit();
    }
    //进度条
    var max = 100;
    var init = 0;
    var uploaded;
    var test;
    var fileObj;
    var jcropObj = {};


    function callback(res) {
        fileObj = JSON.parse(res);
        if (!fileObj.success) {
            PEMO.DIALOG.tips({
                content: fileObj.message || '上传失败'
            });

            return;
        }

        var jcrop_api,
                boundx,
                boundy,
                $preview = $('#previewPanel'),
                $pcnt = $('#previewPanel .preview-container'),
                $pimg = $('#previewPanel .preview-container img'),
                xsize = $pcnt.width(),
                ysize = $pcnt.height();
        var img = new Image();
        img.onload = function () {
            if(img.width < 82|| img.height < 82){
                alert('上传的图像宽度或者高度不能小于80像素哦');
                return false;
            }

            var upBackJson = $(window.document.getElementById('frm').contentWindow.document.getElementsByTagName('body')).html();
            if(upBackJson){
                upBackJson = jQuery.parseJSON(upBackJson);
                if(((upBackJson.data.fileSize)/1024/1024) > 10){
                    alert('上传图片大小不能超过10M');
                    return false;
                }
            }
            $('#totalW').val(img.width);
            $('#totalH').val(img.height);
            $('.tbc-u-crop-box-default').hide();
            $('#target').show().prop("src", img.src);
            $('.jcrop-preview').prop("src", img.src);
            try {
                jcrop_api.destroy();
            } catch (e) {
            }
            if(!$.isEmptyObject(jcropObj)){
                jcropObj.destroy();
                $('#target').width('auto').height('auto');
            }

            $('#target').Jcrop({
                onChange: updatePreview,
                onSelect: updatePreview,
                aspectRatio: xsize / ysize,
                boundary:0,
                boxWidth: 350,//设置裁剪区域的最大宽度
                boxHeight: 200//设置裁剪区域的最大高度
            }, function () {
                // Use the API to get the real image size
                var bounds = this.getBounds();
                boundx = bounds[0];
                boundy = bounds[1];
                // Store the API in the jcrop_api variable
                jcropObj = jcrop_api = this;

                //最小长、宽
                jcrop_api.setOptions({
                    minSize: [80, 80]

                });
                jcrop_api.setSelect(getDefSelect());
                updatePreview();
            });

        };
        img.onerror = function () {
            alert("error!")
        };
        img.src = fileObj.data.filePath;
        //默认选择区域坐标
        function getDefSelect() {
            //得到实际的选框数据
            var dim = jcrop_api.getBounds();
            return defaultImgPosition || [
                        Math.round(100),
                        Math.round(100 * 2),
                        Math.round(dim[0] / 2),
                        Math.round(dim[1] / 3)
                    ];
        }

        function updatePreview(c) {
            if (!c) {
                return;
            }
            //得到实际的选框大小
            var relSelect = jcrop_api.tellSelect();
            if (parseInt(c.w) > 0) {
                var rx = xsize / c.w;
                var ry = ysize / c.h;

                $pimg.css({
                    width: Math.round(rx * boundx) + 'px',
                    height: Math.round(ry * boundy) + 'px',
                    marginLeft: '-' + Math.round(rx * c.x) + 'px',
                    marginTop: '-' + Math.round(ry * c.y) + 'px'
                });

                $('#x').val(Math.round(relSelect.x));
                $('#y').val(Math.round(relSelect.y));
                $('#w').val(Math.round(relSelect.w));
                $('#h').val(Math.round(relSelect.h));
            }
        }
    }
    var frm = $("#frm");
    frm.load(function () {
        var wnd = this.contentWindow;
        var str = $(wnd.document.body).text();
        callback(str);
    });


    var defaultImgPosition;
    function save() {
        if ($.isEmptyObject(fileObj)) {
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
            return false;
        }

        var x = Number($('#x').val());
        var y = Number($('#y').val());
        var w = Number($('#w').val());
        var h = Number($('#h').val());
        var params = {fileId:fileObj.data.id,fileType:'HEAD_IMAGE',imgX:x,imgY:y,imgW:w,imgH:h};
        PEBASE.ajaxRequest({
            url: '${ctx!}/sfm/subImage',
            data: params,
            success: function (data) {
                if (data.success) {
                    $('.pe-user-head-edit-btn', parent.document).children('img').attr('src', data.data.filePath);
                    $('.target-fileId', parent.document).val(data.data.id);
                    $('.target-fileName', parent.document).val(data.data.fileName);
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(index);
                }else{
                    alert(data.message);
                }

            }
        });
    }

    function cancel() {
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
    }
    /*input的file*/
    var $thisHeadUpBtn = $('.head-up-btn input[name="uploadFile"]');
    $('.tbc-u-crop-box-default').mousemove(function(e){
        var e = e || window.event;
        e.stopPropagation();
        var mouseX = e.pageX;
        if(mouseX >60 && mouseX < 320){
            $thisHeadUpBtn.css('left',(mouseX - 60));
        }else if(mouseX <= 60){
            $thisHeadUpBtn.css('left',0);
        }else if(mouseX >= 320){
            $thisHeadUpBtn.css('left',290);
        }

    })
</script>
</body>
</html>