package com.fp.cloud.base;

import org.junit.BeforeClass;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

@ContextConfiguration(locations = {"classpath:spring-config/spring-*.xml"})
public class BaseTests extends AbstractTransactionalJUnit4SpringContextTests {

    @BeforeClass
    public static void beforeClass() throws Exception {
        init();
    }

    /**
     * 设置线程变量
     */
    protected static void init() {
        ExecutionContext.setUserId("tao_fa_deng");
        ExecutionContext.setCorpCode("default");
    }
}
