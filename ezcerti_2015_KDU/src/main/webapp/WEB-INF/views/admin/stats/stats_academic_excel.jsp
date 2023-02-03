<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8" %>
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
    <td colspan="4" align="left" valign="bottom">학사팀 통계</td>
    <td colspan="4" align="right" valign="bottom">[총 ${pb.allCnt }건]</td>
  </tr>
</table>
<table width="690" border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td width="30" align="center" valign="middle" class="tdgray">NO</td>
    <td width="50" align="center" valign="middle" class="tdgray">학수번호</td>
    <td width="20" align="center" valign="middle" class="tdgray">분반</td>
    <td width="230" align="center" valign="middle" class="tdgray">교과목명</td>
    <td width="100" align="center" valign="middle" class="tdgray">학과</td>
    <td width="50" align="center" valign="middle" class="tdgray">교수사번</td>
    <td width="50" align="center" valign="middle" class="tdgray">교수명</td>
    <td width="50" align="center" valign="middle" class="tdgray">연락처</td>
    <td width="80" align="center" valign="middle" class="tdgray">강의수</td>
  </tr>
<c:forEach var="list" items="${pb.list}">
  <tr class="tr_over">
    <td class="tdwhite">${list.ROW_NO }</td>
    <td class="tdwhite">${list.SUBJECT_CD }</td>
    <td class="tdwhite">${list.SUBJECT_DIV_CD }</td>
    <td class="tdwhite">${list.CLASS_NAME }</td>
    <td class="tdwhite">${list.PROF_DEPT_NM }</td>
    <td class="tdwhite">${list.PROF_NO }</td>
    <td class="tdwhite">${list.PROF_NAME }</td>
    <td class="tdwhite" style="mso-number-format:'\@'">${list.HP_NO }</td>
    <td class="tdwhite">${list.CLASS_CNT }</td>
  </tr>
</c:forEach>
<c:if test="${fn:length(pb.list) == 0 }">
	<tr>
		<td colspan="9" align="center">검색결과가 존재하지 않습니다.</td>
	</tr>
</c:if>
</table>
<br>
</div>
</div>


</div>
</body>
</html>

