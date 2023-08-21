<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /></meta>
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<link rel="stylesheet" type="text/css" href="<s:url value="/css/dc_style.css"/>"></link>
<s:if test='progId != "sys02007" '>
<link rel="stylesheet" type="text/css" href="<s:url value="/css/buttonStyle.css"/>"></link>
</s:if>
<link rel="stylesheet" type="text/css" href="<s:url value="/css/custom-theme/jquery-ui-1.8.16.dc.css"/>"></link>
<script type="text/javascript" src="<s:url value="/jquery/jquery-1.8.3.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/jquery/jquery.blockUI.js"/>"></script>
<script type="text/javascript" src="<s:url value="/jquery/ui/jquery.ui.core.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/jquery/ui/jquery.ui.widget.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/jquery/ui/jquery.ui.button.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/jquery/ui/jquery.ui.dialog.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/jquery/ui/jquery.ui.mouse.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/jquery/ui/jquery.ui.draggable.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/jquery/ui/jquery.ui.position.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/dcPlugin/dc.popupWindow.plugin.js"/>"></script>
<script type="text/javascript" src="<s:url value="/dcPlugin/dc.string.plugin.js"/>"></script>
<script type="text/javascript" src="<s:url value="/dcPlugin/dc.textArea.plugin.js"/>"></script>
<script type="text/javascript" src="<s:url value="/dcPlugin/dc.number.plugin.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/dc.popup.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/dc.dialog.js"/>"></script>
<s:include value="/WEB-INF/pages/include/include.CommonMessage.jsp" />
<script type="text/javascript">
//定義根目錄字串，從request.contextPath取出，主要為了之後的共用視窗組合url用到
var contextPath = "${pageContext.request.contextPath}";
var dc_dateType = "1";	<%-- 0: 西元年, 1:民國年--%>
var dc_dateFormat = "yy/mm/dd";
var dc_dateParams = {
        showOn: "button",
        buttonText: '',
        dayNamesMin: ['<s:text name="fix.00284"/>', '<s:text name="fix.00278"/>', '<s:text name="fix.00279"/>', 
			'<s:text name="fix.00280"/>', '<s:text name="fix.00281"/>', '<s:text name="fix.00282"/>', 
			'<s:text name="fix.00283"/>'],
		monthNamesShort: ['<s:text name="fix.00220"/>', '<s:text name="fix.00221"/>', '<s:text name="fix.00222"/>',
			'<s:text name="fix.00223"/>', '<s:text name="fix.00224"/>', '<s:text name="fix.00225"/>',
			'<s:text name="fix.00226"/>', '<s:text name="fix.00227"/>', '<s:text name="fix.00228"/>',
			'<s:text name="fix.00229"/>', '<s:text name="fix.00230"/>', '<s:text name="fix.00231"/>'],
		firstDay: 1,
        buttonImage: '<s:url value="/image_icons/calendar.png"/>',
        buttonImageOnly: true,
        dateFormat: dc_dateFormat,
        changeMonth: true,
        changeYear: true
};
function openBlockUI() {
    $.blockUI({
    	message: '<image src="<s:url value="/images/loading.gif"/>"></image>', 
		css : {top:'30%', padding: '5px', border: 'none', '-webkit-border-radius': '10px', 
    		   '-moz-border-radius': '10px', backgroundColor: 'transparent'},
        overlayCSS: {backgroundColor: '#fff', opacity: 0.6}
    });
}
function closeBlockUI() {
    $.unblockUI();
    $(".blockUI").fadeOut("slow");
}

function openPostWindow(oJson) {
	var wFeatures = {};
	if (oJson.features) {
		var parm1 = oJson.features.split(";");
		for (var i=0; i<parm1.length; i++) {
			if (parm1[i].trim() != "") {
				var parm2 = parm1[i].split(":");
				wFeatures[parm2[0].trim()] = parm2[1].trim();
			}
		}
		if (wFeatures.dialogWidth) {
			wFeatures["width"] = wFeatures.dialogWidth.replace("px", "");
		}
		wFeatures["height"] = (wFeatures.dialogHeight) ? wFeatures.dialogHeight.replace("px", "") : 768;
		wFeatures["width"] = (wFeatures.dialogWidth) ? wFeatures.dialogWidth.replace("px", "") : 1024;
	}
	else {
		wFeatures["height"] = 768;
		wFeatures["width"] = 1024;
	}

	if ((wFeatures.width > screen.width) || (wFeatures.height > screen.height)) {
		wFeatures.width = screen.width - 50;
		wFeatures.height = screen.height - 100;
	}
	var nLeft = (screen.width - wFeatures.width) / 2;
	var nTop = (screen.height - wFeatures.height) / 2 - 20;
	
	var loadingWindow = window.open("loading?t="+new Date().getTime(), "dcEditWindow", "height=" + wFeatures.height + ", width=" + wFeatures.width + ", top=0, left=0, scroll: no, resizable: no, status: no"); 
	loadingWindow.moveTo(nLeft, nTop);
	loadingWindow.focus();
	var dynaForm = $("<form id='tmpPostForm' method='post' action='" + oJson.url + "' target='" + oJson.name + "'/>");
	//
	var pJSON = JSON.parse('{"' + oJson.data.replace(/&/g, '","').replace(/=/g,'":"') + '"}', function(key, value) { 
		return key==="" ? value:decodeURIComponent(value); 
	});
	//	
	for(var pj in pJSON) {
		$("<input type='hidden' name='" + pj + "' value='" + pJSON[pj] + "'>").appendTo(dynaForm);
	}	
	//
	dynaForm.appendTo($("body"));
	dynaForm.submit();
	dynaForm.remove();
	return loadingWindow;
}

function setProgActionDesc(desc) {
	$("#lblProgAction").html(desc);
}
function tabFocus(tabIndex){
	$("#tabs").tabs("select", parseInt(tabIndex, 10));
}

$(document).ready(function() {
	try{
		if (window.parent != null && window.parent.$('#divPanel').length > 0) {
			window.parent.$('#divPanel').unblock();
		}
		$('*:input:not(textarea)').keypress(function(event){
		    // if the key pressed is the enter key
			var unicode = event.charCode ? event.charCode : event.keyCode;
		    if (unicode == 13)  {
		        return false;
		    }
		});	
		if($("#systemInfo").length > 0){
	        var defaults = {
				title: errTitle, width: 512, height : 256, maxHeight: 256, autoOpen: false,
				position:['right', 'bottom'], buttons:{"OK":function(){$(this).dialog("close");}}
	        };
	        $("#systemInfo").dialog(defaults);  
	    }
	    if ($(".inputDate").length > 0) {
	        $(".inputDate").datepicker(dc_dateParams);
			$(".inputDate").change(function() {
				if($(this).val().length == 8) {
					var year = $(this).val().substring(0, 4);
					var month = $(this).val().substring(4, 6);
					var day = $(this).val().substring(6, 8);
					$(this).val(year + "/" + month + "/" + day);
				}
			});
	    }
	    $(".inputTime").change(function() {
			if($(this).val().length == 4) {
				var mm = $(this).val().substring(0, 2);
				var ss = $(this).val().substring(2, 4);
				$(this).val(mm + ":" + ss);
			}
		});

//	    $("table.fixedTable>tbody>tr>td.wordWrap").hover(function() {
//	    	if(!$.trim($(this).text()) == "") {
//	    		$(this).prop("title", $.trim($(this).text()));
//	   	}
//	    }, function() {
//	    	$(this).removeAttr("title");
//	    });

	    $("img.imgButton").hover(function() {
			var tmp = $(this).attr("src").substring(0, $(this).attr("src").length - 4) + "-hover.png";
			$(this).prop("src", tmp);
		}, function() {
			$(this).attr("src", $(this).attr("src").replace("-hover", ""));
		});
	    
		<s:if test="hasFieldErrors() == false && hasActionErrors() == false">
		if (window.name.indexOf("ifrConfirm") >= 0) {
			window.parent.document.forms[0].style.display = "none";    
			window.parent.document.all[window.name].style.display = "inline";
			$("#btnUnBlockUI", window.parent.document).trigger("click");
	 	}
		</s:if>
		<s:else>
		if (window.name.indexOf("ifrConfirm") >= 0) {
			window.parent.document.forms[0].style.display = "inline";    
			window.parent.document.all[window.name].style.display = "none";
	 	}
		<s:if test="hasFieldErrors()">
		$("#systemInfo", window.parent.document).html($("#systemInfo").html());
	    $("#systemInfo ul li a", window.parent.document).each(function(i){
	        if ($(this).prop("lang") != "") {
	        	$("#" + $(this).prop("lang"), window.parent.document).addClass("ui-state-error");
	        	$(this).bind("click", function() {
	            	if (("" + $(this).prop("language")) != "" && typeof(parent.tabFocus) == "function") {
	                   	parent.tabFocus(parseInt($(this).prop("language"), 10));
	            	}
	            	$("#" + $(this).prop("lang"), window.parent.document).trigger("focus");
	    		});
	        }
	    });
	    $("#btnStatus", window.parent.document).trigger("click");
		</s:if>
	    $("#btnUnBlockUI", window.parent.document).trigger("click");
		</s:else>

		$(".labelCut").each(function(){	<%-- 文字內容截字串 --%>
			$(this).prop("lang", $(this).text());
		});
		$(".labelKey").each(function(){ <%-- 文字內容不變 --%>
			$(this).prop("lang", $(this).text());
		}); 
		<%-- 當 Menu 開啟時. 點選畫面任一地方關閉 Menu  --%>
		$("form").click(function() {
			if (jQuery.type(window.top) != "undefined" && typeof(window.top.menuHide) == "function") {
				window.top.menuHide();
			}
		});			
	}
	catch(e){
		alert("網頁發生異常，請聯絡系統管理員，確認作業是否完成。\n" + e);
	}
});

$(window).load(function() {
	window.status = "完成";
<s:if test="hasActionErrors()">
	if ($("#divDialogMsg").length > 0) {
		alertDialog($("#divDialogMsg").html().replaceAll("<BR>", "\n", true));
	}
	$("#btnUnBlockUI", window.parent.document).trigger("click");
	$(window).unbind("unload");
</s:if>

<s:if test="%{userInfo.chainFlag eq \"Y\"}">
	if (window.name.indexOf("ifrConfirm") >= 0) {
		$(window).unbind("unload");
	}
</s:if>
});

$.ajaxSetup({
	type:"POST",
	async:true,
	dataType:"json",
	cache:false,
	contentType: "application/x-www-form-urlencoded; charset=utf-8", 
	beforeSend:function() {},
	complete:function() {}
});
</script>
<s:set var="isInsertAction" value="progAction.startsWith('create') || progAction.startsWith('copy')"/>
<s:set var="isUpdateAction" value="progAction.startsWith('update')"/>
<s:set var="isProcessAction" value="progAction.startsWith('process')"/>
<s:set var="isDeleteAction" value="progAction.startsWith('delete')"/>