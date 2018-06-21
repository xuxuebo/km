package com.qgutech.km.utils;

/**
 * 自定义异常
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月8日16:59:20
 */
public class PeException extends RuntimeException {

    public PeException() {
        super();
    }

    public PeException(String message) {
        super(message);
    }

    public PeException(String message, Throwable cause) {
        super(message, cause);
    }

    public PeException(Throwable cause) {
        super(cause);
    }

    protected PeException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
