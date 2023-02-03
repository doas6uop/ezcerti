<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 강의인증 popup -->
<c:choose>
<c:when test="${not empty message }">
<script>
setTimeout(function(){
		$("#dialog_cert_lecture1").dialog( "close" );
	}, 1500);
</script>
<div id="cert_lecture1">
	<p align="center" style="margin-top:50px;">${message}</p>
</div>
</c:when>
<c:otherwise>
<div id="cert_lecture1" class="graybackbold">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="35" colspan="2">
      	<input name="cert_code" type="text" class="searchtextbox">
      </td>
    </tr>
    <tr>
      <td width="7%" height="35" align="center" ><img src="${pageContext.request.contextPath}/resources/images/common/result_icon.png" width="10" height="13" alt="아이콘"></td>
      <td width="93%" height="35" align="left"> 인증번호를 입력해 주세요.</td>
    </tr>
  </table>
	<input type="hidden" name="class_cd" value="${class_cd}">
	<input type="hidden" name="classday" value="${classday}">
	<input type="hidden" name="classhour_start_time" value="${classhour_start_time}">
</div>
</c:otherwise>
</c:choose>
<!-- //강의인증 popup -->
