<%@ page contentType="text/html; charset=UTF-8"%>
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

<c:set var="cr" value="${classOffRequest}"/>

<script>
$(document).ready(function(){
	$("#topmenu_${varMenuIdx}").removeClass('submenugrayfont').addClass('menubluefont');
 });

function doList(){
	location.replace("${pageContext.request.contextPath}/muniv/main/classoff_list");
}

function doDelete(req_no){
	var postString = {req_no: req_no, proc_type: 'DELETE', reject_reason: ''};

	var r = confirm("삭제하시겠습니까?");
	if(r==true){
		$.ajax({
	        type: "POST",
	
	        url: "${pageContext.request.contextPath}/prof/class/classoff_req_proc",
	
	        data: postString,
	
	        success: function(msg) {
	        	alert(msg);
	        	doList();
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
<div class="titlebox">
	<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="아이콘">&nbsp; 휴강신청내역
</div>

<!-- Contents Start -->
<div class=biginfobg3>
		<h4 style="text-align: center;">휴강신청서</h4>
		
		<table width="95%" cellpadding="0" cellspacing="0" border="1" align="center">
			<tr>
				<th class="deepgraytd2" width="30%">교수명</th>
					<td class="graytd2">${cr.prof_name}</td>
			</tr>
			<tr>
				<th class="deepgraytd2">사번</th>
					<td class="graytd2">${cr.prof_no}</td>
			</tr>
			<tr>
				<th class="deepgraytd2">과목명</th>
					<td class="graytd2">${cr.class_name} (${cr.subject_cd}-${cr.subject_div_cd})</td>
			</tr>
			<tr>
				<th class="deepgraytd2">수업일시</th>
					<td class="graytd2">${cr.classday} (${cr.classhour_start_time} ~ ${cr.classhour_end_time})</td>
			</tr>
			<tr>
				<th class="deepgraytd2">휴강사유</th>
					<td class="graytd2">${cr.req_reason}</td>
			</tr>

			<c:set var="addInfo" value="" />
			<c:if test="${cr.add_classday ne null}">
				<c:set var="addInfo" value="${cr.add_classday} (${cr.add_classhour_start_time} ~ ${cr.add_classhour_end_time})" />
			</c:if>
			
			<tr>
				<th class="deepgraytd2">보강일</th>
					<td class="graytd2">${addInfo}</td>
			</tr>
			
			<c:if test="${cr.proc_status eq 'G030C002'}">
				<tr>
					<th colspan="2">처리정보</th>
				</tr>
				<tr>
					<th class="deepgraytd2">신청일</th>
					<td class="graytd2"><fmt:formatDate value="${cr.req_date}" pattern="yyyy년 MM월 dd일"/></td>
				</tr>
				<tr>
					<th class="deepgraytd2">처리구분</th>
					<td class="graytd2">${cr.proc_status_nm}</td>
				</tr>
				<tr>
					<th class="deepgraytd2">처리일</th>
					<td class="graytd2"><fmt:formatDate value="${cr.proc_date}" pattern="yyyy년 MM월 dd일"/></td>
				</tr>
			</c:if>

			<c:if test="${cr.proc_status eq 'G030C003'}">
				<tr>
					<th colspan="2">처리정보</th>
				</tr>
				<tr>
					<th class="deepgraytd2">신청일</th>
					<td class="graytd2"><fmt:formatDate value="${cr.req_date}" pattern="yyyy년 MM월 dd일"/></td>
				</tr>
				<tr>
					<th class="deepgraytd2">처리구분</th>
					<td class="graytd2">${cr.proc_status_nm}</td>
				</tr>
				<tr>
					<th class="deepgraytd2">처리일</th>
					<td class="graytd2"><fmt:formatDate value="${cr.proc_date}" pattern="yyyy년 MM월 dd일"/></td>
				</tr>
				<tr>
					<th class="deepgraytd2">반려사유</th>
					<td class="graytd2">${cr.proc_reason}</td>
				</tr>			
			</c:if>
			
		</table>
		
		<p style="text-align: center;">신청일 : <fmt:formatDate value="${cr.req_date}" pattern="yyyy년 MM월 dd일"/></p>

</div>

<div class="photobutton">
	<a href="javascript:doList()"><img src="${pageContext.request.contextPath}/resources/images/admin/list_button.png" style="max-width:50px;" alt="목록버튼" /></a>&nbsp;
	<c:if test="${cr.proc_status eq 'G030C001'}">
	<a href="javascript:doDelete('${cr.req_no}')"><img src="${pageContext.request.contextPath}/resources/images/admin/delete_button.png" style="max-width:50px;" alt="삭제버튼" /></a>
	</c:if>
</div>

<input type="hidden" id="currentPage" name="currentPage" value="${param.currentPage}">
<input type="hidden" id="searchItem" name="searchItem" value="${param.searchItem}">
<input type="hidden" id="searchValue" name="searchValue" value="${param.searchValue}">

<input type="hidden" id="req" name="req_no" value="${cr.req_no}">
<!-- Contents End -->

<!-- Footer Start -->
<div>
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
<!-- Footer End -->

</body>
</html>
