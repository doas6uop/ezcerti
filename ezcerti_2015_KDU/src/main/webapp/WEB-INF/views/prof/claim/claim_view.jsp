<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<form id="frm_claim">
<div style="width:100%; height:50%; overflow: auto;" class="grayboldtable">
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
      <td height="27" class="leftpad">학생명</td>
      <td>${claim.student_name } (${claim.student_dept_name })</td>
    </tr>
    <tr>
      <td height="27" class="leftpad">이의신청내역</td>
      <td>
      	${claim.before_claim_name } 
		<img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" /> 
		${claim.ask_claim_name }
      </td>
    </tr>
    <tr class="graytableback">
      <td valign="top" class="leftpad">이의내역</td>
      <td class="rightpad">${claim.ask_claim_content }</td>
    </tr>
  </table>
</div>
<div style="width:100%; height:30%; overflow: auto; margin-top:5px;" class="grayboldtable">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<c:choose>
<c:when test="${claim.claim_sts_cd=='G028C001' }">
	<c:choose>
		<c:when test="${resClassFlag eq 'Y'}">
			<tr>
				<td width="30%" height="27" class="leftpad">처리상태</td>
				<td width="70%">
					<select name="reply_claim_cd">
						<option value="G023C002">출석</option>
						<option value="G023C003">지각</option>
						<option value="G023C004">결석</option>
					</select>
				</td>
			</tr>
			<tr class="graytableback">
				<td height="27" class="leftpad">처리사유</td>
				<td>
					<select name="attend_auth_reason_cd">
					<c:forEach var="code" items="${codeListG024 }">
						<option value="${code.code}">${code.code_name}</option>
					</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td class="leftpad">처리내역</td>
				<td class="rightpad"><textarea id="reply_claim_content" name="reply_claim_content" rows="5" maxlength="450" style="width:190px;"></textarea></td>
			</tr>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="2" class="leftpad">
					<div style="padding: 8px 2px 8px 2px;">
						존재하지 않는 강의입니다.<br/>
						(휴·보강으로 인해  강의정보가 변경 되었습니다.)<br/><br/>
						'처리완료' 버튼을 클릭해 주시기 바랍니다.
					</div>
				</td>
			</tr>
		</c:otherwise>
	</c:choose>
	
</c:when>
<c:when test="${claim.claim_sts_cd=='G028C002' }">
<tr>
	<td width="30%" height="27" class="leftpad">처리상태</td>
	<td width="70%">
	${claim.before_claim_name } 
		<img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" /> 
	${claim.reply_claim_name}
	</td>
</tr>
<tr class="graytableback">
	<td valign="top" class="leftpad">처리내역</td>
	<td>${claim.reply_claim_content }</td>
</tr>
</c:when>
</c:choose>
</table>
</div>
	<input type="hidden" name="claim_no" value="${claim.claim_no }">
	<input type="hidden" name="term_cd" value="${claim.term_cd }">
	<input type="hidden" name="class_cd" value="${claim.class_cd }">
	<input type="hidden" name="classday" value="${claim.classday }">
	<input type="hidden" name="classhour_start_time" value="${claim.classhour_start_time }">
	<input type="hidden" name="before_claim_cd" value="${claim.before_claim_cd }">
	<input type="hidden" id="claim_sts_cd" value="${claim.claim_sts_cd }">
	<input type="hidden" name="student_no" value="${claim.student_no }">
	<input type="hidden" id="resClassFlag" value="${resClassFlag }">
</form>
