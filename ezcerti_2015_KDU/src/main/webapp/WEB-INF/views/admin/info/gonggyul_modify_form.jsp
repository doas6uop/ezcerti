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

<script>
$(document).ready(function(){
	$(".menu12 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_attend_on.gif");
	$(".menu12 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_attend_on.gif");
	$("#in_topmenu5").css("display","block");
	$("#in_menu5").css("display","block");
	
	gonggyulClassNameList();
});

$(document).on('click', ".checkbox_align", function() {
	
	// 체크박스 전체선택 및 해제 
	if($(this).attr('id') == 'chk_all' && $("#chk_all").is(":checked") == true) {
		$("input[name=chk_classname]").prop("checked", true);
	} else if ($(this).attr('id') == 'chk_all' && $("#chk_all").is(":checked") == false) {
		$("input[name=chk_classname]").prop("checked", false);
	} else {
		if ($("#chk_all").is(":checked") == true){
			$("#chk_all").prop("checked", false);
		}
	}
	
});

$(document).on('change', ".searchtextbox", function() {
	
	var startDate = $('#sdate').val();
	var endDate = $('#edate').val();
	
	if(startDate != "" && endDate != "" && $(this).attr('id') != 'submit_date') {
		gonggyulClassNameList();
	}
	
});

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
	    $('#sdate').datepicker("option", "maxDate", $("#edate").val());
	    $('#sdate').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#edate").datepicker( "option", "minDate", selectedDate );
	    });
	 
	    $('#edate').datepicker();
	    $('#edate').datepicker("option", "minDate", $("#sdate").val());
	    $('#edate').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#sdate").datepicker( "option", "maxDate", selectedDate );
	    });
	    
	    $('#submit_date').datepicker();
	});

function gonggyulClassNameList(){
	 
	 // 초기화
	 $('#class_name_box').html("");
	 
	 var student_no = $("#student_no").val();
	 var term_cd = $("#term_cd option:selected").val();
	 var startDate = $('#sdate').val();
	 var endDate = $('#edate').val();
	 var gonggyul_no = $('#gonggyul_no').val();
	 
	 $.ajax({
		 	type : "POST",
	        url: "${pageContext.request.contextPath}/muniv/info/gonggyul_classname_list",
	        data: {
	        		student_no : student_no, 
	        		term_cd : term_cd,
	        		startDate : startDate,
	        		endDate : endDate,
	        		gonggyul_no : gonggyul_no
	        	   },
	        dataType : 'json',
	        success: function(data) {
				
	        	var tmpText = "";
	        	
	        	if(data.list == ""){
	        		tmpText += "<p> 수강중인 강의가 존재하지 않습니다. </p>";
	        	} else {
	        		tmpText += "<p><input type='checkbox' class='checkbox_align' id='chk_all'> 전체 </p>";	
	        	}
				 
	        	var tmpChk = "";
	        	$.each(data.list, function(key, value){
	        		
	        		tmpChk = "";
	        		
	        		if(value.chk_visible == "Y") {
	        			tmpChk = "checked='checked'";
	        		}
	        		
	        		tmpText += "<p><input type='checkbox' class='checkbox_align' " + tmpChk + " name='chk_classname' value=" + value.class_cd + "_" + value.classhour_start_time + "> " + value.class_name 
	        				+ " (" + value.classday_name + ") " + value.classhour_start_time + " </p>";
	        	});
	        	
	        	tmpText += "<p style='color:red;'> ※ 선택된 기간에 존재하는 강의의 목록을 표시합니다.</p>";
	        	$('#class_name_box').append(tmpText);
	        },
	        error: function(msg){
	        	alert(msg);
	        }
	});		
	 
}

 function sendAjax() {
	 
	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	var email_regx=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    var postString = $("#boardFrm").serialize();
    var idReg = /^[0-9]{5,19}$/g;
    var regEmpPwd = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).*$/;

    var frm = new FormData(document.getElementById('boardFrm'));
    
    if(!$("#student_no").val()){
    	alert("공결처리대상을 지정해주세요.");
    	return false;
    }
    
    if(!$("#sdate").val()){
    	alert("공결시작일자를 지정해주세요.");
    	$("#sdate").focus();
    	return false;
    }
    
    if(!$("#edate").val()){
    	alert("공결완료일자를 지정해주세요.");
    	$("#edate").focus();
    	return false;
    }
    
    if($("input[name=chk_classname]:checkbox:checked").length == 0){
    	alert("공결처리과목을 지정해주세요.");
    	return false;
    }
    
    if(!$("#submit_date").val()){
    	alert("제출일자를 지정해주세요.");
    	$("#submit_date").focus();
    	return false;
    }
    
    $.ajax({
        url: "${pageContext.request.contextPath}/muniv/info/gonggyul_modify_ok",
        data: frm,
        dataType : 'text',
        processData : false,
        contentType : false,
        type : "POST",

        success: function(msg) {
        	
        	if(msg.trim() == 'success') {
        		alert("정상 처리되었습니다.");
            	document.location.replace('${pageContext.request.contextPath}/muniv/info/gonggyul_list');	
        	} else if (msg.trim() == 'dup') {
        		alert("공결기간이 중복 됩니다.");
        	} else {
        		alert("오류가 발생했습니다.");
        	} 
        	
        },
        error: function(msg){
        	alert(msg);
        }
	
    });		
 }
 
function ajaxReturn(rlst, msg) {
	
	alert(msg);
	
	if(rlst == 'SUCCESS') {
		if(msg.indexOf("파일") == -1) {
			doList();
		}
	}
}
 
function doList(){
	location.href = '${pageContext.request.contextPath}/muniv/info/gonggyul_list';
}

</script>

<style type="text/css">
	.checkbox_align {margin: -4px 0 0 0; vertical-align: middle;}
</style>

</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">

<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
	  <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/sub_admin_title_04.gif"  alt="공결관리" /></td>
	  <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;관리자 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp;공결관리</td>
    </tr>
  </table>
</div>

<div id="board">

	<form id="boardFrm" enctype="multipart/form-data" onsubmit="javascript:sendAjax(); return false;">
		
		<div id="board_write">
			
			<table border="0" cellpadding="0" cellspacing="0" summary="글쓰기">
				<caption>공결등록</caption>
				<tr>
					<th>공결대상 학생</th>
					<td>
						<div style="padding: 4px; border: 1px solid #7f9db9; border-image: none; width: 70%; height: auto; min-height : 14px; float: left;">
							<span id="to_user_name_span">${gonggyul.student_name }</span>
							<input type="hidden" name="student_name" id="student_name" size="20" value="${gonggyul.student_name }" class="float_left mg_r5" readonly />
							<input type="hidden" name="student_no" id="student_no" size="20"  value="${gonggyul.student_no }" class="float_left" readonly />
						</div>
					</td>
				</tr>
				<tr>
					<th>학기</th>
					<td>
						<c:choose>
							<c:when test="${gonggyul.term_cd eq 'G002C001'}">
								${gonggyul.year}년 1학기
							</c:when>
							<c:otherwise>
								${gonggyul.year}년 2학기
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>기간</th>
					<td>
						<input type="text" id="sdate" name="gong_ilja_start" class="searchtextbox" value="${gonggyul.gong_ilja_start }" style="width:120px;" readonly="readonly"> ~ <input type="text" id="edate" name="gong_ilja_end" value="${gonggyul.gong_ilja_end }" class="searchtextbox" style="width:120px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>과목</th>
					<td id="class_name_box"></td>
				</tr>
				<tr>
					<th>제출일자</th>
					<td>
						<input type="text" id="submit_date" name="submit_date" class="searchtextbox" value="${gonggyul.submit_date }" style="width:120px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>사유</th>
					<td>
						<textarea id="gong_sayu" name="gong_sayu" rows="5" cols="10" style="border: 1px solid #7f9db9;" >${gonggyul.gong_sayu }</textarea>
					</td>
				</tr>
			</table>
		</div>
		
		<div class="btn_area">
			<a href="javascript:doList()"><img src="${pageContext.request.contextPath}/resources/images/board/list_btn.gif" alt="목록" /></a>			
			<a href="javascript:sendAjax()"><img src="${pageContext.request.contextPath}/resources/images/board/insert_btn.gif" alt="등록" /></a>
		</div>
		
		<input type="hidden" name="gonggyul_no" id="gonggyul_no" value="${gonggyul.gonggyul_no }">
		
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
