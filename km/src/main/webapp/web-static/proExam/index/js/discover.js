$(function () {
    var $hotTagContainer = $('#hotTagContainer'),
        $tplHotTagContainer = $('#tplHotTagContainer'),
        $hotResource = $('#hotResource'),
        $tplHotResourceContainer = $('#tplHotResourceContainer'),
        $ctrPerson = $('#ctrPerson'),
        $ctrPersonNav = $('#ctrPersonNav'),
        $tplCtrPerson = $('#tplCtrPerson'),
        $departmentRank = $('#departmentRank'),
        $tplDepartmentRank = $('#tplDepartmentRank'),
        $dSearchNpt = $('#dSearchNpt'),
        $dSearchGlobal = $('#dSearchGlobal'),
        $dSearchPersonal = $('#dSearchPersonal'),
        $dSearchFileNum = $('#dSearchFileNum'),
        $dSearchUploadNum = $('#dSearchUploadNum'),
        $dCloudList = $('#dCloudList'),
        $tplCloudList = $('#tplCloudList');

    // 渲染文件数量-已上传数量
    $dSearchFileNum.text(999);
    $dSearchUploadNum.text(666);

    // 渲染热门标签
    function renderHotTag(obj) {
        var html = _.template($tplHotTagContainer.html())({
            d: obj
        });
        $hotTagContainer.html(html);
    }
    // 热门标签示例数据 todo 示例数据联调时删除
    var hotTagData = {
        hotProject: [
            {
                link: 'http://www.baidu.com',
                name: '会议资料'
            }, {
                link: 'http://www.baidu.com',
                name: '学术报告'
            }, {
                link: 'http://www.baidu.com',
                name: '学术论文'
            }, {
                link: 'http://www.baidu.com',
                name: '项目资料'
            }
        ],
        hotMajor: [
            {
                link: 'http://www.baidu.com',
                name: '财务资产'
            }, {
                link: 'http://www.baidu.com',
                name: '人力资源'
            }, {
                link: 'http://www.baidu.com',
                name: '规划建设'
            }, {
                link: 'http://www.baidu.com',
                name: '工程建设'
            }
        ],
        hotTag: [
            {
                link: 'http://www.baidu.com',
                name: '学术交流'
            }, {
                link: 'http://www.baidu.com',
                name: '党团工作'
            }, {
                link: 'http://www.baidu.com',
                name: '故障分析'
            }
        ]
    };
    renderHotTag(hotTagData);

    // 渲染热门资源
    function renderHotResource(list) {
        var html = _.template($tplHotResourceContainer.html())({
            list: list
        });
        $hotResource.html(html);
    }
    // 热门资源示例数据
    var hotResourceData = [
        {
            link: 'http://www.baidu.com',
            name: '《2018年第一季度总结大会会议纪要》'
        }, {
            link: 'http://www.baidu.com',
            name: '《2018年第一季度总结大会会议纪要》'
        }, {
            link: 'http://www.baidu.com',
            name: '《2018年第一季度总结大会会议纪要》'
        }, {
            link: 'http://www.baidu.com',
            name: '《2018年第一季度总结大会会议纪要》'
        }, {
            link: 'http://www.baidu.com',
            name: '《2018年第一季度总结大会会议纪要》'
        }
    ];
    renderHotResource(hotResourceData);

    // 渲染贡献达人
    function renderCtrPerson(list) {
        var html = _.template($tplCtrPerson.html())({
            list: list
        });
        $ctrPerson.html(html);
    }
    var ctrPersonData = [
        {
            imgUrl: 'http://img.hb.aicdn.com/6b924d41912d0a5dcb881675c1ef9d47532cc5643f7ec-eB3ORE_fw658',
            score: 5000,
            name: '北落师门'
        }, {
            imgUrl: 'http://img.hb.aicdn.com/6b924d41912d0a5dcb881675c1ef9d47532cc5643f7ec-eB3ORE_fw658',
            score: 5000,
            name: '北落师门'
        }, {
            imgUrl: 'http://img.hb.aicdn.com/6b924d41912d0a5dcb881675c1ef9d47532cc5643f7ec-eB3ORE_fw658',
            score: 5000,
            name: '北落师门'
        }, {
            imgUrl: 'http://img.hb.aicdn.com/6b924d41912d0a5dcb881675c1ef9d47532cc5643f7ec-eB3ORE_fw658',
            score: 5000,
            name: '北落师门'
        }, {
            imgUrl: 'http://img.hb.aicdn.com/6b924d41912d0a5dcb881675c1ef9d47532cc5643f7ec-eB3ORE_fw658',
            score: 5000,
            name: '北落师门'
        }
    ];
    renderCtrPerson(ctrPersonData);

    // 渲染达人类别点击事件
    $ctrPersonNav.delegate('.d-ctr__nav', 'click', function() {
        var $this = $(this),
            type = $this.attr('data-type');
        $this.addClass('active').siblings().removeClass('active');
        // todo 获取数据
        console.log(type);
        renderCtrPerson(ctrPersonData);
    });

    // 渲染部门排行
    function renderDepartmentRank(list) {
        var html = _.template($tplDepartmentRank.html())({
            list: list
        });
        $departmentRank.html(html);
    }
    var departmentRankData = [
        {
            score: 5000,
            name: '北落师门'
        }, {
            score: 5000,
            name: '北落师门'
        }, {
            score: 5000,
            name: '北落师门'
        }, {
            score: 5000,
            name: '北落师门'
        }, {
            score: 5000,
            name: '北落师门'
        }
    ];
    renderDepartmentRank(departmentRankData);

    // 全局搜索点击事件
    $dSearchGlobal.click(function() {
        var val = $.trim($dSearchNpt.val());
        if(!val) {
            return;
        }
        console.log(val);
        // todo 全局跳转
    });

    // 个人云库搜索点击事件
    $dSearchPersonal.click(function() {
        var val = $.trim($dSearchNpt.val());
        if(!val) {
            return;
        }
        console.log(val);
        // todo 个人云库搜索跳转
    });

    // 渲染云库动态
    function renderCloudList(list) {
        var html = _.template($tplCloudList.html())({
            list: list
        });
        $dCloudList.html(html);
    }
    var cloudList = [
        {
            date: '2018/08/15',
            name: '周凯上传了《喜迎党的十九大知识竞赛题库》'
        }, {
            date: '2018/08/15',
            name: '周凯上传了《喜迎党的十九大知识竞赛题库》'
        }, {
            date: '2018/08/15',
            name: '周凯上传了《喜迎党的十九大知识竞赛题库》'
        }, {
            date: '2018/08/15',
            name: '周凯上传了《喜迎党的十九大知识竞赛题库》'
        }, {
            date: '2018/08/15',
            name: '周凯上传了《喜迎党的十九大知识竞赛题库》'
        }
    ];
    renderCloudList(cloudList);
});