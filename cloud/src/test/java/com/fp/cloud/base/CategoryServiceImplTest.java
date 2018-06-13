package com.fp.cloud.base;

import com.fp.cloud.base.model.Category;
import com.fp.cloud.base.service.CategoryService;
import org.junit.Test;
import org.springframework.test.annotation.Rollback;

import javax.annotation.Resource;


public class CategoryServiceImplTest extends BaseTests {
    @Resource
    private CategoryService categoryService;

    @Test
    public void testDelte() {
        categoryService.delete("a6dc7e13abfb48e49b17ca234877090d", Category.CategoryEnumType.KNOWLEDGE);
    }

    @Test
    @Rollback(false)
    public void insertKnowledgeCategory() {
        String rootId = "a6dc7e13abfb48e49b17ca234877090d";
        Category category = new Category();
        category.setCategoryName("一级类别");
        category.setCategoryType(Category.CategoryEnumType.KNOWLEDGE);
        category.setParentId(rootId);
        categoryService.save(category);
    }
}
