(function ($) {
    function _$(t) {
        return $(t);
    }

    //加载表格数据数据
    function render(t, refresh) {
        if (refresh) {
            // loadData(t, true);
            initPeGrid(t)
        } else {
            loadData(t);
        }

    }

    function initPeGrid(t) {
        var data = $.data(t, 'peGrid');
        //删除后请求返回的rows，通过判断返回rows是否为空,来判断是否改变page
        if (data.options.isReMathPage) {
            if(data.options.page !== 1){
                data.options.page = data.options.page - 1;
            }
        }
        data.isLoaded = false;
        loadData(t);
    }

    //load的peGrid的数据，用于分页点击
    function loadData(dom, refresh) {
        var data = $.data(dom, 'peGrid');
        if (refresh) {
            data.options.isReMathPage = false;
        }

        if (data.options.url) {
            $.ajax({
                url: data.options.url + '?page=' + data.options.page + '&pageSize=' + data.options.pageSize,
                data: data.options.formParam,
                dataType: 'json',
                error: function () {

                },
                success: function (dataJson) {
                    if (refresh && dataJson.rows && dataJson.rows.length === 0 && (dataJson.total !== 0 || dataJson.total)) {
                        data.options.isReMathPage = true;
                        initPeGrid(dom, refresh);
                        return;
                    } else {
                        if (dataJson.rows && dataJson.rows.length === 0) {
                            if($('.pe-fixed-table-panel').get(0)){
                                $('.pe-fixed-table-panel').hide()
                            }
                            dataJson.emptyData = true;
                            $(dom).css('borderBottom','none');
                        }else{
                            if($('.pe-fixed-table-panel').get(0)){
                                $('.pe-fixed-table-panel').show();
                            }
                            $(dom).css('borderBottom','1px solid #e0e0e0');
                        }
                    }

                    dataJson.tableTitles = data.options.title;
                    $(dom).html('');
                    if(data.options.isTableHasFixed){
                        $('.pe-stand-table-main-panel').find('table').remove();
                    }

                    if(data.options.isTableScroll && (dataJson.rows && dataJson.rows.length !== 0)){
                        var titlesArr = data.options.title,
                            thisWidth = 0,
                            checkedNum = 0;
                        if(data.options.isUserExtend){
                            $.each(titlesArr,function(k,arr){
                                if(arr.checked){
                                    checkedNum++;
                                    if(arr.columnName === 'sexType' || arr.columnName === 'status') {
                                        thisWidth += 50;
                                    }else if(arr.columnName === 'employeeCode'){
                                        thisWidth += 36;
                                    }else if(arr.columnName === 'status'){
                                        thisWidth += 50;
                                    }else if( arr.columnName === 'entryTime') {
                                        thisWidth += 90;
                                    }else if(arr.columnName === 'opt') {
                                        // thisWidth += 76;
                                    }else if(arr.columnName === 'userName' || arr.columnName === 'loginName'){
                                        // thisWidth += 118;
                                    }else if(arr.columnName === 'mobile'){
                                        thisWidth += 80;
                                    }else if(arr.columnName === 'positionName' || arr.columnName === 'email'||arr.columnName === 'organize.organizeName'){
                                        thisWidth += 150;
                                    }else if(arr.columnName === 'checkbox'){
                                        // thisWidth += 16;
                                    }else{
                                        thisWidth += 150;
                                    }
                                }
                            });
                            thisWidth += checkedNum * 24;
                            thisWidth < 774? (thisWidth=774):thisWidth;
                        }else if(data.options.tableScrollType === 'userMana'){
                            for(var k=0,len=titlesArr.length;k<len;k++){
                                if(titlesArr[k].checked){
                                    checkedNum++;
                                    if(titlesArr[k].columnName === 'sexType' || titlesArr[k].columnName === 'status') {
                                        thisWidth += 36;
                                    }else if(titlesArr[k].columnName === 'employeeCode'){
                                        thisWidth += 36;
                                    }else if(titlesArr[k].columnName === 'status'){
                                        thisWidth += 30;
                                    }else if( titlesArr[k].columnName === 'entryTime') {
                                        thisWidth += 90;
                                    }else if(titlesArr[k].columnName === 'opt') {
                                        // thisWidth += 76;
                                    }else if(titlesArr[k].columnName === 'userName'){
                                        // thisWidth += 70;
                                    }else if(titlesArr[k].columnName === 'loginName'){
                                        // thisWidth += 108;
                                    }else if(titlesArr[k].columnName === 'mobile'){
                                        thisWidth += 80;
                                    }else if(titlesArr[k].columnName === 'positionName' || titlesArr[k].columnName === 'email'||titlesArr[k].columnName === 'organize.organizeName'){
                                        thisWidth += 136;
                                    }else if(titlesArr[k].columnName === 'checkbox'){
                                        // thisWidth += 16;
                                    }else{
                                        thisWidth += 150;
                                    }
                                }
                            }
                            thisWidth += checkedNum * 24;
                            thisWidth < 500 ? (thisWidth=500):thisWidth;
                        }else if(data.options.tableScrollType === 'reviewCompResult'){
                          var tableTitles = data.options.title;
                            var subjectNum = 0;
                            for(var i=0,iLen = tableTitles.length;i<iLen;i++){
                                if(tableTitles[i].name === 'subject'){
                                    subjectNum++;
                                }
                            }
                            if(subjectNum >5){
                                thisWidth = 884;
                            }else{
                                thisWidth = 500;
                            }
                        }

                        $(dom).width(thisWidth);
                    }
                    $(dom).append(_.template($('#' + data.options.tempId).html())({peData: dataJson,compareData:data.options.compareData}));
                    $(dom).append('<input type="hidden" name="tablePageSize" value="'+ data.options.pageSize+'" />');
                    data.data = dataJson;
                    $(dom).find('tr').hover(
                        function(e){
                            var e = e || window.event;
                                e.stopPropagation();
                            if($(this).find('td').hasClass('pe-stand-table-empty')){
                                return false;
                            }
                                $(this).addClass('tr-hover');
                        },
                        function(e){
                            var e = e || window.event;
                            e.stopPropagation();
                            if($(this).find('td').hasClass('pe-stand-table-empty')){
                                return false;
                            }
                            $(this).removeClass('tr-hover');
                        }
                    );
                    if(data.options.pagination === 'default'){
                        peGridPanination(dom);
                        PEBASE.peSelect($('.pe-stand-table-pagination-pageSize'), null, $('input[name="savePaginationPageSize"]'),data.peGrid);
                    }else if(data.options.pagination === 'layer'){
                        PEBASE.peSelect($(parent.window.document).find('.layer-page-drop-down'), null, $('input[name="saveLayerPaginationPageSize"]'),data.peGrid);
                        $(parent.window.document).find('input[name="saveLayerPaginationPageSize"]').val(data.options.pageSize);
                        $(parent.window.document).find('input[name="saveLayerPaginationPage"]').val(data.options.page);
                        var totalPage = Math.ceil(parseInt(data.data.total) / parseInt(data.options.pageSize));
                        $(parent.window.document).find('.layer-page-wrap .page-total').html(totalPage).attr('data-total',data.options.total);
                        peSecondPagination(data.peGrid,totalPage);
                    }else if(data.options.pagination === 'secondPagin'){
                        PEBASE.peSelect($('.table-second-pagination-wrap .layer-page-drop-down'), null, $('input[name="saveLayerPaginationPageSize"]'),data.peGrid);
                        $('.table-second-pagination-wrap').find('input[name="saveLayerPaginationPageSize"]').val(data.options.pageSize);
                        $('.table-second-pagination-wrap').find('input[name="saveLayerPaginationPage"]').val(data.options.page);
                        var totalPage = Math.ceil(parseInt(data.data.total) / parseInt(data.options.pageSize));
                        $('.table-second-pagination-wrap').find('.layer-page-wrap .page-total').html(totalPage);
                        peSecondPagination(data.peGrid,totalPage);
                    }else if(!data.options.pagination){

                    }

                    PEBASE.peFormEvent('checkbox');
                    PEBASE.peFormEvent('radio');
                    data.options.onLoad.call({dom:data.peGrid,isTable:true},data);
                    var $thisPaginationDom = data.peGrid.siblings('.pe-stand-table-pagination').get(0)? data.peGrid.siblings('.pe-stand-table-pagination') : data.peGrid.parents('.pe-scrollTable-wrap').siblings('.pe-stand-table-pagination') ;
                    if(data.peGrid.siblings('.pe-stand-table-pagination').get(0) || data.peGrid.parents('.pe-scrollTable-wrap').siblings('.pe-stand-table-pagination').get(0)){
                        var standPagiWrap =$thisPaginationDom;
                        var paginationDown = standPagiWrap.find('.pagination-down');
                        var paginationUp = standPagiWrap.find('.pagination-up');
                    }else if(data.options.pagination === 'layer'){
                        var standPagiWrap = $(parent.window.document).find('.layer-page-wrap');
                        var paginationDown =  $(parent.window.document).find('.layer-page-wrap .pagination-down');
                        var paginationUp =  $(parent.window.document).find('.layer-page-wrap .pagination-up');
                        var layerPageSize = $(parent.window.document).find('input[name="saveLayerPaginationPageSize"]');
                        var layerPage = $(parent.window.document).find('input[name="saveLayerPaginationPage"]');
                    }else if(data.options.pagination === 'secondPagin'){
                        var standPagiWrap = $('.table-second-pagination-wrap').find('.layer-page-wrap');
                        var paginationDown =  $('.table-second-pagination-wrap').find('.layer-page-wrap .pagination-down');
                        var paginationUp =  $('.table-second-pagination-wrap').find('.layer-page-wrap .pagination-up');
                        var layerPageSize = $('.table-second-pagination-wrap').find('input[name="saveLayerPaginationPageSize"]');
                        var layerPage = $('.table-second-pagination-wrap').find('input[name="saveLayerPaginationPage"]');
                    }
                    if(standPagiWrap){
                        if(data.options.pageSize === 10){
                            paginationDown.addClass('disabled');
                            paginationUp.removeClass('disabled');
                        }else if(data.options.pageSize === 100){
                            paginationUp.addClass('disabled');
                            paginationDown.removeClass('disabled');
                        }else{
                            paginationUp.removeClass('disabled');
                            paginationDown.removeClass('disabled');
                        }
                        if(layerPageSize && layerPageSize.get(0) && layerPage && layerPage.get(0)){
                            layerPageSize.val(data.options.pageSize);
                            layerPage.val(data.options.page);
                        }
                    }

                }
            })
        }
    }

    //渲染表格数据共有多少组 数据(页)

    //渲染默认分页
    function peGridPanination(t, p) {
        var data = $.data(t, 'peGrid');
        $('.pe-stand-table-pagination').pagination({
            dataSource: data.options.url,
            showGoInput: true,
            pageSize: data.options.pageSize,
            pageNumber: data.options.page,
            showGoButton: true,
            totalNumber: data.data.total,
            locator: 'rows',
            triggerPagingOnInit: false,
            className: 'pe-stand-pagination',
            classPrefix: 'pePagination',
            hideWhenLessThanOnePage:false,
            prevText: '',
            nextText: '',
            alias: {
                pageNumber: 'page',
                data: data.options.formParam
            },
            goButtonText: 'GO',
            callback: function (d, pagination) {
                
                var totalPage = $('.pe-stand-table-pagination').pagination('getTotalPage');

                if (pagination.pageNumber === 1) {
                    $('.pe-stand-pagination .pePagination-go-first ').addClass('disabled');
                } else {
                    $('.pe-stand-pagination .pePagination-go-first ').removeClass('disabled');
                }
                if (pagination.pageNumber === totalPage) {
                    $('.pe-stand-pagination .pePagination-go-last ').addClass('disabled');
                } else {
                    $('.pe-stand-pagination .pePagination-go-last ').removeClass('disabled');
                }

                data.data.rows = d.rows;
                data.data.start = d.start;
                data.options.page = pagination.pageNumber;
                data.options.total = d.total;
                $(data.peGrid).html('');
                if(data.options.isTableHasFixed){
                    $('.pe-stand-table-main-panel').find('table').remove();
                }
                $(data.peGrid).append(_.template($('#' + data.options.tempId).html())({peData: data.data,compareData:data.options.compareData}));
                if($.isArray(data.options.fixedTableTempId)){
                    $.each(data.options.fixedTableTempId,function(i,v){
                        $('.pe-stand-table-main-panel').append(_.template($('#'+ v).html())({peData: data.data,compareData:data.options.compareData}));
                    });
                }
                PEBASE.peFormEvent('checkbox');
                PEBASE.peFormEvent('radio');
                if (data.options.showTotalDomId) {
                    $('#'+data.options.showTotalDomId).html(data.options.total);
                }
                PEBASE.peSelect($('.pe-stand-table-pagination-pageSize'), null, $('input[name="savePaginationPageSize"]'),data.peGrid);
                var standPagiWrap = data.peGrid.siblings('.pe-stand-table-pagination');
                if(standPagiWrap.get(0)){
                    if(data.options.pageSize === 10){
                        standPagiWrap.find('.pagination-down').addClass('disabled');
                        standPagiWrap.find('.pagination-up').removeClass('disabled');
                        PEBASE.pagiArrowClick({domData:data.options,isTable:true});
                    }else if(data.options.pageSize === 100){
                        standPagiWrap.find('.pagination-up').addClass('disabled');
                        standPagiWrap.find('.pagination-down').removeClass('disabled');
                        PEBASE.pagiArrowClick({domData:data.options,isTable:true});
                    }else{
                        standPagiWrap.find('.pagination-up').removeClass('disabled');
                        standPagiWrap.find('.pagination-down').removeClass('disabled');
                        PEBASE.pagiArrowClick({domData:data.options,isTable:true});
                    }
                }
                if($('.pe-scrollTable-wrap').hasClass('mCustomScrollbar')){
                    $('.pe-scrollTable-wrap').mCustomScrollbar('update');
                }
            },
            afterInit: function (t,p) {
                $('input[name="tablePageSize"]').val(data.options.pageSize);
                
                if (data.options.showTotalDomId) {
                    $('#'+data.options.showTotalDomId).html(data.data.total);
                }
                var standTable = $('.pe-stand-table-pagination');
                if($('.paginationjs-pages').find('.pePagination-page').length === 1 && data.data.total > 10){
                    $('.pePagination-go-last').addClass('disabled');
                }else if($('.paginationjs-pages').find('.pePagination-page').length === 0 || data.data.total <= 10){
                    $('.pe-stand-table-pagination').hide();
                }else{
                    $('.pe-stand-table-pagination').show();
                }
                if($('.paginationjs-pages').find('.pePagination-page').length === 0){

                }

                standTable.delegate('.pePagination-go-first', 'click', function () {
                    if(!$(this).hasClass('disabled')){
                        $('.pe-stand-table-pagination').pagination('go', 1);
                    }

                });
                standTable.delegate('.pePagination-go-last', 'click', function (t) {
                    if(!$(this).hasClass('disabled')) {
                        var thisTablePagi = $('.pe-stand-table-pagination');
                        if ('model' in thisTablePagi.data('pagination')) {
                            var totalPage = thisTablePagi.pagination('getTotalPage')
                        } else {
                            var totalPage = Math.ceil(parseInt(data.data.total) / parseInt(data.options.pageSize));
                        }

                        thisTablePagi.pagination('go', totalPage);
                    }
                })
            }
        });
    }

    //弹框里的第二种分页上一页，下一页的点击事件
    function peSecondPagination(tableDom,totalPage){
        var data = $.data($(tableDom).get(0), 'peGrid');
        if(data.options.pagination === 'secondPagin'){
            var layerPagniWrap = $('.table-second-pagination-wrap').find('.layer-page-wrap');
            var layerPageSize = $('.table-second-pagination-wrap').find('input[name="saveLayerPaginationPageSize"]');
            var layerPage = $('.table-second-pagination-wrap').find('input[name="saveLayerPaginationPage"]');
        }else if(data.options.pagination === 'layer'){
            var layerPagniWrap = $(parent.window.document).find('.layer-page-wrap');
            var layerPageSize = $(parent.window.document).find('input[name="saveLayerPaginationPageSize"]');
            var layerPage = $(parent.window.document).find('input[name="saveLayerPaginationPage"]');
        }

        layerPagniWrap.find('.page-go-input').val(data.options.page);
        if(totalPage === 1){
            layerPagniWrap.find('.page-right a').addClass('disabled');
            layerPagniWrap.find('.page-left a').addClass('disabled');
            layerPagniWrap.find('.page-go-input').attr('readonly',true);
        }
        if(totalPage === 0){
            layerPagniWrap.find('.page-right a').addClass('disabled');
            layerPagniWrap.find('.page-go-input').attr('readonly',true);
            layerPagniWrap.find('.page-go-input').val(0);
        }
        if(totalPage === parseInt(layerPagniWrap.find('.page-go-input').val())){
            layerPagniWrap.find('.page-right a').addClass('disabled');
        }
        if(totalPage !== 1 && totalPage !== 0 && (totalPage !== parseInt(layerPagniWrap.find('.page-go-input').val()))){
            layerPagniWrap.find('.page-right a').removeClass('disabled');
            layerPagniWrap.find('.page-go-input').removeAttr('readonly');
        }

        if(layerPagniWrap.get(0)){
            /*下一页*/
            layerPagniWrap.find('.page-right a').off().on('click',function(e){
                var e = e || window.event;
                    e.stopPropagation();
                if($(this).hasClass('disabled')){
                    return false;
                }
                var data = $.data($(tableDom).get(0), 'peGrid');
                if(data.options.page + 1=== totalPage){
                    $(this).addClass('disabled');
                }
                layerPagniWrap.find('.page-left a').removeClass('disabled');
                
                var nowPageSize = parseInt(layerPageSize.val(),10);
                var nowPage = parseInt(layerPage.val(),10);

                data.options.pageSize = nowPageSize;
                data.options.page = nowPage + 1;
                render($(tableDom).get(0));
            });
            /*上一页*/
            layerPagniWrap.find('.page-left a').off().on('click',function(e){
                var e = e || window.event;
                    e.stopPropagation();
                if($(this).hasClass('disabled')){
                    return false;
                }
                var data = $.data($(tableDom).get(0), 'peGrid');
                if(data.options.page === 2){
                    $(this).addClass('disabled');
                }
                layerPagniWrap.find('.page-right a').removeClass('disabled');
                var nowPageSize = parseInt(layerPageSize.val(),10);
                var nowPage = parseInt(layerPage.val(),10);
                data.options.pageSize = nowPageSize;
                data.options.page = nowPage - 1;
                render($(tableDom).get(0));
            });

            //layer里面的输入框"ENTER"按键跳转表格指定页面
            layerPagniWrap.delegate('.page-go-input','keyup',function(e){
                var e = e || window.event;
                e.stopPropagation();
                var eKeyCode = e.keyCode;
                var thisVal = parseInt(this.value,10);
                var data = $.data($(tableDom).get(0), 'peGrid');
                if ((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105) || eKeyCode === 8 || eKeyCode === 108 || eKeyCode === 46 || eKeyCode === 37 || eKeyCode === 39) {
                    if (parseInt(thisVal,10) > totalPage) {
                        this.value = totalPage;
                    }
                } else if(e.keyCode === 13 || e.keyCode === 108){
                    var nowPageSize = parseInt(layerPageSize.val(),10);
                    layerPage.val(thisVal);
                    data.options.pageSize = nowPageSize;
                    data.options.page = thisVal;
                    render($(tableDom).get(0));
                    if(data.options.page === 1){
                        layerPagniWrap.find('.page-left a').addClass('disabled');
                        layerPagniWrap.find('.page-right a').removeClass('disabled');
                    }else if(data.options.page === totalPage){
                        layerPagniWrap.find('.page-right a').addClass('disabled');
                        layerPagniWrap.find('.page-left a').removeClass('disabled');
                    }else{
                        layerPagniWrap.find('.page-left a').removeClass('disabled');
                        layerPagniWrap.find('.page-right a').removeClass('disabled');
                    }
                }

            });
            layerPagniWrap.delegate('.page-go-input','keydown',function(e){
                    var e = e || window.event;
                        e.stopPropagation();
                    var eKeyCode = e.keyCode;
                    var thisVal = this.value;
                    if (!((eKeyCode >= 48 && eKeyCode <= 57) || (eKeyCode >= 96 && eKeyCode <= 105) || eKeyCode === 8 || eKeyCode === 108 || eKeyCode === 46 || eKeyCode === 37 || eKeyCode === 39)) {
                        // this.value = thisVal;
                        return false;
                    }
            })

        }
    }

    //获取选择的行数,用于checkbox的表格
    function getSelectRows(t, p) {
        //p;为当前页面中checkbox选中状态的class名称,pe中表格中的checkbox的为peChecked
        var data = $.data(t, 'peGrid'),
         thisPeGrid = data.peGrid,
         thisCheckeds;
        if(data.options.isTableHasFixed){
            /*找到直接子table的里checkboxs，目前暂时先如此固定（表格固定的列是table-main-panel里的直接子元素）*/
            thisCheckeds = $('.pe-stand-table-main-panel > .checkbox-table.userMana-left-fixed-table').find('.'+ p);
        }else{
            thisCheckeds = thisPeGrid.find('.' + p);
        }
        var checksArryDataId = [];
        for (var i = 0, len = thisCheckeds.length; i < len; i++) {
            //此处需要的什么参数呢，目前把之前请求回来的数据按照顺序查找出来放在checkArryData里面
            var id = $(thisCheckeds[i]).parent().data('id');
            if (id && id.length === 32) {
                checksArryDataId.push(id);
            }
        }
        return checksArryDataId;
    }

    //获取当前页面所有的rows
    function getSelctAllRows(t,p) {
        var data = $.data(t, 'peGrid');
        var nowDataJson = data.data;
        if (nowDataJson) {
            return false;
        }
        var thisPeGrid = data.peGrid;
        var checksArryAllDataId = [];
        var allCheckboxs = thisPeGrid.find('.pe-checkbox').not('.pe-paper-all-check');
        for(var j=0,len=allCheckboxs.length;j<len;j++){
            checksArryAllDataId.push(allCheckboxs[j].attr('data-id'))
        }
        return allCheckboxs;
    }

    $.fn.peGrid = function (o, p,func) {
        
        if (typeof o == "string") {
            return $.fn.peGrid.methods[o](this, p,func);
        }
        o = o || {};
        return this.each(function () {
            var data = $.data(this, "peGrid");
            
            var option;
            if (data) {
                option = $.extend(data.options, o);
            } else {
                option = option = $.extend({}, $.fn.peGrid.defaults, o);
                data = $.data(this, "peGrid", {
                    options: option,
                    peGrid: _$(this),
                    isLoaded: false
                });
            }
            render(this);
        })
    };

    $.fn.peGrid.methods = {
        //编辑，修改，删除表格中的数据时调用;
        refresh: function (t) {

            return t.each(function () {
                var data = $.data(this,'peGrid');
                data.options.isReMathPage = true;
                render(this, true);
            });
        },
        //分页，切换显示页数等调用;
        load: function (t, p) {
            return t.each(function () {
                var data = $.data(this, 'peGrid');
                data.options.formParam = p;
                data.options.page = 1;
                render(this);
            });

        },
        getTotal: function (t) {
            var totalJson = 0;
            t.each(function () {
                var data = $.data(this, 'peGrid');
                totalJson = data.data.total;
            });

            return totalJson;
        },
        pagiSizeChangeLoad:function(t,p){
            return t.each(function(){
                var data = $.data(this, 'peGrid');
                data.options.pageSize = p;
                data.options.page = 1;
                render(this);
            })

        },
        layerPageChangeLoad:function(t,p){
            return t.each(function(){
                var data = $.data(this, 'peGrid');
                data.options.pageSize = p.pageSize;
                data.options.page = p.page;
                render(this);
            })

        },
        //选择表格中checkbox时调用;
        selectRows: function (t) {
            var selectRows ;
            t.each(function(){
                 var data = $.data(this, 'peGrid');
                selectRows = getSelectRows(this,'peChecked');
             });

            return selectRows;
        },
        userExtendTable:function(t,p,func){

            return t.each(function () {
                var data = $.data(this, 'peGrid');
                data.options.isUserExtend = p;
                data.options.onLoad = func;
                render(this);
            });
        }

    };
    $.fn.peGrid.defaults = {
        url: null,//请求地址，不带参数的
        formParam: null,//表格上部分的form参数
        showTotalDomId: 'showTotal',
        domTableWrap: '',//表格table最近的外层包裹dom元素,jquery对象:'',
        isLoading: false,
        isReMathPage: null,
        page: 1,
        pageSize: 10,
        hover: false,
        title: {},
        pagination:'default',
        compareData:'',
        tempId: '',//表格模板的id
        onLoad: function () {
        }
    }
})(jQuery);