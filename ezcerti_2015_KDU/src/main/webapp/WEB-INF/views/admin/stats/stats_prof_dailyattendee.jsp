<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<meta charset="utf-8">
<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">

<script>
$(document).ready(function(){
	$(".menu7 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_stats_on.gif");
	$(".menu7 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_stats_on.gif");
	$("#in_topmenu7").css("display","block");
	$("#in_menu7").css("display","block");
});
</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 관리자출결현황 -->
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/stats_title_02.png"  alt="학기통계타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;통계 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;출결 현황</td>
    </tr>
  </table>
</div>

<div class="round_box_50 t_center bold mg_t20">
	<p><span>&middot; 강의명 : ${lecture.class_name }</span><span class="pd_l30">&middot; 강의코드 : ${lecture.subject_cd}-${lecture.subject_div_cd }</span><span class="pd_l30">&middot; 수강생 : ${lecture.attendee_cnt }명</span><span class="pd_l30">&middot; 강의일시 : ${lecture.classday_name }요일 ${lecture.classhour_start_time } ~ ${lecture.classhour_end_time }</span></p>
</div>

<table border="0" cellspacing="0" cellpadding="0" class="tstyle_col1 mg_t15">
  <tr>
    <th>NO</th>
    <th>학번</th>
    <th>학생명</th>
    <th>학과명</th>
    <th>${lecture.classday }</th>
    <th>출결전</th>
    <th>출석일</th>
    <th>지각일</th>
    <th>결석일</th>
  </tr>
<c:forEach var="list" items="${statsProfDailyAttendee }">
  <tr>
    <td>${list.ROW_NO }</td>
    <td>${list.STUDENT_NO }</td>
    <td><a href="${pageContext.request.contextPath }/muniv/student/student_view?student_no=${list.STUDENT_NO}">${list.STUDENT_NAME }</a></td>
    <td>${list.STUDENT_DEPT_NAME }</td>
<c:choose>
	<c:when test="${list.ATTEND_STS_CD=='G023C005'||list.ATTEND_STS_CD=='G023C007' }">
    <td colspan="5" class="tdwhitenone">${list.ATTEND_STS_NAME}</td>
	</c:when>
	<c:otherwise>
    <td>${list.ATTEND_STS_NAME}</td>
    <td>${list.ATTEND_BEFORE }</td>
    <td>${list.ATTEND_PRESENT }</td>
    <td>${list.ATTEND_LATE }</td>
    <td>${list.ATTEND_ABSENT }</td>
	</c:otherwise>
</c:choose>    
  </tr>
</c:forEach>
</table>

<br>
<p align="right">
	<a href="${pageContext.request.contextPath }/excel?target=statsAttendee&prof_no=${lecture.prof_no }&subject_cd=${lecture.subject_cd}&subject_div_cd=${lecture.subject_div_cd}">
		<img src="${pageContext.request.contextPath }/resources/images/common/e_down_button.png">
	</a>
</p>
<!-- //관리자출결현황 -->
</div>
</div>

<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>

<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

