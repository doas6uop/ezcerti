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

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/comm/memo/prof_list';
	f.submit();
}

function doSelectedTarget(userNo, userName) {
	if(!$("#to_user_no", opener.document).val()) {
		$("#to_user_no", opener.document).val(userNo);
		$("#to_user_name", opener.document).val(userName);
	} else {
		if($("#to_user_no", opener.document).val().indexOf(userNo) != -1) {
			alert("이미 받는 사람으로 지정되어 있습니다.");			
		} else {
			$("#to_user_no", opener.document).val($("#to_user_no", opener.document).val() + "," + userNo);
			$("#to_user_name", opener.document).val($("#to_user_name", opener.document).val() + "," + userName);
		}
	}

	self.close();
}

</script>
</head>

<body bgcolor="#f0f0f0">

<!-- 메모 -->
<c:set var="pb" value="${pageBean }"/>
<div class="titlebox">
	<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="메모">&nbsp; 교수목록
</div>

<form id="searchForm" method="get" action="${pageContext.request.contextPath}/comm/memo/prof_list" autocomplete="off">
<div class="smallsearchbg">
<table width="100%" border="0" cellspacing="0" cellpadding="0"  style="margin-top:5px">
	<tr>
		<td width="21%" align="right">
			<select id="item" name="item" size="1" class="searchlistbox" id="list">
				<option value="coll_name" <c:if test="${param.item eq 'coll_name'}">selected</c:if>>단과명</option>
				<option value="dept_name" <c:if test="${param.item eq 'dept_name'}">selected</c:if>>학과명</option>
				<option value="name" <c:if test="${param.item eq 'name'}">selected</c:if>>교수명</option>
				<option value="code"<c:if test="${param.item eq 'code'}">selected</c:if>>사번</option>
			</select>
		</td>
		<td width="40%" align="left">
			&nbsp;&nbsp;<input type="text" id="value" name="value" value="${param.value}" class="searchtextbox" />
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
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="subbluebox" onclick="javascript:doSelectedTarget('${b.prof_no }','${b.prof_name}')">
			<tr>
				<td width="50%" align="left">&nbsp;<font style="color:#0000FF">${b.prof_name}</font>&nbsp;[${b.prof_no}]</td>
				<td width="50%" align="left">&nbsp;${b.coll_name} / ${b.dept_name}</td>
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
	<a href="javascript:window.close();"><img src="${pageContext.request.contextPath }/resources/images/common/close_button.png" alt="닫기버튼" /></a>
</div>

<input type="hidden" id="currentPage" name="currentPage">
<input type="hidden" id="coll_cd" name="coll_cd">
<input type="hidden" id="dept_cd" name="dept_cd">
</form>

</body>
</html>
