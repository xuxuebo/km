package com.qgutech.km.base.framework;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.constant.PeConstant;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.AbstractTemplateViewResolver;
import org.springframework.web.servlet.view.AbstractUrlBasedView;
import org.springframework.web.servlet.view.AbstractView;
import org.springframework.web.servlet.view.freemarker.FreeMarkerView;

import java.util.Locale;


public class PeFreeMarkerViewResolver extends AbstractTemplateViewResolver {
    /**
     * Sets the default {@link #setViewClass view class} to {@link #requiredViewClass}:
     * by default {@link FreeMarkerView}.
     */
    public PeFreeMarkerViewResolver() {
        setViewClass(requiredViewClass());
    }

    /**
     * A convenience constructor that allows for specifying {@link #setPrefix prefix}
     * and {@link #setSuffix suffix} as constructor arguments.
     *
     * @param prefix the prefix that gets prepended to view names when building a URL
     * @param suffix the suffix that gets appended to view names when building a URL
     * @since 4.3
     */
    public PeFreeMarkerViewResolver(String prefix, String suffix) {
        this();
        setPrefix(prefix);
        setSuffix(suffix);
    }

    /**
     * Requires {@link FreeMarkerView}.
     */
    @Override
    protected Class<?> requiredViewClass() {
        return FreeMarkerView.class;
    }

    @Override
    protected View loadView(String viewName, Locale locale) throws Exception {
        AbstractUrlBasedView view = buildView(ExecutionContext.getCorpCode() + PeConstant.BACKSLASH + viewName);
        View result = applyLifecycleMethods(ExecutionContext.getCorpCode() + PeConstant.BACKSLASH + viewName, view);
        if (view.checkResource(locale)) {
            return result;
        }

        view = buildView(viewName);
        result = applyLifecycleMethods(viewName, view);
        return (view.checkResource(locale) ? result : null);
    }

    private View applyLifecycleMethods(String viewName, AbstractView view) {
        return (View) getApplicationContext().getAutowireCapableBeanFactory().initializeBean(view, viewName);
    }
}
