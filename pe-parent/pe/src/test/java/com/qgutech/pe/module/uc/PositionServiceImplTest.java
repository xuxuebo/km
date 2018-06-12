package com.qgutech.pe.module.uc;

import com.qgutech.pe.base.BaseTests;
import com.qgutech.pe.base.model.Category;
import com.qgutech.pe.base.model.PageParam;
import com.qgutech.pe.module.uc.model.Position;
import com.qgutech.pe.module.uc.service.PositionService;
import org.junit.Test;

import javax.annotation.Resource;


public class PositionServiceImplTest extends BaseTests {
    @Resource
    private PositionService positionService;

    @Test
//    @Rollback(false)
    public void testSave() {
        Position position = new Position();
        Category category = new Category();
        category.setId("4028811b580402ee01580402f57e0000");
        position.setCategory(category);
        position.setPositionName("一级岗位1.2");
        positionService.save(position);
    }

    @Test
//    @Rollback(false)
    public void testUpdate() {
        Position position = new Position();
        Category category = new Category();
        category.setId("4028811b580402ee01580402f57e0000");
        position.setCategory(category);
        position.setPositionName("一级岗位1.2");
        position.setId("4028811b58050e7b0158050e87040000");
        positionService.update(position);
    }

    @Test
    public void testSearch() {
        PageParam page = new PageParam();
        page.setPage(1);
        page.setPageSize(10);
        page.setSort(Position._updateTime);
        page.setOrder(PageParam.SortOrder.asc);
        Position position = new Position();
        Category category = new Category();
        category.setId("4028811b580402ee01580402f57e0000");
        position.setCategory(category);
        positionService.search(position, page);
    }
}
