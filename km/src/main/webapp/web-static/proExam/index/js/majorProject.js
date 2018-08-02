$(function () {
    //初始化菜单
    initTree();
    function initTree(){
        var $yContainer = $('.y-content');
        var settingInputTree = {
            isOpen: true,
            dataUrl: pageContext.rootPath + '/km/library/listLibrary?type=PROJECT_LIBRARY',
            clickNode: function (treeNode) {
                orgTreeId = treeNode.id;
                // 切换节点
                $yContainer.load('/km/front/projectDetail?libraryId='+orgTreeId);
            },
            treePosition: 'inputDropDown'
        };
        PEMO.ZTREE.initTree('majorProjectTree', settingInputTree);
        // 初始化时默认选中第一个节点
        setTimeout(function() {
            var zTree= $.fn.zTree.getZTreeObj("majorProjectTree");
            var nodes = zTree.getNodes();
            zTree.selectNode(nodes[0], true, true);
            $yContainer.load('/km/front/projectDetail?libraryId='+nodes[0].id);
        }, 500);
    }
})

