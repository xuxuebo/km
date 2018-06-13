package com.fp.cloud.utils;

import com.fp.cloud.module.ems.vo.Ioa;
import com.fp.cloud.module.ems.vo.Mm;
import org.apache.commons.lang.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by jianbolin on 2018/5/31.
 */
public class MobileUtils {

    private final static String TEXT = "TEXT";
    private final static String AUDIO = "AUDIO";
    private final static String VIDEO = "VIDEO";
    private final static String PICTURE = "PICTURE";
    private final static String EDIT = "EDIT";

    public static Ioa getIoa(String s, String itemType){
        s =dealHtmlToText(s);
        if (StringUtils.isEmpty(s)){
            return null;
        }
        Ioa ioa = new Ioa();
        List<Mm> mms = new ArrayList<>();
        List<String> imgs = extractMessage(s);
        if (imgs == null || imgs.size() == 0){
            ioa.setCt(s);
            Mm mm = new Mm();
            mm.setText(s);
            mm.setType(TEXT);
            mms.add(mm);
            ioa.setMobileModels(mms);
            return ioa;
        }

        String st = s;

        for (int i = 0 ; i < imgs.size();i++){
            String img = "＜"+imgs.get(i)+"＞";
            Document doc = (Document) Jsoup.parse("<"+imgs.get(i)+">");
            Elements elements = doc.getElementsByTag("img");
            String  src = elements.attr("data-src");
            String s1 = "";
            if (!imgs.get(i).contains("img") && !imgs.get(i).contains("input")){
                if (imgs.size() == 1) {
                    ioa.setCt(s);
                    Mm mm = new Mm();
                    mm.setText(s);
                    mm.setType(TEXT);
                    mms.add(mm);
                }
                continue;
            }

            if (st.startsWith(img)){
                s1 = "";
                st = st.substring(img.length(),st.length());
            }else {
                s1 = st.split(img)[0];

                if (st.split(img).length > 1) {
                    String s2 = "";
                    for (int k = 1; k < st.split(img).length; k++) {
                        if (k == 1) {
                            s2 += st.split(img)[k];
                        } else {
                            s2 += img + st.split(img)[k];
                        }
                    }
                    st = s2;
                } else {
                    st = "";
                }
            }
            if (StringUtils.isNotBlank(s1)){
                Mm mm = new Mm();
                mm.setType(TEXT);
                mm.setText(s1);
                mms.add(mm);
            }
            if (elements != null && elements.size() > 0) {
                Mm mm = new Mm();
                if (src.endsWith("mp3") || src.endsWith("MP3")) {
                    mm.setType(AUDIO);
                    mm.setUrl(src);
                } else if (src.endsWith("mp4") || src.endsWith("MP4")) {
                    mm.setType(VIDEO);
                    mm.setUrl(src);
                } else if (src.endsWith("jpg") || src.endsWith("JPG") || src.endsWith("jpeg") || src.endsWith("JPEG")
                        || src.endsWith("png") || src.endsWith("PNG") || src.endsWith("gif") || src.endsWith("GIF")) {
                    mm.setType(PICTURE);
                    mm.setUrl(src);
                }
                mms.add(mm);
            }else{
                Mm mm = new Mm();
                mm.setType(EDIT);
                mm.setText("________");
                mms.add(mm);
            }
            if (i == imgs.size() -1){
                if (StringUtils.isNotBlank(st)){
                    Mm mm = new Mm();
                    mm.setType(TEXT);
                    mm.setText(st);
                    mms.add(mm);
                }
            }
        }

        ioa.setMobileModels(mms);
        return ioa;
    }


    /**
     * 提取<括号中内容，忽略<括号中的<括号
     * @param msg
     * @return
     */
    public static List<String> extractMessage(String msg) {

        List<String> list = new ArrayList<String>();
        int start = 0;
        int startFlag = 0;
        int endFlag = 0;
        for (int i = 0; i < msg.length(); i++) {
            if (msg.charAt(i) == '＜') {
                startFlag++;
                if (startFlag == endFlag + 1) {
                    start = i;
                }
            } else if (msg.charAt(i) == '＞') {
                endFlag++;
                if (endFlag == startFlag) {
                    if (start + 1 != i) {
                        list.add(msg.substring(start + 1, i));
                    }
                }
            }
        }
        return list;
    }

    public static void main(String[] args){
        String s = "《钢铁是怎样炼成的》作者是谁？ \n" +
                "<br>";
        Ioa ioa = getIoa(s, "FILL");
        System.out.printf(ioa.toString());
    }

    private static String dealHtmlToText(String htmlContent) {
        if(StringUtils.isEmpty(htmlContent)){
            return htmlContent;
        }

        return htmlContent.replace("<br>","\n").replace("&lt;", "＜").replace("&gt;", "＞").replace("<", "＜").replace(">", "＞");
    }
}
