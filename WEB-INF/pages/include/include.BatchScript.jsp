<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%-- 批次覆核 --%>
<s:hidden id="progDataStatus" name="progDataStatus"/>	
<s:if test="progAction.startsWith('create')"><s:hidden name="progActionApvStatus" value="%{progInfo.addApprove}"/></s:if>
<s:elseif test="progAction.startsWith('update')"><s:hidden name="progActionApvStatus" value="%{progInfo.updApprove}"/></s:elseif>
<s:elseif test="progAction.startsWith('copy')"><s:hidden name="progActionApvStatus" value="%{progInfo.copyApprove}"/></s:elseif>
<s:elseif test="progAction.startsWith('delete')"><s:hidden name="progActionApvStatus" value="%{progInfo.delApprove}"/></s:elseif>
<s:elseif test="progAction.startsWith('save')"><s:hidden name="progActionApvStatus" value="%{progInfo.saveApprove}"/></s:elseif>
<%-- /批次覆核 --%>