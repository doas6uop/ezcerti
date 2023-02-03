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
});


function doList(){
	var f = document.getElementById('boardFrm');
	f.method = 'get';
	f.action = '${pageContext.request.contextPath}/muniv/info/gonggyul_list';
	f.submit();
}

</script>
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
						${gonggyul.student_name }
					</td>
				</tr>
				<tr>
					<th>학기</th>
					<td>
						<c:choose>
							<c:when test="${gonggyul.term_cd == 'G002C001'}">
								1학기
							</c:when>
							<c:otherwise>
								2학기
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>일자</th>
					<td>
						${gonggyul.gong_ilja_start } ~ ${gonggyul.gong_ilja_end } 
					</td>
				</tr>
				<tr>
					<th>과목</th>
					<td>
						<c:forEach var="list_subject" items="${gonggyul.gonggyulSubjectList}">
							<p style="text-align: left;">
								${list_subject.class_name} (${list_subject.classday_name}) ${list_subject.classhour_start_time} [${list_subject.class_real_cnt}/${list_subject.class_total_cnt}시간]
							</p>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th>제출일자</th>
					<td>
						${gonggyul.submit_date }
					</td>
				</tr>
				<tr>
					<th>사유</th>
					<td>
						${gonggyul.gong_sayu }
					</td>
				</tr>
			</table>
		</div>
		<div class="btn_area">
			<a href="javascript:doList()"><img src="${pageContext.request.contextPath}/resources/images/board/list_btn.gif" alt="목록" /></a>
			<c:if test="${gonggyul.checkbox_flag == 'Y'}">	
				<a href="${pageContext.request.contextPath}/muniv/info/gonggyul_modify_form?gonggyul_no=${gonggyul.gonggyul_no }"><img src="${pageContext.request.contextPath}/resources/images/board/insert_btn.gif" alt="수정" /></a>
			</c:if>
			<%-- 
			<button type="button" class="btn-default" onclick="doList()">목록</button>
			<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/muniv/info/gonggyul_modify_form?gonggyul_no=${gonggyul.gonggyul_no }'">수정</button>
			--%>
		</div>
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
