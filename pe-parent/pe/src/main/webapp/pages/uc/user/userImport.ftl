<#import "../../noNavTop.ftl" as p>
<#assign ctx=request.contextPath/>
<@p.pageFrame>
<div class="pe-public-top-nav-header">
    <h3 class="paper-add-accredit-title">导入用户</h3>
</div>
<div class="pe-question-import-wrap">
    <div class="pe-import-tip-text">
        <p class="floatL">请先下载<strong style="color:#199ae2;">用户</strong>导入模板，根据导入模板的格式，添加您的内容，然后上传</p>
        <a class="pe-import-template-btn pe-btn pe-btn-green"
           href="${ctx!}/uc/user/manage/downloadUserTemplate"><span class="iconfont icon-download"></span>下载导入模板</a>
    </div>
    <div class="pe-import-main-wrap">
        <input type="hidden" value="fail" name="uploadState"/>
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
                            <button class="uploadBtn pe-btn pe-btn-blue pe-large-btn pe-begin-uploader-btn"
                                    type="button">立即上传
                            </button>
                            <button class="pe-btn pe-btn-purple pe-large-btn pe-uploader-cancel-upload" type="button">
                                取消
                            </button>
                        </div>
                        <div class="pe-uploader-progress-wrap">
                            <span class="text pe-uploader-progress-num">0%</span>
                            <span class="percentage pe-uploader-progress-percentage"></span>
                        </div>
                    </div>
                </div>
                <div class="pe-uploader-state-wrap">
                    <div class="pe-uploader-state-image"></div>
                    <div class="pe-uploader-complete-info"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function(){
        var thisUpload = PEMO.UPLOAD({
            pick: {
                id: '#filePicker',
                label: '选择文件'
            },
            // dnd: '#uploader',
            paste: document.body,

            accept: {
                title: 'excel类型文档',
                extensions: 'xlsx,xls',
                mimeTypes: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel'
            },
            // swf文件路径
            swf:  'jquery.uploader.swf',
            fileVal:'importUserFile',
            disableGlobalDnd: true,
            chunked: true,
            server: pageContext.rootPath + '/uc/user/manage/importUser',
//            server: 'http://192.168.1.29:8080/image/',
            fileNumLimit: 300,
            fileSizeLimit: 1 * 1024 * 1024,
            fileSingleSizeLimit: 1 * 1024 * 1024, //单个文件的上传大小限制1就是1M(前端限制)
            errorText:'只允许上传excel类型的文档哦',//上传类型错误时的提示语
            afterSuccessUploadContent:'<span class="pe-uploader-success-text">恭喜您用户导入成功！</span>',
            afterFailUploadContent:'<span class="pe-uploader-fail-text">用户导入失败，请修改后重新上传！</span><a href="${ctx!}/uc/user/manage/downloadErrorTemplate" class="pe-down-load-doc">点击下载错误文档</a>'
        });

        //服务器上传返回的状态
        thisUpload.onUploadAccept = function(t,r){
            if(r.success === 'true' || r.success){
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
            setTimeout(function(){
                $('.pe-uploader-progress-wrap').hide();
                $('.text pe-uploader-progress-num').html('0%');
                $('.pe-uploader-progress-percentage').width(0);
                $('.pe-uploader-state-wrap .pe-uploader-state-image').removeClass('state-success state-fail');
            },2000)
        };
        $('.pe-import-main-wrap').delegate('.pe-uploader-cancel-upload','click',function(){
//            location.href =pageContext.rootPath + "/front/manage/initPage#url=/pe/uc/user/manage/initPage&nav=user";
            window.close();
        })

        /*高度管理*/
        var _thisShouldHeight = $(window).height() - 64-60;
        $('.pe-question-import-wrap').css('minHeight',_thisShouldHeight);
    })
</script>
</@p.pageFrame>