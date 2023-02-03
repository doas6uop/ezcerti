<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
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
	        changeYear: true,
	        showButtonPanel: false,
	        yearRange: 'c-0:c+1'
	    };
	    $.datepicker.setDefaults($.datepicker.regional['ko']);
	 
	    $('#reserve_date').datepicker();
	    
	    
});

$(document).ready(function(){
	var reserve_date = $('#reserve_date').val();
	
	if(reserve_date != null && reserve_date != "") {
		getClasshour();
	}
	
	$('#reserve_date').change(function () {
		getClasshour();
	});
	
	$('#classroom_no').change(function () {
		getClasshour();
	});	
});

function getClasshour() {
	var reserve_date = $('#reserve_date').val();
	var classroom = $('#classroom_no').val();
	
	var postString = {year:"${year}", term_cd:"${term_cd}", reserve_date:reserve_date, classroom_no:classroom};
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/muniv/info/classroom_hour",
        data: postString,  
        dataType : "html",
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        success: function(msg) {
        	$("#reserve_time").html(msg);
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
</script>

<br/>

<div id="ajax_indicator1" style="display:none">
   <p style="text-align:center; padding:16px 0 0 0; left:50%; top:50%; position:absolute;">
   	<img src="${pageContext.request.contextPath }/resources/images/ajax-loader.gif" />
   </p>
</div>	
<div id="skip_lecture1">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" id="add_lecture" style="display:block;">
    <tr>
      <td height="30" style="padding-right:7px">예약일</td>
      <td align="left">
      	<input type="text" id="reserve_date" name="reserve_date" class="searchtextbox" style="width:100px;" readonly="readonly" value="${reserve_date}">
      </td>
    </tr>
    <tr>
      <td height="30" style="padding-right:7px">강의실</td>
      <td align="left">
      <select id="classroom_no" name="classroom_no" class="searchlistbox">
		<c:forEach var="list" items="${classroomList}">
			<option value="${list.classroom_no}" <c:if test="${classroom_no eq list.classroom_no}">selected</c:if>>${list.classroom_name}</option>
		</c:forEach>	
	  </select>
      </td>
    </tr>    
    <tr>
      <td height="30" style="padding-right:7px">예약시간</td>
      <td align="left">
      <select id="reserve_time" name="reserve_time" class="searchlistbox">
	  </select>
      </td>
    </tr>
    <tr>
      <td height="30" style="padding-right:7px">사유</td>
      <td align="left">
      	<input type="text" id="reason" name="reason" class="searchtextbox" style="width:150px;">
      </td>
    </tr>
  </table>
  
  <input type="hidden" name="year" id="year" value="${year}">
  <input type="hidden" name="term_cd" id="term_cd" value="${term_cd}">
</div>