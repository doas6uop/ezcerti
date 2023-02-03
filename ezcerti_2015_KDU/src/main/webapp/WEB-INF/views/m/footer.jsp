<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<spring:eval expression="@config['chk_local']" var="chk_local"/>

<div class="subfooter">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="40%" height="60" align="center">
      <div class="visual">
      <img src="${pageContext.request.contextPath}/resources_m/images/footerb_logo.png" style="max-width:119px;" alt="푸터로고"></div>
      </td>
      <td align="left">&nbsp;(주)아이서티<br>
        &nbsp;Tel: 02)1544-5105</strong> <br>
        &nbsp;COPYRIGHT ⓒ 2014 icerti.</td>
    </tr>
  </table>
</div>

<script>
	$(document).ready(function(){
		
		//alert('현재 데이터베이스를 정비중에 있어서 출결시스템을 사용하실 수 없습니다.\n사용상에 불편을 드려 죄송합니다.\n잠시만 기다려 주세요.');
		
		// HTTP프로토콜 HTTPS로 변경
/* 		
		if (document.location.protocol == 'http:' && '${chk_local }' == 'N') {
			// location.href = $(location).attr('href').replace(/http:/gi, "https:");
		}
 */		
	});
</script>