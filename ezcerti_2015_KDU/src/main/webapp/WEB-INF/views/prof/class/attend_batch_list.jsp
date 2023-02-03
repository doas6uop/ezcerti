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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/prof_cert.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prof_style.css">
<script>
$(document).ready(function(){
	$(".menu12 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_attend_on.gif");
	$(".menu12 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_attend_on.gif");
	showElementTop(12);
	showElement(12);
	
});
</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 교수 일괄처리 리스트 -->
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/professor_batch_title.png" alt="강의목록 타이틀" /></td>
    </tr>
  </table>
</div>
<br />

<c:forEach var="list" items="${lectureList }">

	<table width="680" height="77" border="0" cellpadding="0" cellspacing="0" class="graybox" style="cursor: pointer;"
		onclick="window.open('${pageContext.request.contextPath}/prof/class/attend_batch_loading?class_cd=${list.class_cd}','_blank','width=1180, height=945, top=0, left=0,fullscreen=no, toolbar=no, menubar=no, scrollbars=yes, resizable=yes')">
		<%-- onclick="window.open('${pageContext.request.contextPath}/prof/class/attend_batch?class_cd=${list.class_cd}','_blank','width=1180, height=945, top=0, left=0,fullscreen=no, toolbar=no, menubar=no, scrollbars=yes, resizable=yes')"> --%>
	  <tr>
	    <td width="60" rowspan="2" align="center" valign="middle"><div class="bluesquare">${list.row_no }</div></td>
	    <td width="326" height="39" align="left" class="blackfont">${list.classday_name }요일 ${list.classhour_start_time } ~ ${list.classhour_end_time }</td>
	    <td width="97" height="39" align="right" class="blackfont">${list.subject_cd }-${list.subject_div_cd }</td>
	    <td width="97" height="39" align="right" class="blackfont">${list.attendee_cnt }명</td>
	    <td width="60" rowspan="2" align="center" valign="middle"><img src="${pageContext.request.contextPath}/resources/images/prof/list_right_arrow_icon.png" width="28" height="28" alt="회색화살표아이콘" /></td>
	  </tr>
	  <tr>
	    <td colspan="3" align="left" class="grayfont">${list.class_name}</td>
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
<!-- //교수 일괄처리 리스트 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

