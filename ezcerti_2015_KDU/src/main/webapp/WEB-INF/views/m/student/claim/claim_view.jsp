<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div style="width:100%; height:55%; overflow: auto;" class="grayboldtable">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td height="27" class="leftpad">신청상태</td>
	<td>${claim.before_claim_name } 
		<img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" /> 
		${claim.ask_claim_name } (${claim.claim_sts_name })
	</td>
</tr>
<tr class="graytableback">
	<td width="30%" height="27" class="leftpad">강의명</td>
	<td width="70%">${claim.class_name }</td>
</tr>
<tr>
	<td height="27" class="leftpad">강의일시</td>
	<td>${claim.classday } ${claim.classhour_start_time }</td>
</tr>
<tr class="graytableback">
	<td height="27" class="leftpad">교수명</td>
	<td>${claim.prof_name }</td>
</tr>
<tr>
	<td valign="top" height="27" class="leftpad">이의내역</td>
	<td width="70%" style="word-break:break-word;">${claim.ask_claim_content }</td>
</tr>
</table>
</div>
<c:if test="${claim.claim_sts_cd=='G028C002' }">
<div style="width:100%; height:40%; margin-top:5px; overflow: auto;" class="grayboldtable">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr class="graytableback">
	<td width="30%" height="27" class="leftpad">처리상태</td>
	<td width="70%">
	${claim.before_claim_name } 
		<img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" /> 
	${claim.reply_claim_name}
	</td>
</tr>
<tr>
	<td valign="top" class="leftpad">처리내역</td>
	<td width="70%" style="word-break:break-word;">${claim.reply_claim_content }</td>
</tr>
</table>
</div>
</c:if>
