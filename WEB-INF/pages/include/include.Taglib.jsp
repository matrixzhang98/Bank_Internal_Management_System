<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="#session.userInfo.prodMst.prodCode == \"WM\""></s:if>
<s:else>
	<% 
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	%>
</s:else>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"> 