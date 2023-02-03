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
    <td colspan="4" align="left" valign="bottom">공결관리</td>
    <td colspan="4" align="right" valign="bottom">[총 ${pb.allCnt }건]</td>
  </tr>
</table>
<table width="700" border="1" cellspacing="0" cellpadding="0">
	<tr>
		<td width="32" align="center" valign="middle">NO</td>
		<td width="110" align="center" valign="middle">학번</td>
		<td width="150" align="center" valign="middle">이름</td>
		<td width="50" align="center" valign="middle">학기</td>
		<td width="90" align="center" valign="middle">공결기간</td>
		<td width="90" align="center" valign="middle">과목</td>
		<td width="90" align="center" valign="middle">공결시간</td>
		<td width="90" align="center" valign="middle">사유</td>
		<td width="90" align="center" valign="middle">제출</td>
	</tr>
<c:choose>
	<c:when test="${fn:length(pb.list)==0 }">
		<tr>
			<td class="tdwhite" colspan="5" align="center" style="padding:30px 0 30px 0; border-right:none;">검색결과가 존재하지 않습니다.</td>
		</tr>
	</c:when>
	<c:otherwise>
		<c:forEach var="b" items="${pb.list}" varStatus="status">
			<tr class="tr_over">
				<td>${b.row_no}</td>
				<td>${b.student_no }</td>
				<td>${b.student_name }</td>
				<td>
					<c:choose>
						<c:when test="${b.term_cd == 'G002C001'}">
							1학기
						</c:when>
						<c:otherwise>
							2학기
						</c:otherwise>
					</c:choose>
				</td>
				<td>${b.gong_ilja_start} ~ ${b.gong_ilja_end}</td>
				<td style="mso-number-format:'\@'">
					<c:forEach var="list_subject" items="${b.gonggyulSubjectList}">
						${list_subject.class_name}(${list_subject.classday_name})${list_subject.classhour_start_time}<br/>
					</c:forEach>
				</td>
				<td style="mso-number-format:'\@'">
					<c:forEach var="list_subject" items="${b.gonggyulSubjectList}">
						${list_subject.class_real_cnt}/${list_subject.class_total_cnt}<br/>
					</c:forEach>
				</td>
				<td>${b.gong_sayu}</td>
				<td>${b.submit_date}</td>
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