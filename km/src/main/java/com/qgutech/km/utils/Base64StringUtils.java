package com.qgutech.km.utils;

import java.io.UnsupportedEncodingException;

public class Base64StringUtils {

    private static final String UTF_8 = "UTF-8";

    public static String newStringUtf8(byte[] bytes) {
        return Base64StringUtils.newString(bytes, UTF_8);
    }

    public static String newString(byte[] bytes, String charsetName) {
        if (bytes == null) {
            return null;
        }
        try {
            return new String(bytes, charsetName);
        } catch (UnsupportedEncodingException e) {
            throw Base64StringUtils.newIllegalStateException(charsetName, e);
        }
    }

    private static IllegalStateException newIllegalStateException(
            String charsetName, UnsupportedEncodingException e) {
        return new IllegalStateException(charsetName + ": " + e);
    }

    /**
     * Constructs a new <code>String</code> by decoding the specified array of
     * bytes using the UTF-8 charset.
     *
     * @param bytes
     *            The bytes to be decoded into characters
     * @return A new <code>String</code> decoded from the specified array of
     *         bytes using the given charset.
     * @throws IllegalStateException
     *             Thrown when a {@link UnsupportedEncodingException} is caught,
     *             which should never happen since the charset is required.
     */

    public static byte[] newBytesUtf8(String string) {
        return Base64StringUtils.getBytesUnchecked(string, UTF_8);
    }

    private static byte[] getBytesUnchecked(String string, String charsetName) {
        if (string == null) {
            return null;
        }
        try {
            return string.getBytes(charsetName);
        } catch (UnsupportedEncodingException e) {
            throw new IllegalStateException(charsetName + ": " + e);
        }
    }

    public static byte[] getBytesUtf8(String string) {
        return Base64StringUtils.getBytesUnchecked(string, UTF_8);
    }

}

