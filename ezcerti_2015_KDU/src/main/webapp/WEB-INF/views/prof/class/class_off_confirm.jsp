<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:choose>
	<c:when test="${sessionScope.PROF_INFO.prof_adm_cd=='G026C002' }">
		<script>
			alert("학기가 마감되어 변경이 불가능합니다.");
			window.location.reload(true);
		</script>
	</c:when>
	<c:otherwise>
		<!-- <script>
		    var smsInfo = '${smsInfo}';
		    if (smsInfo != '') {
		    	$.ajax({
					type: "POST",
					url: "http://sn.hs.ac.kr:8080/notice.do",
					data: "userId="+smsInfo+"&regId=gwanok&content="+$("#reqMemo").val()+"&callBackNum=031-379-0595"+"&onlySmart=N",
					headers : {"Access-Control-Allow-Origin":"*"},
					success: function(msg){
						if(msg.result=="pass"){
							alert('SMS 메시지발송 성공!');
						}else{
							alert('SMS 메시지발송 실패!');
						}
					},
					// Ajax 호출 오류 처리.
					error: function( objRequest ){
						console.log(objRequest);
						alert('SMS 메시지발송 오류!');
					}
				})
		    }
		</script>	 -->
<!-- 휴강처리 popup -->

<div id="skip_lecture2" style="width:100%; height:100%; padding:0;" class="graybackbold">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="10%" height="80" align="center"><img src="${pageContext.request.contextPath}/resources/images/prof/result_icon.png" width="10" height="13" alt="아이콘"></td>
      <td width="90%" align="left" class="bigbluefont">${message }</td>
    </tr>
  </table>
</div>
<input type="hidden" id="reqMemo" name="reqMemo" value="${smsClassName } : 휴강일 ${smsHugang}, 보강일 ${smsBogang}" />
<!-- //휴강처리 popup -->
</c:otherwise>
</c:choose>