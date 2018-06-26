/*
 * 文件名:FullTextSearchManager.java
 * 创建时间:2014-05-19
 * 版本:1.0
 * 版权所有:上海时代光华教育发展有限公司
 */
package com.qgutech.km.module.km.service;


import com.qgutech.km.base.ExecutionContext;
import org.apache.commons.lang.StringUtils;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.AnalyzerWrapper;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 全文搜索的管理类，用于为全文搜索类提供IndexWriter和IndexReader以及根据appCode提供索引文件的路径。
 *
 * @author ZhaoJie@HF
 * @version 1.0
 * @since 2014-05-19
 */
public class FullTextSearchManager {
    //分词器包装器（每个文档不同的属性用不同的分词器）。
    private AnalyzerWrapper analyzerWrapper;
    //搜索关键字的分词器。
    private Analyzer keywordAnalyzer;
    //全文搜索的索引文件的根路径。
    private String indexRootDir;
    //用于为每一个索引文件保存一个IndexReader的缓存
    private static final Map<String, IndexReader> iReaders = new HashMap<String, IndexReader>();
    //用于为每一个索引文件保存一个IndexWriter的缓存
    private static final Map<String, IndexWriter> iWriters = new HashMap<String, IndexWriter>();

    /**
     * 该方法根据索引根路径，应用编号，公司编号，得到索引文件路径。
     *
     * @param callerAppCode 调用者的应用编号（为哪个应用建立索引，如为km的知识建立索引，callerAppCode即为"km"）。
     * @return 索引文件路径（String类）。
     * @throws IllegalArgumentException 当入参callerAppCode为empty时。
     */

    public String getIndexPath(String callerAppCode) {
        if (StringUtils.isEmpty(callerAppCode)) {
            throw new IllegalArgumentException("callerAppCode is empty!");
        }

        String corpCode = ExecutionContext.getCorpCode();
        return indexRootDir + callerAppCode + "/" + corpCode;
    }

    /**
     * 这个方法用于根据索引文件的路径得到IndexWriter对象。
     *
     * @param path 索引文件路径。
     * @return IndexWriter对象。
     * @throws IOException              当创建Directory或IndexWriter对象失败时。
     * @throws IllegalArgumentException 当索引文件的路径为empty时。
     */

    public IndexWriter getIndexWriter(String path) throws IOException {
        if (StringUtils.isEmpty(path)) {
            throw new IllegalArgumentException("Index path is null!");
        }

        IndexWriter iWriter = iWriters.get(path);
        if (iWriter != null) {
            return iWriter;
        }

        synchronized (iWriters) {
            iWriter = iWriters.get(path);
            if (iWriter != null) {
                return iWriter;
            }

            //通过IndexWriterConfig的创建指定索引版本和语言词汇分析器。
            IndexWriterConfig indexWriterConfig = new IndexWriterConfig(Version.LUCENE_46, analyzerWrapper);
            //通过Directory的创建指定索引存放位置。
            Directory dir = FSDirectory.open(new File(path));
            //创建IndexWriter,它的作用是用来写索引文件。
            iWriter = new IndexWriter(dir, indexWriterConfig);
            //将新创建的IndexWriter缓存起来。
            iWriters.put(path, iWriter);
        }

        return iWriter;
    }

    /**
     * 这个方法用于根据索引文件的路径得到IndexSearcher对象。
     *
     * @param path 索引文件的路径。
     * @return IndexSearcher对象。
     * @throws IOException              当根据索引路径创建Directory或者创建IndexReader错误时。
     * @throws IllegalArgumentException 当索引文件的路径为empty时。
     */

    public IndexSearcher getIndexSearcher(String path) throws IOException {
        if (StringUtils.isEmpty(path)) {
            throw new IllegalArgumentException("Index path is null!");
        }

        IndexReader iReader = iReaders.get(path);
        if (iReader != null) {
            IndexReader indexReader = DirectoryReader.openIfChanged((DirectoryReader) iReader);
            if (indexReader == null) {
                return new IndexSearcher(iReader);
            }

            iReaders.put(path, indexReader);
            return new IndexSearcher(indexReader);
        }

        synchronized (iReaders) {
            iReader = iReaders.get(path);
            if (iReader == null) {
                Directory dir = FSDirectory.open(new File(path));
                iReader = DirectoryReader.open(dir);
                iReaders.put(path, iReader);
            }
        }

        return new IndexSearcher(iReader);
    }

    public AnalyzerWrapper getAnalyzerWrapper() {
        return analyzerWrapper;
    }

    public void setAnalyzerWrapper(AnalyzerWrapper analyzerWrapper) {
        this.analyzerWrapper = analyzerWrapper;
    }

    public Analyzer getKeywordAnalyzer() {
        return keywordAnalyzer;
    }

    public void setKeywordAnalyzer(Analyzer keywordAnalyzer) {
        this.keywordAnalyzer = keywordAnalyzer;
    }

    public String getIndexRootDir() {
        return indexRootDir;
    }

    public void setIndexRootDir(String indexRootDir) {
        this.indexRootDir = indexRootDir;
    }
}
