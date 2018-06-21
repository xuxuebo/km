package com.qgutech.km.base.service;

import com.qgutech.km.base.ExecutionContext;
import com.qgutech.km.base.model.Category;
import com.qgutech.km.base.vo.PeTreeNode;
import com.qgutech.km.constant.PeConstant;
import com.qgutech.km.module.uc.service.PositionService;
import com.qgutech.km.utils.PeException;
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

import static com.qgutech.km.base.model.BaseLevelModel.*;
import static com.qgutech.km.base.model.BaseModel._corpCode;
import static com.qgutech.km.base.model.Category._categoryName;
import static com.qgutech.km.base.model.Category._categoryType;

@Service("categoryService")
public class CategoryServiceImpl extends BaseServiceImpl<Category> implements CategoryService {

    @Resource
    protected I18nService i18nService;
    @Resource
    private PositionService positionService;

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public String save(Category category) {
        checkParams(category);
        if (category.getCategoryName().length() > 30) {
            throw new PeException(i18nService.getI18nValue("categoryName.length.maxLimit"));
        }

        boolean exist = checkName(category);
        if (exist) {
            throw new PeException(i18nService.getI18nValue("categoryName.not.repeat"));
        }

        float showOrder = getMaxShowOrder(category.getParentId());
        category.setShowOrder(showOrder + 1);
        String idPath = getIdPath(category.getParentId());
        category.setIdPath(idPath);
        category.setCategoryStatus(Category.CategoryStatus.ENABLE);
        return super.save(category);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean checkName(Category category) {
        checkParams(category);
        Criterion criterion = Restrictions.and(
                Restrictions.eq(Category._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.eq(Category._categoryName, category.getCategoryName()),
                Restrictions.eq(Category._parentId, category.getParentId()),
                Restrictions.eq(Category._categoryType, category.getCategoryType()),
                Restrictions.ne(Category._categoryStatus, Category.CategoryStatus.DELETE));
        Category dataCategory = getByCriterion(criterion, Category._id);
        return dataCategory != null && (StringUtils.isBlank(category.getId())
                || !dataCategory.getId().equals(category.getId()));

    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int update(Category category) {
        checkParams(category);
        if (category.getCategoryName().length() > 30) {
            throw new PeException(i18nService.getI18nValue("categoryName.length.maxLimit"));
        }

        boolean exist = checkName(category);
        if (exist) {
            throw new PeException(i18nService.getI18nValue("categoryName.not.repeat"));
        }

        String oldParentId = getFieldValueById(category.getId(), _parentId);
        if (StringUtils.isNotBlank(oldParentId) && oldParentId.equals(category.getParentId())) {
            update(category, Category._categoryName);
            return NumberUtils.INTEGER_ONE;
        }

        float showOrder = getMaxShowOrder(category.getParentId());
        category.setShowOrder(showOrder + 1);
        String idPath = getIdPath(category.getParentId());
        category.setIdPath(idPath);
        update(category, Category._categoryName, Category._parentId, _idPath, _showOrder);
        return NumberUtils.INTEGER_ONE;
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int delete(String categoryId, Category.CategoryEnumType type) {
        if (StringUtils.isBlank(categoryId) || type == null) {
            throw new PeException("CategoryId and type is null!");
        }

        Category dataCategory = super.get(categoryId);
        if (dataCategory == null) {
            throw new PeException("Category is not exist!");
        }

        String errorInfoKey = checkDelete(categoryId, type);
        if (StringUtils.isNotBlank(errorInfoKey)) {
            throw new PeException(i18nService.getI18nValue(errorInfoKey));
        }

        Criterion criterion = Restrictions.and(Restrictions.eq(Category._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.or(Restrictions.eq(Category._id, categoryId),
                        Restrictions.like(Category._idPath, categoryId, MatchMode.ANYWHERE)));
        return updateByCriterion(criterion, Category._categoryStatus, Category.CategoryStatus.DELETE);
    }

    private String checkDelete(String categoryId, Category.CategoryEnumType type) {
        List<String> categoryIds = listCategoryId(categoryId, type);
        if (CollectionUtils.isEmpty(categoryIds)) {
            throw new PeException("类别不存在!");
        }

        switch (type) {
            case POSITION:
                boolean positionExist = positionService.exist(categoryIds);
                if (positionExist) {
                    return "position.category.exist.position";
                }
        }

        return null;
    }

    @Override
    @Transactional(readOnly = true)
    public List<String> listCategoryId(String parentId, Category.CategoryEnumType type) {
        if (StringUtils.isBlank(parentId) || type == null) {
            throw new PeException("Parent id is blank!");
        }

        Criterion criterion = Restrictions.and(
                Restrictions.eq(Category._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.eq(Category._categoryType, type),
                Restrictions.ne(Category._categoryStatus, Category.CategoryStatus.DELETE),
                Restrictions.or(Restrictions.like(Category._idPath, parentId, MatchMode.ANYWHERE),
                        Restrictions.eq(Category._id, parentId)));
        List<Category> categories = listByCriterion(criterion, Category._id);
        if (CollectionUtils.isEmpty(categories)) {
            return new ArrayList<>(0);
        }

        List<String> categoryIds = new ArrayList<>(categories.size());
        categoryIds.addAll(categories.stream().map(Category::getId)
                .collect(Collectors.toList()));
        return categoryIds;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Category> list(String parentId, Category.CategoryEnumType type) {
        if (StringUtils.isBlank(parentId) || type == null) {
            throw new PeException("ParentId is blank!");
        }

        Criterion criterion = Restrictions.and(
                Restrictions.eq(Category._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.eq(Category._categoryType, type),
                Restrictions.ne(Category._categoryStatus, Category.CategoryStatus.DELETE),
                Restrictions.like(Category._idPath, parentId, MatchMode.ANYWHERE));
        return listByCriterion(criterion, new Order[]{Order.asc(Category._showOrder)});
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<Category> list(String parentId, String keyword) {
        if (StringUtils.isBlank(parentId)) {
            throw new PeException("ParentId is blank!");
        }

        Junction junction = Restrictions.conjunction()
                .add(Restrictions.eq(_corpCode, ExecutionContext.getCorpCode()))
                .add(Restrictions.like(_idPath, parentId, MatchMode.ANYWHERE))
                .add(Restrictions.ne(Category._categoryStatus, Category.CategoryStatus.DELETE));
        if (StringUtils.isNotBlank(keyword)) {
            junction.add(Restrictions.like(_categoryName, keyword, MatchMode.ANYWHERE));
        }

        return listByCriterion(junction);
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<Category> list(String parentId, String keyword, boolean sub) {
        if (StringUtils.isBlank(parentId)) {
            throw new PeException("ParentId is blank!");
        }

        if (sub) {
            return list(parentId, keyword);
        }

        Junction junction = Restrictions.conjunction()
                .add(Restrictions.eq(_corpCode, ExecutionContext.getCorpCode()))
                .add(Restrictions.eq(_parentId, parentId))
                .add(Restrictions.ne(Category._categoryStatus, Category.CategoryStatus.DELETE));
        if (StringUtils.isNotBlank(keyword)) {
            junction.add(Restrictions.like(_categoryName, keyword, MatchMode.ANYWHERE));
        }

        return listByCriterion(junction);
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public int moveNode(Category category) {
        if (category == null || StringUtils.isBlank(category.getId())
                || StringUtils.isBlank(category.getParentId())
                || category.getCategoryType() == null) {
            throw new PeException("Move category node is not valid!");
        }

        Category dataCategory = get(category.getId(), Category._parentId);
        if (dataCategory == null || StringUtils.isBlank(dataCategory.getParentId())) {
            throw new PeException("Data is not existed!");
        }

        if (dataCategory.getParentId().equals(category.getParentId())) {
            return NumberUtils.INTEGER_ZERO;
        }

        update(category, Category._parentId);
        List<Category> categories = list(category.getId(), category.getCategoryType());
        if (CollectionUtils.isEmpty(categories)) {
            return NumberUtils.INTEGER_ONE;
        }

        for (Category childCategory : categories) {
            String idPath = childCategory.getIdPath();
            idPath = category.getIdPath() + PeConstant.POINT +
                    category.getId() +
                    StringUtils.substringAfter(idPath, dataCategory.getId());
            childCategory.setIdPath(idPath);
        }

        batchSaveOrUpdate(categories);
        return categories.size() + NumberUtils.INTEGER_ONE;
    }

    /**
     * 验证类别参数的合法性
     *
     * @param category 类别参数
     * @since 2016年10月13日17:19:33
     */
    protected void checkParams(Category category) {
        if (category == null || StringUtils.isBlank(category.getCategoryName())
                || StringUtils.isBlank(category.getParentId())
                || category.getCategoryType() == null) {
            throw new PeException("Category parameter is not valid!");
        }
    }

    @Override
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public Category getRoot(Category.CategoryEnumType type) {
        return getByCriterion(Restrictions.conjunction()
                .add(Restrictions.eq(_categoryType, type))
                .add(Restrictions.eq(_corpCode, ExecutionContext.getCorpCode()))
                .add(Restrictions.ne(Category._categoryStatus, Category.CategoryStatus.DELETE))
                .add(Restrictions.disjunction().add(Restrictions.eq(_parentId, ""))
                        .add(Restrictions.isNull(_parentId))));
    }

    @Override
    @Transactional(readOnly = true)
    public List<Category> list(Category.CategoryEnumType type) {
        if (type == null) {
            throw new PeException("Type is null!");
        }

        return listByCriterion(Restrictions.and(Restrictions.eq(Category._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.eq(Category._categoryType, type),
                Restrictions.ne(Category._categoryStatus, Category.CategoryStatus.DELETE)),
                new Order[]{Order.asc(Category._showOrder)});
    }

    @Override
    @Transactional(readOnly = true)
    public List<PeTreeNode> listTreeNode(Category.CategoryEnumType type) {
        if (type == null) {
            throw new PeException("Type is null!");
        }

        List<Category> categories = list(type);
        if (CollectionUtils.isEmpty(categories)) {
            return new ArrayList<>(0);
        }

        List<PeTreeNode> treeNodes = new ArrayList<>();
        for (Category category : categories) {
            PeTreeNode peTreeNode = new PeTreeNode();
            peTreeNode.setId(category.getId());
            peTreeNode.setpId(category.getParentId());
            peTreeNode.setParent(true);
            peTreeNode.setName(category.getCategoryName());
            treeNodes.add(peTreeNode);
            if (!category.isDefault()) {
                continue;
            }

            peTreeNode.setCanEdit(false);
        }

        return treeNodes;
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int moveLevel(String categoryId, boolean isUp) {
        if (StringUtils.isBlank(categoryId)) {
            throw new PeException("Category id is null!");
        }

        Category category = get(categoryId);
        if (category == null) {
            throw new PeException("Category is not exist!");
        }

        //获取交换对象
        Criteria criteria = createCriteria();
        criteria.add(Restrictions.and(
                Restrictions.eq(Category._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.eq(Category._parentId, category.getParentId()),
                Restrictions.ne(Category._categoryStatus, Category.CategoryStatus.DELETE)
                )
        );
        Float showOrder = category.getShowOrder();
        if (isUp) {
            criteria.add(Restrictions.and(Restrictions.lt(Category._showOrder, showOrder)));
            criteria.addOrder(Order.desc(Category._showOrder));
        } else {
            criteria.add(Restrictions.and(Restrictions.gt(Category._showOrder, showOrder)));
            criteria.addOrder(Order.asc(Category._showOrder));
        }

        criteria.setMaxResults(1);
        Category lastChildOrganize = (Category) criteria.uniqueResult();
        if (lastChildOrganize == null) {
            throw new PeException("Organize can not move level!");
        }

        category.setShowOrder(lastChildOrganize.getShowOrder());
        lastChildOrganize.setShowOrder(showOrder);
        update(category, Category._showOrder);
        update(lastChildOrganize, Category._showOrder);
        return 2;
    }

    @Override
    @Transactional(readOnly = true)
    public String checkCatagoryName(Category category) {
        if (category == null || StringUtils.isBlank(category.getCategoryName())) {
            throw new IllegalArgumentException("Category Parameter is illegal");
        }
        Criterion criterion = Restrictions.and(
                Restrictions.eq(Category._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.eq(Category._categoryName, category.getCategoryName()),
                Restrictions.eq(Category._categoryType, Category.CategoryEnumType.ITEM_BANK),
                Restrictions.eq(Category._categoryStatus, Category.CategoryStatus.ENABLE)
        );
        List<Category> categories = listByCriterion(criterion, Category._id);
        if (CollectionUtils.isNotEmpty(categories)) {
            return categories.get(0).getId();
        }

        return null;
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, Category> listByCategoryType(Category.CategoryEnumType categoryEnumType) {
        if (categoryEnumType == null) {
            throw new IllegalArgumentException("Parameters are not valid!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.and(Restrictions.eq(Category._categoryType, categoryEnumType),
                Restrictions.eq(Category._categoryStatus, Category.CategoryStatus.ENABLE)));
        List<Category> categories = listByCriterion(conjunction, Category._id, Category._parentId, Category._idPath, Category._categoryName);
        if (CollectionUtils.isNotEmpty(categories)) {
            Map<String, Category> categoryNameMap = new HashMap<>(categories.size());//<类别名称，类别实体>
            Map<String, String> categoryMap = new HashMap<>(categories.size());
            for (Category catagory : categories) {
                categoryMap.put(catagory.getId(), catagory.getCategoryName());
            }

            for (Category category : categories) {
                if (StringUtils.isBlank(category.getParentId())
                        && PeConstant.STAR.equals(category.getIdPath())) {
                    category.setNamePath(category.getCategoryName());
                    categoryNameMap.put(category.getCategoryName(), category);
                    continue;
                }

                String[] ids = category.getIdPath().split("\\.");
                if (ArrayUtils.isEmpty(ids)) {
                    continue;
                }

                List<String> names = new ArrayList<>(ids.length + 1);
                for (String id : ids) {
                    names.add(categoryMap.get(id));
                }

                names.add(category.getCategoryName());
                category.setNamePath(StringUtils.join(names, PeConstant.POINT));
                categoryNameMap.put(category.getNamePath(), category);
            }

            return categoryNameMap;
        }

        return new HashMap<>(0);
    }

    @Override
    @Transactional(readOnly = true)
    public Category getDefault(Category.CategoryEnumType categoryEnumType) {
        Conjunction conjunction = new Conjunction();
        conjunction.add(Restrictions.eq(Category._categoryName, "未分类"));
        conjunction.add(Restrictions.eq(Category._categoryStatus, Category.CategoryStatus.ENABLE));
        conjunction.add(Restrictions.eq(Category._isDefault, Boolean.TRUE));
        conjunction.add(Restrictions.eq(Category._corpCode, ExecutionContext.getCorpCode()));
        return getByCriterion(conjunction, Category._id, Category._categoryName);
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public void save(List<Category> categories, Category.CategoryEnumType categoryEnumType) {
        if (CollectionUtils.isEmpty(categories) || categoryEnumType == null) {
            throw new IllegalArgumentException("Parameters are not valid!");
        }

        Set<String> categoryNames = categories.stream().map(Category::getNamePath).collect(Collectors.toSet());
        Map<String, Category> preCategoryMap = processCategory(categoryNames, Category.CategoryEnumType.POSITION);
        for(Category category:categories){
            Category preCategory = preCategoryMap.get(category.getNamePath());
            category.setId(preCategory.getId());
        }
    }

    private Map<String, Category> processCategory(Set<String> categoryPaths, Category.CategoryEnumType categoryType) {
        Map<String, Category> allCategories = listByCategoryType(Category.CategoryEnumType.POSITION);//所有类别路径，对应category
        List<String[]> categoryNames = processCategoryNames(new ArrayList<>(categoryPaths));
        Integer maxNum = getMaxPathNum(new ArrayList<>(categoryPaths));
        Map<String, Float> showOrderMap = getMaxShowOrder(null, Category.CategoryEnumType.POSITION);//获取所有的类别对应的showOrder;
        for (int index = 1; index < maxNum; index++) {
            Map<String, Category> nwCategoryMap = new HashMap<>();
            List<Category> nwCategories = new ArrayList<>();
            for (String[] categoryName : categoryNames) {
                if (index > categoryName.length - 1) {
                    continue;
                }

                String catePathName = getParentPath(categoryName, index);
                String parentPathName = getParentPath(categoryName, index - 1);
                String cateName = categoryName[index];
                Category preCategory = allCategories.get(catePathName);
                Category parentCategory = allCategories.get(parentPathName);
                String idPath;
                if(parentCategory==null){
                    continue;
                }

                if (StringUtils.isBlank(parentCategory.getParentId())) {
                    idPath = parentCategory.getId();
                } else {
                    idPath = parentCategory.getIdPath() + PeConstant.POINT + parentCategory.getId();
                }

                Category transientCategory = nwCategoryMap.get(catePathName);
                if (preCategory == null && transientCategory == null) {
                    preCategory = new Category();
                    preCategory.setIdPath(idPath);
                    preCategory.setParentId(parentCategory.getId());
                    Float showOrder = showOrderMap.get(parentCategory.getId());
                    if (showOrder == null) {
                        showOrder = 0f;
                    }

                    preCategory.setShowOrder(showOrder + 1);
                    preCategory.setCategoryName(cateName);
                    preCategory.setNamePath(catePathName);
                    showOrderMap.put(parentCategory.getParentId(), showOrder + 1);
                    preCategory.setCategoryType(categoryType);
                    preCategory.setCategoryStatus(Category.CategoryStatus.ENABLE);
                    nwCategories.add(preCategory);
                    nwCategoryMap.put(catePathName, preCategory);
                }

            }

            if (CollectionUtils.isNotEmpty(nwCategories)) {
                batchSave(nwCategories);
                for (Category category : nwCategories) {
                    allCategories.put(category.getNamePath(), category);
                }
            }
        }

        return allCategories;
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, Float> getMaxShowOrder(List<String> categoryIds, Category.CategoryEnumType categoryEnumType) {
        if (categoryEnumType == null) {
            throw new IllegalArgumentException("parameters are not valid!");
        }

        Conjunction conjunction = getConjunction();
        if (CollectionUtils.isNotEmpty(categoryIds)) {
            conjunction.add(Restrictions.eq(Category._id, categoryIds));
        }

        conjunction.add(Restrictions.eq(Category._categoryType, categoryEnumType));
        conjunction.add(Restrictions.eq(Category._categoryStatus, Category.CategoryStatus.ENABLE));
        conjunction.add(Restrictions.isNotNull(Category._parentId));
        Criteria criteria = createCriteria();
        criteria.add(conjunction);
        criteria.setProjection(Projections.projectionList().add(Projections.groupProperty(Category._parentId)).add(Projections.max(Category._showOrder)));
        List<Category> categories = listByCriteria(criteria, Category._parentId, Category._showOrder);
        Map<String, Float> categoryMap = new HashMap<>(categories.size());
        for (Category category : categories) {
            categoryMap.put(category.getParentId(), category.getShowOrder());
        }

        return categoryMap;
    }

    private String getParentPath(String[] categoryNames, Integer num) {
        if (num == 1) {
            return categoryNames[0] + PeConstant.POINT + categoryNames[num];
        }

        List<String> cateNames = new ArrayList<>(num);
        cateNames.addAll(Arrays.asList(categoryNames).subList(0, num));
        cateNames.add(categoryNames[num]);
        return StringUtils.join(cateNames, PeConstant.POINT);
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


    private List<String[]> processCategoryNames(List<String> categoryPaths) {
        List<String[]> categoryNames = new ArrayList<>(categoryPaths.size());
        for (String categoryPath : categoryPaths) {
            String[] categoryArray = categoryPath.split("\\.");
            categoryNames.add(categoryArray);
        }

        return categoryNames;
    }

    protected String getIdPath(String parentId) {
        if (StringUtils.isBlank(parentId)) {
            return null;
        }

        Category category = get(parentId, Category._idPath);
        String idPath = category.getIdPath();
        if (StringUtils.isBlank(idPath) || PeConstant.STAR.equals(idPath)) {
            return category.getId();
        }

        return idPath + PeConstant.POINT + category.getId();
    }

    protected float getMaxShowOrder(String parentId) {
        Criteria criteria = createCriteria();
        if (StringUtils.isNotEmpty(parentId)) {
            criteria.add(Restrictions.eq(_parentId, parentId));
        } else {
            criteria.add(Restrictions.isNull(_parentId));
        }

        criteria.add(Restrictions.ne(Category._categoryStatus, Category.CategoryStatus.DELETE));
        criteria.addOrder(Order.desc(_showOrder));
        criteria.setMaxResults(1);
        Category lastChildCategory = (Category) criteria.uniqueResult();
        float showOrder = 0F;
        if (lastChildCategory != null) {
            showOrder = lastChildCategory.getShowOrder();
        }

        return showOrder;
    }
}