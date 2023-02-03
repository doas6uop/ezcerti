<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<%
    response.setHeader("Content-Disposition", "attachment; filename=AcademicProfClassStat.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");
%>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<meta charset="utf-8">
<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
</head>

<body>
<div style="padding:10px 0 0 15px">

<table width="690" border="0" cellpadding="0" cellspacing="0" >
  <tr>
    <td colspan="5" align="left" valign="bottom">교수 통계</td>
  </tr>
</table>

<br />

<!-- 강의수 -->
<c:set var="academicProfClassCount" value="${classDetail.CLASS_CNT - classDetail.OFF_CNT}" />

<table border="1" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" valign="middle">학과</td>
		<td>${classDetail.PROF_DEPT_NAME }</td>
		<td align="center" valign="middle">교수명(사번)</td>
		<td colspan="2">${classDetail.PROF_NAME }(${classDetail.PROF_NO })</td>
		<td align="center" valign="middle">총강의수</td>
		<td>${academicProfClassCount }</td>
	</tr>
	<tr>
		<td align="center" valign="middle">학수번호</td>
		<td>${classDetail.SUBJECT_CD }-${classDetail.SUBJECT_DIV_CD }</td>
		<td align="center" valign="middle">교과목명</td>
		<td colspan="2">${classDetail.CLASS_NAME }</td>
		<td align="center" valign="middle">휴강수</td>
		<td>${classDetail.OFF_CNT }</td>
	</tr>
</table>

<br>

<table width="1500" border="1" cellspacing="0" cellpadding="0">
<tr>
	<td align="center" valign="middle">NO</td>
	<td align="center" valign="middle">학과</td>
	<td align="center" valign="middle">학번</td>
	<td align="center" valign="middle">학생명</td>
	
	<c:forEach var="list" items="${academicProfClassStats}" begin="0" varStatus="status" end="0">
		<c:forEach var="idx" begin="1" varStatus="status" end="${academicProfClassCount }">
			<c:set var="day">D${idx}</c:set>
			<td align="center" valign="middle" style="mso-number-format:'\@'">${fn:replace(list[day], '-(', '<br/>(')}</td>
		</c:forEach>
	</c:forEach>

	<td align="center" valign="middle">출석수</td>
	<td align="center" valign="middle">공결수</td>
	<td align="center" valign="middle">지각수</td>
	<td align="center" valign="middle">결석수</td>
</tr>
<c:forEach var="list" items="${academicProfClassStats}" begin="1" varStatus="status" end="${fn:length(academicProfClassStats) - 1}">
	<tr>
			<td align="center">${list.RNUM }</td>
			<td align="center">${list.DEPT_NAME }</td>
			<td align="center">${list.STUDENT_NO }</td>
			<td align="center">
				${list.STUDENT_NAME }
				<c:if test="${list.JOB_PASS eq 'F' or list.JOB_PASS eq 'H'}"> (취)</c:if>
			</td>
			
			<c:forEach var="idx" begin="1" varStatus="status" end="${academicProfClassCount }">
				<c:set var="textCss" value="" />
				<c:set var="day">D${idx}</c:set>
				
				<c:if test="${list[day] == '결석'}"><c:set var="textCss" value="style='color:red'" /></c:if>
				<c:if test="${list[day] == '지각'}"><c:set var="textCss" value="style='color:blue'" /></c:if>
				<c:if test="${list[day] == '휴강'}"><c:set var="textCss" value="style='color:#FF7F27'" /></c:if>
				<c:if test="${list[day] == '공결'}"><c:set var="textCss" value="style='color:#AB65D1'" /></c:if>
				
				<td align="center" ${textCss }>${list[day]}</td>
			</c:forEach>

			<td>${list.ATTEND_PRESENT_CNT }</td>
			<td>${list.ATTEND_GONGGYUL_CNT }</td>
			<td>${list.ATTEND_LATE_CNT }</td>
			<td>${list.ATTEND_ABSENT_CNT }</td>
	</tr>
</c:forEach> 
<c:if test="${fn:length(academicProfClassStats) <= 1 }">
	<tr>
		<td colspan="${academicProfClassCount + 6}" align="center">검색결과가 존재하지 않습니다.</td>
	</tr>
</c:if>
</table>

<br>
</div>

</body>
</html>

