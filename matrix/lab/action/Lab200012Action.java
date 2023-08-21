package com.dc.matrix.lab.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dc.core.action.AbstractAction;
import com.dc.core.action.IBaseAction;
import com.dc.core.exception.DcApplicationException;
import com.dc.core.exception.DcAuthException;
import com.dc.core.util.Pager;
import com.dc.lab.sn.ISnMkr000010Service;
import com.dc.matrix.entity.LabOrderMst;
import com.dc.matrix.lab.service.ILabOrderMstService;
import com.dc.matrix.entity.LabOrderItem;

public class Lab200012Action extends AbstractAction implements IBaseAction{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4471032002094321315L;
	
	private ILabOrderMstService labOrderMstService;
	private LabOrderMst labOrderMst;
	private List<Map<String, Object>> labOrderMstList;
	private ISnMkr000010Service snMkr000010Service;
	
	private List<LabOrderItem> orderItemList;

	@Override
	public String approve() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String init() throws Exception {
		// TODO Auto-generated method stub suffered cardiac arrest
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	@Override
	public String search() throws Exception {
		try {
			Map<String, Object> conditions = new HashMap<String, Object>();
			conditions.put("custId", labOrderMst.getCustMst().getCustId());
			conditions.put("custName", labOrderMst.getCustMst().getCustName());
			conditions.put("orderDate", labOrderMst.getOrderDate());
			conditions.put("orderId", labOrderMst.getOrderId());
			Pager resultPager = getLabOrderMstService().searchByConditions(conditions, getPager(), this.getUserInfo());
			setPager(resultPager);

			labOrderMstList = (List<Map<String, Object>>) resultPager.getData();
			if (labOrderMstList == null || labOrderMstList.isEmpty()) {
				this.addActionError(this.getText("w.0001"));
			}
		} catch (DcApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		} catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		}
		setNextAction(ACTION_SEARCH);
		return SUCCESS;
	}

	@Override
	public String query() throws Exception {
		try {
			labOrderMst = getLabOrderMstService().get(labOrderMst.getOrderId(), getUserInfo());
		}
		catch (DcApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
		catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
		setNextAction(ACTION_QUERY);
		return SUCCESS;
	}

	@Override
	public String create() throws Exception {
		try {
		} catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		}
		setNextAction(ACTION_CREATE_SUBMIT);
		return SUCCESS;
	}

	@Override
	public String createSubmit() throws Exception {
		try {
			if (this.hasConfirm() == true) {
				// 有確認頁
				setNextAction(ACTION_CREATE_CONFIRM);
				return RESULT_CONFIRM;
			} else {
				// 沒有確認頁, 直接存檔
				return this.createConfirm();
			}
		} catch (DcApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
			return RESULT_EDIT;
		} catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
			return RESULT_EDIT;
		}
	}
	
	
	@Override
	public String createConfirm() throws Exception {
		try {
			labOrderMst = getLabOrderMstService().create(labOrderMst, getUserInfo());
			setNextAction(ACTION_CREATE);
			return RESULT_SHOW;
		} catch (DcApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
			setNextAction(ACTION_CREATE_SUBMIT);
			return RESULT_EDIT;
		} catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
			setNextAction(ACTION_CREATE_SUBMIT);
			return RESULT_EDIT;
		}
	}

	@Override
	public String update() throws Exception {
		try {
			labOrderMst = getLabOrderMstService().get(labOrderMst.getOrderId(), getUserInfo());
		} catch (DcApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		} catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		}
		setNextAction(ACTION_UPDATE_SUBMIT);
		return SUCCESS;
	}

	@Override
	public String updateSubmit() throws Exception {
		try {
			if (hasConfirm()) {
				setNextAction(ACTION_UPDATE_CONFIRM);
				return RESULT_CONFIRM;
			} else {
				return this.updateConfirm();
			}
		} catch (DcApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
			setNextAction(ACTION_UPDATE_SUBMIT);
			return RESULT_EDIT;
		} catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
			setNextAction(ACTION_UPDATE_SUBMIT);
			return RESULT_EDIT;
		}
	}

	@Override
	public String updateConfirm() throws Exception {
		try {
			labOrderMst = getLabOrderMstService().update(labOrderMst, getUserInfo());
			setNextAction(ACTION_UPDATE);
			return RESULT_SHOW;
		} catch (DcApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
			setNextAction(ACTION_UPDATE_SUBMIT);
			return RESULT_EDIT;
		} catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
			setNextAction(ACTION_UPDATE_SUBMIT);
			return RESULT_EDIT;
		}
	}

	@Override
	public String delete() throws Exception {
		try {
			labOrderMst = getLabOrderMstService().get(labOrderMst.getOrderId(), getUserInfo());
		} catch (DcApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		} catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		}
		setNextAction(ACTION_DELETE_CONFIRM);
		return SUCCESS;
	}

	@Override
	public String deleteConfirm() throws Exception {
		try {
			labOrderMst = getLabOrderMstService().delete(labOrderMst, getUserInfo());
			setNextAction(ACTION_DELETE);
			return RESULT_SHOW;
		} catch (DcApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
			setNextAction(ACTION_DELETE_CONFIRM);
			return RESULT_CONFIRM;
		} catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
			setNextAction(ACTION_DELETE_CONFIRM);
			return RESULT_CONFIRM;
		}
	}

	@Override
	public String copy() throws Exception {
		try {
			labOrderMst = getLabOrderMstService().get(labOrderMst.getOrderId(), getUserInfo());
		}
		catch (DcApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
		catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
		setNextAction(ACTION_COPY_SUBMIT);
		return SUCCESS;
	}

	@Override
	public String copySubmit() throws Exception {
		try {
			if (this.hasConfirm() == true) {
				setNextAction(ACTION_COPY_CONFIRM);
				return RESULT_CONFIRM;
			}
			else {
				return this.copyConfirm();
			}
		}
		catch (DcApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
			setNextAction(ACTION_COPY_SUBMIT);
			return RESULT_EDIT;
		}
		catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
			setNextAction(ACTION_COPY_SUBMIT);
			return SUCCESS;
		}
	}

	@Override
	public String copyConfirm() throws Exception {
		try {
			labOrderMst = getLabOrderMstService().create(labOrderMst, getUserInfo());
			setNextAction(ACTION_COPY);
			return RESULT_SHOW;
		}
		catch (DcApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
			setNextAction(ACTION_COPY_SUBMIT);
			return RESULT_EDIT;
		}
		catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
			setNextAction(ACTION_COPY_SUBMIT);
			return RESULT_EDIT;
		}
	}
	
	public void validate() {
		try {
			setUpInfo();
		}
		catch (DcAuthException e) {
			throw e;
		}
		catch (DcApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		}
		catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		}
	}
	
	public void validateCreateSubmit() {
		try {
			setUpInfo();
			this.checkPrimaryKey();
		}
		catch (DcAuthException e) {
			throw e;
		}
		catch (DcApplicationException e) {
			// 取得 SQL 錯誤碼，並依多國語系設定顯示於Message box
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
		catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
	}
	
	public void validateCreateConfirm() {
		// 先執行Action所對應的 validate, 再執行 validate(). (即 validateCreateSubmit 執行完後, 再執行 validate())
		try {
			setUpInfo();
			this.checkPrimaryKey();
		}
		catch (DcAuthException e) {
			throw e;
		}
		catch (DcApplicationException e) {
			// 取得 SQL 錯誤碼，並依多國語系設定顯示於Message box
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		}
		catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		}
	}
	
	public void validateUpdateSubmit() {
		// 先執行Action所對應的 validate, 再執行 validate(). (即 validateCreateSubmit 執行完後,再執行 validate())
		try {
			setUpInfo();
		}
		catch (DcAuthException e) {
			throw e;
		}
		catch (DcApplicationException e) {
			// 取得 SQL 錯誤碼，並依多國語系設定顯示於Message box
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		}
		catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		}
	}

	
	public void validateUpdateConfirm() {
		// 先執行Action所對應的 validate, 再執行 validate(). (即 validateCreateSubmit 執行完後, 再執行 validate())
		try {
			setUpInfo();
		}
		catch (DcAuthException e) {
			throw e;
		}
		catch (DcApplicationException e) {
			// 取得 SQL 錯誤碼，並依多國語系設定顯示於Message box
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		}
		catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		}
	}
	
	public void validateDeleteConfirm() {
		try {
			setUpInfo();
		}
		catch (DcAuthException e) {
			throw e;
		}
		catch (DcApplicationException e) {
			// 取得 SQL 錯誤碼，並依多國語系設定顯示於Message box
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		}
		catch (Exception ex) {
			DcApplicationException e = new DcApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		}
	}

	private boolean checkPrimaryKey() throws Exception {
		boolean isValid = true;
		Map<String, Object> conditions = new HashMap<String, Object>();
		conditions.put("orderId", labOrderMst.getOrderId());
		if (labOrderMstService.getDataRowCountByConditions(conditions, this.getUserInfo()) > 0) {
			this.addFieldError("orderId", this.getText("orderId") + this.getText("eP.0004"));
			isValid = false;
		}
		return isValid;
	}
	
	public ILabOrderMstService getLabOrderMstService() {
		return labOrderMstService;
	}

	public void setLabOrderMstService(ILabOrderMstService labOrderMstService) {
		this.labOrderMstService = labOrderMstService;
	}

	public LabOrderMst getLabOrderMst() {
		return labOrderMst;
	}

	public void setLabOrderMst(LabOrderMst labOrderMst) {
		this.labOrderMst = labOrderMst;
	}

	public List<Map<String, Object>> getLabOrderMstList() {
		return labOrderMstList;
	}

	public void setLabOrderMstList(List<Map<String, Object>> labOrderMstList) {
		this.labOrderMstList = labOrderMstList;
	}

	public ISnMkr000010Service getSnMkr000010Service() {
		return snMkr000010Service;
	}

	public void setSnMkr000010Service(ISnMkr000010Service snMkr000010Service) {
		this.snMkr000010Service = snMkr000010Service;
	}

	public List<LabOrderItem> getOrderItemList() {
		return orderItemList;
	}

	public void setOrderItemList(List<LabOrderItem> orderItemList) {
		this.orderItemList = orderItemList;
	}
	
	
}
