package com.qgutech.km.utils;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.Random;

/**
 * 验证码生成工具
 */
public class VerifyCodeUtils {

    public static final String[] SECURITY_CODES = new String[]{"1", "2", "3", "4", "5", "6", "7", "8", "9"};

    public static final String[] SECURITY_NUMBER_CODES = new String[]{"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};

    /**
     * 生成图片
     *
     * @param code     图片显示的数字
     * @param response 响应
     * @since 2016年9月18日21:01:05
     */
    public static void generateCode(int width, int height, String code, HttpServletResponse response) {
        try {
            response.setContentType("image/jpeg");
            response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);
            ServletOutputStream out = response.getOutputStream();
            BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            Graphics graphics = image.getGraphics();
            // 设定背景色
            graphics.setColor(randomColor(200, 250));
            graphics.fillRect(0, 0, width, height);

            // 设定字体
            Font mFont = new Font(null, Font.BOLD, 18);// 设置字体
            graphics.setFont(mFont);

            // 画边框
            graphics.setColor(Color.BLACK);
            graphics.drawRect(0, 0, width - 1, height - 1);

            // 随机产生干扰线，使图象中的认证码不易被其它程序探测到
            graphics.setColor(randomColor(160, 200));
            // 生成随机类
            Random random = new Random();
            for (int i = 0; i < 155; i++) {
                int x2 = random.nextInt(width);
                int y2 = random.nextInt(height);
                int x3 = random.nextInt(12);
                int y3 = random.nextInt(12);
                graphics.drawLine(x2, y2, x2 + x3, y2 + y3);
            }

            // 将认证码显示到图象中
            graphics.setColor(new Color(20 + random.nextInt(110), 20 + random.nextInt(110), 20 + random.nextInt(110)));
            graphics.drawString(code, 6, 19);
            // 图象生效
            graphics.dispose();
            // 输出图象到页面
            // ImageIO.write(image, "JPEG", out);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(response.getOutputStream());
            encoder.encode(image);
            out.close();
        } catch (Exception ex) {
            throw new IllegalArgumentException(ex);
        }

    }


    public static String generateCode(int length, HttpServletResponse response) {
        String code = randomCode(length);
        generateCode(60, 24, code, response);
        return code;
    }

    /**
     * 给定范围获得随机颜色
     */
    private static Color randomColor(int fc, int bc) {
        Random random = new Random();
        if (fc > 255)
            fc = 255;
        if (bc > 255)
            bc = 255;
        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);
        return new Color(r, g, b);
    }

    /**
     * 获取随机数值
     *
     * @param length 需要的长度
     * @return 字符串
     * @since 2016年9月19日08:41:31
     */
    public static String randomCode(int length) {
        return randomCode(length, SECURITY_CODES);
    }

    /**
     * 获取随机数值
     *
     * @param length 需要的长度
     * @return 字符串
     * @since 2016年9月19日08:41:31
     */
    public static String randomCode(int length, String[] codes) {
        StringBuilder builder = new StringBuilder();
        int size = codes.length;
        for (int i = 0; i < length; i++) {
            double rdm = Math.random();
            int index = (int) (rdm * size);
            builder.append(codes[index]);
        }
        return builder.toString();
    }
}
