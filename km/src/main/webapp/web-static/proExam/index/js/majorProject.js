// $(function () {
//     //初始化菜单
//     initTree();
//     function initTree(){
//         var $yContainer = $('.y-content');
//         var settingInputTree = {
//             isOpen: true,
//             dataUrl: pageContext.rootPath + '/km/library/listLibrary?type=PROJECT_LIBRARY',
//             clickNode: function (treeNode) {
//                 orgTreeId = treeNode.id;
//                 // 切换节点
//                 $yContainer.load('/km/front/projectDetail?libraryId='+orgTreeId);
//             },
//             treePosition: 'inputDropDown'
//         };
//         PEMO.ZTREE.initTree('majorProjectTree', settingInputTree);
//         // 初始化时默认选中第一个节点
//         setTimeout(function() {
//             var zTree= $.fn.zTree.getZTreeObj("majorProjectTree");
//             var nodes = zTree.getNodes();
//             zTree.selectNode(nodes[0], true, true);
//             $yContainer.load('/km/front/projectDetail?libraryId='+nodes[0].id);
//         }, 500);
//     }
// })
//

$(function () {
    var data=[{
        "id": "4028810a64eb83bb0164ee09b9f20030",
        "pId": "4028810a64eb83bb0164ee0939bf002d",
        "name": "员工一",
        "canEdit": true,
        "type": "ORG",
        "ishasSelected": false,
        "isParent": true
    }, {
        "id": "4028810a64eb83bb0164ee0939bf002d",
        "pId": "4028810a64eb83bb0164ee08eb0a002c",
        "name": "人才输入中心",
        "canEdit": true,
        "type": "ORG",
        "ishasSelected": false,
        "isParent": true
    }, {
        "id": "4028810a64eb83bb0164ee08eb0a002c",
        "pId": "0164efd8541247bfbc00920123456789",
        "name": "人力资源部",
        "canEdit": true,
        "type": "ORG",
        "ishasSelected": false,
        "isParent": true
    }, {
        "id": "0164efd8541247bfbc00920123456789",
        "name": "测试公司",
        "canEdit": false,
        "type": "ORG",
        "ishasSelected": false,
        "isParent": true
    }, {
        "id": "4028810a64eb83bb0164ee09e0060031",
        "pId": "4028810a64eb83bb0164ee0939bf002d",
        "name": "员工二",
        "canEdit": true,
        "type": "ORG",
        "ishasSelected": false,
        "isParent": true
    }, {
        "id": "4028810a64eb83bb0164ee096d2b002e",
        "pId": "4028810a64eb83bb0164ee08eb0a002c",
        "name": "张主任",
        "canEdit": true,
        "type": "ORG",
        "ishasSelected": false,
        "isParent": true
    }, {
        "id": "4028810a64eb83bb0164ee0a06470032",
        "pId": "4028810a64eb83bb0164ee0939bf002d",
        "name": "员工三",
        "canEdit": true,
        "type": "ORG",
        "ishasSelected": false,
        "isParent": true
    }, {
        "id": "4028810a64eb83bb0164ee098c51002f",
        "pId": "4028810a64eb83bb0164ee08eb0a002c",
        "name": "李主任",
        "canEdit": true,
        "type": "ORG",
        "ishasSelected": false,
        "isParent": true
    }];
    var tree=$('.y-user-tree');
    tree.append(_.template($("#tplYunManageList").html())({data: data}));
    var user=$(".y-user");
    var h=user.height()+23;
    user.height(h);
    $(".y-menu-item-title").eq(0).addClass("y-menu-item-title-active");
    tree.delegate(".y-menu-item-title","click",function(){
        $(this).addClass("y-menu-item-title-active").siblings().removeClass("y-menu-item-title-active");
    });
    var $yContainer = $('.y-content');
    $yContainer.load('/km/front/projectDetail?libraryId='+1);
})
function selectProjectDetail() {
    var $yContainer = $('.y-content');
    $yContainer.load('/km/front/projectDetail?libraryId='+1);
}
