<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:choose>
<c:when test="${sessionScope.PROF_INFO.prof_adm_cd=='G026C002' }">
<script>
	alert("학기가 마감되어 변경이 불가능합니다.");
	window.location.reload(true);
</script>	
</c:when>
<c:otherwise>	
<!-- 휴강처리 popup -->
<c:if test="${empty attendList }">
<script>
alert("연강 가능한 강의가 없습니다.");
window.location.reload(true);
</script>
</c:if>
<div id="attend_copy">
<table width="290" border="0" align="center" style="margin-top:10px; margin-bottom:9px;" cellpadding="0" cellspacing="0">
<tr>
  <td width="20" height="14"><img src="${pageContext.request.contextPath}/resources/images/common/result_icon.png" width="10" height="13"></td>
  <td width="270" align="left" class="bluefont">연강할 강의를 선택해 주십시오.</td>
</tr>
</table>
<table width="290" border="0" align="center" cellpadding="0" cellspacing="0">
<tr class="grayback">
  <td width="190" height="35" align="center" >강의 일시</td>
  <td width="100" align="center" >연강여부</td>
</tr>
<c:forEach var="list" items="${attendList }">    
<tr class="grayback">
  <td height="28" align="center">${list.classday } (${list.classday_name}) ${list.classhour_start_time }</td>
  <td align="center"><input type="checkbox" name="copylist" value="${list.class_cd}||${list.classday}||${list.classhour_start_time}"></td>
</tr>
</c:forEach>    
</table>
<br>
<input type="hidden" name="class_cd" value="${class_cd}">
<input type="hidden" name="classday" value="${classday}">
<input type="hidden" name="classhour_start_time" value="${classhour_start_time}">
</div>
<div id="ajax_indicator" style="display:none">
   <p style="text-align:center; padding:16px 0 0 0; left:50%; top:50%; position:absolute;">
   	<img src="${pageContext.request.contextPath }/resources/images/ajax-loader.gif" />
   </p>
</div>
<!-- //휴강처리 popup -->
</c:otherwise>
</c:choose>