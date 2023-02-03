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
  <table width="970" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/stats_title_05.png"  alt="학기통계타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;통계 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;강의별 통계</td>
    </tr>
  </table>
</div>
<br />

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
  <tr>
    <td>${profStats.PROF_NO }</td>
    <td>${profStats.PROF_NAME }</td>
    <td>${profStats.PROF_ADM_NAME }</td>
    <td>${profStats.PROF_COLL_NAME }</td>
    <td>${profStats.PROF_DEPT_NAME }</td>
    <td>${profStats.ALL_CLASS }</td>
    <td>
      <c:if test="${empty profStats.ADD_CLASS }">
        -    
      </c:if>    	
    	${profStats.ADD_CLASS }    </td>
    <td>
    <c:if test="${empty profStats.OFF_CLASS }">
      -
    </c:if>    
    ${profStats.OFF_CLASS }    </td>
    <td>${profStats.PER_PRESENT }%</td>
    <td>${profStats.PER_LATE }%</td>
    <td>${profStats.PER_ABSENT }%</td>
    <td>${profStats.PER_ETC }%</td>
  </tr>
</table>

<br />

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
    <td style="font-weight: bold;"><a href="${pageContext.request.contextPath }/muniv/stats/stats_prof_daily?prof_no=${param.prof_no}&subject_cd=${list.SUBJECT_CD}&subject_div_cd=${list.SUBJECT_DIV_CD}">${list.CLASS_NAME }</a></td>
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

<br>
<p align="right">
	<a href="${pageContext.request.contextPath }/excel?target=statsProfTerm&prof_no=${param.prof_no }&item=${param.item}&value=${param.value}">
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

