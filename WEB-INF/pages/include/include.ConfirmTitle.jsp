<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>	
<div id="systemInfo" title="Basic dialog" style="background-color: #d6e0ef;display: none;">
<ul>
<s:iterator value="fieldErrors">
<li <s:if test="value[0] == \"~ ~\"">style="display: none"</s:if>><a lang="<s:property value="key"/>" <s:if test="value.size eq 2">language="<s:property value="value[1]"/>"</s:if>><s:property value="value[0]" escapeHtml="false"/></a></li>
</s:iterator>
<s:iterator value="actionMessages">
<li><s:property escapeHtml="false" /></li>
</s:iterator>
</ul>
</div>
<div id="divDialogMsg" style="display:none"><s:iterator value="actionErrors" status="stat"><s:property escapeHtml="false"/><s:if test="!#stat.last"><BR></s:if></s:iterator></div>

<%-- 批次覆核 --%>
<s:if test="progAction.startsWith('delete')">
	<s:include value="/WEB-INF/pages/include/include.BatchScript.jsp" />
</s:if>
<s:else>
	<s:hidden name="progDataStatus"/>
	<s:hidden name="progActionApvStatus"/>
</s:else>	
<%-- /批次覆核 --%>

<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
	<tr>
		<td width="10"><img src="<s:url value="/images/title-tab-left.gif"/>" width="10" height="34" /></td>
		<td width="180" align="left" class="progTitle12px" background="<s:url value="/images/title-tab-back.gif"/>"><label id="lblProgAction"><s:text name="%{'title.' + progAction}" /></label></td>
		<td align="center" background="<s:url value="/images/title-tab-back.gif"/>">
			<label><s:property value="progInfo.progSn" />&nbsp;<s:property value="progInfo.progName" />&nbsp;(<s:property value="progId"/>)</label>
			<s:hidden name="progId"/><s:hidden name="progAction"/>
			
		</td>
		<td width="200" align="right" class="progTitle12px" background="<s:url value="/images/title-tab-back.gif"/>">
			<label><s:property value="userInfo.userMst.userId" /></label><label>(<s:property value="userInfo.execTime" />)</label>
		</td>
		<td width="10"><img src="<s:url value="/images/title-tab-right.gif"/>" width="10" height="34" /></td>
	</tr>
</table>
<%--主管覆核 Star--%>
<s:if test="hasApprove(progAction) == true && hasActionErrors() == false && hasFieldErrors() == false">
	<link rel="stylesheet" type="text/css" href="<s:url value="/css/jquery.countdown.css"/>"></link>
	<script type="text/javascript" src="<s:url value="/jquery/jquery.countdown.min.js"/>"></script>
	<script type="text/javascript" src="<s:url value="/dcPlugin/dc.director.js"/>"></script>
	<s:if test="apvStatus == \"-2\" ">
	<div id="apvSelect" class="dc-approv dc-approv-style" style="display:none;">
		<div class="dc-approv-titlebar">
			<a class="dc-approv-titlebar-close" href="#" onClick="apvClose();"><span class="dc-approv-icon dc-approv-icon-closethick">close</span></a>
		</div>
			<table width="100%" border="0" cellpadding="4" cellspacing="0" > 
	            <tr>
	                <td width="20%" class="colNameAlign required">*<s:text name="fix.00194"/>：</td>
	                <td align="left">
	                    <select id="apvMg">
						<s:iterator value="apvMgrList" status="status" var="obj" >
	                        <option value="<s:property value="%{#obj[0]}" />"><s:property value="%{#obj[0]}" /> - <s:property value="%{#obj[1]}" /></option>
						</s:iterator>
	                    </select>&nbsp;&nbsp;
						<s:if test="errorMessage == null">
	                    <button id="apvBtnSmt" type="button" onClick="apvSelect();"><s:text name="fix.00190" /></button>
	                    <button id="btnCancel" type="button" onClick="apvClose();"><s:text name="fix.00183"/></button>
						</s:if>
	                </td>
	            </tr>
	            <tr>
	                <td width="20%" class="colNameAlign">&nbsp;<s:text name="fix.00021"/>：</td>
	                <td><div id="errorMessage" style="font-weight:bold;text-align:left;line-height:30px;max-height:62px;overflow:hidden;"><s:property value="errorMessage"/></div></td>
				</tr>
			</table>
	</div>
	<%-- 挑選主管  --%>
	<script language="javascript">
	$(document).ready(function() {
		popUpWinApvSelect();
	});
	</script>         
	<%-- 挑選主管-End --%>
	</s:if>
	<s:elseif test="apvStatus == \"0\" ">
		<s:if test="progAction.startsWith('create')"><s:hidden id="progActionApvStatus" value="%{progInfo.addApprove}" disabled="true"/></s:if>
		<s:elseif test="progAction.startsWith('update')"><s:hidden id="progActionApvStatus" value="%{progInfo.updApprove}" disabled="true"/></s:elseif>
		<s:elseif test="progAction.startsWith('copy')"><s:hidden id="progActionApvStatus" value="%{progInfo.copyApprove}" disabled="true"/></s:elseif>
		<s:elseif test="progAction.startsWith('delete')"><s:hidden id="progActionApvStatus" value="%{progInfo.delApprove}" disabled="true"/></s:elseif>
		<s:elseif test="progAction.startsWith('save')"><s:hidden id="progActionApvStatus" value="%{progInfo.saveApprove}" disabled="true"/></s:elseif>
		<s:elseif test="progAction.startsWith('process')"><s:hidden id="progActionApvStatus" value="%{progInfo.processApprove}" disabled="true"/></s:elseif>
		<div id="blockMesage" class="dc-approv dc-approv-style" style="display:none;">
			<div id="defaultCountdown">
				<span class="countdown_row countdown_amount" style="padding-top:2px;">{mnn}{sep}{snn}</span>
			</div>
			<div id="detailMessage">
		        <table width="100%" border="0" cellpadding="0" cellspacing="0" > 
		            <tr>
		                <td width="20%" class="colNameAlign required">*<s:text name="fix.00194"/>：</td>
		                <td align="left"><label id="approveId" style="font-size: 12px;"></label></td>
		            </tr>
		            <tr>
		                <td width="20%" class="colNameAlign">&nbsp;<s:text name="fix.00014"/>：</td>
		                <td align="left"><label id="approveState" style="font-size: 12px;"></label></td>
		            </tr>
		            <%-- 
		            <tr>
		                <td width="20%" class="colNameAlign">&nbsp;<s:text name="fix.00026"/>：</td>
		                <td align="left"><label id="lbl_apvComment" style="font-size: 12px;"></label></td>
		            </tr>
		            --%>
		            <tr>
		                <td colspan="2" align="center">
		                    <button id="btnCancel" type="button" onclick="btnCancel_onClick()"><s:text name="fix.00183"/></button>
		                    <label id="apvTime" style="display: none;"><s:property value="#application.sysParam.apvPoolingTime"/></label>
		                    <label id="apvState00009" class="approveState" style="display: none;"><s:text name="fix.00009"/></label><%-- 主管已放行 --%>
		                    <label id="apvState00010" class="approveState" style="display: none;"><s:text name="fix.00010"/></label><%-- 主管已退回 --%>
		                    <label id="apvState00026" class="approveState" style="display: none;"><s:text name="fix.00026"/></label>
		                    <label id="apvState02759" class="approveState" style="display: none;"><s:text name="fix.02759"/></label><%-- 主管已放行，不可取消 --%>
		                    <label id="apvState02760" class="approveState" style="display: none;"><s:text name="fix.02760"/></label><%-- 主管已退回，不可取消 --%>
		                    <label id="apvState02761" class="approveState" style="display: none;"><s:text name="fix.02761"/></label><%-- 等待時間到，主管已放行 --%>
		                    <label id="apvState02762" class="approveState" style="display: none;"><s:text name="fix.02762"/></label><%-- 等待時間到，主管已退回 --%>
		                    <label id="apvState02763" class="approveState" style="display: none;"><s:text name="fix.02763"/></label><%-- 等待中 --%>
		                </td>
		            </tr>
		        </table>
		    </div>
		</div>
			<script language="javascript">
	        $(document).ready(function() {
	        	popUpWinApvWait();
	        });
	      </script>   
	</s:elseif> 
	<s:hidden id="apvMgrId" name="apvMgrId"/>
	<s:hidden id="apvKey" name="apvKey"/>
	<s:hidden id="ognlApvKey" name="ognlApvKey" value="%{mgrApvCount == null || mgrApvCount == 0 ? apvKey : ognlApvKey }"/>
	<s:hidden id="apvStatus" name="apvStatus"/>
	<s:hidden id="mgrApvCount" name="mgrApvCount" value="%{mgrApvCount == null ? '0' : mgrApvCount }"/>
</s:if>
<%--主管覆核 End--%>