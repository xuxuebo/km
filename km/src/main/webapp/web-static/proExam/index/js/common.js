var YUN = {
    //退出
    loginOut: function () {
        PEMO.DIALOG.confirmL({
            content: '您确定退出吗？',
            area: ['350px', '173px'],
            title: '提示',
            btn: ['取消', '确定'],
            btnAlign: 'c',
            skin: ' pe-layer-confirm pe-layer-has-tree login-out-dialog-layer',
            btn1: function () {
                layer.closeAll();
            },
            btn2: function () {
                location.href = pageContext.rootPath + '/km/client/logout';
            },
            success: function () {
                PEBASE.peFormEvent('checkbox');
            }
        });
    },
    //转换单位
    conver: function (limit) {
        var size = "";
        if (limit < 0.1 * 1024) { //如果小于0.1KB转化成B
            size = limit.toFixed(2) + "B";
        } else if (limit < 0.1 * 1024 * 1024) {//如果小于0.1MB转化成KB
            size = (limit / 1024).toFixed(2) + "KB";
        } else if (limit < 0.1 * 1024 * 1024 * 1024) { //如果小于0.1GB转化成MB
            size = (limit / (1024 * 1024)).toFixed(2) + "MB";
        } else { //其他转化成GB
            size = (limit / (1024 * 1024 * 1024)).toFixed(2) + "GB";
        }

        var sizestr = size + "";
        var len = sizestr.indexOf("\.");
        var dec = sizestr.substr(len + 1, 2);
        if (dec == "00") {//当小数点后为00时 去掉小数部分
            return sizestr.substring(0, len) + sizestr.substr(len + 3, 2);
        }
        return sizestr;
    }
};