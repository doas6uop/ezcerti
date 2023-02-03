<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="mg_t5">
  <table border="0" cellpadding="0" cellspacing="0" class="tstyle_row1">
    <tr>
      <th width="30%">신청상태</th>
      <td>${claim.before_claim_name } <img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" /> ${claim.ask_claim_name } (${claim.claim_sts_name }) </td>
    </tr>
    <tr>
      <th>강의명</th>
      <td>${claim.class_name }</td>
    </tr>
    <tr>
      <th>강의일시</th>
      <td>${claim.classday } ${claim.classhour_start_time }</td>
    </tr>
    <tr>
      <th>교수명</th>
      <td>${claim.prof_name }</td>
    </tr>
    <tr>
      <th>이의내역</th>
      <td>${claim.ask_claim_content }</td>
    </tr>
  </table>
</div>

<c:if test="${claim.claim_sts_cd=='G028C002' }">
<div class="mg_t5">
  <table border="0" cellpadding="0" cellspacing="0" class="tstyle_row1">
	<tr>
	  <th width="30%">처리상태</th>
	  <td>${claim.before_claim_name } <img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" /> ${claim.reply_claim_name}  </td>
	</tr>
	<tr>
	  <th>처리내역</th>
	  <td>${claim.reply_claim_content }</td>
	</tr>
  </table>
</div>
</c:if>
