<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/pages/include/include.Taglib.jsp"%>
<html>
<head>
<title></title>
<s:include value="/WEB-INF/pages/include/include.Scripts.jsp" />
<script type="text/javascript" src="<s:url value="/jquery/ui/jquery.ui.datepicker.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/jquery/jquery.alphanumeric.js"/>"></script>
<script type="text/javascript" src="<s:url value="/dcPlugin/dc.gridList.plugin.js"/>"></script>
<script type="text/javascript" src="<s:url value="/dcPlugin/dc.popupWindow.plugin.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/dc.input.js"/>"></script>
<script language="javascript">
function getParameter() {	
	var param = "labOrderMst.orderId=" + $("#tblGrid").getSelectedRow().find('td').eq(2).text(); 
	return param;
}

$(document).ready(function() {
	$("#tblGrid").initGrid({lines:2});
	$('#tb').initPopupWindow({dailogWidth:'800', dailogHeight:'300'});
});
</script>
</head>
<body>
<s:form theme="simple" action="%{progAction}" >
	<div class="progTitle">
  		<s:include value="/WEB-INF/pages/include/include.Title.jsp" />
	</div>
	<div id="tb">
		<fieldset style="-moz-border-radius:8px;">
		<table width="100%" border="0" cellpadding="2" cellspacing="0">
			<tr class="trBgOdd">
				<td width="20%" class="colNameAlign">&nbsp;<s:text name="custId"/>：</td>
				<td width="30%"><s:textfield name="labOrderMst.custMst.custId" maxlength="10" size="16"/></td>
				<td width="20%" class="colNameAlign">&nbsp;<s:text name="custName"/>：</td>
				<td width="30%"><s:textfield name="labOrderMst.custMst.custName" maxlength="32" size="32"/></td>
			</tr>
			<tr class="tblGrid">
				<td width="20%" class="colNameAlign">&nbsp;<s:text name="orderDate"/>：</td>
				<td width="30%"><s:textfield name="labOrderMst.orderDate" maxlength="10" size="10" cssClass="inputDate"/></td>
				<td width="20%" class="colNameAlign">&nbsp;<s:text name="orderId"/>：</td>
				<td width="30%"><s:textfield name="labOrderMst.orderId" maxlength="32" size="32"/>
				</td>
			</tr>
		</table>
		<!-- 按鍵組合 --><s:include value="/WEB-INF/pages/include/include.ListButton.jsp" /><!-- 按鍵組合 -->
		</fieldset>
		<table id="tblGrid" class ="gridList" width="100%" border="0" cellpadding="2" cellspacing="1">
			<thead>
				<tr align="center" bgcolor="#e3e3e3">
					<th width="30"><s:text name="fix.00164" /></th>
					<th width="120"><s:text name="fix.00090" /></th>
					<th width="15%"><s:text name="custId" /></th>
					<th width="20%"><s:text name="custName" /></th>
					<th width="10%"><s:text name="orderDate" /></th>
					<th width="10%"><s:text name="shipDate" /></th>
					<th width="10%"><s:text name="orderAmt" /></th>
					<th><s:text name="orderStatus" /></th>
				 </tr>
			 </thead>
			 <tbody>
			 <s:iterator value="labOrderMstList" status="status" >
			 	<tr>
					<td width="30" id="sn" align="center"><s:property value="#status.index+1" /></td>
					<!-- 表單按鍵 -->
					<td width="120"><s:include value="/WEB-INF/pages/include/include.actionButton.jsp" /></td>
					<!-- 表單按鍵 -->
					<td width="15%"><label><s:property value="custId" /></label></td>
					<td width="20%"><label><s:property value="custName" /></label></td>
					<td width="10%" style="text-align:center"><label><s:property value="orderDate" /></label></td>
					<td width="10%" style="text-align:center"><label><s:property value="shipDate" /></label></td>
					<td width="10%" style="text-align:right"><label><s:property value="orderAmt" /></label></td>
					<td style="text-align:center">
						<label>
							<s:if test="orderStatus == '0'"><s:property value="orderStatus" />-<s:text name="orderStatus.0" /></s:if>
							<s:elseif test="orderStatus == '1'"><s:property value="orderStatus" />-<s:text name="orderStatus.1" /></s:elseif>
							<s:elseif test="orderStatus == '2"><s:property value="orderStatus" />-<s:text name="orderStatus.2" /></s:elseif>
							<s:elseif test="orderStatus == '9"><s:property value="orderStatus" />-<s:text name="orderStatus.9" /></s:elseif>
						</label>
					</td>
				</tr>
			 </s:iterator>
			 </tbody>
		</table>
	</div>
	<!-- 分頁按鍵列 --><s:include value="/WEB-INF/pages/include/include.PaginationBar.jsp" /><!-- 分頁按鍵列 -->
</s:form>
</body>
</html>