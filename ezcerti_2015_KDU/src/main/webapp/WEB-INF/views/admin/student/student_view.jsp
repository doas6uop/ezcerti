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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">

<script>
$(document).ready(function(){
	$(".menu2 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_02.gif");
	$(".menu2 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_02.gif");

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
$(function() {
	  $( "#dialog_student_attend" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    width:750,
	    height:600,
	    modal: true,
	    beforeClose : function(){
	    	$("#dialog_student_attend .photobox").empty();
	    },
	    buttons: {
	      "닫기": function() {
	        $( this ).dialog( "close" );
	      }
	    }
	  });
});
function attendListView(class_cd, classhour_start_time, student_no){
	$("#dialog_student_attend").load('${pageContext.request.contextPath}/muniv/student/student_attend_view',{class_cd:class_cd, classhour_start_time:classhour_start_time, student_no:student_no});
	$('#dialog_student_attend').dialog('open');
}

function initCertCount(student_no){

	var r = confirm("학번 인증횟수가 초기화됩니다.\n\n초기화하시겠습니까?");
	var postString = "student_no="+student_no;
	if(r==true){   
	    
	    $.ajax({
	        type: "POST",
	
	        url: "${pageContext.request.contextPath}/muniv/student/student_initCertCount",
	
	        data: postString,
	
	        success: function(msg) {
	        	alert(msg);
	        	window.location.reload(true);
	        },
	        error: function(msg){
	        	alert(msg);
	        }
	
	    });
	}
}

</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">

<!-- 학생상세정보조회 -->
<spring:eval expression="@config['user_image_path']" var="user_image_path"/>
<c:set var="s" value="${studentInfo }" />

<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/sub_student_title_02.png"  alt="학생상세정보타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" />  &nbsp;학생 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp;학생상세정보 </td>
    </tr>
  </table>
</div>

<div class="round_box_top mg_t30 float_left"></div>
<div class="round_box_center float_left">

	<c:set var="varStudentYear" value="${s.iphak_year}" />
	
   	<c:choose>
    	<c:when test="${s.student_img eq null}">
    		<c:set var="student_photo" value="${pageContext.request.contextPath}/resources/images/noimage.jpg" />
    	</c:when>
    	<c:otherwise>
    		<c:set var="student_photo" value="${user_image_path}?platformType=nexacro&method=view&f0=${s.student_img}" />
    	</c:otherwise>
   	</c:choose>
 
    <div class="photo_area"><img src="${student_photo}" width="115" height="140" alt="사진이미지" /></div>
    <div class="info_area">
        <table border="0" cellpadding="0" cellspacing="0" class="tstyle_row1">
          <tr>
            <th>학 번</th>
            <td >${s.student_no}</td>
          </tr>
          <tr>
            <th>단과/학과</th>
            <td>${s.coll_name }/${s.dept_name }</td>
          </tr>
          <tr>
            <th>이름</th>
            <td>${s.student_name}</td>
          </tr>
          <tr>
            <th>연락처</th>
            <td>${s.hp_no }</td>
          </tr>
          <tr>
            <th>상태/학년</th>
            <td>${s.student_sts_name}/${s.student_grade_name }</td>
          </tr>
          <tr>
            <th>이메일</th>
            <td>${s.email_addr }</td>
          </tr>
          <tr>
            <th>등록일</th>
            <td>${s.reg_date }</td>
          </tr>
          <tr>
            <th>인증횟수</th>
            <td style="padding:0 0 0 0;">
            	<table>
            		<tr>
            			<td style="padding:0 0 0 10px;border-bottom:0px; border-right:0px;">${s.cert_count}</td>
           			<c:if test="${s.cert_count > 0}">
            			<td style="padding:5px 0 0 50px;border-bottom:0px; border-right:0px;"><a href="javascript:initCertCount('${s.student_no}')"><img src="${pageContext.request.contextPath}/resources/images/admin/init_info_button.png"></a></td>
           			</c:if>
            		</tr>
            	</table>
            </td>
          </tr>
        </table>
    </div>
</div>
<div class="round_box_bottom float_left"></div>

<div class="aligncenter">
	<a href="javascript:window.location.href=parent.document.referrer"><img src="${pageContext.request.contextPath}/resources/images/admin/list_button.png" width="61" height="27" alt="목록버튼" /></a> &nbsp;
	<a href="${pageContext.request.contextPath}/muniv/student/student_edit?student_no=${s.student_no }"><img src="${pageContext.request.contextPath}/resources/images/admin/insert_button_s.png" width="61" height="27" alt="수정버튼" /></a>
</div>
<br />
<br />

<div id="board">
	<p class="pd_r5 bold mg_b5">&nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/student_list_title.png" width="79" height="17" alt="수강정보타이틀" /></p>

	<div id="board_list">	
		<form id="searchForm" onsubmit="javascript:doSearch(); return false;" method="post" autocomplete="off">
		<table width="700" border="0" cellspacing="0" cellpadding="0">
			<caption>게시판 목록</caption>
			<thead>
				<tr>
					<th width="40" class="bg_left" scope="col">번호</th>
					<th width="90" scope="col">과목코드</th>
					<th width="173" scope="col">강의명</th>
					<th width="80" scope="col">교수</th>
					<th width="50" scope="col">요일</th>
					<th width="95" scope="col">수업시간</th>
					<th width="72" scope="col">수강인원</th>
					<th width="90" scope="col">출결내역보기</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${lectureList }" varStatus="status">
				<tr>
					<td>${status.count }</td>
					<td>${list.subject_cd }-${list.subject_div_cd }</td>
					<td class="list_title">
						<a href="${pageContext.request.contextPath}/muniv/attend/class_attend_list?class_cd=${list.class_cd}">${list.class_name }</a>	        
					</td>
					<td class="list_title">
						<a href="${pageContext.request.contextPath}/muniv/prof/prof_view?prof_no=${list.prof_no}">${list.prof_name }</a>	        
					</td>
					<td>${list.classday_name }</td>
					<td>${list.classhour_start_time } ~ ${list.classhour_end_time }</td>
					<td>${list.attendee_cnt }</td>
					<td>
						<a href="javascript:attendListView('${list.class_cd}', '${list.classhour_start_time}', '${s.student_no}')">
						<img src="${pageContext.request.contextPath}/resources/images/admin/student_arrow_icon.png"  alt="화살표아이콘" />출결내역</a>
					</td>
				</tr>
				</c:forEach>
				<c:if test="${empty lectureList }">
				<tr>
					<c:choose>
						<c:when test="${s.student_sts_cd=='G012C002'||s.student_sts_cd=='G012C005' }">
							<td colspan="8" align="center" style="height:80px">제적 또는 휴학중인 학생입니다.</td>
						</c:when>
						<c:otherwise>
							<td colspan="8" align="center" style="height:80px">강의정보가 존재하지 않습니다.</td>
						</c:otherwise>
					</c:choose>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div> <!-- board_list -->
</div> <!-- board -->

<div id="dialog_student_attend"></div>
	<!-- //학생상세정보조회 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

