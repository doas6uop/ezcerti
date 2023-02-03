<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<%
    response.setHeader("Content-Disposition", "attachment; filename=ClassOffApproveList.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");
%>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<meta charset="utf-8">
<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>

<spring:eval expression="@config['makeup_lesson_approval']" var="makeup_lesson_approval"/>

</head>

<body>
<div id="wrap">
<div id="article">
<div id="contents">

	<c:set var="pb" value="${pageBean }"/>	
	<table width="790" border="0" cellpadding="0" cellspacing="0" >
	  <tr>
	    <td colspan="3" align="left" valign="bottom"></td>
	    <%-- <td colspan="2" align="right" valign="bottom">[총 ${pb.allCnt }건]</td> --%>
	  </tr>
	</table>
	
	<table width="800" border="1" cellspacing="0" cellpadding="0">
		<tr height="30">
			<td width="20" align="center" valign="middle">NO</td>
			<td width="150" align="center" valign="middle">교수</td>
			<td align="center" valign="middle">과목</td>
			<td width="180" align="center" valign="middle">휴강</td>
			<td width="180" align="center" valign="middle">보강</td>
		</tr>
		<c:if test="${fn:length(pb.list) <= 0}">
			<tr height="30">
				<td colspan="5" align="center">검색된 내용이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${fn:length(pb.list) > 0}">
			<c:forEach var="b" items="${pb.list}" varStatus="s">
			<tr height="30">
				<td align="center">${s.count}</td>
				<td align="center">${b.prof_name}(${b.prof_no})</td>
				<td>&nbsp;${b.class_name}</td>
				<td align="center"><fmt:formatDate value="${b.classday}" type="both" pattern="yyyy-MM-dd (E)"/>(${b.classhour_start_time})</td>
				<td align="center"><fmt:formatDate value="${b.before_classday}" type="both" pattern="yyyy-MM-dd (E)"/>(${fn:substring(b.before_classday, 11, 16)})</td>
			</tr>
			</c:forEach>					
		</c:if>
	</table>
<br>
</div>
</div>


</div>
</body>
</html>