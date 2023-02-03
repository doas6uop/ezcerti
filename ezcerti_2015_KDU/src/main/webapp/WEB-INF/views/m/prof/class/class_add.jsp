<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="format-detection" content="telephone=no" /> 

<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>

<link href="${pageContext.request.contextPath}/resources_m/css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/categorylayer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/prof_cert.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_m/css/smoothness/jquery-ui-1.10.3.custom.css">
<script>
$(document).ready(function(){
	$("#btn_add_lecture").click(function(){
		if($("#add_classday").val() < 1){
			alert("강의일을 선택해주십시오.");
			$("#add_classday").focus();
			return false;
		}
		
		var classhour = $("#classhour_list").val().split("|");
		var classhour_start_time = classhour[0];
		var classhour_end_time = classhour[1];
		var classhour_name = classhour[2];
		
		$("#dialog_confirm .confirm_classday").html("강의일 :"+$("#add_classday").val());
		$("#dialog_confirm .confirm_classhour").html("강의시간 :"+classhour_start_time);
		$("#dialog_confirm .confirm_class").html("강의명 :"+$("#lst_class :selected").text());
		<c:choose>
		<c:when test="${sessionScope.PROF_INFO.prof_adm_cd=='G026C002' }">
			alert("학기가 마감되어 변경이 불가능합니다.");
			window.location.reload(true);
		</c:when>
		<c:otherwise>	
		$("#dialog_confirm").dialog("open");
		</c:otherwise>
		</c:choose>
	});
});
$(function() {
    $( "#dialog_confirm" ).dialog({
   	  autoOpen: false,
      resizable: false,
      height:240,
      modal: true,
      buttons: {
        "등록": function() {
        	var postString = {class_cd: $("#lst_class :selected").val(), addClassday: $("#add_classday").val(), addClasshour: $("#classhour_list").val()};
    		
    	    $.ajax({
    	        type: "POST",
    	
    	        url: "${pageContext.request.contextPath}/prof/class/class_add_confirm",
    	
    	        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
    	
    	        success: function(msg) {
    	        	alert(msg);
    	        	window.location.reload(true);
    	        },
    	        error: function(msg){
    	        	alert(msg);
    	        }
    	
    	    });	        
        },
        "취소": function() {
          $( this ).dialog( "close" );
        }
      }
    });
  });
var minDate = ${startDay};
var maxDate = ${remainDay}+14;
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
	        minDate: minDate,
	        maxDate: maxDate,
	        isRTL: false,
	        showMonthAfterYear: true,
	        yearSuffix: '',
	        showOn: 'focus',
	        changeMonth: true,
	        changeYear: false,
	        showButtonPanel: false,
	        yearRange: 'c-0:c+1',
	    };
	    $.datepicker.setDefaults($.datepicker.regional['ko']);
	 
	    $('#add_classday').datepicker();
	    
	    
});

</script>
</head>

<body bgcolor="#f0f0f0">
<div>
	<jsp:include page="../../header.jsp"></jsp:include>
</div>
<!-- 교수 보강등록 -->
<div class="titlebox"> <img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="아이콘"> &nbsp;보강 등록</div>
<div class="subsearchbg" style="height:100px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="25%" height="40">강의일선택 </td>
      <td width="75%" align="left">
         <input type="text" id="add_classday" name="add_classday" style="max-width:80px" readonly="readonly">
      </td>
    </tr>
    <tr>
      <td width="25%">강의시작시간 </td>
      <td width="75%" align="left">
        <select id="classhour_list" name="add_classhour" class="searchlistbox">
		<c:forEach var="list" items="${classhourList }">
			<option value="${list.classhour_start_time }|${list.classhour_end_time}|${list.classhour_name}|${list.classhour}">${list.classhour_start_time }</option>
		</c:forEach>	
		</select>
      </td>
    </tr>
    <tr>
      <td width="25%" height="33">강의선택 </td>
      <td width="75%" align="left">
        <select name="class_cd" id="lst_class" class="searchlistbox">
	        <c:forEach var="lecture" items="${lectureList}" >
       				<option value="${lecture.class_cd }" >(${lecture.classday_name}) ${lecture.classhour_start_time} |${lecture.subject_div_cd}-${lecture.class_name }</option>
	        </c:forEach>
        </select>
      </td>
    </tr>
  </table>
</div>
<div class="photobutton">
	<button id="btn_add_lecture"><img src="${pageContext.request.contextPath}/resources_m/images/classadd_button.png"style="max-width:60px;" alt="보강등록 버튼"></button>
</div>
<div id="dialog_confirm" title="보강등록">
	<p class="confirm_classday"></p>
	<p class="confirm_classhour"></p>
	<p class="confirm_class"></p>
	<p class="confirm_msg">보강을 등록하시겠습니까?</p>
</div>
<!-- //교수 보강등록 -->
<div>
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
</body>
</html>

