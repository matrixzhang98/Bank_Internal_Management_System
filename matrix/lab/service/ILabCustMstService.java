package com.dc.matrix.lab.service;

import java.util.Map;

import com.dc.core.entity.UserInfo;
import com.dc.core.exception.dcApplicationException;
import com.dc.core.service.IBaseCRUDService;
import com.dc.core.service.IBaseSearchService;
import com.dc.matrix.entity.LabCustMst;

public interface ILabCustMstService extends IBaseCRUDService<LabCustMst, String>, IBaseSearchService<LabCustMst, String>{

	public int getDataRowCountByConditions(Map<String, Object> conditions, UserInfo info) throws dcApplicationException;
	
}
