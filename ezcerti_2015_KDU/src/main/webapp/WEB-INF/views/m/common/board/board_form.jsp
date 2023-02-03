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

<c:set var="varMenuIdx" value="" />
<c:set var="varTitleName" value="" />
<c:choose>
	<c:when test="${board_type eq 'NOTICE'}">	
		<c:set var="varMenuIdx" value="05" />

		<c:if test="${user_type eq '[ROLE_PROF]'}">
			<c:set var="varMenuIdx" value="06" />
		</c:if>
		
		<c:set var="varTitleName" value="공지사항" />
	</c:when>
	<c:otherwise>
		<c:set var="varMenuIdx" value="06" />

		<c:if test="${user_type eq '[ROLE_PROF]'}">
			<c:set var="varMenuIdx" value="07" />
		</c:if>

		<c:set var="varTitleName" value="문의게시판" />
	</c:otherwise>
</c:choose>

<script>
$(document).ready(function(){
	$("#topmenu_${varMenuIdx}").removeClass('submenugrayfont').addClass('menubluefont');
 });

function sendAjax() {
	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	var email_regx=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var postString = $("#board").serialize();
	var idReg = /^[0-9]{5,19}$/g;
	var regEmpPwd = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).*$/;

	var frm = new FormData(document.getElementById('board'));

	if(!$("#title").val()){
		alert("제목을 입력하세요.");
		$("#title").focus();
		return false;
	}

	$.ajax({
		url: "${pageContext.request.contextPath}/comm/board/board_form_submit",

		data: frm,
		dataType : 'text',
		processData : false,
		contentType : false,
		type : "POST",

		success: function(msg) {
			alert(msg);
			//document.location.replace('${pageContext.request.contextPath}/comm/board/board_list');
			doList();
		},
		error: function(msg){
			alert(msg);
		}
	});		
};
 
function doList(){
	var f = document.getElementById('board');
	f.method = 'post';
	f.enctype = '';
	f.action = '${pageContext.request.contextPath}/comm/board/board_list';
	f.submit();
}

</script>
</head>

<body bgcolor="#f0f0f0">
<div>
	<jsp:include page="../../header.jsp"></jsp:include>
</div>
<!-- Title Start -->
<c:set var="pb" value="${pageBean }"/>
<div class="titlebox">
	<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="아이콘">&nbsp; ${varTitleName}
</div>
<!-- Title End -->

<!-- Contents Start -->
<form id="board" enctype="multipart/form-data" onsubmit="javascript:sendAjax(); return false;">

<div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding:0px 5px 0px 5px">
		<tr>
			<td width="25%" height="30" align="center" class="deepgraytd">제목</td>
			<td class="graytd">
				<input id="title" name="title" class="searchtextbox" type="text" value="" size="43" maxlength="100"/>
			</td>
		</tr>
		<tr>
			<td width="25%" height="30" align="center" class="deepgraytd">내용</td>
			<td class="graytd">
				<textarea id="contents" name="contents" rows="10" cols="35"></textarea>
			</td>
		</tr>
		<!-- 
		<tr>
			<td width="25%" height="30" class="deepgrayhd">첨부파일</td>
			<td class="graytd">
				<input type="file" id="uploadFile" name="uploadFile">
			</td>
		</tr>
		-->		
	</table>
</div>

<div class="photobutton">
	<c:set var="varAuth" value="F" />
	<c:if test="${board.board_type eq 'NOTICE'}">
		<c:if test="${user_type eq '[ROLE_SYSTEM]' || user_type eq '[ROLE_ADMIN]' || user_type eq '[ROLE_PROF]'}">
			<c:set var="varAuth" value="T" />
		</c:if>
	</c:if>
	<c:if test="${board.board_type eq 'QNA'}">
		<c:if test="${user_type ne ''}">
			<c:set var="varAuth" value="T" />
		</c:if>
	</c:if>

	<a href="javascript:doList()"><img src="${pageContext.request.contextPath}/resources/images/admin/list_button.png" style="max-width:50px;" alt="목록버튼" /></a>&nbsp;
	<c:if test="${varAuth eq 'T'}">
		<button><img src="${pageContext.request.contextPath}/resources/images/admin/btnRegister.png" style="max-width:50px;" alt="등록버튼" /></button>
	</c:if>	
</div>

<input type="hidden" id="board_type" name="board_type" value="${board_type}">
</form>
<!-- Contents End -->

<!-- Footer Start -->
<div>
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
<!-- Footer End -->

</body>
</html>
