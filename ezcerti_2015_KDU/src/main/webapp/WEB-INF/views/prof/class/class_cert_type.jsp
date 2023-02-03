<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>

<c:choose>
	<c:when test="${sessionScope.PROF_INFO.prof_adm_cd=='G026C002' }">
		alert("학기가 마감되어 변경이 불가능합니다.");
		window.location.reload(true);
	</c:when>
<c:otherwise>

function doChangeCertType(obj) {
	$("#cert_type").val(obj.value);
}
</script>
	
<!-- 강의인증 popup -->
<div id="cert_lecture0" style="width:95%; height:85%;" class="graybackbold">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="7%" height="35">
      	<img src="${pageContext.request.contextPath}/resources/images/prof/result_icon.png" width="10" height="13" alt="아이콘">
      </td>
      <td colspan="2">출결체크 방법을 선택하세요.</td>
    </tr>
    <tr>
      <td height="40" valign="top" style="padding-top:10px">&nbsp;</td>
      <!-- beacon 추가 -->
      <td colspan="2">
      	<input type="radio" name="certType" value="PROF_AUTH" onClick="javacript:doChangeCertType(this)">&nbsp;교수호명방식<br/>
      	<input type="radio" name="certType" value="CERT_NUM" onClick="javacript:doChangeCertType(this)">&nbsp;인증번호방식
      </td>
    </tr>
  </table>

<input type="hidden" name="cert_type" id="cert_type">
<input type="hidden" name="cert_sts_cd" value="${cert_sts_cd}">
<input type="hidden" name="class_cd" value="${class_cd}">
<input type="hidden" name="classday" value="${classday}">
<input type="hidden" name="classhour_start_time" value="${classhour_start_time}">
</div>
<!-- //강의인증 popup -->
</c:otherwise>
</c:choose>
