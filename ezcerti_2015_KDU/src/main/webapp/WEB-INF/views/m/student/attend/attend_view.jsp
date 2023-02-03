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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_m/css/smoothness/jquery-ui-1.10.3.custom.css">

<%-- 출결수를 출결이력정보에서 처리하기 위한 변수(2015.08.31) --%>
<c:set var="val_attendee_cnt" value="0" />
<c:set var="val_attendee_present_cnt" value="0" />
<c:set var="val_attendee_late_cnt" value="0" />
<c:set var="val_attendee_absent_cnt" value="0" />
<c:set var="val_attendee_off_cnt" value="0" />
<c:set var="val_attendee_quit_cnt" value="0" />
<c:set var="val_attendee_before_cnt" value="0" />
<c:set var="val_attendee_gonggyul_cnt" value="0" />

<script>
$(document).ready(function(){
	$("#topmenu_02").removeClass('submenugrayfont').addClass('menubluefont');
});
function studentClaim(class_cd, classday, classhour_start_time){
	$("#dialog_student_claim1").load('${pageContext.request.contextPath}/student/attend/attend_claim',{class_cd:class_cd, classday:classday, classhour_start_time:classhour_start_time});
	$("#dialog_student_claim1").dialog("open");
}
$(function() {
	  $( "#dialog_student_claim1" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    width:310,
	    height:350,
	    modal: true,
	    buttons: {
	      "확인": function() {
	    	var r=confirm("이의신청 하시겠습니까?");
	        $( this ).dialog( "close" );
	    	if (r==true)
	    	  {
	    		var postString = $("#frm_claim").serialize();
	    		
	    	    $.ajax({
	    	        type: "POST",
	    	
	    	        url: "${pageContext.request.contextPath}/student/attend/attend_claim_confirm",
	    	
	    	        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
	    	
	    	        success: function(msg) {
	    	        	alert(msg);
	    	        	//window.location.reload(true);
	    	        },
	    	        error: function(msg){
	    	        	alert(msg);
	    	        }
	    	
	    	    });	        
	    	  }
	      },
	      "취소": function() {
	        $( this ).dialog( "close" );
	      }
	    }
	  });
	});
</script>
</head>

<body bgcolor="#f0f0f0">
<div>
	<jsp:include page="../../header.jsp"></jsp:include>
</div>
<!-- 강의출결상세 -->
<div class="titlebox">
<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="아이콘"> &nbsp; 강의출결 상세정보</div>
<div class="smallsearchbg">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td colspan="3" width="100%" height="20" align="center"><span style="color:blue; font-weight: bold;">${lectureDetail.class_name } (${lectureDetail.classroom_no})</span></td>
    </tr>
    <tr>
      <td width="33%" height="20" align="left">${lectureDetail.prof_dept_name}</td>
      <td width="33%">${lectureDetail.prof_name }</td>
      <td width="33%">${lectureDetail.classday_name }요일 ${lectureDetail.classhour_start_time }</td>
    </tr>
  </table>
</div>
<table width="97%" border="0" align="center" cellpadding="0" cellspacing="0" class="graytable">
  <tr>
    <td width="12%" height="30" align="center"><img src="${pageContext.request.contextPath}/resources_m/images/white_icon.png" style="max-width:17px;" alt="출석아이콘"></td>
    <td width="38%" align="left">출결전 <span id="span_attend_before_cnt">&nbsp;</span><%-- ${studentAttendCnt.BEFORE_CNT } --%>건</td>
    <td width="12%" align="center"><img src="${pageContext.request.contextPath}/resources_m/images/blue_icon.png" style="max-width:17px;" alt="출석아이콘"></td>
    <td width="38%" align="left">출석 <span id="span_attend_present_cnt">&nbsp;</span><%-- ${studentAttendCnt.PRESENT_CNT } --%>건</td>
  </tr>
  <tr>
    <td width="12%" height="30" align="center"><img src="${pageContext.request.contextPath}/resources_m/images/yellow_icon.png" style="max-width:17px;" alt="출석아이콘"></td>
    <td width="38%" align="left">지각 <span id="span_attend_late_cnt">&nbsp;</span><%-- ${studentAttendCnt.LATE_CNT } --%>건</td>
    <td width="12%" align="center"><img src="${pageContext.request.contextPath}/resources_m/images/red_icon.png" style="max-width:17px;" alt="출석아이콘"></td>
    <td width="38%" align="left">결석 <span id="span_attend_absent_cnt">&nbsp;</span><%-- ${studentAttendCnt.ABSENT_CNT } --%>건</td>
  </tr>
</table>

<div class="tablebox">
	<c:forEach var="list" items="${attendDetailHistoryList }">
		<table width="127" cellpadding="0" cellspacing="0" class="phototable">
		
			<c:choose>
		    	<%-- 공결시 --%>
		    	<c:when test="${list.class_type_cd!='G019C002' and list.reg_etc != null and list.reg_etc == 'GONGGYUL'}">
		    		<c:set var="val_attendee_gonggyul_cnt" value="${val_attendee_gonggyul_cnt + 1}" />
				    <c:set var="attendTopStyle" value="photopupple" /> 
					<c:set var="attendBottomStyle" value="puppleboxfont" /> 
		    	</c:when>
		    	
		    	<%-- 그외 상황 --%>
		    	<c:otherwise>
		    		<c:choose>
		    			
		    			<%-- 출결전 / 정상 --%>
					    <c:when test="${list.attend_sts_cd=='G023C001'&&list.class_type_cd=='G019C001' }">
							<c:set var="val_attendee_before_cnt" value="${val_attendee_before_cnt + 1}" />
							<c:set var="attendTopStyle" value="photowhite" />
				    		<c:set var="attendBottomStyle" value="whiteboxfont" />
					    </c:when>
					    
					    <%-- 출결전 / 휴강 --%>
					    <c:when test="${list.attend_sts_cd=='G023C001'&&list.class_type_cd=='G019C002' }">
							<c:set var="attendTopStyle" value="photogray" />
				    		<c:set var="attendBottomStyle" value="grayboxfont" />
					    </c:when>
					    
					    <%-- 출결전 / 보강 --%>
					    <c:when test="${list.attend_sts_cd=='G023C001'&&list.class_type_cd=='G019C003' }">
							<c:set var="val_attendee_before_cnt" value="${val_attendee_before_cnt + 1}" />
							<c:set var="attendTopStyle" value="photogray" />
				    		<c:set var="attendBottomStyle" value="grayboxfont" />
					    </c:when>
					    
					    <%-- 출결 --%>
					    <c:when test="${list.attend_sts_cd=='G023C002' }">    	
							<c:set var="val_attendee_present_cnt" value="${val_attendee_present_cnt + 1}" />
						    <c:set var="attendTopStyle" value="photoblue" /> 
							<c:set var="attendBottomStyle" value="blueboxfont" /> 
					    </c:when>
					    
					    <%-- 지각 --%>
					    <c:when test="${list.attend_sts_cd=='G023C003' }">
							<c:set var="val_attendee_late_cnt" value="${val_attendee_late_cnt + 1}" />
							
							<c:set var="attendTopStyle" value="photoyellow" /> 
							<c:set var="attendBottomStyle" value="yellowboxfont" /> 
					    </c:when>
					    
					    <%-- 결석 --%>
					    <c:when test="${list.attend_sts_cd=='G023C004'&&list.class_type_cd!='G019C002' }">
							<c:set var="val_attendee_absent_cnt" value="${val_attendee_absent_cnt + 1}" />
						    
						    <c:set var="attendTopStyle" value="photored" /> 
							<c:set var="attendBottomStyle" value="redboxfont" /> 
					    </c:when>
					    
				    	<%-- 휴강시 결석 (경동대만 추가 2017.04.17) --%>
					    <c:when test="${list.attend_sts_cd=='G023C004'&&list.class_type_cd=='G019C002' }">
						    <c:set var="attendTopStyle" value="photogray" /> 
							<c:set var="attendBottomStyle" value="grayboxfont" /> 
					    </c:when>
					    
		    		</c:choose>
		    	</c:otherwise>
		    </c:choose>
	
			<tr>
			    <td width="91" height="50" class="${attendTopStyle }"><fmt:formatDate value="${list.classday}" pattern="yyyy-MM-dd"/><br />
			      ${list.class_type_name }
			    </td>
		    </tr>
		    
		    <c:choose>
		    	<%-- 강의전 --%>
		    	<c:when test="${list.attend_sts_cd=='G023C001' }">
		    		<c:choose>
		    			
		    			<%-- 휴강 --%>
		    			<c:when test="${list.class_type_cd=='G019C002' }">
							<tr>
								<td height="50" class="grayboxfont">보강일<br>
									<c:if test="${empty list.before_classday}">없음</c:if>
									<c:if test="${not empty list.before_classday}"><fmt:formatDate value="${list.before_classday }" pattern="yyyy-MM-dd"/></c:if>
								</td>
							</tr>
		    			</c:when>	
		    			
		    			<%-- 보강 --%>
		    			<c:when test="${list.class_type_cd=='G019C003' }">
							<tr>
								<c:choose>
									<c:when test="${attendTopStyle eq 'puppletop'}">
										<c:set var="attendBottomStyle2" value="puppleboxfont" /> 							
									</c:when>
									<c:otherwise>
										<c:set var="attendBottomStyle2" value="grayboxfont" /> 							
									</c:otherwise>
								</c:choose>
								
								<td height="50" class="${attendBottomStyle2 }">휴강일<br>
								<c:if test="${empty list.before_classday}">없음</c:if>
								<c:if test="${not empty list.before_classday}"><fmt:formatDate value="${list.before_classday }" pattern="yyyy-MM-dd"/></c:if>
								<br/>${list.attend_sts_name }
								</td>
							</tr>
		    			</c:when>
		    			
		    			<%-- 정상 --%>
			    		<c:otherwise>
							<tr>
							    <td height="50" class="${attendBottomStyle }">${list.class_sts_name }<br />
							      ${list.attend_sts_name }
							     </td>
						    </tr>
			    		</c:otherwise>
		    		</c:choose>
		    	</c:when>
		    	
		    	<%-- 그외 상황 --%>
		    	<c:otherwise>
		    		<c:choose>
			    		<%-- 휴강시 (경동대만 추가 2017.04.17) --%>
		    			<c:when test="${list.class_type_cd=='G019C002' }">
							<tr>
								<td height="50" class="grayboxfont">보강일<br>
									<c:if test="${empty list.before_classday}">없음</c:if>
									<c:if test="${not empty list.before_classday}"><fmt:formatDate value="${list.before_classday }" pattern="yyyy-MM-dd"/></c:if>
								</td>
							</tr>
		    			</c:when>
		    			
		    			<c:otherwise>
				    		<tr>
							    <td height="50" class="${attendBottomStyle }">${list.class_sts_name }<br />
							      ${list.attend_sts_name }
							     </td>
						    </tr>
					    </c:otherwise>
				    </c:choose>
		    	</c:otherwise>
		    </c:choose>
			
			<!-- 
			<c:choose>
			<c:when test="${lectureDetail.class_adm_cd == 'G027C001' && (list.attend_sts_cd=='G023C003'||list.attend_sts_cd=='G023C004')}">
			<tr>
			<td height="30" align="center">
				<button onclick="studentClaim('${list.class_cd}','${list.classday }','${list.classhour_start_time}')">
					<img src="${pageContext.request.contextPath}/resources/images/student/claim_button.png" width="73" height="23" alt="이의신청버튼" />
				</button>
			</td>
			</tr>
			</c:when>
			<c:otherwise>
			<tr>
				<td height="30" align="center">
				</td>
			</tr>
			</c:otherwise>
			</c:choose>
			-->
		</table>
	</c:forEach>  
</div>

<div id="dialog_student_claim1" title="이의신청"></div>
<!-- //강의출결상세 -->
<div>
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
</body>
</html>
<%-- 출결수를 출결이력정보에서 처리(2015.08.31) --%>
<script>
	$("#span_attend_gonggyul_cnt").html("${val_attendee_gonggyul_cnt}");	
	$("#span_attendee_cnt").html("${val_attendee_cnt}");
	$("#span_attend_present_cnt").html("${val_attendee_present_cnt}");
	$("#span_attend_late_cnt").html("${val_attendee_late_cnt}");
	$("#span_attend_absent_cnt").html("${val_attendee_absent_cnt}");
	$("#span_attend_off_cnt").html("${val_attendee_off_cnt}");
	$("#span_attend_before_cnt").html("${val_attendee_before_cnt}");
</script>