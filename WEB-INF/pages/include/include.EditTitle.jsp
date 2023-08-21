<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<script type="text/javascript" src="<s:url value="/jquery/jquery.alerts.js"/>"></script>
<div id="systemInfo" title="Basic dialog" style="display:none;background-color: #d6e0ef">
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
<%-- 批次覆核 --%><s:include value="/WEB-INF/pages/include/include.BatchScript.jsp" /><%-- /批次覆核 --%>
<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
	<tr>
		<td width="10"><img src="<s:url value="/images/title-tab-left.gif"/>" width="10" height="34" /></td>
		<td width="180" align="left" class="progTitle12px" background="<s:url value="/images/title-tab-back.gif"/>"><label id="lblProgAction"><s:text name="%{'title.' + progAction}" /></label></td>
		<td align="center" background="<s:url value="/images/title-tab-back.gif"/>">
			<label><s:property value="progInfo.progSn" />&nbsp;<s:property value="progInfo.progName" />&nbsp;(<s:property value="progId"/>)</label>
			<s:hidden name="progId"/><s:hidden name="progAction"/><s:hidden name="apvKey"/>
		</td>
		<td width="200" align="right" class="progTitle12px" background="<s:url value="/images/title-tab-back.gif"/>">
			<label><s:property value="userInfo.userMst.userId" /></label><label>(<s:property value="userInfo.execTime" />)</label>
		</td>
		<td width="10"><img src="<s:url value="/images/title-tab-right.gif"/>" width="10" height="34" /></td>
	</tr>
</table>