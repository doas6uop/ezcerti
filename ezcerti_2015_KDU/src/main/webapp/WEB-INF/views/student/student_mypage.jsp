<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<meta charset="utf-8">
<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/student_cert.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/student_style.css">
<script>
$(document).ready(function(){
	$(".menu21 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_mypage_on.gif");
	$(".menu21 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_mypage_on.gif");
	
});
</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 학생 마이페이지 -->
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/student/professor_mypage_title_01.png" width="128" height="20" alt="오늘의 강의 타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/student/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;마이페이지&nbsp; <img src="${pageContext.request.contextPath}/resources/images/student/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp; 오늘의 강의</td>
    </tr>
  </table>
</div>
<br />
<form>
<input type="hidden" name="classday" id="classday">
</form>
<table width="680" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="61">
    <c:if test="${not empty lectureDay.class_prev}">
    	<a href="${pageContext.request.contextPath}/student/student_mypage?classday=${lectureDay.class_prev }"><img src="${pageContext.request.contextPath}/resources/images/student/before_button.png" width="61" height="27" alt="이전버튼" /></a>
    </c:if>
    </td>
    	<td width="615" align="center" class="bigfont">${lectureDay.classday } (${lectureDay.classday_name})
    </td>
    <td width="10">
    <c:if test="${not empty lectureDay.class_next}">
    	<a href="${pageContext.request.contextPath}/student/student_mypage?classday=${lectureDay.class_next }"><img src="${pageContext.request.contextPath}/resources/images/student/next_button.png" width="61" height="27" alt="다음버튼" /></a>
   	</c:if>
    </td>
  </tr>
</table>
<c:forEach var="list" items="${attendList}">
<table width="680" height="87" border="0" cellpadding="0" cellspacing="0" class="graybox">
  <tr>
    <td width="98" rowspan="2" align="center" valign="middle" class="listleftbg">${list.class_type_name }<br />
      ${list.class_sts_name }</td>
    
    <td  align="left"  class="blackfont">
    	<a href="${pageContext.request.contextPath}/student/attend/attend_view?class_cd=${list.class_cd }">${list.class_name } (${list.classroom_no })</a>
    </td>
    <td width="62" height="37" align="right" class="blackfont">${list.prof_name }</td>
<%--정상,보강 --%>
<c:if test="${list.class_type_cd=='G019C001'||list.class_type_cd=='G019C003' }">
	<%--강의전 --%>
	<c:if test="${list.class_sts_cd=='G020C001' }">
		<td width="130" rowspan="2" align="center" valign="middle" class="listgraybigbox">강의전</td>
	</c:if>
	<%--//강의전 --%>
	<%--강의중 --%>
	<c:if test="${list.class_sts_cd=='G020C002' }">
		<%--인증요청전 --%>
		<c:if test="${list.cert_sts_cd=='G021C001' }">
			<td width="130" rowspan="2" align="center" valign="middle" class="listrightblue">출결전</td>
	    </c:if>
		<%--//인증요청전 --%>
		<%--인증요청후 --%>
		<c:if test="${list.cert_sts_cd=='G021C002' }">
			<c:if test="${list.attend_sts_cd=='G023C001' }">
				<c:if test="${list.cert_type eq 'PROF_AUTH'}">
					<td width="130" rowspan="2" align="center" valign="middle" class="listrightblue">강의중</td>
				</c:if>
				<c:if test="${list.cert_type eq 'BEACON_AUTH'}">
					<td width="130" rowspan="2" align="center" valign="middle" class="listrightblue">강의중</td>
				</c:if>
				<c:if test="${list.cert_type eq 'CERT_NUM'}">
					<td width="130" rowspan="2" align="center" valign="middle" class="listrightdeepb" style="cursor: pointer;" onclick="certLecture('${list.class_cd}','${list.classday}','${list.classhour_start_time}','${list.attend_sts_cd}')">출결인증</td>
				</c:if>
			</c:if>
			<c:if test="${list.attend_sts_cd=='G023C002'}">
				<td width="130" rowspan="2" align="center" valign="middle" class="listrightpurple">출석</td>
			</c:if>
			<c:if test="${list.attend_sts_cd=='G023C003'}">
				<td width="130" rowspan="2" align="center" valign="middle" class="listrightpurple">지각</td>
			</c:if>
			<c:if test="${list.attend_sts_cd=='G023C004'}">
				<td width="130" rowspan="2" align="center" valign="middle" class="listrightpurple">결석</td>
			</c:if>
		</c:if>
		<%--//인증요청후 --%>
	</c:if>
	<%--//강의중 --%>
	<%--강의완료 --%>
	<!-- c:if test="${list.class_sts_cd=='G020C003' && list.class_type_cd ne 'G019C003'}"-->
	<c:if test="${list.class_sts_cd=='G020C003'}">
		<td width="130" rowspan="2" align="center" valign="middle" class="listgraybigbox">강의종료</td>
	</c:if>
	<%--//강의완료 --%>
</c:if>
<%--//정상,보강 --%>
<%--휴강 --%>
<c:if test="${list.class_type_cd=='G019C002'}">
	<%--보강 없음 --%>
	<c:if test="${empty list.before_classday }">
     <td width="130" rowspan="2" align="center" valign="middle" class="listrightyellow">보강정보
     <hr style="noshade:noshade; size:1px; width:96px; color:#FFFFFF;" />
     없음<br></td>
	</c:if>
	<%--//보강 없음 --%>
	<%--보강 있음 --%>
	<c:if test="${not empty list.before_classday }">
	 <td width="130" rowspan="2" align="center" valign="middle" class="listrightyellow">보강정보
	 <hr style="noshade:noshade; size:1px; width:96px; color:#FFFFFF;" />
	 	<fmt:formatDate value="${list.before_classday}" type="date" pattern="yyyy-MM-dd"/><br>
		<fmt:formatDate value="${list.before_classday}" type="both" pattern="(E) HH:mm"/><br></span>
	</c:if>
	<%--//보강 있음 --%>
</c:if>
<%--//휴강  --%>    
  </tr>
  <tr>
  	<td colspan="2" valign="top" width="370" height="37" align="left" class="grayfont">
    	<a href="${pageContext.request.contextPath}/student/attend/attend_view?class_cd=${list.class_cd }">
    ${list.classday} (${lectureDay.classday_name}) ${list.classhour_start_time } ~ ${list.classhour_end_time }</a>
    	<c:if test="${list.is_team == 'Y'}">&nbsp;&nbsp;&nbsp;*팀티칭</c:if>
    </td>
  </tr>
</table>
</c:forEach>
<c:if test="${empty attendList }">
<table width="680" height="100" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center">데이터가 존재하지 않습니다.</td>
	</tr>
</table>
</c:if>

<!-- 강의목록 -->
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/student/professor_mypage_title_02.png" alt="강의목록 타이틀" /></td>
    </tr>
  </table>
</div>
<br />
<c:forEach var="list" items="${lectureList }">
<table width="680" height="77" border="0" cellpadding="0" cellspacing="0" class="graybox" style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/student/attend/attend_view?class_cd=${list.class_cd }'">
  <tr>
    <td width="60" rowspan="2" align="center" valign="middle"><div class="bluesquare">${list.row_no }</div></td>
    <td  align="left" class="blackfont">${list.class_name}</td>
    <td height="39" align="right" class="blackfont">${list.prof_name }</td>
    <td width="60" rowspan="2" align="center" valign="middle"><img src="${pageContext.request.contextPath}/resources/images/student/list_right_arrow_icon.png" width="28" height="28" alt="회색화살표아이콘" /></td>
  </tr>
  <tr>
    <td colspan="2" width="326" height="39" align="left" class="grayfont">${list.classday_name }요일 ${list.classhour_start_time } ~ ${list.classhour_end_time }
    <c:if test="${list.is_team == 'Y'}">&nbsp;&nbsp;&nbsp;*팀티칭</c:if>
    </td>
  </tr>
</table>
</c:forEach>
<c:if test="${empty lectureList }">
<table width="680" height="100" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center">데이터가 존재하지 않습니다.</td>
	</tr>
</table>
</c:if>
<!-- //강의목록 -->
<br>
<div id="dialog_cert_lecture1" title="강의인증"></div>	
<div id="dialog_cert_lecture2" title="강의인증"></div>	
<!-- //학생 마이페이지 -->
</div>
</div>
<div id="right"><jsp:include page="../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../footer.jsp"></jsp:include></div>
</div>
</body>
</html>