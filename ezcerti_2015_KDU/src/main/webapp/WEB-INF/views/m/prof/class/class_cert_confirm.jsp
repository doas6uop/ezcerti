<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 강의인증 popup -->
<div id="cert_lecture2" style="width:95%; height:88%" class="graybackbold">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="8%" height="27"><img src="${pageContext.request.contextPath}/resources/images/prof/result_icon.png" width="10" height="13" alt="아이콘"></td>
      <td width="92%">${attendMaster.classday} (${attendMaster.classday_name}) ${attendMaster.classhour_start_time}</td>
    </tr>
    <tr>
      <td height="27"><img src="${pageContext.request.contextPath}/resources/images/prof/result_icon.png" width="10" height="13" alt="아이콘"></td>
      <td class="bluefont">${attendMaster.class_name}</td>
    </tr>
    <tr>
      <td height="27"><img src="${pageContext.request.contextPath}/resources/images/prof/result_icon.png" width="10" height="13" alt="아이콘"></td>
      <td>
      <c:choose>
		<c:when test="${cert_time==30 }">
      		유효시간: ${cert_time }초
      	</c:when>
	  	<c:otherwise>
	  		유효시간: <fmt:formatNumber value="${cert_time/60 }" type="NUMBER"/>분
		</c:otherwise>
	  </c:choose>
      </td>
    </tr>
    <tr>
      <td height="40" colspan="2" align="center">인증번호를 발급하시겠습니까?</td>
    </tr>
  </table>

<input type="hidden" name="cert_type" value="${cert_type }">
<input type="hidden" name="class_cd" value="${attendMaster.class_cd }">
<input type="hidden" name="classday" value="${attendMaster.classday }">
<input type="hidden" name="classhour_start_time" value="${attendMaster.classhour_start_time}">
<input type="hidden" name="cert_sts_cd" value="${attendMaster.cert_sts_cd }">
<input type="hidden" name="cert_time" value="${cert_time}">
</div>
<!-- //강의인증 popup -->
