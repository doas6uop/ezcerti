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

<jsp:useBean id="to_day" class="java.util.Date" />
<fmt:formatDate value="${to_day}" pattern="yyyyMMdd" var="toDay" />

<script>
$(document).ready(function(){
	$("#topmenu_08").removeClass('submenugrayfont').addClass('menubluefont');
 });

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'post';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/comm/memo/memo_list';
	f.submit();
}

function doSearch(){
	var f = document.getElementById('searchForm');
	f.method = 'post';
	f.currentPage.value = 1;
	f.searchValue = "";
	f.action = '${pageContext.request.contextPath}/comm/memo/memo_list';
	f.submit();
}

function doView(memo_no){
	var f = document.getElementById('searchForm');
	f.method = 'post';
	f.memo_no.value = memo_no;
	f.action = '${pageContext.request.contextPath}/comm/memo/memo_view';
	f.submit();
}

</script>
</head>

<body bgcolor="#f0f0f0">
<div>
	<jsp:include page="../../header.jsp"></jsp:include>
</div>
<!-- 메모 목록 -->
<c:set var="pb" value="${pageBean }"/>
<div class="titlebox">
	<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="메모">&nbsp; 메모
</div>

<form id="searchForm" onsubmit="javascript:doSearch(); return false;" method="post" autocomplete="off">
<div class="smallsearchbg">
<table width="100%" border="0" cellspacing="0" cellpadding="0"  style="margin-top:5px">
	<tr>
		<td width="21%" align="right">
			<select id="searchItem" name="searchItem" size="1" class="searchlistbox" id="list">
				<option value="message" <c:if test="${param.searchItem eq 'message'}">selected</c:if>>내용</option>
				<option value="sender"<c:if test="${param.searchItem eq 'sender'}">selected</c:if>>보낸사람</option>
				<option value="receiver"<c:if test="${param.searchItem eq 'receiver'}">selected</c:if>>받는사람</option>
			</select>
		</td>
		<td width="40%" align="left">
			&nbsp;&nbsp;<input type="text" id="searchValue" name="searchValue" value="${param.searchValue}" class="searchtextbox" />
		</td>
		<td width="10%" align="center" valign="bottom">
			<div class="visual">
				<button><img src="${pageContext.request.contextPath}/resources_m/images/search_button.png" style="max-width:63px;" alt="검색버튼"></button>
			</div>
		</td>
	</tr>
</table>
</div>

<table width="97%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td width="5%" style="min-width:45px;">
		<c:if test="${cPage>1 }">
			<div class="visual">
				<a href="javascript:paging(${cPage-1 })"><img src="${pageContext.request.contextPath}/resources_m/images/beforeb_button.png" style="max-width:45px;" alt="이전버튼"></a>
			</div>
		</c:if>
		</td>
		<td width="90%" align="center" class="blackboldfont">[총 ${pb.allCnt }건]</td>
		<td width="5%" align="right" style="min-width:45px;">
		<c:if test="${pb.totalPage > cPage }">
			<div class="visual">
				<a href="javascript:paging(${cPage+1 })"><img src="${pageContext.request.contextPath}/resources_m/images/nextb_button.png" style="max-width:45px;" alt="다음버튼"></a>
			</div>
		</c:if>
		</td>
	</tr>
</table>

<div class="tablelayout">
	<c:forEach var="b" items="${pb.list }">

	<fmt:formatDate pattern="yyyy-MM-dd" value="${b.reg_date}" var="regDate" />
	<fmt:formatDate pattern="yyyyMMdd" value="${b.receive_date}" var="receiveDate" />
	<c:choose>
		<c:when test="${receiveDate eq ''}">
			<c:set var="receiveDate" value="" />
		</c:when>
		<c:when test="${toDay eq receiveDate}">
			<fmt:formatDate pattern="HH:mm:ss" value="${b.receive_date}" var="receiveFormatDate" />
		</c:when>
		<c:otherwise>
			<fmt:formatDate pattern="yyyy-MM-dd" value="${b.receive_date}" var="receiveFormatDate" />
		</c:otherwise>
	</c:choose>
	
	<c:set var="receiveCheckDate" value="(${receiveFormatDate})" />
	<c:if test="${receiveCheckDate eq '()'}">
		<c:set var="receiveCheckDate" value="" />
	</c:if>

	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="subbluebox" onclick="javascript:doView('${b.memo_no}')">
		<tr>
			<td width="50%">&nbsp;${b.from_user_name}[${regDate}]</td>
			<td width="50%" align="right">&nbsp;<font style="color:#0000FF">${receiveCheckDate}</font></td>
		</tr>
		<tr>
			<td height="33" colspan="2" class="graysmallfont"><a href="javascript:doView('${b.memo_no}')">${b.message}</a></td>
		</tr>
	</table>	
	</c:forEach>
	<c:if test="${empty pb.list }">
	<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0" class="subbluebox">
		<tr>
			<td align="center">데이터가 존재하지 않습니다.</td>
		</tr>
	</table>
	</c:if>

	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:20px;">
		<tr>
		    <td height="25" align="center" class="paginggrayfont"><my:pageGroupMobile/></td>
		</tr>
	</table>
</div>

<div class="photobutton">
	<c:set var="varAuth" value="F" />
	<c:if test="${user_type eq '[ROLE_SYSTEM]' || user_type eq '[ROLE_ADMIN]' || user_type eq '[ROLE_PROF]'}">
		<c:set var="varAuth" value="T" />
	</c:if>

	<c:if test="${varAuth eq 'T'}">
		<a href="${pageContext.request.contextPath}/comm/memo/memo_form">
			<img src="${pageContext.request.contextPath}/resources/images/admin/register_button.png" style="max-width:50px;" alt="등록버튼" />
		</a>
	</c:if>
</div>

<input type="hidden" id="currentPage" name="currentPage" value="${param.currentPage}">
<input type="hidden" id="memo_no" name="memo_no">
</form>

<div>
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
</body>
</html>
