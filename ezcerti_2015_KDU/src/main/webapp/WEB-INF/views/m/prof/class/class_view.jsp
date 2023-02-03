
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

<spring:eval expression="@config['user_image_path']" var="user_image_path"/>
<spring:eval expression="@config['makeup_lesson']" var="makeup_lesson"/>
<spring:eval expression="@config['attend_authority_period']" var="attend_authority_period"/>

<c:set var="am" value="${attendMaster}"/>
<jsp:useBean id="toDay" class="java.util.Date" />

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
	
	var otherImg = "";
	$('.phototable img').error(function() {
		otherImg = $(this).attr('src');
		
		if(otherImg.indexOf(".JPG") < 0) {
			otherImg = otherImg.replace(".jpg", ".JPG");
		} else {
			otherImg = '${pageContext.request.contextPath}/resources/images/noimage.jpg';
		}

		$(this).attr('src', otherImg);		
		//$(this).attr('src', '${pageContext.request.contextPath}/resources/images/noimage.jpg');
	}).each(function(n) {
		$(this).attr('src', $(this).attr('src'));
	});
	
	//setInterval("location.reload();", 60000);	
});


var statusList = new Array();

function chgStatus(no, student_no, sts_cd) {
	
	/* 학교측 요청 사항 20160625 이후는 출결처리가 안되게 [수정사항] */
	/* if("${attendMaster.classday >= '2016-06-25'}" == "true"){
		alert("6/25일 이후에는 출결처리가 되지 않습니다.\n자세한 사항은 교무처에 문의하시기 바랍니다.");
		return;
	} */
	
	<c:choose>
		<c:when test="${attendMaster.class_prog_cd!='G018C001'}">
			alert("휴/보강 신청, 취소 중인 강의는 출결처리를 하실 수 없습니다.");
		</c:when>
		<c:when test="${attendMaster.class_type_cd=='G019C002'}">
			alert("휴강된 강의에서는 출결처리를 하실 수 없습니다.\n보강된 강의에서 출결처리를 하시기 바랍니다.");
		</c:when>
		<c:when test="${attendMaster.class_sts_cd=='G020C001'}">
			alert("아직 강의가 시작되지 않았습니다.");
		</c:when>
		<c:when test="${attendMaster.class_sts_cd == 'G020C002' and empty attendMaster.cert_type }">
			alert("강의인증 방식이 선택되지 않았습니다.\n\n[강의시작] 버튼을 클릭하여\n\n강의인증 방식을 선택해 주시기 바랍니다.");
		</c:when>
		<c:when test="${attendMaster.class_sts_cd=='G020C002' and attendMaster.cert_sts_cd=='G021C001'}">
		</c:when>
		<c:when test="${attendMaster.class_adm_cd=='G027C002'}">
		</c:when>
		<c:otherwise>	
			if($("#student_photo_"+no+" .photowhite").attr("class")=="photowhite"){
				$("#student_photo_"+no+" .photowhite").removeClass("photowhite").addClass("photoblue");
				$("#student_photo_"+no+" .photowhitefont").removeClass("photowhitefont").addClass("photobluefont");
				statusList[no] = student_no+"|"+sts_cd+"|"+"G023C002";
			}else if($("#student_photo_"+no+" .photoblue").attr("class")=="photoblue"){
				$("#student_photo_"+no+" .photoblue").removeClass("photoblue").addClass("photoyellow");
				$("#student_photo_"+no+" .photobluefont").removeClass("photobluefont").addClass("photoyellowfont");
				statusList[no] = student_no+"|"+sts_cd+"|"+"G023C003";
			}else if($("#student_photo_"+no+" .photoyellow").attr("class")=="photoyellow"){
				$("#student_photo_"+no+" .photoyellow").removeClass("photoyellow").addClass("photored");
				$("#student_photo_"+no+" .photoyellowfont").removeClass("photoyellowfont").addClass("photoredfont");
				statusList[no] = student_no+"|"+sts_cd+"|"+"G023C004";
			}else if($("#student_photo_"+no+" .photored").attr("class")=="photored"){
				$("#student_photo_"+no+" .photored").removeClass("photored").addClass("photoblue");
				$("#student_photo_"+no+" .photoredfont").removeClass("photoredfont").addClass("photobluefont");
				statusList[no] = student_no+"|"+sts_cd+"|"+"G023C002";
			}
			/* 
			else if ($("#student_photo_"+no+" .photogray").attr("class")=="photogray"){ 
				
				// 20160525일 이후 휴학생의 경우 출결처리 가능하게 (출석만 가능) [수정사항] /
				if("${attendMaster.classday >= '2016-05-25'}" == "true"){
					$("#student_photo_"+no+" .photogray").removeClass("photogray").addClass("photoblue");
					$("#student_photo_"+no+" .photograyfont").removeClass("photograyfont").addClass("photobluefont");
					statusList[no] = student_no+"|"+sts_cd+"|"+"G023C002";
				}
			}
			 */
		</c:otherwise>
	</c:choose>	
}
function chgAllStatus(){
	
	/* 학교측 요청 사항 20160625 이후는 출결처리가 안되게 [수정사항] */
	/* if("${attendMaster.classday >= '2016-06-25'}" == "true"){
		alert("6/25일 이후에는 출결처리가 되지 않습니다.\n자세한 사항은 교무처에 문의하시기 바랍니다.");
		return;
	} */
	
	<c:choose>
		<c:when test="${attendMaster.class_prog_cd!='G018C001'}">
			alert("휴/보강 신청, 취소 중인 강의는 출결처리를 하실 수 없습니다.");
		</c:when>
		<c:when test="${attendMaster.class_type_cd=='G019C002'}">
			alert("휴강된 강의에서는 출결처리를 하실 수 없습니다.\n보강된 강의에서 출결처리를 하시기 바랍니다.");
		</c:when>
		<c:when test="${attendMaster.class_sts_cd=='G020C001'}">
			alert("아직 강의가 시작되지 않았습니다.");
		</c:when>
		<c:when test="${attendMaster.class_sts_cd == 'G020C002' and empty attendMaster.cert_type }">
			alert("강의인증 방식이 선택되지 않았습니다.\n\n[강의시작] 버튼을 클릭하여\n\n강의인증 방식을 선택해 주시기 바랍니다.");
		</c:when>
		<c:when test="${attendMaster.class_sts_cd=='G020C002' and attendMaster.cert_sts_cd=='G021C001'}">
		</c:when>
		<c:when test="${attendMaster.class_adm_cd=='G027C002'}">
		</c:when>
		<c:otherwise>
			var studentStatus;
			for(var i = 1; i < '${fn:length(attendDetailList)+1}'; i++){
				studentStatus = $("#student_photo_"+[i]).attr("onclick");
				if(studentStatus != null && studentStatus != undefined){
					
					if($("#student_photo_"+[i]+" .photowhite").attr("class")=="photowhite"){
						$("#student_photo_"+[i]+" .photowhite").removeClass("photowhite").addClass("photoblue");
						$("#student_photo_"+[i]+" .photowhitefont").removeClass("photowhitefont").addClass("photobluefont");
						statusList[i] = studentStatus.split("'")[3]+"|"+studentStatus.split("'")[5]+"|"+"G023C002";
					}else if($("#student_photo_"+[i]+" .photoblue").attr("class")=="photoblue"){
						$("#student_photo_"+[i]+" .photoblue").removeClass("photoblue").addClass("photoblue");
						$("#student_photo_"+[i]+" .photobluefont").removeClass("photobluefont").addClass("photobluefont");
						statusList[i] = studentStatus.split("'")[3]+"|"+studentStatus.split("'")[5]+"|"+"G023C002";
					}else if($("#student_photo_"+[i]+" .photoyellow").attr("class")=="photoyellow"){
						$("#student_photo_"+[i]+" .photoyellow").removeClass("photoyellow").addClass("photoblue");
						$("#student_photo_"+[i]+" .photoyellowfont").removeClass("photoyellowfont").addClass("photobluefont");
						statusList[i] = studentStatus.split("'")[3]+"|"+studentStatus.split("'")[5]+"|"+"G023C002";
					}else if($("#student_photo_"+[i]+" .photored").attr("class")=="photored"){
						$("#student_photo_"+[i]+" .photored").removeClass("photored").addClass("photoblue");
						$("#student_photo_"+[i]+" .photoredfont").removeClass("photoredfont").addClass("photobluefont");
						statusList[i] = studentStatus.split("'")[3]+"|"+studentStatus.split("'")[5]+"|"+"G023C002";
					}		
					
				}
			}
			alert("출결저장 버튼을 누르셔야 적용됩니다.");
		</c:otherwise>
	</c:choose>
}
Array.prototype.remove = function (index) { 
	this.splice(index, 1); 
};	

function sendUpdate() {

    <%
		SimpleDateFormat  formatter1 = new SimpleDateFormat("yyyy-MM-dd");
	    String nowDate =  formatter1.format(new Date());
	%>
	var nowDate = <%="'" + nowDate + "'"%>;
	
	if(checkAttendAuth("${am.classday}", "${attend_authority_period}", nowDate)) {
		if(statusList.length==0){
			alert("변경내역이 존재하지 않습니다.");
		}else{
			<c:choose>
				<c:when test="${attendMaster.class_prog_cd!='G018C001'}">
					alert("휴/보강 신청, 취소 중인 강의는 출결처리를 하실 수 없습니다.");
				</c:when>
				<c:when test="${sessionScope.PROF_INFO.prof_adm_cd=='G026C002' }">
					alert("학기가 마감되어 변경이 불가능합니다.");
					window.location.reload(true);
				</c:when>
				<c:otherwise>			
					$('#attend_reason_popup').dialog('open');
				</c:otherwise>
			</c:choose>
	 	}
	} else {
		alert("출결처리 시간이 아닙니다.");
	}	
}
	
$(function() {
	var btnStatus = 0; 
	  $( "#attend_reason_popup" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    height:180,
	    modal: true,
	    buttons: {
	      "변경완료": function() {
    	if(btnStatus == 0){
	        for (var i = statusList.length; i >= 0; i--) {
		        if (statusList[i] == null || statusList[i].length < 0) {
		        	statusList.remove(i);
		        }else{
			    	statusList[i] +="|"+$("#select_reason_code").val();
		        }
			    }
	        btnStatus++;
	    	}else if(btnStatus > 0){
	    		alert("처리중입니다.");
	    		return false;
	    	}
			
		var postString = {statusList: statusList, class_cd: '${attendMaster.class_cd}', classday: '${attendMaster.classday}', classhour_start_time: '${attendMaster.classhour_start_time}'};
		
	    $.ajax({
	        type: "POST",
	
	        url: "${pageContext.request.contextPath}/m/prof/class/class_view_update",
	
	        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
	
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
	        
	      },
	      "취소": function() {
	        $( this ).dialog( "close" );
	      }
	    }
	  });
	});

$(function() {
	  $( "#dialog_authority_list" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    width:300,
	    height:350,
	    modal: true,
	    buttons: {
	      "닫기": function() {
	        $( this ).dialog( "close" );
	      }
	    }
	  });
	});
$(function() {
	  $( "#dialog_apperror_list" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    width:300,
	    height:350,
	    modal: true,
	    buttons: {
	      "닫기": function() {
	        $( this ).dialog( "close" );
	      }
	    }
	  });
	});
	
$(function() {
	  $( "#dialog_attend_copy1" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    width:300,
	    height:350,
	    modal: true,
	    buttons: {
	      "확인": function() {			
	        $( this ).dialog( "close" );
	    	$("#dialog_attend_copy2").load('${pageContext.request.contextPath}/prof/class/attend_copy',{class_cd:'${class_cd}',subject_cd:'${attendMaster.subject_cd}',subject_div_cd:'${attendMaster.subject_div_cd}', classday:'${classday}', classhour_start_time:'${classhour_start_time}'});
	        $('#dialog_attend_copy2').dialog('open');
	      },
	      "취소": function() {
	        $( this ).dialog( "close" );
	      }
	    }
	  });
	});
$(function() {
	  $( "#dialog_attend_copy2" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    width:300,
	    height:350,
	    modal: true,
	    buttons: {
	      "확인": function() {
	    	  var classList=[];
	    	  $('input[name="copylist"]:checkbox:checked').each(function(){classList.push($(this).val());});
	    	  
	    	  var tmp = classList.join(',');
	  		var postString = {class_cd:'${class_cd}', classday:'${classday}', classhour_start_time:'${classhour_start_time}', classList:tmp};
			
		    $.ajax({
		        type: "POST",
		
		        url: "${pageContext.request.contextPath}/prof/class/attend_copy_confirm",
		
		        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
		
		        success: function(msg) {
		        	$('#resultDIV').append(msg);   
		        	classList = new Array();
		        	alert(msg);
		        	window.location.reload(true);
		        },
		        beforeSend: function() {
		            //통신을 시작할때 처리
		         $('.ui-dialog button:nth-child(1)').button('disable');
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
	    	  
	      },
	      "취소": function() {
	        $( this ).dialog( "close" );
	      }
	    }
	  });
	});
function attendCopy(){
	<c:choose>
		<c:when test="${attendMaster.class_prog_cd!='G018C001'}">
			alert("휴/보강 신청, 취소 중인 강의는 출결처리를 하실 수 없습니다.");
		</c:when>
		<c:when test="${attendMaster.class_type_cd=='G019C002'}">
			alert("휴강된 강의는 연강처리를 하실 수 없습니다.");
		</c:when>
		<c:when test="${attendMaster.class_sts_cd=='G020C001'}">
			alert("아직 강의가 시작되지 않았습니다.");
		</c:when>
		<c:when test="${attendMaster.class_sts_cd == 'G020C002' and empty attendMaster.cert_type }">
			alert("강의인증 방식이 선택되지 않았습니다.\n\n[강의시작] 버튼을 클릭하여\n\n강의인증 방식을 선택해 주시기 바랍니다.");
		</c:when>
		<c:otherwise>
			
			if(statusList.length>0){
				alert("변경사항 적용 후 처리가능합니다.");
				return false;
			}else if(statusList.length==0){
				$("#dialog_attend_copy1").dialog("open");	
			}
			
		</c:otherwise>
	</c:choose>	
}

function restoreClass(class_cd, classday, classhour_start_time, class_type_cd, before_classday){
	/* 지정휴강일의 경우 교수가 취소할 수 없도록 요청하여 'BATCH_CLASSOFF' 정보로 체크하였으나
	   해당 조건을 풀어달라는 요청에 의해 'BATCH_CLASSOFF_'로 변경함 (2017.04.12)
	*/
	<c:choose>
		<c:when test="${am.reg_etc != null and am.reg_etc eq 'BATCH_CLASSOFF_'}">
			alert("보강일이 지정된 강의는 취소하실 수 없습니다.\n자세한 내용은 교학처로 문의하시기 바랍니다.");			
		</c:when>
		<c:otherwise>
			$("#dialog_restore_class1").load('${pageContext.request.contextPath}/prof/class/restore_class',{class_cd:class_cd, classday:classday, classhour_start_time:classhour_start_time, class_type_cd:class_type_cd, before_classday:before_classday});
			$("#dialog_restore_class1").dialog("open");
		</c:otherwise>
	</c:choose>
}

$(function() {
	  $( "#dialog_restore_class1" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    width:300,
	    height:350,
	    modal: true,
	    buttons: {
	      "확인": function() {			
	        $( this ).dialog( "close" );

	        var postString = {
	    			class_cd:'${class_cd}',
	    			before_classday:$("input[name='before_classday']").val(), 
	    			before_classhour_start_time:$("input[name='before_classhour_start_time']").val(),
	    			before_class_type_cd:$("input[name='before_class_type_cd']").val(),
	    			current_classday:$("input[name='current_classday']").val(), 
	    			current_classhour_start_time:$("input[name='current_classhour_start_time']").val(),
	    			current_class_type_cd:$("input[name='current_class_type_cd']").val()
    			};
	        
		    $.ajax({
		        type: "POST",
		
		        url: "${pageContext.request.contextPath}/prof/class/restore_class_request",
		
		        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
		
		        success: function(msg) {
		        	$('#resultDIV').append(msg);   
		        	classList = new Array();
		        	alert(msg);
		        	location.href="${pageContext.request.contextPath}/prof/prof_mypage";
		        },
		        beforeSend: function() {
		            //통신을 시작할때 처리
		         $('.ui-dialog button:nth-child(1)').button('disable');
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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="55%" align="left"><img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png"  style="max-width:13px;" alt="아이콘">&nbsp; 강의출결 상세정보 
      </td>
    <td width="45%" align="right">
    <!-- 강의중 -->
    <c:if test="${am.class_type_cd ne 'G019C002' and am.class_sts_cd=='G020C002'}">
   	<!-- 2015.02.02 (인증처리 하도록 수정)
	- 인증요청 전인 경우 항상 강의인증 버튼 표시
	- 인증요청 후인 경우  
	- CERT_TYPE이 CERT_NUM인 경우만 강의인증 버튼 표시
	- CERT_TYPE이 PROF_AUTH인 경우 강의중으로 표시
   	-->
		<c:if test="${am.cert_sts_cd=='G021C001' }">
			<button onclick="certType('${class_cd}','${classday}','${classhour_start_time}','${am.cert_sts_cd }')"><img src="${pageContext.request.contextPath}/resources_m/images/attendee_button_07.png" style="max-width:60px;" alt="강의시작 버튼"></button>&nbsp;			
		</c:if>
		<c:if test="${am.cert_sts_cd=='G021C002' && am.cert_type eq 'CERT_NUM'}">
	    	<button onclick="certLecture('${class_cd}','${classday}','${classhour_start_time}','${am.cert_sts_cd }')"><img src="${pageContext.request.contextPath}/resources_m/images/attendee_button_08.png" style="max-width:60px;" alt="인증코드 버튼"></button>&nbsp;
		</c:if>	               
	</c:if>
  	<c:if test="${am.cert_sts_cd!='G021C002'}">
		<c:if test="${makeup_lesson eq 'Y' and am.classoff_yn eq 'Y' }">		
			<c:if test="${am.class_type_cd == 'G019C001'}">        	
		    	<button onclick="skipLecture('${class_cd}','${classday}','${classhour_start_time}','${am.class_prog_cd }','${am.classroom_no}')">
		    		<img src="${pageContext.request.contextPath}/resources_m/images/attendee_button_01.png" style="max-width:60px;" alt="휴강처리버튼">
		    	</button>&nbsp;&nbsp;
			</c:if>
			<%--
			<c:if test="${am.class_type_cd == 'G019C002' and am.class_prog_cd != 'G018C004' and am.before_classday > toDay }">
			--%>
			<c:if test="${am.class_type_cd == 'G019C002' and am.class_prog_cd != 'G018C004'}">
			 	<button onclick="restoreClass('${class_cd}', '${classday}', '${classhour_start_time}', '${am.class_type_cd}', '${am.before_classday}')">
			 		<img src="${pageContext.request.contextPath}/resources_m/images/button_cancel_off.png" style="max-width:60px; margin-right:5px;" alt="휴강취소버튼">
			 	</button>
			</c:if>
			<%-- 
			<c:if test="${am.class_type_cd == 'G019C003' and am.classday > toDay }">
			--%>
			<c:if test="${am.class_type_cd == 'G019C003'}">
			 	<button onclick="restoreClass('${class_cd}', '${classday}', '${classhour_start_time}', '${am.class_type_cd}', '${am.before_classday}')">
			 	    <img src="${pageContext.request.contextPath}/resources_m/images/button_cancel_add.png" style="max-width:60px; margin-right:5px;" alt="보강취소버튼">
			 	</button>
			</c:if>
		</c:if>
	</c:if>    	 
   	</td>
  </tr>
</table>

<!-- 15주차가 보강주로 인해 16주차에 강의가 생성됨으로 표시를 16이 아닌 15로 표시되도록 함 -->
<c:set var="view_week" value="${am.curr_week}" />
<c:if test="${view_week eq '16'}">
	<c:set var="view_week" value="${view_week - 1}" />
</c:if>

</div>
  <div class="attendeeinfo"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="25" colspan="3"><font style="font-size:13px; font-weight:bold">${am.class_name }<font/> (${am.classroom_no})</td>
    </tr>
  <tr>
    <td height="25" >
    	<c:if test="${am.curr_week ne null && !empty am.curr_week}">(${view_week}주)</c:if>
    	${am.classday} (${am.classday_name }) ${am.classhour_start_time } ~ ${am.classhour_end_time }
    </td>
    <td height="25" align="center">${am.subject_cd}-${am.subject_div_cd }</td>
    <td height="25" align="right">${am.class_type_name}</td>
  </tr>
  <tr>
    <td height="25">${am.prof_dept_name }</td>
    <td height="25" align="center">${am.prof_name }</td>
    <td height="25" align="right">${am.class_sts_name }</td>
  </tr>
  <tr>
  	<td colspan="3">
       <c:choose>
       <c:when test="${am.class_type_cd=='G019C001'}">
       &nbsp;강의형태 : ${am.class_type_name}
       </c:when>
       <c:when test="${am.class_type_cd=='G019C002'}">
	       <c:if test="${empty am.before_classday }">
	       	&nbsp;강의형태 : ${am.class_type_name}
	       </c:if>
	       <c:if test="${not empty am.before_classday }">
	       &nbsp;보강일정보 : <fmt:formatDate value="${am.before_classday}" type="both" pattern="yyyy-MM-dd (E) HH:mm"/>
	       </c:if>
	       </c:when>
       <c:when test="${am.class_type_cd=='G019C003'}">
	       <c:if test="${empty am.before_classday }">
	       	&nbsp;강의형태 : ${am.class_type_name}
	       </c:if>
	       <c:if test="${not empty am.before_classday }">
	       &nbsp;휴강일정보 : <fmt:formatDate value="${am.before_classday}" type="both" pattern="yyyy-MM-dd (E) HH:mm"/>
	       </c:if>
       </c:when>
       </c:choose>
    </td>
  </tr>
</table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="graytable">
      <tr>
        <td height="26" colspan="2" align="center"><strong>총원 <span id="span_attendee_cnt">${am.attendee_cnt }</span>명</strong></td>
        <td align="center" valign="bottom"><img src="${pageContext.request.contextPath}/resources_m/images/red_icon.png" style="max-width:17px;" alt="출석아이콘"></td>
        <td align="left">결석 <span id="span_attend_absent_cnt">${am.attend_absent_cnt }</span>명</td>
        <td align="center" valign="bottom"><img src="${pageContext.request.contextPath}/resources_m/images/gray_icon.png" style="max-width:17px;" alt="출석아이콘"></td>
        <td align="left">휴학 <span id="span_attend_off_cnt">${am.attend_off_cnt }</span>명</td>
		<c:if test="${am.cert_sts_cd=='G021C002' && am.cert_type eq 'CERT_NUM'}">
			<td><img src="${pageContext.request.contextPath}/resources_m/images/blue_icon.png" style="max-width:17px;"></td>
			<td align="left">앱 실행 : ${attendAppInfo.app_exec}명</td>
		</c:if>
      </tr>
      <tr>
        <td height="26" align="center"><img src="${pageContext.request.contextPath}/resources_m/images/blue_icon.png" style="max-width:17px;" alt="출석아이콘"></td>
        <td align="left">출석 <span id="span_attend_present_cnt">${am.attend_present_cnt }</span>(<span id="span_attend_gonggyul_cnt">&nbsp;</span>)명</td>
        <td align="center"><img src="${pageContext.request.contextPath}/resources_m/images/yellow_icon.png" style="max-width:17px;" alt="출석아이콘"></td>
        <td align="left">지각 <span id="span_attend_late_cnt">${am.attend_late_cnt }</span>명</td>
        <td align="center"><img src="${pageContext.request.contextPath}/resources_m/images/deepgray_icon.png" style="max-width:16px;" alt="출석아이콘"></td>
        <td align="left">제적 <span id="span_attend_quit_cnt">${am.attend_quit_cnt }</span>명</td>
		<c:if test="${am.cert_sts_cd=='G021C002' && am.cert_type eq 'CERT_NUM'}">
			<td><a onclick="$('#dialog_apperror_list').dialog('open')"><img src="${pageContext.request.contextPath}/resources_m/images/red_icon.png" style="max-width:17px;"></a></td>
			<td align="left">상태이상 : <a onclick="$('#dialog_apperror_list').dialog('open')" style="cursor:pointer">${attendAppInfo.app_error}명</a></td>
		</c:if>
      </tr>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="70%" height="25" align="left">직권처리인원 ${fn:length(attendAuthorityDetailList) }명</td>
        <td width="30%" align="right"><a onclick="$('#dialog_authority_list').dialog('open')"><img src="${pageContext.request.contextPath}/resources_m/images/attendee_button_03.png" style="max-width:60px;" alt="내역보기 버튼"></a></td>
      </tr>
    </table>
</div>
<div class="photobutton" style="margin-bottom: 0px;">
   	<button><img src="${pageContext.request.contextPath}/resources/images/prof/button_reload2.png" height="20" alt="새로고침버튼" onclick="javascript:location.reload();"></button>
	
	<c:if test="${attendMaster.class_adm_cd=='G027C001'}">
   		<button><img src="${pageContext.request.contextPath}/resources/images/prof/attendbatch_button.png" height="20" alt="일괄출석버튼" onclick="chgAllStatus()"></button>
		<button id="send_update" onclick="javascript:sendUpdate()"><img src="${pageContext.request.contextPath}/resources/images/prof/class_button_07.png" height="20" alt="출결저장 버튼"></button>
		<c:if test="${isUninterruptLecture == 'true' }">
			<button id="attend_copy" onclick="attendCopy('${class_cd}','${classday}','${classhour_start_time}')" ><img src="${pageContext.request.contextPath}/resources/images/prof/class_button_06.png" height="20" alt="연강출결처리버튼"></button>
		</c:if>
	</c:if>
	
	<a href="javascript:history.back(-1)"><img src="${pageContext.request.contextPath}/resources/images/prof/list_button.png" style="max-width:45px;" alt="목록버튼"></a>
</div>
<div class="tablebox">
	<c:forEach var="list" items="${attendDetailList}">
	
		<c:set var="varStudentYear" value="${list.iphak_year}" />
    	
    	<c:choose>
	    	<c:when test="${list.student_img eq null}">
	    		<c:set var="student_photo" value="${pageContext.request.contextPath}/resources/images/noimage.jpg" />
	    	</c:when>
	    	<c:otherwise>
				<c:set var="student_photo" value="${user_image_path}?platformType=nexacro&method=view&f0=${list.student_img}" />
	    	</c:otherwise>
    	</c:choose>
    	
		<c:set var="val_attendee_cnt" value="${val_attendee_cnt + 1}" />
		
		<c:choose>
		 	<%-- 공결시 --%>
		   	<c:when test="${list.reg_etc != null and list.reg_etc == 'GONGGYUL'}">
		   		<c:set var="val_attendee_gonggyul_cnt" value="${val_attendee_gonggyul_cnt + 1}" />
			    <c:set var="val_attendphoto_style" value="photopupple" />
			    <c:set var="val_attendfont_style" value="photopupplefont" />
		   	</c:when>
		   	
		   	<%-- 휴강시 (경동대만 추가 2017.04.17) --%>
	    	<c:when test="${list.class_type_cd == 'G019C002'}">
	    		<c:set var="val_attendee_before_cnt" value="${val_attendee_before_cnt + 1}" />
				<c:set var="val_attendphoto_style" value="photowhite" />
	    		<c:set var="val_attendfont_style" value="photowhitefont" />
	    	</c:when>
		   	
		   	<%-- 그외 상황 --%>
		   	<c:otherwise>
		   		<c:choose>
		   			
		   			<%-- 출결전 --%>
				    <c:when test="${list.attend_sts_cd=='G023C001' and (list.student_sts_cd ne 'G012C002' and list.student_sts_cd ne 'G012C005') }">
						<c:set var="val_attendee_before_cnt" value="${val_attendee_before_cnt + 1}" />
						<c:set var="val_attendphoto_style" value="photowhite" />
			    		<c:set var="val_attendfont_style" value="photowhitefont" />
				    </c:when>
				    
				    <%-- 출결 --%>
				    <c:when test="${list.attend_sts_cd=='G023C002' }">    	
						<c:set var="val_attendee_present_cnt" value="${val_attendee_present_cnt + 1}" />
					    <c:set var="val_attendphoto_style" value="photoblue" />
			    		<c:set var="val_attendfont_style" value="photobluefont" />
				    </c:when>
				    
				    <%-- 지각 --%>
				    <c:when test="${list.attend_sts_cd=='G023C003' }">
						<c:set var="val_attendee_late_cnt" value="${val_attendee_late_cnt + 1}" />
						<c:set var="val_attendphoto_style" value="photoyellow" />
			    		<c:set var="val_attendfont_style" value="photoyellowfont" />
				    </c:when>
				    
				    <%-- 결석 --%>
				    <c:when test="${list.attend_sts_cd=='G023C004' }">
						<c:set var="val_attendee_absent_cnt" value="${val_attendee_absent_cnt + 1}" />
					    <c:set var="val_attendphoto_style" value="photored" />
			    		<c:set var="val_attendfont_style" value="photoredfont" />
				    </c:when>
				    
				    <%-- 휴학 --%>
				    <c:when test="${list.attend_sts_cd=='G023C005' or list.student_sts_cd eq 'G012C002'}">
						<c:set var="val_attendee_off_cnt" value="${val_attendee_off_cnt + 1}" />
						<c:set var="val_attendphoto_style" value="photogray" />
			    		<c:set var="val_attendfont_style" value="photograyfont" />
				    </c:when>
				    
				    <%-- 제적 --%>
				    <c:when test="${list.attend_sts_cd=='G023C007' or list.student_sts_cd eq 'G012C005'}">
						<c:set var="val_attendee_quit_cnt" value="${val_attendee_quit_cnt + 1}" />
						<c:set var="val_attendphoto_style" value="photodeepgray" />
			    		<c:set var="val_attendfont_style" value="photodeepgrayfont" />
				    </c:when>
				    
		   		</c:choose>
			</c:otherwise>
		</c:choose>
		
		<table class="phototable" cellpadding="0" cellspacing="0" id="student_photo_${list.row_no }" onclick="chgStatus('${list.row_no }','${list.student_no}', '${list.attend_sts_cd }')">
			<tr>
				<td class="${val_attendphoto_style}">
					<img src="${student_photo}" style="width: 65px; height: 80px; font-family: '돋움', '돋움체';" alt="샘플사진">
				</td>
			</tr>
			<tr>
				<td class="${val_attendfont_style}">
					${fn:substring(list.student_dept_name,0,5)}<br/>
					${list.student_no }<c:if test="${list.abs_cnt ne null}">(장기)</c:if><br/>
					<font style="font-size:12px; font-weight:bold">${list.student_name }</font><br/>
					<c:choose>
			      		<c:when test="${list.attend_sts_cd=='G023C005' or list.student_sts_cd eq 'G012C002' }">
			      			(휴-${list.status_change_date })
			      		</c:when>
			      		<c:when test="${list.attend_sts_cd=='G023C007' or list.student_sts_cd eq 'G012C005' }">
			      			(제-${list.status_change_date })
			      		</c:when>
			      		
						<%-- 
			      			* 복학생 관련 처리 
			      			* 복학생의 경우 복학전 데이데는 
			      			* 일반 휴학의 경우  >>  결석
			      			* 군휴학, 질병     >>  출석 처리
			      			* 휴학 날짜가 지난후에는 재학생과 동일처리
			      		 --%>
			      		<c:when test="${list.student_sts_cd=='G012C001' and list.status_change_date ne null }">
			      			
			      			<fmt:parseDate var="parsedDate" value="${list.status_change_date}" pattern="yyyymmdd"/>
			      			<fmt:formatDate var="parsedDate2" value="${parsedDate}" type="both" pattern="yyyy-mm-dd"/>
			      			
			      			<c:if test="${list.classday <= parsedDate2}">
			      				(복-${list.status_change_date })
			      			</c:if>
			      			
			      				<%-- 
					      			* 학교측 요청 20170622 조기취업자 표시관련
				      		 	--%>
								<c:if test="${list.student_no == '1120006'}">
				      				<c:if test="${list.classday >= '2016-12-15'}">
					      				조기취업자
					      			</c:if>
					      		</c:if>
								<c:if test="${list.student_no == '1346019'}">
					      			<c:if test="${list.classday >= '2017-01-09'}">
					      				조기취업자
					      			</c:if>
					      		</c:if>
					      		<c:if test="${list.student_no == '1180007'}">
					      			<c:if test="${list.classday >= '2016-08-01'}">
					      				조기취업자
					      			</c:if>
					      		</c:if>
					      		<c:if test="${list.student_no == '1396084'}">
					      			<c:if test="${list.classday >= '2016-11-14'}">
					      				조기취업자
					      			</c:if>
					      		</c:if>
					      		<c:if test="${list.student_no == '0780048'}">
					      			<c:if test="${list.classday >= '2016-03-15'}">
					      				조기취업자
					      			</c:if>
					      		</c:if>
					      		<c:if test="${list.student_no == '0770126'}">
					      			<c:if test="${list.classday >= '2017-03-01'}">
					      				조기취업자
					      			</c:if>
					      		</c:if>
					      		<c:if test="${list.student_no == '1070089'}">
					      			<c:if test="${list.classday >= '2017-05-10'}">
					      				조기취업자
					      			</c:if>
					      		</c:if>
			      			
			      		</c:when>
			      		
			        </c:choose>
				</td>
			</tr>
		</table>

	</c:forEach>
</div>
  
<div class="photobutton" style="margin-bottom: 0px;">
   	<button><img src="${pageContext.request.contextPath}/resources/images/prof/button_reload2.png" height="20" alt="새로고침버튼" onclick="javascript:location.reload();"></button>
   	
   	<c:if test="${attendMaster.class_adm_cd=='G027C001'}">
		<button><img src="${pageContext.request.contextPath}/resources/images/prof/attendbatch_button.png" height="20" alt="일괄출석버튼" onclick="chgAllStatus()"></button>
		<button id="send_update" onclick="javascript:sendUpdate()"><img src="${pageContext.request.contextPath}/resources/images/prof/class_button_07.png" height="20" alt="출결저장 버튼"></button>
		<c:if test="${isUninterruptLecture == 'true' }">
			<button id="attend_copy" onclick="attendCopy('${class_cd}','${classday}','${classhour_start_time}')"><img src="${pageContext.request.contextPath}/resources/images/prof/class_button_06.png" height="20" alt="연강출결처리버튼"></button>
		</c:if>
	</c:if>
	
	<a href="javascript:history.back(-1)"><img src="${pageContext.request.contextPath}/resources/images/prof/list_button.png" style="max-width:45px;" alt="목록버튼"></a>
</div>
<div id="attend_reason_popup" title="출결상태 직권변경">
	<table style="width:100%;">
	<tr>
		<td align="center" style="margin-bottom:20px;">처리사유를 선택해주십시오.</td>
	</tr>
	<tr>
		<td align="center" style="height:30px;">
		<select id="select_reason_code">
		<c:forEach var="code" items="${codeListG024 }" begin="0" end="0">
			<option value="${code.code}">${code.code_name}</option>
		</c:forEach>
		</select>
		</td>
	</tr>
	</table>
<div id="ajax_indicator" style="display:none">
   <p style="text-align:center; padding:16px 0 0 0; left:50%; top:50%; position:absolute;">
   	<img src="${pageContext.request.contextPath }/resources/images/ajax-loader.gif" />
   </p>
</div>		
</div>
<div id="dialog_authority_list">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="55" align="center" valign="middle" class="tdgray">이름</td>
        <td width="65" align="center" valign="middle" class="tdgray">학번</td>
        <td width="120" align="center" valign="middle" class="tdgray">처리시간</td>
        <td width="100" align="center" valign="middle" class="tdgraynone">처리사유</td>
      </tr>
	<c:forEach var="list" items="${attendAuthorityDetailList }">	
      <tr>
        <td class="tdwhite">${list.student_name }</td>
        <td class="tdwhite">${list.student_no }</td>
        <td class="tdwhite"><fmt:formatDate value="${list.attend_auth_proc_time}" type="both" pattern="yyyy-MM-dd (E) HH:mm"/></td>
        <td class="tdwhitenone">${list.attend_sts_name }<br/>${list.attend_auth_reason_name }</td>
      </tr>
    </c:forEach>
	<c:if test="${empty attendAuthorityDetailList }">
		<tr>
			<td colspan="4" align="center" style="height:50px;" valign="middle">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
    </table></td>
  </tr>
</table>
</div>
<!-- 출결 앱 상태이상 내역 -->
<div id="dialog_apperror_list" title="출결 앱 상태이상 수강자 내역">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="55" align="center" valign="middle" class="tdgray">이름</td>
        <td width="65" align="center" valign="middle" class="tdgray">학번</td>
      </tr>
	<c:forEach var="list" items="${attendAppErrorList }">	
      <tr>
        <td class="tdwhite">${list.student_no }</td>
        <td class="tdwhite">${list.student_name }</td>
      </tr>
    </c:forEach>
	<c:if test="${empty attendAppErrorList }">
		<tr>
			<td colspan="4" align="center" style="height:50px;" valign="middle">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
    </table></td>
  </tr>
</table>
</div>
<div id="dialog_skip_lecture1" title="휴강처리"></div>	
<div id="dialog_skip_lecture2" title="휴강처리"></div>	
<div id="dialog_cert_lecture0" title="강의인증"></div>
<div id="dialog_cert_lecture1" title="강의인증"></div>	
<div id="dialog_cert_lecture2" title="강의인증"></div>	
<div id="dialog_cert_lecture3" title="강의인증"></div>
<div id="dialog_attend_copy1" title="연강출결처리">
<div style="width:96%;height:96%;"class="graybackbold">
	<p align="center" style="color: #00F;">${am.class_name }</p>
	<br>
	<p align="center" style="color: #00F;">${am.classday } (${am.classday_name }) ${am.classhour_start_time }</p>
	<br>
	<p>· 연강처리시 현재 강의의 출결정보가 선택된 강의에 반영됩니다.</p>
	<br>
	<p>· 만약 연강으로 처리된 강의의 출결정보를 변경하여야 할 경우 출결처리와 연강처리를 다시 진행해야 연강처리할 강의에 반영됩니다.</p>
</div>
</div>
<div id="dialog_attend_copy2" title="연강출결처리"></div>
<div id="dialog_restore_class1" title="보강취소"></div>
<div id="dialog_restore_class2" title="보강취소"></div>
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
	$("#span_attend_before_cnt").html("${val_attendee_before_cnt}");
	$("#span_attend_off_cnt").html("${val_attendee_off_cnt}");
	$("#span_attend_quit_cnt").html("${val_attendee_quit_cnt}");	
</script>