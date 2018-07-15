<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>上传文件</title>
    <!--引入CSS-->
    <link rel="stylesheet" type="text/css" href="${resourcePath!}/web-static/proExam/index/css/webuploader.css">
    <link rel="stylesheet" type="text/css" href="${resourcePath!}/web-static/proExam/index/css/upload.css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}" type="text/css"/>

    <!--引入JS-->
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/jquery.min.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/underscore-min.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/webuploader.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/upload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.core.js?_v=0.1"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.excheck.js?_v=0.1"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.exedit.js?_v=0.1"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/plugins/jquery.mCustomScrollbar.concat.min.js?_v=0.1"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js"></script>

    <style type="text/css">
        .km-add-form {
            width: 320px;
            margin: 60px auto;
        }

        .km-upload-btn-wrap {
            margin: 0;
            background-color: #00a0e9;
        }

        .webuploader-container .webuploader-pick + div, .webuploader-container {
            height: 34px !important;
        }

        .webuploader-container .webuploader-pick {
            background: #24a4ec;
            height: 34px;
            line-height: 34px;
            border-radius: 3px;
        }

        .km-file-name {
            float: left;
            line-height: 32px;
            max-width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .km-opt-bar{
            margin-top: 30px;
            margin-left: 50px;
        }

        .btn-default:hover, .btn-default:focus {
            background-color: #e0e0e0;
            background-position: 0 -15px;
        }
        .btn-default:hover, .btn-default:focus, .btn-default:active, .btn-default.active, .open .dropdown-toggle.btn-default {
            color: #333;
            background-color: #ebebeb;
            border-color: #adadad;
        }

    </style>
    <script>
        var pageContext = {
            resourcePath:'${resourcePath!}',
            rootPath:'${ctx!}',
            downloadServerUrl:'${downloadServerUrl!}'
        };
    </script>
</head>

<body style="background-color: #fff">

<div id="uploader" class="wu-example">
    <form action="javascript:void(0);" name="kmAddForm" class="km-add-form clear">
        <input type="hidden" name="showOrder" value="0">
        <input type="hidden" name="libraryId" id="floderId" value="">
        <div class="floatL" style="margin-bottom: 36px; margin-top: -15px;">
            <div>
                <span class="pe-label-name floatL">文件：</span>
                <div class="km-file-name file-queue">
                    <i style="color: #b3b2b2">请选择文件上传</i>
                </div>
                <div id="formData"></div>
            </div>
            <div style="margin-top: 66px; margin-left: 46px">
                <div class="km-upload-btn-wrap" id="filePicker">选择文件</div>
                <button id="startBtn" style="padding: 5px 21px 9px; display: none;" class="pe-btn pe-btn-white btn-default">开始上传</button>
                <button id="cancelBtn" style="padding: 5px 21px 9px; display: none;" class="pe-btn pe-btn-white btn-default">取消上传</button>
            </div>
            <div class="clear"></div>
        </div>
        <label class="floatL">
            <span class="pe-label-name floatL">标签：</span>
            <input class="pe-stand-filter-form-input" type="text" maxlength="10" placeholder="请输入标签" name="tag">
            <div class="clear"></div>
        </label>
        <div class="clear"></div>
        <div class="km-opt-bar">
            <button class="pe-btn pe-btn-blue" id="saveKnowledge" type="submit">保存</button>
            <button class="pe-btn pe-btn-white js-cancel" type="button">取消</button>
        </div>
    </form>
</div>
<script type="text/javascript">
    window.onload = function () {
        $('#floderId').val(parent.document.getElementById("myLibrary").value);
        var chunkSize = 5000 * 1024;        //分块大小
        var uploadFileUrl = '${downloadServerUrl!}/file/uploadFile';
        var uploader = window.uploadFile({
            auto: false,
            dnd:'#uploader',
            swf: "/km/web-static/flash/Uploader.swf",
            server: uploadFileUrl,
            pick: "#filePicker",
            resize: false,
            paste: document.body,
            disableGlobalDnd: true,
            thumb: {
                width: 100,
                height: 100,
                quality: 70,
                allowMagnify: true,
                crop: true
            },
            compress: false,
            prepareNextFile: true,
            chunked: true,
            chunkSize: 5000 * 1024,
            threads: true,
            fileNumLimit: 1,
            fileSingleSizeLimit: 10 * 1024 * 1024 * 1024,
            duplicate: true
        }, {
            uploadCompleted: function (data) {
                if (data == undefined || data == null) {
                    return;
                }

                $('#uploadState').text('已上传');

                $('#formData').html("<input type='hidden' name='fileId' value='{{fileId}}' />".replace("{{fileId}}", data.id)
                                + "<input type='hidden' name='knowledgeName' value='{{knowledgeName}}' />".replace("{{knowledgeName}}", data.storedFileName)
                                + "<input type='hidden' name='knowledgeType' value='{{knowledgeType}}' />".replace("{{knowledgeType}}", data.suffix)
                                + "<input type='hidden' name='knowledgeSize' value='{{knowledgeSize}}' />".replace("{{knowledgeSize}}", data.fileSize)
                        );
            },
            appCode: "km",
            corpCode: "lbox",
            processor: 'FILE',
            businessId: (new Date()).getTime(),
            responseFormat: "json"
        });

        var $list = $(".file-queue");
        uploader.on( 'fileQueued', function( file ) {
            $list.html('');
            $list.attr("data-id", file.id);
            $list.append( '<div id="' + file.id + '" class="item">' +
                    '<h4 class="info">' + file.name + '</h4>' +
                    '<p id="uploadState">等待上传...</p>'  +
                    '</div>' );

            $('#startBtn').show();
            $('#filePicker').hide();
        });

        // 文件上传过程中创建进度条实时显示。
        uploader.on( 'uploadProgress', function( file, percentage ) {
            $('#uploadState').html('<span>上传中</span><span style="color: #2a9cfe">'+Math.round(percentage * 100) + '%</span>');
        });

        uploader.on('uploadComplete', function(file) {
            $( '#'+file.id ).find('.progress').fadeOut();
        });

        uploader.on('all', function(type) {
            if (type === 'startUpload') {
                var $startBtn = $('#startBtn');
                $startBtn.html('暂停上传');
                $('#filePicker').hide();
            } else if (type === 'stopUpload') {
                $('#startBtn').html('开始上传');
            } else if (type === 'uploadFinished') {
                $('#startBtn').hide();
                $('#cancelBtn').show();
            }
        });

        $("#cancelBtn").on('click', function() {
            $('#filePicker').show();
            $('#cancelBtn').hide();
            $('#formData').html('');
            $('.file-queue').html('<i style="color: #b3b2b2">请选择文件上传</i>'+
                                  '<div id="formData"></div>');
        });

        $("#startBtn").on('click', function() {
            uploader.upload();
        });

        //保存
        $("#saveKnowledge").on('click', function () {
            var kmAddFormElem = document.kmAddForm;
            $(kmAddFormElem).submit(function () {
                if (!kmAddFormElem.elements.fileId || !kmAddFormElem.elements.fileId.value) {
                    alert("请先选择文件上传！");
                    return;
                }
                var url = pageContext.rootPath + '/knowledge/saveKnowledge';
                console.log(url);
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    data: $(kmAddFormElem).serialize(),
                    url: url,
                    success: function (data) {
                        PEMO.DIALOG.tips({
                            content: '保存成功',
                            time: 1000
                        });
                        window.parent.layer.closeAll()
                        //刷新列表
                        //var folderId = $('#floderId').val();
                        //route['YunCb']($parent.document.getElementById("yunLContentBody"), route.routes.yun, null,folderId);
                    }
                });
            });
        });

        $('.js-cancel').click(function () {
           window.parent.layer.closeAll()
        });
    };

</script>

</body>
</html>