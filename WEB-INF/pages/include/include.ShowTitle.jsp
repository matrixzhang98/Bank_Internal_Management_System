<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>	
<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
	<tr>
		<td width="10"><img src="<s:url value="/images/title-tab-left.gif"/>" width="10" height="34" /></td>
		<td width="180" align="left" class="progTitle12px" background="<s:url value="/images/title-tab-back.gif"/>">
		<label id="lblProgAction" class="progDescription">
		<s:if test="getActionMapping().name != \"approve\"">
			<s:if test="progAction.endsWith('JobConfirm')">
				<s:text name="%{'title.' + progAction.replaceFirst('JobConfirm', '') + 'Finish'}" />
			</s:if>
			<s:elseif test="progAction.endsWith('Job')">
				<s:text name="%{'title.' + progAction.replaceFirst('Job', '') + 'Finish'}" />
			</s:elseif>
			<s:elseif test="progAction.endsWith('Confirm')">
				<s:text name="%{'title.' + progAction.replaceFirst('Confirm', '') + 'Finish'}" />
			</s:elseif>
			<s:elseif test="progAction.endsWith('Submit')">
				<s:text name="%{'title.' + progAction.replaceFirst('Submit', '') + 'Finish'}" />
			</s:elseif>
			<s:else>
				<s:text name="%{'title.' + progAction + 'Finish'}" />
			</s:else>
		</s:if>
		<s:else>
			<s:text name="%{'title.' + progAction }" />
			<script language="javascript">
			$(document).ready(function() {
				$("label.modify").each(function() {
					if ($.trim($(this).html()) == "") {
						$(this).html("&nbsp;&nbsp;&nbsp;&nbsp;");
					}
				});
			});
			</script>
		</s:else>
		</label>
		</td>
		<td align="center" background="<s:url value="/images/title-tab-back.gif"/>">
			<label><s:property value="progInfo.progSn" />&nbsp;<s:property value="progInfo.progName" />&nbsp;(<s:property value="progId" />)</label>
			<s:hidden name="progId"/><s:hidden name="progAction"/>
		</td>
		<td width="200" align="right" class="progTitle12px" background="<s:url value="/images/title-tab-back.gif"/>">
			<label><s:property value="userInfo.userMst.userId" /></label><label>(<s:property value="userInfo.execTime" />)</label>
		</td>
		<td width="10"><img src="<s:url value="/images/title-tab-right.gif"/>" width="10" height="34" /></td>
	</tr>
</table>
