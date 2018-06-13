package com.fp.cloud.module.ems.vo;

/**
 * Created by jianbolin on 2018/6/4.
 */
public class Mm {
    private String text;

    //TEXT AUDIO VIDEO PICTURE EDIT
    private String type;
    private String url;

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return "Mm{" +
                "text='" + text + '\'' +
                ", type='" + type + '\'' +
                ", url='" + url + '\'' +
                '}';
    }
}
