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
	$(".menu2 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_02.gif");
	$(".menu2 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_02.gif");
});

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/muniv/attend/class_attend_list';
	f.submit();
}
</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 강의출결목록 -->
<c:set var="pb" value="${pageBean }"/>
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/sub_class_title_01.png"  alt="수강생상세정보타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;통합검색 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;강의출결목록 </td>
    </tr>
  </table>
</div>

<form id="searchForm" method="get" action="${pageContext.request.contextPath}/muniv/attend/class_attend_list" autocomplete="off">
	<div id="board">
		<p class="pd_r5 bold t_right mg_b5">[총 ${pb.allCnt }건]</p>
	
		<div id="board_list">	
			<table width="700" border="0" cellspacing="0" cellpadding="0">
				<caption>목록</caption>
				<thead>
					<tr>
				        <th width="33" class="bg_left" scope="col">NO</th>
				        <th width="135" scope="col">강의일시</th>
				        <th width="118" scope="col">학과</th>
				        <th width="132" scope="col">과목</th>
				        <th width="110" scope="col">교수</th>
				        <th width="56" scope="col">수강인원</th>
				        <th width="106" scope="col">상태</th>			
					</tr>
				</thead>
				<tbody>
				<c:choose>
					<c:when test="${fn:length(pb.list)==0 }">
						<tr>
							<td class="tdwhite" colspan="7" align="center" style="padding:30px 0 30px 0; border-right:none;">검색결과가 존재하지 않습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="b" items="${pb.list}" varStatus="status">
							<c:choose>
								<c:when test="${b.class_type_cd eq 'G019C002'}">
									<c:set var="varStatusNm" value="${b.req_reason}" />
								</c:when>
								<c:otherwise>
									<c:set var="varStatusNm" value="${b.class_sts_name}" />
								</c:otherwise>
							</c:choose>
						
							<tr class="tr_over">
								<td>${b.row_no}</td>
								<td><a href="${pageContext.request.contextPath}/muniv/attend/class_attend_view?classday=${b.classday}&classhour_start_time=${b.classhour_start_time }&class_cd=${b.class_cd }">${b.classday } <fmt:formatDate value="${b.classday }" type="time" pattern="(E)"/> ${b.classhour_start_time } ~ ${b.classhour_end_time }</a></td>
								<td>${b.prof_dept_name }</td>
								<td>${b.class_name }</td>
								<td>${b.prof_name }</td>
								<td>${b.attendee_cnt }</td>
								<td>${b.class_type_name }(${varStatusNm})</td>
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
	</div> <!-- board -->
	
	<input type="hidden" id="currentPage" name="currentPage">
	<input type="hidden" name="class_cd" value="${class_cd }">
</form>
<p>&nbsp;</p>	
<!-- //강의출결목록조회 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

