<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/pages/include/include.Taglib.jsp"%>
<html>
<head>
<title></title>
<base target="_self" />
<s:include value="/WEB-INF/pages/include/include.Scripts.jsp" />
</head>
<body>
<s:form method="post" theme="simple" action="%{progAction}" >
	<s:hidden name="labCustMst.ver" />
	<div class="progTitle">
		<s:include value="/WEB-INF/pages/include/include.ConfirmTitle.jsp" />
	</div>
	<div id="tb">
		<table width="100%" border="0" cellpadding="4" cellspacing="0" >
			<tr class="trBgOdd">
				<td width="20%" class="colNameAlign required">*<s:text name="custId" />：</td>
				<td width="30%"><s:hidden name="labCustMst.custId" /><label><s:property value="labCustMst.custId" /></label></td>
				<td width="20%" class="colNameAlign required">*<s:text name="custName" />：</td>
				<td width="30%"><s:hidden name="labCustMst.custName" /><label><s:property value="labCustMst.custName" /></label></td>
			</tr>
			<tr class="trBgEven">
				<td width="20%" class="colNameAlign required">*<s:text name="custTel" />：</td>
				<td width="30%"><s:hidden name="labCustMst.custTel" /><label><s:property value="labCustMst.custTel" /></label></td>
				<td width="20%" class="colNameAlign">&nbsp;<s:text name="birthDate" />：</td>
				<td width="30%"><s:hidden name="labCustMst.birthDate" /><label><s:property value="labCustMst.birthDate" /></label></td>
			</tr>
			<tr class="trBgOdd">
				<td width="20%" class="colNameAlign required">*<s:text name="custAddr" />：</td>
				<td width="30%"><s:hidden name="labCustMst.custAddr" /><label><s:property value="labCustMst.custAddr" /></label></td>
				<td width="20%">&nbsp;</td>
				<td width="30%">&nbsp;</td>
			</tr>
			<tr class="trBgEven">
				<td width="20%" class="colNameAlign required">*<s:text name="custLevel" />：</td>
				<td width="30%"><s:hidden name="labCustMst.custLevel" />
					<label><s:if test="labCustMst.custLevel == 0"><s:text name="custLevel.0" /></s:if></label>
					<label>	<s:elseif test="labCustMst.custLevel == 1"><s:text name="custLevel.1" /></s:elseif></label>
					<label>	<s:elseif test="labCustMst.custLevel == 2"><s:text name="custLevel.2" /></s:elseif></label>
				</td>
				<td width="20%" class="colNameAlign required">*<s:text name="custStatus" />：</td>
				<td width="30%"><s:hidden name="labCustMst.custStatus" />
					<label><s:if test="labCustMst.custStatus == 0"><s:text name="custStatus.0" /></s:if></label>
					<label>	<s:elseif test="labCustMst.custStatus == 1"><s:text name="custStatus.1" /></s:elseif></label>
				</td>
			</tr>
		</table>
	</div>
	<br>
	<!-- 按鍵組合 --> 
	<s:include value="/WEB-INF/pages/include/include.ConfirmButton.jsp" />
	<!-- 按鍵組合 -->
</s:form>
</body>
</html>