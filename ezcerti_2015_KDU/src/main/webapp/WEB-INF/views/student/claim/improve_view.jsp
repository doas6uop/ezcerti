<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
$(function() {
	$.datepicker.regional['ko'] = {
	        closeText: '닫기',
	        prevText: '이전달',
	        nextText: '다음달',
	        currentText: '오늘',
	        monthNames: ['1월(JAN)','2월(FEB)','3월(MAR)','4월(APR)','5월(MAY)','6월(JUN)',
	        '7월(JUL)','8월(AUG)','9월(SEP)','10월(OCT)','11월(NOV)','12월(DEC)'],
	        monthNamesShort: ['1월','2월','3월','4월','5월','6월',
	        '7월','8월','9월','10월','11월','12월'],
	        dayNames: ['일','월','화','수','목','금','토'],
	        dayNamesShort: ['일','월','화','수','목','금','토'],
	        dayNamesMin: ['일','월','화','수','목','금','토'],
	        weekHeader: 'Wk',
	        dateFormat: 'yy-mm-dd',
	        firstDay: 0,
	        isRTL: false,
	        showMonthAfterYear: true,
	        yearSuffix: '',
	        showOn: 'focus',
	        changeMonth: true,
	        changeYear: true,
	        showButtonPanel: false,
	        yearRange: 'c-0:c+1',
	    };
	    $.datepicker.setDefaults($.datepicker.regional['ko']);
	 
	    $('#classday').datepicker();
});
</script>

<form id="frm_improve">

<c:choose>
	<c:when test="${procType eq 'NEW'}">
		<div style="width:100%; height:50%; overflow: auto;" class="grayboldtable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="graytableback">
					<td width="30%" height="27" class="leftpad">강의</td>
					<td width="70%">
						<select name="class_cd" id="class_cd" class="searchlistbox" style="width:180px;">
						
						<c:forEach var="list" items="${lectureList}">
							<option value="${list.class_cd}">(${list.classday_name}) ${list.classhour_start_time} | ${list.class_name}</option>
						</c:forEach>
		
						</select>
					</td>
				</tr>
				<tr>
					<td width="30%" height="27" class="leftpad">강의일</td>
					<td width="70%"><input type="text" id="classday" name="classday" class="searchtextbox" style="width:100px;" readonly="readonly"></td>
				</tr>
				<tr class="graytableback">
					<td valign="middle" class="leftpad">개선내역</td>
					<td class="rightpad"><textarea name="ask_claim_content" rows="6" maxlength="450" style="width:250px;"></textarea></td>
				</tr>
			</table>
			
			<input type="hidden" name="classhour_start_time" id="classhour_start_time">
		</div>	
	</c:when>
	<c:otherwise>
		<div style="width:100%; height:50%; overflow: auto;" class="grayboldtable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="graytableback">
					<td width="30%" height="27" class="leftpad">강의</td>
					<td width="70%">
						<select name="class_cd" id="class_cd" class="searchlistbox" style="width:180px;" disabled>
						
						<c:forEach var="list" items="${lectureList}">
							<option value="${list.class_cd}" <c:if test="${list.class_cd eq claim.class_cd}">selected</c:if>>(${list.classday_name}) ${list.classhour_start_time} | ${list.class_name}</option>
						</c:forEach>
		
						</select>
					</td>
				</tr>
				<tr>
					<td width="30%" height="27" class="leftpad">강의일</td>
					<td width="70%">${claim.classday } ${claim.classhour_start_time }</td>
				</tr>
				<tr class="graytableback">
					<td height="27" class="leftpad">개선내역</td>
					<td class="rightpad">${claim.class_improve_content }</td>
				</tr>
			</table>
			
			<input type="hidden" name="improve_no" id="improve_no" value="${claim.improve_no}">			
		</div>	
	</c:otherwise>
</c:choose>

</form>
