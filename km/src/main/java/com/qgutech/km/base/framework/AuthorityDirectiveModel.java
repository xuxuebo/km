package com.qgutech.km.base.framework;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.service.SessionService;
import com.qgutech.km.constant.CookieKey;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.module.uc.model.SessionContext;
import com.qgutech.km.utils.CookieUtil;
import com.qgutech.km.utils.PeException;
import freemarker.core.Environment;
import freemarker.template.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import java.io.IOException;
import java.util.Map;

/**
 * 权限自定义标签
 *
 * @author LiYanCheng@HF
 * @since 2016年11月19日17:54:39
 */
@Component
public class AuthorityDirectiveModel implements TemplateDirectiveModel {

    protected final Log LOG = LogFactory.getLog(getClass());
    @Resource
    private SessionService sessionService;

    @Override
    public void execute(Environment env, Map params, TemplateModel[] loopVars,
                        TemplateDirectiveBody body) throws TemplateException, IOException {
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        Cookie cookie = CookieUtil.getCookie(attributes.getRequest(), CookieKey.UC_LOGIN_SESSION_ID);
        if (cookie == null || StringUtils.isBlank(cookie.getValue())) {
            env.getOut().write("");
            return;
        }

        try {
            String sessionId = cookie.getValue();
            SessionContext sessionContext = sessionService.loadBySessionId(sessionId);
            SessionContext.set(sessionContext);
            ExecutionContext.setUserId(sessionContext.getUserId());
            ExecutionContext.setCorpCode(sessionContext.getCorpCode());
        } catch (PeException e) {
            LOG.error(e);
        }

        if (!SessionContext.get().isAdmin()) {
            env.getOut().write("");
            return;
        }

        String authCode = ((SimpleScalar) params.get("authCode")).getAsString();
        //隐藏标签
        if (StringUtils.isBlank(authCode)) {
            env.getOut().write("");
            return;
        }

        //权限标签处理
        if ("CORP_MANAGE".equals(authCode)) {
            if (PeConstant.DEFAULT_CORP_CODE.equals(ExecutionContext.getCorpCode())
                    && (SessionContext.get().isSuperAdmin() || SessionContext.get().isSystemAdmin())) {
                body.render(env.getOut());
                return;
            }

            env.getOut().write("");
            return;
        } else if (authCode.startsWith("VERSION_")) {
            if (SessionContext.get().getAuthCodes().contains(authCode)) {
                body.render(env.getOut());
                return;
            }

            env.getOut().write("");
            return;
        }

        if (SessionContext.get().isSuperAdmin() || SessionContext.get().isSystemAdmin()) {
            body.render(env.getOut());
            return;
        }

        try {
            if (CollectionUtils.isEmpty(SessionContext.get().getAuthCodes())) {
                env.getOut().write("");
                return;
            }

            if (SessionContext.get().getAuthCodes().contains(PeConstant.ALL)) {
                body.render(env.getOut());
                return;
            }

            if (!SessionContext.get().getAuthCodes().contains(authCode)) {
                env.getOut().write("");
                return;
            }

            body.render(env.getOut());
        } catch (PeException ex) {
            LOG.error(ex);
        }


    }
}
