package com.qgutech.pe.utils;

import com.qgutech.pe.base.framework.RequestContext;
import com.qgutech.pe.constant.PeConstant;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.iterators.CollatingIterator;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
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
