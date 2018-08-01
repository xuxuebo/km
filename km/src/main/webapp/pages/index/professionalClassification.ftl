<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>专业分类</title>

    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/layer.css">
    <link rel="stylesheet"
          href="${resourcePath!}/web-static/proExam/css/pro_exam_plugin_min.css?_v=${(resourceVersion)!}"
          type="text/css">
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pro_exam_base.css?_v=${(resourceVersion)!}"
          type="text/css"/>
    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/css/pe-common.css?_v=${(resourceVersion)!}"
          type="text/css">

    <link rel="stylesheet" href="${resourcePath!}/web-static/proExam/index/css/index.css">
    <script>
        var pageContext = {
            resourcePath: '${resourcePath!}',
            rootPath: '${ctx!}'
        };
    </script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/jquery.min.js"></script>
<#--<script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/webuploader.js"></script>-->
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/underscore-min.js"></script>
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/layer/layer.js?_v=${(resourceVersion)!}"></script>
<#--<script src="${resourcePath!}/web-static/proExam/index/js/upload.js" type="text/javascript" charset="utf-8"></script>-->
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.core.js?_v=0.1"></script>
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.excheck.js?_v=0.1"></script>
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/jquery.ztree.exedit.js?_v=0.1"></script>
    <script type="text/javascript"
            src="${resourcePath!}/web-static/proExam/js/plugins/jquery.mCustomScrollbar.concat.min.js?_v=0.1"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/pro_exam_base.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/js/echarts-4.1.js"></script>
    <script type="text/javascript" src="${resourcePath!}/web-static/proExam/index/js/require.js"></script>
    <style type="text/css">
        .y-content__opt__bar .webuploader-container .webuploader-pick {
            background-color: transparent
        }
        .y-content-professional{
            padding: 16px 14px;
            width: 100%;
            box-sizing: border-box;
        }
        .y-content-professional-file-box{
            width: 100%;
            height: 382px;
            box-sizing: border-box;
            position: relative;

        }
        .y-content-professional-file{
            height: 100%;
            box-sizing: border-box;
            margin-right:444px
        }
        .y-content-professional-file-list{
            padding:0 20px;
        }

        .y-content-professional-file-list-item{
            padding: 9px 0;
        }
        .y-content-professional-file-list-item::after{
            content: "";
            display: block;
            height: 0;
            clear: both;
        }
        .y-content-professional-file-list-item-title,.y-content-professional-file-list-item-name,.y-content-professional-file-list-item-time{
            font-size: 14px;
            color: #626262;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            line-height: 23px;
        }
        .y-content-professional-file-list-item-title,.y-content-professional-file-list-item-name{
            float: left;
        }
        .y-content-professional-file-list-item-title{
            width: 50%;
        }
        .y-content-professional-file-list-item-name{
            width: 25%;
        }
        .y-content-professional-file-list-item-time{
            float: right;
            width: 25%;
            text-align: right;
        }
        .y-content-professional-file-list-item-icon{
            display: inline-block;
            width: 20px;
            height: 23px;
            float: left;
            margin-right: 10px;
            background-repeat: no-repeat;
            background-position: center;
            background-image: url('../web-static/proExam/index/img/ico_docx.png');
            background-image: image-set(url('../web-static/proExam/index/img/ico_docx.png') 1x, url('../web-static/proExam/index/img/ico_docx@2x.png') 2x);
            background-image: -webkit-image-set(url('../web-static/proExam/index/img/ico_docx.png') 1x, url('../web-static/proExam/index/img/ico_docx@2x.png') 2x)
        }


        .y-content-professional-rank{
            position: absolute;
            width:430px;
            height: 100%;
            box-sizing: border-box;
            top: 0;
            right: 0;
        }
        .y-content-professional-rank-list{
            padding:10px 20px;
        }
        .y-content-professional-rank-list-item{
            padding: 10px 0;
        }
        .y-content-professional-rank-list-item::after{
            content: "";
            display: block;
            height: 0;
            clear: both;
        }
        .y-content-professional-rank-list-item-rank,.y-content-professional-rank-list-item-name,.y-content-professional-rank-list-item-department,.y-content-professional-rank-list-item-grade{
            float: left;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            line-height: 40px;
            height: 40px;
        }
        .y-content-professional-rank-list-item-rank{
            position: relative;
            margin-right: 45px;
        }
        .y-content-professional-rank-list-item:nth-child(1) .y-content-professional-rank-list-item-rank-pic{
            display: inline-block;
            width: 20px;
            height: 35px;
            margin-top: 2.5px;
            background-repeat: no-repeat;
            background-position: center;
            background-image: url('../web-static/proExam/index/img/ico_1.png');
            background-image: image-set(url('../web-static/proExam/index/img/ico_1.png') 1x, url('../web-static/proExam/index/img/ico_1@2x.png') 2x);
            background-image: -webkit-image-set(url('../web-static/proExam/index/img/ico_1.png') 1x, url('../web-static/proExam/index/img/ico_1@2x.png') 2x)
        }
        .y-content-professional-rank-list-item:nth-child(2) .y-content-professional-rank-list-item-rank-pic{
            display: inline-block;
            width: 20px;
            height: 35px;
            margin-top: 2.5px;
            background-repeat: no-repeat;
            background-position: center;
            background-image: url('../web-static/proExam/index/img/ico_2.png');
            background-image: image-set(url('../web-static/proExam/index/img/ico_2.png') 1x, url('../web-static/proExam/index/img/ico_2@2x.png') 2x);
            background-image: -webkit-image-set(url('../web-static/proExam/index/img/ico_2.png') 1x, url('../web-static/proExam/index/img/ico_2@2x.png') 2x)
        }
        .y-content-professional-rank-list-item:nth-child(3) .y-content-professional-rank-list-item-rank-pic{
            display: inline-block;
            width: 20px;
            height: 35px;
            margin-top: 2.5px;
            background-repeat: no-repeat;
            background-position: center;
            background-image: url('../web-static/proExam/index/img/ico_3.png');
            background-image: image-set(url('../web-static/proExam/index/img/ico_3.png') 1x, url('../web-static/proExam/index/img/ico_3@2x.png') 2x);
            background-image: -webkit-image-set(url('../web-static/proExam/index/img/ico_3.png') 1x, url('../web-static/proExam/index/img/ico_3@2x.png') 2x)
        }
        .y-content-professional-rank-list-item:nth-child(4) .y-content-professional-rank-list-item-rank-pic{
            display: inline-block;
            width: 20px;
            height: 35px;
            margin-top: 2.5px;
            background-repeat: no-repeat;
            background-position: center;
            background-image: url('../web-static/proExam/index/img/ico_4.png');
            background-image: image-set(url('../web-static/proExam/index/img/ico_4.png') 1x, url('../web-static/proExam/index/img/ico_4@2x.png') 2x);
            background-image: -webkit-image-set(url('../web-static/proExam/index/img/ico_4.png') 1x, url('../web-static/proExam/index/img/ico_4@2x.png') 2x)
        }
        .y-content-professional-rank-list-item:nth-child(5) .y-content-professional-rank-list-item-rank-pic{
            display: inline-block;
            width: 20px;
            height: 35px;
            margin-top: 2.5px;
            background-repeat: no-repeat;
            background-position: center;
            background-image: url('../web-static/proExam/index/img/ico_5.png');
            background-image: image-set(url('../web-static/proExam/index/img/ico_5.png') 1x, url('../web-static/proExam/index/img/ico_5@2x.png') 2x);
            background-image: -webkit-image-set(url('../web-static/proExam/index/img/ico_5.png') 1x, url('../web-static/proExam/index/img/ico_5@2x.png') 2x)
        }
        .y-content-professional-rank-list-item-name{
            position: relative;
            padding-left: 54px;
            width: 140px;
            box-sizing: border-box;
        }
        .y-content-professional-rank-list-item-name-avatar{
            position: absolute;
            top:0;
            left:0;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-repeat: no-repeat;
            background-position: center;
            background-image: url('../web-static/proExam/index/img/default_user.png');
        }
        .y-content-professional-rank-list-item-department{
            width: 100px;
            text-align: center;
        }
        .y-content-professional-rank-list-item-grade{
            width: 80px;
            float: right;
            text-align: right;
        }

        .y-content-professional-wrap{
            width: 100%;
            height: 50px;
            padding:0 20px;
            border-bottom: 1px solid #EBF0F4;
            box-sizing: border-box;
        }
        .y-content-professional-title{
            float: left;
            font-size: 16px;
            color: #2F2D3B;
        }
        .y-content-professional-more{
            float: right;
            font-size: 14px;
            color: #5C5C5C;
            cursor: pointer;
        }
        .y-content-professional-more,.y-content-professional-title{
           height: 100%;line-height: 50px
        }
        .y-content-professional-dynamic{
            width: 100%;
            box-sizing: border-box;
        }
        .y-body-professional{
            position: relative;
        }
        .y-content-professional-dynamic-list{
            padding:14px 20px;
        }
        .y-content-professional-dynamic-list::after{
            content: "";
            display: block;
            height: 0;
            clear: both;
        }
        .y-content-professional-dynamic-list-item{
            padding-bottom: 20px;
        }
        .y-content-professional-dynamic-list-item-doc{
            float: left;
            color: #5C5C5C;
            width: 80%;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .y-content-professional-dynamic-list-item-time{
            float: right;
            color: #5C5C5C;
            width: 20%;
            text-align: right;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        @media screen and (max-width: 1080px) {
            .y-content-professional-file-list-item-title{
                width: 35%;
            }
            .y-content-professional-file-list-item-name{
                width: 30%;
            }
            .y-content-professional-file-list-item-time{
                float: right;
                width: 35%;
                text-align: right;
            }
        }
    </style>
</head>
<body class="y-body y-body-professional">
<header class="y-head">
    <div class="y-logo__wrap">
        <a href="${ctx!}/km/front/index" class="y-logo"></a>
    </div>
    <div class="y-head__right">
        <form class="y-head__searcher" name="searchForm" action="javascript:void(0);">
            <label><input type="text" class="y-nav__search__input" placeholder="搜索文件"/></label>
            <button type="submit" class="y-nav__search__btn"><span class="yfont-icon">&#xe658;</span></button>
        </form>
        <div class="y-head__msg">
            <span class="yfont-icon">&#xe654;</span>
            <i class="has-msg"></i>
        </div>
        <div class="y-head__help">
            <span class="yfont-icon">&#xe64d;</span>
        </div>
        <div class="y-head__user" title="点击退出" onclick="loginOut();">
            <div class="y-head__avatar">
                <img src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
            </div>
            <div class="y-head__username">
            ${userName!}
            </div>
        </div>
    </div>
    <nav class="y-nav">
        <ul class="y-nav__link">
            <li><a href="${ctx!}/km/front/index" class="y-nav__link__item "><span class="txt">云库</span></a></li>
            <li><a href="${ctx!}/km/front/professionalClassification" class="y-nav__link__item active"><span
                    class="txt">专业分类</span></a></li>
        <#--<li><a href="${ctx!}/km/front/dataView" class="y-nav__link__item"><span class="txt">数据</span></a></li>-->
            <li><a href="${ctx!}/km/front/dataStatistics" class="y-nav__link__item"><span class="txt">数据统计</span></a>
            </li>
            <li><a href="${ctx!}/km/front/majorProject" class="y-nav__link__item"><span class="txt">重点项目</span></a></li>
        <#if admin?? && admin>
            <li><a href="${ctx!}/km/front/adminSetting" class="y-nav__link__item"><span class="txt">设置</span></a></li>
        </#if>

        </ul>
    </nav>
</header>
<section class="y-container">
    <aside class="y-aside y-aside-professional" id="YAside">
        <div class="y-aside__title">
            <span class="yfont-icon">&#xe650;</span><span class="txt">菜单</span>
        </div>
        <ul class="y-aside__menu">
            <li class="y-menu__item y-user">
                <a href="#user" class="y-menu__item__title y-aside__menu__item__title">
                    <span class="yfont-icon">&#xe643;</span><span class="txt">用户管理</span>
                </a>
            </li>
        </ul>
    </aside>
    <div class="y-content">
        <div class="y-content-body" id="yunContentBody">
            <h4 class="y-content__title">配电线路</h4>
            <div class="y-content-professional">
                <div class="y-content-professional-file-box">
                    <div class="y-content-professional-file">
                        <div class="y-content-professional-wrap">
                            <span class="y-content-professional-title">文件</span>
                            <span class="y-content-professional-more">查看更多</span>
                        </div>
                        <ul class="y-content-professional-file-list"></ul>
                    </div>
                    <div class="y-content-professional-rank">
                        <div class="y-content-professional-wrap">
                            <span class="y-content-professional-title">贡献榜单</span>
                        </div>
                        <ul class="y-content-professional-rank-list">
                            <li class="y-content-professional-rank-list-item">
                                <div class="y-content-professional-rank-list-item-rank"><i class="y-content-professional-rank-list-item-rank-pic"></i></div>
                                <div class="y-content-professional-rank-list-item-name"><i class="y-content-professional-rank-list-item-name-avatar"></i>夏雨</div>
                                <div class="y-content-professional-rank-list-item-department">人力资源部</div>
                                <div class="y-content-professional-rank-list-item-grade">500,00份</div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="y-content-professional-dynamic">
                    <div class="y-content-professional-wrap">
                        <span class="y-content-professional-title">动态</span>
                        <span class="y-content-professional-more">查看更多</span>
                    </div>
                    <ul class="y-content-professional-dynamic-list">
                        <li class="y-content-professional-dynamic-list-item">
                            <div class="y-content-professional-dynamic-list-item-doc">刘云上传了《中国人力资源产业园区发展现状及投资策略建议报告》</div>
                            <div class="y-content-professional-dynamic-list-item-time">2018/05/04</div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <footer class="y-footer footer-bar">
            国家电网江苏省电力公司 ©苏ICP备15007035号-1
        </footer>
    </div>
</section>
<script type="text/template" id="tplYunFileList">
    <% for(var i=0;i< 8;i++) {%>
        <li class="y-content-professional-file-list-item">
            <div class="y-content-professional-file-list-item-title"><i class="y-content-professional-file-list-item-icon"></i>高温相变储热铝合金材料的研究现状及展望.docx</div>
            <div class="y-content-professional-file-list-item-name">高晓松阿萨德阿萨德</div>
            <div class="y-content-professional-file-list-item-time">2015/05/02</div>
        </li>
    <% }%>
</script>
<script type="text/template" id="tplYunRankList">
    <% for(var i=0;i< 5;i++) {%>
        <li class="y-content-professional-rank-list-item">
            <div class="y-content-professional-rank-list-item-rank"><i class="y-content-professional-rank-list-item-rank-pic"></i></div>
            <div class="y-content-professional-rank-list-item-name"><i class="y-content-professional-rank-list-item-name-avatar"></i>夏雨</div>
            <div class="y-content-professional-rank-list-item-department">人力资源部</div>
            <div class="y-content-professional-rank-list-item-grade">500,00份</div>

        </li>
    <% }%>
</script>
<script type="text/template" id="tplYunDynamicList">

</script>
</body>
</html>

<script type="application/javascript">
    $(function () {
        $(".y-content-professional-file-list").html(_.template($("#tplYunFileList").html()))
        $(".y-content-professional-rank-list").html(_.template($("#tplYunRankList").html()))
    })
</script>
<script src="${resourcePath!}/web-static/proExam/index/js/index.js"></script>