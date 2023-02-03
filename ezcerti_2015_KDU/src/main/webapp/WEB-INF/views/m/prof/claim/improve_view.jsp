<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<form id="frm_claim">
<div style="width:100%; height:55%; overflow: auto;" class="grayboldtable">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
</form>
