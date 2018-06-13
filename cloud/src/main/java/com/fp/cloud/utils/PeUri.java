package com.fp.cloud.utils;

import com.fp.cloud.base.framework.RequestContext;
import com.fp.cloud.constant.PeConstant;

import java.util.HashSet;
import java.util.Set;

public class PeUri {
    static Set<String> sessionNotRequiredSet = new HashSet<>();

    static {
        sessionNotRequiredSet.add("login/*");
        sessionNotRequiredSet.add("mobile/login/*");
        sessionNotRequiredSet.add("website/*");
    }

    public static boolean isSessionNotRequired(RequestContext requestContext) {
        String channel = requestContext.getChannel();
        String actionName = requestContext.getAction();

        return channel == null || processRequestUrl(channel, actionName);
    }

    private static boolean processRequestUrl(String channel, String actionName) {
        for (String notRequiredUrl : sessionNotRequiredSet) {
            if (!notRequiredUrl.contains(PeConstant.STAR)) {
                if (notRequiredUrl.equals(channel + PeConstant.BACKSLASH + actionName)) {
                    return true;
                }

                continue;
            }

            int firstTagIndex = notRequiredUrl.indexOf(PeConstant.BACKSLASH);
            int endTagIndex = notRequiredUrl.lastIndexOf(PeConstant.BACKSLASH);
            String noRequiredChannel = notRequiredUrl.substring(0, firstTagIndex);
            if (!noRequiredChannel.equals(channel)) {
                continue;
            }

            if (firstTagIndex == endTagIndex) {
                return true;
            }

            String noRequiredActionName = notRequiredUrl.substring(firstTagIndex + 1, endTagIndex);
            if (actionName.contains(noRequiredActionName)) {
                return true;
            }
        }

        return false;
    }

}
