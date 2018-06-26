<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>上传文件</title>
    <!--引入CSS-->
    <link rel="stylesheet" type="text/css" href="${resourcePath!}/web-static/proExam/index/css/webuploader.css">
    <link rel="stylesheet" type="text/css" href="${resourcePath!}/web-static/proExam/index/css/upload.css">
    <!--引入JS-->
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/jquery.min.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/webuploader.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/upload.js"></script>

</head>

<body style="background-color: #fff">

<div id="uploader" class="wu-example">
    <!--用来存放文件信息-->
    <div id="thelist" class="uploader-list"></div>
    <div class="btns">
        <div id="filePicker">选择文件</div>
        <button id="ctlBtn" class="btn btn-default">开始上传</button>
    </div>
</div>



<script type="text/javascript">
    var chunkSize = 5000 * 1024;        //分块大小
    var uploadFileUrl = "http://192.168.0.35/fs/file/uploadFile";
    var business = {appCode: "km",
        processor: "VID",
        corpCode: "default",
        businessId: (new Date()).getTime(),
        responseFormat: "json",
        chunkSize: chunkSize};

//    WebUploader.Uploader.register({
//        "before-send-file": "beforeSendFile", "before-send": "beforeSend", "after-send-file": "afterSendFile"
//    }, {
//        beforeSendFile: function (file) {
//            //秒传验证
//            var task = new $.Deferred();
//            var start = new Date().getTime();
//            (new WebUploader.Uploader()).md5File(file, 0, 10 * 1024 * 1024).progress(function (percentage) {
//                console.log(percentage);
//            }).then(function (val) {
//                console.log("总耗时: " + ((new Date().getTime()) - start) / 1000);
//                business.md5 = val;
//                business.chunks = Math.ceil(file.size / chunkSize);
//                business.storedFileName = file.name;
//                business.fileSize = file.size;
//                business.suffix = file.ext;
//                var md5Check = $.extend(true, {resumeType: "md5Check"}, business);
//                $.ajax({
//                    type: "POST",
//                    url: uploadFileUrl,
//                    data: md5Check,
//                    cache: false,
//                    dataType: "json"
//                }).then(function (data, textStatus, jqXHR) {
//                    console.log(data);
//                    if (data.status == "FAILED") {//FAILED表示参数错误或者程序执行错误，不需要上传文件
//                        task.reject();
//                        uploader.skipFile(file);
//                        alert(data.processMsg);
//                    } else if (data.status == "SUCCESS"
//                            || data.status == "PROCESSING") {//表示文件已存在并且处理正确或者处理中，不需要上传文件
//                        task.reject();
//                        uploader.skipFile(file);
//                        file.data = data;
//                        UploadComlate(file);
//                    } else {//表示文件不存在，需要上传文件
//                        task.resolve();
//                    }
//                }, function (jqXHR, textStatus, errorThrown) { //任何形式的验证失败，都触发重新上传
//                    task.resolve();
//                });
//            });
//            return $.when(task);
//        }, beforeSend: function (block) {
//            //分片验证是否已传过，用于断点续传
//            var task = new $.Deferred();
//            var chunkCheck = {resumeType: "chunkCheck", chunk: block.chunk, blockSize: (block.end - block.start)};
//            $.ajax({
//                type: "POST",
//                url: uploadFileUrl,
//                data: $.extend(true, chunkCheck, business),
//                cache: false,
//                dataType: "json"
//            }).then(function (data, textStatus, jqXHR) {
//                console.log(data);
//                if (data.status == "FAILED") {//FAILED表示参数错误，不需要上传分片，结束文件上传
//                    task.reject();
//                    uploader.skipFile(file);
//                    alert(data.processMsg);
//                } else if (data.status == "SUCCESS") {//SUCCESS表示分片已存在，不需要上传分片
//                    task.reject();
//                } else {//表示分片不存在，需要上传分片
//                    task.resolve();
//                }
//            }, function (jqXHR, textStatus, errorThrown) {    //任何形式的验证失败，都触发重新上传
//                task.resolve();
//            });
//
//            return $.when(task);
//        }, afterSendFile: function (file) {
//            var chunksTotal = Math.ceil(file.size / chunkSize);
//            if (chunksTotal > 1) {
//                //合并请求
//                var task = new $.Deferred();
//                $.ajax({
//                    type: "POST",
//                    url: uploadFileUrl,
//                    data: $.extend(true, {"resumeType": "chunksMerge"}, business),
//                    cache: false,
//                    dataType: "json"
//                }).then(function (data, textStatus, jqXHR) {
//                    console.log(data);
//                    //FAILED表示参数错误(包括实际分片总数和前台传来的分片总数不一致)或者程序执行错误，上传失败
//                    if (data.status == "FAILED") {
//                        task.reject();
//                        //uploader.skipFile(file);
//                        alert(data.processMsg);
//
//                    } else if (data.status == "SUCCESS"'
//                            || data.status == "PROCESSING") {//SUCCESS表示分片已合并完成并且正确处理
//                        task.resolve();
//                        file.data = data;
//                        UploadComlate(file);
//                    } else {//表示文件正在合并或者合并失败
//                        task.resolve();
//                    }
//
//                }, function (jqXHR, textStatus, errorThrown) {
//                    task.reject();
//                });
//
//                return $.when(task);
//            } else {
//                UploadComlate(file);
//            }
//        }
//    });

//    var uploader = WebUploader.create({
//        swf: "/km/web-static/flash/Uploader.swf",
//        server: uploadFileUrl,
//        pick: "#filePicker",
//        resize: false,
//        dnd: "#theList",
//        paste: document.body,
//        disableGlobalDnd: true,
//        thumb: {
//            width: 100,
//            height: 100,
//            quality: 70,
//            allowMagnify: true,
//            crop: true
//        },
//        compress: false,
//        prepareNextFile: true,
//        chunked: true,
//        chunkSize: chunkSize,
//        threads: true,
//        formData: function () {
//            return $.extend(true, {resumeType: "chunkUpload"}, business);
//        },
//        fileNumLimit: 1,
//        fileSingleSizeLimit: 10 * 1024 * 1024 * 1024,
//        duplicate: true
//    });
//
    var uploader = WebUploader.create({
        // swf文件路径
        swf: "/km/web-static/flash/Uploader.swf",
        // 文件接收服务端。
        server: "http://192.168.0.35/fs/file/uploadFile",
        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#filePicker',
        // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
        resize: false
    });

//    uploader.on("fileQueued", function (file) {
//
//        $("#theList").append('<li id="' + file.id + '">' +
//                '<img /><span>' + file.name + '</span><span class="itemUpload">上传</span><span class="itemStop">暂停</span><span class="itemDel">删除</span>' +
//                '<div class="percentage"></div>' +
//                '</li>');
//
//        var $img = $("#" + file.id).find("img");
//
//        uploader.makeThumb(file, function (error, src) {
//            if (error) {
//                $img.replaceWith("<span>不能预览</span>");
//            }
//
//            $img.attr("src", src);
//        });
//
//    });

//    $("#theList").on("click", ".itemUpload", function () {
//        uploader.upload();
//
//        //"上传"-->"暂停"
//        $(this).hide();
//        $(".itemStop").show();
//    });
//
//    $("#theList").on("click", ".itemStop", function () {
//        uploader.stop(true);
//
//        //"暂停"-->"上传"
//        $(this).hide();
//        $(".itemUpload").show();
//    });
//
//    //todo 如果要删除的文件正在上传（包括暂停），则需要发送给后端一个请求用来清除服务器端的缓存文件
//    $("#theList").on("click", ".itemDel", function () {
//        uploader.removeFile($(this).parent().attr("id"));	//从上传文件列表中删除
//
//        $(this).parent().remove();	//从上传列表dom中删除
//    });
//
//    uploader.on("uploadProgress", function (file, percentage) {
//        $("#" + file.id + " .percentage").text(percentage * 100 + "%");
//    });

//    function UploadComlate(file) {
//        console.log(file);
//
//        $("#" + file.id + " .percentage").text("上传完毕");
//        $(".itemStop").hide();
//        $(".itemUpload").hide();
//        $(".itemDel").hide();
//
//        $("#theList").html('');
//    }

</script>

</body>
</html>