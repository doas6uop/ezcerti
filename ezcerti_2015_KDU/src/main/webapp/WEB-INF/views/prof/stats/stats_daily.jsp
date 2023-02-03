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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prof_style.css">
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
<!--  교수출결현황 -->
<c:set var="lecture" value="${profStatsDailyLecture }"/>	
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/stats_title_05.png"  alt="학기통계타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;통계 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;강의별 통계</td>
    </tr>
  </table>
</div>

<table border="0" cellspacing="0" cellpadding="0" class="tstyle_col1 mg_t15">
  <tr>
    <th>강의코드</th>
    <th width="20%">강의명</th>
    <th>교수명</th>
    <th>수업일</th>
    <th>수강생</th>
    <th>출결전</th>
    <th>출석</th>
    <th>지각</th>
    <th>결석</th>
    <th>기타</th>
    <th>휴학</th>
    <th>제적</th>
  </tr>
  <tr class="tr_over">
    <td>${lecture.SUBJECT_CD }-${lecture.SUBJECT_DIV_CD }</td>
    <td>${lecture.CLASS_NAME }</td>
    <td>${lecture.PROF_NAME }</td>
    <td>${lecture.CDAY }</td>
    <td>${lecture.ATTENDEE_CNT }</td>
    <td>${lecture.PER_BEFORE }%</td>
    <td>${lecture.PER_PRESENT }%</td>
    <td>${lecture.PER_LATE }%</td>
    <td>${lecture.PER_ABSENT }%</td>
    <td>${lecture.PER_ETC }%</td>
    <td>${lecture.ATTEND_OFF_CNT }</td>
    <td>${lecture.ATTEND_QUIT_CNT }</td>
  </tr>
</table>

<h4 class="mg_t30"><img src="${pageContext.request.contextPath}/resources/images/prof/stats_daily_h4.gif" alt="강의일별 통계"></h4>

<table border="0" cellspacing="0" cellpadding="0" class="tstyle_col1 mg_t10">
  <tr>
    <th>NO</th>
    <th>강의형태</th>
    <th>강의상태</th>
    <th>강의일</th>
    <th>강의시간</th>
    <th>출석</th>
    <th>지각</th>
    <th>결석</th>
    <th>휴학</th>
    <th>제적</th>
  </tr>
<c:forEach var="list" items="${profStatsDaily}">
<c:choose>
<c:when test="${list.class_type_cd=='G019C002' }">
	<tr class="tr_over">
    <td>${list.row_no }</td>
    <td>${list.class_type_name }</td>
    <td>${list.class_sts_name }</td>
    <td style="font-weight:bold;"><a href="${pageContext.request.contextPath }/prof/stats/stats_attendee?subject_cd=${list.subject_cd}&subject_div_cd=${list.subject_div_cd }&classday=${list.classday}&classhour_start_time=${list.classhour_start_time}">${list.classday} (${list.classday_name })</a></td>
    <td>${list.classhour_start_time} ~ ${list.classhour_end_time }</td>
    <td colspan="5">휴강</td>
  </tr>	
</c:when>
<c:otherwise>
  <tr class="tr_over">
    <td>${list.row_no }</td>
    <td>${list.class_type_name }</td>
    <td>${list.class_sts_name }</td>
    <td style="font-weight:bold;"><a href="${pageContext.request.contextPath }/prof/stats/stats_attendee?subject_cd=${list.subject_cd}&subject_div_cd=${list.subject_div_cd }&classday=${list.classday}&classhour_start_time=${list.classhour_start_time}">${list.classday} (${list.classday_name })</a></td>
    <td>${list.classhour_start_time} ~ ${list.classhour_end_time }</td>
    <td>${list.attend_present_cnt }</td>
    <td>${list.attend_late_cnt }</td>
    <td>${list.attend_absent_cnt }</td>
    <td>${list.attend_off_cnt }</td>
    <td>${list.attend_quit_cnt }</td>
  </tr>
</c:otherwise>
</c:choose>
</c:forEach>
</table>

<br>
<!-- 
<p class="t_center">
	<a href="${pageContext.request.contextPath }/excel?target=statsProfDaily&prof_no=${param.prof_no}&subject_cd=${lecture.SUBJECT_CD}&subject_div_cd=${lecture.SUBJECT_DIV_CD }&item=${param.item}&value=${param.value}">
		<img src="${pageContext.request.contextPath }/resources/images/common/e_down_button.png">
	</a>
</p>
-->
<!-- //관리자출결현황 -->
</div>
</div>

<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>

<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

