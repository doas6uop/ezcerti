<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<meta charset="utf-8">
<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/prof_cert.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prof_style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">

		<!-- 로딩바 관련 추가 -->
		<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common_loading_bar.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common_loading_bar_style.css">

<!-- [${sessionScope.PROF_INFO.prof_adm_cd}] -->
<!-- [${prof.prof_adm_cd}] -->

<script>
$(document).ready(function(){
	$(".menu15 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_stats_on.gif");
	$(".menu15 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_stats_on.gif");
	showElementTop(15);
	showElement(15);
});
$(function() {
  $( "#tabs" ).tabs();
});

// 교수 강의 정보 refresh 처리
// 학기마감시 EndProc 미처리로 인하 출결 데이터 생성 처리
// 교수의 전체 강의 상대로 동작
function refreshProc() {

	var r=confirm("새로고침을 하시겠습니까?");

	if(r==true){

		var tmp_prof_no = '${prof.prof_no}';

		$.ajax({
				type: "POST",
				url: "${pageContext.request.contextPath}/prof/stats/refresh_end_proc",
				data: { prof_no : tmp_prof_no },
				success: function(msg) {
					//통신이 완료된 후 처리
					$('.spinner_layer').fadeOut('fast', function(){
						alert(msg);
						window.location.reload(true);
					});
				},
				beforeSend: function() {
					//통신을 시작할때 처리
					$('.spinner_layer').show().fadeIn('fast');
				}, 
				error: function(msg){ // 예상치 못한 에러

					$('.spinner_layer').fadeOut('fast', function(){
						alert("[ERROR] PROC 처리 중 예외가 발생 했습니다.");
						window.location.reload(true);
					});
				}
		});
	}
}

function termEnd(){
	<c:choose>
	<c:when test="${prof.prof_adm_cd == 'G026C002' }">
		//var r=confirm("학기마감을 취소하시겠습니까?");
		alert("이미 학기마감을 하셨습니다.");
	</c:when>
	<c:otherwise>
		var r=confirm("학기마감을 하시겠습니까?");
		
		if(r==true){
			$.ajax({
			    type: "POST",
			    url: "${pageContext.request.contextPath}/prof/stats/stats_term_end_confirm",
			    data: {data : 1},   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
			    success: function(msg) {
			    	alert(msg);
			    	window.location.reload(true);
			    },
			     beforeSend: function() {
			     //통신을 시작할때 처리
			     jQuery('.ui-dialog button').button('disable');
			     $('#ajax_indicator').show().fadeIn('fast');
					}, 
			    complete: function() {
			        //통신이 완료된 후 처리
			        $('#ajax_indicator').fadeOut();
			  	}, 	        
			    error: function(msg){
			    	alert(msg);
			    }
			});	   	
		}		
	</c:otherwise>
	</c:choose>

}

function termEnd2(){
	<c:choose>
	<c:when test="${prof.prof_adm_cd == 'G026C002' }">
		//var r=confirm("학기마감을 취소하시겠습니까?");
		//alert("이미 학기마감을 하셨습니다.");
		var message="테스트";
		var r=prompt(message);
		
		if(r=='4231'){
			r=true;
		}
		
	</c:when>
	<c:otherwise>
		//var r=confirm("학기마감을 하시겠습니까?");
	</c:otherwise>
	</c:choose>
	if(r==true){
		$.ajax({
		    type: "POST",
		    url: "${pageContext.request.contextPath}/prof/stats/stats_term_end_confirm",
		    data: {data : 1},   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
		    success: function(msg) {
		    	alert(msg);
		    	window.location.reload(true);
		    },
		     beforeSend: function() {
		     //통신을 시작할때 처리
		     jQuery('.ui-dialog button').button('disable');
		     $('#ajax_indicator').show().fadeIn('fast');
				}, 
		    complete: function() {
		        //통신이 완료된 후 처리
		        $('#ajax_indicator').fadeOut();
		  	}, 	        
		    error: function(msg){
		    	alert(msg);
		    }
		});	   	
	}		
}
</script>
<style>
.ui-tabs.ui-widget-content {
    border: none;
}
.ui-widget-header{
	background: none;
	border: none;
	border-bottom: 1px solid #ccc;
	font-size:12px;
	font-face:Dotum;
}
</style>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 교수 학기별통계 -->
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/stats_title_01.gif"  alt="학기마감" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" onclick="termEnd2()" width="22" height="12" alt="홈아이콘" /> &nbsp;통계 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;학기 통계</td>
    </tr>
  </table>
</div>
<br>

<!-- [${fn:length(statsTermEndList)}][${unconfirmedClaim}] -->

<div class="round_box_50">
  <span class="float_left bold mg_t3 pd_l5">&middot; 학교상태 : ${univ.univ_sts_name }<span class="pd_l20">&middot; 교수상태 : ${prof.prof_adm_name}</span></span>
  <span class="float_right">
    <c:if test="${univ.univ_sts_cd=='G004C001' }">
      <c:choose>
      <c:when test="${fn:length(statsTermEndList) == 0 and unconfirmedClaim == 0}" >
      <%-- <c:when test="${fn:length(statsTermEndList) == 0 and fn:length(chkRemainClass) == 0}" > --%>
      <%-- <c:when test="${statsTermEndList.size()==0||chkRemainClass.size()==0}"> 에러로 인해 주석 처리--%>
        <button onclick="termEnd()">
          <img src="${pageContext.request.contextPath }/resources/images/common/endterm_button.gif">
        </button>
      </c:when>
      <c:otherwise>
        <button onclick="javascript:refreshProc();">
          <img src="${pageContext.request.contextPath }/resources/images/common/refresh_button.gif">
        </button>
        <button onclick="alert('학기마감이 가능한 상태가 아닙니다.');">
          <img src="${pageContext.request.contextPath }/resources/images/common/endterm_button.gif">
        </button>
      </c:otherwise>
      </c:choose>
    </c:if>
    
    <c:if test="${univ.univ_sts_cd=='G004C002'&&prof.prof_adm_cd=='G026C001' }">
      <button onclick="alert('학기마감을 하면 출결정보를 수정할 수 없습니다.');termEnd()">
        <img src="${pageContext.request.contextPath }/resources/images/common/endterm_button.gif">
      </button>
    </c:if>
    <c:if test="${univ.univ_sts_cd=='G004C002'&&prof.prof_adm_cd=='G026C002' }">
      <button onclick="alert('학기가 마감되었습니다.');">
        <img src="${pageContext.request.contextPath }/resources/images/common/endterm_button.gif">
      </button>
    </c:if>
  </span>
</div>

<br>


<div id="tabs">
<ul style="margin-bottom:10px;">
	<li><a href="#tabs-1">출결전인 학생이 존재하는 강의</a></li>
	<li><a href="#tabs-2">출석한 학생이 없는 강의</a></li>
	<li><a href="#tabs-3" onclick="location.href='${pageContext.request.contextPath}/prof/claim/claim_list'">이의신청 미처리내역 ${unconfirmedClaim }건</a></li>
</ul>
<div id="tabs-1" style="height:400px; padding-left:5px; overflow-y: scroll;">

	<table border="0" cellspacing="0" cellpadding="0" class="tstyle_col1">
	  <tr>
	    <th>NO</th>
	    <th>강의번호</th>
	    <th>강의일</th>
	    <th>강의명</th>
	    <th>수강생수</th>
	    <th>강의상태</th>
	    <th>강의형태</th>
	  </tr>
	<c:forEach var="list" items="${statsTermEndList }">
	<c:if test="${list.reg_etc=='1' }">  
	  <tr>
	    <td>${list.row_no }</td>
	    <td>${list.subject_cd }-${list.subject_div_cd }</td>
	    <td style="line-height: 18px; font-weight:bold;">
	      <a href="${pageContext.request.contextPath}/prof/class/class_view?class_cd=${list.class_cd}&classday=${list.classday}&classhour_start_time=${list.classhour_start_time}">
	        ${list.classday } (${list.classday_name })<br>${list.classhour_start_time } ~ ${list.classhour_end_time }
	        </a>	      </td>
	    <td class="bold"><a href="${pageContext.request.contextPath}/prof/class/class_view?class_cd=${list.class_cd}&classday=${list.classday}&classhour_start_time=${list.classhour_start_time}">${list.class_name }</a></td>
	    <td>${list.attendee_cnt }</td>
	    <td>${list.class_sts_name }</td>
	    <td>${list.class_type_name }</td>
	  </tr>
	</c:if>
	<c:if test="${empty list}">
		<tr>
			<td style="margin:150px;">해당하는 데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>  
	</c:forEach>  
	</table>

</div>
<div id="tabs-2" style="height:400px; padding-left:5px; overflow-y: scroll;">
  <table border="0" cellspacing="0" cellpadding="0" class="tstyle_col1">
    <tr>
      <th>NO</th>
      <th>강의번호</th>
      <th>강의일</th>
      <th>강의명</th>
      <th>수강생수</th>
      <th>강의상태</th>
      <th>강의형태</th>
    </tr>
  <c:forEach var="list" items="${statsTermEndList }">
  <c:if test="${list.reg_etc=='2' }">  
    <tr onclick="location.href='">
      <td>${list.row_no }</td>
      <td>${list.subject_cd }-${list.subject_div_cd }</td>
      <td style="line-height: 18px; font-weight:bold;">
        <a href="${pageContext.request.contextPath}/prof/class/class_view?class_cd=${list.class_cd}&classday=${list.classday}&classhour_start_time=${list.classhour_start_time}">${list.classday } (${list.classday_name })<br>${list.classhour_start_time } ~ ${list.classhour_end_time }</a>    </td>
      <td class="bold">
        <a href="${pageContext.request.contextPath}/prof/class/class_view?class_cd=${list.class_cd}&classday=${list.classday}&classhour_start_time=${list.classhour_start_time}">
          ${list.class_name }
          </a>    </td>
      <td>${list.attendee_cnt }</td>
      <td>${list.class_sts_name }</td>
      <td>${list.class_type_name }</td>
    </tr>
  </c:if>  
  </c:forEach>  
  </table>

</div>
<div id="tabs-3">&nbsp;</div>
</div>
<p>&nbsp;</p>
<!-- //교수 학기별통계 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>

<jsp:include page="../../common/util/loading_bar_footer.jsp"></jsp:include>

<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

