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
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/student_style.css">
<script>
$(document).ready(function(){
	$(".menu22 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_attend_on.gif");
	$(".menu22 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_attend_on.gif");
	
	var termVal = $("#lst_term option:selected").val();
	splitTerm(termVal);
	
});

function doChangeTerm(obj) {
	var termVal = $("#lst_term").val();
	
	splitTerm(termVal);
}

function splitTerm(termVal) {
	if(termVal != "") {
		var arrTermVal = termVal.split(":");
		
		$("#curr_year").val(arrTermVal[0]);
		$("#curr_term_cd").val(arrTermVal[1]);
	}	
}

</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 학생 강의출결목록 -->
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/student/professor_class_title_01.png" alt="강의출결 타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/student/home_icon.png" width="22" height="12" alt="홈아이콘" />  &nbsp; 강의출결 &nbsp;  <img src="${pageContext.request.contextPath}/resources/images/student/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp; 강의출결</td>
    </tr>
  </table>
</div>
<form id="searchForm" method="get" action="${pageContext.request.contextPath}/student/attend/attend_list" autocomplete="off">
	
	<table width="693" border="0" cellpadding="0" cellspacing="0" class="classtopbg">
	  <tr>
	    <td align="center" valign="middle"><table width="620" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="51" align="left">학 기 :</td>
	        <td width="274" align="left">
	        
	        <select name="term_cd" id="lst_term" class="searchlistbox" onChange="javascript:doChangeTerm(this)">
	        	<c:forEach var="term" items="${termList }">
	        		<c:choose>
	        			<c:when test="${year eq term.year and term_cd==term.term_cd }">
	        				<option value="${term.year}:${term.term_cd }" selected="selected">${term.term_name }</option>
	        			</c:when>
	        			<c:otherwise>
	        				<option value="${term.year}:${term.term_cd }">${term.term_name }</option>
	        			</c:otherwise>
	        		</c:choose>
	        	</c:forEach>
	        </select>
	        
	        </td>
	        <td width="295" align="right">
	        	<button><img src="${pageContext.request.contextPath}/resources/images/student/search_button.png" width="69" height="26" alt="검색버튼" /></button>
	        </td>
	      </tr>
	    </table></td>
	  </tr>
	</table>
	
	<input type="hidden" id="curr_year" name="curr_year">
	<input type="hidden" id="curr_term_cd" name="curr_term_cd">

</form>
<br />
<c:forEach var="list" items="${lectureList }">
<table width="680" height="77" border="0" cellpadding="0" cellspacing="0" class="graybox" style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/student/attend/attend_view?class_cd=${list.class_cd }&term_cd=${list.term_cd }&prof_no=${list.prof_no}'">
  <tr>
    <td width="60" rowspan="2" align="center" valign="middle"><div class="bluesquare">${list.row_no }</div></td>
    <td width="326" height="39" align="left" class="blackfont">${list.classday_name }요일 ${list.classhour_start_time } ~ ${list.classhour_end_time }
    <c:if test="${list.is_team == 'Y'}">&nbsp;&nbsp;&nbsp;*팀티칭</c:if>
    </td>
    <td height="39" align="center" class="blackfont">${list.prof_name }</td>
    <td width="60" rowspan="2" align="center" valign="middle"><img src="${pageContext.request.contextPath}/resources/images/student/list_right_arrow_icon.png" width="28" height="28" alt="회색화살표아이콘" /></td>
  </tr>
  <tr>
    <td colspan="2" align="left" class="grayfont">${list.class_name}</td>
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
<!-- //학생 강의출결목록 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>