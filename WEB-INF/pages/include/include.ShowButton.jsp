<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="getActionMapping().name != \"approve\"">
<s:include value="/WEB-INF/pages/include/include.SignArea.jsp" />
<div align="center" id="toolbar"
	<s:if test="#session.userInfo.prodMst.prodCode == \"WM\""></s:if>
 	<s:else>class="toolbar ui-widget-header ui-corner-all"</s:else>
	>
	<s:if test="progAction == 'create' && progInfo.continueType eq \"1\""><button id="btnContinueIns" type="button"><s:text name="fix.00051"/></button></s:if>
	&nbsp;&nbsp;
	<button id="btnRpt" type="button" style="display:none"><s:text name="fix.00047"/></button>
	<s:if test="progInfo.screenAction eq \"1\""><button id="btnPrt" type="button"><s:text name="fix.00193"/></button></s:if>
	<button id="btnCls" type="button" style="display:none"><s:text name="fix.00004"/></button>
</div>
<script type="text/javascript"> 
$(document).ready(function() {
	if (typeof(parent.unbindUnload) == "function") {
		parent.unbindUnload();
	}
	<s:if test="progAction == 'create' && progInfo.continueType eq \"1\"">
	$("#btnContinueIns").click(function() {
		if (typeof(resetAction) == "function") {
			<%-- 當為多筆+分頁維護(僅可勾選資料)時, 用以處理[送出] Or [分頁]的機制 --%>
			resetAction();
		}
		if (window.name.indexOf("ifrConfirm") >= 0) {
			window.parent.document.forms[0].style.display = "inline";    
			window.parent.document.all[window.name].style.display = "none";
			$("#btnRst", window.parent.document).trigger("click");
		}
		else {
			openBlockUI();
			$("form").submit();
		}
	});
	</s:if>
    <s:if test="progInfo.screenAction eq \"1\"">
	$("#btnPrt").click(function() {
		window.print();
	});
    </s:if>
    
    <s:if test="%{userInfo.chainFlag eq \"Y\"}">
	    $("#btnCls").show();
		$("#btnCls").click(function() {
			window.top.close();	
		});
    </s:if>
    <s:else>
    	if (window.top.opener) {
			$("#btnCls").show();
			$("#btnCls").click(function() {
				var obj = new Object();
				obj.refresh = true;
				window.top.opener.reSearch(obj);
				window.top.close();	
			});
		}
    </s:else>
	
	$("#btnRpt").click(function() {
		var param = getParameter("report");
	});

	<s:if test="progAction.startsWith('create') || progAction.startsWith('update') || progAction.startsWith('delete') 
		|| progAction.startsWith('copy') || progAction.startsWith('process') || progAction.startsWith('save')">
	$(window).bind('unload', function(){
		var obj = new Object();
		obj.refresh = true;
		window.returnValue = obj;
		<s:if test="%{userInfo.chainFlag eq \"Y\"}">
		if (window.top.opener != null) {
			window.top.opener.focus();
		}
		</s:if>
	});
	</s:if>
	<s:elseif test="%{userInfo.chainFlag eq \"Y\"}">
	$(window).bind('unload', function(){
		if (window.top.opener != null) {
			window.top.opener.focus();
		}
	});
	</s:elseif>
});
</script>
</s:if>