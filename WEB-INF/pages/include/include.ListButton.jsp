<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<table id="listButton" width="100%" border="0">
	<tr>
		<td>
			<s:if test="progInfo.searchAction eq \"1\"">
			<button id="listBtnBrw"><s:text name="fix.00188"/></button>
			</s:if>
			<%
			String hasBtnClr = request.getParameter("hasBtnClr");
			if ("Y".equals(hasBtnClr)) {
			%>
			<button id="listBtnClr" type="button"><s:text name="fix.00187"/></button>
			<%}%>
			<s:if test="progInfo.addAction eq \"1\""><button id="btnIns" type="button"><s:text name="fix.00001"/></button></s:if>
			<s:if test="progInfo.updAction eq \"1\""><button id="btnUpd" type="button" style="display:none"><s:text name="fix.00183"/></button></s:if>
			<s:if test="progInfo.processAction eq \"1\""><button id="btnPrs" type="button"><s:text name="fix.00046"/></button></s:if>
			&nbsp;&nbsp;
			<%-- 報表使用同一權限管控旗標(不同按鍵狀態旗標) --%>
			<s:if test="progInfo.printAction eq \"1\""><button id="listBtnRpt" ><s:text name="fix.00047"/></button></s:if>
			<s:if test="progInfo.screenAction eq \"1\""><button id="listBtnPrt" type="button"><s:text name="fix.00193"/></button></s:if>
		</td>
		<s:if test="#session.userInfo.prodMst.prodCode == \"WM\"">
			<s:if test="pager.totalPages > 0">
				<td align="right">
					<label><s:property value="pager.currentPage" /> / <s:property value="pager.totalPages" /></label>
					<button id="btnFirst" type="button" onclick="return page_onClick('first');" title="<s:text name="fix.00040" />"><img src="<s:url value="/image_icons/moveFirst.png"/>" width="15" height="15" /></button>
					<button id="btnPrevious" type="button" onclick="return page_onClick('previous');" title="<s:text name="fix.00044"/>"><img src="<s:url value="/image_icons/moveLeft.png"/>" width="15" height="15" /></button>
					<select id="pager" onChange="page_onChange(this.selectedIndex + 1)">
					<s:iterator status="status" value="pager.totalPages.{ #this }" >
						<option value="<s:property value="#status.index" />" <s:property value="%{((#status.index + 1) == pager.currentPage) ? 'selected' : ''}"/>>
							<s:property value="#status.index + 1" />
						</option>
					</s:iterator>
					</select>
					<button id="btnNext" type="button" onclick="return page_onClick('next');" title="<s:text name="fix.00043"/>"><img src="<s:url value="/image_icons/moveRight.png"/>" width="15" height="15" /></button>
					<button id="btnLast" type="button" onclick="return page_onClick('last');" title="<s:text name="fix.00041"/>"><img src="<s:url value="/image_icons/moveLast.png"/>" width="15" height="15" /></button>
				</td>
			</s:if>
		</s:if>
	</tr>
</table>
<script type="text/javascript">
function reSearch(oRtn) {
	if (jQuery.type(oRtn) != "undefined" && oRtn != null && oRtn.refresh == true) {
		$("#listBtnBrw").trigger("click");
	}
}

function closedAction(oRtn) {
	if (jQuery.type(oRtn) != "undefined" && oRtn != null) {
		if (oRtn.refresh == true) {
			if (typeof(setInit) == "function") {
				setInit();
			}
			$("#listBtnBrw").trigger("click", [false]);
		}
		else if (oRtn.logout == true) {
		}
	}	
}
$(document).ready(function() {
	$("body").css({ "cursor" : "default" });
	<s:if test="progInfo.searchAction eq \"1\"">
	$("#listBtnBrw").on("click", function(event) {
		<%-- arguments[1]:是否重設分頁頁碼 --%>
		if (typeof(resetPaginationBar) == "function") {
			var tmp = true;
			if (arguments.length > 1 && jQuery.type(arguments[1]) == "boolean") {
				tmp = false;
			}
			resetPaginationBar({zeroIndex:tmp});
		}
		var isValidate = true;
		$("form").attr("action", $("form").attr("action").replace("print", "search"));
		if (typeof(validate) == "function") {
			var errorFlag = false;
			isValidate = validate("search", errorFlag);
		}
        if (isValidate) openBlockUI();
		return isValidate;
	});
	</s:if>
	<%
	if ("Y".equals(hasBtnClr)) {
	%>
	$("#listBtnClr").on("click", function() {
		$("form").find(":text:not(:hidden):not([readonly='readonly'])").val("");
		$("select").not(".ctrlReadonly").prop("selectedIndex", 0);
		$("form").find(":checkbox").prop("checked", false);
	});
	<%}%>
	
	<s:if test="progInfo.queryAction eq \"1\"">
	$('.imgViewAct').on("click", function(evt) {
		try {
			$(this).parent().parent().trigger("click");
			var oRtn;
			var dailogSize = jQuery.type($("#tb").attr("lang")) == 'undefined' ? "dialogWidth: 1024px; dialogHeight: 768px;" : $("#tb").attr("lang");		
			var param = getParameter("query");
			if (jQuery.type(param) == "boolean" && param == false) {
				return false;
			}
			else if (jQuery.type(param) == "boolean" || jQuery.type(param) == "string") {
				if (param != "") {
					param = "&" + param;
				}
				<s:if test='progInfo.inApprove == \"2\"'>
				param = "&progDataStatus=" + $("input[name='progDataStatus']:radio:checked").val() + param;
				</s:if>
				
				param = "progId=<s:property value="progId" />&progAction=query" + param;
				window.parent.mSubWindow = openPostWindow({"url":"query", "data":param, "name":"dcEditWindow"});
				//oRtn = window.showModalDialog("query?progId=<s:property value="progId" />&progAction=query" + param, window, dailogSize + " scroll: auto; resizable: no; status: no;");
			}
			else {
				alert("(<s:text name="eC.0343" />(showModalDialog)");
				//oRtn = window.showModalDialog(contextPath + "/" + param.url, window, dailogSize + " resizable: no; status: no;");
			}
		}
		catch(e) {
			alert("(<s:text name="eC.0343" />:" + e.message + ")");
		}
		return false;
	});
	</s:if>
	
	<s:if test="progInfo.addAction eq \"1\"">
	$("#btnIns").click(function() {
		try {
			var param = true;
			var oRtn;
			var dailogSize = jQuery.type($("#tb").attr("lang")) == 'undefined' ? "dialogWidth: 1024px; dialogHeight: 768px;" : $("#tb").attr("lang");		
			if (typeof(getInsParameter) == "function") {
				param = getInsParameter("create");
			}
			if (jQuery.type(param) == "boolean" && param == false) {
				return;
			}
			else if (jQuery.type(param) == "boolean" || jQuery.type(param) == "string") {
				if (jQuery.type(param) == "string" && param != "") {
					param = "&" + param;
				}
	            else{
	                param = "";
	            }
				<s:if test='progInfo.inApprove == \"2\"'>
				param = "&progDataStatus=" + $("input[name='progDataStatus']:radio:checked").val() + param;
				</s:if>
				param = "progId=<s:property value="progId" />&progAction=create" + param;
				window.parent.mSubWindow = openPostWindow({"url":"create", "data":param, "name":"dcEditWindow"});
				//oRtn = window.showModalDialog("create?progId=<s:property value="progId" />&progAction=create" + param, window, dailogSize + " scroll: auto; resizable: no; status: no;");
			}
			else {
				alert("(<s:text name="eC.0343" />(showModalDialog)");
				//oRtn = window.showModalDialog(contextPath + "/" + param.url, window, dailogSize + " scroll: auto; resizable: no; status: no;");
			}
			closedAction(oRtn);
		}
		catch(e) {
			alert("(<s:text name="eC.0343" />:" + e.message + ")");
		}
		return false;
	});
	</s:if>
	<s:if test="progInfo.copyAction eq \"1\"">
	$('.imgCopyAct').click(function(evt) {
		try {
			$(this).parent().parent().trigger("click");
			var oRtn;
			var dailogSize = jQuery.type($("#tb").attr("lang")) == 'undefined' ? "dialogWidth: 1024px; dialogHeight: 768px;" : $("#tb").attr("lang");
			var param = getParameter("copy");
			if (jQuery.type(param) == "boolean" && param == false) {
				return false;
			}
			else if (jQuery.type(param) == "boolean" || jQuery.type(param) == "string") {
				if (param != "") {
					param = "&" + param;
				}
				<s:if test='progInfo.inApprove == \"2\"'>
				param = "&progDataStatus=" + $("input[name='progDataStatus']:radio:checked").val() + param;
				</s:if>
				param = "progId=<s:property value="progId" />&progAction=copy" + param;
				window.parent.mSubWindow = openPostWindow({"url":"copy", "data":param, "name":"dcEditWindow"});
				//oRtn = window.showModalDialog("copy?progId=<s:property value="progId" />&progAction=copy" + param, window, dailogSize + " scroll: auto; resizable: no; status: no;");
			}
			else {
				alert("(<s:text name="eC.0343" />(showModalDialog)");
				//oRtn = window.showModalDialog(contextPath + "/" + param.url, window, dailogSize + " scroll: auto; resizable: no; status: no;");
			}
			closedAction(oRtn);
		}
		catch(e) {
			alert("(<s:text name="eC.0343" />:" + e.message + ")");
		}
		return false;
	});
	</s:if>
	<s:if test="progInfo.updAction eq \"1\"">
	$('.imgUpdAct, #btnUpd').click(function(evt) {
		try {
			$(this).parent().parent().trigger("click");
			var oRtn;
			var dailogSize = jQuery.type($("#tb").attr("lang")) == 'undefined' ? "dialogWidth: 1024px; dialogHeight: 768px;" : $("#tb").attr("lang");
			var param = getParameter("update");
			if (jQuery.type(param) == "boolean" && param == false) {
				return false;
			}
			else if (jQuery.type(param) == "boolean" || jQuery.type(param) == "string") {
				if (param != "") {
					param = "&" + param;
				}
				<s:if test='progInfo.inApprove == \"2\"'>
				param = "&progDataStatus=" + $("input[name='progDataStatus']:radio:checked").val() + param;
				</s:if>
				param = "progId=<s:property value="progId" />&progAction=update" + param;
				window.parent.mSubWindow = openPostWindow({"url":"update", "data":param, "name":"dcEditWindow"});
				//oRtn = window.showModalDialog("update?progId=<s:property value="progId" />&progAction=update" + param, window, dailogSize + " scroll: auto; resizable: no; status: no;");
			}
			else {
				alert("(<s:text name="eC.0343" />(showModalDialog)");
				//oRtn = window.showModalDialog(contextPath + "/" + param.url, window, dailogSize + " scroll: auto; resizable: no; status: no;");
			}
			closedAction(oRtn);
		}
		catch(e) {
			alert("(<s:text name="eC.0343" />:" + e.message + ")");
		}
		return false;
	});
	</s:if>
	<s:if test="progInfo.delAction eq \"1\"">
	$('.imgDelAct').click(function(evt) {
		try {
			$(this).parent().parent().trigger("click");
			var oRtn;
			var dailogSize = jQuery.type($("#tb").attr("lang")) == 'undefined' ? "dialogWidth: 1024px; dialogHeight: 768px;" : $("#tb").attr("lang");
			var param = getParameter("delete");
			if (jQuery.type(param) == "boolean" && param == false) {
				return false;
			}
			else if (jQuery.type(param) == "boolean" || jQuery.type(param) == "string") {
				if (param != "") {
					param = "&" + param;
				}
				<s:if test='progInfo.inApprove == \"2\"'>
				param = "&progDataStatus=" + $("input[name='progDataStatus']:radio:checked").val() + param;
				</s:if>
				param = "progId=<s:property value="progId" />&progAction=delete" + param;
				window.parent.mSubWindow = openPostWindow({"url":"delete", "data":param, "name":"dcEditWindow"});
				//oRtn = window.showModalDialog("delete?progId=<s:property value="progId" />&progAction=delete" + param, window, dailogSize + " scroll: auto; resizable: no; status: no;");
			}
			else {
				alert("(<s:text name="eC.0343" />(showModalDialog)");
				//oRtn = window.showModalDialog(contextPath + "/" + param.url, window, dailogSize + " scroll: auto; resizable: no; status: no;");
			}
			closedAction(oRtn);
		}
		catch(e) {
			alert("(<s:text name="eC.0343" />:" + e.message + ")");
		}
		return false;
	});
	</s:if>
	<s:if test="progInfo.saveAction eq \"1\"">
	$("#btnSav").click(function() {
		alert("save");
		return false;
	});
	</s:if>
	<s:if test="progInfo.processAction eq \"1\"">
	$('#btnPrs').click(function(evt) {
		$(this).parent().parent().trigger("click");
		var oRtn;
		var dailogSize = jQuery.type($("#tb").attr("lang")) == 'undefined' ? "dialogWidth: 1024px; dialogHeight: 768px;" : $("#tb").attr("lang");
		var param = getParameter("process");
		if (jQuery.type(param) == "boolean" && param == false) {
			return false;
		}
		else if (jQuery.type(param) == "boolean" || jQuery.type(param) == "string") {
			if (param != "") {
				param = "&progDataStatus=1&" + param;
			}
			oRtn = window.showModalDialog("process?progId=<s:property value="progId" />&progAction=delete" + param, window, dailogSize + " scroll: auto; resizable: no; status: no;");
		}
		else {
			oRtn = window.showModalDialog(contextPath + "/" + param.url, window, dailogSize + " scroll: auto; resizable: no; status: no;");
		}
		closedAction(oRtn);
		return false;
	});
	</s:if>
	<s:if test="progInfo.printAction eq \"1\"">
	$("#listBtnRpt").click(function() {
		var isValidate = true;
		$("form").attr("action", $("form").attr("action").replace("search", "print"));
		if (typeof(validate) == "function") {
			isValidate = validate("print");				
		}
        if (isValidate) openBlockUI();
		return isValidate;
	});
	</s:if>
	$("#listBtnPrt").click(function() {
		window.print();
		return false;
	});
});
</script>		
				    