<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<%
    response.setHeader("Content-Disposition", "attachment; filename=AcademicProfUsageStat.xls"); 
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
    <td colspan="5" align="left" valign="bottom">교수별 사용현황</td>
    <td colspan="4" align="right" valign="bottom">[총 ${pb.allCnt }건]</td>
  </tr>
</table>
<table width="700" border="1" cellspacing="0" cellpadding="0">
	<tr>
		<td width="30" align="center" valign="middle">NO</td>
		<td width="100" align="center" valign="middle">단과</td>
		<td width="120" align="center" valign="middle">학과</td>
		<td width="50" align="center" valign="middle">사번</td>
		<td width="100" align="center" valign="middle">성명</td>
		<td width="50" align="center" valign="middle">총 강의수</td>
		<td width="50" align="center" valign="middle">처리수</td>
		<td width="50" align="center" valign="middle">미처리수</td>
		<td width="50" align="center" valign="middle">사용률</td>
		<td width="40" align="center" valign="middle">마감</td>		
	</tr>
<c:choose>
	<c:when test="${fn:length(pb.list)==0 }">
		<tr>
			<td class="tdwhite" colspan="9" align="center" style="padding:30px 0 30px 0; border-right:none;">검색결과가 존재하지 않습니다.</td>
		</tr>
	</c:when>
	<c:otherwise>
		<c:forEach var="b" items="${pb.list}" varStatus="status">
			<c:choose>
				<c:when test="${b.PROF_ADM_CD eq 'G026C002'}">
					<c:set var="varClose" value="마감" />
				</c:when>
				<c:otherwise>
					<c:set var="varClose" value="&nbsp;" />
				</c:otherwise>
			</c:choose>
		
			<tr class="tr_over">
				<td>${b.ROW_NO}</td>
				<td>${b.COLL_NAME}</td>
				<td>${b.DEPT_NAME}</td>
				<td>${b.PROF_NO}</td>
				<td>${b.PROF_NAME}</td>
				<td>${b.TOT_CNT}</td>
				<td>${b.PROC_CNT}</td>
				<td>${b.NOT_PROC_CNT}</td>
				<td>${b.USAGE}%</td>
				<td>${varClose}</td>
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