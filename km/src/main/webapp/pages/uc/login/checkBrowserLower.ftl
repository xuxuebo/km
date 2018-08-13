<#assign ctx=request.contextPath/>
<!doctype html>
<html lang="zn-CH">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>智慧云</title>
    <script type="text/javascript" src="/km/web-static/proExam/js/plugins/jquery-1.9.1.min.js?_v="></script>
    <script type="text/javascript" src="/km/web-static/proExam/js/environment_check.js?_v="></script>
    <script type="text/javascript">
        var ieBrowserReg = /IE_\d/ig;
        var firBrowserReg = /FIREFOX_\d/ig;
        var chromeBrowserReg = /CHROME_\d/ig;
        if (EnCheck.browserName && EnCheck.browserNum) {
            if (ieBrowserReg.test(EnCheck.browserName)) {
                if (EnCheck.browserNum < 9) {
                    location.href = '/km/login/initBrowseLower';
                }
            } else if (firBrowserReg.test(EnCheck.browserName)) {
                if (EnCheck.browserNum < 30) {
                    location.href = '/km/login/initBrowseLower';
                }
            } else if (chromeBrowserReg.test(EnCheck.browserName)) {
                if (EnCheck.browserNum < 35) {
                    location.href = '/km/login/initBrowseLower';
                }
            }
        }
        location.href = '/km/front/index';
    </script>
</head>
<body>
</body>
</html>