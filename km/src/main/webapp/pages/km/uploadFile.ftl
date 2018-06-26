<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>上传文件</title>
    <!--引入CSS-->
    <link rel="stylesheet" type="text/css" href="${resourcePath!}/web-static/proExam/index/css/webuploader.css">
    <link rel="stylesheet" type="text/css" href="${resourcePath!}/web-static/proExam/index/css/upload.css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}"
          type="text/css"/>

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
            max-width: 150px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .km-opt-bar{
            margin-top: 30px;
            margin-left: 50px;
        }

    </style>
    <script>
        var pageContext = {
            resourcePath:'${resourcePath!}',
            rootPath:'${ctx!}'
        };
    </script>
</head>

<body style="background-color: #fff">

<div id="uploader" class="wu-example">
    <!--用来存放文件信息-->
<#--    <div id="thelist" class="uploader-list"></div>
    <div class="btns">
        <div id="filePicker">选择文件</div>
        <button id="ctlBtn" class="btn btn-default">开始上传</button>
    </div>-->
    <form action="javascript:void(0);" name="kmAddForm" class="km-add-form clear">
        <input type="hidden" name="showOrder" value="0">
        <div class="floatL" style="margin-bottom: 16px;">
            <span class="pe-label-name floatL">文件：</span>
            <div class="floatL">
                <div class="km-file-name js-file-name"></div>
                <div class="km-upload-btn-wrap" id="filePicker">选择文件</div>
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
            <button class="pe-btn pe-btn-blue" type="submit">保存</button>
            <button class="pe-btn pe-btn-white js-cancel" type="button">取消</button>
        </div>
    </form>
</div>
<script type="text/javascript">
    window.onload = function () {
        var chunkSize = 5000 * 1024;        //分块大小
        var uploadFileUrl = "http://192.168.0.35/fs/file/uploadFile";
        var business = {
            appCode: "km",
            processor: "VID",
            corpCode: "default",
            businessId: (new Date()).getTime(),
            responseFormat: "json",
            chunkSize: chunkSize
        };

        var processor = "FILE";
        window.uploadFile({
            auto: true,
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
                console.log(data);
                processor = data.suffix
                $('.js-file-name').attr("title", data.storedFileName)
                        .html(data.storedFileName + "&nbsp;&nbsp;" +
                                "<input type='hidden' name='fileId' value='{{fileId}}' />".replace("{{fileId}}", data.id)
                                + "<input type='hidden' name='knowledgeName' value='{{knowledgeName}}' />".replace("{{knowledgeName}}", data.storedFileName)
                                + "<input type='hidden' name='knowledgeType' value='{{knowledgeType}}' />".replace("{{knowledgeType}}", data.suffix)
                                + "<input type='hidden' name='knowledgeSize' value='{{knowledgeSize}}' />".replace("{{knowledgeSize}}", data.fileSize)
                        );
            },
            appCode: "km",
            processor: processor,
            //extractPoint: true,
            corpCode: "lbox",
            businessId: (new Date()).getTime(),
            responseFormat: "json"
        });

        //保存
        var kmAddFormElem = document.kmAddForm;
        $(kmAddFormElem).submit(function () {
            if (!kmAddFormElem.elements.fileId || !kmAddFormElem.elements.fileId.value) {
                alert("请先选择文件！");
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
                    window.parent.location.reload();
                }
            });
        })
        $('.js-cancel').click(function () {
           window.parent.layer.closeAll()
        });
    };

</script>

</body>
</html>