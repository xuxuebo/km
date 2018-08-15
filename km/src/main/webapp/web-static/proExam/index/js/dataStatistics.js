$(function () {
    //文件数量
    $.ajax({
        url: pageContext.resourcePath + "/statistic/fileCount",
        dataType: 'json',
        success: function (result) {
            if (result) {
                $(".s-data-account").html(result.totalCount);
                $(".s-file-upload-account").html(result.dayCount);
            }
        }
    });

    //个人排行
    $.ajax({
        url: pageContext.resourcePath + "/statistic/rank",
        dataType: 'json',
        success: function (result) {
            $("#rankUL").html(_.template($("#rank").html())({list: result}));
        }
    });

    //中心排行
    $.ajax({
        url: pageContext.resourcePath + "/statistic/orgStatistic",
        dataType: 'json',
        success: function (result) {
            var names = result.names;
            var counts = result.counts;
            names = names ? names : [];
            counts = counts ? counts : [];

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
                        data: names,
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
                        data: counts
                    }
                ]
            };
            myChart.setOption(option);
        }
    });


    //环形图
    var myPieChart = echarts.init(document.getElementById('s-echarts-pie'));
    $.ajax({
        url: pageContext.resourcePath + "/statistic/libraryRank?type=PROJECT_LIBRARY",
        dataType: 'json',
        success: function (result) {
            var data = result.valuePairs, total = 0;
            for (var i = 0; i < data.length; i++) {
                total += parseInt(data[i].value);
            }
            // 圆环图各环节的颜色
            var color = ['#F03869', '#446EB6', '#F3CE30', '#F44336', '#8BC34A', '#F3F3F3'];
            var pieOption = {
                tooltip: {
                    formatter: "{b} <br/>{c}份 ({d}%)"
                },
                legend: {
                    //icon: 'circle',//设置图标现状
                    y: 'bottom',//设置图标在底部
                    left: 'center',
                    top: '90%',
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
                        text: total + '\n份文件',
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
                        label: {                        // 饼图图形上的文本标签，可用于说明图形的一些数据信息，比如值，名称等.
                            normal: {
                                show: true,             // 是否显示标签[ default: false ]
                                position: 'outside',    // 标签的位置。'outside'饼图扇区外侧，通过视觉引导线连到相应的扇区。'inside','inner' 同 'inside',饼图扇区内部。'center'在饼图中心位置。
                                formatter: function (params) {
                                    return '{color' + params.data.key + '| ' + params.data.value + '份}'
                                },
                                borderWidth: 1,
                                borderRadius: 4,
                                rich: {},
                                labelLine: {
                                    show: true
                                }
                            }
                        },
                        data: data
                    }
                ]
            };
            myPieChart.setOption(pieOption);
        }
    });

    //专业排行
    $.ajax({
        url: pageContext.resourcePath + "/statistic/libraryRank?type=SPECIALTY_LIBRARY",
        dataType: 'json',
        success: function (result) {
            result = result.valuePairs;
            var color = ['#588EE9', '#45FBC8', '#F3CE30', '#F03869', '#446EB6', '#725CA4 '];
            var res = '', max;
            for (var i = 0; i < result.length; i++) {
                if (i == 0) {
                    max = parseInt(result[i].value);
                }

                result[i].width = parseInt(parseInt(result[i].value) / max * 100);
                var colorRed = color[i];
                res += '<li>';
                res += '<span class="s-special-info">' + result[i].name + '</span>';
                res += '<div class="s-progress ' + colorRed + '">';
                res += '<div class="s-progress-inline s-progress-active" style="width: ' + result[i].width + '%">';
                res += '<div class="s-progress-value">' + result[i].value + '份<span class="s-progress-value-icon"></span></div>';
                res += '</div></div></li>';
            }
            $("#s-progress").html(res);
            var progress = document.getElementsByClassName('s-progress-inline');
            var progressValue = document.getElementsByClassName("s-progress-value");
            var progressIcon = document.getElementsByClassName("s-progress-value-icon");
            for (var i = 0; i < progress.length; i++) {
                progress[i].style.backgroundColor = color[i];
                progressValue[i].style.left = result[i].width + "%";
                progressValue[i].style.backgroundColor = color[i];
                progressIcon[i].style.borderTopColor = color[i];
            }
        }
    });
});