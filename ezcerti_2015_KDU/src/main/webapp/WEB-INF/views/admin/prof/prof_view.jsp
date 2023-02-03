<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	$(".menu2 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_02.gif");
	$(".menu2 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_02.gif");
});
</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
	<!-- 교수상세정보조회 -->
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/sub_professor_title_02.png"  alt="교수상세정보타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;통합검색&nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp;교수상세정보 </td>
    </tr>
  </table>
</div>

<c:set var="profAdmCd" value="" />
<c:if test="${prof.prof_adm_cd eq 'G026C002'}">
	<c:set var="profAdmCd" value="<font color='#0000FF'>(학기마감)</font>" />
</c:if>

<div class="round_box_top mg_t30 float_left"></div>
<div class="round_box_center float_left">
  <table border="0" cellpadding="0" cellspacing="0" class="tstyle_row1">
  <tr>
    <th>사번</th>
    <td >${prof.prof_no }</td>
  </tr>
  <tr>
    <th>단과대학</th>
    <td>${prof.coll_name }</td>
  </tr>
  <tr>
    <th>학과명</th>
    <td>${prof.dept_name }</td>
  </tr>
  <tr>
    <th>교수명</th>
    <td>${prof.prof_name }</td>
  </tr>
  <tr>
    <th>연락처</th>
    <td>${prof.hp_no}</td>
  </tr>
  <tr>
    <th>상태</th>
    <td>${prof.prof_sts_cd }&nbsp;${profAdmCd}</td>
  </tr>
  <tr>
    <th>이메일</th>
    <td>${prof.email_addr }</td>
  </tr>
  <tr>
    <th>등록일</th>
    <td>${prof.reg_date }</td>
  </tr>
</table>
</div>
<div class="round_box_bottom float_left"></div>

<div class="aligncenter">
	<a href="javascript:window.location.href=parent.document.referrer"><img src="${pageContext.request.contextPath}/resources/images/admin/list_button.png" width="61" height="27" alt="목록버튼" /></a> &nbsp;
	<a href="${pageContext.request.contextPath}/muniv/prof/prof_edit?prof_no=${prof.prof_no }"><img src="${pageContext.request.contextPath}/resources/images/admin/insert_button_s.png" width="61" height="27" alt="수정버튼" /></a>
</div>

<br>
<br>

<div id="board">
	<p class="pd_r5 bold mg_b5">&nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/professor_list_title_02.png"  alt="교수별강의현황타이틀" /></p>
	<div id="board_list">	
		<form id="searchForm" onsubmit="javascript:doSearch(); return false;" method="post" autocomplete="off">
		<table width="700" border="0" cellspacing="0" cellpadding="0">
			<caption>게시판 목록</caption>
			<thead>
				<tr>
					<th width="52" class="bg_left" scope="col">번호</th>
					<th scope="col">과목코드</th>
					<th scope="col">강의명</th>
					<th width="15%" scope="col">요일</th>
					<th width="152" scope="col">수업시간</th>
					<th width="60" scope="col">수강인원</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${lectureList }">
				<tr>
					<td>${list.row_no }</td>
					<td>${list.subject_cd }-${list.subject_div_cd }</td>
					<td class="list_title">
						<a href="${pageContext.request.contextPath}/muniv/attend/class_attend_list?class_cd=${list.class_cd}">${list.class_name }</a>	        
					</td>
					<td>${list.classday_name }</td>
					<td>${list.classhour_start_time } ~ ${list.classhour_end_time }</td>
					<td>${list.attendee_cnt }</td>
				</tr>
				</c:forEach>
				<c:if test="${fn:length(lectureList)==0 }">
				<tr>
					<td colspan="6" align="center">결과가 존재하지 않습니다.</td>
				</tr>
				</c:if>			
			</tbody>
		</table>
	</div> <!-- board_list -->
</div> <!-- board -->

</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

