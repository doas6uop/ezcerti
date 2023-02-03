<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
</head>

<script>
	function doPrint() {
		$('#btnArea').css("display", "none");
		window.print();
	} 
</script>

<body>
<div style="padding:10px 0 0 15px">
<!-- 관리자출결현황 -->
<div class="titlebg">
<table width="800" border="0" cellpadding="0" cellspacing="0" >
	<tr>
		<td width="350" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/stats_title_05.png"  alt="학기통계타이틀" /></td>
		<td width="350" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;통계 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;강의별 통계</td>
	</tr>
</table>
</div>

<br />

<div id="btnArea" class="btnArea">
	<p align="left">
		<a href="${pageContext.request.contextPath}/prof/stats/stats_class_daily?prof_no=${classDetail.PROF_NO }&subject_cd=${classDetail.SUBJECT_CD }&subject_div_cd=${classDetail.SUBJECT_DIV_CD }&curr_year=${curr_year }&curr_term_cd=${curr_term_cd }&type=EXCEL">
			<img src="${pageContext.request.contextPath }/resources/images/common/e_down_button.png">
		</a>&nbsp;
		<a href="javascript:doPrint()">
			<img src="${pageContext.request.contextPath }/resources/images/common/print_button.png">
		</a>&nbsp;	
		<a href="javascript:self.close()">
			<img src="${pageContext.request.contextPath }/resources/images/common/close_button.png">
		</a>
	</p>
</div>

<br />

<!-- 강의수 -->
<c:set var="academicProfClassCount" value="${classDetail.CLASS_CNT - classDetail.OFF_CNT}" />

<table border="0" cellspacing="0" cellpadding="0" class="tstyle_col1" style="width:800px">
	<tr>
		<th>학과</th>
		<th>교수명(사번)</th>
		<th>학수번호</th>
		<th>분반</th>
		<th>교과목명</th>
		<th>총강의수</th>
		<th>휴강수</th>
	</tr>
	<tr>
		<td>${classDetail.PROF_DEPT_NAME }</td>
		<td>${classDetail.PROF_NAME }(${classDetail.PROF_NO })</td>
		<td>${classDetail.SUBJECT_CD }</td>
		<td>${classDetail.SUBJECT_DIV_CD }</td>
		<td>${classDetail.CLASS_NAME }</td>
		<td>${academicProfClassCount }</td>
		<td>${classDetail.OFF_CNT }</td>
	</tr>
</table>

<br>

<c:set var="tableWidth" value="${(academicProfClassCount * 45) + 340}" />
<c:if test="${tableWidth < 1500}">
	<c:set var="tableWidth" value="1500" />
</c:if>

<table border="0" cellspacing="0" cellpadding="0" class="tstyle_col1" <%-- style="width:${tableWidth}px" --%>>
<tr>
	<th>NO</th>
	<th>학과</th>
	<th>학번</th>
	<th>학생명</th>
	<th>출석수</th>
	<th>공결수</th>
	<th>지각수</th>
	<th>결석수</th>
  
	<c:forEach var="list" items="${academicProfClassStats}" begin="0" varStatus="status" end="0">
		<c:forEach var="idx" begin="1" varStatus="status" end="${academicProfClassCount }">
			<c:set var="day">D${idx}</c:set>
			<th>${fn:replace(list[day], '-(', '<br/>(')}</th>
		</c:forEach>
	</c:forEach>

</tr>
<c:forEach var="list" items="${academicProfClassStats}" begin="1" varStatus="status" end="${fn:length(academicProfClassStats) - 1}">
	<tr>
			<td>${list.RNUM }</td>
			<td style="width:100px">${list.DEPT_NAME }</td>
			<td style="width:60px">${list.STUDENT_NO }</td>

			<td style="width:50px">
				${list.STUDENT_NAME }
				<c:choose>
		      		<c:when test="${list.STUDENT_STS_CD eq 'G012C002' }">
		      			<br/>(휴학)<br/>${list.STATUS_CHANGE_DATE }
		      		</c:when>
		      		<c:when test="${list.STUDENT_STS_CD eq 'G012C005' }">
		      			<br/>(제적)<br/>${list.STATUS_CHANGE_DATE }
		      		</c:when>
		      	</c:choose>
		      	<c:if test="${list.JOB_PASS eq 'F' or list.JOB_PASS eq 'H'}">&nbsp;(취)</c:if>
			</td>

			<td style="width:50px">${list.ATTEND_PRESENT_CNT }</td>
			<td style="width:50px">${list.ATTEND_GONGGYUL_CNT }</td>
			<td style="width:50px">${list.ATTEND_LATE_CNT }</td>
			<td style="width:50px">${list.ATTEND_ABSENT_CNT }</td>
			
			<c:forEach var="idx" begin="1" varStatus="status" end="${academicProfClassCount }">
				<c:set var="textCss" value="" />
				<c:set var="day">D${idx}</c:set>
				
				<c:if test="${list[day] == '결석'}"><c:set var="textCss" value="style='color:red'" /></c:if>
				<c:if test="${list[day] == '지각'}"><c:set var="textCss" value="style='color:blue'" /></c:if>
				<c:if test="${list[day] == '휴강'}"><c:set var="textCss" value="style='color:#FF7F27'" /></c:if>
				<c:if test="${list[day] == '공결'}"><c:set var="textCss" value="style='color:#AB65D1'" /></c:if>
				
				<td ${textCss }>${list[day]}</td>
			</c:forEach>
	</tr>
</c:forEach> 
<c:if test="${fn:length(academicProfClassStats) <= 1 }">
	<tr>
		<td class="tdwhite" colspan="${academicProfClassCount + 6}" align="center" style="padding:30px 0 30px 0; border-right:none;">검색결과가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${fn:length(academicProfClassStats) > 10 }">
	<tr>
		<th>NO</th>
		<th>학과</th>
		<th>학번</th>
		<th>학생명</th>
		<th>출석수</th>
		<th>공결수</th>
		<th>지각수</th>
		<th>결석수</th>
	  
		<c:forEach var="list" items="${academicProfClassStats}" begin="0" varStatus="status" end="0">
			<c:forEach var="idx" begin="1" varStatus="status" end="${academicProfClassCount }">
				<c:set var="day">D${idx}</c:set>
				<th>${fn:replace(list[day], '-(', '<br/>(')}</th>
			</c:forEach>
		</c:forEach>
	
	</tr>
</c:if>

</table>

<br>
</div>

</body>
</html>

