<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/student_cert.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_m/css/smoothness/jquery-ui-1.10.3.custom.css">
<script>
$(document).ready(function(){
	$("#topmenu_01").removeClass('submenugrayfont').addClass('menubluefont');
});
</script>
</head>

<body bgcolor="#f0f0f0">
<div>
	<jsp:include page="../header.jsp"></jsp:include>
</div>
<!-- 학생 마이페이지 -->
<div class="titlebox">
<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="아이콘">&nbsp; 오늘의 강의</div>
<table width="97%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="5%">
    <c:if test="${not empty lectureDay.class_prev}">
    <div class="visual">
    <a href="${pageContext.request.contextPath}/m/student/student_mypage?classday=${lectureDay.class_prev }"><img src="${pageContext.request.contextPath}/resources_m/images/beforeb_button.png" style="max-width:45px;" alt="이전버튼"></a>
    </div>
    </c:if>
    </td>
    <td width="90%" align="center" class="blackboldfont">${lectureDay.classday } (${lectureDay.classday_name})</td>
    <td width="5%" align="right">
    <c:if test="${not empty lectureDay.class_next}">
    <div class="visual">
    <a href="${pageContext.request.contextPath}/m/student/student_mypage?classday=${lectureDay.class_next }"><img src="${pageContext.request.contextPath}/resources_m/images/nextb_button.png" style="max-width:45px;" alt="다음버튼"></a>
    </div>
    </c:if>
    </td>
  </tr>
</table>
<div class="tablelayout">
<c:forEach var="list" items="${attendList}">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="subbluebox">
  <tr>
    <td width="17%" rowspan="2" class="leftgraybox">${list.class_type_name }<br>
      ${list.class_sts_name }</td>
    <td width="44%">
    	<a href="${pageContext.request.contextPath}/student/attend/attend_view?class_cd=${list.class_cd }">
    	&nbsp;${list.classday} (${lectureDay.classday_name}) ${list.classhour_start_time }
    	</a>
    </td>
    
    <td width="13%" align="right">${list.prof_name }</td>
<%--정상,보강 --%>
<c:if test="${list.class_type_cd=='G019C001'||list.class_type_cd=='G019C003' }">
	<%--강의전 --%>
	<c:if test="${list.class_sts_cd=='G020C001' }">
		<td width="26%" rowspan="2"><div class="whiterightbox">강의전</div></td>
	</c:if>
	<%--//강의전 --%>
	<%--강의중 --%>
	<c:if test="${list.class_sts_cd=='G020C002' }">
		<%--인증요청전 --%>
		<c:if test="${list.cert_sts_cd=='G021C001' }">
			<td width="26%" rowspan="2"><div class="whiterightbox">출결전</div></td>
	    </c:if>
		<%--//인증요청전 --%>
		<%--인증요청후 --%>
		<c:if test="${list.cert_sts_cd=='G021C002' }">
			<c:if test="${list.attend_sts_cd=='G023C001' }">
				<c:if test="${list.cert_type eq 'PROF_AUTH'}">
					<td width="26%" rowspan="2"><div class="rightdeepbbox">강의중</div></td>
				</c:if>
				<c:if test="${list.cert_type eq 'BEACON_AUTH'}">
					<td width="26%" rowspan="2"><div class="rightdeepbbox">강의중</div></td>
				</c:if>
				<c:if test="${list.cert_type eq 'CERT_NUM'}">
					<td width="26%" rowspan="2"><div class="rightdeepbbox" onclick="certLecture('${list.class_cd}','${list.classday}','${list.classhour_start_time}','${list.attend_sts_cd}')">출결<br>인증</div></td>
				</c:if>
			</c:if>
			<c:if test="${list.attend_sts_cd=='G023C002'}">
				<td width="26%" rowspan="2"><div class="rightpurplebox">출석</div></td>
			</c:if>
			<c:if test="${list.attend_sts_cd=='G023C003'}">
				<td width="26%" rowspan="2"><div class="rightpurplebox">지각</div></td>
			</c:if>
			<c:if test="${list.attend_sts_cd=='G023C004'}">
				<td width="26%" rowspan="2"><div class="rightpurplebox">결석</div></td>
			</c:if>
		</c:if>
		<%--//인증요청후 --%>
	</c:if>
	<%--//강의중 --%>
	<%--강의완료 --%>
	<c:if test="${list.class_sts_cd=='G020C003' }">
		<td width="26%" rowspan="2"><div class="whiterightbox">강의<br>종료</div></td>
	</c:if>
	<%--//강의완료 --%>
</c:if>
<%--//정상,보강 --%>
<%--휴강 --%>
<c:if test="${list.class_type_cd=='G019C002' }">
	<%--보강 없음 --%>
	<c:if test="${empty list.before_classday }">
    <td width="26%" rowspan="2"><div class="rightyellowbox">보강정보<br>없음<br></div></td>
	</c:if>
	<%--//보강 없음 --%>
	<%--보강 있음 --%>
	<c:if test="${not empty list.before_classday }">
    <td width="26%" rowspan="2"><div class="rightyellowbox">보강정보<br>
    <fmt:formatDate value="${list.before_classday}" type="date" pattern="yyyy-MM-dd"/><br>
    <fmt:formatDate value="${list.before_classday}" type="time" pattern="(E) HH:mm"/></div></td>
	</c:if>
	<%--//보강 있음 --%>
</c:if>
<%--//휴강  --%>      


  </tr>
  <tr>
    <td colspan="2" class="graysmallfont">
    	<c:if test="${list.is_team == 'Y'}">*팀티칭</c:if><br/>
    	<a href="${pageContext.request.contextPath}/student/attend/attend_view?class_cd=${list.class_cd }">${list.class_name }<br/>(${list.classroom_no })</a>
    </td>
  </tr>
</table>
</c:forEach>
<c:if test="${empty attendList }">
<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0" class="subbluebox">
	<tr>
		<td align="center">데이터가 존재하지 않습니다.</td>
	</tr>
</table>
</c:if>
</div>
<div class="titlebox">
<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="아이콘">&nbsp; 강의 목록</div>
<div class="tablelayout">
<c:forEach var="list" items="${lectureList }">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="subbluebox" onclick="location.href='${pageContext.request.contextPath }/student/attend/attend_view?class_cd=${list.class_cd }'">
  <tr>
    <td width="11%" rowspan="2" align="center" valign="middle">
    <div class="numberbox">${list.row_no }</div></td>
    <td height="24">&nbsp;${list.classday_name }요일 ${list.classhour_start_time }
    <c:if test="${list.is_team == 'Y'}">&nbsp;&nbsp;&nbsp;*팀티칭</c:if>
    </td>
    <td width="24%" height="24" align="center">${list.prof_name }</td>
    <td width="11%" rowspan="2" align="center" valign="middle">
    <div class="visual">
    	<img src="${pageContext.request.contextPath}/resources_m/images/blue_circleb_b_icon.png" style="max-width:23px;" alt="화살표아이콘">
    </div>
    </td>
  </tr>
  <tr>
    <td colspan="2" class="graysmallfont">${list.class_name}</td>
    </tr>
</table>
</c:forEach>
<c:if test="${empty lectureList }">
<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0" class="subgraybox">
	<tr>
		<td align="center">데이터가 존재하지 않습니다.</td>
	</tr>
</table>
</c:if>
<br>
</div>
<div id="dialog_cert_lecture1" title="강의인증"></div>	
<div id="dialog_cert_lecture2" title="강의인증"></div>	
<!-- //학생 마이페이지 -->
<div>
	<jsp:include page="../footer.jsp"></jsp:include>
</div>
</body>
</html>
