package com.dc.matrix.lab.dao.hibernate;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.dc.core.dao.hibernate.GenericDaoHibernate;
import com.dc.core.entity.UserInfo;
import com.dc.core.exception.dcApplicationException;
import com.dc.core.util.LocaleDataHelper;
import com.dc.core.util.Pager;
import com.dc.matrix.entity.LabCustMst;
import com.dc.matrix.lab.dao.ILabCustMstDao;

public class LabCustMstDaoHibernate extends GenericDaoHibernate<LabCustMst, String> implements ILabCustMstDao {
	public Pager searchByConditions(Map<String, Object> conditions, Pager pager, UserInfo userInfo) throws dcApplicationException {
		List<Object> values = new ArrayList<Object>();
		String lang = LocaleDataHelper.getPropertityWithLocalUpper("", userInfo.getLocale());
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT LCM.CUST_ID custId, LCM.CUST_NAME custName, ");
		sb.append(" LCM.CUST_TEL custTel, LCM.CUST_LEVEL custLevel, LCM.CUST_STATUS custStatus ");
		sb.append("FROM LAB_CUST_MST LCM ");
		String sWhere = " WHERE ";
		if (StringUtils.isNotEmpty((String) conditions.get("custId"))) {
			sb.append(sWhere + " LCM.CUST_ID LIKE ? "); 
			values.add(conditions.get("custId") + "%");
			sWhere = " AND ";
		}
		
		if (StringUtils.isNotEmpty((String) conditions.get("custName"))) {
			sb.append(sWhere + " LCM.CUST_NAME LIKE ? ");
			values.add("%" + conditions.get("custName") + "%");
			sWhere = " AND ";
		}
		
		if (conditions.get("custLevel") != null && !((List<String>) conditions.get("custLevel")).isEmpty()) {
			List<String> custLevelList = (List<String>) conditions.get("custLevel");
			sb.append(sWhere + " ( ");
			for(int i = 0; i < custLevelList.size(); i++) {
				if(i > 0) {
					sb.append(" OR ");
				}
				sb.append(" LCM.CUST_LEVEL = ? ");
				values.add(custLevelList.get(i));
			}
			sb.append(" ) ");
			sWhere = " AND ";
		}
		
		if (conditions.get("custStatus") != null && !((List<String>) conditions.get("custStatus")).isEmpty()) {
			List<String> custStatusList = (List<String>) conditions.get("custStatus");
			sb.append(sWhere + " ( ");
			for(int i = 0; i < custStatusList.size(); i++) {
				if(i > 0) {
					sb.append(" OR ");
				}
				sb.append(" LCM.CUST_STATUS = ? ");
				values.add(custStatusList.get(i));
			}
			sb.append(" ) ");
			sWhere = " AND ";
		}

		sb.append("ORDER BY LCM.CUST_ID ");

		return super.findBySQLQueryMapPagination(sb.toString(), pager, null, values, userInfo);
	}
	
	public int getDataRowCountByConditions(Map<String, Object> conditions, UserInfo info) throws dcApplicationException {
		DetachedCriteria crit = DetachedCriteria.forClass(LabCustMst.class);
		for (Iterator<String> itr = conditions.keySet().iterator(); itr.hasNext();) {
			String key = itr.next();
			crit.add(Restrictions.eq(key, conditions.get(key)));
		}
		return super.getRowCount(crit);
	}
	
}