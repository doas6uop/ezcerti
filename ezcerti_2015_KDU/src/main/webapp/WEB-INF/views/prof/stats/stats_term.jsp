<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">

<script>
$(document).ready(function(){
	$(".menu15 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_stats_on.gif");
	$(".menu15 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_stats_on.gif");
	$("#in_topmenu15").css("display","block");
	$("#in_menu15").css("display","block");
	
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

function doPopupProfClassStats(prof_no, subject_cd, subject_div_cd) {
	
	var curr_year = $("#curr_year").val();
	var curr_term_cd = $("#curr_term_cd").val();
	
	var targetURL = "${pageContext.request.contextPath}/prof/stats/stats_class_daily?prof_no="+prof_no+"&subject_cd="+subject_cd+"&subject_div_cd="+subject_div_cd+"&curr_year=" + curr_year + "&curr_term_cd=" + curr_term_cd;
	
	
	window.open(targetURL,'classStatPop','width=1550, height=800,top=0,left=0,toolbar=no, menubar=no, scrollbars=yes')
}

</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 교수 학기별통계 -->
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom">
      	<img src="${pageContext.request.contextPath}/resources/images/prof/stats_title_02.gif"  alt="학기별 통계" />
      </td>
      <td width="340" align="right" valign="bottom">
      	<img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;통계 &nbsp;
      	<img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;학기별 통계
      </td>
    </tr>
  </table>
</div>

<div>
	
</div>

<form id="searchForm" method="get" action="${pageContext.request.contextPath}/prof/stats/stats_term" autocomplete="off">
	<table width="699" border="0" cellpadding="0" cellspacing="0" style="padding-top: 5px;">
	  <tr>
	    <td align="center" valign="middle">
		    <table width="665" border="0" cellspacing="0" cellpadding="0">
		      <tr>
		      	<td width="45px;">학기 :</td>
		        <td width="110px;">
			        <select name="term_cd" id="lst_term" class="searchlistbox" onChange="javascript:doChangeTerm(this)">
			        	<c:forEach var="term" items="${termList }">
			        		<c:choose>
			        			<c:when test="${year eq term.year and term_cd eq term.term_cd}">
			        				<option value="${term.year}:${term.term_cd }" selected="selected">${term.term_name }</option>
			        			</c:when>
			        			<c:otherwise>
			        				<option value="${term.year}:${term.term_cd }">${term.term_name }</option>
			        			</c:otherwise>
			        		</c:choose>
			        	</c:forEach>
			        </select>
		        </td>
		        <td width="45px;">
		        	<button type="button" onclick="submit()"><img src="/resources/images/prof/button_reload2.png" style="height: 24px; vertical-align: middle;"/></button>
		        </td>
		        <td width="auto;">&nbsp;</td>
		      </tr>
		    </table>
		    
		    <input type="hidden" id="curr_year" name="curr_year">
			<input type="hidden" id="curr_term_cd" name="curr_term_cd">
	    </td>
	  </tr>
	</table>
</form>
<br/>
<table border="0" cellspacing="0" cellpadding="0" class="tstyle_col1">
  <tr>
    <th>사번</th>
    <th>교수명</th>
    <th>학기상태</th>
    <th>단과</th>
    <th width="20%">학과</th>
    <th>총강의수</th>
    <th>보강수</th>
    <th>휴강수</th>
    <th>출석</th>
    <th>지각</th>
    <th>결석</th>
    <th>기타</th>
  </tr>
<c:forEach var="profList" items="${profStats}">  
  <tr>
    <td>${profList.PROF_NO }</td>
    <td>${profList.PROF_NAME }</td>
    <td>${profList.PROF_ADM_NAME }</td>
    <td>${profList.PROF_COLL_NAME }</td>
    <td>${profList.PROF_DEPT_NAME }</td>
    <td>${profList.ALL_CLASS }</td>
    <td>
      <c:if test="${empty profList.ADD_CLASS }">
        -    
      </c:if>    	
    	${profList.ADD_CLASS }    </td>
    <td>
    <c:if test="${empty profList.OFF_CLASS }">
      -
    </c:if>    
    ${profList.OFF_CLASS }    </td>
    <td>${profList.PER_PRESENT }%</td>
    <td>${profList.PER_LATE }%</td>
    <td>${profList.PER_ABSENT }%</td>
    <td>${profList.PER_ETC }%</td>
</c:forEach>    
  </tr>
</table>

<br>


<table border="0" cellspacing="0" cellpadding="0" class="tstyle_col1">
  <tr>
    <th width="5%">NO</th>
    <th>강의번호</th>
    <th width="25%">강의명</th>
    <th>수업일</th>
    <th>보강일</th>
    <th>휴강일</th>
    <th>수강생</th>
    <th>출석</th>
    <th>지각</th>
    <th>결석</th>
    <th>기타</th>
    <th>휴학/제적</th>
  </tr>
<c:forEach var="list" items="${statsTermList }">
  <tr>
    <td>${list.ROWNUM }</td>
    <td>${list.SUBJECT_CD }-${list.SUBJECT_DIV_CD }</td>
    <td style="font-weight: bold;">
    	<!-- 
    	<a href="${pageContext.request.contextPath }/prof/stats/stats_daily?prof_no=${profList.PROF_NO}&subject_cd=${list.SUBJECT_CD}&subject_div_cd=${list.SUBJECT_DIV_CD }">${list.CLASS_NAME }</a>
    	-->
    	<a href="javascript:doPopupProfClassStats('${list.PROF_NO}','${list.SUBJECT_CD}','${list.SUBJECT_DIV_CD }')">${list.CLASS_NAME }</a>
    </td>
    <td>${list.ALL_CLASS }</td>
    <td>
      <c:if test="${empty list.ADD_CLASS}">    
        -
      </c:if>    
      <c:if test="${not empty list.ADD_CLASS}">
        ${list.ADD_CLASS }    
      </c:if>    </td>
    <td>
      <c:if test="${empty list.OFF_CLASS}">    
        -
      </c:if>    
      <c:if test="${not empty list.OFF_CLASS}">
        ${list.OFF_CLASS }    
      </c:if>    </td>
    <td>${list.ATTENDEE_CNT }</td>
    <td>${list.PER_PRESENT }%</td>
    <td>${list.PER_LATE }%</td>
    <td>${list.PER_ABSENT }%</td>
    <td>${list.PER_ETC }%</td>
    <td>
      <c:if test="${list.ATTEND_OFF_CNT=='0'}">    
        -
      </c:if>    
      <c:if test="${list.ATTEND_OFF_CNT!='0'}">
        ${list.ATTEND_OFF_CNT }    
      </c:if>
      /   
      <c:if test="${list.ATTEND_QUIT_CNT=='0'}">    
        -
      </c:if>    
      <c:if test="${list.ATTEND_QUIT_CNT!='0'}">
        ${list.ATTEND_QUIT_CNT }    
      </c:if>    </td>
  </tr>
</c:forEach>
</table>

<!-- 
<p class="mg_t15 t_center">
	<a href="${pageContext.request.contextPath }/excel?target=statsProfTerm&prof_no=${profList.PROF_NO }&item=${param.item}&value=${param.value}">
		<img src="${pageContext.request.contextPath }/resources/images/common/e_down_button.png">
	</a>
</p>
-->
<!-- //교수 학기별통계 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

