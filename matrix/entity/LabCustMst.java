package com.dc.matrix.entity;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.dc.core.entity.TempEntity;

@Entity
@Table(name = "LAB_CUST_MST")
public class LabCustMst extends TempEntity implements Serializable {
	
	private static final long serialVersionUID = -6158836222057191526L;
	
	private String custId;
	private String custName;
	private String custTel;
	private String custAddr;
	private String birthDate;
	private String custLevel;
	private String custStatus;
	private Integer custAge;
	private BigDecimal custRate;
	private BigDecimal custSalary;
	
	@Id
	@Column(name = "CUST_ID")
	public String getCustId() {
		return custId;
	}
	
	public void setCustId(String custId) {
		this.custId = custId;
	}
	
	@Column(name = "CUST_NAME")
	public String getCustName() {
		return custName;
	}
	
	public void setCustName(String custName) {
		this.custName = custName;
	}
	
	@Column(name = "CUST_TEL")
	public String getCustTel() {
		return custTel;
	}
	
	public void setCustTel(String custTel) {
		this.custTel = custTel;
	}
	
	@Column(name = "CUST_ADDR")
	public String getCustAddr() {
		return custAddr;
	}
	
	public void setCustAddr(String custAddr) {
		this.custAddr = custAddr;
	}
	
	@Column(name = "BIRTH_DATE")
	public String getBirthDate() {
		return birthDate;
	}
	
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}
	
	@Column(name = "CUST_LEVEL")
	public String getCustLevel() {
		return custLevel;
	}
	
	public void setCustLevel(String custLevel) {
		this.custLevel = custLevel;
	}
	
	@Column(name = "CUST_STATUS")
	public String getCustStatus() {
		return custStatus;
	}
	
	public void setCustStatus(String custStatus) {
		this.custStatus = custStatus;
	}
	
	@Column(name = "CUST_AGE")
	public Integer getCustAge() {
		return custAge;
	}

	public void setCustAge(Integer custAge) {
		this.custAge = custAge;
	}
	
	@Column(name = "CUST_RATE")
	public BigDecimal getCustRate() {
		return custRate;
	}

	public void setCustRate(BigDecimal custRate) {
		this.custRate = custRate;
	}
	
	@Column(name = "CUST_SALARY")
	public BigDecimal getCustSalary() {
		return custSalary;
	}

	public void setCustSalary(BigDecimal custSalary) {
		this.custSalary = custSalary;
	}

	@Override
	public String[] obtainLocaleFieldNames() {
		return null;
	}
}
