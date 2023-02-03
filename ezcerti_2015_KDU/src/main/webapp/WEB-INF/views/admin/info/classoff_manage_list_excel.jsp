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
    <td colspan="4" align="left" valign="bottom">일괄휴강관리</td>
    <td colspan="3" align="right" valign="bottom">[총 ${pb.allCnt }건]</td>
  </tr>
</table>
<table width="700" border="1" cellspacing="0" cellpadding="0">
	<tr>
		<td width="32" align="center" valign="middle">NO</td>
		<td width="110" align="center" valign="middle">휴강처리일자</td>
		<td width="150" align="center" valign="middle">보강처리일자</td>
		<td width="50" align="center" valign="middle">사유</td>
		<td width="90" align="center" valign="middle">등록일</td>
		<td width="90" align="center" valign="middle">수행여부</td>
		<td width="90" align="center" valign="middle">수행일자</td>
	</tr>
<c:choose>
	<c:when test="${fn:length(pb.list)==0 }">
		<tr>
			<td class="tdwhite" colspan="7" align="center" style="padding:30px 0 30px 0; border-right:none;">검색결과가 존재하지 않습니다.</td>
		</tr>
	</c:when>
	<c:otherwise>
		<c:forEach var="b" items="${pb.list}" varStatus="status">
			<tr class="tr_over">
				<td>${b.classoffmanage_no}</td>
				<td>${b.classday }</td>
				<td>${b.before_classday }</td>
				<td>${b.classoffmanage_sayu }</td>
				<td>${b.regdate }</td>
				<td>
					<c:choose>
						<c:when test="${b.perform_flag eq 'Y'}">
							수행
						</c:when>
						<c:otherwise>
							미수행
						</c:otherwise>
					</c:choose>
				</td>
				<td>${b.perform_date }</td>
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