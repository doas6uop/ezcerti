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
	$("#topmenu_02").removeClass('submenugrayfont').addClass('menubluefont');
	
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

<body bgcolor="#f0f0f0">
<div>
	<jsp:include page="../../header.jsp"></jsp:include>
</div>
<!-- 강의출결목록 -->
<div class="titlebox">
<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="아이콘">&nbsp; 강의 목록</div>
<form id="searchForm" method="get" action="${pageContext.request.contextPath}/student/attend/attend_list" autocomplete="off">
	
	<div class="smallsearchbg">
	  <table width="98%" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	      <td width="15%" height="37" align="center"><strong>학 기 :</strong></td>
	      <td width="45%" align="left">
			
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
	      <td width="44%" align="right"><button><img src="${pageContext.request.contextPath}/resources_m/images/search_button.png" style="max-width:55px;" alt="검색버튼"></button></td>
	    </tr>
	  </table>
	</div>
	<div class="tablelayout">
	<c:forEach var="list" items="${lectureList }">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="subbluebox" onclick="location.href='${pageContext.request.contextPath}/student/attend/attend_view?class_cd=${list.class_cd }'">
	  <tr>
	    <td width="11%" rowspan="2" align="center" valign="middle">
	    <div class="numberbox">${list.row_no }</div></td>
	    <td height="24">&nbsp;${list.classday_name }요일 ${list.classhour_start_time }
	    <c:if test="${list.is_team == 'Y'}">&nbsp;&nbsp;&nbsp;*팀티칭</c:if>
	    </td>
	    <td width="24%" height="24" align="center">${list.prof_name }</td>
	    <td width="11%" rowspan="2" align="center" valign="middle">
	    <div class="visual"><img src="${pageContext.request.contextPath}/resources_m/images/blue_circleb_b_icon.png" style="max-width:23px;" alt="화살표아이콘">
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
	
	<input type="hidden" id="curr_year" name="curr_year">
	<input type="hidden" id="curr_term_cd" name="curr_term_cd">
	
</form>
<!-- //강의출결목록 -->
<div>
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
</body>
</html>
