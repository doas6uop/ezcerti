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
	$("#topmenu_03").removeClass('submenugrayfont').addClass('menubluefont');
	
	var termVal = $("#lst_term option:selected").val();
	splitTerm(termVal);
	
	if($("select#lst_term").length>0){
		$.getJSON("<c:url value='/m/prof/class/getclass'/>",{year:$('#curr_year').val(), term_cd: $('#curr_term_cd').val()}, function(j){
			var options = "<option value=''>강의선택</option>";
			for (var i = 0; i < j.length; i++) 
			{
				if(j[i].class_cd=='<c:out value="${class_cd}"/>'){
					options += '<option value="' + j[i].class_cd + '" selected="selected">(' + j[i].classday_name+') '+j[i].classhour_start_time+' | '+j[i].class_name+'</option>';
				}else{
					options += '<option value="' + j[i].class_cd + '">(' + j[i].classday_name+') '+j[i].classhour_start_time+' | '+j[i].class_name+'</option>';
				}
				
			}
			$("#lst_class").html(options);
			//$('#lst_dept option:first').attr('selected', 'selected');
		});
	}	
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

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/m/prof/attendee/attendee_list';
	f.submit();
}
$(function(){
	$("select#lst_term").change(function(){
		$.getJSON("<c:url value='/m/prof/class/getclass'/>",{year:$('#curr_year').val(), term_cd: $('#curr_term_cd').val()}, function(j){
			var options = "<option value=''>강의선택</option>";
			for (var i = 0; i < j.length; i++) 
			{
				options += '<option value="' + j[i].class_cd + '">(' + j[i].classday_name+') '+j[i].classhour_start_time+' | '+j[i].class_name+'</option>';
				
			}
			$("#lst_class").html(options);
			$('#lst_class option:first').attr('selected', 'selected');
		});
	}); 	
});
</script>
</head>

<body bgcolor="#f0f0f0">
<div>
	<jsp:include page="../../header.jsp"></jsp:include>
</div>
<!-- 수강생목록 -->
<c:set var="pb" value="${pageBean }"/>
<form id="searchForm" method="get" action="${pageContext.request.contextPath}/m/prof/attendee/attendee_list" autocomplete="off">
<div class="titlebox">
<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="아이콘">&nbsp; 수강생 목록</div>

<div class="smallsearchbg">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="13%" height="37">학기</td>
      <td width="25%" align="left">
      
      <select name="term_cd" id="lst_term" class="searchlistbox" style="max-width:86px;" onChange="javascript:doChangeTerm(this)">
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
      <td width="16%">강의명</td>
      <td width="31%" align="left">
	   <select name="class_cd" id="lst_class" class="searchlistbox" style="max-width:80px;">
        </select>
      </td>
      <td width="15%" align="center">
      	<button><img src="${pageContext.request.contextPath}/resources_m/images/search_button.png" style="max-width:53px;" alt="검색버튼"></button>
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
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="subbluebox" 	onclick="location.href='${pageContext.request.contextPath}/prof/attendee/attendee_view?class_cd=${class_cd}<c:if test='${empty class_cd }'>${lectureList[0].class_cd }</c:if>&student_no=${b.student_no }'">
  <tr>
    <td width="11%" rowspan="2" align="left" valign="middle">
    <div class="numberbox">${b.row_no }</div></td>
    <td width="16%" rowspan="2" style="font-size:16px; font-weight:bold">${b.student_name }</td>
    <td width="38%" align="center">${b.dept_name }</td>
    <td width="18%" height="24" align="center" class="englishfont">${b.student_no }</td>
    <td width="15%" height="24" align="center">${b.student_grade_cd }</td>
    </tr>
  <tr>
    <td width="38%" align="center" class="englishfont">${b.hp_no }</td>
    <td align="center">&nbsp;</td>
    <td align="center">${b.student_sts_cd }</td>
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
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin:15px 0 15px 0;">
	<tr>
	    <td height="25" align="center" class="paginggrayfont"><my:pageGroupMobile/></td>
	</tr>
</table>
<table width="97%" border="0" align="center" cellpadding="0" cellspacing="0" class="graytable">
  <tr>
    <td width="28%" height="40" align="right">
     <select id="item" name="item" size="1" class="searchlistbox" id="list">
        <option value="name"
		<c:if test="${param.item=='name'}">
			selected
			</c:if>
			>학생명</option>
			<option value="code"
		<c:if test="${param.item=='code'}">
			selected
		</c:if>
			>학번</option>
   	</select>
    </td>
    <td width="45%" align="center"><input type="text" id="value" name="value" value="${param.value}" class="searchtextbox" /></td>
    <td width="27%" align="left">
    <div class="visual">
    <button><img src="${pageContext.request.contextPath}/resources_m/images/search_button.png" style="max-width:61px;" alt="검색버튼"></button>
    </div>
    </td>
  </tr>
</table>
<input type="hidden" id="subject_cd" name="subject_cd">
<input type="hidden" id="subject_div_cd" name="subject_div_cd">
<input type="hidden" name="currentPage" value="${currentPage }">
<input type="hidden" id="curr_year" name="curr_year">
<input type="hidden" id="curr_term_cd" name="curr_term_cd">
</form>
<!-- //수강생목록 -->
<div>
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
</body>
</html>
