<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

<%
   //치환 변수 선언
    pageContext.setAttribute("cr", "\r"); //Space
    pageContext.setAttribute("cn", "\n"); //Enter
    pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
    pageContext.setAttribute("br", "<br/>"); //br 태그
%>

<jsp:useBean id="to_day" class="java.util.Date" />
<fmt:formatDate value="${to_day}" pattern="yyyyMMdd" var="toDay" />

<script>
$(document).ready(function(){
	$("#topmenu_08").removeClass('submenugrayfont').addClass('menubluefont');
 });

function doList(){
	var f = document.getElementById('memo');
	f.method = 'post';
	f.action = '${pageContext.request.contextPath}/comm/memo/memo_list';
	f.submit();
}

function doDelete(){
	var postString = $("#memo").serialize();
	var r = confirm("삭제하시겠습니까?");
	if(r==true){
		$.ajax({
	        type: "POST",
	
	        url: "${pageContext.request.contextPath}/comm/memo/memo_delete",
	
	        data: postString,
	
	        success: function(msg) {
	        	alert(msg);
	        	document.location.replace('${pageContext.request.contextPath}/comm/memo/memo_list');
	        },
	        error: function(msg){
	        	alert("실패");
	        }
	    });
	}
} 

</script>
</head>

<body bgcolor="#f0f0f0">
<div>
	<jsp:include page="../../header.jsp"></jsp:include>
</div>
<!-- 메모 -->
<div class="titlebox">
	<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="메모">&nbsp; 메모
</div>

<fmt:formatDate pattern="yyyyMMdd" value="${memo.receive_date}" var="receiveDate" />
<c:choose>
	<c:when test="${receiveDate eq ''}">
		<c:set var="receiveDate" value="" />
	</c:when>
	<c:when test="${toDay eq receiveDate}">
		<fmt:formatDate pattern="HH:mm:ss" value="${memo.receive_date}" var="receiveFormatDate" />
	</c:when>
	<c:otherwise>
		<fmt:formatDate pattern="yyyy-MM-dd" value="${memo.receive_date}" var="receiveFormatDate" />
	</c:otherwise>
</c:choose>

<c:set var="receiveCheckDate" value="(${receiveFormatDate})" />
<c:if test="${receiveCheckDate eq '()'}">
	<c:set var="receiveCheckDate" value="" />
</c:if>

<form id="memo" name="memo" method="post">
<div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding:0px 5px 0px 5px">
		<tr>
			<td width="70%" height="30" align="left" class="deepgraytd">${memo.from_user_name}&nbsp;[<fmt:formatDate value="${memo.reg_date}" pattern="yyyy.MM.dd HH:mm:ss"/>]</td>
			<td width="30%" height="30" align="right" class="deepgraytd"><font style="color:#0000FF">${receiveCheckDate}</font></td>
		</tr>
		<tr>
			<td height="100%" colspan="2" align="left" class="graytd" style="padding:10px 5px 10px 5px">
				${fn:replace(memo.message, cn, br)}
			</td>
		</tr>
		<c:if test="${!empty board.boardFileList }">
		<tr>
			<td height="30" align="left" class="graytd">
			<c:forEach var="b" items="${board.boardFileList}">
				<a href="javascript:doBoardFileView('${b.file_no}')">${b.org_file_name}</a><br/>
			</c:forEach>
			</td>
		</tr>
		</c:if>
	</table>
</div>

<div class="photobutton">
	<c:set var="varAuth" value="F" />
	<c:if test="${user_type eq '[ROLE_SYSTEM]' || user_type eq '[ROLE_ADMIN]' || user_type eq '[ROLE_PROF]'}">
		<c:set var="varAuth" value="T" />
	</c:if>

	<a href="javascript:doList()"><img src="${pageContext.request.contextPath}/resources/images/admin/list_button.png" style="max-width:50px;" alt="목록버튼" /></a>&nbsp;
	<c:if test="${varAuth eq 'T'}">
		<a href="javascript:doDelete()"><img src="${pageContext.request.contextPath}/resources/images/admin/delete_button.png" style="max-width:50px;" alt="삭제버튼" /></a>
	</c:if>
</div>

<input type="hidden" id="currentPage" name="currentPage" value="${param.currentPage}">
<input type="hidden" id="searchItem" name="searchItem" value="${param.searchItem}">
<input type="hidden" id="searchValue" name="searchValue" value="${param.searchValue}">

<input type="hidden" id="memo_no" name="memo_no" value="${memo.memo_no}">
</form>

<div>
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
</body>
</html>
