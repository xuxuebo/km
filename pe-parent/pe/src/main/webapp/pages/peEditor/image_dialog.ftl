<#assign ctx=request.contextPath/>
<div class="pe-question-import-wrap pe-editor-all-wrap">
    <div class="pe-import-main-wrap">
        <div class="pe-upload-choose-area">
            <input type="hidden" value="fail" name="uploadState"/>
            <input type="hidden" value="" name="uploadImageUrl"/>
            <input type="hidden" value="" name="uploadImageAlt"/>
            <input type="hidden" value="" name="imageId"/>
            <input type="hidden" value="" name="fileId"/>
            <input type="hidden" value="image" name="uploaderType"/>
            <div id="uploader">
                <div class="pe-uploader-top-area">
                    <div id="dndArea" class="placeholder pe-uploader-holder-area">
                        <div class="pe-show-uploader-name-area floatL clearF">
                            <span class="pe-uploader-tip-name floatL">上传文件</span>
                            <div class="pe-uploader-file-show-name placeholder-show-name floatL">请选择图片进行上传</div>
                        </div>
                        <div id="filePicker"></div>
                    </div>
                    <div class="pe-uploader-top-opt-area">
                        <div class="btns pe-uploader-opt-btns">
                            <button class="uploadBtn pe-btn pe-btn-blue pe-large-btn pe-begin-uploader-btn disabled">
                                立即上传
                            </button>
                            <#--<button class="pe-btn pe-btn-purple pe-large-btn pe-uploader-cancel-upload">取消</button>-->
                        </div>
                        <div class="pe-uploader-progress-wrap">
                            <span class="text pe-uploader-progress-num">0%</span>
                            <span class="percentage pe-uploader-progress-percentage"></span>
                        </div>
                    </div>
                </div>
                <div class="pe-uploader-state-wrap" style="display:none;">
                    <div class="pe-uploader-state-image"></div>
                    <div class="pe-uploader-complete-info"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function () {
        var thisUpload = PEMO.UPLOAD({
            pick: {
                id: '#filePicker',
                label: '选择文件'
            },
            // dnd: '#uploader',
            paste: document.body,
            accept: {
                title: '部分图片类型',
                extensions: 'jpg,JPG,jpeg,JPEG,png,PNG,gif,GIF',
                mimeTypes: 'image/jpg,image/jpeg,image/png,image/gif'
            },
            // swf文件路径
            swf: 'jquery.uploader.swf',
            disableGlobalDnd: true,
            chunked: false,
            formData: {
                fsType:'COMMON',
                templateType:'ITEM',
                processorType:'IMAGE'
            },
//            server: 'http://192.168.1.29:8080/image/',
            fileNumLimit: 300,
            fileSizeLimit: 10*1024 * 1024,
            fileSingleSizeLimit: 10*1024 * 1024, //单个文件的上传大小限制1就是1M(前端限制)
            afterSuccessUploadContent: '<span class="pe-uploader-success-text">上传成功</span>',
            afterFailUploadContent: '<span class="pe-uploader-fail-text">上传失败，请重新上传</span>'
        });

        //服务器上传返回的状态
        thisUpload.onUploadAccept = function (t, r) {
            if (r.success) {
                $('input[name="uploadState"]').val('success');
                $('input[name="uploadImageUrl"]').val(r.data.filePath);
                $('input[name="uploadImageAlt"]').val(r.data.fileName);
                $('input[name="imageId"]').val(r.data.id);
                return true;
            } else {
                $('input[name="uploadState"]').val('false');
                thisUpload.options.afterFailUploadContent = '<span class="pe-uploader-fail-text">'+r.message+'</span>';
                return false;
            }

        };

    })
</script>