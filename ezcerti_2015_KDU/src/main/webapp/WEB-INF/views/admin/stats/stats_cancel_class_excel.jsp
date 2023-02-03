<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<%
    response.setHeader("Content-Disposition", "attachment; filename=AdminCancelClass.xls"); 
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
    <td colspan="3" align="left" valign="bottom">결강현황</td>
    <td colspan="3" align="right" valign="bottom">[총 ${pb.allCnt }건]</td>
  </tr>
</table>	
<table width="700" border="1" cellspacing="0" cellpadding="0">
	<thead>
		<tr>
	        <th width="30" align="center" valign="middle">NO</th>
	        <th width="220" align="center" valign="middle">강의일시</th>
	        <th width="125" align="center" valign="middle">학과</th>
	        <th width="150" align="center" valign="middle">과목</th>
	        <th width="110" align="center" valign="middle">교수</th>
	        <th width="110" align="center" valign="middle">직종</th>
	        <th width="110" align="center" valign="middle">연락처</th>
	        <th width="55" align="center" valign="middle">수강인원</th>
		</tr>
	</thead>
	<tbody>
	<c:choose>
		<c:when test="${fn:length(pb.list)==0 }">
			<tr>
				<td colspan="6" align="center">검색결과가 존재하지 않습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="b" items="${pb.list}" varStatus="status">
				<tr>
					<td>${b.row_no}</td>
					<td>${b.classday } <fmt:formatDate value="${b.classday }" type="time" pattern="(E)"/> ${b.classhour_start_time } ~ ${b.classhour_end_time }</td>
					<td>${b.prof_dept_name }</td>
					<td>${b.class_name }</td>
					<td>${b.prof_name }</td>
					<td>${b.prof_jikjong }</td>
					<td style='mso-number-format: "@";'>${b.etc_val }</td>
					<td>${b.attendee_cnt }</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose> 
	</tbody>
</table>
<!-- //관리자출결현황 -->
</div>
</div>

</div>
</body>
</html>

