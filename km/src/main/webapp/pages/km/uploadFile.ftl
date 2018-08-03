<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>上传文件</title>
    <!--引入CSS-->
    <link rel="stylesheet" type="text/css" href="${resourcePath!}/web-static/proExam/index/css/webuploader.css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}"
          type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${resourcePath!}/web-static/proExam/index/css/upload.css">
    <!--引入JS-->
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/jquery.min.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/underscore-min.js"></script>
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js?_v=${(resourceVersion)!}"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/webuploader.js"
            type="text/javascript" charset="utf-8"></script>
<#--
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/upload.js" type="text/javascript" charset="utf-8"></script>
-->
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.core.js?_v=0.1"></script>
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.excheck.js?_v=0.1"></script>
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.exedit.js?_v=0.1"></script>
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/jquery.mCustomScrollbar.concat.min.js?_v=0.1"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js"></script>


    <script>
        var pageContext = {
            resourcePath: '${resourcePath!}',
            rootPath: '${ctx!}',
            downloadServerUrl: '${downloadServerUrl!}'
        };
    </script>
</head>

<body style="background-color: #fff">

<div id="uploader" class="wu-example">
    <ul id="theList" class="file-list"></ul>
    <div id="picker">选择文件</div>
</div>
<script type="text/javascript">
    var chunkSize = 5000 * 1024;        //分块大小
    var uploadFileUrl = "${downloadServerUrl!}/file/uploadFile";
    var business = {
        appCode: "km",
        corpCode: '${corpCode!}',
        processor: 'FILE',
        businessId: (new Date()).getTime(),
        responseFormat: "json",
        chunkSize: chunkSize
    };

    WebUploader.Uploader.register({
        "before-send-file": "beforeSendFile", "before-send": "beforeSend", "after-send-file": "afterSendFile"
    }, {
        beforeSendFile: function (file) {
            var $file = $("#" + file.id);
            $file.find('.itemDel').remove();
            //秒传验证
            var task = new $.Deferred();
            var start = new Date().getTime();
            (new WebUploader.Uploader()).md5File(file, 0, 10 * 1024 * 1024).progress(function (percentage) {
            }).then(function (val) {
                console.log('beforeSendFile', "总耗时: " + ((new Date().getTime()) - start) / 1000);
                business.md5 = val;
                business.chunks = Math.ceil(file.size / chunkSize);
                business.storedFileName = file.name;
                business.fileSize = file.size;
                business.suffix = file.ext;
                var md5Check = $.extend(true, {resumeType: "md5Check"}, business);
                $.ajax({
                    type: "POST",
                    url: uploadFileUrl,
                    data: md5Check,
                    cache: false,
                    dataType: "json"
                }).then(function (data, textStatus, jqXHR) {
                    if (data.status == "FAILED") {//FAILED表示参数错误或者程序执行错误，不需要上传文件
                        task.reject();
                        uploader.skipFile(file);
                        alert(data.processMsg);
                    } else if (data.status == "SUCCESS"
                            || data.status == "PROCESSING") {//表示文件已存在并且处理正确或者处理中，不需要上传文件
                        task.reject();
                        uploader.skipFile(file);
                        file.data = data;
                        UploadComlate(file);
                    } else {//表示文件不存在，需要上传文件
                        task.resolve();
                    }
                }, function (jqXHR, textStatus, errorThrown) { //任何形式的验证失败，都触发重新上传
                    task.resolve();
                });
            });
            return $.when(task);
        }, beforeSend: function (block) {
            //分片验证是否已传过，用于断点续传
            console.log('beforeSend', block)
            var task = new $.Deferred();
            var chunkCheck = {
                resumeType: "chunkCheck",
                chunk: block.chunk,
                blockSize: (block.end - block.start)
            };
            $.ajax({
                type: "POST",
                url: uploadFileUrl,
                data: $.extend(true, chunkCheck, business),
                cache: false,
                dataType: "json"
            }).then(function (data, textStatus, jqXHR) {
                if (data.status == "FAILED") {//FAILED表示参数错误，不需要上传分片，结束文件上传
                    task.reject();
                    uploader.skipFile(file);
                    alert(data.processMsg);
                } else if (data.status == "SUCCESS") {//SUCCESS表示分片已存在，不需要上传分片
                    task.reject();
                } else {//表示分片不存在，需要上传分片
                    task.resolve();
                }
            }, function (jqXHR, textStatus, errorThrown) {    //任何形式的验证失败，都触发重新上传
                task.resolve();
            });

            return $.when(task);
        }, afterSendFile: function (file) {
            console.log('afterSendFile', file)
            var chunksTotal = Math.ceil(file.size / chunkSize);
            if (chunksTotal > 1) {
                //合并请求
                var task = new $.Deferred();
                $.ajax({
                    type: "POST",
                    url: uploadFileUrl,
                    data: $.extend(true, {"resumeType": "chunksMerge"}, business),
                    cache: false,
                    dataType: "json"
                }).then(function (data, textStatus, jqXHR) {

                    //FAILED表示参数错误(包括实际分片总数和前台传来的分片总数不一致)或者程序执行错误，上传失败
                    if (data.status == "FAILED") {
                        task.reject();
                        //uploader.skipFile(file);
                        alert(data.processMsg);

                    } else if (data.status == "SUCCESS"
                            || data.status == "PROCESSING") {//SUCCESS表示分片已合并完成并且正确处理
                        task.resolve();
                        file.data = data;
                        UploadComlate(file);
                    } else {//表示文件正在合并或者合并失败
                        task.resolve();
                    }

                }, function (jqXHR, textStatus, errorThrown) {
                    task.reject();
                });

                return $.when(task);
            } else {
                UploadComlate(file);
            }
        }
    });
    var FLAG_FINISHED = false;
    var uploader = WebUploader.create({
        swf: "/km/web-static/flash/Uploader.swf",
        server: uploadFileUrl,
        pick: "#picker",
        resize: false,
        auto: true,
        dnd: "#theList",
        paste: document.body,
        disableGlobalDnd: true,
        thumb: {
            width: 100,
            height: 100,
            quality: 70,
            allowMagnify: true,
            crop: true
            //, type: "image/jpeg"
        }
//				, compress: {
//					quality: 90
//					, allowMagnify: false
//					, crop: false
//					, preserveHeaders: true
//					, noCompressIfLarger: true
//					,compressSize: 100000
//				}
        , compress: false,
        prepareNextFile: false,
        chunked: true,
        chunkSize: chunkSize,
        threads: true,
        formData: function () {
            return $.extend(true, {resumeType: "chunkUpload"}, business);
        },
        fileNumLimit: 10,
        fileSingleSizeLimit: 10 * 1024 * 1024 * 1024,
        duplicate: true,
        accept: {
            title: "不支持的文件类型",
            //mimeTypes: "application/zip,application/x-rar-compressed,application/application/x-7z-compressed",
            extensions: 'exe,wmv,flv,mp4,rmvb,mkv,mov,avi,m4v,asf,mp3,ape,bmp,png,gif,jpg,jpeg,tif,doc,docx,ppt,pptx,xls,xlsx,pdf,txt,zip,rar,7z'
        }
    });

    function bytesToSize(bytes) {
        if (bytes === 0) return '0 B';
        var k = 1000, // or 1024
                sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
                i = Math.floor(Math.log(bytes) / Math.log(k));

        return (bytes / Math.pow(k, i)).toPrecision(3) + ' ' + sizes[i];
    }

    uploader.on("fileQueued", function (file) {
        $("#picker").hide()
        $("#theList").append('<li id="' + file.id + '" data-id="" class="y-table__filed_name type-' + file.ext + '">' +
                '<span class="file-name" title="' + file.name + '">' + file.name + '</span><span class="file-size">' + bytesToSize(file.size) + '</span>' +
                '<span class="itemDel">删除</span><span class="finished-icon" style="display: none"></span>' +
                '<div class="percentage"></div>' +
                '</li>');
    });
    /*


        $("#theList").on("click", ".itemStop", function () {
            uploader.stop(true);

            //"暂停"-->"上传"
            $(this).hide();
            $(".itemUpload").show();
        });
    */

    //todo 如果要删除的文件正在上传（包括暂停），则需要发送给后端一个请求用来清除服务器端的缓存文件
    $("#theList").on("click", ".itemDel", function () {
        uploader.removeFile($(this).parent().attr("id"));	//从上传文件列表中删除

        $(this).parent().remove();	//从上传列表dom中删除
    });

    uploader.on("uploadProgress", function (file, percentage) {
        $("#" + file.id + " .percentage").css({width: percentage * 100 + "%"});
    });
    var libraryId = parent.document.getElementById("myLibrary").value;
    function UploadComlate(file) {
        console.log(file);
        var $file = $("#" + file.id);
        $file.find('.percentage').css({width: "100%"});
        var data = file.data
        $("#"+file.id).attr("data-id", data.id);
        //TODO 上传成功后 请求km保存
        var url = pageContext.rootPath + '/knowledge/saveKnowledge';
        $.ajax({
            type: 'post',
            dataType: 'json',
            data: $.param({
                showOrder: 0,
                libraryId: libraryId,
                fileId: data.id,
                knowledgeName: data.storedFileName,
                knowledgeType: data.suffix,
                knowledgeSize: data.fileSize
            }),
            url: url,
            success: function (data) {
                $file.find('.percentage').hide();
                $file.find('.finished-icon').show();

                if(FLAG_FINISHED){
                    var upload = window.parent.document.getElementsByClassName("js-file-upload");
                    if (!upload || upload.length == 0) {
                        window.parent.layer.closeAll();
                    }

                    if (parent && parent.refreshPage && typeof parent.refreshPage == "function") {
                        parent.refreshPage();
                    }
                }

                //刷新列表
                //var folderId = $('#floderId').val();
                //route['YunCb']($parent.document.getElementById("yunLContentBody"), route.routes.yun, null,folderId);
            }
        });

        /* $(".itemStop").hide();
         $(".itemUpload").hide();
         $(".itemDel").hide();

         $("#theList").html('');*/
    }

    uploader.on( 'uploadFinished', function( file, percentage ) {
        PEMO.DIALOG.tips({
            content: '上传完成',
            time: 1000
        });
        FLAG_FINISHED = true;
    });

</script>

</body>
</html>