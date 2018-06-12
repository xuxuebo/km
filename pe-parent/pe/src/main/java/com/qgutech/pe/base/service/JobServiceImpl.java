package com.qgutech.pe.base.service;

import com.qgutech.pe.base.job.JobConstant;
import com.qgutech.pe.base.model.PeJob;
import com.qgutech.pe.base.redis.PeJedis;
import com.qgutech.pe.utils.PeDateUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Disjunction;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

import static com.qgutech.pe.base.model.BaseModel._id;

@Service("jobService")
public class JobServiceImpl extends BaseServiceImpl<PeJob> implements JobService {

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public String save(PeJob job) {
        if (job == null || StringUtils.isBlank(job.getFunctionCode())
                || StringUtils.isBlank(job.getCronExpression())) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        job.setExecuteStatus(PeJob.ExecuteStatus.NO_START);
        return super.save(job);
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public String save(String functionCode, Date date, String sourceId) {
        if (StringUtils.isBlank(functionCode) || date == null ||
                StringUtils.isBlank(sourceId)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        PeJob peJob = new PeJob();
        peJob.setCronExpression(PeDateUtils.format(date, JobConstant.QUARTZ_EXPRESSION_FORMAT));
        peJob.setFunctionCode(functionCode);
        peJob.setSourceId(sourceId);
        return save(peJob);
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int update(String sourceId, PeJob job, String... fields) {
        if (StringUtils.isBlank(sourceId) || job == null) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        Conjunction conjunction = Restrictions.conjunction();
        conjunction.add(Restrictions.eq(PeJob._sourceId, sourceId));
        return updateByCriterion(conjunction, job, fields);
    }

    @Override
    @Transactional(readOnly = true)
    public PeJob getBySourceId(String sourceId, String... fields) {
        if (StringUtils.isBlank(sourceId)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        return getBySource(sourceId);
    }

    @Transactional(readOnly = true)
    public PeJob getBySource(String sourceId) {
        if (StringUtils.isBlank(sourceId)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }
        return getByCriterion(Restrictions.eq(PeJob._sourceId, sourceId));
    }

    @Override
    @Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
    public int deleteBySourceId(String sourceId) {
        if (StringUtils.isBlank(sourceId)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        Conjunction conjunction = Restrictions.conjunction();
        conjunction.add(Restrictions.eq(PeJob._sourceId, sourceId));
        return delete(conjunction);
    }

    @Override
    @Transactional(readOnly = true)
    public List<PeJob> list(PeJob.ExecuteStatus... status) {
        if (status == null || ArrayUtils.isEmpty(status)) {
            throw new IllegalArgumentException("Parameters is not valid!");
        }

        Disjunction disjunction = Restrictions.disjunction();
        disjunction.add(Restrictions.in(PeJob._executeStatus, Arrays.asList(status)));
        disjunction.add(Restrictions.eq(PeJob._cycle, Boolean.TRUE));
        return listByCriterion(disjunction);
    }
}
