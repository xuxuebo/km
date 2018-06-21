    var userControl = {
        init:function(){

        },
        /*学员端首页*/
        initExamNav:{
            init:function(){
                var _this = this;
                _this.bind();
            },
            bind:function(){
                $('.user-footer-wrap').hide();
                var $thisRightPanel = $('.my-exam-nav-right-panel');
                var $mainContentLeft = $('.user-main-content-left .pe-center-left');
                /*学员端首页左边面板根据屏幕宽度初始化自适应位置*/
                var thisMainWrapLeft = $('.pe-user-manage-all-wrap').offset().left;
                //84为左边面板fixed的top值，60为footer的高度(暂时删除)，10是与footer的距离
                var thisShouldBeHeight = window.innerHeight - 84;
                // $('.pe-dynamic-empty-wrap.pe-dynamic-no-data').height(thisShouldBeHeight);
                /*回到头部*/
                $('.go-top-btn').click(function () {
                    $(window).scrollTop(0);
                });


                $(window).resize(function(){
                    // userControl.renderHeight();
                    var thisRightTotalHeight = $('.user-main-right-panel').height(),//面板的实际内容高度
                        thisScrollHeight = $(window).scrollTop(),//实际内容滚动的高度
                        $mainContentLeft = $('.user-main-content-left .pe-center-left'),
                        selectTypeName = $('.user-select-class').attr('data-type');
                    // if(selectTypeName === 'initMyDynamic' || 'myExercisePage'){
                    if(selectTypeName !== 'personalCenter'){
                        var isDownBottom = parseInt(thisRightTotalHeight - thisScrollHeight - thisShouldBeHeight) <0 ? true : false;
                        if (isDownBottom) {
                            $mainContentLeft.height($(window).height() -60-40-84)
                        } else {
                            $mainContentLeft.height(thisShouldBeHeight);
                        }
                    }else{
                        $('.user-main-right-panel').css('background','#fff');
                    }
                    if(((selectTypeName === 'myMsgCenter' || selectTypeName === 'myExamPage')) && $('.pe-stand-table-empty:visible').get(0)){
                        var hasFooterHeight = $(window).height() - 84 - 60-40;
                        $mainContentLeft.height( hasFooterHeight);
                        $('.my-exam-nav-right-panel').height(hasFooterHeight).css('minHeight',500);
                        $('.user-main-right-panel').css('background','none');
                        $('.pe-stand-table-main-panel').removeClass('blue-shadow');
                    }
                    if(selectTypeName === 'initMyDynamic' && $('.pe-dynamic-empty-wrap:visible').get(0)){
                        var hasFooterHeight = $(window).height() - 84 - 60-40;
                        $mainContentLeft.height( hasFooterHeight);
                        $('.my-exam-nav-right-panel').height( hasFooterHeight).css('minHeight',500);
                    }else if(selectTypeName === 'initMyDynamic'){
                        console.log('main-rioght',$('.user-main-right-panel').outerHeight());
                        if(($('.user-main-right-panel').outerHeight()) <= ($(window).height() - 84 - 60-40)){
                            $('.user-main-right-panel').height(thisShouldBeHeight).css('minHeight',500);
                            $('.my-exam-nav-right-panel').height('auto');
                            $mainContentLeft.height( hasFooterHeight);
                        }
                    }
                    if(selectTypeName === 'myExercisePage' && $('.pe-dynamic-empty-wrap:visible').get(0)){
                        $mainContentLeft.height( hasFooterHeight);
                        $('.my-exam-nav-right-panel').height( hasFooterHeight).css('minHeight',500);
                    }

                    //myExamPage
                    if($('.pe-environment-check').get(0)){
                        var _thisShouldBeHeight = $(window).height() - 64 - 60;
                        $('.pe-environment-check').height(_thisShouldBeHeight);
                    }
                    if($('.check-wrong-wrap').get(0)){
                        var wrongWrapShouldHeight = $(window).height() - 64-60 - 20;
                        $('.check-wrong-wrap').height(wrongWrapShouldHeight);
                    }

                    console.log('1 resize');
                });

                $('.pe-login-out').on('click', function () {
                    PEMO.DIALOG.confirmL({
                        content: '您确定退出吗？',
                        area: ['350px', '173px'],
                        title: '提示',
                        btn: ['取消', '确定'],
                        btnAlign: 'c',
                        skin: 'pe-layer-confirm pe-layer-has-tree login-out-dialog-layer',
                        btn1: function () {
                            layer.closeAll();
                        },
                        btn2: function () {
                            location.href = pageContext.rootPath + '/client/logout';
                        },
                        success: function () {
                            PEBASE.peFormEvent('checkbox');
                        }
                    });
                });

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

                $(".pe-user-name").hover(
                    function () {
                        $(".pe-login-sort").show();
                        $('.login-name-con-arrow').addClass('icon-thin-arrow-up');
                    },
                    function(){
                        $(".pe-login-sort").hide();
                        $('.login-name-con-arrow').removeClass('icon-thin-arrow-up');
                    }
                );

                $('.admin-role').on('click', function () {
                    location.href = pageContext.rootPath +'/front/manage/initPage';
                });


                $('.pe-user-menu-tree').on('click',function(){
                    if($(this).hasClass('user-select-class')){
                        return false;
                    }

                    renderTreeData($(this));
                });

                function renderTreeData($menuTree){
                    $('.pe-user-menu-tree').removeClass('user-select-class');
                    $('.pe-user-menu-tree i').css({'color':''});
                    $menuTree.addClass('user-select-class');
                    $menuTree.find('i').css({'color':'#6d9ed9'});
                    var url = $menuTree.data('url');
                    var thisPanelHeight = '';

                    $("#peMainPulickContent").load(url, function () {
                        var $thisFixLeftPanelPo = $('.user-main-content-left'),$userSelectClassDom = $('.user-select-class');
                        /*我的考试*/
                        if($userSelectClassDom.attr('data-type') === 'initMyDynamic'){
                            $thisFixLeftPanelPo.css({'position':'fixed','top':'84px'});
                            $thisRightPanel.removeClass('blue-shadow');
                        }else if($userSelectClassDom.attr('data-type') === 'myExamPage'){
                            $thisFixLeftPanelPo.css({'position':'absolute','top':'0'});
                            /*历史考试*/
                            $(window).scrollTop(0);
                            $mainContentLeft.height($thisRightPanel.height());
                            $thisRightPanel.css('background','#fff').height('auto');
                        }else if($userSelectClassDom.attr('data-type') === 'myMsgCenter'){
                            $thisFixLeftPanelPo.css({'position':'absolute','top':'0'});
                            /*消息中心*/
                            $(window).scrollTop(0);
                            $mainContentLeft.height($thisRightPanel.height());
                        }else if($userSelectClassDom.attr('data-type') === 'personalCenter'){
                            $thisFixLeftPanelPo.css({'position':'absolute','top':'0'});
                            /*个人中心*/
                            $(window).scrollTop(0);
                            $mainContentLeft.height($thisRightPanel.height());
                            $thisRightPanel.css({'background':'#fff'}).addClass('blue-shadow');
                        }else if($userSelectClassDom.attr('data-type') === 'myExercisePage'){
                            $(window).scrollTop(0);
                            $thisFixLeftPanelPo.css({'position':'fixed','top':'84px'});
                            $mainContentLeft.height($thisRightPanel.height());
                            $thisRightPanel.height('auto');
                            $thisRightPanel.addClass('blue-shadow');
                        }
                    });
                    //定义页面所有的checkbox，和radio的模拟点击事件
                    PEBASE.peFormEvent('checkbox');
                    PEBASE.peFormEvent('radio');
                }

                $('.my-exam-center-left li').hover(
                    function(e){
                        var e = e || window.event;
                        e.stopPropagation();
                        $(this).addClass('hover');
                        if(!$(this).hasClass('user-select-class')){
                            $('li.user-select-class').addClass('select-hover');
                        }

                    },
                    function(e){
                        var e = e || window.event;
                        e.stopPropagation();
                        $(this).removeClass('hover');
                        $('li.user-select-class').removeClass('select-hover');
                    }
                );
                renderTreeData($('.pe-user-menu-tree').eq(0));
            }
        },
        renderHeight:function(isFixed,size){
            var $thisRightPanel = $('.my-exam-nav-right-panel'),//右边section，包裹框;
                $thisRealRightPanel = $('.user-main-right-panel'),//右边section里面直接的内容div
                $thisLeftPanel = $('.user-main-content-left .pe-center-left'),//左边面板dom
                selectType = $('.user-select-class').attr('data-type'),
                thisShouldBeHeight = $(window).height() - 84,
                $thisFixLeftPanelPo = $('.user-main-content-left');

            if(isFixed && selectType === 'myExamPage' || 'myMsgCenter'){
                $thisFixLeftPanelPo.css({'position':'fixed','top':'84px'});
            }else if(!isFixed && selectType === 'myExamPage'){
                $thisFixLeftPanelPo.css({'position':'absolute','top':'0'});
            }
            if(selectType === 'initMyDynamic'){
                $thisRightPanel.height('auto');
            }
            if(selectType === 'initMyDynamic' && $('.my-exam-nav-right-panel .pe-dynamic-no-data .pe-dynamic-empty:visible').get(0)){
                $thisRightPanel.addClass('blue-shadow');
            }

            if(($thisRealRightPanel.outerHeight()+20) < thisShouldBeHeight){
                var hasFooterHeight = $(window).height() - 84 - 60-40;
                $thisLeftPanel.height( hasFooterHeight);
                $('.user-footer-wrap').show();
                if(selectType === 'myMsgCenter'){
                    if(!$('.pe-stand-table-empty:visible').get(0)){
                        $thisLeftPanel.height( 794);
                        $thisRightPanel.height(794).css({'minHeight':794,'marginBottom':'40px','background':'#fff'});
                    }else{
                        $thisRightPanel.height( hasFooterHeight).css('minHeight',500);
                    }
                }else{
                    if(selectType == 'myExamPage'){
                        $thisRightPanel.css('background','#fff');
                        $('.user-main-right-panel').css('background','#fff');
                        $('.pe-stand-table-main-panel').removeClass('blue-shadow');
                        if (size && size > 10) {
                            $thisRightPanel.height('auto').css({ 'background': '#fff'});
                        } else {
                            $thisRightPanel.height(hasFooterHeight).css({
                                'background': '#fff'
                            });
                        }
                    }
                    if(selectType == 'initMyDynamic'){
                        $thisRightPanel.height(hasFooterHeight).css({
                            'background': '#fff'
                        });
                    }
                    if(selectType == 'myExercisePage'){
                        $thisRightPanel.height(hasFooterHeight).css({
                            'background': '#fff'
                        });
                    }
                    if(selectType === 'initMyDynamic' || 'myExercisePage' ){
                        if($('.pe-dynamic-no-data:visible').get(0) || $('.pe-dynamic-error-wrap:visible').get(0) || $('.pe-stand-table-empty:visible').get(0)){
                            $thisRightPanel.css('background','#fff');
                        }
                    }

                }
            }else{
                $(window).scroll(function(){
                    userControl.isScrollBottom();
                    if(!(selectType === 'personalCenter')){
                        $thisRightPanel.height('auto').css('minHeight','576px;');
                    }

                    /*回到顶部*/
                    if($(window).scrollTop() >= 600){
                        $('.go-top-btn').fadeIn();
                    }else{
                        $('.go-top-btn').fadeOut();
                    }
                });
                $thisRightPanel.height('auto');
                $thisLeftPanel.height($('.user-main-right-panel').height());
                if(selectType === 'myMsgCenter'){
                    $thisRightPanel.addClass('blue-shadow').css('background','#fff');
                }else{
                    $thisRightPanel.removeClass('blue-shadow').css('background','none');
                }
            }
            if(selectType ==( 'myExercisePage' || 'myExamPage')){
                if(($thisRealRightPanel.outerHeight()+20) < thisShouldBeHeight){
                    $('.pe-stand-table-main-panel').removeClass('blue-shadow');
                }
                if(selectType === 'myExercisePage'){
                    $thisRightPanel.addClass('blue-shadow');
                }
            }
        },
        isScrollBottom:function(){
            var thisRightTotalHeight = $('.user-main-right-panel').height(),//面板的实际内容高度
                thisScrollHeight = $(window).scrollTop(),//实际内容滚动的高度
                $mainContentLeft = $('.user-main-content-left .pe-center-left'),
                thisShouldBeHeight = $(window).height() - 84,
                selectTypeName = $('.user-select-class').attr('data-type');
            if(selectTypeName === 'initMyDynamic' || 'myExercisePage'){
                var isDownBottom = parseInt(thisRightTotalHeight - thisScrollHeight - thisShouldBeHeight) <0 ? true : false;
                console.log('isDownBottom',isDownBottom);
                if (isDownBottom) {
                    $mainContentLeft.height($(window).height() -60-40-84)
                } else {
                    $mainContentLeft.height(thisShouldBeHeight);
                }
            }
        },
        /*我的考试*/
        myExamDynamic:{
                initData: function () {
                    var _this = this;
                    _this.initDynamic();
                },
                bind: function () {
                    $('.pe-student-today-exam').delegate('.pe-join-btn', 'mouseover mouseout', function (e) {
                        var e = e || window.event;
                        if (e.type == "mouseover") {
                            $(this).parents('.pe-student-contain').find('.pe-student-img img').attr('src', pageContext.resourcePath +'/web-static/proExam/images/pe-btn-hover.png');
                        } else if (e.type == "mouseout") {
                            $(this).parents('.pe-student-contain').find('.pe-student-img img').attr('src', pageContext.resourcePath +'/web-static/proExam/images/pe-btn.png');
                        }
                    });

                    $('body').delegate('.pe-join-btn,.pe-answer-sure-btn', 'click', function () {
                        var id = $(this).data('id');
                        window.open( pageContext.rootPath +'/ems/exam/client/initVerifyUser?examId=' + id,"EXAM_PAGE",'');
                    });

                    $(".pe-student-warn").hover(function () {
                        $(".pe-student-start").show();
                    });

                    //综合科目panel点击事件
                    $('.pe-dynamic-contain').on('click','.pe-recent-comprehensive',function (){
                        var $thisItemPanel = $(this);
                        var thisSubjectArrow = $thisItemPanel.find('.pe-recent-subject .pe-dynamic-icon');
                        if (thisSubjectArrow.hasClass('icon-thin-arrow-down')) {
                            $thisItemPanel.find('.pe-recent-step-con').eq(0).slideDown();
                            thisSubjectArrow.removeClass('icon-thin-arrow-down').addClass('icon-thin-arrow-up');
                            $thisItemPanel.addClass('subject-item-panel');
                            $thisItemPanel.find('.recent-shadow-stack').hide();
                        } else if (thisSubjectArrow.hasClass('icon-thin-arrow-up')) {
                            $thisItemPanel.find('.pe-recent-step-con').eq(0).slideUp(function(){
                                $thisItemPanel.find('.recent-shadow-stack').show();
                            });
                            thisSubjectArrow.removeClass('icon-thin-arrow-up').addClass('icon-thin-arrow-down');

                        }
                    });

                    $('.pe-dynamic-contain').on('click','.rank-link',function (e){
                        var e = e || window.event;
                        e.stopPropagation();
                        var examId = $(this).data('id');
                        PEMO.DIALOG.selectorDialog({
                            content: [pageContext.rootPath + '/ems/resultReport/client/initRankPage?examId=' + examId, 'no'],
                            skin:'pe-rank-dialog',
                            area: ['400px'],
                            success:function(){

                            }
                        });
                    });

                    if(window.addEventListener){
                        localStorage.removeItem('SUBMIT_EXAM_STORAGE');
                        window.addEventListener("storage", function (e) {
                            var e = e || window.event;
                            if(!e.newValue){
                                return;
                            }

                            if (e.key === 'SUBMIT_EXAM_STORAGE') {
                                localStorage.removeItem(e.key);
                                location.reload();
                            }
                        });
                    }
                },
                initDynamic: function () {
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exam/client/searchExamDynamic',
                        success: function (data) {
                            if(data && data.length ==0){
                                var thisShouldBeHeight = $(window).height() - 84-40-60;
                                /*数据为空*/
                                $('.pe-recent-wrap').hide();
                                $('.pe-dynamic-no-data').show();
                            }else{
                                $(".pe-student-today-exam").hide();
                                $(".pe-student-many").hide();
                                $(".pe-exam-warn-wrap").hide();
                                $('.pe-recent-content').show();
                                $('.user-exam-more-panel').show();
                            }
                            $('.user-exam-more-panel').html('');
                            if ($.isEmptyObject(data)) {
                                userControl.renderHeight();
                                return false;
                            }

                            $('.user-exam-more-panel').html(_.template($('#dynamicTemp').html())({data: data}));
                            $('.user-footer-wrap').show();
                            userControl.renderHeight();
                            userControl.myExamDynamic.rollingDynamicTime();
                            /*卡片的hover效果处理*/
                            $('.pe-recent-content .pe-recent-item').hover(
                                function(e){
                                    var e = e || window.event;
                                    e.stopPropagation();
                                    $(this).addClass('recent-hover');
                                },
                                function(e){
                                    var e = e || window.event;
                                    e.stopPropagation();
                                    $(this).removeClass('recent-hover');
                                }
                            );
                        },
                        error:function(){
                            /*页面出错*/
                            $('.pe-recent-wrap').hide();
                            $('.pe-dynamic-error-wrap').show();
                            userControl.renderHeight();
                            var thisLeftContentHeight = $('.user-main-content-left .pe-center-left').height();
                            $('.my-exam-nav-right-panel .pe-dynamic-error-wrap').height(thisLeftContentHeight );//435为空页面的paddingTop值
                        }
                    });
                },
                rollingDynamicTime: function () {
                    $('.residual-second-span').each(function (index, ele) {
                        var second = parseInt($(ele).text());
                        var timeInterval = setInterval(function () {
                            if (second === 0) {
                                var $minute = $(ele).siblings('.residual-minute-span');
                                if ($minute.length <= 0) {
                                    clearInterval(timeInterval);
                                    $(ele).parents('.recent-exam-btn').find('.pe-recent-test').show();
                                    $(ele).parents('.recent-exam-btn').find('.pe-recent-ing').show();
                                    $(ele).parents('.recent-exam-btn').find('.pe-recent-item-right').remove();
                                    return false;
                                }
                                var minute = parseInt($minute.text());
                                if (minute === 1) {
                                    $minute.siblings('.residual-minute-text').remove();
                                    $minute.remove();
                                } else {
                                    $minute.text(minute - 1);
                                }

                                second = 60;
                            }

                            $(ele).text(--second);
                        }, 1000);
                    });
                },

                init: function () {
                    var _this = this;
                    _this.initData();
                    _this.bind();
                }
        },
        /*历史考试*/
        examResult:{
            initDate:function(){
                var peTableTitle = [
                    {'title': '考试名称', 'width': 22},
                    {'title': '考试时间', 'width': 40},
                    {'title': '类型', 'width': 10},
                    {'title': '成绩', 'width': 10},
                    {'title': '状态', 'width': 8},
                    {'title': '操作', 'width': 10}
                ];
                /*表格生成*/
                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/ems/examResult/client/searchMyExam',
                    formParam: $('#examManageForm').serialize(),//表格上方表单的提交参数
                    tempId: 'peExamManaTemp',//表格模板的id
                    showTotalDomId: 'showTotal',
                    title: peTableTitle, //表格头部的数量及名称数组;
                    onLoad:function(t,d){
                        if(t.data.rows && t.data.rows.length === 0){
                                var hasFooterHeight = $(window).height() - 84 - 60-40;
                            $('.user-main-content-left .pe-center-left').height( hasFooterHeight);
                                $('.my-exam-nav-right-panel').height( hasFooterHeight).css('minHeight',500).addClass('blue-shadow');
                                $('.user-main-right-panel').css('background','none');
                                $('.pe-stand-table-main-panel').removeClass('blue-shadow');

                                return false;
                        }
                        var isLeftFixed = false;
                        if(t && t.options.pageSize > 10 && t.data.total > 15){
                            isLeftFixed = true;
                        }
                        userControl.renderHeight(isLeftFixed,t.options.pageSize);
                    }
                });
            },
            init:function(){
                var _this = userControl.examResult;
                _this.initDate();
                _this.bind();
            },
            bind:function(){

                $('#queryCondition').on('click', function () {
                    $('.pe-stand-table-wrap').peGrid('load', $('#examManageForm').serialize());
                });

                $('.pe-stand-table-wrap').delegate('.icon-my-examination','click',function(){
                    var examId = $(this).data('id');
                    window.open(pageContext.rootPath + '/ems/examResult/client/viewMyPaper?examId=' + examId,'')
                });

                $('.pe-stand-table-wrap').delegate('.icon-test-analysis','click',function(){
                    var examId = $(this).data('id');
                    window.open(pageContext.rootPath + '/ems/resultReport/client/viewMyAnalysis?examId=' + examId,'')
                });

                $('.pe-stand-table-wrap').on('click','.rank-link',function (e){
                    var e = e || window.event;
                    e.stopPropagation();
                    var examId = $(this).data('id');
                    PEMO.DIALOG.selectorDialog({
                        content: [pageContext.rootPath + '/ems/resultReport/client/initRankPage?examId=' + examId, 'no'],
                        skin:'pe-rank-dialog',
                        area: ['400px']
                    });
                });

                /*点击批次弹出批次展示框的事件*/
                $('.pe-stand-table-wrap').delegate('.edit-arrange', 'click', function (e) {
                    var e = e || window.event;
                    e.stopPropagation();
                    var _thisArrow = $(this).find('.arrange-arrow');
                    var id = $(this).attr('data-id');
                    var thisBatch = _thisArrow.parents('tr').next('.batch-new-tr');
                    if (!(_thisArrow.parents('tr').next('.batch-new-tr:visible').get(0))) {
                        $('.batch-new-tr:visible').prev('tr').eq(0).find('.arrange-arrow')
                            .removeClass('icon-thin-arrow-up')
                            .addClass('icon-thin-arrow-down');
                    }
                    $('.batch-new-tr:visible').prev('tr').eq(0).find('.pe-ellipsis').removeClass('batch-active');
                    $('.batch-new-tr:visible').hide();
                    if (_thisArrow.hasClass('icon-thin-arrow-down')) {
                        _thisArrow.parent('.pe-ellipsis').addClass('batch-active');
                        _thisArrow.removeClass('icon-thin-arrow-down').addClass('icon-thin-arrow-up');
                        thisBatch.show();
                    } else {
                        thisBatch.hide();
                        _thisArrow.parent('.pe-ellipsis').removeClass('batch-active');
                        _thisArrow.removeClass('icon-thin-arrow-up').addClass('icon-thin-arrow-down');
                    }

                });
            }
        },
        /*个人中心*/
        perCenter:{
            init:function(userId){
                var  _this= this;
                _this.bind(userId);
                userControl.renderHeight();
            },

            bind:function(userId){
                $('.user-main-right-panel').css('background','#fff');
                $(".pe-center-left-con a").click(function () {
                    $(".pe-center-left-con li").removeClass("pe-center-item");
                    $(this).parent("li").addClass("pe-center-item");
                });

                //修改头像
                $('.pe-user-head-edit-btn').on('click', function () {
                    if(userId){
                        PEMO.DIALOG.selectorDialog({
                            content: pageContext.rootPath + '/uc/user/client/initUserHeadPage?userId='+ userId,
                            area: ['606px', '400px'],
                            skin:'layui-cut-header',
                            title: '修改头像'
                        });
                    }else{
                        PEMO.DIALOG.tips({
                            content:'出问题了,用户ID没有取到'
                        })
                    }

                });

                $('.reset-pass-word').click(function(){
                    PEMO.DIALOG.confirmL({
                        content: _.template($('#resetPassword').html())(),
                        area: '450px',
                        title: '修改密码',
                        btn: ['确定', '取消'],
                        btnAlign: 'l',
                        btn1: function () {
                            var oldPassword= $.trim($('input[name="oldPassword"]').val());
                            var newPassword= $.trim($('input[name="newPassword"]').val());
                            var confirmPassword= $.trim($('input[name="confirmPassword"]').val());
                            var  $error=$('.validate-form-cell').find('.error').eq(0);
                            if(!oldPassword){
                                $error.show().text("原始密码不能为空！");
                                return false;
                            }

                            if(!newPassword){
                                $error.show().text("新密码不能为空！");
                                return false;
                            }

                            if(!confirmPassword){
                                $error.show().text("确认密码不能为空！");
                                return false;
                            }

                            if (oldPassword == newPassword){
                                $error.show().text("新密码不能与原始密码相同！");
                                return false;
                            }

                            if(newPassword.length < 6 || newPassword.length > 20){
                                $error.show().text("密码为6-20位，只能含有字母或者数字");
                                return false;
                            }

                            if(newPassword !== confirmPassword){
                                $error.show().text("新密码两次输入不一致！");
                                return false;
                            }

                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath +'/uc/user/resetPassword',
                                data: $('#resetPasswordForm').serialize(),
                                success: function (data) {
                                    if(data.success){
                                        layer.closeAll('page');
                                        PEMO.DIALOG.tips({
                                            content:"密码修改成功"
                                        });
                                    }else{
                                        $error.show().text(data.message);
                                    }
                                }
                            });
                        },
                        success:function(){
                            var layuiBtn = $('.pe-layer-confirm.layui-layer .layui-layer-btn');
                               if(layuiBtn.get(0)){
                                   layuiBtn.css('paddingLeft','144px');
                               }
                            var  $error=$('.validate-form-cell').find('.error').eq(0);
                            $('input[name="newPassword"]').on("blur",function(){
                                var newPassword= $.trim($('input[name="newPassword"]').val());
                                if(newPassword&&!/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/.test(newPassword)){
                                    $error.show().text("密码为6-20位，只能包含字母和数字");
                                }else{
                                    $error.hide();
                                }
                            })
                        }
                    });
                });

                $("body").delegate('input[name="mobile"]', "input", function () {
                    var $this = $(this);
                    var $error = $('.validate-form-cell').find('.error').eq(0);
                    var mobile = $.trim($this.val());
                    $error.hide();
                    if (!/^((13[0-9])|(15[^4])|(18[0,1,2,3,5-9])|(17[0-8])|(147))\d{8}$/.test(mobile)) {
                        $('.pe-identity-get-btn').prop('disabled', true);
                        return false;
                    } else {
                        $('.pe-identity-get-btn').removeProp('disabled');
                    }
                });


                $('body').delegate('.pe-online-btn','click',function(){
                    var $this = $(this);
                    if($this.prop('disabled')){
                        return false;
                    }

                    var $error=$('.validate-form-cell').find('.error').eq(0);
                    var mobile= $.trim($('input[name="mobile"]').val());
                    $error.hide();
                    if(!mobile){
                        $error.show().text("手机号不能为空！");
                        return false;
                    }
                    if (!/^((13[0-9])|(15[^4])|(18[0,1,2,3,5-9])|(17[0-8])|(147))\d{8}$/.test(mobile)){
                        $error.show().text("手机号输入不正确！");
                        return false;
                    }

                    $this.prop('disabled',true);
                    PEBASE.ajaxRequest({
                        url:pageContext.rootPath +'/uc/user/sendMobileCode',
                        data:{mobile:mobile},
                        success:function(data){
                            if(data.success){
                                $('.pe-identity-get-btn').html('已发送(<span class="text-red time-red"></span>)');
                                $('.pe-identity-get-btn').attr('disabled', 'disabled');
                                var curCount = 60;
                                $('.time-red').html(curCount);
                                var InterValObj = setInterval(function () {
                                    if (curCount == 0) {
                                        clearInterval(InterValObj);
                                        $('.pe-identity-get-btn').removeAttr("disabled");
                                        $('.pe-identity-get-btn').html('重新发送');
                                    } else {
                                        curCount--;
                                        $('.time-red').html(curCount);
                                    }

                                }, 1000);
                            }else{
                                $error.show().text(data.message);
                            }
                        }
                    });
                });

                $('body').delegate('input[name="email"]','blur',function(){
                    var email= $.trim($('input[name="email"]').val());
                    var $error=$('.validate-form-cell').find('.error').eq(0);
                    if(!email){
                        $error.show().text("邮箱不能为空！");
                        return false;
                    }
                    if (!/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/.test(email)){
                        $error.show().text("邮箱格式不正确！");
                    }else{
                        $error.hide();
                    }
                });

                $('.pe-mobile,.change-mobile').click(function(){
                    var titleName=$(this).data('name');
                    var type=$(this).data('type');
                    PEMO.DIALOG.confirmL({
                        content: _.template($('#bindMobile').html())(),
                        area: ['508px','300px'],
                        title: titleName,
                        btn: ['确定', '取消'],
                        skin: 'pe-layer-confirm pe-layer-has-tree pe-bind-mobile-layer',
                        btnAlign: 'l',
                        btn1: function () {
                            var mobile= $.trim($('input[name="mobile"]').val());
                            var verifyCode=$.trim($('input[name="verifyCode"]').val());
                            var password=$.trim($('input[name="password"]').val());
                            var $error=$('.validate-form-cell').find('.error').eq(0);
                            if(!mobile){
                                $error.show().text("手机号不能为空");
                                return false;
                            }

                            if(!verifyCode){
                                $error.show().text("验证码不能为空");
                                return false;
                            }

                            if(!password){
                                $error.show().text("密码不能为空");
                                return false;
                            }
                            if (!/^((13[0-9])|(15[^4])|(18[0,1,2,3,5-9])|(17[0-8])|(147))\d{8}$/.test(mobile)){
                                $error.show().text("手机号输入不正确！");
                                return false;
                            }
                            PEBASE.ajaxRequest({
                                url:pageContext.rootPath +'/uc/user/checkIdentityCode',
                                data:$('#bindMobileForm').serialize(),
                                success:function(data){
                                    if(data.success){
                                        layer.closeAll('page');
                                        PEMO.DIALOG.tips({
                                            content:"成功绑定手机号"
                                        });
                                        window.location.href="/pe/front/initPage#url=/pe/front/initMyPersonalCenter";
                                    }else{
                                        $error.show().text(data.message);
                                    }
                                }
                            });
                        }
                    });
                });

                $('.pe-email,.change-email').click(function(){
                    var titleName=$(this).data('name');
                    PEMO.DIALOG.confirmL({
                        content: _.template($('#bindEmail').html())(),
                        area: '468px',
                        title: titleName,
                        btn: ['确定', '取消'],
                        btnAlign: 'l',
                        btn1: function () {
                            var email= $.trim($('input[name="email"]').val());
                            var password=$.trim($('input[name="password"]').val());
                            var $error=$('.validate-form-cell').find('.error').eq(0);

                            if(!email){
                                $error.show().text("邮箱不能为空！");
                                return false;
                            }

                            if (!/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/.test(email)){
                                $error.show().text("邮箱格式不正确！");
                                return false;
                            }

                            if(!password){
                                $error.show().text("密码不能为空！")
                                return false;
                            }

                            PEBASE.ajaxRequest({
                                url:pageContext.rootPath + '/uc/user/bindEmail',
                                data:$('#bindEmailForm').serialize(),
                                success:function(data){
                                    if(data.success){
                                        layer.closeAll();
                                        PEMO.DIALOG.alert({
                                            content:'已向您的邮箱'+email+'发送验证信息，请注意查收',
                                            btn: ['我知道了'],
                                            success:function(index){
                                                $(index).find('.layui-layer-content').height(50);
                                            },
                                            yes: function () {
                                                layer.closeAll();
                                            }
                                        });

                                    }else{
                                        $error.show().text(data.message);
                                    }
                                }
                            });
                        },
                        success:function(index){
                            if(index){
                                $(index).find('.layui-layer-btn').css("paddingLeft","119px");
                            }
                        }
                    });
                });
            }
        },
        /*消息中心*/
        msgCenter:{
            init:function(){
                var _this = userControl.msgCenter;
                    _this.initDate();
                    _this.bind();
            },
            initDate:function(){
                $('.pe-stand-table-wrap').peGrid({
                    url: pageContext.rootPath + '/message/client/searchMyMessage',
                    formParam: $('#examManageForm').serialize(),//表格上方表单的提交参数
                    tempId: 'peExamManaTemp',//表格模板的id
                    showTotalDomId: 'showTotal',
                    onLoad: function (t) {
                        $('.pe-stand-table').find('tr:first-child').find('td').css({'borderTop': 'none', 'paddingRight': '0'});
                        PEBASE.peFormEvent('checkbox');
                        var $thisMsgCheckAll = $('.user-message-center-wrap .pe-paper-all-check');
                        $thisMsgCheckAll.find('span.iconfont').removeClass('icon-checked-checkbox').addClass('icon-unchecked-checkbox');
                        $thisMsgCheckAll.find('input.pe-form-ele').prop('checked',false);
                        if(t.data.rows && t.data.rows.length === 0){
                            var hasFooterHeight = $(window).height() - 84 - 60-40;
                            $('.user-main-content-left .pe-center-left').height( hasFooterHeight);
                            $('.my-exam-nav-right-panel').height( hasFooterHeight).css({'minHeight':500,'background':'#fff'});
                            $('.user-main-right-panel').css('background','none');
                            $('.pe-stand-table-main-panel').removeClass('blue-shadow');
                            return false;
                        }
                        var isLeftFixed = false;
                        if(t && t.options.pageSize > 10 && t.data.total > 15){
                            isLeftFixed = true;
                        }
                        userControl.renderHeight(isLeftFixed);
                    }
                });
            },
            bind:function(){
                $('.pe-stand-table-wrap').delegate('.pe-message-delete', 'click', function () {
                    var id = $(this).data('id');
                    $.post(pageContext.rootPath + '/message/client/deleteMessage', {'messageId': id}, function (data) {
                        if (data.success) {
                            PEMO.DIALOG.tips({
                                content: '删除成功',
                                time: 1000,
                                end: function () {
                                    $('.pe-stand-table-wrap').peGrid('refresh');
                                }
                            });

                            return false;
                        }
                        PEMO.DIALOG.tips({
                            content: '删除失败',
                            time: 1500
                        })
                    }, 'json')
                });
                $('.pe-stand-table-wrap').delegate('.pe-mark-read', 'click', function () {
                    var id = $(this).data('id');
                    $.post(pageContext.rootPath + '/message/client/markReadMessage', {'messageId': id}, function (data) {
                        if (data.success) {
                            PEMO.DIALOG.tips({
                                content: '成功标记为已读',
                                time: 1000,
                                end: function () {
                                    $('.pe-stand-table-wrap').peGrid('refresh');
                                }
                            });
                            return false;
                        }
                        PEMO.DIALOG.tips({
                            content: '标记失败',
                            time: 1500
                        })
                    }, 'json');

                });
                $('#batchDeleteDom').on('click', function () {
                    var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
                    if (!rows || rows.length <= 0) {
                        PEMO.DIALOG.alert({
                            content: '请至少先选择一条消息！',
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });
                        return false;
                    }
                    $.post(pageContext.rootPath + '/message/client/batchDeleteMessage', {'messageId': JSON.stringify(rows)}, function (data) {
                        if (data.success) {
                            PEMO.DIALOG.tips({
                                content: '删除成功',
                                time: 1000,
                                end: function () {
                                    $('.pe-stand-table-wrap').peGrid('refresh');
//                            $('.pe-paper-all-check').trigger('click');
                                }
                            });

                            return false;
                        }
                        PEMO.DIALOG.tips({
                            content: '删除失败',
                            time: 1500
                        })
                    }, 'json')
                });
                $('#batchReadDom').on('click', function () {
                    var rows = $('.pe-stand-table-wrap').peGrid('selectRows');
                    if (!rows || rows.length <= 0) {
                        PEMO.DIALOG.alert({
                            content: '请至少先选择一条消息！',
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });
                        return false;
                    }
                    $.post(pageContext.rootPath + '/message/client/batchMarkReadMessage', {'messageId': JSON.stringify(rows)}, function (data) {
                        if (data.success) {
                            PEMO.DIALOG.tips({
                                content: '成功标记为已读',
                                time: 1000,
                                end: function () {
                                    $('.pe-stand-table-wrap').peGrid('refresh');
                                }
                            });

                            return false;
                        }
                        PEMO.DIALOG.tips({
                            content: '标记失败',
                            time: 1000
                        })
                    }, 'json')
                });

                $('.pe-stand-table-wrap').delegate('.message-content-cla', 'click', function () {
                    var content = $(this).attr('title');
                    var id = $(this).data('id');
                    var notRead = $(this).find('.icon-tree-dot') && $(this).find('.icon-tree-dot').length > 0;
                    PEMO.DIALOG.alert({
                        content: '<p style="font-size: 14px;" class="message-content-p">'+content+'</p>',
                        btn: ['关闭'],
                        area: ['650px','auto'],
                        yes: function () {
                            layer.closeAll();
                            if(!notRead){
                                return false;
                            }

                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/message/client/markReadMessage',
                                data: {'messageId': id},
                                success: function (data) {
                                    $('.pe-stand-table-wrap').peGrid('refresh');
                                }
                            });
                        },
                        cancel: function () {
                            layer.closeAll();
                            if(!notRead){
                                return false;
                            }

                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/message/client/markReadMessage',
                                data: {'messageId': id},
                                success: function (data) {
                                    $('.pe-stand-table-wrap').peGrid('refresh');
                                }
                            });
                        },
                        success:function(){
                            var $thisMsgP = $('.message-content-p');
                            $('.layui-layer-content').height($thisMsgP.height() + 5);
                        }

                    });
                });
            }
        },
        /*环境检测*/
        environmentCheck:{
            showAttendExam:function(){
                if (enviromentValid) {
                    if(msgValid && examTime){
                        $('.pe-for-submit').removeClass('forbid-take-exam-btn');
                    }

                    $('.pe-environment-check').addClass('check-success').hide();
                    $('.online-environment-wrap').show();
                }
            },
            bind: function () {
                var _this = this;
                $(".pe-online-close").click(function () {
                    $(".pe-online-exam-top").slideUp();
                });

                $('.pe-online-btn').on('click', function () {
                    var $this = $(this);
                    if($this.prop('disabled')){
                        return false;
                    }

                    $this.prop('disabled',true);
                    _this.countdown(60);
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath +'/ems/exam/client/getUserVerify',
                        data: {examId: _this.examId}
                    });
                });

                $('.pe-online-sure').on('click', function () {
                    if ($(this).hasClass('forbid-take-exam-btn') || !msgValid || !enviromentValid) {
                        $('.pe-for-submit').addClass('forbid-take-exam-btn');
                        return false;
                    }
                    var isCanJoinExam = false;
                    _this.checkLegality(function (t) {
                        if (t) {
                            isCanJoinExam = true;
                        }
                    },_this.examId);

                    if (isCanJoinExam) {
                        location.replace(pageContext.rootPath + '/ems/exam/client/enterExam?examId=' + _this.examId+'&openTab='+openTab);
                    }
                });

                $('.pe-online-check-num').on('blur', function () {
                    var code = $(this).val();
                    if (!code || code.length != 4) {
                        return false;
                    }
                    _this.validateCode();
                });

                $('.pe-for-continue').on('click', function () {
                    window.close();
                });

                if($('.pe-environment-check').get(0)){
                    if($('.pe-environment-check').get(0)){
                        var _thisShouldBeHeight = $(window).height() - 64 - 60;
                        $('.pe-environment-check').height(_thisShouldBeHeight);
                    }
                    if($('.check-wrong-wrap').get(0)){
                        var wrongWrapShouldHeight = $(window).height() - 64-60 - 20;
                        $('.check-wrong-wrap').height(wrongWrapShouldHeight);
                    }

                }


                $('.environment-result-close').on('click',function(){
                    window.close();
                });

                $('.environment-result-reflash').on('click',function(){
                    location.reload();
                });
                /*常见故障检测点击事件*/
                $('.pe-result-way .solve-msg-li').click(function(){
                    var $_thisMsgLi = $(this),$_thisArrow = $_thisMsgLi.find('.iconfont'),$allSolveBlock = $('.problem-solve-block');

                    if($_thisMsgLi.find('.problem-solve-block:visible').get(0)) {
                        $_thisMsgLi.find('.problem-solve-block:visible').slideUp();
                        $_thisMsgLi.find('.iconfont').removeClass('icon-thin-arrow-up').addClass('icon-thin-arrow-down');
                    }else{
                        $_thisMsgLi.find('.problem-solve-block').slideDown();
                        $_thisMsgLi.find('.iconfont').removeClass('icon-thin-arrow-down').addClass('icon-thin-arrow-up');
                    }

                })
            },

            validateCode: function () {
                var _this = this;
                var $checkNumDom = $('.pe-online-check-num'),
                    code = $checkNumDom.val(),
                    $error = $checkNumDom.parents('.validate-form-cell').find('.error'),
                    $btn = $checkNumDom.parents('.validate-form-cell').find('.pe-online-btn'),
                    $success = $checkNumDom.parents('.validate-form-cell').find('.success');
                $error.hide();
                $success.hide();
                $error.text('');
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exam/client/checkUserVerify',
                    data: {examId: _this.examId, code: code},
                    success: function (data) {
                        if (data.success) {
                            $btn.show();
                            $success.show();
                            $success.text(' 验证成功');
                            msgValid = true;
                            userControl.environmentCheck.showAttendExam();
                            return false;
                        }

                        $error.show();
                        $error.text(' 验证失败');
                    }
                });
            },

            checkEnviroment:function(){
                var isCamOk,camState;
                var cameraDom = $('.pe-result-camera'), speakerDom = $('.pe-result-speaker');
                if(!cameraDom.get(0) && !speakerDom.get(0)){
                    $('.online-environment-wrap').show();
                    $('.pe-environment-check').hide();
                }else if(cameraDom.get(0) && !speakerDom.get(0)){
                    startCameraCheck();
                }else{
                    audioCheckStart();
                }

                /*摄像头检测部分*/
                function startCameraCheck(){
                    $('.pe-environment-check').show();
                    var checkCamInterval = setInterval(function(){
                        if( EnCheck.camStateNum === 1){
                            clearInterval(checkCamInterval);
                        }else if( EnCheck.camStateNum === 2){
                            clearInterval(checkCamInterval);
                        }else{

                        }
                        if(EnCheck.camStateNum !== 0){
                            isGetCamStateShow(true);
                        }
                    },100);
                    camChecking();
                }

                /*循环监听是否有摄像头或者(摄像头有无损坏?)*/
                function camChecking(){
                    //检测是否以后flash
                    var success = EnCheck.flash();
                    if(success && success.isFlash === 1){
                        isGetCamStateShow(true);
                    }else{
                        $('.camera-failed').show();
                        $('.camera-loading').hide();
                        $('.pe-environment-check').hide();
                        $('.online-environment-wrap').hide();
                        $('.check-wrong-wrap').show();
                        alert('缺少flash插件或者您当前浏览器flash版本偏低(<11)，可能会导致摄像头使用不了，请安装或升级您的flash');
                        return false;
                    }
                }

                /*摄像头状态检测成功之后的状态*/
                function isGetCamStateShow(success){
                    if($('#webcam').find('object').get(0)){
                        $('#webcam').html('');
                    }
                    EnCheck.camera();
                    if(EnCheck.camStateNum === 1){
                        $('#XwebcamXobjectX').remove();
                        $('.camera-success').show();
                        $('.camera-loading').hide();
                        if (!speakerDom || speakerDom.length === 0) {
                            var $onlineTexts = document.getElementsByClassName('pe-online-text');
                            for(var i=0;i<$onlineTexts.length;i++){
                                $onlineTexts[i].style.display = "none";
                            }

                            var $pass = document.getElementsByClassName('test-pass');
                            for(i=0;i<$pass.length;i++){
                                $pass[i].style.display = "block";
                            }

                            enviromentValid = true;
                            userControl.environmentCheck.showAttendExam();
                        }else{
                            if(audioValid){
                                enviromentValid = true;
                                userControl.environmentCheck.showAttendExam();
                            }else{
                                $('.pe-environment-check').hide();
                                $('.check-wrong-wrap').show();
                            }
                        }

                    }else if(EnCheck.camStateNum === 2){
                        $('.camera-failed').show();
                        $('.camera-loading').hide();
                        $('.pe-environment-check').hide();
                        $('.check-wrong-wrap').show();
                    }
                }

                /*音频检测部分*/
                function audioCheckStart(){
                    $('.online-environment-wrap').show();
                    EnCheck.audioCheck(_.template($('#audioCheckTemp').html())(), pageContext.resourcePath + '/web-static/proExam/audioTest.mp3', function (index) {
                        $('.speaker-success').show();
                        if ((!cameraDom || cameraDom.length === 0)) {
                            var $onlineTexts = document.getElementsByClassName('pe-online-text');
                            for(var i=0;i<$onlineTexts.length;i++){
                                $onlineTexts[i].style.display = "none";
                            }

                            var $pass = document.getElementsByClassName('test-pass');
                            for(i=0;i<$pass.length;i++){
                                $pass[i].style.display = "block";
                            }

                            enviromentValid = true;
                            userControl.environmentCheck.showAttendExam();
                        }else{
                            $('.online-environment-wrap').hide();
                            audioValid = true;
                            startCameraCheck();
                        }
                        layer.close(index);
                        $('.pe-environment-check').show();
                    }, function (index) {
                        $('.speaker-failed').show();
                        layer.close(index);
                        $('.online-environment-wrap').hide();
                        if(cameraDom.get(0)){
                            $('.pe-environment-check').show();
                            $('.online-environment-wrap').hide();
                            startCameraCheck();
                        }else{
                            $('.check-wrong-wrap').show();
                        }

                    });
                }

            },
            checkLegality: function (callback) {
                var _this = this;
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exam/client/checkEnterExam',
                    data: {examId: _this.examId},
                    async: false,
                    success: function (data) {
                        if (data.success) {
                            callback(true);
                            return false;
                        }

                        var message = '<div><h3 class="pe-dialog-content-head">' + data.message + '</h3>';
                        if (data.data) {
                            message = message + '<p class="pe-dialog-content-tip">很遗憾，您已经迟到' + data.data + '分钟了。</p>';
                        }

                        message = message + '</div>';
                        PEMO.DIALOG.alert({
                            content: message,
                            area: ['500px'],
                            btn: ['我知道了'],
                            yes: function (shiIndex) {
                                layer.close(shiIndex);
                            }
                        })
                    }
                });
            },

            examId:'',
            init: function (examId) {
                var _this = this;
                _this.examId = examId;
                _this.bind();
                _this.initData();
                _this.checkEnviroment();
            },

            initData: function () {
                var _this = this;
                _this.residualTime();
                _this.showAttendExam();
            },

            residualTime:function () {
                if(residualTime<=0){
                    examTime=true;
                    return false;
                }

                var InterValObj = setInterval(function () {
                    console.info(residualTime);
                    if (residualTime == 0) {
                        examTime = true;
                        $('.exam-residual-time').html("参加考试");
                        if (enviromentValid && msgValid && examTime) {
                            $('.pe-for-submit').removeClass('forbid-take-exam-btn');
                            $('.pe-wrong-nopass-btn').parents('.pe-admin-explain').remove();
                        }

                        clearInterval(InterValObj);
                    } else {
                        residualTime--;
                        var min = Math.floor(residualTime / 60);
                        var sec = residualTime % 60;
                        if(residualTime<3600) {
                            $('.exam-residual-time').html(min + ':' + sec);
                        }
                    }

                }, 1000);
            },
            countdown: function (time) {
                if (!time && time <= 0) {
                    return false;
                }

                $('.exam-user-verify-btn').html(time + '秒');
                var timeInterval = setInterval(function () {
                    if (time === 0) {
                        clearInterval(timeInterval);
                        $('.exam-user-verify-btn').addClass('pe-online-btn');
                        $('.exam-user-verify-btn').html('获取验证码');
                        return false;
                    }

                    $('.exam-user-verify-btn').html(--time + '秒');
                }, 1000);
            }
        },
        /*忘记密码*/
        forgetPW:{
            writePhone:{
                init: function () {
                    var _this = this;
                    _this.bind();
                },

                bind: function () {
                    $(document).keydown(function (e) {
                        var e = e || window.event;
                        if (e.keyCode == 13) {
                            $('.save-next').click();
                            return false;
                        }
                    });

                    $('.pe-password-change-btn').click(function () {
                        $('#verify-code').attr('src', pageContext.rootPath + '/login/createVerifyCode?_t=' + Math.random());
                        return false;
                    });

                    $('.save-next').click(function () {
                        $('.pe-password-tip').hide();
                        var userName = $('input[name="userName"]').val();
                        if (!userName) {
                            $('input[name="paperCode"]').focus();
                            $('.error-msg').text('账号不能为空');
                            $('.pe-password-tip').show();
                            return false;
                        }

                        var verifyCode = $('input[name="verifyCode"]').val();
                        if (!verifyCode) {
                            $('input[name="verifyCode"]').focus();
                            $('.error-msg').text('验证码不能为空');
                            $('.pe-password-tip').show();
                            return false;
                        }

                        PEBASE.ajaxRequest({
                            url: pageContext.rootPath +'/login/checkAccount',
                            data: {account: userName, verifyCode: verifyCode},
                            success: function (data) {
                                if (!data.success) {
                                    $('.error-msg').text(data.message);
                                    $('.pe-password-tip').show();
                                    $('#verify-code').attr('src', pageContext.rootPath + '/login/createVerifyCode?_t=' + Math.random());
                                    return false;
                                }

                                location.href = pageContext.rootPath +'/login/initMustPage?account=' + userName;
                            }
                        });
                    });
                }
            },
            verifyUserID:{
                initVal:{
                    mobile:'',
                    email:'',
                    userId:''
                },
                init: function (mobile,email,userId) {
                    var _this = this;
                    _this.initVal.mobile = mobile;
                    _this.initVal.email = email;
                    _this.initVal.userId = userId;
                    _this.bind(_this.initVal.userId);
                },
                bind: function (userId) {
                    var _this = this;
                    $('.pe-identity-sel').on('change', function () {
                        var validType = $('.pe-identity-sel').val();
                        if (validType === 'mobile') {
                            $('.phone-or-email').text('已验证手机：');
                            var mobileVal = $('.hidden-mobile').html();
                            $('.phone-email-val').text(mobileVal);
                            if (_this.initVal.mobile) {
                                $('.mobile-img-cla').show();
                            }

                        } else {
                            $('.phone-or-email').text('已验证邮箱：');
                            var emailVal = $('.hidden-email').html();
                            $('.phone-email-val').text(emailVal);
                            $('.mobile-img-cla').hide();
                        }
                    });

                    $('.pe-password-change-btn').click(function () {
                        $('#verify-code').attr('src', pageContext.rootPath + '/login/createVerifyCode?_t=' + Math.random());
                    });

                    $('.pe-identity-get-btn').on('click', function () {
                        $('.mobile-img-error-message').text('');
                        var verifyCode = $('input[name="verifyCode"]').val();

                        var validType = $('.pe-identity-sel').val();
                        var params = {verifyCode: verifyCode};
                        params[validType] = _this.initVal[validType];
                        PEBASE.ajaxRequest({
                            url: pageContext.rootPath +'/login/createIdentityCode',
                            data: params,
                            success: function (data) {
                                if (!data.success) {
                                    $('.mobile-img-error-message').text(data.message);
                                    return false;
                                }

                                $('.error-message').html('');
                                $('.pe-identity-get-btn').html('已发送 60s').attr('disabled', 'disabled');
                                $('.pe-identity-sel').attr('disabled', 'disabled');
                                var curCount = 60;
                                $('.text-red').html(curCount);
                                var InterValObj = setInterval(function () {
                                    if (curCount == 0) {
                                        clearInterval(InterValObj);
                                        $('.pe-identity-get-btn').removeAttr("disabled");
                                        $('.pe-identity-get-btn').html('重新发送');
                                        $('.pe-identity-sel').removeAttr("disabled");
                                    } else {
                                        curCount--;
                                        $('.pe-identity-get-btn').html('已发送 ' + curCount + 's');
                                        $('.text-red').html(curCount);
                                    }

                                }, 1000);
                            }
                        });
                    });

                    $(document).keydown(function (e) {
                        var e = e || window.event;
                        if (e.keyCode == 13) {
                            $('.save-next').click();
                            return false;
                        }
                    });

                    $('.save-next').click(function () {
                        var peIdentity = $.trim($('input[name="peIdentity"]').val()), validType = $('.pe-identity-sel').val();
                        var params = {verifyCode: peIdentity};
                        params[validType] = _this.initVal[validType];
                        if (!peIdentity) {
                            $('.error-message').html('');
                            $('input[name="peIdentity"]').focus();
                            $('.error-message').append('<i class="iconfont icon-caution-tip" ></i>');
                            $('.error-message').append('验证码不能为空');
                            return false;
                        }

                        $.ajax({
                            url: pageContext.rootPath +'/login/checkIdentityCode',
                            data: params,
                            success: function (data) {
                                var json = eval('(' + data + ')');
                                if (json.success) {
                                    location.href = pageContext.rootPath +'/login/resetPwdPage?userId='+ userId;
                                } else {
                                    $('.error-message').html('');
                                    $('.error-message').append('<i class="iconfont icon-caution-tip" ></i>');
                                    $('input[name="peIdentity"]').focus();
                                    $('.error-message').append(json.message);
                                }
                            }
                        });
                    });
                }
            },
            resetPW:{
                init: function () {
                    var _this = this;
                    _this.bind();
                },
                bind: function () {
                    var _this = this;
                    $('#first-paperCode').on('blur', function () {
                        _this.checkPaperCode();
                    });
                    $('#second-paperCode').on('blur', function () {
                        _this.checkPwd();
                    });
                    $(document).keydown(function (e) {
                        var e = e || window.event;
                        if (e.keyCode == 13) {
                            $('.pe-save-btn').click();
                            return false;
                        }
                    });
                    $('.pe-save-btn').click(function () {
                        _this.checkPaperCode();
                        _this.checkPwd();
                        var firstPaperCode = $('#first-paperCode').val();
                        var id = $('input[name="userId"]').val();
                        $.ajax({
                            url: pageContext.rootPath + '/login/updatePwd',
                            data: {newPassword: firstPaperCode, id: id},
                            Type: 'post',
                            success: function (data) {
                                var json = eval('(' + data + ')');
                                if (json.success) {
                                    location.href = pageContext.rootPath + '/login/passwordSetSuccess';
                                } else {
                                    $(".pe-password-tip").html('');
                                    $('.pe-password-tip').append('<i class="iconfont icon-caution-tip" ></i>');
                                    $('.pe-password-tip').append(json.message);
                                }
                            }
                        });
                    });
                },
                checkPaperCode: function () {
                    var paperCode = $('#first-paperCode').val();
                    if (paperCode.length <6 || paperCode.length>20) {
                        $(".pe-password-tip").html('');
                        $('.pe-password-tip').append('<i class="iconfont icon-caution-tip" ></i>');
                        $('.pe-password-tip').append('密码为6-20位');
                        $('.pe-save-btn').attr('disabled', 'disabled');
                    } else {
                        $(".pe-password-tip").html('');
                        $('.pe-save-btn').removeAttr("disabled");
                    }
                },
                checkPwd: function () {
                    var firstPaperCode = $('#first-paperCode').val();
                    var secondPaperCode = $('#second-paperCode').val();
                    if (firstPaperCode != secondPaperCode) {
                        $(".pe-password-tip").html('');
                        $('.pe-password-tip').append('<i class="iconfont icon-caution-tip" ></i>');
                        $('.pe-password-tip').append('两次输入的密码不相同');
                        $('.pe-save-btn').attr('disabled', 'disabled');
                    }
                    else {
                        $('.pe-save-btn').removeAttr("disabled");
                        $(".pe-password-tip").html('');
                    }
                }
            },
            resetComplete:{
                init:function(){
                    var _this=this;
                    _this.bind()
                },
                bind:function(){
                    $(document).keydown(function (e) {
                        var e = e || window.event;
                        if (e.keyCode == 13) {
                            $('.pe-set-enter-btn').click();
                            return false;
                        }
                    });

                    $('.pe-set-enter-btn').click(function(){
                        location.href = pageContext.rootPath + '/login/loginPage';
                    });
                }
            }
        }

    };


