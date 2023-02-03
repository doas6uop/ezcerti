<%@ page contentType="text/html; charset=UTF-8"%>
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
	$("#topmenu_${varMenuIdx}").removeClass('submenugrayfont').addClass('menubluefont');
 });

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'post';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/muniv/main/classoff_list';
	f.submit();
}

function doSearch(){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = 1;
	f.searchValue = "";
	f.action = '${pageContext.request.contextPath}/muniv/main/classoff_list';
	f.submit();
}

function doView(req_no){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.req_no.value = req_no;
	f.action = '${pageContext.request.contextPath}/muniv/main/classoff_view';
	f.submit();
}
</script>
</head>

<body bgcolor="#f0f0f0">
<div>
	<jsp:include page="../../header.jsp"></jsp:include>
</div>
<!-- 휴강신청내역 리스트 목록 -->
<c:set var="pb" value="${pageBean }"/>
<div class="titlebox">
	<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="아이콘">&nbsp; 휴강신청내역
</div>

<form id="searchForm" onsubmit="javascript:doSearch(); return false;" method="get" autocomplete="off">
<div class="smallsearchbg">
<table width="100%" border="0" cellspacing="0" cellpadding="0"  style="margin-top:5px">
	<tr>
		<td width="21%" align="right">
			<select id="searchItem" name="searchItem" size="1" class="searchlistbox" id="list">
				<option value="class_name" <c:if test="${param.searchItem eq 'class_name'}">selected</c:if>>과목명</option>
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

<div class="tablelayout">
	<c:forEach var="b" items="${pb.list }">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="subbluebox" onclick="javascript:doView('${b.req_no }')">
		<tr>
			<td width="70%" class="deepgraytd">&nbsp;${b.req_date }</td>
			<td width="30%" align="right" style="padding-right:5px" class="deepgraytd">${b.prof_name }</td>
		</tr>
		<tr>
			<td class="graysmallfont">
				<strong><a href="javascript:doView('${b.req_no }')">${b.class_name }&nbsp;</a></strong>
			</td>
			<td align="right" style="padding-right:5px" class="smallfont">(${b.proc_status_nm })</td>
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

<input type="hidden" id="currentPage" name="currentPage" value="${param.currentPage}">
<input type="hidden" id="req_no" name="req_no">

</form>

<div>
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
</body>
</html>
