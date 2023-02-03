<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prof_style.css">
<script>
$(document).ready(function(){
	$(".menu12 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_attend_on.gif");
	$(".menu12 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_attend_on.gif");
	showElementTop(2);
	showElement(2);
	
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
		
		$("#dialog_confirm .confirm_classday").html($("#add_classday").val());
		$("#dialog_confirm .confirm_classhour").html(classhour_start_time);
		$("#dialog_confirm .confirm_class").html($("#lst_class :selected").text());
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
      width:310,
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

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 교수 보강등록 -->
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom">
      <img src="${pageContext.request.contextPath}/resources/images/prof/professor_classadd_title.png"  alt="강의출결  타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;출결관리 &nbsp; <img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;보강등록</td>
    </tr>
  </table>
</div>
<table width="699" border="0" cellpadding="0" cellspacing="0" class="listcheckbg">
  <tr>
    <td align="center" valign="middle"><table width="639" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="93" height="33" align="left">강의 선택 :</td>
        <td width="253" height="33" align="left">
	        <select name="class_cd" id="lst_class" class="searchlistbox" style="max-width: 200px">
		        <c:forEach var="lecture" items="${lectureList}" >
	       				<option value="${lecture.class_cd }" >(${lecture.classday_name}) ${lecture.classhour_start_time} ${lecture.subject_div_cd}분반| ${lecture.class_name }</option>
		        </c:forEach>
	        </select>
        </td>
        <td width="101" height="33">강의시작시간 :</td>
        <td width="201" height="33" colspan="2" align="left">
        <select id="classhour_list" name="add_classhour" class="searchlistbox">
		<c:forEach var="list" items="${classhourList }">
			<option value="${list.classhour_start_time }|${list.classhour_end_time}|${list.classhour_name}|${list.classhour}">${list.classhour_start_time }</option>
		</c:forEach>	
		</select>
		</td>
        </tr>
      <tr>
        <td height="33" align="left">강의일 선택 :</td>
        <td height="33" colspan="4" align="left">
        	<input type="text" id="add_classday" name="add_classday" class="searchtextbox" style="max-width:170px" readonly="readonly">
        </td>
        </tr>
    </table></td>
  </tr>
</table>
<div class="alignright"><button id="btn_add_lecture"><img src="${pageContext.request.contextPath}/resources/images/prof/class_button_05.png" width="78" height="27" alt="보강등록버튼" /></button>
</div>
<div id="dialog_confirm" title="보강등록">
  <table width="290" style="margin-top:5px;" border="0" align="center" cellpadding="0" cellspacing="0" class="graybackbold">
    <tr>
      <td width="80" align="left">강의일</td>
      <td width="210" class="confirm_classday">2014-03-27</td>
    </tr>
    <tr>
      <td align="left">강의명</td>
      <td class="confirm_class"></td>
    </tr>
    <tr>
      <td align="left">시작시간</td>
      <td class="confirm_classhour">08:00 ~ 08:50</td>
    </tr>
  </table>
  <div class="bluefont" style="padding-left:10px; padding-top:9px;">보강을 등록하시겠습니까?</div>
</div>
<!-- //교수 보강등록 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

