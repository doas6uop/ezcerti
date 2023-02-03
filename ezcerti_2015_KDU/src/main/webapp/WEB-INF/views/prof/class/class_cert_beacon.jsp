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
<!-- 강의인증 popup -->
<div id="cert_lecture1" style="width:95%; height:85%;" class="graybackbold">
  <table id="cert_lec" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="40" valign="top" style="padding-top:10px">
      	<img src="${pageContext.request.contextPath}/resources/images/prof/result_icon.png" width="10" height="13" alt="아이콘">
      </td>
      <td colspan="2">요청 후 선택된 유효시간까지 인증된 학생에 대하여 정상출석 처리됩니다.</td>
    </tr>
    <tr>
      <td height="30"><img src="${pageContext.request.contextPath}/resources/images/prof/result_icon.png" width="10" height="13" alt="아이콘"></td>
      <td width="23%">유효시간</td>
      <td width="70%">
      <select name="cert_time" id="cert_time" class="searchlistbox">
		<option value="60">1분</option>
		<option value="120">2분</option>
		<option value="180">3분</option>
		<option value="300" selected>5분</option>
		<option value="600">10분</option>
		<option value="900">15분</option>
	  </select>
     </td>
    </tr>
  </table>

<input type="hidden" name="cert_type" value="${cert_type}">
<input type="hidden" name="class_cd" value="${attendMaster.class_cd}">
<input type="hidden" name="classday" value="${attendMaster.classday}">
<input type="hidden" name="classhour_start_time" value="${attendMaster.classhour_start_time}">
<input type="hidden" name="cert_sts_cd" value="${attendMaster.cert_sts_cd}">
</div>
<!-- //강의인증 popup -->
</c:otherwise>
</c:choose>
