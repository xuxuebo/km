package com.fp.cloud.utils;

import java.util.UUID;

/**
 * 该类用于获取32位的UUID
 *
 * @author TaoFaDeng@HF
 * @since 2016年2月23日15:18:32
 */
public class UUIDGenerator {
    public static String uuid() {
        return UUID.randomUUID().toString().replace("-", "");
    }
}
