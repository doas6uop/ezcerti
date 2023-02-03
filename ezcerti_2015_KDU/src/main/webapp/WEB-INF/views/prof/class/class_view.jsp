<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/prof_cert.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prof_style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">

<c:set var="am" value="${attendMaster}"/>
<spring:eval expression="@config['user_image_path']" var="user_image_path"/>
<spring:eval expression="@config['makeup_lesson']" var="makeup_lesson"/>
<spring:eval expression="@config['attend_authority_period']" var="attend_authority_period"/>

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
	$(".menu12 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_attend_on.gif");
	$(".menu12 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_attend_on.gif");
	showElementTop(12);
	showElement(12);

	var otherImg = "";
	$('.photobox img').error(function() {
		
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
	
	/* $('.beforephoto').click(function() {
		alert('aaaa');
	});  */
	
	//setInterval("location.reload();", 60000);	
});


var statusList = new Array();

function chgStatus(no, student_no, sts_cd, student_sts_cd) {
	
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
			if($("#student_photo_"+no+" .beforephoto").attr("class")=="beforephoto"){
				$("#student_photo_"+no+" .beforephoto").removeClass("beforephoto").addClass("attendphoto");
				$("#student_photo_"+no+" .beforefont").removeClass("beforefont").addClass("attendfont");
				statusList[no] = student_no+"|"+sts_cd+"|"+"G023C002";
			}else if($("#student_photo_"+no+" .attendphoto").attr("class")=="attendphoto"){
				$("#student_photo_"+no+" .attendphoto").removeClass("attendphoto").addClass("latephoto");
				$("#student_photo_"+no+" .attendfont").removeClass("attendfont").addClass("latefont");
				statusList[no] = student_no+"|"+sts_cd+"|"+"G023C003";	
			}else if($("#student_photo_"+no+" .latephoto").attr("class")=="latephoto"){
				$("#student_photo_"+no+" .latephoto").removeClass("latephoto").addClass("cutphoto");
				$("#student_photo_"+no+" .latefont").removeClass("latefont").addClass("cutfont");
				statusList[no] = student_no+"|"+sts_cd+"|"+"G023C004";
			}else if($("#student_photo_"+no+" .cutphoto").attr("class")=="cutphoto"){
				$("#student_photo_"+no+" .cutphoto").removeClass("cutphoto").addClass("attendphoto");
				$("#student_photo_"+no+" .cutfont").removeClass("cutfont").addClass("attendfont");
				statusList[no] = student_no+"|"+sts_cd+"|"+"G023C002";
			}
			
			/*
			else if ($("#student_photo_"+no+" .timeoffphoto").attr("class")=="timeoffphoto"){ 
				
				// 20160525일 이후 휴학생의 경우 출결처리 가능하게 (출석만 가능) [수정사항] 
				if("${attendMaster.classday >= '2016-05-25'}" == "true"){
					$("#student_photo_"+no+" .timeoffphoto").removeClass("timeoffphoto").addClass("attendphoto");
					$("#student_photo_"+no+" .timeofffont").removeClass("timeofffont").addClass("attendfont");
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
					
					if($("#student_photo_"+[i]+" .beforephoto").attr("class")=="beforephoto"){
						$("#student_photo_"+[i]+" .beforephoto").removeClass("beforephoto").addClass("attendphoto");
						$("#student_photo_"+[i]+" .beforefont").removeClass("beforefont").addClass("attendfont");
						statusList[i] = studentStatus.split("'")[3]+"|"+studentStatus.split("'")[5]+"|"+"G023C002";
					}else if($("#student_photo_"+[i]+" .attendphoto").attr("class")=="attendphoto"){
						$("#student_photo_"+[i]+" .attendphoto").removeClass("attendphoto").addClass("attendphoto");
						$("#student_photo_"+[i]+" .attendfont").removeClass("attendfont").addClass("attendfont");
						statusList[i] = studentStatus.split("'")[3]+"|"+studentStatus.split("'")[5]+"|"+"G023C002";
					}else if($("#student_photo_"+[i]+" .latephoto").attr("class")=="latephoto"){
						$("#student_photo_"+[i]+" .latephoto").removeClass("latephoto").addClass("attendphoto");
						$("#student_photo_"+[i]+" .latefont").removeClass("latefont").addClass("attendfont");
						statusList[i] = studentStatus.split("'")[3]+"|"+studentStatus.split("'")[5]+"|"+"G023C002";
					}else if($("#student_photo_"+[i]+" .cutphoto").attr("class")=="cutphoto"){
						$("#student_photo_"+[i]+" .cutphoto").removeClass("cutphoto").addClass("attendphoto");
						$("#student_photo_"+[i]+" .cutfont").removeClass("cutfont").addClass("attendfont");
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
	
	        url: "${pageContext.request.contextPath}/prof/class/class_view_update",
	
	        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
	
	        success: function(msg) {
	        	statusList = new Array();
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
	    width:500,
	    height:600,
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
	    width:360,
	    height:400,
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
	    width:310,
	    height:380,
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
	    width:310,
	    height:380,
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
    width:310,
    height:380,
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

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 교수 강의출결 상세정보 -->
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom">
      <img src="${pageContext.request.contextPath}/resources/images/prof/professor_class_title_02.png"  alt="강의출결 상세정보 타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;강의출결 &nbsp; <img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp; 강의출결 상세정보</td>
    </tr>
  </table>
</div>

<!-- 15주차가 보강주로 인해 16주차에 강의가 생성됨으로 표시를 16이 아닌 15로 표시되도록 함 -->
<c:set var="view_week" value="${am.curr_week}" />
<c:if test="${view_week eq '16'}">
	<c:set var="view_week" value="${view_week - 1}" />
</c:if>
<p style="color: red; padding: 10px 0 0 5px; font-weight: bold;">* (장기) - 수업당 결석수(총결석수/시수)가 2회 이상인 학생의 경우 학번 옆에 표시됩니다.</p>
<table width="700" border="0" cellpadding="0" cellspacing="0" class="classinfobg">
  <tr>
    <td align="center" valign="middle"><table width="658" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="331" height="30" align="left"><img src="${pageContext.request.contextPath}/resources/images/prof/cross_icon.png" width="9" height="9" alt="아이콘" /> 
        	&nbsp;강의일 : ${am.classday} <fmt:formatDate value="${am.classday}" type="time" pattern="(E)"/> ${am.classhour_start_time } ~ ${am.classhour_end_time }
			<c:if test="${am.curr_week ne null && !empty am.curr_week}">(${view_week}주)</c:if>        	
        </td>
        <td width="331" align="left"><img src="${pageContext.request.contextPath}/resources/images/prof/cross_icon.png" width="9" height="9" alt="아이콘" /> &nbsp;단 과 : ${am.prof_coll_name }</td>
      </tr>
      <tr>
        <td height="30" align="left"><img src="${pageContext.request.contextPath}/resources/images/prof/cross_icon.png" width="9" height="9" alt="아이콘" /> &nbsp;교수명 : ${am.prof_name }</td>
        <td align="left"><img src="${pageContext.request.contextPath}/resources/images/prof/cross_icon.png" width="9" height="9" alt="아이콘" /> &nbsp;개설학과 : ${am.prof_dept_name }</td>
      </tr>
      <tr align="left">
      	<c:set var="varColSpan" value="colspan='2'" />
      	<c:if test="${am.cert_sts_cd=='G021C002' && am.cert_type eq 'CERT_NUM'}">
      		<c:set var="varColSpan" value="" />
      	</c:if>
        <td height="30" ${varColSpan}><img src="${pageContext.request.contextPath}/resources/images/prof/cross_icon.png" width="9" height="9" alt="아이콘" /> &nbsp;강의명 : ${am.class_name } (${am.classroom_no})</td>
        
        <c:if test="${varColSpan eq ''}">
        <td height="30"><img src="${pageContext.request.contextPath}/resources/images/prof/cross_icon.png" width="9" height="9" alt="아이콘" /> &nbsp;인증번호 : ${am.class_cert_no }</td>
        </c:if>
      </tr>
      <tr>
        <td height="30" align="left"><img src="${pageContext.request.contextPath}/resources/images/prof/cross_icon.png" width="9" height="9" alt="아이콘" /> &nbsp;강의코드 : ${am.subject_cd}-${am.subject_div_cd }</td>
        <td align="right">
        <!-- 강의중 -->
        <c:if test="${am.class_type_cd ne 'G019C002' and am.class_sts_cd=='G020C002'}">
        	<!-- 2015.02.02 (인증처리 하도록 수정)
			- 인증요청 전인 경우 항상 강의인증 버튼 표시
			- 인증요청 후인 경우  
			- CERT_TYPE이 CERT_NUM인 경우만 강의인증 버튼 표시
			- CERT_TYPE이 PROF_AUTH인 경우 강의중으로 표시
        	-->
        	<c:if test="${am.cert_sts_cd=='G021C001' }">
	        	<button onclick="certType('${class_cd}','${classday}','${classhour_start_time}','${am.cert_sts_cd }')"><img src="${pageContext.request.contextPath}/resources/images/prof/class_button_08.png"  alt="강의시작 버튼" /></button>
        	</c:if>
	        <c:if test="${am.cert_sts_cd=='G021C002' && am.cert_type eq 'CERT_NUM'}">
	        	<button onclick="certLecture('${class_cd}','${classday}','${classhour_start_time}','${am.cert_sts_cd }')"><img src="${pageContext.request.contextPath}/resources/images/prof/class_button_09.png"  alt="인증코드 버튼" /></button>
			</c:if>	               
		</c:if>
		<c:if test="${am.cert_sts_cd != 'G021C002'}">
			<c:if test="${makeup_lesson eq 'Y' and am.classoff_yn eq 'Y' }">
				<c:if test="${am.class_type_cd == 'G019C001'}">
					<!-- 보강처리를 하지 않는 경우 버튼 제거 -->        	
	     			<button onclick="skipLecture('${class_cd}','${classday}','${classhour_start_time}','${am.class_prog_cd }','${am.classroom_no}')">		     			
	        			<img src="${pageContext.request.contextPath}/resources/images/prof/class_button_02.png" alt="휴강처리 버튼" />
	      			</button>
				</c:if>
				<%--c:if test="${am.class_type_cd == 'G019C002' and am.class_prog_cd != 'G018C004' and am.before_classday > toDay }"--%>
				<c:if test="${am.class_type_cd == 'G019C002' and am.class_prog_cd != 'G018C004'}">
			 		<button onclick="restoreClass('${class_cd}', '${classday}', '${classhour_start_time}', '${am.class_type_cd}', '${am.before_classday}')">
			 			<img src="${pageContext.request.contextPath}/resources/images/prof/button_cancel_off.png">
			 		</button>
				</c:if>
				<%--c:if test="${am.class_type_cd == 'G019C003' and am.classday > toDay }"--%>
				<c:if test="${am.class_type_cd == 'G019C003'}">
			 		<button onclick="restoreClass('${class_cd}', '${classday}', '${classhour_start_time}', '${am.class_type_cd}', '${am.before_classday}')">
			 			<img src="${pageContext.request.contextPath}/resources/images/prof/button_cancel_add.png">
			 		</button>
				</c:if>
			</c:if>			
		</c:if>
        </td>
      </tr>
    </table>
      <table width="662" border="0" cellpadding="0" cellspacing="0" class="classgraybg">
        <tr>
          <td colspan="2">총인원 : <span id="span_attendee_cnt">${am.attendee_cnt }</span>명</td>
          <td><img src="${pageContext.request.contextPath}/resources/images/prof/blue_icon.png" alt="출석아이콘" /></td>
          <td align="left">출석 : <span id="span_attend_present_cnt">${am.attend_present_cnt }</span>명</td>
          <td><img src="${pageContext.request.contextPath}/resources/images/prof/yellow_icon.png"  alt="결석아이콘" /></td>
          <td align="left">지각 : <span id="span_attend_late_cnt">${am.attend_late_cnt }</span>명</td>
          <td><img src="${pageContext.request.contextPath}/resources/images/prof/red_icon.png"  alt="결석아이콘" /></td>
          <td align="left">결석 : <span id="span_attend_absent_cnt">${am.attend_absent_cnt }</span>명</td>
          <c:if test="${am.cert_sts_cd=='G021C002' && am.cert_type eq 'CERT_NUM'}">
	          <td><img src="${pageContext.request.contextPath}/resources/images/prof/blue_icon.png" /></td>
	          <td align="left">앱 실행 : ${attendAppInfo.app_exec}명</td>
          </c:if>
        </tr>
        <tr>
          <td><img src="${pageContext.request.contextPath}/resources/images/prof/pupple_icon.png" alt="공결아이콘" /></td>
          <td align="left">공결 : <span id="span_attend_gonggyul_cnt">&nbsp;</span>명</td>
          <td><img src="${pageContext.request.contextPath}/resources/images/prof/white_icon.png" alt="결석아이콘" /></td>
          <td align="left">출결전 : <span id="span_attend_before_cnt">&nbsp;</span>명</td>
          <td><img src="${pageContext.request.contextPath}/resources/images/prof/gray_icon.png" alt="결석아이콘" /></td>
          <td align="left">휴학 : <span id="span_attend_off_cnt">${am.attend_off_cnt }</span>명</td>
          <td><img src="${pageContext.request.contextPath}/resources/images/prof/deepgray_icon.png" alt="결석아이콘" /></td>
          <td align="left">제적 : <span id="span_attend_quit_cnt">${am.attend_quit_cnt }</span>명</td>
          <c:if test="${am.cert_sts_cd=='G021C002' && am.cert_type eq 'CERT_NUM'}">
	          <td><a onclick="$('#dialog_apperror_list').dialog('open')"><img src="${pageContext.request.contextPath}/resources/images/prof/red_icon.png" style="cursor:pointer" /></a></td>
	          <td align="left">상태이상 : <a onclick="$('#dialog_apperror_list').dialog('open')" style="cursor:pointer">${attendAppInfo.app_error}명</a></td>
          </c:if>
        </tr>
      </table>
      <table width="658" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="35" align="left"><img src="${pageContext.request.contextPath}/resources/images/prof/cross_icon.png" width="9" height="9" alt="아이콘" /> &nbsp;강의상태 : ${am.class_sts_name }</td>
          <td align="left"><img src="${pageContext.request.contextPath}/resources/images/prof/cross_icon.png" width="9" height="9" alt="아이콘" />
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
          <td align="left"><img src="${pageContext.request.contextPath}/resources/images/prof/cross_icon.png" width="9" height="9" alt="아이콘" /> &nbsp;직권처리인원 : ${fn:length(attendAuthorityDetailList) }명</td>
          <td width="78" align="right"><a onclick="$('#dialog_authority_list').dialog('open')"><img src="${pageContext.request.contextPath}/resources/images/prof/class_button_03.png" width="78" height="27" alt="내역보기버튼" /></a></td>
        </tr>
      </table></td>
  </tr>
</table>
<br />

<table width="699" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="right" valign="bottom">
    	<button style="margin:0 0 0 5px;" onclick="javascript:location.reload();"><img src="${pageContext.request.contextPath}/resources/images/prof/button_reload2.png" height="27" alt="새로고침버튼"></button>
    	
    	<c:if test="${attendMaster.class_adm_cd=='G027C001'}">
	   		<button style="margin:0 5px 0 5px;" onclick="javascript:chgAllStatus()"><img src="${pageContext.request.contextPath}/resources/images/prof/attendbatch_button.png" width="72" height="27" alt="일괄출석버튼"></button>
	    	<button id="send_update" onclick="sendUpdate();"><img src="${pageContext.request.contextPath}/resources/images/prof/class_button_07.png" width="78" height="27" alt="출결저장버튼" /></button>
	    	<c:if test="${isUninterruptLecture == 'true' }">
				<button id="attend_copy" onclick="attendCopy('${class_cd}','${classday}','${classhour_start_time}')" style="margin:0 5px 0 5px;"><img src="${pageContext.request.contextPath}/resources/images/prof/class_button_06.png" width="99" height="27" alt="연강출결처리버튼" /></button>
			</c:if>
		</c:if>
		
    	<a href="javascript:javascript:history.back(-1)"><img src="${pageContext.request.contextPath}/resources/images/prof/list_button.png" width="61" height="27" alt="목록버튼" /></a>&nbsp;</td>
  </tr>
  <tr>
    <td valign="middle" class="phototop">&nbsp;&nbsp;
    	<img src="${pageContext.request.contextPath}/resources/images/prof/class_mouse_icon.png" width="25" height="22" alt="마우스아이콘" />
    	 사진을 클릭하시면 출석 &gt; 지각 &gt; 결석이 반전되며 처리 됩니다.
    </td>
  </tr>
  <tr>
    <td height="313" align="center" valign="top" class="photobg">
	    <div class="photobox">
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
					    <c:set var="val_attendphoto_style" value="gonggyulphoto" />
					    <c:set var="val_attendfont_style" value="gonggyulfont" />
			    	</c:when>
			    	
			    	<%-- 휴강시 (경동대만 추가 2017.04.17) --%>
			    	<c:when test="${list.class_type_cd == 'G019C002'}">
			    		<c:set var="val_attendee_before_cnt" value="${val_attendee_before_cnt + 1}" />
						<c:set var="val_attendphoto_style" value="beforephoto" />
			    		<c:set var="val_attendfont_style" value="beforefont" />
			    	</c:when>
			    	
			    	<%-- 그외 상황 --%>
			    	<c:otherwise>
			    		<c:choose>
			    			
			    			<%-- 출결전 --%>
						    <c:when test="${list.attend_sts_cd=='G023C001' and (list.student_sts_cd ne 'G012C002' and list.student_sts_cd ne 'G012C005') }">
								<c:set var="val_attendee_before_cnt" value="${val_attendee_before_cnt + 1}" />
								<c:set var="val_attendphoto_style" value="beforephoto" />
					    		<c:set var="val_attendfont_style" value="beforefont" />
						    </c:when>
						    
						    <%-- 출결 --%>
						    <c:when test="${list.attend_sts_cd=='G023C002' }">    	
								<c:set var="val_attendee_present_cnt" value="${val_attendee_present_cnt + 1}" />
							    <c:set var="val_attendphoto_style" value="attendphoto" />
					    		<c:set var="val_attendfont_style" value="attendfont" />
						    </c:when>
						    
						    <%-- 지각 --%>
						    <c:when test="${list.attend_sts_cd=='G023C003' }">
								<c:set var="val_attendee_late_cnt" value="${val_attendee_late_cnt + 1}" />
								<c:set var="val_attendphoto_style" value="latephoto" />
					    		<c:set var="val_attendfont_style" value="latefont" />
						    </c:when>
						    
						    <%-- 결석 --%>
						    <c:when test="${list.attend_sts_cd=='G023C004' }">
								<c:set var="val_attendee_absent_cnt" value="${val_attendee_absent_cnt + 1}" />
							    <c:set var="val_attendphoto_style" value="cutphoto" />
					    		<c:set var="val_attendfont_style" value="cutfont" />
						    </c:when>
						    
						    <%-- 휴학 --%>
						    <c:when test="${list.attend_sts_cd=='G023C005' or list.student_sts_cd eq 'G012C002'}">
								<c:set var="val_attendee_off_cnt" value="${val_attendee_off_cnt + 1}" />
								<c:set var="val_attendphoto_style" value="timeoffphoto" />
					    		<c:set var="val_attendfont_style" value="timeofffont" />
						    </c:when>
						    
						    <%-- 제적 --%>
						    <c:when test="${list.attend_sts_cd=='G023C007' or list.student_sts_cd eq 'G012C005'}">
								<c:set var="val_attendee_quit_cnt" value="${val_attendee_quit_cnt + 1}" />
								<c:set var="val_attendphoto_style" value="leavephoto" />
					    		<c:set var="val_attendfont_style" value="leavefont" />
						    </c:when>
						    
			    		</c:choose>
			    	</c:otherwise>
			    </c:choose>
			    
				<table class="phototable" border="0" cellpadding="0" cellspacing="0" id="student_photo_${list.row_no }" onclick="chgStatus('${list.row_no }','${list.student_no}', '${list.attend_sts_cd }', '${list.student_sts_cd}')" style="cursor: pointer;">
				  <tr>
				    <td valign="middle" class="${val_attendphoto_style}">
				    	<img src="${student_photo}" width="75" height="100" alt="사진" />
				    </td>
				  </tr>
				  <tr>
				    <td class="${val_attendfont_style}" style="height: 69px;">
				    	${fn:substring(list.student_dept_name,0,5)}<br/>
				    	${list.student_no }<c:if test="${list.abs_cnt ne null}">(장기)</c:if><br/>
				      	<font style="font-size:14px; font-weight:bold;">${list.student_name }</font><br/>
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
    </td>
  </tr>
  <tr>
    <td><img src="${pageContext.request.contextPath}/resources/images/prof/class_photobg_bottom.png" width="699" height="26" alt="포토박스아래" /></td>
  </tr>
  <tr>
    <td height="45" align="right" valign="bottom">
    	<button style="margin:0 0 0 5px;" onclick="javascript:location.reload();"><img src="${pageContext.request.contextPath}/resources/images/prof/button_reload2.png" height="27" alt="새로고침버튼"></button>
    	
    	<c:if test="${attendMaster.class_adm_cd=='G027C001'}">
		 	<button id="send_update" style="margin:0 0 0 5px;" onclick="sendUpdate();"><img src="${pageContext.request.contextPath}/resources/images/prof/class_button_07.png" width="78" height="27" alt="출결저장버튼" /></button>
	    	<c:if test="${isUninterruptLecture == 'true' }">
				<button id="attend_copy" onclick="attendCopy('${class_cd}','${classday}','${classhour_start_time}')" style="margin:0 5px 0 5px;"><img src="${pageContext.request.contextPath}/resources/images/prof/class_button_06.png" width="99" height="27" alt="연강출결처리버튼" /></button>
			</c:if>
		</c:if>
    	
    	<a href="javascript:javascript:history.back(-1)"><img src="${pageContext.request.contextPath}/resources/images/prof/list_button.png" width="61" height="27" alt="목록버튼" /></a>&nbsp;</td>
  </tr>
</table>

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
<!-- 직권처리 내역 -->
<div id="dialog_authority_list" title="수강자 출결 내역">
    <table border="0" cellspacing="0" cellpadding="0" class="tstyle_col1">
      <tr>
        <th>이름</th>
        <th>학번</th>
        <th>처리시간</th>
        <th>처리사유</th>
      </tr>
      <c:forEach var="list" items="${attendAuthorityDetailList }">
        <tr>
          <td>${list.student_name }</td>
          <td>${list.student_no }</td>
          <td><fmt:formatDate value="${list.attend_auth_proc_time}" type="both" pattern="yyyy-MM-dd (E) HH:mm"/></td>
          <td class="tdwhitenone">${list.attend_sts_name }<br/>${list.attend_auth_reason_name }</td>
        </tr>
      </c:forEach>
      <c:if test="${empty attendAuthorityDetailList }">
        <tr>
          <td colspan="4">데이터가 존재하지 않습니다.</td>
        </tr>
      </c:if>
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
	<div style="width:96%;height:96%;" class="graybackbold">
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
<!-- //교수 강의출결상세보기 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
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
