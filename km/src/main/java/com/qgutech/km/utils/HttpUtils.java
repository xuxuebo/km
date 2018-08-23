package com.qgutech.km.utils;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * http 工具
 *
 * @author LiYanCheng
 * @since 2017-11-13 14:33:32
 */
public class HttpUtils {

    private static final Integer STATUS_200 = 200;

    private static final Log LOG = LogFactory.getLog(HttpUtils.class);

    /**
     * http get 请求
     *
     * @param url 请求路径
     * @return 返回值
     */
    public static String requestGet(String url) {
        //实例化httpclient
        CloseableHttpClient httpclient = HttpClients.createDefault();
        //实例化get方法
        HttpGet httpget = new HttpGet(url);
        //请求结果
        CloseableHttpResponse response = null;
        String content = "";
        try {
            //执行get方法
            response = httpclient.execute(httpget);
            if (response.getStatusLine().getStatusCode() == STATUS_200) {
                content = EntityUtils.toString(response.getEntity(), "UTF-8");
            }

        } catch (IOException e) {
            LOG.error(e);
        } finally {
            try {
                if (response != null) {
                    response.close();
                }
            } catch (IOException ignored) {

            }
            if (httpclient != null) {
                try {
                    httpclient.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        return content;
    }


    /**
     * http post 请求
     *
     * @param url    请求路径
     * @param params 请求参数
     * @return 返回值
     */
    public static String requestPost(String url, Map<String, String> params) {
        //实例化httpClient
        CloseableHttpClient httpclient = HttpClients.createDefault();
        //实例化post方法
        HttpPost httpPost = new HttpPost(url);
        //处理参数
        List<NameValuePair> nameValuePairs = new ArrayList<>();
        Set<String> keySet = params.keySet();
        for (String key : keySet) {
            nameValuePairs.add(new BasicNameValuePair(key, params.get(key)));
        }

        //结果
        CloseableHttpResponse response = null;
        String content = "";
        try {
            //提交的参数
            UrlEncodedFormEntity uefEntity = new UrlEncodedFormEntity(nameValuePairs, "UTF-8");
            //将参数给post方法
            httpPost.setEntity(uefEntity);
            //执行post方法
            response = httpclient.execute(httpPost);
            if (response.getStatusLine().getStatusCode() == STATUS_200) {
                content = EntityUtils.toString(response.getEntity(), "UTF-8");
            }

        } catch (IOException e) {
            LOG.error("IOException");
        } finally {
            try {
                if (response != null) {
                    response.close();
                }
            } catch (IOException ignored) {

            }
            if (httpclient != null) {
                try {
                    httpclient.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        return content;
    }

    public static String getBrowser(HttpServletRequest request) {
        String UserAgent = request.getHeader("USER-AGENT").toLowerCase();
        if (UserAgent.contains("msie")) {
            return "IE";
        }

        if (UserAgent.contains("firefox")) {
            return "FF";
        }

        if (UserAgent.contains("safari")) {
            return "SF";
        }

        return null;
    }

    public static String doGet(String userInfoUrl, String token) {
        String uri = userInfoUrl + "?token=" + token;
        System.out.println("------uri----------" + uri);
        GetMethod getMethod = new GetMethod(uri);
        HttpClient client = new HttpClient();
        try {
            client.executeMethod(getMethod);
            InputStream stream = getMethod.getResponseBodyAsStream();
            StringBuilder sb = new StringBuilder();
            String line;
            BufferedReader br = new BufferedReader(new InputStreamReader(stream));
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

            System.out.println(sb);
            return sb.toString();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
