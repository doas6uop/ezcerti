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
	f.action = '${pageContext.request.contextPath}/muniv/stats/stats_prof';
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
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/stats_title_05.png"  alt="학기통계타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;통계 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;교수 통계</td>
    </tr>
  </table>
</div>
<br />
<br />

<form id="searchForm" method="get" action="${pageContext.request.contextPath}/muniv/stats/stats_prof" autocomplete="off">
<div id="board">
	<p class="pd_r5 bold t_right mg_b5">[총 ${pb.allCnt }건]</p>

	<div id="board_list">	
		<form id="searchForm" onsubmit="javascript:doSearch(); return false;" method="post" autocomplete="off">
		<table width="700" border="0" cellspacing="0" cellpadding="0">
			<caption>게시판 목록</caption>
			<thead>
				<tr>
					<th width="30" class="bg_left" scope="col">번호</th>
					<th width="35" scope="col">사번</th>
					<th width="55" scope="col">교수명</th>
					<th width="90" scope="col">학과명</th>
					<th width="30" scope="col">총강의</th>
					<th width="30" scope="col">보강수</th>
					<th width="30" scope="col">휴강수</th>
					<th width="30" scope="col">출석</th>
					<th width="30" scope="col">지각</th>
					<th width="30" scope="col">결석</th>
					<th width="30" scope="col">기타</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="b" items="${pb.list}">
			<tr>
				<td>${b.ROW_NO}</td>
				<td><a href="${pageContext.request.contextPath }/muniv/stats/stats_prof_term?prof_no=${b.PROF_NO}">${b.PROF_NO }</a></td>
				<td><a href="${pageContext.request.contextPath }/muniv/stats/stats_prof_term?prof_no=${b.PROF_NO}">${b.PROF_NAME }</a></td>
				<td>${b.PROF_DEPT_NAME }</td>
				<td>${b.ALL_CLASS }</td>
				<td>${b.ADD_CLASS }
					<c:if test="${empty b.ADD_CLASS }">-</c:if>
				</td>
				<td>${b.OFF_CLASS }
					<c:if test="${empty b.OFF_CLASS }">-</c:if>
				</td>
				<td>${b.ATTEND_PRESENT }%</td>
				<td>${b.ATTEND_LATE }%</td>
				<td>${b.ATTEND_ABSENT }%</td>
				<td>${b.ATTEND_ETC }%</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
	</div> <!-- board_list -->
	<div class="pagination">
		<div class="page_num"> 
			<my:pageGroup/>
		</div>
	</div>
	<div class="btn_area">
		<a href="${pageContext.request.contextPath }/excel?target=adminStatsProf&item=${param.item}&value=${param.value}">
			<img src="${pageContext.request.contextPath }/resources/images/common/e_down_button.png">
		</a>	
	</div>
	<div class="search_area">
		<div class="search">
			<h4 class="float_left mg_t3">
				<img src="${pageContext.request.contextPath}/resources/images/board/search_title.gif" alt="search" />
			</h4>
			<div class="float_left pd_l15">
				<fieldset>
				<legend>통합검색</legend>
				<label class="alternate" for="fmSearch4">검색목록</label>
					<select id="item" name="item">
			            <option value="code"
						<c:if test="${param.item=='code'}">
							selected
						</c:if>
						>사번</option>
						<option value="name"
						<c:if test="${param.item=='name'}">
							selected
						</c:if>
						>교수명</option>
					</select>
				<label class="alternate" for="fmString2">검색어 입력</label>
				<input type="text" id="value" name="value" value="${param.value}" class="search_txt" />
				<label class="alternate" for="btnSearch">검색</label>
				<input name="btnSearch" type="image" src="${pageContext.request.contextPath}/resources/images/board/search_btn.gif" alt="검색" id="btnSearch" />
				</fieldset>
			</div>
		</div>
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

