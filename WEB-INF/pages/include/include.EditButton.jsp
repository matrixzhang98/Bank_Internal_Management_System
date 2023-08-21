<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<div align="center" id="toolbar" 
 	<s:if test="#session.userInfo.prodMst.prodCode == \"WM\""></s:if>
 	<s:else>class="toolbar ui-widget-header ui-corner-all"</s:else>
 	>
	<s:set var="isBatch" value="false"/>
	<s:if test="progDataStatus == \"0\""><button id="btnSmt" type="button"><s:text name="fix.00186"/></button><button id="btnSpvrSmt" type="button"><s:text name="fix.01849"/></button><s:set var="isBatch" value="true"/></s:if>
	<s:elseif test="progAction.startsWith('create') && progInfo.addApprove == \"3\""><button id="btnSmt" type="button"><s:text name="fix.00186"/></button><button id="btnSpvrSmt" type="button"><s:text name="fix.01849"/></button><s:set var="isBatch" value="true"/></s:elseif>
	<s:elseif test="progAction.startsWith('update') && progInfo.updApprove == \"3\""><button id="btnSmt" type="button"><s:text name="fix.00186"/></button><button id="btnSpvrSmt" type="button"><s:text name="fix.01849"/></button><s:set var="isBatch" value="true"/></s:elseif>
	<s:elseif test="progAction.startsWith('copy') && progInfo.copyApprove == \"3\""><button id="btnSmt" type="button"><s:text name="fix.00186"/></button><button id="btnSpvrSmt" type="button"><s:text name="fix.01849"/></button><s:set var="isBatch" value="true"/></s:elseif>
	<s:else><button id="btnSmt" type="button"><s:text name="fix.00190"/></button></s:else>
	<button id="btnRst" type="button" style="display:none"><s:if test="progAction != 'updateSubmit'"><s:text name="fix.00187"/></s:if><s:else><s:text name="fix.00048"/></s:else></button>
	&nbsp;&nbsp;
	<s:if test="progInfo.screenAction eq \"1\""><button id="btnPrt" type="button"><s:text name="fix.00193"/></button></s:if>
	<button id="btnCls" type="button"><s:text name="fix.00004"/></button>
	<button id="btnStatus" type="button" style="display:none">Status..</button>
	<a id="reloadDialog" href="" style="display:none">reload...</a>
    <button id="btnUnBlockUI" type="button" onClick="closeBlockUI();" style="display:none">unblockUI..</button>
</div>
<script type="text/javascript">
function bindUnload() { 
	if(history.length <= 0){
		if (window.name.indexOf("ifrConfirm") < 0) {
			$(window).bind('beforeunload', function(){
			    return "<s:text name="fix.03410"/>";
			});
		}
	}
}
function unbindUnload() {
	$(window).unbind("beforeunload");	
}
$(document).ready(function() {
	bindUnload();
	$("#btnSmt").click(function() {
		$("form").attr("action", $("form").attr("action").replace("Flow", "Submit"));
		var isValidate = validate("submit");
		if(isValidate){
            $("form").validate("closePrompt");
            openBlockUI();
        	if (window.name.indexOf("ifrConfirm") < 0) {
        		unbindUnload();
        	}	
            $("form").submit();
        }
	});
<s:if test="#isBatch == true">
	$("#btnSpvrSmt").click(function() {
		var isValidate = validate("flow");
		if(isValidate){
			$("form").attr("action", $("form").attr("action").replace("Submit", "Flow"));
            $("form").validate("closePrompt");
            openBlockUI();
            $("form").submit();
        }
	});
</s:if>	
	$("#btnRst").click(function() {
		$("form").validate("closePrompt");
		unbindUnload();
		$("#reloadDialog").attr("href", window.location.href);
		reloadDialog.click();
	});
	<s:if test="progInfo.screenAction eq \"1\"">
	$("#btnPrt").click(function() {
		window.print();
	});
    </s:if>
	if (history.length > 0) {
		$("#btnCls").hide();
	}
	else {
		$("#btnCls").click(function() {
			$("form").validate("closePrompt");
			unbindUnload();
		<s:if test="%{userInfo.chainFlag eq \"Y\"}">
			window.top.close();	
		</s:if>
		<s:else>
			window.close();	
		</s:else>
		});
	}
	$("#btnStatus").click(function() {
		$("form").validate("closePrompt");
		$("#systemInfo").dialog("open")
	});
	<s:if test="%{userInfo.chainFlag eq \"Y\"}">
	$(window).bind('unload', function(){
		if (window.top.opener != null) {
			window.top.opener.focus();
		}
	});
	</s:if>
	
});
</script>