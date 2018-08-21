package com.qgutech.km.base.vo;

/**
 * 前后台交互
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年9月1日16:09:49
 */
public class JsonResult<T> {

    public static final String SUCCESS = "SUCCESS";
    public static final String FAILED = "FAILED";

    private boolean success = true;
    private T data;
    private String message;
    private String statusCode;
    private Object object;

    public JsonResult() {

    }

    public JsonResult(boolean success, String message) {
        this.success = success;
        this.message = message;
    }

    public JsonResult(boolean success, String message, T data) {
        this.success = success;
        this.message = message;
        this.data = data;
    }


    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }

    @Override
    public String toString() {
        return "JsonResult{" +
                "success=" + success +
                ", data=" + data +
                ", message='" + message + '\'' +
                ", statusCode='" + statusCode + '\'' +
                ", object=" + object +
                '}';
    }

    public void setSuccessAndMessage(boolean success, String message) {
        this.success = success;
        this.message = message;
    }
}
