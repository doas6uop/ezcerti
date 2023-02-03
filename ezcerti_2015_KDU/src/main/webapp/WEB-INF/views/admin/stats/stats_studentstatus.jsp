<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	$(".menu7 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_stats_on.gif");
	$(".menu7 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_stats_on.gif");
	$("#in_topmenu7").css("display","block");
	$("#in_menu7").css("display","block");
});
function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/muniv/stats/stats_studentstatus';
	f.submit();
}
</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 관리자출결현황 -->
<c:set var="pb" value="${pageBean }"/>	
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/stats_title_02.png"  alt="학기통계타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;통계 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;학생출결 현황</td>
    </tr>
  </table>
</div>
<br />
<br />

<form id="searchForm" method="get" action="${pageContext.request.contextPath}/muniv/stats/stats_studentstatus" autocomplete="off">
<div id="board">
	<p class="pd_r5 bold t_right mg_b5">[총 ${pb.allCnt }건]</p>

	<div id="board_list">	
		<table width="700" border="0" cellspacing="0" cellpadding="0">
			<caption>목록</caption>
			<thead>
				<tr>
			        <th width="20" class="bg_left" scope="col">NO</td>
			        <th width="40" scope="col">학번</td>
			        <th width="55" scope="col">학생명</td>
			        <th width="45" scope="col">전화번호</td>
			        <th width="40" scope="col">학과명</td>
			        <th width="30" scope="col">출결전</td>
			        <th width="30" scope="col">출석</td>
			        <th width="30" scope="col">지각</td>
			        <th width="30" scope="col">결석</td>
				</tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${fn:length(pb.list)==0 }">
					<tr>
						<td class="tdwhite" colspan="9" align="center" style="padding:30px 0 30px 0; border-right:none;">검색결과가 존재하지 않습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="b" items="${pb.list}" varStatus="status">
						<tr class="tr_over">
							<td>${b.row_no}</td>
							<td><a href="${pageContext.request.contextPath }/muniv/student/student_view?student_no=${b.STUDENT_NO}">${b.STUDENT_NO }</a></td>
							<td><a href="${pageContext.request.contextPath }/muniv/student/student_view?student_no=${b.STUDENT_NO}">${b.STUDENT_NAME }</a></td>
							<td>${b.HP_NO }</td>
						    <td>${l.DEPT_NAME }</td>
						    <td>${l.ATTEND_BEFORE }%</td>
						    <td>${l.ATTEND_PRESENT }%</td>
						    <td>${l.ATTEND_LATE }%</td>
						    <td>${l.ATTEND_ABSENT }%</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose> 
			</tbody>
		</table>
	</div> <!-- board_list -->
	<div class="pagination">
		<div class="page_num"> 
			<my:pageGroup/>
		</div>
	</div>
	<div class="btn_area">
		<a href="${pageContext.request.contextPath }/excel?target=studentStatus">
			<img src="${pageContext.request.contextPath }/resources/images/common/e_down_button.png">
		</a>
	</div>	
	
</div> <!-- board -->	

<input type="hidden" id="currentPage" name="currentPage">
</form> 
<!-- //관리자출결현황 -->
</div>
</div>

<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>

<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

