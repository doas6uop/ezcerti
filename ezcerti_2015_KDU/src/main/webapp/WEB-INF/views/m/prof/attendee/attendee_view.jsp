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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_m/css/smoothness/jquery-ui-1.10.3.custom.css">
<script>
$(document).ready(function(){
	$("#topmenu_03").removeClass('submenugrayfont').addClass('menubluefont');

	var otherImg = "";
	$('.photo_area img').error(function() {
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

});

</script>
</head>

<body bgcolor="#f0f0f0">
<div>
	<jsp:include page="../../header.jsp"></jsp:include>
</div>
<!-- 수강생 상세보기 -->
<spring:eval expression="@config['user_image_path']" var="user_image_path"/>

<div class="titlebox">
<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="아이콘"> &nbsp; 수강생 상세보기</div>
<div class="studentinfobg">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="25%" height="25" align="left" style="font-size:17px; font-weight:bold">${student.student_name }</td>
      <td width="60%" align="left" >${student.coll_name }</td>
      <td width="15%" rowspan="4" align="right" valign="middle">
      	<div class="photo_area">
      	
	      	<c:set var="varStudentYear" value="${student.iphak_year}" />
	    		
	    	<c:choose>
		    	<c:when test="${student.student_img eq null}">
		    		<c:set var="student_photo" value="${pageContext.request.contextPath}/resources/images/noimage.jpg" />
		    	</c:when>
		    	<c:otherwise>
					<c:set var="student_photo" value="${user_image_path}?platformType=nexacro&method=view&f0=${student.student_img}" />
		    	</c:otherwise>
	    	</c:choose>
      	
      		<img src="${student_photo}" style="max-width:70px;" alt="학생사진">
      	</div>
	  </td>
    </tr>
    <tr align="left">
      <td width="25%" height="25">${student.student_no }</td>
      <td width="60%" >${student.dept_name }</td>
    </tr>
    <tr align="left">
      <td width="25%" height="25">${student.student_sts_name }</td>
      <td width="60%">${student.hp_no}</td>
    </tr>
    <tr align="left">
      <td height="25%">${student.student_grade_name }</td>
      <td height="60%">${student.email_addr }</td>
    </tr>
  </table>
</div>
<div class="centerbutton">
	<!-- a href="javascript:window.location.href=parent.document.referrer;"-->
	<a href="javascript:history.back();">
		<img src="${pageContext.request.contextPath}/resources_m/images/attendee_button_04.png" style="max-width:50px;" alt="목록버튼">
	</a>
</div>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" class="graytable">
  <tr>
    <td height="25" align="center">${lecture.class_name }</td>
  </tr>
  <tr>
  	<td align="center">${lecture.subject_cd }-${lecture.subject_div_cd }</td>
  </tr>
  <tr>
  	<td align="center">${lecture.classday_name}요일 ${lecture.classhour_start_time } ~ ${lecture.classhour_end_time }</td>
  </tr>
</table>
<div class="tablebox">
	<c:forEach var="list" items="${attendDetail}">
		
		<c:choose>
   			<%-- 휴강시 (경동대만 추가 2017.04.17) --%>
		   	<c:when test="${list.class_type_cd == 'G019C002'}">
				<table width="127" cellpadding="0" cellspacing="0" class="phototable" >
					<tr>
						<td width="91" height="50" class="photogray">
						<fmt:formatDate value="${list.classday}" type="date" pattern="MM/dd"/>(${list.curr_week }주)
						</td>
					</tr>
					<tr>
						<td height="25" class="grayboxfont">휴강</td>
					</tr>
				</table>
		   	</c:when>
		   	
		   	<%-- 그외 상황 --%>
		   	<c:otherwise>
		   		
		   		<c:if test="${list.attend_sts_cd=='G023C001' }">
				<table width="127" cellpadding="0" cellspacing="0" class="phototable" >
				 <tr>
				 	<td width="91" height="50" class="photowhite">
						<fmt:formatDate value="${list.classday}" type="date" pattern="MM/dd"/>(${list.curr_week }주)
				 	</td>
				 </tr>
				 <tr>
				 	<td height="25" class="whiteboxfont">${list.attend_sts_name }</td>
				 </tr>
				 </table>
				</c:if>
				<c:if test="${list.attend_sts_cd=='G023C002' }">
				<table width="127" cellpadding="0" cellspacing="0" class="phototable" >
				 <tr>
				 	<td width="91" height="50" class="photoblue">
						<fmt:formatDate value="${list.classday}" type="date" pattern="MM/dd"/>(${list.curr_week }주)
					</td>
				 </tr>
				 <tr>
				 	<td height="25" class="blueboxfont">${list.attend_sts_name }</td>
				 </tr>
				 </table>
				</c:if>
				<c:if test="${list.attend_sts_cd=='G023C003' }">
				<table width="127" cellpadding="0" cellspacing="0" class="phototable" >
				 <tr>
				 	<td width="91" height="50" class="photoyellow">
						<fmt:formatDate value="${list.classday}" type="date" pattern="MM/dd"/>(${list.curr_week }주)
					</td>
				 </tr>
				 <tr>
				 	<td height="25" class="yellowboxfont">${list.attend_sts_name }</td>
				 </tr>
				 </table>
				</c:if>
				<c:if test="${list.attend_sts_cd=='G023C004' }">
				<table width="127" cellpadding="0" cellspacing="0" class="phototable" >
				 <tr>
				 	<td width="91" height="50" class="photored">
						<fmt:formatDate value="${list.classday}" type="date" pattern="MM/dd"/>(${list.curr_week }주)
					</td>
				 </tr>
				 <tr>
				 	<td height="25" class="redboxfont">${list.attend_sts_name }</td>
				 </tr>
				 </table>
				</c:if>
				<c:if test="${list.attend_sts_cd=='G023C005' }">
				<table width="127" cellpadding="0" cellspacing="0" class="phototable" >
				 <tr>
				 	<td width="91" height="50" class="photogray">
						<fmt:formatDate value="${list.classday}" type="date" pattern="MM/dd"/>(${list.curr_week }주)
					</td>
				 </tr>
				 <tr>
				 	<td height="25" class="grayboxfont">${list.attend_sts_name }</td>
				 </tr>
				 </table>
				</c:if>
				<c:if test="${list.attend_sts_cd=='G023C007' }">
				<table width="127" cellpadding="0" cellspacing="0" class="phototable" >
				 <tr>
				 	<td width="91" height="50" class="photodeepgray">
						<fmt:formatDate value="${list.classday}" type="date" pattern="MM/dd"/>(${list.curr_week }주)
					</td>
				 </tr>
				 <tr>
				 	<td height="25" class="deepgrayboxfont">${list.attend_sts_name }</td>
				 </tr>
				 </table>
				</c:if>
		   	
			</c:otherwise>
		</c:choose>
		
	</c:forEach>
<c:if test="${empty attendDetail }">
<table width="98%" height="100" border="0" cellpadding="0" cellspacing="0" class="subbluebox">
	<tr>
		<td align="center">데이터가 존재하지 않습니다.</td>
	</tr>
</table>
</c:if>
</div>  
<!-- //수강생 상세보기 -->
<div>
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
</body>
</html>
