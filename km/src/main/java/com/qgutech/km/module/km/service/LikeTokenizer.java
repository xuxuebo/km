/*
 * 文件名:LikeTokenizer.java
 * 创建时间:2014-06-20
 * 版本:1.0
 * 版权所有:上海时代光华教育发展有限公司
 */
package com.qgutech.km.module.km.service;


import org.apache.commons.io.IOUtils;
import org.apache.lucene.analysis.Tokenizer;
import org.apache.lucene.analysis.tokenattributes.CharTermAttribute;
import org.apache.lucene.analysis.tokenattributes.OffsetAttribute;
import org.apache.lucene.analysis.tokenattributes.PositionIncrementAttribute;

import java.io.IOException;
import java.io.Reader;

/**
 * 类似数据库的like搜索的Tokenizer，用于对输入流分词，产生语汇单元。
 * <p/>
 * 例如，“中国人”会被分词为：“中”，“中国”，“中国人”，“国”，“国人”，“人”。
 *
 * @author ZhaoJie@HF
 * @version 1.0
 * @since 2014-06-20
 */
public final class LikeTokenizer extends Tokenizer {

    private final OffsetAttribute offsetAttribute;
    private final CharTermAttribute charTermAttribute;
    private final PositionIncrementAttribute positionIncrementAttribute;

    private String content;

    private int wordStart;
    private int wordEnd;
    private int offset;


    public LikeTokenizer(Reader reader) {
        super(reader);
        offsetAttribute = addAttribute(OffsetAttribute.class);
        charTermAttribute = addAttribute(CharTermAttribute.class);
        positionIncrementAttribute = addAttribute(PositionIncrementAttribute.class);
    }

    @Override
    public boolean incrementToken() throws IOException {
        clearAttributes();
        if (content == null || wordStart >= content.length()) {
            return false;
        }

        String word = content.substring(wordStart, wordEnd);
        int length = word.length();
        charTermAttribute.append(word);
        positionIncrementAttribute.setPositionIncrement(1);
        offsetAttribute.setOffset(offset, offset + length);

        offset = offset + length + 1;
        wordEnd++;

        if (wordEnd > content.length()) {
            wordStart++;
            wordEnd = wordStart + 1;
        }

        return true;
    }

    @Override
    public void reset() throws IOException {
        super.reset();
        resetTokenVars();
        content = IOUtils.toString(input);
    }

    private void resetTokenVars() {
        offset = 0;
        wordStart = 0;
        wordEnd = 1;
    }
}
