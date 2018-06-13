package com.fp.cloud.module.uc;

import com.fp.cloud.module.uc.model.Organize;
import com.fp.cloud.module.uc.service.OrganizeService;
import com.fp.cloud.base.BaseTests;
import org.junit.Test;
import org.springframework.test.annotation.Rollback;

import javax.annotation.Resource;


public class OrganizeServiceImplTest extends BaseTests {
    @Resource
    private OrganizeService organizeService;

    @Test
//    @Rollback(false)
    public void testSave() {
        Organize organize = new Organize();
        organize.setOrganizeName("一级部门1.3");
        organize.setParentId("4028819d57a3b2d10157a3b2e0fd0000");
        organizeService.save(organize);
    }

    @Test
//    @Rollback(false)
    public void testUpdate() {
        Organize organize = new Organize();
        organize.setOrganizeName("一级部门1.2");
        organize.setParentId("4028819d57a3b2d10157a3b2e0fd0000");
        organize.setId("40288119580a554e01580a5555fe0000");
        organizeService.update(organize);
    }

    @Test
//    @Rollback(false)
    public void testDelete() {
        organizeService.delete("40288119580a554e01580a5555fe0000");
    }

    @Test
    public void testListOrganizeId(){
        organizeService.listOrganizeId("40288119580a554e01580a5555fe0000");
    }

    @Test
    @Rollback(false)
    public void testMoveLevel(){
        organizeService.moveLevel("40288119580a554e01580a5555fe0000",true);
    }

    @Test
    public void testSearch() {

    }
}
