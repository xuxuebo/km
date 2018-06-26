/*
 * 文件名:LikeAnalyzer.java
 * 创建时间:2014-06-20
 * 版本:1.0
 * 版权所有:上海时代光华教育发展有限公司
 */
package com.qgutech.km.module.km.service;

import org.apache.lucene.analysis.Analyzer;

import java.io.Reader;

/**
 * 类似数据库的like分词器。
 *
 * @author ZhaoJie@HF
 * @version 1.0
 * @since 2014-06-20
 */
public class LikeAnalyzer extends Analyzer {
    @Override
    protected TokenStreamComponents createComponents(String fieldName, Reader reader) {
        return new TokenStreamComponents(new LikeTokenizer(reader));
    }
}
