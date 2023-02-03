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
<!-- 휴강처리 popup -->
<script>
var disabledDays = [${attendDay}];

function disableAllTheseDays(date) {
	var m = date.getMonth(), d = date.getDate(), y = date.getFullYear();
	var day = "";
	
	if((m+1) < 10) {
		day = y + '-0' +(m+1);
	} else {
		day = y + '-' +(m+1);
	}

	if(d < 10) {
		day = day + '-0' + d;
	} else {
		day = day + '-' + d;
	}

	for (i = 0; i < disabledDays.length; i++) {
		if(day == disabledDays[i]) {
			return [false];
		}
	}
	return [true];
}

//var minDate = ${startDay};
//var maxDate = ${remainDay}-1; // 학교측 요청 06/24까지로 날짜 제한

var minDate = "${sessionScope.UNIV_INFO.term_start_date}";
var maxDate = "${sessionScope.UNIV_INFO.term_end_date}";

$(function() {
	
	// 종강일 관련 제한 (종갈일 - 1)
	// 현재 등록된 학기종료 일자 2016-12-17
	// 종강일 2016-12-16
	// 제한 2016-12-15
	maxDate = new Date(maxDate);
	maxDate.getMonth() + 1;
	maxDate.setDate(maxDate.getDate()-2);
	
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
	        changeYear: true,
	        showButtonPanel: false,
	        yearRange: 'c-0:c+1',
	        //beforeShowDay: disableAllTheseDays 
	    };
	    $.datepicker.setDefaults($.datepicker.regional['ko']);
	 
	    $('#alter_classday').datepicker();
	    
	    
});

$(document).ready(function(){

	$('#ajax_indicator1').fadeOut();
	
	$('#alter_classday').change(function () {
		getClasshour2();
	});
	
	$('#classhour_list').on('change', function(){
		getClasshour3();
	});
	
	/* $('#alter_classday').change(function () {
		getClasshour();
	});
	
	$('#alter_classroom').change(function () {
		getClasshour();
	});	 */
	
	/*
	
		팀티칭 휴보강처리 관련 20160729
		팀티칭 관련 휴보강 처리를 위해서는
		getclasshour2,3 메소드 실행시 선택된 classhour_start_time 이외에
		휴강처리할 강의의 classhour_start_time 이 존재해야함
		
		교수가 보강지정대상일에 수업이 있는지 없는지 판단하기 위해서는
		일반적으로는 class_cd, prof_no, classday 등만 있으면 되지만
		
		팀티칭의 경우 class_cd, prof_no를 사용 할수 없고 
		subject_cd, subject_div_cd 등을 사용 해야 하는데
		classhour_start_time 까지 있어야 정확한 데이터를 얻을수 있기 때문에
		해당 값이 필요
	
	*/
});

function getClasshour() {
	var classday = $('#alter_classday').val();
	var classroom = $('#alter_classroom').val();
	var postString = {year : "${attendMaster.year}", term_cd : "${attendMaster.term_cd}", subject_cd : "${attendMaster.subject_cd}", subject_div_cd : "${attendMaster.subject_div_cd}", classroom_no : classroom, classday : classday};
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/prof/class/class_off_hour",
        data: postString,  
        dataType : "html",
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        success: function(msg) {
        	$("#classhour_list").html(msg);
        },
	    beforeSend: function() {
         	$('#ajax_indicator1').show().fadeIn('fast');
    	}, 
        complete: function() {
            $('#ajax_indicator1').fadeOut();
        },      
        error: function(msg){
        	alert(msg);
        }
    });	        	
}

function getClasshour2() {
	var classday = $('#alter_classday').val();
	var classroom = $('#alter_classroom').val();
	var classhour_start_time = $('#classhour_list').val();
	var campus_time = $('#campus_time').val();
	
	var postString = {year : "${attendMaster.year}", term_cd : "${attendMaster.term_cd}", subject_cd : "${attendMaster.subject_cd}", subject_div_cd : "${attendMaster.subject_div_cd}", classday : classday, classroom_no : "${attendMaster.classroom_no }", classhour_start_time : classhour_start_time, campus_time : campus_time};
	
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/prof/class/class_off_hour2",
        data: postString,  
        dataType : "html",
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        success: function(msg) {
        	$("#classhour_list").html(msg);
        	getClasshour3();
        },
	    beforeSend: function() {
         	$('#ajax_indicator1').show().fadeIn('fast');
    	}, 
        complete: function() {
            $('#ajax_indicator1').fadeOut();
        },      
        error: function(msg){
        	alert(msg);
        }
    });	        	
}

function getClasshour3() {
	var classday = $('#alter_classday').val();
	var classroom = $('#alter_classroom').val();
	var classhour_start_time = $('#classhour_list').val();
	var campus_time = $('#campus_time').val();
	
	if(classhour_start_time != "" && classhour_start_time != null) {
		var tempText = classhour_start_time.split('|');
		classhour_start_time = tempText[0];
	}
	
	var postString = {year : "${attendMaster.year}", term_cd : "${attendMaster.term_cd}", subject_cd : "${attendMaster.subject_cd}", subject_div_cd : "${attendMaster.subject_div_cd}", classday : classday, classroom_no : "${attendMaster.classroom_no }", classhour_start_time : classhour_start_time, campus_time : campus_time};
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/prof/class/class_off_hour3",
        data: postString,  
        dataType : "html",
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        success: function(msg) {
        	$("#alter_classroom").html(msg);
        },
	    beforeSend: function() {
         	$('#ajax_indicator1').show().fadeIn('fast');
    	}, 
        complete: function() {
            $('#ajax_indicator1').fadeOut();
        },      
        error: function(msg){
        	alert(msg);
        }
    });	        	
}

function doCheckTime() {
	var classroom = $('#alter_classroom').val();
	var classhour = $('#classhour_list').val();

	if(classroom != null && classroom != '' && classhour != null && classhour != '') {
		if((classroom == "11321" || classroom == "11322") && classhour.indexOf("18:20") >= 0) {
			alert("교학처로 문의 후, 신청하시기 바랍니다. (강의실 키 관련)");
		}
	}
}

</script>
<div id="ajax_indicator1" style="/* display: none; */">
   <p style="text-align:center; padding:16px 0 0 0; left:50%; top:50%; position:absolute;">
   	<img src="${pageContext.request.contextPath }/resources/images/ajax-loader.gif" />
   </p>
</div>	
<div id="skip_lecture1">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="30" colspan="2" class="bluefont">${attendMaster.class_name }</td>
    </tr>
    <tr>
      <td height="30" colspan="2">${attendMaster.classday } (${attendMaster.classday_name }) ${attendMaster.classhour_start_time }</td>
    </tr>
    <tr class="grayback">
      <td width="50%" height="40">
		<label><input type="radio" name="rdo_alter" value="ok" onclick="$('#add_lecture').css('display','block');" checked>대체수업(보강) 지정</label>
	  </td>
    </tr>
  </table>
  <!-- 2015.02.02 (대체수업일을 항상 지정하기위해 style을 none에서 block로 변경) -->
  <table width="100%" border="0" cellspacing="0" cellpadding="0" id="add_lecture" style="display:block;">
    <tr>
      <td height="30" style="padding-right:7px">보강일</td>
      <td align="left">
      	<input type="text" id="alter_classday" name="alter_classday" class="searchtextbox" style="width:150px;" placeholder="보강날짜를 지정하세요!!" readonly="readonly">
      </td>
    </tr>
	<tr>
      <td height="30" style="padding-right:7px">시작시간</td>
      <td align="left">
      <select id="classhour_list" name="alter_classhour" class="searchlistbox" onChange="javascript:doCheckTime()">
	  </select>
      </td>
    </tr>
    <tr>
      <td height="30" style="padding-right:7px">강의실</td>
      <td align="left">
      <select id="alter_classroom" name="alter_classroom" class="searchlistbox" onChange="javascript:doCheckTime()">
		<%-- <c:forEach var="list" items="${classroomList}">
			<option value="${list.classroom_no}" <c:if test="${attendMaster.classroom_no eq list.classroom_no}">selected</c:if>>${list.classroom_name}</option>
		</c:forEach> --%>
	  </select>
      </td>
    </tr>    
    <tr>
      <td height="30" style="padding-right:7px">휴강사유</td>
      <td align="left">
      	<input type="text" id="alter_classoff_reason" name="alter_classoff_reason" class="searchtextbox" style="width:150px;">
      </td>
    </tr>
    <c:if test="${isUninterruptLecture == 'true' }">
    <tr>
    	<td colspan="2"><font color="red">* 연속된 강의가 존재합니다. 각각 휴강처리해야 합니다.</font></td>
    </tr>
    </c:if>
  </table>
<input type="hidden" name="class_cd" value="${attendMaster.class_cd}">
<input type="hidden" name="classday" value="${attendMaster.classday }">
<input type="hidden" name="classhour_start_time" value="${attendMaster.classhour_start_time }">
<input type="hidden" id="campus_time" name="campus_time" value="${campus_time}">
</div>
<!-- //휴강처리 popup -->
</c:otherwise>
</c:choose>