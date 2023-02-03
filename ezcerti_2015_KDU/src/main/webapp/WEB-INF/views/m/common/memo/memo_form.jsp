<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="format-detection" content="telephone=no" /> 

<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>

<link href="${pageContext.request.contextPath}/resources_m/css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/categorylayer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_m/css/smoothness/jquery-ui-1.10.3.custom.css">

<script>
$(document).ready(function(){
	$("#topmenu_08").removeClass('submenugrayfont').addClass('menubluefont');
 });

function sendAjax() {
	
	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	var email_regx=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    var postString = $("#memo").serialize();
    var idReg = /^[0-9]{5,19}$/g;
    var regEmpPwd = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).*$/;

    if(!$("#message").val()){
    	alert("내용을 입력하세요.");
    	$("#message").focus();
    	return false;
    }

    if(!$("#to_user_no").val()){
    	alert("받는사람을 입력하세요.");
    	return false;
    }
    
    $.ajax({
        type: "POST",

        url: "${pageContext.request.contextPath}/comm/memo/memo_form_submit",

        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},

        success: function(msg) {
        	alert(msg);
        	document.location.replace('${pageContext.request.contextPath}/comm/memo/memo_list');
        },
        error: function(msg){
        	alert(msg);
        }
	
    });
	
 };
 
 function doSearchProf() {
	 var url = "${pageContext.request.contextPath}/comm/memo/prof_list";
	 
	 window.open(url, "교수목록", "width=710, height=350, toolbar=no, menubar=no, scrollbars=no, resizable=no" ); 
 }

 function doClearReceiver() {
	 $("#to_user_no").val("");
	 $("#to_user_name").val("");
 }
 
</script>
</head>

<body bgcolor="#f0f0f0">
<div>
	<jsp:include page="../../header.jsp"></jsp:include>
</div>
<!-- 메모 -->
<c:set var="pb" value="${pageBean }"/>
<div class="titlebox">
	<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="메모">&nbsp; 메모
</div>

<form id="memo" name="memo" method="post" onsubmit="javascript:sendAjax(); return false;">
<div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding:0px 5px 0px 5px">
		<tr>
			<td width="25%" height="30" align="center" class="deepgraytd">받는사람</td>
			<td class="graytd">
				<input type="text" id="to_user_name" name="to_user_name" class="searchtextbox float_left" size="15"/>&nbsp;
				<a href="javascript:doSearchProf()"><img src="${pageContext.request.contextPath}/resources_m/images/add_prof.png" style="max-width:62px;" alt="교수선택" class="float_left" valign="middle"></a>
				<a href="javascript:doClearReceiver()"><img src="${pageContext.request.contextPath}/resources_m/images/clear_prof.png" style="max-width:62px;" alt="교수초기화" class="float_left" valign="middle"></a>
				<input type="hidden" id="to_user_no" name="to_user_no"/>
			</td>
		</tr>
		<tr>
			<td width="25%" height="30" align="center" class="deepgraytd">내용</td>
			<td class="graytd">
				<textarea id="message" name="message" rows="10" cols="35"></textarea>
			</td>
		</tr>
	</table>
</div>

<div class="photobutton">
	<c:set var="varAuth" value="F" />
	<c:if test="${user_type eq '[ROLE_SYSTEM]' || user_type eq '[ROLE_ADMIN]' || user_type eq '[ROLE_PROF]'}">
		<c:set var="varAuth" value="T" />
	</c:if>

	<a href="${pageContext.request.contextPath}/comm/memo/memo_list"><img src="${pageContext.request.contextPath}/resources/images/admin/list_button.png" style="max-width:50px;" alt="목록버튼" /></a>&nbsp;
	<c:if test="${varAuth eq 'T'}">
		<button><img src="${pageContext.request.contextPath}/resources/images/admin/register_button.png" style="max-width:50px;" alt="등록버튼" /></button>
	</c:if>
</div>

</form>

<div>
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
</body>
</html>
