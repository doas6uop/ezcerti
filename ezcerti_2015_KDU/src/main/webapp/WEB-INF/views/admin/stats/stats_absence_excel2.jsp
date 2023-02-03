<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<%
    response.setHeader("Content-Disposition", "attachment; filename=AcademicStat.xls"); 
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
<div id="wrap">
<div id="article">
<div id="contents">

<c:set var="pb" value="${pageBean }"/>	
<table width="690" border="0" cellpadding="0" cellspacing="0" >
  <tr>
    <td colspan="4" align="left" valign="bottom">결석현황</td>
    <td colspan="4" align="right" valign="bottom">[총 ${pb.allCnt }건]</td>
  </tr>
</table>
<table width="700" border="1" cellspacing="0" cellpadding="0">
	<tr>
		<td width="32" align="center" valign="middle">NO</td>
		<td width="110" align="center" valign="middle">단과</td>
		<td width="150" align="center" valign="middle">학과</td>
		<td width="50" align="center" valign="middle">학년</td>
		<td width="90" align="center" valign="middle">학번</td>
		<td width="90" align="center" valign="middle">이름</td>
		<td width="125" align="center" valign="middle">학생 연락처</td>
		<td width="50" align="center" valign="middle">상태</td>
		<td width="50" align="center" valign="middle">결석수</td>
		<td width="50" align="center" valign="middle">강의명</td>
		<td width="50" align="center" valign="middle">분반</td>
		<td width="50" align="center" valign="middle">학점</td>
		<td width="50" align="center" valign="middle">이론</td>
		<td width="50" align="center" valign="middle">실습</td>
		<td width="50" align="center" valign="middle">주간시수</td>
		<td width="50" align="center" valign="middle">교수이름</td>
		<td width="50" align="center" valign="middle">교수학과</td>
		<td width="50" align="center" valign="middle">교수 연락처</td>
	</tr>
<c:choose>
	<c:when test="${fn:length(pb.list)==0 }">
		<tr>
			<td class="tdwhite" colspan="9" align="center" style="padding:30px 0 30px 0; border-right:none;">검색결과가 존재하지 않습니다.</td>
		</tr>
	</c:when>
	<c:otherwise>
		<c:forEach var="b" items="${pb.list}" varStatus="status">
			<tr class="tr_over">
				<td>${b.row_no}</td>
				<td>${b.coll_name }</td>
				<td>${b.dept_name }</td>
				<td>${b.student_grade }학년</td>
				<td style="mso-number-format:'\@'">${b.student_no }</td>
				<td>${b.student_name }</td>
				<td style="mso-number-format:'\@'">${b.hp_no }</td>
				<td>${b.student_sts_name }</td>
				<td>${b.absence_cnt }</td>
				<td>${b.class_name }</td>
				<td>${b.subject_div_cd }</td>
				<td>${b.hakjum }</td>
				<td>${b.sigan }</td>
				<td>${b.pra_sigan }</td>
				<td>${b.total_cnt }</td>
				<td>${b.prof_name }</td>
				<td>${b.prof_deft_name }</td>
				<td style="mso-number-format:'\@'">${b.prof_hp_no }</td>
			</tr>
		</c:forEach>
	</c:otherwise>
</c:choose> 
</table>
<br>
</div>
</div>


</div>
</body>
</html>