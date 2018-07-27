package com.qgutech.km.utils;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.redis.PeJedisCommands;
import com.qgutech.km.base.redis.PeRedisClient;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.constant.RedisKey;
import com.qgutech.km.module.sfm.model.PeFile;
import com.qgutech.km.module.sfm.service.FileServerService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.TextNode;
import org.jsoup.select.Elements;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Field;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 博易考 工具类
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月14日17:12:26
 */
public class PeUtils {

    private static final Log LOG = LogFactory.getLog(PeUtils.class);

    private static final String IMAGE_DEFAULT_URL = "/web-static/proExam/images/default-image.png";
    private static final String AUDIO_DEFAULT_URL = "/web-static/proExam/images/default-music.png";
    private static final String VIDEO_DEFAULT_URL = "/web-static/proExam/images/default-video.png";

    /**
     * 生成编号 2位年2位月2位日2位时2位分2位秒3毫秒3位流水号
     *
     * @return 编号
     * @since 2016年10月14日18:02:24
     */
    public static String getItemCode() {
        String codePrefix = PeDateUtils.format(new Date(), "yyMMddHHmmssSSS");
        String redisKey = RedisKey.ITEM_SN + PeConstant.REDIS_DIVISION +
                ExecutionContext.getCorpCode() + PeConstant.REDIS_DIVISION + codePrefix;
        return codePrefix + getCodeSn(redisKey, 1);
    }

    /**
     * 生成编号 2位年2位月2位日2位时2位分2位秒3位流水号
     *
     * @return 编号
     * @since 2016年10月14日18:02:24
     */
    public static String getPaperCode() {
        String codePrefix = PeDateUtils.format(new Date(), "yyMMddHHmmss");
        String redisKey = RedisKey.PAPER_SN + PeConstant.REDIS_DIVISION +
                ExecutionContext.getCorpCode() + PeConstant.REDIS_DIVISION + codePrefix;
        return codePrefix + getCodeSn(redisKey, 1000);
    }

    /**
     * 生成编号 2位年2位月2位日2位时2位分2位秒3位流水号
     *
     * @return 编号
     * @since 2016年10月14日18:02:24
     */
    public static String getFifteenCode(String key) {
        String codePrefix = PeDateUtils.format(new Date(), "yyMMddHHmmss");
        String redisKey = key + PeConstant.REDIS_DIVISION +
                ExecutionContext.getCorpCode() + PeConstant.REDIS_DIVISION + codePrefix;
        return codePrefix + getCodeSn(redisKey, 1000);
    }

    private static String getCodeSn(String redisKey, int sleepTime) {
        Long sn = getItemCodeSn(redisKey);
        try {
            if (sn >= 10000) {
                Thread.sleep(sleepTime);
                sn = getItemCodeSn(redisKey);
            }

        } catch (InterruptedException e) {
            LOG.error(e);
            sn = getItemCodeSn(redisKey);
        }

        if (sn < 10) {
            return "00" + sn;
        } else if (sn < 100) {
            return "0" + sn;
        }

        return sn.toString();
    }

    private static Long getItemCodeSn(String redisKey) {
        PeJedisCommands jedisCommands = PeRedisClient.getCommonJedis();
        Long itemSn = NumberUtils.LONG_ONE;
        Long existNum = jedisCommands.setnx(redisKey, itemSn);
        if (existNum == null || existNum <= 0) {
            itemSn = jedisCommands.incr(redisKey);
        } else {
            jedisCommands.expire(redisKey, 1);
        }

        return itemSn;
    }

    /**
     * 验证分页条件
     *
     * @param page 分页参数
     * @since 2016年10月17日12:30:39
     */
    public static void validPage(PageParam page) {
        if (page == null) {
            throw new PeException("Page is null!");
        }

        if (page.isAutoPaging()) {
            int pageSize = page.getPageSize();
            if (pageSize < 1) {
                throw new PeException("Page size must bigger than 1!");
            }

            int first = page.getStart();
            if (first < 0) {
                throw new PeException("First page must bigger than 0!");
            }
        }
    }

    public static String subString(String value, int startIndex, int endIndex) {
        Document document = Jsoup.parse(value);
        Elements elements = document.getElementsByAttributeValue("class", "upload-img");
        if (!elements.isEmpty()) {
            for (Element element : elements) {
                element.replaceWith(new TextNode("【图片】", ""));
            }

            value = document.body().text();
        }

        elements = document.getElementsByAttributeValue("class", "image-audio");
        if (!elements.isEmpty()) {
            for (Element element : elements) {
                element.replaceWith(new TextNode("【音频】", ""));
            }

            value = document.body().text();
        }

        elements = document.getElementsByAttributeValue("class", "image-video");
        if (!elements.isEmpty()) {
            for (Element element : elements) {
                element.replaceWith(new TextNode("【视频】", ""));
            }

            value = document.body().text();
        }

        elements = document.getElementsByAttributeValue("class", "insert-blank-item");
        if (!elements.isEmpty()) {
            for (Element element : elements) {
                element.replaceWith(new TextNode("【填空】", ""));
            }

            value = document.body().text();
        }

        if (value.length() < endIndex) {
            return value.substring(startIndex, value.length());
        }

        return value.substring(startIndex, endIndex);
    }

    public static <T> List<T> subList(List<T> values, int startIndex, int endIndex) {
        if (endIndex > values.size()) {
            endIndex = values.size();
        }

        return values.subList(startIndex, endIndex);
    }

    /**
     * 返回 1~max之间不重复的随机数（包括1、max）
     *
     * @param max 最大数
     * @return 数值集合
     * @since 2016年10月19日18:32:46
     */
    public static List<Integer> randomNum(int max) {
        List<Integer> randomNumList = new ArrayList<Integer>();
        long speed = System.currentTimeMillis() + ((int) (Math.random() * 1000));
        Random random = new Random(speed);
        int count = 0;
        while (count < max) {
            int randomInt = Math.abs(random.nextInt()) % max + 1;
            if (randomNumList.contains(randomInt)) {
                continue;
            }
            randomNumList.add(randomInt);
            count++;
        }

        return randomNumList;
    }

    /**
     * 返回 1~max之间的随机数
     *
     * @param max 最大数
     * @return 数值
     * @since 2016年10月19日18:32:46
     */

    public static Integer getRandomNum(int max) {
        Random random = new Random(System.currentTimeMillis());
        return Math.abs(random.nextInt()) % max + 1;
    }



    /**
     * 分页对象内部属性提取转换
     *
     * @author zhangyang
     * @since 2016年10月31日15:01:58
     */
    @SuppressWarnings("unchecked")
    public static <T, V> Page<T> convertPage(Page<V> vPage, String fieldName) {
        Page<T> tPage = new Page<T>();
        tPage.setAutoCount(vPage.isAutoCount());
        tPage.setAutoPaging(vPage.isAutoCount());
        tPage.setOrder(vPage.getOrder());
        tPage.setPage(vPage.getPage());
        tPage.setPageSize(vPage.getPageSize());
        tPage.setSort(vPage.getSort());
        tPage.setTotal(vPage.getTotal());
        List<V> rows = vPage.getRows();
        if (rows == null || rows.size() == 0) {
            return tPage;
        }
        List<T> tList = new ArrayList<T>();
        tPage.setRows(tList);
        Field field = null;
        for (V v : rows) {
            if (field == null) {
                try {
                    field = v.getClass().getDeclaredField(fieldName);
                } catch (NoSuchFieldException e) {
                    throw new RuntimeException("field[" + fieldName + "] is not exist!", e);
                }

                if (field == null) {
                    throw new RuntimeException("field[" + fieldName + "] is not exist!");
                }

                field.setAccessible(true);
            }

            try {
                T t = (T) field.get(v);
                tList.add(t);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }

        return tPage;
    }

    private static void processElements(Elements elements, PeFile.ProcessorType processorType) {
        FileServerService fileServerService = SpringContextHolder.getBean("fileServerService");
        if (elements.size() <= 0) {
            return;
        }

        String resourcePath = PropertiesUtils.getEnvProp().getProperty("static.resource.path");
        List<String> fileIds = new ArrayList<>(elements.size());
        String defaultUrl = null;
        switch (processorType) {
            case IMAGE:
                defaultUrl = IMAGE_DEFAULT_URL;
                break;
            case AUDIO:
                defaultUrl = AUDIO_DEFAULT_URL;
                break;
            case VIDEO:
                defaultUrl = VIDEO_DEFAULT_URL;
                break;
        }

        for (Element element : elements) {
            String id = element.attr("data-id");
            element.attr("src", resourcePath + defaultUrl);
            if (StringUtils.isBlank(id)) {
                continue;
            }

            fileIds.add(id);
        }

        if (CollectionUtils.isEmpty(fileIds)) {
            return;
        }

        Map<String, String> filePathMap = fileServerService.findFilePath(fileIds);
        for (Element element : elements) {
            String id = element.attr("data-id");
            if (StringUtils.isBlank(id)) {
                continue;
            }

            if (StringUtils.isBlank(filePathMap.get(id))) {
                continue;
            }

            element.attr("data-src", filePathMap.get(id));
        }
    }

    //获取IP地址
    public static String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("X-Real-IP");
        if (StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("x-forwarded-for");
        }

        if (StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }

        if (StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }

        if (StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
            if (ip.equals("127.0.0.1")) {
                //根据网卡取本机配置的IP
                try {
                    ip = InetAddress.getLocalHost().getHostAddress();
                } catch (UnknownHostException e) {
                    LOG.error("can not get ip address!", e);
                }
            }
        }

        return ip;
    }

    private static String progressImgHtml(String text, List<String> imgTexts) {
        if (StringUtils.isBlank(text) || CollectionUtils.isEmpty(imgTexts)) {
            return text;
        }

        for (String imgText : imgTexts) {
            text = text.replaceAll(imgText, StringUtils.EMPTY);
        }

        return text;
    }

    /**
     * 分钟转换
     *
     * @param second 秒
     * @return 00:00:00
     * @since 2016年12月8日17:01:24
     */
    public static String processTime(int second) {
        if (second <= 0) {
            return "00:00:00";
        }

        String timeString;
        int hour = second / 3600;
        if (hour < 10) {
            timeString = "0" + hour;
        } else {
            timeString = String.valueOf(hour);
        }

        timeString = timeString + ":";
        int minute = second % 3600 / 60;
        if (minute < 10) {
            timeString = timeString + "0" + minute;
        } else {
            timeString = timeString + String.valueOf(minute);
        }

        timeString = timeString + ":";
        second = second % 3600 % 60;
        if (second < 10) {
            timeString = timeString + "0" + second;
        } else {
            timeString = timeString + String.valueOf(second);
        }

        return timeString;
    }

    /**
     * 打乱list集合
     *
     * @param list 集合信息
     * @return 乱序后的list
     * @since 2016年12月12日17:25:59
     */
    public static <X> List<X> upsetList(List<X> list) {
        if (CollectionUtils.isEmpty(list)) {
            return new ArrayList<>(0);
        }

        List<Integer> randomNumbers = randomNum(list.size());
        List<X> upsets = new ArrayList<>(list.size());
        for (Integer number : randomNumbers) {
            upsets.add(list.get(number - 1));
        }

        return upsets;
    }

    public static String secondTranTime(long time) {
        if (time <= 0) {
            return StringUtils.EMPTY;
        }

        long hour = time / (60 * 60);
        time = time % (60 * 60);
        long minute = time / 60;
        long second = time % 60;
        if (hour > 0) {
            return hour + "时" + minute + "分" + second + "秒";
        } else if (hour <= 0 && minute > 0) {
            return minute + "分" + second + "秒";
        } else if (hour <= 0 && minute <= 0 && second >= 0) {
            return second + "秒";
        }

        return StringUtils.EMPTY;
    }

    /**
     * 封装接口请求参数，针对ELP
     *
     * @param requestURI 请求路径
     * @return map 参数集合
     * @since 2017-11-15 14:50:18
     */
    public static Map<String, String> packageParam(String requestURI) {
        Map<String, String> params = new HashMap<>();
        String appSecret = PropertiesUtils.getEnvProp().getProperty("interface.elp.app.secret");
        String appKey = PropertiesUtils.getEnvProp().getProperty("interface.elp.app.key");
        String signText = appSecret + "|" + requestURI + "|" + appSecret;
        String md5Sign = MD5Generator.getHexMD5(signText);
        params.put("sign_", md5Sign == null ? null : md5Sign.toUpperCase());
        params.put("appKey_", appKey);
        params.put("timestamp_", System.currentTimeMillis() + "");
        return params;
    }

    public static List<String> intersection(List<String> list1, List<String> list2) {
        if (CollectionUtils.isEmpty(list1)) {
            return list2;
        }
        if (CollectionUtils.isEmpty(list2)) {
            return list1;
        }

        Map<String, Boolean> map = new HashMap<>(list1.size());
        for (String string : list1) {
            map.put(string, true);
        }

        return list2.stream().filter(string -> BooleanUtils.isTrue(map.get(string))).collect(Collectors.toList());
    }
}
