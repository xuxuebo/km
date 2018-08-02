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
    var array = [0, 65, 78, 90, 27, 100];
    var color = ['#588EE9', '#45FBC8', '#F3CE30', '#F03869', '#446EB6', '#725CA4 '];
    var res = '';
    for (var i = 0; i < array.length; i++) {
        var colorRed = color[i];
        res += '<li>';
        res += '<span class="s-special-info">断电保护</span>';
        res += '<div class="s-progress ' + colorRed + '">';
        res += '<div class="s-progress-inline s-progress-active" style="width: ' + array[i] + '%">';
        res += '<div class="s-progress-value">' + array[i] + '份<span class="s-progress-value-icon"></span></div>';
        res += '</div></div></li>';
    }
    $("#s-progress").html(res);
    var progress = document.getElementsByClassName('s-progress-inline');
    var progressValue = document.getElementsByClassName("s-progress-value");
    var progressIcon = document.getElementsByClassName("s-progress-value-icon");
    for (var i = 0; i < progress.length; i++) {
        progress[i].style.backgroundColor = color[i];
        progressValue[i].style.left = array[i] + "%";
        progressValue[i].style.backgroundColor = color[i];
        progressIcon[i].style.borderTopColor = color[i];
    }
});