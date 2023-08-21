<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<table width="100%">
	<tr>
		<td>
			<button id="btnBrw"><s:text name="fix.00188"/></button>
			<button id="btnClr" type="button" style="display:none"><s:text name="fix.00187"/></button>
			<s:if test="progInfo.screenAction eq \"1\""><button id="btnPrt" type="button"><s:text name="fix.00193"/></button></s:if>
			<button id="btnCls" type="button"><s:text name="fix.00004"/></button>
		</td>
		<s:if test="#session.userInfo.prodMst.prodCode == \"WM\"">
			<s:if test="pager.totalPages > 0">
				<td align="right">
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
$(document).ready(function() {
	$("#btnBrw").click(function() {
		var isValidate = true;
		if (typeof(resetPaginationBar) == "function") {
			resetPaginationBar();
		}
		if (typeof(validate) == "function") {
			isValidate = validate();
		}
		if (isValidate) {
			$("#pagerMethod").val("");		
			$("#currentPage").val("0");
			openBlockUI();
		}
		return isValidate;
	});
	
	$("#btnClr").click(function() {
		$("form").find(":text:not(:hidden):not([readonly='readonly'])").val("");
		$("select").not(".ctrlReadonly").prop("selectedIndex", 0);
		$("form").find(":checkbox").prop("checked", false);
	});
    
    <s:if test="progInfo.screenAction eq \"1\"">
	$("#btnPrt").click(function() {
		window.print();
		return false;	
	});
	</s:if>
    
	$("#btnCls").click(function() {
		window.close();
		return false;
	});
});
</script>		
				    