package com.dc.matrix.lab.dao;


import java.util.Map;

import com.dc.core.dao.IGenericDao;
import com.dc.core.entity.UserInfo;
import com.dc.core.exception.dcApplicationException;
import com.dc.core.util.Pager;
import com.dc.matrix.entity.LabCustMst;

public interface ILabCustMstDao extends IGenericDao<LabCustMst, String>{
	
	public Pager searchByConditions(Map<String, Object> conditions, Pager pager, UserInfo userInfo) throws dcApplicationException;
	
	
}
