<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 이의신청 popup -->
<c:set var="adh" value="${attendDetailHistory}"/>
<c:set var="am" value="${attendMaster}"/>
<c:choose>
<c:when test="${not empty message }">
<script>
</script>
<div id="attend_claim1">
	<p align="center" style="margin-top:50px;">${message}</p>
</div>
</c:when>
<c:otherwise>
<div id="attend_claim1" class="grayboldtable">
<form id="frm_claim">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr class="graytableback">
	<td width="30%" height="27" class="leftpad">강의명</td>
	<td width="70%">${am.class_name}</td>
</tr>
<tr>
	<td height="27" class="leftpad">강의일시</td>
	<td>${am.classday } (${am.classday_name }) ${am.classhour_start_time }</td>
</tr>
<tr class="graytableback">
	<td height="27" class="leftpad">교수명</td>
	<td>${am.prof_name }</td>
</tr>
<tr>
	<td height="27" class="leftpad">현재출결상태</td>
	<td>
		<select name="before_claim_cd" disabled="disabled" >
			<option value="${adh.attend_sts_cd }">${adh.attend_sts_name }</option>
		</select>
	</td>
</tr>
<tr class="graytableback">
	<td height="27" class="leftpad">요구출결상태</td>
	<td>
		<select name="ask_claim_cd">
			<option value="G023C002">출석</option>
			<option value="G023C003">지각</option>
		</select>
	</td>
</tr>
<tr>
	<td height="75" class="leftpad">이의내용</td>
	<td>
		<textarea name="ask_claim_content" rows="4" maxlength="450" style="width:178px;"></textarea>
	</td>
</tr>
</table>
	<input type="hidden" name="class_cd" value="${am.class_cd }">
	<input type="hidden" name="classday" value="${am.classday }">
	<input type="hidden" name="classhour_start_time" value="${am.classhour_start_time }">
</form>
</div>
</c:otherwise>
</c:choose>
<!-- //이의신청 popup -->
