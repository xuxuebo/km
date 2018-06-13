package com.fp.cloud.module.uc.service;

import com.fp.cloud.base.ExecutionContext;
import com.fp.cloud.base.model.Category;
import com.fp.cloud.base.model.Page;
import com.fp.cloud.base.service.BaseServiceImpl;
import com.fp.cloud.base.service.CategoryService;
import com.fp.cloud.constant.PeConstant;
import com.fp.cloud.utils.PeException;
import com.fp.cloud.utils.PeUtils;
import com.fp.cloud.base.model.PageParam;
import com.fp.cloud.base.service.I18nService;
import com.fp.cloud.module.uc.model.Position;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

@Service("positionService")
public class PositionServiceImpl extends BaseServiceImpl<Position> implements PositionService {
    @Resource
    private I18nService i18nService;
    @Resource
    private CategoryService categoryService;

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public String save(Position position) {
        checkPosition(position);

        boolean hasName = checkName(position);
        if (hasName) {
            throw new PeException(i18nService.getI18nValue("position.name.exist"));
        }

        position.setPositionStatus(Position.PositionStatus.ENABLE);
        return super.save(position);
    }

    private void checkPosition(Position position) {
        if (position == null) {
            throw new IllegalArgumentException("Position is null!");
        }

        if (StringUtils.isBlank(position.getPositionName()) || position.getPositionName().length() > 50) {
            throw new IllegalArgumentException("Position name is illegal!");
        }

        if (position.getCategory() == null || StringUtils.isBlank(position.getCategory().getId())) {
            throw new IllegalArgumentException("Position category is illegal!");
        }
    }

    /**
     * 校验同一类别下的岗位名称是否重复
     *
     * @param position 岗位实体
     * @return 是否重复
     * @since 2016年10月26日09:14:47 author by WuKang@HF
     */
    private boolean checkName(Position position) {
        Criterion criterion = Restrictions.and(
                Restrictions.eq(Position._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.eq(Position._positionName, position.getPositionName()),
                Restrictions.eq(Position._category, position.getCategory().getId()),
                Restrictions.ne(Position._positionStauts, Position.PositionStatus.DELETE)
        );

        String dataPositionId = getFieldValueByCriterion(criterion, Position._id);
        return !StringUtils.isBlank(dataPositionId) &&
                !(StringUtils.isNotBlank(position.getId()) && dataPositionId.equals(position.getId()));
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int update(Position position) {
        checkPosition(position);
        if (StringUtils.isBlank(position.getId())) {
            throw new IllegalArgumentException("Position id is null!");
        }

        boolean hasName = checkName(position);
        if (hasName) {
            throw new PeException(i18nService.getI18nValue("position.name.exist"));
        }

        super.update(position, Position._positionName, Position._category);
        return NumberUtils.INTEGER_ONE;
    }

    @Override
    @Transactional(readOnly = true)
    public Page<Position> search(Position position, PageParam pageParam) {
        PeUtils.validPage(pageParam);
        Page<Position> page = new Page<>();
        if (position == null || position.getCategory() == null) {
            return page;
        }

        Category category = position.getCategory();
        String categoryId = category.getId();
        if (StringUtils.isBlank(categoryId)) {
            Category root = categoryService.getRoot(Category.CategoryEnumType.POSITION);
            categoryId = root.getId();
        }

        List<String> categoryIds = new ArrayList<>();
        if (category.isInclude()) {
            categoryIds = categoryService.listCategoryId(categoryId, Category.CategoryEnumType.POSITION);
        } else {
            categoryIds.add(categoryId);
        }

        if (CollectionUtils.isEmpty(categoryIds)) {
            return page;
        }

        Criterion criterion = Restrictions.and(
                Restrictions.eq(Position._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.ne(Position._positionStauts, Position.PositionStatus.DELETE),
                Restrictions.in(Position._category, categoryIds)
        );

        return search(pageParam, criterion, new Order[]{}, Position._positionName, Position._id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Position> listByCategory(List<String> categoryIds) {
        if (CollectionUtils.isEmpty(categoryIds)) {
            throw new IllegalArgumentException("CategoryId list is empty!");
        }

        Criterion criterion = Restrictions.and(
                Restrictions.eq(Position._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.ne(Position._positionStauts, Position.PositionStatus.DELETE),
                Restrictions.in(Position._category, categoryIds));
        return listByCriterion(criterion, new Order[]{Order.desc(Position._createTime)}, Position._id, Position._positionName, Position._category);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean exist(List<String> categoryIds) {
        if (CollectionUtils.isEmpty(categoryIds)) {
            throw new IllegalArgumentException("CategoryIds is empty!");
        }

        Criterion criterion = Restrictions.and(
                Restrictions.eq(Position._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.ne(Position._positionStauts, Position.PositionStatus.DELETE),
                Restrictions.in(Position._category, categoryIds)
        );

        return super.exist(criterion);
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, List<Position>> findNamePath(List<String> positionNames) {
        if (CollectionUtils.isEmpty(positionNames)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.in(Position._positionName, positionNames));
        conjunction.add(Restrictions.eq(Position._positionStauts, Position.PositionStatus.ENABLE));
        List<Position> positions = listByCriterion(conjunction, Position._id, Position._positionName,
                Position._category, Position._categoryIdPath);
        if (CollectionUtils.isEmpty(positions)) {
            return new HashMap<>(0);
        }

        Set<String> categoryIds = new HashSet<>();
        for (Position position : positions) {
            Category category = position.getCategory();
            String[] ids = category.getIdPath().split("\\.");
            categoryIds.addAll(new HashSet<>(Arrays.asList(ids)));
            categoryIds.add(category.getId());
        }

        List<Category> categories = categoryService.listByIds(new ArrayList<>(categoryIds), Category._id, Category._categoryName);
        if (CollectionUtils.isEmpty(categories)) {
            return new HashMap<>(0);
        }

        Map<String, String> categoryNameMap = categories.stream().collect(Collectors.toMap(Category::getId, Category::getCategoryName));
        Map<String, List<Position>> positionsMap = new HashMap<>(positionNames.size());
        for (Position position : positions) {
            List<Position> ps = positionsMap.get(position.getPositionName());
            if (ps == null) {
                ps = new ArrayList<>();
                positionsMap.put(position.getPositionName(), ps);
            }

            ps.add(position);
            Category category = position.getCategory();
            String categoryName = categoryNameMap.get(category.getId());
            String[] ids = category.getIdPath().split("\\.");
            List<String> names = new ArrayList<>(ids.length + 1);
            for (String id : ids) {
                names.add(categoryNameMap.get(id));
            }

            names.add(categoryName);
            position.setCategoryNamePath(StringUtils.join(names, PeConstant.POINT));
        }

        return positionsMap;
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
    public void save(List<Position> positions) {
        if (CollectionUtils.isEmpty(positions)) {
            throw new IllegalArgumentException("Parameters are note valid");
        }

        List<Category> categories = positions.stream().map(Position::getCategory).collect(Collectors.toList());
        categoryService.save(categories, Category.CategoryEnumType.POSITION);
        Map<String, String> categoryMap = new HashMap<>(categories.size());
        for (Category category : categories) {
            categoryMap.put(category.getNamePath(), category.getId());
        }
        //    Map<String, String> categoryMap = categories.stream().collect(Collectors.toMap(Category::getNamePath, Category::getId));
        Map<String, List<Position>> prePositionMap = checkPosition(positions);
        if (MapUtils.isEmpty(prePositionMap)) {
            return;
        }

        List<Position> prePosition = processPosition(categoryMap, prePositionMap);
        batchSave(prePosition);
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
    public int syncCategory(List<Category> categories) {
        if (CollectionUtils.isEmpty(categories)) {
            throw new IllegalArgumentException("Category list is empty!");
        }

        Category rootCategory = categoryService.getRoot(Category.CategoryEnumType.POSITION);
        for (Category category : categories) {
            if (StringUtils.isEmpty(category.getParentId())) {
                category.setParentId(rootCategory.getId());
                category.setIdPath(rootCategory.getId());
            }
        }

        Map<String, Category> categoryMap = categories.stream().collect(Collectors.toMap(Category::getId, category -> category));
        Conjunction conjunction = getConjunction();
        conjunction.add(Restrictions.eq(Category._categoryType, Category.CategoryEnumType.POSITION));
        conjunction.add(Restrictions.isNotNull(Category._parentId));
        List<String> categoryIds = categoryService.listFieldValueByCriterion(conjunction, Category._id);
        List<String> saveCategoryIds = (List<String>) CollectionUtils.subtract(categoryMap.keySet(), categoryIds);
        if (CollectionUtils.isNotEmpty(categoryIds)) {
            List<String> expireIds = (List<String>) CollectionUtils.subtract(categoryIds, categoryMap.keySet());
            if (CollectionUtils.isNotEmpty(expireIds)) {
                categoryService.update(expireIds, Category._categoryStatus, Category.CategoryStatus.DELETE);
            }

            categoryIds.removeAll(expireIds);
            if (CollectionUtils.isNotEmpty(categoryIds)) {
                List<Category> updateCategorys = new ArrayList<>(categoryIds.size());
                for (String categoryId : categoryIds) {
                    Category category = categoryMap.get(categoryId);
                    updateCategorys.add(category);
                }

                categoryService.update(updateCategorys, Category._categoryName, Category._idPath, Category._parentId, Category._showOrder);
            }
        }

        if (CollectionUtils.isEmpty(saveCategoryIds)) {
            return categories.size();
        }

        final String addSql = "INSERT INTO T_PE_CATEGORY(ID,CORP_CODE,CREATE_BY,CREATE_TIME,UPDATE_BY,UPDATE_TIME,ID_PATH," +
                "PARENT_ID,SHOW_ORDER,CATEGORY_NAME,CATEGORY_TYPE,CATEGORY_STATUS,IS_DEFAULT) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        List<Object[]> allValues = new ArrayList<>();
        for (String categoryId : saveCategoryIds) {
            Category category = categoryMap.get(categoryId);
            if (category.getShowOrder() == null) {
                category.setShowOrder(-1f);
            }

            if (StringUtils.isBlank(category.getIdPath())) {
                category.setIdPath(rootCategory.getId());
                category.setParentId(rootCategory.getId());
            }

            Object[] values = {category.getId(), ExecutionContext.getCorpCode(), ExecutionContext.getUserId(), new Date(),
                    ExecutionContext.getUserId(), new Date(), category.getIdPath(), category.getParentId(), category.getShowOrder(),
                    category.getCategoryName(), Category.CategoryEnumType.POSITION.toString(), Category.CategoryStatus.ENABLE.toString(),
                    category.isDefault()};
            allValues.add(values);
        }

        baseService.getJdbcTemplate().batchUpdate(addSql, allValues);
        return categories.size();
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
    public int syncPosition(List<Position> positions) {
        if (CollectionUtils.isEmpty(positions)) {
            throw new IllegalArgumentException("Position list is empty!");
        }

        for (Position position : positions) {
            Category category = new Category();
            category.setId(position.getCategoryId());
            position.setCategory(category);
        }

        Map<String, Position> positionMap = positions.stream().collect(Collectors.toMap(Position::getId, position -> position));
        List<String> positionIds = listFieldValueByCriterion(getConjunction(), Position._id);
        List<String> savePositionIds = (List<String>) CollectionUtils.subtract(positionMap.keySet(), positionIds);
        if (CollectionUtils.isNotEmpty(positionIds)) {
            List<String> expireIds = (List<String>) CollectionUtils.subtract(positionIds, positionMap.keySet());
            if (CollectionUtils.isNotEmpty(expireIds)) {
                update(expireIds, Position._positionStauts, Position.PositionStatus.DELETE);
            }

            positionIds.removeAll(expireIds);
            if (CollectionUtils.isNotEmpty(positionIds)) {
                List<Position> updatePositions = new ArrayList<>(positionIds.size());
                for (String positionId : positionIds) {
                    Position position = positionMap.get(positionId);
                    updatePositions.add(position);
                }

                update(updatePositions, Position._category, Position._positionName);
            }
        }

        if (CollectionUtils.isEmpty(savePositionIds)) {
            return positions.size();
        }

        final String addSql = "INSERT INTO T_UC_POSITION(ID,CORP_CODE,CREATE_BY,CREATE_TIME,UPDATE_BY,UPDATE_TIME,POSITION_NAME," +
                "POSITION_STATUS,CATEGORY_ID) VALUES(?,?,?,?,?,?,?,?,?)";
        List<Object[]> allValues = new ArrayList<>();
        for (String positionId : savePositionIds) {
            Position position = positionMap.get(positionId);
            if (StringUtils.isBlank(position.getPositionName())) {
                continue;
            }
            Object[] values = {position.getId(), ExecutionContext.getCorpCode(), ExecutionContext.getUserId(), new Date(),
                    ExecutionContext.getUserId(), new Date(),
                    position.getPositionName(), Position.PositionStatus.ENABLE.toString(), position.getCategoryId()};
            allValues.add(values);
        }

        baseService.getJdbcTemplate().batchUpdate(addSql, allValues);
        return positions.size();
    }

    private Map<String, List<Position>> checkPosition(List<Position> positions) {
        List<String> positionNames = positions.stream().map(Position::getPositionName).collect(Collectors.toList());
        Map<String, List<Position>> dbPositionMap = findNamePath(positionNames);
        Map<String, List<Position>> prePositionMap = new HashMap<>();
        Map<String, String> categoryPathMap = new HashMap<String, String>();//需要新建
        for (Position position : positions) {
            String cateNamePath = position.getCategory().getNamePath();
            List<Position> dbPositions = dbPositionMap.get(position.getPositionName());
            if (CollectionUtils.isEmpty(dbPositions)) {
                if (StringUtils.isNotBlank(categoryPathMap.get(position.getCategoryNamePath())) &&
                        categoryPathMap.get(position.getCategoryNamePath()).equals(position.getPositionName())) {
                    continue;
                }
                List<Position> prePositions = prePositionMap.get(cateNamePath);
                if (prePositions == null) {
                    prePositions = new ArrayList<>();
                    prePositionMap.put(cateNamePath, prePositions);
                }

                prePositions.add(position);
                categoryPathMap.put(cateNamePath, position.getPositionName());
                continue;
            }

            for (Position dbPosition : dbPositions) {
                if (dbPosition.getCategoryNamePath().equals(cateNamePath)) {
                    position.setId(dbPosition.getId());
                    break;
                }
            }

            if (StringUtils.isNotBlank(position.getId())) {
                continue;
            }

            List<Position> prePositions = prePositionMap.get(cateNamePath);
            if (prePositions == null) {
                prePositions = new ArrayList<>();
                prePositionMap.put(cateNamePath, prePositions);
            }

            prePositions.add(position);
            categoryPathMap.put(cateNamePath, position.getPositionName());
        }

        return prePositionMap;
    }

    private List<Position> processPosition(Map<String, String> categoryMap, Map<String, List<Position>> positionMap) {
        Set<String> positionCategoryNames = positionMap.keySet();
        List<Position> positions = new ArrayList<>();
        for (String pCategoryName : positionCategoryNames) {
            String categoryId = categoryMap.get(pCategoryName);//position的类别种类
            List<Position> prePositions = positionMap.get(pCategoryName);
            if (CollectionUtils.isEmpty(prePositions)) {
                continue;
            }

            for (Position position : prePositions) {
                Category category = new Category();
                category.setId(categoryId);
                position.setCategory(category);
                position.setPositionStatus(Position.PositionStatus.ENABLE);
                positions.add(position);
            }
        }

        return positions;
    }
}
