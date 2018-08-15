package com.qgutech.km.module.km.model;

/**
 * @author TangFD@HF 2018/8/15
 */
public class ValuePair {
    private String name;
    private Object value;

    public ValuePair(String name, Object value) {
        this.name = name;
        this.value = value;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Object getValue() {
        return value;
    }

    public void setValue(Object value) {
        this.value = value;
    }
}
