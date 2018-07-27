<!doctype html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>数据统计</title>

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
    </style>
</head>
<body class="y-body">
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
        <#--<li><a href="${ctx!}/km/front/dataView" class="y-nav__link__item"><span class="txt">数据</span></a></li>-->
            <li><a href="${ctx!}/km/front/dataStatistics" class="y-nav__link__item active"><span class="txt">数据统计</span></a>
            </li>
            <li><a href="${ctx!}/km/front/majorProject" class="y-nav__link__item"><span class="txt">重点项目</span></a></li>
        <#if admin?? && admin>
            <li><a href="${ctx!}/km/front/adminSetting" class="y-nav__link__item"><span class="txt">设置</span></a></li>
        </#if>

        </ul>
    </nav>
</header>
<section class="s-data-statistics">
    <div class="s-data-statistics-content">
        <div class="s-data-statistics-header">
            <div class="s-data-file-total">
                <div class="s-data-show">
                    <div class="s-data-file-info">文件数量</div>
                    <div class="s-data-account">568345</div>
                </div>
            </div>
            <div class="s-data-upload-file-total">
                <div class="s-file-upload">
                    <div class="s-file-upload-info">日上传数量</div>
                    <div class="s-file-upload-account">568345</div>
                </div>
            </div>
        </div>
        <div class="s-echarts">
            <div class="s-echarts-central-info">中心排行</div>
            <div class="s-echarts-up">
                <div class="s-echarts-central">
                    <div class="s-central-bar" id="s-echarts-bar" style="height: 403px;width: 492px;"></div>
                </div>
                <div class="s-echarts-special">
                    <div class="s-echarts-special-info">专业排行</div>
                    <ul id="s-progress">

                    </ul>
                </div>
            </div>
        </div>
        <div class="s-echarts-down">
            <div class="s-echarts-person">
                <div class="s-echarts-person-info">个人排行</div>
                <div class="s-person-picture">
                    <ul>
                        <li>
                            <div class="s-person-icon_first"></div>
                            <img class="s-person-img"
                                 src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
                            <span class="s-person-name">张恒恒</span>
                            <span class="s-person-number">50000份</span>
                        </li>
                        <li>
                            <div class="s-person-icon_second"></div>
                            <img class="s-person-img"
                                 src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
                            <span class="s-person-name">张恒恒</span>
                            <span class="s-person-number">50000份</span>
                        </li>
                        <li>
                            <div class="s-person-icon_third"></div>
                            <img class="s-person-img"
                                 src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
                            <span class="s-person-name">张恒恒</span>
                            <span class="s-person-number">50000份</span>
                        </li>
                        <li>
                            <span class="s-person-order-number">4</span>
                            <img class="s-person-img"
                                 src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
                            <span class="s-person-name">张恒恒</span>
                            <span class="s-person-number">50000份</span>
                        </li>
                        <li>
                            <span class="s-person-order-number">5</span>
                            <img class="s-person-img"
                                 src="${resourcePath!}/web-static/proExam/index/img/default_user.png" alt="">
                            <span class="s-person-name">张恒恒</span>
                            <span class="s-person-number">50000份</span>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="s-echarts-point">
                <div class="s-echarts-point-info">重点项目排行</div>
                <div class="s-echarts-point-pie" id="s-echarts-pie"></div>
            </div>
        </div>
    </div>
    <div class="s-data-statistics-background_icon"></div>
</section>


</body>
</html>

<script type="application/javascript">
    $(function () {
        //柱状图
        var myChart = echarts.init(document.getElementById('s-echarts-bar'));
        var option = {
            tooltip: {
                trigger: 'axis'
            },
            toolbox: {
                show: true,
                orient: 'vertical',
                y: 'center'
            },
            calculable: true,
            grid: {
                y: 80,
                y2: 40,
                x2: 10
            },
            xAxis: [
                {
                    type: 'category',
                    //max: 30,
                    barWidth: 30,
                    data: ['电网技术中心', '状态评价中心', '计量中心', '客服中心', '人力资源服务室'],
                    axisLabel: {
                        //X轴刻度配置
                        interval: 0,//0：表示全部显示不间隔；auto:表示自动根据刻度个数和宽度自动设置间隔个数
                        show: true,
                        textStyle: {
                            color: "#D9D9D9"
                        }
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    axisLabel: {
                        show: true,
                        textStyle: {
                            color: "#D9D9D9"
                        }
                    },
                    lineStyle: {
                        color: ['#FFFFFF'],
                        width: 1,
                        type: 'solid',
                        opacity: 0.1
                    }
                }
            ],
            series: [
                {
                    type: 'bar',
                    itemStyle: {
                        normal: {
                            color: function (params) {
                                // build a color map as your need.
                                var colorList = [
                                    '#446EB6', '#F03869', '#F3CE30', '#45FBC8', '#588EE9'
                                ];
                                return colorList[params.dataIndex]
                            }
                        }
                    },
                    barWidth: 30,//柱图宽度
                    barCategoryGap: 30,
                    data: [350, 156, 423, 289, 540]
                }
            ]
        };
        myChart.setOption(option);

        //环形图
        var myPieChart = echarts.init(document.getElementById('s-echarts-pie'));
        // 圆环图各环节的颜色
        var color = ['#F03869', '#446EB6', '#F3CE30'];
        var pieOption = {
            tooltip: {
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'horizontal',
                icon: 'circle',//设置图标现状
                itemWidth: 8,//设置图标大小
                itemHeight: 8,
                itemGap: 52,//设置图标间距
                y: 'bottom',//设置图标在底部
                left: 'center',
                top: '90%',
                data: ['直接访问', '邮件营销', '联盟广告'],
                textStyle: {//图例文字的样式
                    color: color,
                    fontSize: 12
                }
            },
            toolbox: {
                show: true,
                feature: {}
            },
            calculable: true,
            graphic: {
                type: 'text',
                left: 'center',
                top: '40%',
                style: {
                    text: '12455\n总文件',
                    fill: '#66698D',
                    fontSize: 36,
                    fontWeight: 'bold'
                }
            },
            series: [
                {
                    name: '访问来源',
                    type: 'pie',
                    radius: ['50%', '55%'],
                    color: color,
                    center: ['50%', '50%'],
                    itemStyle: {
                        normal: {
                            label: {
                                show: false
                            },
                            labelLine: {
                                show: true
                            }
                        }
                    },
                    label: {                        // 饼图图形上的文本标签，可用于说明图形的一些数据信息，比如值，名称等.
                        normal: {
                            show: true,             // 是否显示标签[ default: false ]
                            position: 'outside',    // 标签的位置。'outside'饼图扇区外侧，通过视觉引导线连到相应的扇区。'inside','inner' 同 'inside',饼图扇区内部。'center'在饼图中心位置。
                            formatter: function (params) {
                                return '{color' + params.data.key + '| ' + params.data.value + '件}'
                            },
                            borderWidth: 1,
                            borderRadius: 4,
                            rich: {
                                colora: {
                                    color: '#eee',
                                    backgroundColor: '#F03869',
                                    padding: [2, 2],
                                    borderRadius: 2,
                                    height: 15
                                },
                                colorb: {
                                    color: '#eee',
                                    backgroundColor: '#446EB6',
                                    padding: [2, 2],
                                    borderRadius: 2,
                                    height: 15
                                },
                                colorc: {
                                    color: '#eee',
                                    backgroundColor: '#F3CE30',
                                    padding: [2, 2],
                                    borderRadius: 2,
                                    height: 15
                                }
                            },
                            labelLine: {
                                show: true
                            }
                        }
                    },
                    data: [
                        {value: 5954950, name: '直接访问', key: 'a'},
                        {value: 2250956, name: '邮件营销', key: 'b'},
                        {value: 2356956, name: '联盟广告', key: 'c'}
                    ]
                }
            ]
        };
        myPieChart.setOption(pieOption);

        //专业排行
        var array = [0, 6500, 7800, 9000, 2700, 10000];
        var color = ['#588EE9', '#45FBC8', '#F3CE30', '#F03869', '#446EB6', '#725CA4 '];
        var res = '';
        for (var i = 0; i < array.length; i++) {
            var colorRed = color[i];
            res += '<li>';
            res += '<span class="s-special-info">断电保护</span>';
            res += '<div class="s-progress ' + colorRed + '">';
            res += '<div class="s-progress-inline s-progress-active" style="width: ' + array[i] / 100 + '%">';
            res += '<div class="s-progress-value">' + array[i] + '份<span class="s-progress-value-icon"></span></div>';
            res += '</div></div></li>';
        }
        $("#s-progress").html(res);
        var progress = document.getElementsByClassName('s-progress-inline');
        var progressValue = document.getElementsByClassName("s-progress-value");
        var progressIcon = document.getElementsByClassName("s-progress-value-icon");
        for (var i = 0; i < progress.length; i++) {
            progress[i].style.backgroundColor = color[i];
            progressValue[i].style.left = array[i] / 100 + "%";
            progressValue[i].style.backgroundColor = color[i];
            progressIcon[i].style.borderTopColor = color[i];
        }
    });

</script>
<script src="${resourcePath!}/web-static/proExam/index/js/index.js"></script>