package com.qgutech.pe.base.mvc;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonParseException;
import com.google.gson.reflect.TypeToken;
import com.qgutech.pe.utils.ReflectUtil;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpInputMessage;
import org.springframework.http.HttpOutputMessage;
import org.springframework.http.MediaType;
import org.springframework.http.converter.AbstractGenericHttpMessageConverter;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.util.Assert;
import org.springframework.util.ClassUtils;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.lang.reflect.Field;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.nio.charset.Charset;
import java.util.*;

public class PeGsonHttpMessageConverter extends AbstractGenericHttpMessageConverter<Object> {

    public static final Charset DEFAULT_CHARSET = Charset.forName("UTF-8");


    private Gson gson = new Gson();

    private String jsonPrefix;

    /**
     * Construct a new {@code GsonHttpMessageConverter}.
     */
    public PeGsonHttpMessageConverter() {
        super(MediaType.APPLICATION_JSON, new MediaType("application", "*+json"));
        this.setDefaultCharset(DEFAULT_CHARSET);
    }

    /**
     * Set the {@code Gson} instance to use.
     * If not set, a default {@link Gson#Gson() Gson} instance is used.
     * <p>Setting a custom-configured {@code Gson} is one way to take further
     * control of the JSON serialization process.
     */
    public void setGson(Gson gson) {
        Assert.notNull(gson, "'gson' is required");
        this.gson = gson;
    }

    /**
     * Return the configured {@code Gson} instance for this converter.
     */
    public Gson getGson() {
        return this.gson;
    }

    /**
     * Specify a custom prefix to use for JSON output. Default is none.
     *
     * @see #setPrefixJson
     */
    public void setJsonPrefix(String jsonPrefix) {
        this.jsonPrefix = jsonPrefix;
    }

    /**
     * Indicate whether the JSON output by this view should be prefixed with ")]}', ".
     * Default is {@code false}.
     * <p>Prefixing the JSON string in this manner is used to help prevent JSON
     * Hijacking. The prefix renders the string syntactically invalid as a script
     * so that it cannot be hijacked.
     * This prefix should be stripped before parsing the string as JSON.
     *
     * @see #setJsonPrefix
     */
    public void setPrefixJson(boolean prefixJson) {
        this.jsonPrefix = (prefixJson ? ")]}', " : null);
    }

    @Override
    public boolean canRead(Class<?> clazz, MediaType mediaType) {
        return canRead(mediaType);
    }

    @Override
    public boolean canWrite(Class<?> clazz, MediaType mediaType) {
        return canWrite(mediaType);
    }

    @Override
    protected boolean supports(Class<?> clazz) {
        // should not be called, since we override canRead/Write instead
        throw new UnsupportedOperationException();
    }

    @Override
    protected Object readInternal(Class<?> clazz, HttpInputMessage inputMessage)
            throws IOException, HttpMessageNotReadableException {

        TypeToken<?> token = getTypeToken(clazz);
        return readTypeToken(token, inputMessage);
    }

    @Override
    public Object read(Type type, Class<?> contextClass, HttpInputMessage inputMessage)
            throws IOException, HttpMessageNotReadableException {

        TypeToken<?> token = getTypeToken(type);
        return readTypeToken(token, inputMessage);
    }

    /**
     * Return the Gson {@link TypeToken} for the specified type.
     * <p>The default implementation returns {@code TypeToken.get(type)}, but
     * this can be overridden in subclasses to allow for custom generic
     * collection handling. For instance:
     * <pre class="code">
     * protected TypeToken<?> getTypeToken(Type type) {
     * if (type instanceof Class && List.class.isAssignableFrom((Class<?>) type)) {
     * return new TypeToken<ArrayList<MyBean>>() {};
     * }
     * else {
     * return super.getTypeToken(type);
     * }
     * }
     * </pre>
     *
     * @param type the type for which to return the TypeToken
     * @return the type token
     */
    protected TypeToken<?> getTypeToken(Type type) {
        return TypeToken.get(type);
    }

    private Object readTypeToken(TypeToken<?> token, HttpInputMessage inputMessage) throws IOException {
        Reader json = new InputStreamReader(inputMessage.getBody(), getCharset(inputMessage.getHeaders()));
        try {
            return this.gson.fromJson(json, token.getType());
        } catch (JsonParseException ex) {
            throw new HttpMessageNotReadableException("Could not read JSON: " + ex.getMessage(), ex);
        }
    }

    private Charset getCharset(HttpHeaders headers) {
        if (headers == null || headers.getContentType() == null || headers.getContentType().getCharset() == null) {
            return DEFAULT_CHARSET;
        }
        return headers.getContentType().getCharset();
    }

    @Override
    protected void writeInternal(Object o, Type type, HttpOutputMessage outputMessage)
            throws IOException, HttpMessageNotWritableException {

        Charset charset = getCharset(outputMessage.getHeaders());
        OutputStreamWriter writer = new OutputStreamWriter(outputMessage.getBody(), charset);
        try {
            if (this.jsonPrefix != null) {
                writer.append(this.jsonPrefix);
            }

            processLazyObject(o);

            if (type != null) {
                this.gson.toJson(o, type, writer);
            } else {
                this.gson.toJson(o, writer);
            }

            writer.close();
        } catch (JsonIOException ex) {
            throw new HttpMessageNotWritableException("Could not write JSON: " + ex.getMessage(), ex);
        }
    }

    private void processLazyObject(Object result) {
        if (result == null) {
            return;
        }

        Class<?> clazz = result.getClass();
        if (pass(clazz)) {
            return;
        }

        if (Collection.class.isAssignableFrom(clazz)) {
            processLazyCollection((Collection) result);
        } else if (Map.class.isAssignableFrom(clazz)) {
            processLazyMap((Map) result);
        } else if (clazz.isArray()) {
            processLazyArray((Object[]) result);
        } else {
            processLazyField(result);
        }
    }

    private boolean pass(Class<?> clazz) {
        return clazz.isPrimitive() || clazz.isEnum()
                || String.class.equals(clazz)
                || ClassUtils.isPrimitiveWrapper(clazz)
                || clazz.equals(BigDecimal.class)
                || Date.class.isAssignableFrom(clazz);
    }

    private boolean checkLazyObject(Class<?> clazz) {
        return clazz.getName().contains("_$$_");
    }

    private boolean checkLazyList(Object fieldValue) {
        try {
            if (fieldValue instanceof Collection) {
                Collection collection = (Collection) fieldValue;
                collection.size();
            } else if (fieldValue instanceof Map) {
                Map map = (Map) fieldValue;
                map.size();
            }

            return false;
        } catch (Exception e) {
            return true;
        }
    }

    private void processLazyCollection(Collection collection) {
        if (collection == null || collection.size() == 0) {
            return;
        }

        Iterator iterator = collection.iterator();
        while (iterator.hasNext()) {
            Object o = iterator.next();
            if (o == null || pass(o.getClass())) {
                continue;
            }

            if (checkLazyObject(o.getClass())) {
                iterator.remove();
                continue;
            }

            processLazyObject(o);
        }
    }

    @SuppressWarnings("unchecked")
    private void processLazyMap(Map map) {
        if (map == null || map.size() == 0) {
            return;
        }

        Iterator<Map.Entry> iterator = map.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry next = iterator.next();
            Object key = next.getKey();
            Object value = next.getValue();
            if (key == null || pass(key.getClass())) {
                if (value == null || pass(value.getClass())) {
                    continue;
                }

                if (checkLazyObject(value.getClass())) {
                    iterator.remove();
                } else {
                    processLazyObject(value);
                }

                continue;
            }

            if (checkLazyObject(key.getClass())) {
                iterator.remove();
                continue;

            }

            if (value == null || pass(value.getClass())) {
                processLazyObject(key);
                continue;
            }

            if (checkLazyObject(value.getClass())) {
                iterator.remove();
                continue;
            }

            processLazyObject(key);
            processLazyObject(value);
        }
    }

    private void processLazyArray(Object[] objects) {
        if (objects == null || objects.length == 0) {
            return;
        }

        for (int i = 0; i < objects.length; i++) {
            Object o = objects[i];
            if (o == null || pass(o.getClass())) {
                continue;
            }

            if (checkLazyObject(o.getClass())) {
                objects[i] = null;
                continue;
            }

            processLazyObject(o);
        }
    }

    private void processLazyField(Object o) {
        List<Field> fields = ReflectUtil.getFields(o.getClass());
        if (fields == null || fields.size() == 0) {
            return;
        }

        for (Field f : fields) {
            if (f == null) {
                continue;
            }

            Class<?> fieldType = f.getType();
            if (pass(fieldType)) {
                continue;
            }

            Object fieldValue = ReflectUtil.getFieldValue(f, o);
            if (fieldValue == null) {
                continue;
            }

            Class<?> clazz = fieldValue.getClass();
            if (checkLazyObject(clazz)) {
                ReflectUtil.setFieldValue(f, o, getEagerObject(fieldValue));
                continue;
            }

            if (checkLazyList(fieldValue)) {
                ReflectUtil.setFieldValue(f, o, null);
                continue;
            }

            processLazyObject(fieldValue);
        }
    }

    private Object getEagerObject(Object o) {
        Field handler = ReflectUtil.getField(o.getClass(), "handler");
        if (handler == null) {
            return null;
        }

        Object handlerValue = ReflectUtil.getFieldValue(handler, o);
        if (handlerValue == null) {
            return null;
        }

        Field persistentClassField = ReflectUtil.getField(handlerValue.getClass(), "persistentClass");
        if (persistentClassField == null) {
            return null;
        }

        Field idField = ReflectUtil.getField(handlerValue.getClass(), "id");
        if (idField == null) {
            return null;
        }

        Class<?> persistentClass = (Class<?>) ReflectUtil.getFieldValue(persistentClassField, handlerValue);
        if (persistentClass == null) {
            return null;
        }

        Field idF = ReflectUtil.getField(persistentClass, "id");
        if (idF == null) {
            return null;
        }

        Object id = ReflectUtil.getFieldValue(idField, handlerValue);
        if (id == null) {
            return null;
        }

        Object instance = ReflectUtil.newInstance(persistentClass);
        if (instance == null) {
            return null;
        }

        ReflectUtil.setFieldValue(idF, instance, id);
        return instance;
    }
}