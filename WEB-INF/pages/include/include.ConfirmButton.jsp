<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<div align="center" id="toolbar" class="toolbar ui-widget-header ui-corner-all">
	<s:set var="isBatch" value="false"/>
	<s:if test="progAction.startsWith('delete') && progInfo.delApprove == \"3\" && progDataStatus == \"1\""><button id="btnSpvrSmt" type="button"><s:text name="fix.01849"/></button><s:set var="isBatch" value="true"/></s:if>
	<s:else><button id="btnOka" type="button"><s:text name="fix.00190"/></button></s:else>
	<s:if test="progAction != 'deleteConfirm'"><button id="btnPrv" type="button"><s:text name="fix.00044"/></button></s:if>
	&nbsp;&nbsp;
	<s:if test="progInfo.screenAction eq \"1\""><button id="btnPrt" type="button"><s:text name="fix.00193"/></button></s:if>
	<button id="btnCls" type="button"><s:text name="fix.00004"/></button>
</div>
<script type="text/javascript"> 
$(document).ready(function() {
<s:if test="#isBatch == true">
	$("#btnSpvrSmt").click(function() {
		$("form").attr("action", $("form").attr("action").replace("Confirm", "Flow"));
           openBlockUI();
           $("form").submit();
	});
</s:if>
<s:else>
	$("#btnOka").click(function() {
		if (typeof(resetAction) == "function") {
			<%-- 當為多筆+分頁維護(僅可勾選資料)時, 用以處理[送出] Or [分頁]的機制 --%>
			resetAction();
		}
		openBlockUI();
		$("form").submit();
	});
</s:else>
	<s:if test="progAction != 'deleteConfirm'">
	$("#btnPrv").click(function() {
		if (window.name.indexOf("ifrConfirm") >= 0) {
			window.parent.document.forms[0].style.display = "inline";    
			window.parent.document.all[window.name].style.display = "none";
		}
		return false;
	});
	</s:if>
	<s:if test="progInfo.screenAction eq \"1\"">
	$("#btnPrt").click(function() {
		window.print();
		return false;
	});
    </s:if>
	if (history.length > 0) {
		$("#btnCls").hide();
	}
	else {
		$("#btnCls").click(function() {
			if (typeof(parent.unbindUnload) == "function") {
				parent.unbindUnload();
			}				
			window.close();	
			return false;
		});
	}
	
	<s:if test="hasFieldErrors()">
		$("#systemInfo").dialog("open");
	</s:if>
});
</script>