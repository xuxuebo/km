package com.qgutech.km.module.uc.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.service.BaseServiceImpl;
import com.qgutech.km.base.vo.PeTreeNode;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.module.uc.model.Organize;
import com.qgutech.km.module.uc.model.User;
import com.qgutech.km.utils.PeException;
import com.qgutech.km.base.service.I18nService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

@Service("organizeService")
public class OrganizeServiceImpl extends BaseServiceImpl<Organize> implements OrganizeService {
    @Resource
    private I18nService i18nService;
    @Resource
    private UserService userService;

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public String save(Organize organize) {
        checkOrganize(organize);
        boolean hasName = checkName(organize);
        if (hasName) {
            throw new PeException(i18nService.getI18nValue("organize.name.exist"));
        }

        float showOrder = getMaxShowOrder(organize.getParentId());
        organize.setShowOrder(showOrder + 1);
        String idPath = getIdPath(organize.getParentId());
        organize.setIdPath(idPath);
        organize.setOrganizeStatus(Organize.OrganizeStatus.ENABLE);

        return super.save(organize);
    }


    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public Map<String, Organize> save(List<Organize> organizes) {
        if (CollectionUtils.isEmpty(organizes)) {
            throw new IllegalArgumentException("Parameters are not valid!");
        }

        List<String> orgNamePaths = organizes.stream().map(Organize::getNamePath).collect(Collectors.toList());
        if (CollectionUtils.isEmpty(orgNamePaths)) {
            return new HashMap<>(0);
        }

        Map<String, Organize> orgNamePathMap = findOrganizeNamePath();//idPathName,Org;
        Map<String, Float> showOrgMap = findShowOrders();
        List<String[]> namePathList = subNamePath(orgNamePaths);
        Integer maxNum = getMaxPathNum(orgNamePaths);
        for (int num = 1; num < maxNum; num++) {
            List<Organize> nwOrganize = new ArrayList<>();
            Map<String, Organize> nwOrganizeMap = new HashMap<>();
            for (String[] buildPath : namePathList) {
                if (num > buildPath.length - 1) {
                    continue;
                }

                String preOrgName = buildPath[num];
                String parentPath = getParentPath(buildPath, num);//父路径
                String preOrgPath = parentPath + PeConstant.POINT + preOrgName;//preOrg路径
                Organize preOrg = orgNamePathMap.get(preOrgPath);
                Organize preParentOrg = orgNamePathMap.get(parentPath);
                String idPath = null;
                Organize transientOrg = nwOrganizeMap.get(preOrgPath);
                if (preOrg != null || transientOrg != null) {
                    continue;
                }


                if (preParentOrg != null) {
                    if (StringUtils.isBlank(preParentOrg.getParentId())) {
                        idPath = preParentOrg.getId();
                    } else {
                        idPath = preParentOrg.getIdPath() + PeConstant.POINT + preParentOrg.getId();
                    }
                }

                Float showOrder = showOrgMap.get(preParentOrg.getId());
                preOrg = new Organize();
                preOrg.setOrganizeName(preOrgName);
                preOrg.setOrganizeStatus(Organize.OrganizeStatus.ENABLE);
                preOrg.setParentId(preParentOrg.getId());
                preOrg.setIdPath(idPath);
                preOrg.setNamePath(preOrgPath);
                if (showOrder == null) {
                    showOrder = 0f;
                    showOrgMap.put(preParentOrg.getId(), showOrder + 1);
                }

                preOrg.setShowOrder(showOrder + 1);
                nwOrganize.add(preOrg);
                nwOrganizeMap.put(preOrgPath, preOrg);
            }

            if (CollectionUtils.isNotEmpty(nwOrganize)) {
                batchSave(nwOrganize);
                for (Organize organize : nwOrganize) {
                    orgNamePathMap.put(organize.getNamePath(), organize);
                }
            }
        }

        return orgNamePathMap;
    }


    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
    public int syncOrganize(List<Organize> organizes) {
        if (CollectionUtils.isEmpty(organizes)) {
            throw new IllegalArgumentException("Organize list is empty!");
        }

        Map<String, Organize> organizeMap = organizes.stream().collect(Collectors.toMap(Organize::getId, organize -> organize));
        List<String> dbOrganizeIds = listFieldValueByCriterion(getConjunction(), Organize._id);
        List<String> saveOrganizeIds = (List<String>) CollectionUtils.subtract(organizeMap.keySet(), dbOrganizeIds);
        if (CollectionUtils.isNotEmpty(dbOrganizeIds)) {
            List<String> expireIds = (List<String>) CollectionUtils.subtract(dbOrganizeIds, organizeMap.keySet());
            if (CollectionUtils.isNotEmpty(expireIds)) {
                update(expireIds, Organize._organizeStauts, Organize.OrganizeStatus.DELETE);
            }

            dbOrganizeIds.removeAll(expireIds);
            if (CollectionUtils.isNotEmpty(dbOrganizeIds)) {
                List<Organize> updateOrganizes = new ArrayList<>(dbOrganizeIds.size());
                for (String dbOrganizeId : dbOrganizeIds) {
                    Organize organize = organizeMap.get(dbOrganizeId);
                    updateOrganizes.add(organize);
                }

                update(updateOrganizes, Organize._organizeName, Organize._idPath, Organize._parentId, Organize._showOrder);
            }
        }

        if (CollectionUtils.isEmpty(saveOrganizeIds)) {
            return organizes.size();
        }
        String parentId = null;
        for(Organize organize:organizes) {
            if(organize.isDefault()){
                parentId = organize.getId();
            }
        }

        final String addSql = "INSERT INTO T_UC_ORGANIZE(ID,CORP_CODE,CREATE_BY,CREATE_TIME,UPDATE_BY,UPDATE_TIME,ID_PATH," +
                "PARENT_ID,SHOW_ORDER,ORGANIZE_NAME,ORGANIZE_STATUS,IS_DEFAULT) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
        List<Object[]> allValues = new ArrayList<>();
        for (String saveOrganizeId : saveOrganizeIds) {
            Organize organize = organizeMap.get(saveOrganizeId);
            if(StringUtils.isBlank(organize.getIdPath())&& !organize.isDefault()){
                organize.setIdPath(parentId);
                organize.setParentId(parentId);
            }

            Object[] values = {organize.getId(), ExecutionContext.getCorpCode(), ExecutionContext.getUserId(), new Date(),
                    ExecutionContext.getUserId(), new Date(), organize.getIdPath(), organize.getParentId(),
                    organize.getShowOrder(), organize.getOrganizeName(),
                    Organize.OrganizeStatus.ENABLE.toString(), organize.isDefault()};

            allValues.add(values);
        }

        baseService.getJdbcTemplate().batchUpdate(addSql, allValues);
        return organizes.size();
    }

    private Map<String, Float> findShowOrders() {
        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.eq(Organize._organizeStauts, Organize.OrganizeStatus.ENABLE));
        Criteria criteria = createCriteria();
        criteria.add(conjunction);
        Projection projection = Projections.projectionList().add(Projections.groupProperty(Organize._parentId))
                .add(Projections.max(Organize._showOrder));
        criteria.setProjection(projection);
        List<Organize> organizes = listByCriteria(criteria, Organize._parentId, Organize._showOrder);
        Map<String, Float> reOrgMap = new HashMap<>(organizes.size());
        if (CollectionUtils.isEmpty(organizes)) {
            return new HashMap<>(0);
        }

        Organize rootOrg = getRoot();
        for (Organize org : organizes) {
            if (StringUtils.isBlank(org.getParentId())) {
                reOrgMap.put(rootOrg.getId(), org.getShowOrder());
                continue;
            }

            reOrgMap.put(org.getParentId(), org.getShowOrder());
        }

        return reOrgMap;
    }

    private String getParentPath(String[] namePaths, Integer endNum) {
        List<String> parentNames = new ArrayList<>(endNum - 1);
        parentNames.addAll(Arrays.asList(namePaths).subList(0, endNum));
        return StringUtils.join(parentNames, PeConstant.POINT);
    }


    private Map<String, Organize> findOrganizeNamePath() {
        Map<String, Organize> organizeIdMap = findAll();//id,Organize;
        Map<String, Organize> reOrganizeMap = new HashMap<>();
        for (Organize organize : organizeIdMap.values()) {
            String idPath = organize.getIdPath();
            if (PeConstant.STAR.equals(idPath)) {
                reOrganizeMap.put(organize.getOrganizeName(), organize);
                continue;
            }

            String[] idPaths = idPath.split("\\.");
            if (ArrayUtils.isNotEmpty(idPaths)) {
                List<String> idNames = new ArrayList<>(idPath.length() + 1);
                for (String id : idPaths) {
                    Organize org = organizeIdMap.get(id);
                    if (org != null && StringUtils.isNotBlank(org.getOrganizeName())) {
                        idNames.add(org.getOrganizeName());
                    }
                }

                String namePath = StringUtils.join(idNames, PeConstant.POINT);
                namePath = namePath + PeConstant.POINT + organize.getOrganizeName();
                reOrganizeMap.put(namePath, organize);
            }
        }

        return reOrganizeMap;
    }


    //将路径转化为集合{数组}
    private List<String[]> subNamePath(List<String> namePaths) {
        List<String[]> nameList = new ArrayList<>();
        for (String namePath : namePaths) {
            String[] nameArray = namePath.split("\\.");
            nameList.add(nameArray);
        }

        return nameList;
    }

    //获取所有路径的最大集层数
    private Integer getMaxPathNum(List<String> namePaths) {
        Integer max = 0;
        for (String namePath : namePaths) {
            String[] nameArray = namePath.split("\\.");
            if (nameArray.length > max) {
                max = nameArray.length;
            }
        }

        return max;
    }

    /**
     * 检测organize是否合法
     *
     * @param organize 部门实体
     * @since 2016年11月1日17:59:11 author by WuKang@HF
     */
    private void checkOrganize(Organize organize) {
        if (organize == null) {
            throw new IllegalArgumentException("Organize is null!");
        }

        if (StringUtils.isBlank(organize.getOrganizeName()) || organize.getOrganizeName().length() > 50) {
            throw new IllegalArgumentException("Organize name is illegal!");
        }

        if (StringUtils.isBlank(organize.getParentId())) {
            throw new IllegalArgumentException("Organize has not parent organize!");
        }
    }

    /**
     * 校验同一层级下部门名称是否重复
     *
     * @param organize 部门实体
     * @return 是否重复
     * @since 2016年10月26日09:14:47 author by WuKang@HF
     */
    private boolean checkName(Organize organize) {
        Criterion criterion = Restrictions.and(
                Restrictions.eq(Organize._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.eq(Organize._parentId, organize.getParentId()),
                Restrictions.eq(Organize._organizeName, organize.getOrganizeName()),
                Restrictions.ne(Organize._organizeStauts, Organize.OrganizeStatus.DELETE)
        );

        String dataOrganizeId = getFieldValueByCriterion(criterion, Organize._id);
        return !StringUtils.isBlank(dataOrganizeId) &&
                !(StringUtils.isNotBlank(organize.getId()) && dataOrganizeId.equals(organize.getId()));

    }

    /**
     * 根据父部门获取子部门应设置的idPath
     *
     * @param parentId 父部门Id
     * @return 子部门应设置的idPath
     * @since 2016年10月28日11:22:14 author by WuKang@HF
     */
    private String getIdPath(String parentId) {
        if (StringUtils.isBlank(parentId)) {
            return null;
        }

        Organize organize = load(parentId);
        if (organize == null) {
            return null;
        }

        String idPath = organize.getIdPath();
        if (StringUtils.isBlank(idPath) || PeConstant.STAR.equals(idPath)) {
            return organize.getId();
        }

        return idPath + PeConstant.POINT + organize.getId();
    }

    @Override
    @Transactional(readOnly = true)
    public float getMaxShowOrder(String parentId) {
        Criteria criteria = createCriteria();
        criteria.add(Restrictions.eq(Organize._parentId, parentId));
        criteria.add(Restrictions.ne(Organize._organizeStauts, Organize.OrganizeStatus.DELETE));
        criteria.addOrder(Order.desc(Organize._showOrder));
        criteria.setMaxResults(1);
        Organize lastChildOrganize = (Organize) criteria.uniqueResult();
        float showOrder = 0F;
        if (lastChildOrganize != null) {
            showOrder = lastChildOrganize.getShowOrder();
        }

        return showOrder;
    }


    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int update(Organize organize) {
        checkOrganize(organize);
        if (StringUtils.isBlank(organize.getId())) {
            throw new IllegalArgumentException("Organize id is null!");
        }

        Organize dataOrganize = get(organize.getId());
        if (dataOrganize == null) {
            throw new IllegalArgumentException("Organize is not exist!");
        }

        boolean hasName = checkName(organize);
        if (hasName) {
            throw new PeException(i18nService.getI18nValue("organize.name.exist"));
        }

        String oldParentId = dataOrganize.getParentId();
        if (StringUtils.isNotBlank(oldParentId) && oldParentId.equals(organize.getParentId())) {
            super.update(organize, Organize._organizeName);
            return NumberUtils.INTEGER_ONE;
        }

        float showOrder = getMaxShowOrder(organize.getParentId());
        organize.setShowOrder(showOrder + 1);
        String idPath = getIdPath(organize.getParentId());
        organize.setIdPath(idPath);
        update(organize, Organize._organizeName, Organize._parentId, Organize._idPath, Organize._showOrder);
        List<Organize> organizes = listByCriterion(Restrictions.like(Organize._idPath, organize.getId(), MatchMode.ANYWHERE));
        if (CollectionUtils.isEmpty(organizes)) {
            return NumberUtils.INTEGER_ONE;
        }

        for (Organize childOrg : organizes) {
            idPath = childOrg.getIdPath();
            idPath = organize.getIdPath() + PeConstant.POINT +
                    organize.getId() +
                    StringUtils.substringAfter(idPath, childOrg.getId());
            childOrg.setIdPath(idPath);
        }

        batchSaveOrUpdate(organizes);
        return NumberUtils.INTEGER_ONE;
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int delete(String organizeId) {
        if (StringUtils.isBlank(organizeId)) {
            throw new IllegalArgumentException("OrganizeId is null!");
        }

        boolean hasUser = userService.checkOrganizeUser(organizeId);
        if (hasUser) {
            throw new PeException(i18nService.getI18nValue("organize.has.user"));
        }

        Criterion criterion = Restrictions.and(
                Restrictions.eq(Organize._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.or(
                        Restrictions.eq(Organize._id, organizeId),
                        Restrictions.like(Organize._idPath, organizeId, MatchMode.ANYWHERE)),
                Restrictions.ne(Organize._organizeStauts, Organize.OrganizeStatus.DELETE));

        return updateByCriterion(criterion, Organize._organizeStauts, Organize.OrganizeStatus.DELETE);
    }

    @Override
    @Transactional(readOnly = true)
    public Organize getRoot() {
        return getByCriterion(Restrictions.and(
                Restrictions.eq(Organize._corpCode, ExecutionContext.getCorpCode())
                , Restrictions.isNull(Organize._parentId)));
    }

    @Override
    @Transactional(readOnly = true)
    public List<String> listOrganizeId(String parentId) {
        if (StringUtils.isBlank(parentId)) {
            throw new IllegalArgumentException("ParentId is null!");
        }

        Criterion criterion = Restrictions.and(
                Restrictions.eq(Organize._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.or(
                        Restrictions.ilike(Organize._idPath, parentId, MatchMode.ANYWHERE),
                        Restrictions.eq(Organize._id, parentId)),
                Restrictions.ne(Organize._organizeStauts, Organize.OrganizeStatus.DELETE));
        return listFieldValueByCriterion(criterion, Organize._id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<PeTreeNode> listTreeNode() {
        Criterion criterion = Restrictions.and(
                Restrictions.eq(Organize._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.ne(Organize._organizeStauts, Organize.OrganizeStatus.DELETE));
        List<Organize> organizes = listByCriterion((criterion),
                new Order[]{Order.asc(Organize._showOrder), Order.desc(Organize._createTime)});
        if (CollectionUtils.isEmpty(organizes)) {
            return new ArrayList<>(0);
        }

        List<PeTreeNode> peTreeNodes = new ArrayList<>(organizes.size());
        for (Organize organize : organizes) {
            PeTreeNode peTreeNode = new PeTreeNode();
            peTreeNode.setName(organize.getOrganizeName());
            peTreeNode.setpId(organize.getParentId());
            peTreeNode.setId(organize.getId());
            peTreeNode.setParent(true);
            peTreeNodes.add(peTreeNode);
            if (!organize.isDefault()) {
                continue;
            }

            peTreeNode.setCanEdit(false);
        }

        return peTreeNodes;
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int moveLevel(String organizeId, boolean isUp) {
        if (StringUtils.isBlank(organizeId)) {
            throw new IllegalArgumentException("OrganizeId is null!");
        }

        Organize organize = get(organizeId);
        if (organize == null) {
            throw new IllegalArgumentException("Organize is not exist!");
        }

        //获取交换对象
        Criteria criteria = createCriteria();
        criteria.add(Restrictions.and(
                Restrictions.eq(Organize._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.eq(Organize._parentId, organize.getParentId()),
                Restrictions.ne(Organize._organizeStauts, Organize.OrganizeStatus.DELETE)));
        Float showOrder = organize.getShowOrder();
        if (isUp) {
            criteria.add(Restrictions.and(Restrictions.lt(Organize._showOrder, showOrder)));
            criteria.addOrder(Order.desc(Organize._showOrder));
        } else {
            criteria.add(Restrictions.and(Restrictions.gt(Organize._showOrder, showOrder)));
            criteria.addOrder(Order.asc(Organize._showOrder));
        }

        criteria.setMaxResults(1);
        Organize lastChildOrganize = (Organize) criteria.uniqueResult();
        if (lastChildOrganize == null) {
            throw new IllegalArgumentException("Organize can not move level!");
        }

        organize.setShowOrder(lastChildOrganize.getShowOrder());
        lastChildOrganize.setShowOrder(showOrder);
        super.update(organize, Organize._showOrder);
        super.update(lastChildOrganize, Organize._showOrder);
        return NumberUtils.INTEGER_ONE;
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, Organize> find(List<String> organizeIds) {
        if (CollectionUtils.isEmpty(organizeIds)) {
            throw new IllegalArgumentException("Parameters are not valid!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.and(
                Restrictions.eq(Organize._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.ne(Organize._organizeStauts, Organize.OrganizeStatus.DELETE)));
        conjunction.add(Restrictions.in(Organize._id, organizeIds));
        List<Organize> organizes = listByCriterion(conjunction, Organize._organizeName, Organize._id, Organize._idPath);
        Map<String, Organize> organizeMap = new HashMap<>(organizes.size());
        for (Organize organize : organizes) {
            organizeMap.put(organize.getId(), organize);
        }

        return organizeMap;
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, Organize> findAll() {
        Criterion criterion = Restrictions.and(
                Restrictions.eq(Organize._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.ne(Organize._organizeStauts, Organize.OrganizeStatus.DELETE));
        List<Organize> organizes = listByCriterion(criterion, Organize._organizeName, Organize._idPath, Organize._parentId, Organize._id);
        if (CollectionUtils.isEmpty(organizes)) {
            return new HashMap<>(0);
        }

        return organizes.stream().collect(Collectors.toMap(Organize::getId, organize -> organize));
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, Long> findUserCount(List<String> organizeIds) {
        if (CollectionUtils.isEmpty(organizeIds)) {
            throw new IllegalArgumentException("OrganizeId is empty!");
        }

        Criteria criteria = createCriteria();
        criteria.add(Restrictions.in(Organize._id, organizeIds));
        criteria.createAlias(Organize._userAlias, Organize._userAlias);
        String userAlias = Organize._userAlias + PeConstant.POINT;
        criteria.add(Restrictions.eq(userAlias + User._status, User.UserStatus.ENABLE));
        criteria.setProjection(Projections.projectionList()
                .add(Projections.groupProperty(Organize._id))
                .add(Projections.rowCount()));
        List<Object[]> objects = criteria.list();
        if (CollectionUtils.isEmpty(objects)) {
            return new HashMap<>(0);
        }

        Map<String, Long> userCountMap = new HashMap<>(objects.size());
        for (Object[] values : objects) {
            String organizeId = (String) values[0];
            Long count = (Long) values[1];
            userCountMap.put(organizeId, count);
        }

        return userCountMap;
    }

    @Override
    @Transactional(readOnly = true)
    public Organize getDefault() {
        Conjunction conjunction = new Conjunction();
        conjunction.add(Restrictions.eq(Organize._organizeName, "其他"));
        conjunction.add(Restrictions.eq(Organize._isDefault, Boolean.TRUE));
        conjunction.add(Restrictions.eq(Organize._corpCode, ExecutionContext.getCorpCode()));
        return getByCriterion(conjunction, Organize._id, Organize._organizeName);
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, List<Organize>> findOrganizeName(List<String> organizeNames) {
        if (CollectionUtils.isEmpty(organizeNames)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.in(Organize._organizeName, organizeNames));
        conjunction.add(Restrictions.eq(Organize._organizeStauts, Organize.OrganizeStatus.ENABLE));
        List<Organize> organizes = listByCriterion(conjunction, Organize._organizeName, Organize._id, Organize._parentId, Organize._idPath);
        if (CollectionUtils.isEmpty(organizes)) {
            return new HashMap<>(0);
        }

        Set<String> organizeIds = new HashSet<>();
        for (Organize organize : organizes) {
            String[] ids = organize.getIdPath().split("\\.");
            organizeIds.addAll(new HashSet<>(Arrays.asList(ids)));
        }

        List<Organize> organizeList = (List<Organize>) findAll().values();
        Map<String, Organize> parentOrgMap = organizeList.stream().collect(Collectors.toMap(Organize::getId, organize1 -> organize1));
        Map<String, List<Organize>> organizesMap = new HashMap<>(organizes.size());
        for (Organize organize : organizes) {
            List<Organize> orgs = organizesMap.get(organize.getOrganizeName());
            if (orgs == null) {
                orgs = new ArrayList<>();
                organizesMap.put(organize.getOrganizeName(), orgs);
            }

            orgs.add(organize);
            if (organize.getIdPath().equals(PeConstant.STAR)) {
                continue;
            }

            String[] ids = organize.getIdPath().split("\\.");
            List<String> names = new ArrayList<>(ids.length);
            for (String id : ids) {
                names.add(parentOrgMap.get(id).getOrganizeName());
            }

            organize.setNamePath(StringUtils.join(names, PeConstant.POINT));
        }

        return organizesMap;
    }
}
