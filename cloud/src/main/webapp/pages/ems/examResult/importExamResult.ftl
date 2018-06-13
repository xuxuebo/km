<#import "../../noNavTop.ftl" as p>
<#assign ctx=request.contextPath/>
<@p.pageFrame>
<div class="pe-public-top-nav-header">
    <h3 class="paper-add-accredit-title">${(exam.examName)!}</h3>
</div>

<div class="pe-question-import-wrap">
    <input type="hidden" value="fail" name="uploadState"/>
    <div class="pe-import-tip-text">
        <p class="floatL">请先下载<strong style="color:#199ae2;">考试结果</strong>导入模板，根据导入模板的格式，添加您的内容，然后上传</p>
        <a class="pe-import-template-btn pe-btn pe-btn-green"
           href="${ctx!}/ems/examResult/manage/exportTemplate?optType=${(exam.optType)!}&id=${(exam.id)!}"><span
                class="iconfont icon-download"></span>下载导入模板</a>
    </div>
    <div class="pe-import-main-wrap">
        <div class="pe-upload-choose-area">
            <div id="uploader">
                <div class="pe-uploader-top-area">
                    <div id="dndArea" class="placeholder pe-uploader-holder-area">
                        <div class="pe-show-uploader-name-area floatL clearF">
                            <span class="pe-uploader-tip-name floatL">上传文件</span>
                            <div class="pe-uploader-file-show-name floatL"></div>
                        </div>
                        <div id="filePicker"></div>
                    </div>
                    <div class="pe-uploader-top-opt-area">
                        <div class="btns pe-uploader-opt-btns">
                            <button class="uploadBtn pe-btn pe-btn-blue pe-large-btn pe-begin-uploader-btn">立即上传
                            </button>
                            <button type="button" class="pe-btn pe-btn-purple pe-large-btn pe-uploader-cancel-upload">取消</button>
                        </div>
                        <div class="pe-uploader-progress-wrap">
                            <span class="text pe-uploader-progress-num">0%</span>
                            <span class="percentage pe-uploader-progress-percentage"></span>
                        </div>
                    </div>
                </div>
                <div class="pe-uploader-state-wrap">
                    <div class="pe-uploader-state-image state-fail"></div>
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
                extensions: 'xls,xlsx',
                mimeTypes: '.xls,.xlsx'
            },
            fileVal:'userResultFile',
            disableGlobalDnd: true,
            chunked: true,
            server: pageContext.rootPath + '/ems/examResult/manage/importExamResult?examId=${(exam.id)!}',
            fileNumLimit: 3000,
            fileSizeLimit: 10*1024 * 1024,
            fileSingleSizeLimit: 10*1024 * 1024,
            afterSuccessUploadContent: '<span class="pe-uploader-success-text">恭喜您学员成绩导入成功！</span>',
            afterFailUploadContent: '<span class="pe-uploader-fail-text">学员成绩导入失败，请修改后重新上传！</span><a href="${ctx}/ems/examResult/manage/downloadErrorTemplate?examId=${(exam.id)!}" class="pe-down-load-doc">点击下载错误文档</a>'
        });
        thisUpload.onUploadSuccess = function (file, response) {
            setTimeout(function () {
                $('.pe-uploader-progress-wrap').hide();
                $('.text pe-uploader-progress-num').html('0%');
                $('.pe-uploader-progress-percentage').width(0);
            }, 2000)
        };

        //不管失败，成功，完成就出发;
        thisUpload.onUploadComplete = function (t, r) {

        };
        thisUpload.onUploadAccept = function(t,r){
            if(r.success === 'true' || r.success){
                window.opener.location.reload();
                //上传成功
                $('input[name="uploadState"]').val('success');
                $('.pe-uploader-state-wrap .pe-uploader-state-image').removeClass('state-fail').addClass('state-success');
                $('.webuploader-pick').removeClass('disabled');
                return true;
            }else if(r.success === 'false' || !r.success){
                $('input[name="uploadState"]').val('false');
                $('.pe-uploader-state-wrap .pe-uploader-state-image').removeClass('state-success').addClass('state-fail');
                $('.webuploader-pick').removeClass('disabled');
                return false;
            }
        };

        $('.pe-import-main-wrap').delegate('.pe-uploader-cancel-upload','click',function(){
           window.close();
        })

        /*高度管理*/
        var _thisShouldHeight = $(window).height() - 64-60;
        $('.pe-question-import-wrap').css('minHeight',_thisShouldHeight);
    })
</script>
</@p.pageFrame>