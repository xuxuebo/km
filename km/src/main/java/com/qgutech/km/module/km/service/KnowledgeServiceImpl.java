package com.qgutech.km.module.km.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Page;
import com.qgutech.km.base.model.PageParam;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.constant.KnowledgeConstant;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.module.km.model.*;
import com.qgutech.km.module.sfm.model.PeFile;
import com.qgutech.km.module.sfm.service.FileServerService;
import com.qgutech.km.module.uc.model.Organize;
import com.qgutech.km.module.uc.model.User;
import com.qgutech.km.module.uc.model.UserPosition;
import com.qgutech.km.module.uc.model.UserRole;
import com.qgutech.km.utils.PeDateUtils;
import com.qgutech.km.utils.PeException;
import com.qgutech.km.utils.PropertiesUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service("knowledgeService")
public class KnowledgeServiceImpl extends BaseServiceImpl<Knowledge> implements KnowledgeService {

    @Resource
    private LibraryService libraryService;
    @Resource
    private KnowledgeRelService knowledgeRelService;
    @Resource
    private ShareService shareService;

    @Resource
    private StatisticService statisticService;

    /**
     * 获取个人云库文件列表
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public List<Knowledge> getKnowledgeByCreateBy(String libraryType) {
        List<Knowledge> knowledgeList = new ArrayList<>();

        //添加id in
        List<String> knowledgeIds = new ArrayList<>();
        //查询我的个人库的id
        Library library = libraryService.getUserLibraryByLibraryType(libraryType);
        if(library==null){
            return new ArrayList<>(0);
        }
        //查询云库里面所有文件id
        List<KnowledgeRel> knowledgeRelList = knowledgeRelService.findByLibraryId(library.getId());
        if(CollectionUtils.isEmpty(knowledgeRelList)){
            return new ArrayList<>(0);
        }
        //取我的云库里面所有文件id
        for(KnowledgeRel k : knowledgeRelList){
            knowledgeIds.add(k.getKnowledgeId());
        }
        Criterion criterion = Restrictions.and(
                Restrictions.eq(Knowledge.CORP_CODE, ExecutionContext.getCorpCode()),
                Restrictions.ne(Knowledge.CREATE_BY, ExecutionContext.getUserId()),
                Restrictions.in(Knowledge.ID,knowledgeIds)
                );
        knowledgeList = listByCriterion((criterion),
                new Order[]{Order.asc(Knowledge.CREATE_TIME)});
        return knowledgeList;
    }

    @Override
    @Transactional(readOnly = false)
    public int shareToPublic(Share share) {
        if(null==share || StringUtils.isEmpty(share.getKnowledgeId())||StringUtils.isEmpty(share.getShareLibraryId())){
            return 0;
        }
        //保存公共库
        KnowledgeRel knowledgeRel = new KnowledgeRel();
        knowledgeRel.setKnowledgeId(share.getKnowledgeId());
        knowledgeRel.setLibraryId(share.getShareLibraryId());
        String knowledgeRelId = knowledgeRelService.save(knowledgeRel);
        //保存分享记录
        share.setShareType(KnowledgeConstant.SHARE_NO_PASSWORD);
        share.setExpireTime(KnowledgeConstant.SHARE_PERMANENT_VALIDITY);
        String shareId = shareService.save(share);
        //保存共享统计记录
        Statistic statistic = new Statistic(shareId,0,0,0);
        statisticService.save(statistic);
        return 1;
    }
}
