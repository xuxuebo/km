package com.fp.cloud.base.mvc;

import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.support.ConfigurableWebBindingInitializer;
import org.springframework.web.context.request.WebRequest;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class PeWebBindingInitializer extends ConfigurableWebBindingInitializer {
    @Override
    public void initBinder(WebDataBinder binder, WebRequest request) {
        super.initBinder(binder, request);
        binder.registerCustomEditor(Date.class, new DatePropertyEditor());
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
        binder.registerCustomEditor(List.class, new StringListPropertyEditor());
        binder.registerCustomEditor(Map.class, new StringMapPropertyEditor());
    }
}