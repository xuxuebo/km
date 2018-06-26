/*
 * 文件名:KmFullTextSearchServiceImpl.java
 * 创建时间:2014-05-19
 * 版本:1.0
 * 版权所有:上海时代光华教育发展有限公司
 */
package com.qgutech.km.module.km.service;

import com.qgutech.fs.utils.FsFileManagerUtil;
import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.module.km.model.IndexKnowledge;
import com.qgutech.km.module.sfm.service.FileServerService;
import com.qgutech.km.utils.PropertiesUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.Term;
import org.apache.lucene.queries.TermFilter;
import org.apache.lucene.queryparser.classic.MultiFieldQueryParser;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.search.*;
import org.apache.lucene.util.Version;
import org.apache.poi.hslf.HSLFSlideShow;
import org.apache.poi.hslf.model.Slide;
import org.apache.poi.hslf.model.TextRun;
import org.apache.poi.hslf.usermodel.SlideShow;
import org.apache.tika.Tika;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;

/**
 * 资料中心（km）全文搜索的服务实现类（impl）。
 *
 * @author ZhaoJie@HF
 * @version 1.0
 * @since 2014-05-19
 */
@Service("kmFullTextSearchService")
public class KmFullTextSearchServiceImpl  implements KmFullTextSearchService {
    //索引文件的属性：知识主键
    private static final String DOC_FIELD_KNOWLEDGE_ID = "knowledgeId";
    //索引文件的属性：知识名称
    private static final String DOC_FIELD_KNOWLEDGE_NAME = "knowledgeName";
    //索引文件的属性：知识标签
    private static final String DOC_FIELD_TAGS = "tags";
    //索引文件的属性：知识简介
    private static final String DOC_FIELD_INTRODUCTION = "introduction";
    //索引文件的属性：知识内容
    private static final String DOC_FIELD_CONTENT = "content";
    //索引文件的属性：知识状态
    private static final String DOC_FIELD_STATUS = "status";
    //索引文件的属性：知识上传者的用户名
    private static final String DOC_FIELD_UPLOADER_USER_NAME = "uploaderUserName";
    //知识状态：启用
    private static final String DOC_FIELD_STATUS_ENABLE = "ENABLE";
    //km应用编号
    private static final String KM_APP_CODE = "km";
    //知识的类型为DOC
    private static final String KNOWLEDGE_TYPE_OF_DOC = "DOC";
    //知识的类型
    private static final String KNOWLEDGE_TYPE = "knowledgeType";
    //知识存储id
    private static final String STORED_FILE_ID = "storedFileId";
    //知识状态
    private static final String OPT_STATUS = "optStatus";
    //corpCode
    private static final String CORP_CODE = "corpCode";
    //知识索引增加成功标志
    private static final String KNOWLEDGE_ADD_FLAG_SUCCESS = "success";
    //知识索引增加失败标志
    private static final String KNOWLEDGE_ADD_FLAG_FAILED = "failed";
    //知识主键在redis中前缀
    private static final String KNOWLEDGE_ID_NAMESPACE = "sfm.fts.knowledge.id.namespace";
    //知识存储id在redis中前缀
    private static final String STORED_FILE_ID_NAMESPACE = "sfm.fts.stored.file.id.namespace";
    //记录日志
    public static final Log LOG = LogFactory.getLog(KmFullTextSearchServiceImpl.class);

    //全文搜索的管理类，用于获取IndexWriter和IndexReader
    @Resource
    private FullTextSearchManager fullTextSearchManager;
    //全文搜索的最大搜索数
    @Value("${km.max.search.count}")
    private int maxSearchCount;
//    //文件服务器管理对象
    private FileServerService fileServerManager;
//    //redis客户端
//    private JedisCommands jedis;
    //用于抽取文档内容
    @Resource
    private Tika tika;
    //调度者的调度名
    private String schedulerName;
    //被抽取内容的文件的临时目录
    private String extractedTempDir;

    @Override
    public void add(IndexKnowledge indexKnowledge) {
        checkKnowledge(indexKnowledge);
        add(Arrays.asList(indexKnowledge));
    }

    @Override
    public void add(List<IndexKnowledge> indexKnowledgeList) {
        if (CollectionUtils.isEmpty(indexKnowledgeList)) {
            throw new IllegalArgumentException("KnowledgeList is empty!");
        }

        boolean assign = false;
        List<String> corpCodeList = new ArrayList<String>();
        Map<String, List<IndexKnowledge>> corpKnowledgeListMap = new HashMap<String, List<IndexKnowledge>>();
        for (IndexKnowledge indexKnowledge : indexKnowledgeList) {
            try {
                checkKnowledge(indexKnowledge);
                String corpCode = indexKnowledge.getCorpCode();
//                if (!assign && indexKnowledge.isAssign()) {
//                    assign = true;
//                }

                if (KNOWLEDGE_TYPE_OF_DOC.equalsIgnoreCase(indexKnowledge.getKnowledgeType()) ) {
                    String content = getContent(corpCode, indexKnowledge.getStoredFileId(), null);
                    indexKnowledge.setContent(content);
                }

                if (!corpCodeList.contains(corpCode)) {
                    corpCodeList.add(corpCode);
                    List<IndexKnowledge> knowledgeList = new ArrayList<IndexKnowledge>();
                    knowledgeList.add(indexKnowledge);
                    corpKnowledgeListMap.put(corpCode, knowledgeList);
                    continue;
                }

                List<IndexKnowledge> knowledgeList = corpKnowledgeListMap.get(corpCode);
                knowledgeList.add(indexKnowledge);
                corpKnowledgeListMap.put(corpCode, knowledgeList);
            } catch (Exception e) {
                LOG.error("Knowledge" + indexKnowledge + " invalid when add index for it!");
            }
        }

        if (corpCodeList.size() == 0) {
            return;
        }

        String corpCode = ExecutionContext.getCorpCode();
        for (Map.Entry<String, List<IndexKnowledge>> entry : corpKnowledgeListMap.entrySet()) {
            String key = entry.getKey();
            List<IndexKnowledge> value = entry.getValue();
            ExecutionContext.setCorpCode(key);
            add(value, assign);
        }

        ExecutionContext.setCorpCode(corpCode);
    }

    private void add(List<IndexKnowledge> indexKnowledgeList, boolean assign) {
        IndexWriter iWriter = getIndexWriter();
        //doc类型并且不是来自redis和平台分配的知识主键列表（增加成功的）。
        List<String> knowledgeIdList = new ArrayList<String>(indexKnowledgeList.size());
        for (IndexKnowledge indexKnowledge : indexKnowledgeList) {
            try {
                Document document = convert(indexKnowledge);
                iWriter.addDocument(document);

                if (indexKnowledge.getKnowledgeType().equalsIgnoreCase(KNOWLEDGE_TYPE_OF_DOC)
                        && !indexKnowledge.isFromRedis() && !assign) {
                    Map<String, String> job = getKnowledgeMap(indexKnowledge);

                    knowledgeIdList.add(indexKnowledge.getKnowledgeId());
                }

            } catch (IOException e) {
                String msg = "Exception occurred when add the index for knowledge["
                        + "knowledgeId:" + indexKnowledge.getKnowledgeId()
                        + ",knowledgeName:" + indexKnowledge.getKnowledgeName()
                        + "]to the directory[" + fullTextSearchManager.getIndexPath(KM_APP_CODE) + "]"
                        + ",during this process," + "knowledgeList size is[" + indexKnowledgeList.size()
                        + "],corpCode is[" + ExecutionContext.getCorpCode() + "]and appCode is[" + KM_APP_CODE + "]!";
                LOG.error(msg, e);
            }
        }

        boolean flag = true;//表示commit是否成功。
        try {
            iWriter.commit();
        } catch (IOException e) {
            flag = false;
            String msg = "Exception occurred when commit the index data to the directory ["
                    + fullTextSearchManager.getIndexPath(KM_APP_CODE) + " ],during this process,"
                    + "knowledgeList size is[" + indexKnowledgeList.size() + "],corpCode is["
                    + ExecutionContext.getCorpCode() + "]and appCode is[" + KM_APP_CODE + "]!";
            LOG.error(msg, e);
            throw new RuntimeException(msg, e);
        } finally {
            String knowledgeAddFlag;
            if (flag) {
                knowledgeAddFlag = KNOWLEDGE_ADD_FLAG_SUCCESS;
            } else {
                knowledgeAddFlag = KNOWLEDGE_ADD_FLAG_FAILED;
            }

//            for (String knowledgeId : knowledgeIdList) {
//                jedis.set(KNOWLEDGE_ID_NAMESPACE + knowledgeId, knowledgeAddFlag);
//            }
        }
    }

    @Override
    public void update(IndexKnowledge indexKnowledge) {
        checkKnowledge(indexKnowledge);
        update(Arrays.asList(indexKnowledge));
    }

    @Override
    public void update(List<IndexKnowledge> indexKnowledgeList) {
        if (CollectionUtils.isEmpty(indexKnowledgeList)) {
            throw new IllegalArgumentException("KnowledgeList is empty!");
        }

        IndexWriter iWriter = getIndexWriter();
        for (IndexKnowledge indexKnowledge : indexKnowledgeList) {
            try {
                checkKnowledge(indexKnowledge);
                if (KNOWLEDGE_TYPE_OF_DOC.equalsIgnoreCase(indexKnowledge.getKnowledgeType())
                        && !indexKnowledge.isFromRedis()) {
                    String content = this.getContent(indexKnowledge.getCorpCode(),
                            indexKnowledge.getStoredFileId(), null);
                    indexKnowledge.setContent(content);
                }

                Document document = convert(indexKnowledge);
                iWriter.updateDocument(new Term(DOC_FIELD_KNOWLEDGE_ID, indexKnowledge.getKnowledgeId()), document);

            } catch (IOException e) {
                String msg = "Exception occurred when update the index of knowledge["
                        + "knowledgeId:" + indexKnowledge.getKnowledgeId() + ",knowledgeName:" + indexKnowledge.getKnowledgeName()
                        + "]in the directory[" + fullTextSearchManager.getIndexPath(KM_APP_CODE) + "]"
                        + ",during this process," + "knowledgeList size is[" + indexKnowledgeList.size()
                        + "],corpCode is[" + ExecutionContext.getCorpCode() + "]and appCode is[" + KM_APP_CODE + "]!";
                LOG.error(msg, e);
            } catch (Exception e) {
                LOG.error("Knowledge updated index failed!", e);
            }
        }

        try {
            iWriter.commit();
        } catch (IOException e) {
            String msg = "Exception occurred when commit the index data to the directory ["
                    + fullTextSearchManager.getIndexPath(KM_APP_CODE) + " ],during this process,"
                    + "knowledgeList size is[" + indexKnowledgeList.size() + "],corpCode is["
                    + ExecutionContext.getCorpCode() + "]and appCode is[" + KM_APP_CODE + "]!";
            LOG.error(msg, e);
            throw new RuntimeException(msg, e);
        }
    }

    @Override
    public void delete(String knowledgeId) {
        if (StringUtils.isEmpty(knowledgeId)) {
            throw new IllegalArgumentException("KnowledgeId is empty!");
        }

        IndexWriter iWriter = getIndexWriter();
        try {
            iWriter.deleteDocuments(new Term(DOC_FIELD_KNOWLEDGE_ID, knowledgeId));
            iWriter.commit();
        } catch (IOException e) {
            String msg = "Exception occurred when delete the index of knowledge[" + knowledgeId + "] from "
                    + "directory[" + fullTextSearchManager.getIndexPath(KM_APP_CODE) + "],during this process"
                    + ",corpCode is[" + ExecutionContext.getCorpCode() + "]and appCode is[" + KM_APP_CODE + "]!";
            LOG.error(msg, e);
            throw new RuntimeException(msg, e);
        }
    }

    private File bakFile(String indexPath) throws IOException {
        File indexFile = new File(indexPath);
        int endRam = ((int) (Math.random() * 10000)) + 1;
        File bakFile = new File(indexPath + ".bak" + endRam);

        if (indexFile.exists()) {
            if (!indexFile.renameTo(bakFile)) {
                if (!bakFile.mkdirs()) {
                    String message = "Unable to create directory " + indexPath + ".bak" + endRam + "!";
                    throw new IOException(message);
                }
                FileUtils.copyDirectory(indexFile, bakFile);
                FileUtils.deleteDirectory(indexFile);
            }
        }

        if (!indexFile.mkdirs()) {
            String message = "Unable to create directory " + indexPath + "!";
            throw new IOException(message);
        }

        return bakFile;
    }

    @Override
    public void rebuild(List<IndexKnowledge> indexKnowledgeList) {
        if (CollectionUtils.isEmpty(indexKnowledgeList)) {
            throw new IllegalArgumentException("KnowledgeList is empty!");
        }

        File bakFile;
        String indexPath = fullTextSearchManager.getIndexPath(KM_APP_CODE);
        File indexFile = new File(indexPath);
        try {
            bakFile = bakFile(indexPath);
        } catch (IOException e) {
            String msg = "Exception occurred when backup the index directory [" + indexPath + "]!";
            LOG.error(msg, e);
            throw new RuntimeException(msg, e);
        }

        IndexWriter iWriter = getIndexWriter();
        try {
            for (IndexKnowledge indexKnowledge : indexKnowledgeList) {
                checkKnowledge(indexKnowledge);
                if (KNOWLEDGE_TYPE_OF_DOC.equalsIgnoreCase(indexKnowledge.getKnowledgeType())) {
                    String content = getContent(indexKnowledge.getCorpCode(), indexKnowledge.getStoredFileId(), null);
                    indexKnowledge.setContent(content);
                }

                Document document = convert(indexKnowledge);
                iWriter.addDocument(document);
            }

            iWriter.commit();
            bakFile.delete();

        } catch (Exception e) {
            indexFile.delete();
            bakFile.renameTo(indexFile);

            String msg = "Exception occurred when rebuild the index directory [" + indexPath + "]!";
            LOG.error(msg, e);
            throw new RuntimeException(msg, e);
        }
    }

    /**
     * 该方法是用于处理全文搜索分页对象。
     * <ul>
     * <li>如果fullTestSearchPage为null，重新生成一个新的分页对象。</li>
     * <li>如果分页对象的属性页数小于等于0，将其设为1。</li>
     * <li>如果分页对象的属性页面记录数小于等于0，将其设为10。</li>
     * </ul>
     *
     * @param fullTestSearchPage 全文搜索分页对象（用于存储知识的主键）。
     * @return 已处理的全文搜索分页对象。
     */
    private Page<String> processPage(Page<String> fullTestSearchPage) {
        if (fullTestSearchPage == null) {
            fullTestSearchPage = new Page<String>();
        }

//        if (fullTestSearchPage.getPageNo() <= 0) {
//            fullTestSearchPage.setPageNo(1);
//        }

        if (fullTestSearchPage.getPageSize() <= 0) {
            fullTestSearchPage.setPageSize(10);
        }

        return fullTestSearchPage;
    }

    @Override
    public Page<String> search(String keyword, Page<String> page) {
        if (StringUtils.isEmpty(keyword)) {
            return page;
        }
        page = processPage(page);

        try {
            Query query = getQuery(keyword);
            IndexSearcher iSearcher = getIndexSearcher();
            Filter filter = new TermFilter(new Term(DOC_FIELD_STATUS, DOC_FIELD_STATUS_ENABLE));
            TopDocs topDocs = iSearcher.search(query, filter, maxSearchCount);
            if (topDocs == null) {
                return page;
            }

            ScoreDoc[] scoreDocs = topDocs.scoreDocs;
            if (scoreDocs.length == 0) {
                return page;
            }

            List<String> ids = new ArrayList<String>(scoreDocs.length);
            for (ScoreDoc scoreDoc : scoreDocs) {
                Document doc = iSearcher.doc(scoreDoc.doc);
                ids.add(doc.get(DOC_FIELD_KNOWLEDGE_ID));
            }

            setPage(ids, page);
            return page;
        } catch (IOException e) {
            String msg = "Exception occurred when searching doc with condition[" + keyword + "]!";
            LOG.error(msg, e);
            throw new RuntimeException(msg, e);
        }
    }

    /**
     * 这个方法用于根据获得的满足条件的知识id列表以及当前分页对象的信息，设置分页对象中的总记录数和分页数据（知识的id）。
     * <p/>
     * <ul>
     * <li>如果分页对象的首页大于总记录数加1，不设置。</li>
     * <li>如果分页对象的页大小小于剩下的知识id的个数（总记录数-首页+1）
     * ，当前rows的个数为page.getPageSize()，否则为剩下的知识id的个数，总数为ids.size()。</li>
     * </ul>
     *
     * @param ids  知识主键的列表。
     * @param page 当前分页对象。
     */

    private void setPage(List<String> ids, Page<String> page) {
        int count = ids.size() - page.getFirst() + 1;
        if (count <= 0) {
            return;
        }

        if (page.getPageSize() < count) {
            count = page.getPageSize();
        }

        List<String> rows = new ArrayList<String>(count);
        for (int i = page.getFirst() - 1; i < page.getFirst() - 1 + count; i++) {
            rows.add(ids.get(i));
        }

        page.setTotal(ids.size());
        page.setRows(rows);
    }

    /**
     * 这个方法用于根据搜索关键字创建lucene的Query对象。
     * <p/>
     * 与关键字相匹配的文件域有知识的简介，知识的内容，知识的标签，知识的名称和知识的作者，它们之间的关系为或的关系。
     *
     * @param keyword 搜索关键字。
     * @return lucene的Query对象。
     */
    private Query getQuery(String keyword) {
        //需要查询的文件的域
        String[] fields = {DOC_FIELD_INTRODUCTION, DOC_FIELD_CONTENT,
                DOC_FIELD_TAGS, DOC_FIELD_KNOWLEDGE_NAME, DOC_FIELD_UPLOADER_USER_NAME};
        //文件域的必要性。SHOULD为或关系，MUST为和关系
        BooleanClause.Occur[] flags = {BooleanClause.Occur.SHOULD, BooleanClause.Occur.SHOULD,
                BooleanClause.Occur.SHOULD, BooleanClause.Occur.SHOULD,
                BooleanClause.Occur.SHOULD};
        //文件域的值
        String[] conditionValues = {keyword, keyword, keyword, keyword, keyword};

        try {
            Analyzer keywordAnalyzer = fullTextSearchManager.getKeywordAnalyzer();
            return MultiFieldQueryParser.parse(Version.LUCENE_46,
                    conditionValues, fields, flags, keywordAnalyzer);
        } catch (ParseException e) {
            String msg = "Exception occurred when creating a multiple field query with search condition[" + keyword + "]!";
            LOG.error(msg, e);
            throw new RuntimeException(msg, e);
        }
    }

    /**
     * 这个方法用于将知识对象转化为lucene中的Document对象。
     * <p/>
     * <b>以下是Document对象的域以及域的存储，分词，索引和权值分配情况：</b>
     * <ul>
     * <li>知识的主键knowledgeId，存储，不分词，索引，没有权值分配。</li>
     * <li>知识的名称knowledgeName，不存储，分词，索引，权值为0.2f。</li>
     * <li>知识的标签tags，不存储，分词，索引，权值为0.3f。</li>
     * <li>知识的简介introduction，不存储，分词，索引，权值为0.1f。</li>
     * <li>知识的内容content，不存储，分词，索引，权值为0.1f。</li>
     * <li>知识的上传者用户名uploaderUserName，不存储，分词，索引，权值为0.3f。</li>
     * <li>知识的状态status，不存储，不分词，索引，没有权值分配。</li>
     * </ul>
     *
     * @param indexKnowledge 知识对象。
     * @return lucene中的Document对象
     */
    private Document convert(IndexKnowledge indexKnowledge) {
        String content = StringUtils.trimToEmpty(indexKnowledge.getContent());

        Document doc = new Document();
        doc.add(new StringField(DOC_FIELD_KNOWLEDGE_ID, indexKnowledge.getKnowledgeId(), Field.Store.YES));

        TextField knowledgeNameField = new TextField(DOC_FIELD_KNOWLEDGE_NAME,
                indexKnowledge.getKnowledgeName(), TextField.Store.NO);
        knowledgeNameField.setBoost(0.433f);
        doc.add(knowledgeNameField);

        TextField tagsField = new TextField(DOC_FIELD_TAGS, indexKnowledge.getTags().replace(",", " "), TextField.Store.NO);
        tagsField.setBoost(0.0866f);
        doc.add(tagsField);

        TextField introductionField = new TextField(DOC_FIELD_INTRODUCTION, indexKnowledge.getIntroduction(), TextField.Store.NO);
        introductionField.setBoost(0.0433f);
        doc.add(introductionField);

        TextField contentField = new TextField(DOC_FIELD_CONTENT, content, TextField.Store.NO);
        contentField.setBoost(0.0041f);
        doc.add(contentField);

        Field uploaderUserNameField = new TextField(DOC_FIELD_UPLOADER_USER_NAME
                , indexKnowledge.getUploaderUserName(), TextField.Store.NO);
        uploaderUserNameField.setBoost(0.433f);
        doc.add(uploaderUserNameField);

        doc.add(new StringField(DOC_FIELD_STATUS, indexKnowledge.getOptStatus(), Field.Store.NO));

        return doc;
    }

    /**
     * 这个方法用于根据公司编号，知识对应文件的存储id和知识所在的主机名（或ip）和端口，获得知识对应文件的内容，
     * 当抽取内容的过程中出现任何异常，返回""。
     * <p/>
     * <ul>
     * <li>如果hostAndPort为empty，根据corpCode和storedFileId，随机抽取文档服务器
     * ，获得知识在文档服务器上的链接，然后根据该链接读取文档内容。</li>
     * <li>如果hostAndPort不为empty，用hostAndPort替换链接中的主机名（或ip）和端口，然后根据该链接读取文档内容。</li>
     * </ul>
     *
     * @param corpCode     公司编码。
     * @param storedFileId 知识对应文件的存储id。
     * @param hostAndPort  知识所在的主机名（或ip）和端口。
     * @return 知识对应文档的内容。
     */
    private String getContent(String corpCode, String storedFileId, String hostAndPort) {
        String fileUrl = FsFileManagerUtil.getFileUrl(PropertiesUtils.getConfigProp().getProperty("fs.server.host"),storedFileId, UUID.randomUUID().toString());

        if (StringUtils.isNotEmpty(hostAndPort)) {
            int start = fileUrl.indexOf("//") + 2;
            int end = fileUrl.indexOf("/", start);
            fileUrl = fileUrl.replace(fileUrl.substring(start, end), hostAndPort);
        }

        URL url = null;
        try {
            url = new URL(fileUrl);
            return tika.parseToString(url);
        } catch (MalformedURLException e) {
            LOG.error("Format of url[" + fileUrl + "] is malformed!", e);
        } catch (Exception e) {
            String content = extractCompatibleMode(url);
            if (StringUtils.isNotEmpty(content)) {
                return content;
            }

            LOG.error("Tika extracts content of url[" + fileUrl + "] failed!", e);
        }

        return StringUtils.EMPTY;
    }

    /**
     * 抽取兼容模式文档的内容。
     *
     * @param url 知识的资源定位符。
     * @return 知识对应文档的内容。
     */
    private String extractCompatibleMode(URL url) {
        File tempFile = null;
        OutputStream os = null;
        InputStream is = null;
        try {
            File tempDir = new File(extractedTempDir);
            if (!tempDir.exists()) {
                tempDir.mkdirs();
            }

            tempFile = new File(tempDir, "" + ((int) (Math.random() * 100000000) + 1));
            tempFile.createNewFile();
            os = new FileOutputStream(tempFile);
            is = url.openStream();

            byte[] buffer = new byte[1024];
            int len;
            while ((len = is.read(buffer)) != -1) {
                os.write(buffer, 0, len);
            }

            os.flush();
            return tika.parseToString(tempFile);
        } catch (Exception e) {
            String content = getPPT2003Text(tempFile);
            if (!StringUtils.isEmpty(content)) {
                return content;
            }

            LOG.error("Tika extracts compatible mode file's content of url[" + url.toString() + "]failed!", e);
        } finally {
            IOUtils.closeQuietly(os);
            IOUtils.closeQuietly(is);
            FileUtils.deleteQuietly(tempFile);
        }

        return StringUtils.EMPTY;
    }

    /**
     * 抽取2003格式的ppt的内容。
     *
     * @param pptFile ppt文件对象。
     * @return ppt文件的内容。
     */
    private String getPPT2003Text(File pptFile) {
        String content = StringUtils.EMPTY;
        InputStream is = null;
        try {
            is = new FileInputStream(pptFile);
            SlideShow slideShow = new SlideShow(new HSLFSlideShow(is));
            Slide[] slides = slideShow.getSlides();
            for (Slide slide : slides) {
                TextRun[] textRuns = slide.getTextRuns();
                for (TextRun textRun : textRuns) {
                    content += StringUtils.trimToEmpty(textRun.getText());
                }

                content += StringUtils.trimToEmpty(slide.getTitle());
            }
        } catch (Exception e) {
            LOG.error("Extracting content of ppt[2003] failed!", e);
        } finally {
            IOUtils.closeQuietly(is);
        }

        return content;
    }


    /**
     * 这个方法用于将知识的属性与值的map转化为knowledge对象。其中以"__"开头的属性名忽略。
     *
     * @param knowledgeMap key为知识的属性名，value为知识的属性值。
     * @return 知识对象。
     */
    private IndexKnowledge toKnowledge(Map<String, String> knowledgeMap) {
        IndexKnowledge indexKnowledge = new IndexKnowledge();
        for (Map.Entry<String, String> entry : knowledgeMap.entrySet()) {
            String key = entry.getKey();
            if (key.startsWith("__")) {
                continue;
            }

            String value = entry.getValue();
        }

        return indexKnowledge;
    }

    /**
     * 这个方法用于得到lucene的IndexWriter对象。
     * <p/>
     * 该方法首先根据appCode得到当前的索引文件路径，再根据路径得到IndexWriter对象。
     *
     * @return lucene的IndexWriter对象。
     */
    private IndexWriter getIndexWriter() {
        String path = fullTextSearchManager.getIndexPath(KM_APP_CODE);
        IndexWriter indexWriter;
        try {
            indexWriter = fullTextSearchManager.getIndexWriter(path);
        } catch (IOException e) {
            String msg = "Exception occurred when get the IndexWriter object of lucene by appCode[" + KM_APP_CODE + "]!";
            LOG.error(msg, e);
            throw new RuntimeException(msg, e);
        }

        return indexWriter;
    }

    /**
     * 这个方法用于得到lucene的IndexSearcher对象。
     * <p/>
     * 该方法首先根据appCode得到当前的索引文件路径，再根据路径得到IndexSearcher对象。
     *
     * @return lucene的IndexSearcher对象。
     */
    private IndexSearcher getIndexSearcher() {
        String indexPath = fullTextSearchManager.getIndexPath(KM_APP_CODE);
        try {
            return fullTextSearchManager.getIndexSearcher(indexPath);
        } catch (IOException e) {
            String msg = "Exception occurred when get the IndexSearcher object of lucene by appCode[" + KM_APP_CODE + "]!";
            LOG.error(msg, e);
            throw new RuntimeException(msg, e);
        }
    }

    /**
     * 校验知识，检查知识以及知识的属性是否合法。
     * <p/>
     * <ul>
     * <li>当知识的属性content为null，将其设为""。</li>
     * <li>当知识的属性uploaderUserName为null，将其设为""。</li>
     * <li>当知识的属性introduction为null，将其设为""。</li>
     * <li>当知识的属性tags为null，将其设为""。</li>
     * </ul>
     *
     * @param indexKnowledge 知识对象。
     * @throws IllegalArgumentException <ul>
     *                                  <li>当知识为null时。</li>
     *                                  <li>当知识的属性knowledgeId为empty。</li>
     *                                  <li>当知识的属性knowledgeName为empty。</li>
     *                                  <li>当知识的属性knowledgeType为empty。</li>
     *                                  <li>当知识的属性optStatus为empty。</li>
     *                                  <li>当知识的属性storedFileId为empty。</li>
     *                                  <li>当知识的属性corpCode为empty。</li>
     *                                  </ul>
     */
    private void checkKnowledge(IndexKnowledge indexKnowledge) {
        if (indexKnowledge == null) {
            throw new IllegalArgumentException("Knowledge is null!");
        }

        if (StringUtils.isEmpty(indexKnowledge.getKnowledgeId())) {
            throw new IllegalArgumentException("KnowledgeId is empty!");
        }

        if (StringUtils.isEmpty(indexKnowledge.getKnowledgeName())) {
            throw new IllegalArgumentException("KnowledgeName is empty!");
        }

        if (StringUtils.isEmpty(indexKnowledge.getKnowledgeType())) {
            throw new IllegalArgumentException("KnowledgeType is empty!");
        }

        if (StringUtils.isEmpty(indexKnowledge.getOptStatus())) {
            throw new IllegalArgumentException("OptStatus is empty!");
        }

        if (StringUtils.isEmpty(indexKnowledge.getStoredFileId())
                && KNOWLEDGE_TYPE_OF_DOC.equalsIgnoreCase(indexKnowledge.getKnowledgeType())) {
            throw new IllegalArgumentException("StoredFileId is empty!");
        }

        if (StringUtils.isEmpty(indexKnowledge.getCorpCode())) {
            throw new IllegalArgumentException("CorpCode is empty!");
        }

        if (indexKnowledge.getContent() == null) {
            indexKnowledge.setContent(StringUtils.EMPTY);
        }

        if (indexKnowledge.getUploaderUserName() == null) {
            indexKnowledge.setUploaderUserName(StringUtils.EMPTY);
        }

        if (indexKnowledge.getIntroduction() == null) {
            indexKnowledge.setIntroduction(StringUtils.EMPTY);
        }

        if (indexKnowledge.getTags() == null) {
            indexKnowledge.setTags(StringUtils.EMPTY);
        }
    }

    /**
     * 将知识对象转化为属性名和属性值的map。
     *
     * @param indexKnowledge 知识对象。
     * @return knowledgeMap 知识对象的属性名和属性值的映射。
     */
    private Map<String, String> getKnowledgeMap(IndexKnowledge indexKnowledge) {
        Map<String, String> knowledgeMap = new HashMap<String, String>(10);
        knowledgeMap.put(KNOWLEDGE_TYPE, indexKnowledge.getKnowledgeType());
        knowledgeMap.put(DOC_FIELD_CONTENT, indexKnowledge.getContent());
        knowledgeMap.put(DOC_FIELD_KNOWLEDGE_ID, indexKnowledge.getKnowledgeId());
        knowledgeMap.put(STORED_FILE_ID, indexKnowledge.getStoredFileId());
        knowledgeMap.put(DOC_FIELD_KNOWLEDGE_NAME, indexKnowledge.getKnowledgeName());
        knowledgeMap.put(OPT_STATUS, indexKnowledge.getOptStatus());
        knowledgeMap.put(CORP_CODE, indexKnowledge.getCorpCode());
        knowledgeMap.put(DOC_FIELD_INTRODUCTION, indexKnowledge.getIntroduction());
        knowledgeMap.put(DOC_FIELD_TAGS, indexKnowledge.getTags());
        knowledgeMap.put(DOC_FIELD_UPLOADER_USER_NAME, indexKnowledge.getUploaderUserName());

        return knowledgeMap;
    }

    public FullTextSearchManager getFullTextSearchManager() {
        return fullTextSearchManager;
    }

    public void setFullTextSearchManager(FullTextSearchManager fullTextSearchManager) {
        this.fullTextSearchManager = fullTextSearchManager;
    }

    public int getMaxSearchCount() {
        return maxSearchCount;
    }

    public void setMaxSearchCount(int maxSearchCount) {
        this.maxSearchCount = maxSearchCount;
    }

//    public JedisCommands getJedis() {
//        return jedis;
//    }
//
//    public void setJedis(JedisCommands jedis) {
//        this.jedis = jedis;
//    }

    public Tika getTika() {
        return tika;
    }

    public void setTika(Tika tika) {
        this.tika = tika;
    }

    public String getExtractedTempDir() {
        return extractedTempDir;
    }

    public void setExtractedTempDir(String extractedTempDir) {
        this.extractedTempDir = extractedTempDir;
    }
}
