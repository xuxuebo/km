package com.fp.cloud.base.mvc;

import com.google.gson.Gson;
import org.apache.commons.lang.StringUtils;

import java.beans.PropertyEditorSupport;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class StringMapPropertyEditor extends PropertyEditorSupport {

    private static final Gson gson = new Gson();

    public String getAsText() {
        if (this.getValue() == null) {
            return null;
        }

        @SuppressWarnings("unchecked")
        Map<String, String> map = (Map<String, String>) getValue();
        StringBuilder builder = new StringBuilder();
        boolean first = true;
        for (Map.Entry<String, String> entry : map.entrySet()) {
            if (first) {
                first = false;
            } else {
                builder.append("|");
            }

            builder.append(entry.getKey()).append(",").append(entry.getValue());
        }

        return builder.toString();
    }

    public void setAsText(String text) {
        if (StringUtils.isBlank(text)) {
            setValue(null);
            return;
        }

        String[] parts = text.trim().split("|");
        Map<String, Object> map = new HashMap<>(parts.length);
        for (String part : parts) {
            if (StringUtils.isBlank(part)) {
                continue;
            }

            int indexOf = part.trim().indexOf(",");
            if (indexOf < 0) {
                continue;
            }

            if (indexOf >= part.length() - 1) {
                map.put(part, null);
            } else {
                map.put(part.substring(indexOf), part.substring(indexOf + 1));
            }
        }

        setValue(map);
    }
}
