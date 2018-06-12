package com.qgutech.pe.module.im.service;

import com.qgutech.pe.module.uc.model.User;
import com.qgutech.pe.module.uc.service.UserRedisService;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.Map;

/**
 * 消息统一管理接口实现类
 *
 * @author LiYanCheng@HF
 * @since 2016年12月10日15:20:17
 */
@Service("smsService")
public class SmsServiceImpl implements SmsService {

    private final Log LOG = LogFactory.getLog(getClass());

    @Resource
    private UserRedisService userRedisService;

    @Override
    public void sendSmsMsg(String templateName, String userId, Map<String, Object> paramData, boolean isQuick) {
        if (StringUtils.isBlank(userId) || StringUtils.isBlank(templateName)) {
            LOG.error("UserId or templateName is blank!");
            return;
        }

        User user = userRedisService.get(userId, User._mobile);
        if (user == null || StringUtils.isBlank(user.getMobile())) {
            LOG.error("User is not existed or user mobile is not existed!");
            return;
        }

        MsgSendService.sendSmsMsg(templateName, Collections.singletonList(user.getMobile()), paramData, isQuick);
    }

    @Override
    public void sendSmsMsg(String templateName, String userId, Map<String, Object> paramData) {
        sendSmsMsg(templateName, userId, paramData, true);
    }
}
