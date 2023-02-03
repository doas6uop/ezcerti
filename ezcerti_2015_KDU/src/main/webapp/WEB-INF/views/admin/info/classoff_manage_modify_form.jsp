<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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

<%
	/*
	 * 현재 날짜에서 하루를 더한 값을 리턴한다.
	 * 일자 선택시 오늘과 이전일을 제외한 날짜만 휴강선택을 할수 있다.
	 * 
	*/ 
	Calendar oCalendar = Calendar.getInstance();
	oCalendar.add(Calendar.DATE, 1);

	// 현재 날짜/시간 등의 각종 정보 얻기
	String currentDate = "";
	currentDate = String.valueOf(oCalendar.get(Calendar.YEAR)) + "-";
	currentDate += (oCalendar.get(Calendar.MONTH) + 1) > 9 ? "" + String.valueOf(oCalendar.get(Calendar.MONTH) + 1) : '0' + String.valueOf(oCalendar.get(Calendar.MONTH) + 1);
	currentDate += "-" + ((oCalendar.get(Calendar.DAY_OF_MONTH)) > 9 ? "" + String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH)) : '0' + String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH)));
%>

<script>
$(document).ready(function(){
	$(".menu12 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_attend_on.gif");
	$(".menu12 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_attend_on.gif");
	$("#in_topmenu5").css("display","block");
	$("#in_menu5").css("display","block");
});

/* maxDate, minDate 제한 function */
function convertDate(oriDate , num) {
	
	var tmp = oriDate.split("-");
	var theBigDay = new Date(tmp[0], tmp[1], tmp[2]); // 1962-07-07
	
	if(num < 0) {
		theBigDay.setDate(theBigDay.getDate() - 1);
	} else {
		theBigDay.setDate(theBigDay.getDate() + 1);
	}
	
	var m = theBigDay.getMonth(), d = theBigDay.getDate(), y = theBigDay.getFullYear();
	var day = "";
	
	if(m < 10) {
		day = y + '-0' + m;
	} else {
		day = y + '-' + m;
	}

	if(d < 10) {
		day = day + '-0' + d;
	} else {
		day = day + '-' + d;
	}
	
	return day;
}

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
	        changeYear: false,
	        showButtonPanel: false,
	        yearRange: 'c-1:c+1'
	    };
	    $.datepicker.setDefaults($.datepicker.regional['ko']);
	 
	    $('#sdate').datepicker();
	    $('#sdate').datepicker("option", "minDate", <%="'" + currentDate + "'"%>);
	    $('#sdate').datepicker("option", "onClose", function ( selectedDate ) {
	    	selectedDate = convertDate(selectedDate , 1);
	        $("#edate").datepicker( "option", "minDate", selectedDate );
	    });
	 
	    $('#edate').datepicker();
	    $('#edate').datepicker("option", "onClose", function ( selectedDate ) {
	    	selectedDate = convertDate(selectedDate , -1);
	        $("#sdate").datepicker( "option", "maxDate", selectedDate );
	    });
	});

 function sendAjax() {
	 
	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	var email_regx=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    var postString = $("#boardFrm").serialize();
    var idReg = /^[0-9]{5,19}$/g;
    var regEmpPwd = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).*$/;

    var frm = new FormData(document.getElementById('boardFrm'));
    
    if(!$("#sdate").val()){
    	alert("휴강처리일자를 지정해주세요.");
    	$("#sdate").focus();
    	return false;
    }
    
    if(!$("#edate").val()){
    	alert("보강처리일자를 지정해주세요.");
    	$("#edate").focus();
    	return false;
    }
    
    if($("#sdate").val() == $("#edate").val()){
    	alert("휴강처리일자와 보강처리일자가 동일합니다.");
    	$("#edate").focus();
    	return false;
    }
    
    $.ajax({
        url: "${pageContext.request.contextPath}/muniv/info/classoff_manage_modify_ok",
        data: frm,
        dataType : 'text',
        processData : false,
        contentType : false,
        type : "POST",

        success: function(msg) {
        	
        	if(msg.trim() == 'success') {
        		alert("정상 처리되었습니다.");
            	document.location.replace('${pageContext.request.contextPath}/muniv/info/classoff_manage_list');	
        	} else if (msg.trim() == 'dup') {
        		alert("휴강 처리기간이 중복 됩니다.");
        		$("#sdate").focus();
        	} else {
        		alert("권한이 없습니다.");
        	} 
        	
        },
        error: function(msg){
        	alert(msg);
        }
	
    });		
 };
 
function doList(){
	location.href = '${pageContext.request.contextPath}/muniv/info/classoff_manage_list';
}

</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">

<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
	  <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/sub_admin_title_05.gif"  alt="일괄휴강관리" /></td>
	  <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;관리자 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp;일괄휴강관리</td>
    </tr>
  </table>
</div>

<div id="board">

	<form id="boardFrm" enctype="multipart/form-data" onsubmit="javascript:sendAjax(); return false;">
	
		<div id="board_write">
			
			<fmt:parseDate var="parsedDate1" value="${classoffmanage.classday }" pattern="yy/mm/dd"/>
			<fmt:formatDate var="fmt_classday" value="${parsedDate1}" type="both" pattern="yyyy-mm-dd"/>
			<fmt:parseDate var="parsedDate2" value="${classoffmanage.before_classday }" pattern="yy/mm/dd"/>
			<fmt:formatDate var="fmt_before_classday" value="${parsedDate2}" type="both" pattern="yyyy-mm-dd"/>
			
			<table border="0" cellpadding="0" cellspacing="0" summary="글쓰기">
				<caption>일괄휴강관리 수정</caption>
				<tr>
					<th>휴강처리일자 </th>
					<td>
						${fmt_classday }&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="sdate" name="classday" class="searchtextbox" value="" style="width:90px;" readonly="readonly">
					</td>
					<th>보강처리일자</th>
					<td>
						${fmt_before_classday }&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="edate" name="before_classday" value="" class="searchtextbox" style="width:90px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>사유</th>
					<td colspan="3">
						<textarea id="classoffmanage_sayu" name="classoffmanage_sayu" rows="5" cols="10" style="border: 1px solid #7f9db9;" >${classoffmanage.classoffmanage_sayu }</textarea>
					</td>
				</tr>
			</table>
		</div>
		
		<div class="btn_area">
			<a href="javascript:doList()"><img src="${pageContext.request.contextPath}/resources/images/board/list_btn.gif" alt="목록" /></a>			
			<a href="#" onclick="javascript:sendAjax()"><img src="${pageContext.request.contextPath}/resources/images/board/insert_btn.gif" alt="수정" /></a>
			<%-- 		
			<button type="button" class="btn-default" onclick="doList()">목록</button>
			<button type="button" class="btn-default" onclick="sendAjax()">수정</button>
			--%>
		</div>
		
		<input type="hidden" name="classoffmanage_no" value="${classoffmanage.classoffmanage_no }">
		
	</form>
</div>


</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>
