<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/pages/include/include.Taglib.jsp"%>
<html>
<head>
<title></title>
<base target="_self" />
<s:include value="/WEB-INF/pages/include/include.Scripts.jsp" />
<script type="text/javascript" src="<s:url value="/dcPlugin/dc.gridEditList.plugin.js"/>"></script>
<script type="text/javascript" src="<s:url value="/dcPlugin/dc.number.plugin.js"/>"></script>
<script type="text/javascript" src="<s:url value="/jquery/ui/jquery.ui.datepicker.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/jquery/jquery.alphanumeric.js"/>"></script>
<script type="text/javascript" src="<s:url value="/dcPlugin/dc.validation.plugin.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/dc.input.js"/>"></script>
<script language="javascript">
function validate() {
	$("#frmlab200012").validate("clearPrompt");

	return $("#frmlab200012").validate("showPromptWithErrors");
}	

$(document).ready(function() {
	oTable = $('#tblGrid').initEditGrid({height:'480'});	   
	$('#btnInsRow').on("click", function() {
		fnAddTableRow(oTable, function(newRow) {
		});
		return false;
	});
	<%--單筆刪除--%>
	$('.imgDelete').on("click", function(event) {
		fnDelTableRow($(this), oTable);
		return false;
	});
	<%--多筆刪除--%>
	$('#btnRmvRow').on("click", function() {
		fnDelAllRow(oTable);
		return false;
	});

	
	<%-- 客戶ID帶名稱 --%>
	$('#custId').on("change",function() {
		var custId = $('#custId').val();
		if(custId != ""){
			var paramsString = '{"custId":"' + custId +'"}';
				$.getJSON(
					'<s:url value="/ajax/ajaxQuery/queryDataByParams.action" />',
					{"queryName": 'findLabCustMstByKey', "params": paramsString},
					function(data){						
						//有查到資料
						if(data.results.length == 1 && data.results[0] != "" && data.results[0] != null){
							$('#lblCustId').text(data.results[0][1]);
						}
						//查無資料
						else{							
							$('#lblCustId').text("<s:text name="eC.0037"/>")
						}
					}
				);		
		}
		else{
			$('#lblCustId').text("");
		}
	});
	
	<%-- 商品ID帶名稱 --%>
	$('.itemData').on("change",function() {
		var index = fnGetObjIndex($(this));
		var itemId = $('#itemId_' + index).val();
		if(itemId != ""){
			var paramsString = '{"itemId":"' + itemId +'"}';
				$.getJSON(
					'<s:url value="/ajax/ajaxQuery/queryDataByParams.action" />',
					{"queryName": 'findLabItemMstByKey', "params": paramsString},
					function(data){						
						//有查到資料
						if(data.results.length == 1 && data.results[0] != "" && data.results[0] != null){
							$('#lblItemId_' + index).text(data.results[0][1]);
							$('#lblItemId_' + index).val(data.results[0][1]);
							$('#itemPrc_' + index).text(data.results[0][2]);
							$('#itemPrc_' + index).val(data.results[0][2]);
							if(data.results[0][3] == null || data.results[0][3] == ""){
								$('#itemPromoPrc_' + index).text("<s:text name=""/>");
								$('#itemPromoPrc_' + index).val("");
							}else{
								$('#itemPromoPrc_' + index).text(data.results[0][3]);
								$('#itemPromoPrc_' + index).val(data.results[0][3]);	
							}
						}
						//查無資料
						else{							
							$('#lblItemId_' + index).text("<s:text name="eC.0037"/>");
							$('#itemPrc_' + index).text("<s:text name=""/>");
							$('#itemPromoPrc_' + index).text("<s:text name=""/>");
						}
					}
				);		
		}
		else{
			$('#lblCustId').text("");
		}
	});
	
	<%-- 計算單筆價格 --%>
	$('.qtyData').on("change", function(){
		var index = fnGetObjIndex($(this));
		var itemPrc = $('#itemPrc_' + index).val().toNumber();
		var itemPromoPrc = $('#itemPromoPrc_' + index).val().toNumber();
		var orderQty = $('#orderQty_' + index).val().toNumber();
		if(itemPromoPrc != null && itemPromoPrc != ""){
			var subTotal = accMul(itemPromoPrc,orderQty);
		}else{
		var subTotal = accMul(itemPrc,orderQty);
		}
		$('#subTotal_' + index).text(subTotal);
		$('#subTotal_' + index).val(subTotal);
		
		var subTotal = $('#subTotal_' + index).val().toNumber();
		var orderAmt = $('#orderAmt').val().toNumber();
		var orderAmts = accAdd(subTotal,orderAmt)
		$('#orderAmt').text(orderAmts);
		$('#orderAmt').val(orderAmts);
	});
});
</script>
</head>
<body>
<s:form id="frmlab200012" method="post" theme="simple" action="%{progAction}" target="ifrConfirm">
<s:hidden name="labOrderMst.ver" />
	<div class="progTitle">
		<!-- 程式標題 --> <s:include value="/WEB-INF/pages/include/include.EditTitle.jsp" /> <!-- 程式標題 -->
	</div>
	<div id="tb">
	<table width="100%" border="0" cellpadding="4" cellspacing="0" >
	<tbody>    
        <tr class="trBgOdd">
            <td width="20%" class="colNameAlign required">*<s:text name="orderDate" />：</td>
     		<td width="30%"><s:textfield name="labOrderMst.orderDate"/><label><s:property value="orderDate"/></label></td>
            <td width="20%" class="colNameAlign required">*<s:text name="orderId"/>：</td>
            <td width="30%"><s:textfield name="labOrderMst.orderId"/><label><s:property value="orderId"/></label></td>
		</tr>
		<tr class="trBgEven">
            <td width="20%" class="colNameAlign required">*<s:text name="custId" />：</td>
            <td width="30%">
            	<s:textfield id="custId" name="labOrderMst.custMst.custId" size="10" maxlength="10" cssClass="enKey"/>
            	<input type="image" id="programId_<s:property value="#stat.index" />" class="programPopUp" src="<s:url value="/image_icons/search.png"/>" />
            	<s:label id="lblCustId" name="labOrderMst.custMst.custName"/>
            </td>
            <td width="20%" class="colNameAlign required">*<s:text name="orderAmt"/>：</td>
            <td width="30%"><s:textfield name="labOrderMst.orderAmt"/><s:label id="orderAmt" name="labOrderMst.orderAmt" /></td>
        </tr>   
	</tbody> 
    </table>
    <fieldset style="-moz-border-radius:4px;">
    <div style="width:100%; display:block; float:left; background-color:#b7d3d6">
        <button class="btnInsRow" type="button" id="btnInsRow"><s:text name="fix.00255" /></button>
        <button class="btnRmvRow" type="button" id="btnRmvRow"><s:text name="fix.00256" /></button>
    </div>
    <table id="tblGrid" width="100%" border="0" cellpadding="2" cellspacing="1">
        <thead>
            <tr align="center" bgcolor="#e3e3e3">
                <th width="30"><s:text name="fix.00164" /></th>
                <th width="20">&nbsp;</th>
                <th width="28%"><s:text name="itemId" /></th>
                <th width="15%"><s:text name="itemPrc" /></th>                                    
                <th width="15%"><s:text name="itemPromoPrc" /></th>                                   
                <th width="15%"><s:text name="orderQty" /></th>                                   
                <th><s:text name="subTotal" /></th>                                                                                
                <th style="display: none;">&nbsp;</th>          
            </tr>
        </thead>
		<tbody id="tbGrid">
		        <s:iterator value="orderItemList" status="stat">
		        <tr>
		            <td id="SN" align="center" width="30"><s:property value="#stat.index + 1" /></td>
		            <td align="center" width="20">
		                <input class="imgDelete" type="image" src="<s:url value="/image_icons/delete.png"/>" width="16" height="16" title="<s:text name="fix.00182"/>">
		            </td>
		            <td width="28%"><!-- 搜尋 -->
		                <s:textfield id="%{'itemId_' + #stat.index}" name="%{'orderItemList['+#stat.index+'].itemId'}" cssClass="enOnly itemData" maxlength="32" size="16"/>
		                <input type="image" id="itemId_<s:property value="#stat.index" />" class="programPopUp" src="<s:url value="/image_icons/search.png"/>" />
		                <s:label id="%{'lblItemId_' + #stat.index}" name="%{'orderItemList['+#stat.index+'].itemName'}" value="%{orderItemList[#stat.index].itemName}" cssClass="labelCut"/>
		            </td>
		            <td width="15%" align="center"><!-- 商品價格 --> 
		           		<s:hidden name="labOrderMst.orderItems.itemPrc"/>           
						<s:label id="%{'itemPrc_' + #stat.index}" name="%{'orderItemList['+#stat.index+'].itemPrc'}" value="%{orderItemList[#stat.index].itemPrc}" cssClass="labelCut"/>
		            </td>
		            <td width="15%" align="center"><!-- 特惠價格 -->
						<s:label id="%{'itemPromoPrc_' + #stat.index}" name="%{'orderItemList['+#stat.index+'].itemPromoPrc'}" value="%{orderItemList[#stat.index].itemPromoPrc}" cssClass="labelCut"/>
						<s:hidden name="labOrderMst.orderItems.itemPromoPrc"/>
		            </td>
		            <td width="15%" align="center"><!-- 訂購數量 -->
						<s:hidden name="labOrderMst.orderItems.orderQty"/>
						<s:textfield id="%{'orderQty_' + #stat.index}" name="%{'orderItemList['+#stat.index+'].orderQty'}" cssClass="numkey qtyData" maxlength="32" size="16"/>
		            </td>
		            <td align="center"><!-- 單筆金額 -->              
						<s:hidden name="labOrderMst.orderItems.subTotal"/>
						<s:label id="%{'subTotal_' + #stat.index}" name="%{'orderItemList['+#stat.index+'].subTotal'}" value="%{orderItemList[#stat.index].subTotal}" cssClass="labelCut totalData"/>
		            </td>
		            <td style="display: none;">
		                <s:hidden id="%{'operate_' + #stat.index}" name="%{'orderItemList['+#stat.index+'].operate'}"/>
		                <s:hidden id="%{'ver_' + #stat.index}" name="%{'orderItemList['+#stat.index+'].ver'}"/>
		                <s:hidden id="%{'orderItemOid_' + #stat.index}" name="%{'orderItemList['+#stat.index+'].orderItemOid_'}" />
		            </td>
	        	</tr>
		        </s:iterator>   
		</tbody>
    </table>
    </fieldset>
    </div>
	<!-- 按鍵組合 --> 
	<s:include value="/WEB-INF/pages/include/include.EditButton.jsp" />
	<!-- 按鍵組合 -->
</s:form>
<iframe id="ifrConfirm" name="ifrConfirm" width="100%" height="290" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="display:none; border: 0px none"></iframe>
</body>
</html>