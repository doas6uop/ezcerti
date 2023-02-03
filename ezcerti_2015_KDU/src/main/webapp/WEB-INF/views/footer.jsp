<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<spring:eval expression="@config['chk_local']" var="chk_local"/>

<script type="text/javascript">

	var selectLocationURL = "";
	function selectLocation(el){
		var url = el.options[el.selectedIndex].value;
		if(url != "" && selectLocationURL != url){
			window.open(url);
			selectLocationURL = url;
		}
	}
	var selectLocationURL2 = "";
	function selectLocation2(el){
		var url = el.options[el.selectedIndex].value;
		if(url != "" && selectLocationURL2 != url){
			window.open(url);
			selectLocationURL2 = url;
		}
	}

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

    <div class="copyright">
    	<p class="bottom_logo"><img src="${pageContext.request.contextPath}/resources/images/footer/b_logo.gif"/></p>
      <div class="copy">
          <p>업체명 : (주)씨딘 | (07207) 서울특별시 영등포구 양평로 21길 26(선유도역 1차 아이에스비즈타워) 1706호 <br/> | 대표 : 정성기
         <!-- 사업자등록번호 : 107-87-42618 <br/>									-->
         <!-- 통신판매업 : 제 2020-대전유성-1627호	 | 직접생산자확인 : 제 2013-16266호<br/> -->
         TEL : 02-6925-6005 | FAX : 02-830-5405 | EMAIL : devteam@sitin.co.kr</p>
        <p>COPYRIGHT (C) 2013 Sitin. ALL RIGHT RESERVED.</p>
      </div>
    </div>
    <div class="familly_area">
    </div>