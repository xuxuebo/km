<aside class="y-aside" id="YAside">
    <div class="y-aside__title">
        <span class="yfont-icon">&#xe650;</span><span class="txt">菜单</span>
    </div>
    <ul class="y-aside__menu">
        <li class="y-menu__item my-yun">
            <a href="#yun" class="y-menu__item__title y-aside__menu__item__title">
                <span class="yfont-icon">&#xe643;</span><span class="txt">我的云库</span>
            </a>
        </li>
        <li class="y-menu__item recycle-yun">
            <a href="#yunRecycle" class="y-menu__item__title y-aside__menu__item__title">
                <span class="yfont-icon">&#xe65c;</span><span class="txt">回收站</span>
            </a>
        </li>
    </ul>
</aside>
    <section class="y-content">
        <div class="y-content-body" id="yunLContentBody">

        </div>
    </section>
<script type="text/template" id="tplYunTable">
    <table class="y-table">
        <thead class="y-table__header">
        <tr>
            <th class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </th>
            <th class="y-table__td name">
                <span class="">名称</span>
            </th>
            <th class="y-table__td size">
                <span class="">大小</span>
            </th>
            <th class="y-table__td create-time">
                <span class="">上传时间</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <tr class="y-table__tr js-opt-dbclick" >
            <td class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </td>
            <td class="y-table__td name">
                <div class="y-table__opt__bar">
                    <button type="button" title="点击下载"
                            class="yfont-icon opt-item js-opt-download">&#xe64f;
                    </button>
                    <button type="button" title="分享"  class="yfont-icon opt-item js-opt-share">
                        &#xe652;
                    </button>
                    <button type="button" title="删除" class="yfont-icon opt-item js-opt-delete">
                        &#xe65c;
                    </button>
                </div>
                <div class="y-table__filed_name">
                   人才管理
                </div>
            </td>
            <td class="y-table__td size">
               3M
            </td>
            <td class="y-table__td upload-time">
                2018-08-02
            </td>
        </tr>
        </tbody>
    </table>
    <#--<div class="table__none">--暂无数据--</div>-->
</script>

<#--模板引擎-->

<#--我的云库-->
<script type="text/template" id="tplYun">
    <h4 class="y-content__title">我的云库</h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__green js-download" type="button">下载</button>
        <div id="theList"></div>
    </div>
    <#--表格包裹的div-->
    <ul class="y-bread-crumbs" id="breadCrumbs">
        <li>全部</li>
    </ul>
    <div class="pe-stand-table-main-panel">
        <div class="y-content__table" id="yunTable">
            <div class="pe-stand-table-pagination"></div>
        </div>
    </div>
</script>

<#--回收站-->
<script type="text/template" id="tplRecycle">
    <h4 class="y-content__title">回收站</h4>
    <div class="y-content__opt__bar">
        <button class="y-btn y-btn__blue js-reduction" type="button">还原文件</button>
        <button class="y-btn y-btn__green js-emptyRecycle" type="button">清空回收站</button>
    </div>
    <div class="y-content__table" id="recycleTable">
    </div>
</script>
<script type="text/template" id="tplRecycleTable">
    <table class="y-table">
        <thead class="y-table__header">
        <tr>
            <th class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </th>
            <th class="y-table__td name">
                <span class="">文件名</span>
            </th>
            <th class="y-table__td size">
                <span class="">大小</span>
            </th>
            <th class="y-table__td create-time">
                <span class="">删除时间</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <tr class="y-table__tr" >
            <td class="y-table__td checkbox">
                <label class="y-checkbox">
                    <input type="checkbox">
                    <span class="y-checkbox__span"></span>
                </label>
            </td>
            <td class="y-table__td name">
                <div class="y-table__opt__bar">
                </div>
                <div class="y-table__filed_name">
                   大型优惠活动
                </div>
            </td>
            <td class="y-table__td size">
               2kb
            </td>
            <td class="y-table__td upload-time">
               2018-08-23
            </td>
        </tr>
        </tbody>
    </table>

    <#--<div class="table__none">--暂无数据--</div>-->

</script>
<script type="text/template" id="reduction">
    <div class="clearF">
        <div class="validate-form-cell" style="margin-left:80px;">
            <em class="error" style="display: none;"></em>
        </div>
        <label class="floatL">
            <span class="pe-label-name floatL">确定还原选中的文件?</span>
        </label>
    </div>
</script>

<script type="text/template" id="emptyRecycle">
    <div class="clearF">
        <div class="validate-form-cell" style="margin-left:80px;">
            <em class="error" style="display: none;"></em>
        </div>
        <label class="floatL">
            <span class="pe-label-name floatL">确定清空回收站?</span>
        </label>
    </div>
</script>

<script src="${resourcePath!}/web-static/proExam/index/js/publicLibrary.js"></script>
