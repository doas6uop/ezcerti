<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
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
<script>
$(document).ready(function(){
	$(".menu13 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_attendee_on.gif");
	$(".menu13 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_attendee_on.gif");
	
	var termVal = $("#lst_term option:selected").val();
	splitTerm(termVal);
	
	if($("select#lst_term").length>0){
		$.getJSON("<c:url value='/prof/class/getclass'/>",{year:$('#curr_year').val(), term_cd: $('#curr_term_cd').val()}, function(j){
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
	f.action = '${pageContext.request.contextPath}/prof/attendee/attendee_list';
	f.submit();
}
$(function(){
	$("select#lst_term").change(function(){
		$.getJSON("<c:url value='/prof/class/getclass'/>",{year:$('#curr_year').val(), term_cd: $('#curr_term_cd').val()}, function(j){
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

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 교수 수강생목록 -->
<c:set var="pb" value="${pageBean }"/>
<form id="searchForm" method="get" action="${pageContext.request.contextPath}/prof/attendee/attendee_list" autocomplete="off">
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/professor_attendee_title_01.png" alt="수강생목록 타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;수강생&nbsp;  <img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp; 수강생 목록</td>
    </tr>
  </table>
</div>
<table width="699" border="0" cellpadding="0" cellspacing="0" class="checkbg">
  <tr>
    <td align="center" valign="middle"><table width="645" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="59" align="left">학 기 : </td>
        <td width="135" align="left">
        
        <select id="lst_term" name="term_cd" class="searchlistbox" onChange="javascript:doChangeTerm(this)">
        	<c:forEach var="term" items="${termList}">
        		<c:choose>
        			<c:when test="${year eq term.year and term_cd==term.term_cd}">
        				<option value="${term.year}:${term.term_cd}" selected="selected">${term.term_name}</option>
        			</c:when>
        			<c:otherwise>
        				<option value="${term.year}:${term.term_cd}">${term.term_name}</option>
        			</c:otherwise>
        		</c:choose>
        	</c:forEach>
        </select>
        
        </td>
        <td width="65" align="left">강의명 :</td>
        <td width="275" align="left">
        <select name="class_cd" id="lst_class" class="searchlistbox" style="width:300px;">
        </select>
        </td>
        <td width="111"><button><img src="${pageContext.request.contextPath}/resources/images/prof/check_button.png" width="111" height="53" alt="조회버튼" /></button></td>
      </tr>
    </table></td>
  </tr>
</table>
<br />
<div class="alignright" >[ 총 ${pb.allCnt }건 ]</div>
<c:forEach var="b" items="${pb.list }">
  <table width="680" height="77" border="0" cellpadding="0" cellspacing="0" class="graybox" style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/prof/attendee/attendee_view?class_cd=${class_cd}<c:if test='${empty class_cd }'>${lectureList[0].class_cd }</c:if>&student_no=${b.student_no }'">
    <tr>
      <td width="60" rowspan="2" align="center" valign="middle"><div class="bluesquare">${b.row_no }</div></td>
      <td width="200" height="39" align="left" class="blackfont">${b.dept_name }</td>
      <td width="120" height="39" align="left" class="blackfont">${b.student_no }</td>
      <td width="100" height="39" align="left" class="blackfont">${b.student_grade_cd }</td>
      <td width="110" height="39" align="center" class="blackfont">${b.student_name }</td>
      <td width="40" rowspan="2" align="center" valign="middle" class="blackfont"><img src="${pageContext.request.contextPath}/resources/images/prof/list_right_arrow_icon.png" width="28" height="28" alt="회색화살표아이콘" /></td>
    </tr>
    <tr>
      <td width="200" class="grayfont">${b.hp_no }</td>
      <td class="grayfont">&nbsp;</td>
      <td class="grayfont">${b.student_sts_cd }</td>
      <td align="center">
		<c:choose>
      		<c:when test="${b.student_sts_cd eq '휴학' }">
      			${b.status_change_date }
      		</c:when>
      		<c:when test="${b.student_sts_cd eq '제적' }">
      			${b.status_change_date }
      		</c:when>
      	</c:choose>
	  </td>
    </tr>
  </table>
</c:forEach>
<c:if test="${empty pb.list }">
<table width="680" height="100" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center">데이터가 존재하지 않습니다.</td>
	</tr>
</table>
</c:if>
<br />
<table width="692" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="35" align="center" class="paginggrayfont"><my:pageGroup/></td>
  </tr>
  <tr>
    <td colspan="2" align="center" valign="middle" class="searchbg"><table width="390" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td><label for="list"></label>
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
        <td>
          <input type="text" id="value" name="value" value="${param.value}" class="searchtextbox"  /></td>
        <td align="right"><button><img src="${pageContext.request.contextPath}/resources/images/prof/search_button.png" width="69" height="26" alt="검색버튼" /></button></td>
      </tr>
    </table></td>
  </tr>
</table>
<input type="hidden" id="subject_cd" name="subject_cd">
<input type="hidden" id="subject_div_cd" name="subject_div_cd">
<input type="hidden" name="currentPage" value="${currentPage }">
<input type="hidden" id="curr_year" name="curr_year">
<input type="hidden" id="curr_term_cd" name="curr_term_cd">
</form>
<!-- //교수 수강생목록 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

