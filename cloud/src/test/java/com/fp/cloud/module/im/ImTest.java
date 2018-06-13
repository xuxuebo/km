package com.fp.cloud.module.im;

import com.fp.cloud.module.im.domain.ImReceiver;
import com.fp.cloud.module.im.domain.ImTemplate;
import com.fp.cloud.module.im.service.MsgSendService;
import org.junit.Test;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class ImTest {
    @Test
    public void test() {
        String emailOrPhoneNum = "15905517834";

        Map<String, Object> paramData = new HashMap<String, Object>(5);
        paramData.put("CONFIRM_CODE", "789034");
        paramData.put("ACCOUNT_NAME", "陶发登");
        paramData.put("TO_ACCOUNT_NUMBER", emailOrPhoneNum);
        String templateName = ImTemplate.REGISTER_CONFIRM_CODE;
//        MsgSendService.sendSmsMsg(templateName
//                , Collections.singletonList(emailOrPhoneNum), paramData, true);
        emailOrPhoneNum = "taofadeng@qgutech.com";
        MsgSendService.sendEmailMsg(templateName, "注册验证码"
                , Collections.singletonList(new ImReceiver(null, emailOrPhoneNum, emailOrPhoneNum)), paramData, true);
    }
}
