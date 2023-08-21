<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="progInfo.queryAction eq \"1\""><input type="image" class="imgViewAct" src="<s:url value="/image_icons/view.png"/>" title="<s:text name="fix.00184"/>"></s:if>
<s:if test="progInfo.copyAction eq \"1\""><input type="image" class="imgCopyAct" src="<s:url value="/image_icons/copy.png"/>" title="<s:text name="fix.00192"/>"></s:if>
<s:if test='progDataStatus == \"1\"'>
<s:if test="progInfo.updAction eq \"1\""><input type="image" class="imgUpdAct" src="<s:url value="/image_icons/alter.png"/>" title="<s:text name="fix.00185"/>"></s:if>
<s:if test="progInfo.delAction eq \"1\""><input type="image" class="imgDelAct" src="<s:url value="/image_icons/delete.png"/>" title="<s:text name="fix.00182"/>"></s:if>
</s:if>
<s:else>
<s:if test="progInfo.updAction eq \"1\""><input type="image" class="imgUpdAct" src="<s:url value="/image_icons/load.png"/>" title="<s:text name="fix.00185"/>"></s:if>
<s:if test="progInfo.delAction eq \"1\""><input type="image" class="imgDelAct" src="<s:url value="/image_icons/reject.png"/>" title="<s:text name="fix.00183"/>"></s:if>
</s:else>
