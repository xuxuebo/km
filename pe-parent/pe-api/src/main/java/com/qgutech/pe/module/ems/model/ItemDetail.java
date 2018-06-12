package com.qgutech.pe.module.ems.model;

import com.qgutech.pe.base.model.BaseModel;
import com.qgutech.pe.module.ems.vo.Ic;
import org.hibernate.annotations.Type;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

/**
 * 试题表
 */
@Entity
@Table(name = "t_ems_item_detail", indexes = {
        @Index(name = "i_ems_item_detail_corpCode", columnList = "corpCode")
})
public class ItemDetail extends BaseModel {

    public static final String _itemContent = "ics";

    @Type(type = "com.qgutech.pe.utils.CompressType", parameters = {
            @org.hibernate.annotations.Parameter(name = "clazzName",
                    value = "com.qgutech.pe.module.ems.vo.Ic")})
    @Column(name = "item_detail", nullable = false)
    private Ic ics;

    public Ic getIcs() {
        return ics;
    }

    public void setIcs(Ic ics) {
        this.ics = ics;
    }
}
