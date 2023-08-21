package com.dc.matrix.lab.service.impl;

import java.util.List;
import java.util.Map;

import com.dc.core.entity.UserInfo;
import com.dc.core.exception.dcApplicationException;
import com.dc.core.util.BeanUtilsHelper;
import com.dc.core.util.Pager;
import com.dc.matrix.entity.LabCustMst;
import com.dc.matrix.lab.dao.ILabCustMstDao;
import com.dc.matrix.lab.service.ILabCustMstService;

public class LabCustMstServiceImpl implements ILabCustMstService{
	
	private ILabCustMstDao labCustMstDao;

	@Override
	public LabCustMst get(String id, UserInfo info) throws dcApplicationException {
		try {
			return labCustMstDao.get(id, info);
		}
		catch (dcApplicationException e) {
			throw e;
		}
		catch (Exception e) {
			throw new dcApplicationException(e, info);
		}
	}

	@Override
	public LabCustMst create(LabCustMst entity, UserInfo info) throws dcApplicationException {
		try {
			return this.getLabCustMstDao().save(entity, info);			
		}
		catch (dcApplicationException e) {
			throw e;
		}
		catch (Exception e) {
			throw new dcApplicationException(e, info);
		}
	}

	@Override
	public LabCustMst update(LabCustMst entity, UserInfo info) throws dcApplicationException {
		try {			
			LabCustMst po = this.getLabCustMstDao().get(entity.getCustId(), info);
			if (entity.getVer().getTime() == po.getVer().getTime()) {
				BeanUtilsHelper.copyProperties(po, entity, entity.obtainLocaleFieldNames());
				getLabCustMstDao().update(po, info);
				return po;
			}
			else {
				throw new dcApplicationException(dcApplicationException.dcEXCEPTION_TYPE_ERROR, "eP.0013");
			}
		}
		catch (dcApplicationException e) {
			throw e;
		}
		catch (Exception e) {
			throw new dcApplicationException(e, info);
		}
	}

	@Override
	public LabCustMst delete(LabCustMst entity, UserInfo info) throws dcApplicationException {
		try {
			LabCustMst po = getLabCustMstDao().get(entity.getCustId(), info);
			if (entity.getVer().getTime() == po.getVer().getTime()) {
				getLabCustMstDao().delete(po, info);
				//
				return entity;
			}
			else {
				throw new dcApplicationException(dcApplicationException.dcEXCEPTION_TYPE_ERROR, "eP.0013");
			}
		}
		catch (dcApplicationException e) {
			throw e;
		}
		catch (Exception e) {
			throw new dcApplicationException(e, info);
		}
	}

	@Override
	public List<LabCustMst> searchAll(UserInfo info) throws dcApplicationException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Pager searchByConditions(Map<String, Object> conditions, Pager pager, UserInfo userInfo) throws dcApplicationException {
		return labCustMstDao.searchByConditions(conditions, pager, userInfo);
	}

	@Override
	public List<LabCustMst> searchByConditions(Map<String, Object> conditions, UserInfo userInfo) throws dcApplicationException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object> queryDataByParamsByService(Map<String, Object> conditions, UserInfo userInfo) throws dcApplicationException {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public int getDataRowCountByConditions(Map<String, Object> conditions, UserInfo info) throws dcApplicationException {
		return this.labCustMstDao.getDataRowCountByConditions(conditions, info);
	}

	public ILabCustMstDao getLabCustMstDao() {
		return labCustMstDao;
	}

	public void setLabCustMstDao(ILabCustMstDao labCustMstDao) {
		this.labCustMstDao = labCustMstDao;
	}

	
	
}
