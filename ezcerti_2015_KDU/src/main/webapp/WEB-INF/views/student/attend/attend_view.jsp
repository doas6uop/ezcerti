<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/student_style.css">

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
	$(".menu22 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_attend_on.gif");
	$(".menu22 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_attend_on.gif");
});
function studentClaim(class_cd, classday, classhour_start_time){
	$("#dialog_student_claim1").load('${pageContext.request.contextPath}/student/attend/attend_claim',{class_cd:class_cd, classday:classday, classhour_start_time:classhour_start_time});
	$("#dialog_student_claim1").dialog("open");
}
function studentImprove(class_cd, classday, classhour_start_time){
	$("#dialog_student_improve1").load('${pageContext.request.contextPath}/student/attend/attend_improve',{class_cd:class_cd, classday:classday, classhour_start_time:classhour_start_time});
	$("#dialog_student_improve1").dialog("open");
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
$(function() {
	  $( "#dialog_student_improve1" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    width:310,
	    height:280,
	    modal: true,
	    buttons: {
	      "확인": function() {
	    	var r=confirm("개선사항 요청 하시겠습니까?");
	        $( this ).dialog( "close" );
	    	if (r==true)
	    	  {
	    		var postString = $("#frm_claim").serialize();
	    		
	    	    $.ajax({
	    	        type: "POST",
	    	
	    	        url: "${pageContext.request.contextPath}/student/attend/attend_improve_confirm",
	    	
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

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 학생 강의출결 상세정보 -->
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/student/professor_class_title_02.png" alt="강의출결상세정보 타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/student/home_icon.png" width="22" height="12" alt="홈아이콘" />  &nbsp; 강의출결 &nbsp;  <img src="${pageContext.request.contextPath}/resources/images/student/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp; 강의출결상세정보</td>
    </tr>
  </table>
</div>
<table width="699" border="0" cellpadding="0" cellspacing="0" class="studentclassbg">
  <tr>
    <td align="center" valign="middle"><table width="658" border="0" cellspacing="0" cellpadding="0">
    <tr align="left">
        <td height="30" colspan="2"><img src="${pageContext.request.contextPath}/resources/images/student/cross_icon.png" width="9" height="9" alt="아이콘" /> &nbsp;강의명 : ${lectureDetail.class_name } (${lectureDetail.classroom_no})</td>
      </tr>
      <tr>
        <td width="331" height="30" align="left"><img src="${pageContext.request.contextPath}/resources/images/student/cross_icon.png" width="9" height="9" alt="아이콘" />&nbsp; 강의일시 : ${lectureDetail.classday_name }요일 ${lectureDetail.classhour_start_time } ~ ${lectureDetail.classhour_end_time}</td>
        <td width="331" align="left"><img src="${pageContext.request.contextPath}/resources/images/student/cross_icon.png" width="9" height="9" alt="아이콘" /> &nbsp;교수명 : ${lectureDetail.prof_name }</td>
      </tr>
      <tr>
        <td height="30" align="left"><img src="${pageContext.request.contextPath}/resources/images/student/cross_icon.png" width="9" height="9" alt="아이콘" /> &nbsp;개설단과 : ${lectureDetail.prof_coll_name }</td>
        <td align="left"><img src="${pageContext.request.contextPath}/resources/images/student/cross_icon.png" width="9" height="9" alt="아이콘" /> &nbsp;개설학과 : ${lectureDetail.prof_dept_name}</td>
      </tr>
           
    </table>
      <table width="662" border="0" cellpadding="0" cellspacing="0" class="studentgraybg">
        <tr>
          <td align="center"><img src="${pageContext.request.contextPath}/resources/images/student/white_icon.png" width="25" height="25" alt="출결전아이콘" /></td>
          <td align="left">출결전 <span id="span_attend_before_cnt">&nbsp;</span><%-- ${studentAttendCnt.BEFORE_CNT } --%>건</td>
          <td align="center"><img src="${pageContext.request.contextPath}/resources/images/student/blue_icon.png" width="25" height="25" alt="출석아이콘" /></td>
          <td align="left">출석 <span id="span_attend_present_cnt">&nbsp;</span><%-- ${studentAttendCnt.PRESENT_CNT } --%>건</td>
          <td align="center"><img src="${pageContext.request.contextPath}/resources/images/student/yellow_icon.png" width="25" height="25" alt="지각아이콘" /></td>
          <td align="left">지각 <span id="span_attend_late_cnt">&nbsp;</span><%-- ${studentAttendCnt.LATE_CNT } --%>건</td>
          <td align="center"><img src="${pageContext.request.contextPath}/resources/images/student/red_icon.png" width="25" height="25" alt="결석아이콘" /></td>
          <td align="left">결석 <span id="span_attend_absent_cnt">&nbsp;</span><%-- ${studentAttendCnt.ABSENT_CNT } --%>건</td>
        </tr>
    </table></td>
  </tr>
</table>

<div class="photobox">
	<c:forEach var="list" items="${attendDetailHistoryList }">
		<table class="phototable" border="0" cellpadding="0" cellspacing="0" style="margin-bottom:5px;">
		
			<c:choose>
			
		    	<%-- 공결시 --%>
		    	<c:when test="${list.class_type_cd!='G019C002' and list.reg_etc != null and list.reg_etc == 'GONGGYUL'}">
		    		<c:set var="val_attendee_gonggyul_cnt" value="${val_attendee_gonggyul_cnt + 1}" />
				    <c:set var="attendTopStyle" value="puppletop" /> 
					<c:set var="attendBottomStyle" value="pupplebottom" /> 
		    	</c:when>
		    	
		    	<%-- 그외 상황 --%>
		    	<c:otherwise>
		    		<c:choose>
		    			
		    			<%-- 출결전 / 정상 --%>
					    <c:when test="${list.attend_sts_cd=='G023C001'&&list.class_type_cd=='G019C001' }">
							<c:set var="val_attendee_before_cnt" value="${val_attendee_before_cnt + 1}" />
							<c:set var="attendTopStyle" value="whitetop" />
				    		<c:set var="attendBottomStyle" value="whitebottom" />
					    </c:when>
					    
					    <%-- 출결전 / 휴강 --%>
					    <c:when test="${list.attend_sts_cd=='G023C001'&&list.class_type_cd=='G019C002' }">
							<c:set var="attendTopStyle" value="graytop" />
				    		<c:set var="attendBottomStyle" value="graybottom" />
					    </c:when>
					    
					   	<%-- 출결전 / 보강 --%>
					    <c:when test="${list.attend_sts_cd=='G023C001'&&list.class_type_cd=='G019C003' }">
							<c:set var="val_attendee_before_cnt" value="${val_attendee_before_cnt + 1}" />
							<c:set var="attendTopStyle" value="graytop" />
				    		<c:set var="attendBottomStyle" value="graybottom" />
					    </c:when>
					    
					    <%-- 출결 --%>
					    <c:when test="${list.attend_sts_cd=='G023C002' }">    	
							<c:set var="val_attendee_present_cnt" value="${val_attendee_present_cnt + 1}" />
						    <c:set var="attendTopStyle" value="bluetop" /> 
							<c:set var="attendBottomStyle" value="bluebottom" /> 
					    </c:when>
					    
					    <%-- 지각 --%>
					    <c:when test="${list.attend_sts_cd=='G023C003' }">
							<c:set var="val_attendee_late_cnt" value="${val_attendee_late_cnt + 1}" />
							
							<c:set var="attendTopStyle" value="yellowtop" /> 
							<c:set var="attendBottomStyle" value="yellowbottom" /> 
					    </c:when>
					    
					    <%-- 결석 --%>
					    <c:when test="${list.attend_sts_cd=='G023C004'&&list.class_type_cd!='G019C002' }">
							<c:set var="val_attendee_absent_cnt" value="${val_attendee_absent_cnt + 1}" />
						    
						    <c:set var="attendTopStyle" value="redtop" /> 
							<c:set var="attendBottomStyle" value="redbottom" /> 
					    </c:when>
					    
		   				<%-- 휴강시 결석 (경동대만 추가 2017.04.17) --%>
					    <c:when test="${list.attend_sts_cd=='G023C004'&&list.class_type_cd=='G019C002' }">
							<c:set var="attendTopStyle" value="graytop" />
				    		<c:set var="attendBottomStyle" value="graybottom" />
					    </c:when>
					    
					    <%-- 휴학/제적 --%>
					    <c:otherwise>
						    <c:set var="attendTopStyle" value="redtop" /> 
							<c:set var="attendBottomStyle" value="redbottom" /> 
					    </c:otherwise>
		    		</c:choose>
		    	</c:otherwise>
		    </c:choose>
		
			<tr>
			    <td class="${attendTopStyle }"><fmt:formatDate value="${list.classday}" pattern="yyyy-MM-dd"/><br />
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
								<td class="graybottom">보강일<br>
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
										<c:set var="attendBottomStyle2" value="pupplebottom" /> 							
									</c:when>
									<c:otherwise>
										<c:set var="attendBottomStyle2" value="graybottom" /> 							
									</c:otherwise>
								</c:choose>
								
								<td class="${attendBottomStyle2 }">휴강일<br>
								<c:if test="${empty list.before_classday}">없음</c:if>
								<c:if test="${not empty list.before_classday}"><fmt:formatDate value="${list.before_classday }" pattern="yyyy-MM-dd"/></c:if>
								<br/>${list.attend_sts_name }
								</td>
							</tr>
		    			</c:when>
		    			
		    			<%-- 정상 --%>
			    		<c:otherwise>
							<tr>
							    <td class="${attendBottomStyle }">${list.class_sts_name }<br />
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
								<td class="graybottom">보강일<br>
									<c:if test="${empty list.before_classday}">없음</c:if>
									<c:if test="${not empty list.before_classday}"><fmt:formatDate value="${list.before_classday }" pattern="yyyy-MM-dd"/></c:if>
								</td>
							</tr>
		    			</c:when>
		    			
		    			<c:otherwise>
				    		<tr>
							    <td class="${attendBottomStyle }">${list.class_sts_name }<br />
									${list.attend_sts_name }
							    </td>
						    </tr>
					    </c:otherwise>
				    </c:choose>
		    	</c:otherwise>
		    </c:choose>
		    
			<c:choose>
				<c:when test="${lectureDetail.class_adm_cd == 'G027C001' && (list.class_type_cd!='G019C002'&&(list.attend_sts_cd=='G023C003'||list.attend_sts_cd=='G023C004'))}">
					<tr height="28px">
						<td align="center" style="padding:2px 0 0 0">
							<button onclick="studentClaim('${list.class_cd}','${list.classday }','${list.classhour_start_time}')">
								<img src="${pageContext.request.contextPath}/resources/images/student/claim_button.png" width="73" height="20px" alt="이의신청버튼" />
							</button>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr height="28px">
						<td align="center">
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
			<!-- 
			<c:choose>
			<c:when test="${list.attend_sts_cd=='G023C003'||list.attend_sts_cd=='G023C002'}">
			<tr height="28px">
			<td align="center" style="padding:2px 0 0 0">
				<button onclick="studentImprove('${list.class_cd}','${list.classday }','${list.classhour_start_time}')">
					<img src="${pageContext.request.contextPath}/resources/images/student/improve_button.png" width="73" height="20px" alt="강의개선버튼" />
				</button>
			</td>
			</tr>
			</c:when>
			<c:otherwise>
			<tr height="28px">
				<td align="center">
				</td>
			</tr>
			</c:otherwise>
			</c:choose>
			-->
		</table>
	</c:forEach>
</div>
<br>
<div class="alignright" style="text-align:center;">
	<a href="javascript:window.location.href=parent.document.referrer;">
		<img src="${pageContext.request.contextPath}/resources/images/student/list_button.png" width="61" height="27" alt="목록버튼" />
	</a>
</div>
<div id="dialog_student_claim1" title="이의신청"></div>
<!-- //학생 강의출결 상세정보 -->
</div>
<div id="dialog_student_improve1" title="개선사항"></div>
<!-- //학생 강의출결 상세정보 -->
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
