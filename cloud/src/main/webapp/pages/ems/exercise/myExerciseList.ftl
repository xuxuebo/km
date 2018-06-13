<#assign ctx=request.contextPath/>
<section class="pe-exercise-all-wrap pe-user-right-wrap user-main-right-panel">
    <form action="" name="exerciseForm">
        <div class="right-wrap-content">
        <#--新的练习-->
        </div>
    </form>
    <div class="pe-dynamic-empty-wrap pe-dynamic-no-data" style="display: none;">
        <div class="wrap">
        <div class="user-exam-no-data">
        </div>
        <p class="pe-dynamic-empty">目前暂无练习，请等待管理员为您安排</p>
        </div>
    </div>
</section>


<script type="text/template" id="myExercise">
    <%_.each(data,function(exercise,index){%>
    <%if(exercise.status==='PROCESS'){%>
    <div class="exercise-list-item over-flow-hide">
    <#--如果是图片，没有练习过，下面这个div加上一个class为new-exercise-item,-->
        <%if(exercise.accuracy!=null && exercise.completionRate!=null){%>
        <div class="floatL clearF left-img-wrap">
            <div class="has-exercise-wrap">
                <div class="floatL clearF item-detail">
                    <div class="exercise-progress"><%=parseFloat(exercise.completionRate.toFixed(1),10)%>%</div>
                    <div>完成率</div>
                </div>
                <div class="clearF item-detail">
                    <div class="exercise-progress"><%=parseFloat(exercise.accuracy.toFixed(1),10)%>%</div>
                    <div>正确率</div>
                </div>
                <div class="exercise-arrow"></div>
                <div class="clearF"></div>
            </div>
        </div>
        <%}else{%>
        <div class="floatL clearF left-img-wrap new-exercise-item">
        </div>
        <%}%>
        <div class=" right-item-wrap">
            <h3 class="name-title"><%=exercise.exerciseName%></h3>
            <div class="exercise-end-time">
                截止时间:<%if(exercise.endTime==null){%>
                <span class="">无限制</span>
                <%}else{%>
                <span class=""><%=moment(exercise.endTime).format('YYYY-MM-DD HH:mm')%></span>
                <%}%>
            </div>
            <div class="exercise-buttons-wrap ">
                <#--<%if(!exercise.completionRate||parseFloat(exercise.completionRate.toFixed(1),10)>100){%>-->
                <%if(exercise.hasSubmit){%>
                <button type="button" class="pe-btn pe-btn-white floatR" data-time="<%=exercise.endTime%>" data-id="<%=exercise.id%>">重新开始</button>
                <#--<button type="button" class="pe-btn pe-btn-blue continue-exercise-btn" data-time="<%=exercise.endTime%>" data-id="<%=exercise.id%>">继续答题</button>-->
                <%}else{%>
                <button type="button" class="pe-btn pe-btn-blue continue-exercise-btn floatR" data-time="<%=exercise.endTime%>" data-id="<%=exercise.id%>">继续答题</button>
                <%}%>
                <%if(exercise.accuracy<100&&exercise.completionRate>0){%>
                <a href="javascript:;" data-id="<%=exercise.id%>"  class="exercise-wrong-tips floatL clearF exercise-wrong-tips-wrong">
                    <span class="iconfont floatL clearF"></span>
                    我的错题
                </a>
                <%}else if(exercise.accuracy==100){%>
                <a href="javascript:;" class="exercise-wrong-tips floatL clearF tip-gray">
                    <span class="iconfont floatL clearF"></span>
                    我的错题
                </a>
                <%}%>
            </div>
        </div>
    </div>
    <%}else{%>
    <div class="exercise-list-item over-flow-hide">
        <div class="floatL clearF left-img-wrap new-exercise-item">
        </div>
        <div class="right-item-wrap">
            <h3 class="name-title"><%=exercise.exerciseName%></h3>
            <div class="exercise-end-time">
                截止时间:<%if(exercise.endTime==null){%>
                <span class="">无限制</span>
                <%}else{%>
                <span class=""><%=moment(exercise.endTime).format('YYYY-MM-DD HH:mm')%></span>
                <%}%>
            </div>
            <div class="exercise-buttons-wrap">
                <button type="button" class="pe-btn pe-btn-blue begin-exercise-btn floatR"  data-id="<%=exercise.id%>">开始练习</button>
                <%if(exercise.accuracy==null||exercise.accuracy==100){%>
                    <a href="javascript:;" class="exercise-wrong-tips floatL clearF tip-gray">
                        <span class="iconfont floatL clearF"></span>
                        我的错题
                    </a>
                <%}else{%>
                    <a href="javascript:;" class="exercise-wrong-tips floatL clearF">
                        <span class="iconfont floatL clearF"></span>
                        我的错题
                    </a>
                <%}%>
            </div>
        </div>
    </div>
    <%}%>
    <%});%>

</script>

<script type="text/template" id="exerciseKnowledgeTemp">
    <dd class="user-detail-value">
        <ul class="exercise-knowledge-wrap over-flow-hide">
            <%_.each(data.itemTypes,function(itemType,index){%>
            <%if(itemType === 'SINGLE_SELECTION'){%>
            <li class="item-kn floatL clearF template-item-type-name"data-id="SINGLE_SELECTION">单选题</li>
            <%}else if(itemType === 'MULTI_SELECTION'){%>
            <li class="item-kn floatL clearF  template-item-type-name" data-id="MULTI_SELECTION" >多选题</li>
            <%}else if(itemType === 'INDEFINITE_SELECTION'){%>
            <li class="item-kn floatL clearF template-item-type-name" data-id="INDEFINITE_SELECTION">不定项选择题</li>
            <%}else if(itemType === 'JUDGMENT'){%>
            <li class="item-kn floatL clearF template-item-type-name" data-id="JUDGMENT">判断题</li>
            <%}else if(itemType === 'FILL'){%>
            <li class="item-kn floatL clearF template-item-type-name" data-id="FILL" >填空题</li>
            <%}else if(itemType === 'QUESTIONS'){%>
            <li class="item-kn floatL clearF template-item-type-name" data-id="QUESTIONS">问答题</li>
            <%}%>
            <%});%>
        </ul>
    </dd>

</script>

<script type="text/template" id="exerciseSettingTemp">
    <form id="exerciseSetting">
    <div class="exercise-temp-wrap">
        <dl class="over-flow-hide user-detail-msg-wrap">
            <dt class="floatL user-detail-title">知识点:</dt>
            <dd class="user-detail-value">
                <input type="hidden" name="exercise.id" value="<%=data.id%>"/>
                <input type="hidden" name="knowledgeId" >
                <input type="hidden" name="itemType" >
                <ul class="exercise-knowledge-wrap over-flow-hide">
                    <%if(data.knowledges.length>0){%>
                    <%_.each(data.knowledges,function(knowledge,index){%>
                    <li class="item-kn floatL clearF template-knowledge-name" data-id="<%=knowledge.id%>" title="<%=knowledge.knowledgeName%>"> <%=knowledge.knowledgeName%></li>
                    <%});%>
                    <%}else{%>
                        暂无知识点
                    <%}%>
                </ul>
            </dd>

            <dt class="floatL user-detail-title">题&emsp;型:</dt>
            <div class="exercise-knowledge-temp">
                <dd class="user-detail-value">
                    <ul class="exercise-knowledge-wrap over-flow-hide">
                        <%_.each(data.itemTypes,function(itemType,index){%>
                        <%if(itemType === 'SINGLE_SELECTION'){%>
                        <li class="item-kn floatL clearF template-item-type-name"data-id="SINGLE_SELECTION">单选题</li>
                        <%}else if(itemType === 'MULTI_SELECTION'){%>
                        <li class="item-kn floatL clearF  template-item-type-name" data-id="MULTI_SELECTION" >多选题</li>
                        <%}else if(itemType === 'INDEFINITE_SELECTION'){%>
                        <li class="item-kn floatL clearF template-item-type-name" data-id="INDEFINITE_SELECTION">不定项选择题</li>
                        <%}else if(itemType === 'JUDGMENT'){%>
                        <li class="item-kn floatL clearF template-item-type-name" data-id="JUDGMENT">判断题</li>
                        <%}else if(itemType === 'FILL'){%>
                        <li class="item-kn floatL clearF template-item-type-name" data-id="FILL" >填空题</li>
                        <%}else if(itemType === 'QUESTIONS'){%>
                        <li class="item-kn floatL clearF template-item-type-name" data-id="QUESTIONS">问答题</li>
                        <%}%>
                        <%});%>
                    </ul>
                </dd>
            </div>

            <dt class="floatL user-detail-title">题&emsp;量:</dt>
            <dd class="user-detail-value">
                <label class="pe-radio" style="margin-right:25px;">
                    <span class="iconfont icon-checked-radio"></span>
                    <input class="pe-form-ele"  type="radio" checked="checked" value="ALL" name="itemNumberType"/>
                    全部&emsp;
                </label>
                <label class="pe-radio ">
                    <span class="iconfont icon-unchecked-radio"></span>
                    <input class="pe-form-ele pe-form-ele-input" type="radio" value="PORTION" name="itemNumberType"/>
                    自定义
                </label>
                <input type="text" name="itemNumber"
                       class="exam-create-num-input exercise-item-count-input"><span class="add-paper-tip-text">*最大可选<span
                    class="max-num max-item-num"><%=data.itemCount%></span>道题</span>
            </dd>
            <dt class="floatL user-detail-title">题&emsp;速:</dt>
            <dd class="user-detail-value">
                <label class="pe-radio" style="margin-right:25px;">
                    <span class="iconfont pe-unlimit-input icon-checked-radio"></span>
                    <input class="pe-form-ele "  type="radio" checked="checked" value="UNLIMIT" name="speedType"/>
                    不限制
                </label>
                <label class="pe-radio ">
                    <span class="iconfont pe-limit-input icon-unchecked-radio"></span>
                    <input class="pe-form-ele" type="radio" value="LIMIT" name="speedType"/>
                    限制
                </label>
                <input type="text" name="speed" style="width:60px;"
                       class="exam-create-num-input exam-create-num">秒/题
                 <span class="pe-total-time"   style="display: none"> <span class="add-paper-tip-text">*预计<span class="max-num max-num-time">0</span>分钟做完题</span></span>
            </dd>
            <dt class="floatL user-detail-title">模&emsp;式:</dt>
            <dd class="user-detail-value">
               <#-- <label class="pe-radio" style="margin-right:25px;">
                    <span class="iconfont pe-unlimit-input icon-checked-radio"></span>
                    <input class="pe-form-ele "  type="radio" checked="checked" value="SHOW" name="questionAnswer"/>
                    显示答案
                </label>
                <label class="pe-radio ">
                    <span class="iconfont pe-limit-input icon-unchecked-radio"></span>
                    <input class="pe-form-ele" type="radio" value="NOSHOW" name="questionAnswer"/>
                    不显示答案
                </label>-->
                <div>
                    <label class="pe-checkbox">
                        <span class="iconfont icon-checked-checkbox peChecked"></span>
                        <input class="pe-form-ele" type="checkbox" checked="checked" value="SHOW" name="questionAnswer"/>
                        答完自动显示答案
                    </label>
                </div>
            </dd>
        </dl>
    </div>
    </form>
</script>
<script type="text/javascript">

    $(function () {
        var formD = $("#exerciseSetting");
        var isChecked = ":checked";
        var myExerciseDynamic = {
            init: function () {
                var _this = this;
                _this.initDynamic();
                _this.bind();
            },

            initDynamic: function () {
                PEBASE.ajaxRequest({
                    url: pageContext.rootPath + '/ems/exercise/client/searchExerciseDynamic',
                    success: function (data) {
                        if (data && data.length == 0) {
                            $('.pe-user-right-wrap .right-wrap-content').hide();
                            $('.pe-dynamic-no-data').show();
                            $('.my-exam-nav-right-panel').css('background','#fff');
                            var hasFooterHeight = $(window).height() - 84 - 60-40;
                            $('.user-main-content-left .pe-center-left').height( hasFooterHeight).css('minHeight',450);
                            $('.my-exam-nav-right-panel').height( hasFooterHeight).css('minHeight',450);
                            $('.user-main-right-panel').css('background','none');
                            $('.pe-stand-table-main-panel').removeClass('blue-shadow');
                            return false;
                        }

                        $('.right-wrap-content').html(_.template($('#myExercise').html())({data: data}));
                        userControl.renderHeight();
                    }
                });
            },

            checkParams: function () {
                if (formD.find("input[name='itemNumberType']" + isChecked).val() === 'PORTION') {
                    var itemCount=formD.find("input[name='itemNumber']").val();
                    if (!itemCount || $.trim(itemCount) === '' || parseInt($.trim(itemCount)) < 1) {
                        PEMO.DIALOG.tips({
                            content: "请设置练习的题量！",
                            time: 1500
                        });

                        return false;
                    }
                }

                return true;
            },

            bind: function () {
                $('.pe-exercise-all-wrap').delegate('.exercise-wrong-tips-wrong','click',function(){
                    var id = $(this).data("id");
                    window.open(pageContext.rootPath + '/ems/exercise/client/viewWrongItem?exerciseId='+id);
                });

                $('.pe-exercise-all-wrap').delegate('.pe-btn-white','click',function(){
                    var time = $(this).data("time");
                    if (time && !(myExerciseDynamic.checkTime(time))) {
                        return false;
                    }

                    var id = $(this).data("id");
                    PEMO.DIALOG.confirmR({
                        content:'答题记录将被删除，是否继续？',
                        title: '重新开始',
                        btn: ['取消', '继续'],
                        btn2:function(){
                            PEBASE.ajaxRequest({
                                url: pageContext.rootPath + '/ems/exercise/client/renew',
                                data: {id: id},
                                success:function(data){
                                    if(data.success){
                                        myExerciseDynamic.initDynamic();
                                    }
                                }
                            });
                        },
                        btn1:function(){
                            layer.closeAll();
                        }
                    });
                });

                $('.pe-exercise-all-wrap').delegate('.continue-exercise-btn', 'click', function () {
                    var id = $(this).data("id");
                    window.open(pageContext.rootPath+'/ems/exercise/client/enterExercise?exerciseId='+id,"ENTER_EXERCISE");
                });

                $('.pe-exercise-all-wrap').delegate('.begin-exercise-btn', 'click', function () {
                    var id = $(this).data("id");
                    PEBASE.ajaxRequest({
                        url: pageContext.rootPath + '/ems/exercise/client/get',
                        data:{exerciseId:id},
                        success: function (data) {
                            PEMO.DIALOG.confirmL({
                                content: _.template($('#exerciseSettingTemp').html())({data: data}),
                                skin: 'pe-layer-alert pe-exercise-layer',
                                title: '练习设置',
                                area: ['856px', '540px'],
                                btn: ['进入练习'],
                                btn1: function () {
                                    var isVal = myExerciseDynamic.checkParams();
                                    var isTrue = myExerciseDynamic.checkSetting();
                                    if (!isVal || !isTrue) {
                                        return false;
                                    }

                                    var itemTypes = [];
                                    $('.curs').each(function (index, ele) {
                                        itemTypes.push($(ele).data("id"));
                                    });

                                    $('input[name="itemType"]').val(JSON.stringify(itemTypes));
                                    var knowledgeId = [];
                                    $('.cur').each(function (index, ele) {
                                        knowledgeId.push($(ele).data("id"));
                                    });

                                    $('input[name="knowledgeId"]').val(JSON.stringify(knowledgeId));
                                    PEBASE.ajaxRequest({
                                        url: pageContext.rootPath + '/ems/exercise/client/entryExercise',
                                        data: $('#exerciseSetting').serializeArray(),
                                        async: false,
                                        success: function (data) {
                                            if (data.success) {
                                                window.open(pageContext.rootPath + '/ems/exercise/client/enterExercise?exerciseId=' + id);
                                            }

                                        }
                                    });

                                    layer.closeAll();
                                    myExerciseDynamic.initDynamic();
                                },
                                success: function () {
                                    PEBASE.peFormEvent('radio');
                                    PEBASE.peFormEvent('checkbox');
                                    $('.template-knowledge-name').on('click', function(){
                                        $(this).toggleClass('cur');
                                        var knowledgeId = [];
                                        $('.cur').each(function(index,ele){
                                            knowledgeId.push($(ele).data("id"));
                                        });

                                        PEBASE.ajaxRequest({
                                            url:pageContext.rootPath + '/ems/exercise/client/itemTypes',
                                            data:{exerciseId:id,knowledgeId:JSON.stringify(knowledgeId)},
                                            success:function(data){
                                                $('.exercise-knowledge-temp').html(_.template($('#exerciseKnowledgeTemp').html())({data: data}));
                                                $('.max-item-num').html(data.itemCount) ;
                                            }
                                        });

                                    });

                                    $('.exercise-item-count-input').on('keyup', function () {
                                        this.value = this.value.replace(/[^\d]/g, "");
                                        var itemNumber = parseInt($(this).val(),10);
                                        var totalItem=parseInt($('.max-item-num').html(),10);
                                        if(itemNumber>totalItem){
                                            $(this).val('');
                                        }

                                        if ($('.peChecked').next('input[name="itemNumberType"]').val() === 'PORTION') {
                                            var speed = $('input[name="speed"]').val();
                                            if (speed > 0 && itemNumber > 0) {
                                                $('.max-num-time').html((itemNumber * speed / 60).toFixed(1));
                                            }
                                        }
                                    });


                                    $('.exam-create-num').on('keyup', function () {
                                        this.value = this.value.replace(/[^\d]/g, "");
                                        var speed = $(this).val();
                                        var itemNumber;
                                        if ($('.peChecked').next('input[name="itemNumberType"]').val() === 'PORTION') {
                                            itemNumber = $('input[name="itemNumber"]').val();
                                        } else {
                                            itemNumber = $('.max-item-num').html();
                                        }
                                        if (speed > 0 && itemNumber > 0) {
                                            $('.max-num-time').html((itemNumber * speed / 60).toFixed(1));
                                        }
                                    });

                                    $('.pe-limit-input').on('click',function(){
                                        $('.pe-total-time').show();
                                    });

                                    $('.pe-unlimit-input').on('click',function(){
                                        $('.pe-total-time').hide();
                                    });

                                    $('.exercise-knowledge-temp').delegate('.template-item-type-name', 'click', function () {
                                        $(this).toggleClass('curs');
                                        var itemTypes = [];
                                        $('.curs').each(function (index, ele) {
                                            itemTypes.push($(ele).data("id"));
                                        });

                                        var knowledgeId = [];
                                        $('.cur').each(function (index, ele) {
                                            knowledgeId.push($(ele).data("id"));
                                        });

                                        PEBASE.ajaxRequest({
                                            url: pageContext.rootPath + '/ems/exercise/client/countItem',
                                            data: {
                                                exerciseId: id,
                                                itemType: JSON.stringify(itemTypes),
                                                knowledgeId: JSON.stringify(knowledgeId)
                                            },
                                            success: function (data) {
                                                $('.max-item-num').html(data);
                                            }
                                        });
                                    });

                                }
                            })
                        }
                    });
                });

            },

            checkSetting: function () {
                var isTrue=true;
                var speedType = $('.peChecked').next('input[name="speedType"]').val();
                var itemNumberType = $('.peChecked').next('input[name="itemNumberType"]').val();
                if (itemNumberType === 'PORTION') {
                    var itemNumber = parseInt($('input[name="itemNumber"]').val(),10);
                    var totalNumber= parseInt($('.max-item-num').html(),10);
                    if (!itemNumber || parseInt(itemNumber) < 1) {
                        PEMO.DIALOG.alert({
                            content: '题量不能为空',
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });

                        isTrue = false;
                    } else if (itemNumber > totalNumber) {
                        PEMO.DIALOG.alert({
                            content: '题量不能大于最大可选题量',
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });

                        isTrue=false;
                    }

                }

                if (speedType === 'LIMIT') {
                    var speed = $('input[name="speed"]').val();
                    if (!speed) {
                        PEMO.DIALOG.alert({
                            content: '题速不能为空',
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });

                        isTrue = false;
                    } else if (parseInt(speed) < 1) {
                        PEMO.DIALOG.alert({
                            content: '您的速度太快了',
                            btn: ['我知道了'],
                            yes: function () {
                                layer.closeAll();
                            }
                        });

                        isTrue = false;
                    }
                }
                return isTrue;
            },

            checkTime: function (time) {
                var nowTime = new Date().getTime();
                var times = moment(time).valueOf();
                if (nowTime > times) {
                    PEMO.DIALOG.alert({
                        content: '该练习已经结束',
                        btn:['我知道了'],
                        yes:function(){
                            layer.closeAll();
                        }
                    });
                    return false;
                }
                return true;
            }
        };
        myExerciseDynamic.init();
    });


</script>
