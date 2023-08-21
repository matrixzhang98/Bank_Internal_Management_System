<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="pager.totalPages > 0">
<div align="right" id="paginationBar" class="toolbar ui-widget-header ui-corner-all" 
	<s:if test="#session.userInfo.prodMst.prodCode == \"WM\"">
		style="display:none;padding-right: 60px;"
	</s:if>
	<s:else>
		style="padding-right: 60px;"
	</s:else>
	>
	<label><s:property value="pager.currentPage" /> / <s:property value="pager.totalPages" /></label>
	<s:if test="#session.userInfo.prodMst.prodCode == \"WM\""></s:if>
 	<s:else>
 		<button id="btnFirst" type="button" onclick="return page_onClick('first');" title="<s:text name="fix.00040" />">&lt;&lt;</button>
		<button id="btnPrevious" type="button" onclick="return page_onClick('previous');" title="<s:text name="fix.00044"/>">&lt;</button>&nbsp;
		<select id="pager" onChange="page_onChange(this.selectedIndex + 1)">
			<s:iterator status="status" value="pager.totalPages.{ #this }" >
				<option value="<s:property value="#status.index" />" <s:property value="%{((#status.index + 1) == pager.currentPage) ? 'selected' : ''}"/>>
					<s:property value="#status.index + 1" />
				</option>
			</s:iterator>
		</select>
		<button id="btnNext" type="button" onclick="return page_onClick('next');" title="<s:text name="fix.00043"/>">&gt;</button>
		<button id="btnLast" type="button" onclick="return page_onClick('last');" title="<s:text name="fix.00041"/>">&gt;&gt;</button>
 	</s:else>
	&nbsp;&nbsp;
	<s:hidden id="currentPage" name="pager.currentPage"/>
	<s:hidden id="pagerMethod" name="pager.pagerMethod"/>
	<s:hidden id="totalPages" name="pager.totalPages"/>
     <s:hidden id="pageSize" name="pager.pageSize" value="%{null == progInfo || progInfo.pageSize == null ? 15 : progInfo.pageSize}" />
</div>
<script language="javascript">
function resetPaginationBar(params) {
	var defaults = {
		pagerMethod:"",
		zeroIndex:true,
		pageIndex:0 
	};
	var opts = $.extend({}, defaults, params);
	if (opts.zeroIndex == true) {
		$("#pagerMethod").val("");
		$("#currentPage").val("0");
	}
	else {
		$("#pagerMethod").val("goPage");
	}
}
function page_onClick(method) {
	$("#pagerMethod").val(method);
	var isValidate = true;
	if (typeof(validate) == "function") {
		var errorFlag = false;
		isValidate = validate("search", errorFlag);				
	}
	if (isValidate == true) {
		openBlockUI();
		$("form").submit();
	}
	return false;
}
function page_onChange(toPage) {
	$("#currentPage").val(toPage);
	$("#pagerMethod").val('goPage');
	var isValidate = true;
	if (typeof(validate) == "function") {
		var errorFlag = false;
		isValidate = validate("search", errorFlag);				
	}

	if (isValidate == true) {
		openBlockUI();
		$("form").submit();
	}
	return false;
}
$(document).ready(function() {
});
</script>
</s:if>