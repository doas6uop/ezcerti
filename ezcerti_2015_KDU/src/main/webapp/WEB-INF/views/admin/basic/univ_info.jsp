<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<meta charset="utf-8">
<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">

<script>
$(document).ready(function(){
	$(".menu5 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_basic_on.gif");
	$(".menu5 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_basic_on.gif");
	$("#in_topmenu5").css("display","block");
	$("#in_menu5").css("display","block");
});
function endTerm(chgUnivStatus){
	
	//var postString = {statusList: statusList, class_cd: '${attendMaster.class_cd}', classday: '${attendMaster.classday}', classhour_start_time: '${attendMaster.classhour_start_time}'};
	var postString = {univ_sts_cd : chgUnivStatus};
	
	var confirmMsg1 = "학기를 마감하시겠습니까? 모든 교수의 상태도 학기마감으로 변경되며 출결정보 변경이 불가능합니다.";
	var confirmMsg2 = "학교상태를 정상으로 변경하시겠습니까?";
	if(chgUnivStatus=='end'){
		var r=confirm(confirmMsg1);
	}else{
		var r=confirm(confirmMsg2);
	}
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/muniv/basic/end_term",
        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
        success: function(msg) {
					if($.trim(msg) === "ok"){
						if(r==true){
						    $.ajax({
						        type: "POST",
						        url: "${pageContext.request.contextPath}/muniv/basic/end_term_confirm",
						        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
						        success: function(msg) {
											alert(msg);
											window.location.reload(true);
						        },
						        error: function(msg){
						        	alert(msg);
						        }

						    });	  
							
						}
					}else if($.trim(msg) === "no"){
						alert("마감가능한 시기가 아닙니다.");
					}
        },
        error: function(msg){
        	alert(msg);
        }

    });	  
}

</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
	<!-- 학교정보조회 -->
	<div class="titlebg">
	  <table width="670" border="0" cellpadding="0" cellspacing="0">
	    <tr>
	      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/sub_basics_title_01.png"  alt="학교정보타이틀" /></td>
	      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;기초정보&nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp;학교정보 </td>
	    </tr>
	  </table>
	</div>
	
	<div class="round_box_top mg_t30 float_left"></div>
	<div class="round_box_center float_left">
	  <table border="0" cellpadding="0" cellspacing="0" class="tstyle_row1">
	  <tr>
	    <th width="200">학교코드</th>
	    <td>${univ.univ_cd }</td>
	  </tr>
	  <tr>
	    <th>학교명</th>
	    <td>${univ.univ_name }</td>
	  </tr>
	  <tr>
	    <th>학기명</th>
	    <td>${univ.term_name }</td>
	  </tr>
	  <tr>
	    <th>개강일</th>
	    <td>${univ.term_start_date }</td>
	  </tr>
	  <tr>
	    <th>종강일</th>
	    <td>${univ.term_end_date }</td>
	  </tr>
	  <tr>
	    <th>출결정보상태</th>
	    <td>${univ.attend_proc_name }</td>
	  </tr>
	  <tr>
	    <th>학교상태</th>
	    <td>${univ.univ_sts_name }</td>
	  </tr>
	</table>
	</div>
	<div class="round_box_bottom float_left"></div>	
	
	<p align="center" style="margin-top:20px;">
<c:if test="${univ.univ_sts_cd=='G004C001' }">
		<button onclick="endTerm('end')">
			<img src="${pageContext.request.contextPath }/resources/images/common/endterm_button.png" width="72" height="27" alt="학기마감" />
		</button>
</c:if>		
<c:if test="${univ.univ_sts_cd=='G004C002' }">
		<button onclick="endTerm('start')">
			<img src="${pageContext.request.contextPath }/resources/images/common/endterm_button.png" width="72" height="27" alt="학기마감" />
		</button>
</c:if>		
	</p>	
	<!-- //학교정보조회 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

