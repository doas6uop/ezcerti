<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(document).ready(function(){
	var cert_no = '${attendMaster.class_cert_no}';
	var counts ='';
	for(i=0;i<cert_no.length;i++){
	    var tmp = cert_no.substring(i, i+1);
	    counts += '<img src="${pageContext.request.contextPath}/resources/images/common/number_' + tmp + '.png" style="margin-right:3px;">';
	}
	$("#output_no").html(counts);
});
</script>
<!-- 강의인증 popup -->
<div id="cert_lecture3">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
   <tr>
     <td height="50" colspan="2" align="center">
     	<span id="output_no"></span>
     </td>
   </tr>
   <tr>
     <td width="12%" height="40" align="center" valign="middle" class="grayback"><img src="${pageContext.request.contextPath}/resources/images/prof/result_icon.png" width="10" height="13" alt="아이콘"></td>
     <td width="88%" align="left" valign="middle" class="grayback">발급시간 : <fmt:formatDate value="${attendMaster.class_cert_issue_time}" type="both" pattern="yyyy-MM-dd (E) HH:mm:ss"/></td>
   </tr>
   <tr>
     <td height="30" align="center" valign="top" class="grayback"><img src="${pageContext.request.contextPath}/resources/images/prof/result_icon.png" width="10" height="13" alt="아이콘"></td>
     <td align="left" valign="top" class="grayback">
		<c:choose>
			<c:when test="${attendMaster.class_cert_time==30 }">
			${attendMaster.class_cert_time }초간 유효합니다.
			</c:when>
			<c:otherwise>
			<fmt:formatNumber value="${attendMaster.class_cert_time/60 }" type="NUMBER"/>분간 유효합니다.
			</c:otherwise>
		</c:choose>
     </td>
   </tr>
 </table>
 
<input type="hidden" name="class_cd" value="${attendMaster.class_cd}">
<input type="hidden" name="classday" value="${attendMaster.classday}">
<input type="hidden" name="classhour_start_time" value="${attendMaster.classhour_start_time}">
 
</div>
<!-- //강의인증 popup -->
