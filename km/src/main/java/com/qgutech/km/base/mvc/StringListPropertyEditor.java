package com.qgutech.km.base.mvc;

import org.apache.commons.lang.StringUtils;

import java.beans.PropertyEditorSupport;
import java.util.ArrayList;
import java.util.List;


public class StringListPropertyEditor extends PropertyEditorSupport {

    public String getAsText() {
        if (this.getValue() == null) {
            return null;
        }

        @SuppressWarnings("unchecked")
        List<String> list = (List<String>) getValue();
        StringBuilder sb = new StringBuilder();
        boolean first = true;
        for (Object element : list) {
            if (first) {
                first = false;
            } else {
                sb.append(",");
            }
            sb.append(element);

        }

        return sb.toString();
    }

    public void setAsText(String text) {
        if (StringUtils.isEmpty(text)) {
            setValue(null);
            return;

        }

        String[] parts = text.split(",");
        List<String> list = new ArrayList<String>(parts.length);
        for (String part : parts) {
            list.add(part.trim());
        }

        setValue(list);
    }
}
