<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prof_style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">
<script>
$(document).ready(function(){
	$(".menu13 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_attendee_on.gif");
	$(".menu13 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_attendee_on.gif");
	
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

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 교수 수강생상세보기 -->
<spring:eval expression="@config['user_image_path']" var="user_image_path"/>

<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof//professor_attendee_title_02.png" alt="수강생목록 타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof//home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;수강생&nbsp;  <img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp; 수강생 상세보기</td>
    </tr>
  </table>
  </div>
  
    <div class="round_box_top mg_t30 float_left"></div>
    <div class="round_box_center float_left">
    
		<c:set var="varStudentYear" value="${student.iphak_year}" />
    
    	<c:choose>
	    	<c:when test="${student.student_img eq null}">
	    		<c:set var="student_photo" value="${pageContext.request.contextPath}/resources/images/noimage.jpg" />
	    	</c:when>
	    	<c:otherwise>
	    		<c:set var="student_photo" value="${user_image_path}?platformType=nexacro&method=view&f0=${student.student_img}" />
	    	</c:otherwise>
    	</c:choose>
    
        <div class="photo_area"><img src="${student_photo}" width="79" height="101" alt="사진이미지" /></div>
        <div class="info_area">
            <table border="0" cellpadding="0" cellspacing="0" class="tstyle_row1">
              <tr>
                <th>학생명</th>
                <td >${student.student_name }</td>
              </tr>
              <tr>
                <th>학번</th>
                <td>${student.student_no }</td>
              </tr>
              <tr>
                <th>단과</th>
                <td>${student.coll_name }</td>
              </tr>
              <tr>
                <th>학과</th>
                <td>${student.dept_name }</td>
              </tr>
              <tr>
                <th>연락처</th>
                <td>${student.hp_no} </td>
              </tr>
              <%--
              <tr>
                <th>국적</th>
                <td>${student.nation_name}</td>
              </tr>
              --%>
              <tr>
                <th>이메일</th>
                <td>${student.email_addr }</td>
              </tr>
              <tr>
                <th>상태</th>
                <td>${student.student_sts_name }/${student.student_grade_name }</td>
              </tr>
            </table>
        </div>
      </div>
      <div class="round_box_bottom float_left"></div>
      
      
      <h4><img src="${pageContext.request.contextPath}/resources/images/content/attendee_h4.gif" alt="강의 출석부" class="mg_t40" /></h4>
      <div class="round_box_top mg_t10 float_left"></div>
      <div class="round_box_center float_left">
      	<p class="f14 bold border-dashed pd_b10 mg_b20">${lecture.class_name } (${lecture.subject_cd }-${lecture.subject_div_cd }), ${lecture.classday_name }요일 ${lecture.classhour_start_time } ~ ${lecture.classhour_end_time }</p>
        <ul class="attend_box">
        	<c:forEach var="list" items="${attendDetail}">
        		<c:choose>
        			
        			<%-- 휴강시 (경동대만 추가 2017.04.17) --%>
			    	<c:when test="${list.class_type_cd == 'G019C002'}">
			    		<li class="pre_attend">
			                <p><fmt:formatDate value="${list.classday}" type="date" pattern="MM/dd"/>(${list.curr_week }주)</p>
		                	<p class="mg_t25">휴강</p>
						</li>
			    	</c:when>
			    	
			    	<%-- 그외 상황 --%>
			    	<c:otherwise>
			    		<c:if test="${list.attend_sts_cd=='G023C001' }">
			        	<li class="pre_attend">
			                <p><fmt:formatDate value="${list.classday}" type="date" pattern="MM/dd"/>(${list.curr_week }주)</p>
		                	<p class="mg_t25"><img src="${pageContext.request.contextPath}/resources/images/content/pre_attend_btn.gif" alt="출석전" /></p>
						</li>
		                </c:if>
						<c:if test="${list.attend_sts_cd=='G023C002' }">
			        	<li class="attend">
			                <p><fmt:formatDate value="${list.classday}" type="date" pattern="MM/dd"/>(${list.curr_week }주)</p>
							<p class="mg_t25"><img src="${pageContext.request.contextPath}/resources/images/content/attend_btn.gif" alt="출석" /></p>
						</li>
						</c:if>
						<c:if test="${list.attend_sts_cd=='G023C003' }">
			        	<li class="late">
			                <p><fmt:formatDate value="${list.classday}" type="date" pattern="MM/dd"/>(${list.curr_week }주)</p>
							<p class="mg_t25"><img src="${pageContext.request.contextPath}/resources/images/content/late_btn.gif" alt="지각" /></p>
						</li>
						</c:if>
						<c:if test="${list.attend_sts_cd=='G023C004' }">
			        	<li class="absence">
			                <p><fmt:formatDate value="${list.classday}" type="date" pattern="MM/dd"/>(${list.curr_week }주)</p>
							<p class="mg_t25"><img src="${pageContext.request.contextPath}/resources/images/content/absence_btn.gif" alt="결석" /></p>
						</li>
						</c:if>
						<c:if test="${list.attend_sts_cd=='G023C005' }">
			        	<li class="absence">
			                <p><fmt:formatDate value="${list.classday}" type="date" pattern="MM/dd"/>(${list.curr_week }주)</p>
							<p class="mg_t25"><img src="${pageContext.request.contextPath}/resources/images/content/absence_btn.gif" alt="결석" /></p>
						</li>
						</c:if>
						<c:if test="${list.attend_sts_cd=='G023C007' }">
			        	<li class="absence">
			                <p><fmt:formatDate value="${list.classday}" type="date" pattern="MM/dd"/>(${list.curr_week }주)</p>
							<p class="mg_t25"><img src="${pageContext.request.contextPath}/resources/images/content/absence_btn.gif" alt="결석" /></p>
						</li>
						</c:if>    
			    	</c:otherwise>
        			
        		</c:choose>
            </li>
        	</c:forEach>
        </ul>
      </div>
      <div class="round_box_bottom float_left"></div>

<div class="alignright float_left" style="text-align:center;">
	<!-- a href="javascript:window.location.href=parent.document.referrer;"-->
	<a href="javascript:history.back();">	
		<img src="${pageContext.request.contextPath}/resources/images/prof/list_button.png" width="61" height="27" alt="목록버튼" />
	</a>
</div>
<!-- //교수 수강생상세보기 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

