package com.qgutech.pe.module.uc.service;

import com.qgutech.pe.base.ExecutionContext;
import com.qgutech.pe.base.model.Category;
import com.qgutech.pe.base.service.BaseServiceImpl;
import com.qgutech.pe.base.service.CategoryService;
import com.qgutech.pe.constant.PeConstant;
import com.qgutech.pe.module.uc.model.Organize;
import com.qgutech.pe.module.uc.model.Position;
import com.qgutech.pe.module.uc.model.User;
import com.qgutech.pe.module.uc.model.UserPosition;
import com.qgutech.pe.utils.PeException;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户岗位关联 service impl
 *
 * @author LiYanCheng@HF
 * @version 1.0.0
 * @since 2016年10月27日19:53:25
 */
@Service("userPositionService")
public class UserPositionServiceImpl extends BaseServiceImpl<UserPosition> implements UserPositionService {
    @Resource
    private CategoryService categoryService;

    @Override
    @Transactional(readOnly = true)
    public Map<String, List<Position>> findByUserId(List<String> userIds) {
        if (CollectionUtils.isEmpty(userIds)) {
            throw new PeException("UserId list is empty!");
        }

        Criterion criterion = Restrictions.and(
                Restrictions.eq(UserPosition._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.in(UserPosition._user, userIds));
        List<UserPosition> userPositions = listByCriterion(criterion, UserPosition._positionAlias, UserPosition._positionName, UserPosition._user);
        if (CollectionUtils.isEmpty(userPositions)) {
            return new HashMap<>(0);
        }

        Map<String, List<Position>> positionMap = new HashMap<>(userIds.size());
        for (UserPosition userPosition : userPositions) {
            List<Position> positions = positionMap.get(userPosition.getUser().getId());
            if (positions == null) {
                positions = new ArrayList<>();
                positionMap.put(userPosition.getUser().getId(), positions);
            }

            Position position = userPosition.getPosition();
            position.setPositionName(userPosition.getPosition().getPositionName());
            positions.add(position);
        }

        return positionMap;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Position> listByUserId(String userId) {
        if (StringUtils.isBlank(userId)) {
            throw new IllegalArgumentException("UserId is blank!");
        }

        Criterion criterion = Restrictions.and(
                Restrictions.eq(UserPosition._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.eq(UserPosition._user, userId));
        List<UserPosition> userPositions = listByCriterion(criterion, new Order[]{Order.desc(UserPosition._createTime)},
                UserPosition._position, UserPosition._positionName, UserPosition._positionAlias);
        if (CollectionUtils.isEmpty(userPositions)) {
            return new ArrayList<>(0);
        }

        List<Position> positions = new ArrayList<>(userPositions.size());
        for (UserPosition userPosition : userPositions) {
            Position position = userPosition.getPosition();
            position.setCategoryName(position.getCategory().getCategoryName());
            positions.add(position);
        }
        return positions;
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int deleteByUserId(List<String> userIds) {
        if (CollectionUtils.isEmpty(userIds)) {
            throw new PeException("UserId list is blank!");
        }

        Criterion criterion = Restrictions.and(
                Restrictions.eq(UserPosition._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.in(UserPosition._user, userIds)
        );

        return delete(criterion);
    }

    @Override
    @Transactional(readOnly = true)
    public String getPositionByUserId(String userId) {
        if (StringUtils.isBlank(userId)) {
            throw new IllegalArgumentException("UserId is null!");
        }

        List<Position> positions = listByUserId(userId);
        if (CollectionUtils.isEmpty(positions)) {
            return null;
        }

        StringBuilder stringBuilder = new StringBuilder();
        for (int index = 0; index < positions.size(); index++) {
            stringBuilder.append(positions.get(index).getPositionName());
            if (index != (positions.size() - 1)) {
                stringBuilder.append(PeConstant.COMMA);
            }
        }

        return stringBuilder.toString();
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int deleteByPositionId(String positionId) {
        if (StringUtils.isBlank(positionId)) {
            throw new IllegalArgumentException("PositionId is null!");
        }
        Criterion criterion = Restrictions.and(
                Restrictions.eq(UserPosition._corpCode, ExecutionContext.getCorpCode()),
                Restrictions.eq(UserPosition._position, positionId)
        );
        return delete(criterion);
    }
}
