<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="my" uri="/my-taglib" %>
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
	$(".menu5 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_05.gif");
	$(".menu5 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_05.gif");
	$("#in_topmenu5").css("display","block");
	$("#in_menu5").css("display","block");
});
function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/muniv/info/admin_list';
	f.submit();
}
</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
	<!-- 관리자목록 -->
	<c:set var="pb" value="${pageBean }"/>
	<div class="titlebg">
	  <table width="670" border="0" cellpadding="0" cellspacing="0" >
	    <tr>
	      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/sub_admin_title_01.png"  alt="강의일정보타이틀" /></td>
	      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;관리자 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp;관리자목록</td>
	    </tr>
	  </table>
	</div>
	<br />
	<br />
	
<form id="searchForm" method="get" action="${pageContext.request.contextPath}/muniv/info/admin_list" autocomplete="off">
<div id="board">
	<p class="pd_r5 bold t_right mg_b5">[총 ${pb.allCnt }건]</p>

	<div id="board_list">	
		<table width="700" border="0" cellspacing="0" cellpadding="0">
			<caption>목록</caption>
			<thead>
				<tr>
			        <th width="52" class="bg_left" scope="col">NO</td>
			        <th width="137" scope="col">소속</td>
			        <th width="98" scope="col">사번</td>
			        <th width="97" scope="col">관리자명</td>
			        <th width="122" scope="col">연락처</td>
			        <th width="102" scope="col">권한</td>
			        <th width="82" scope="col">상태</td>
				</tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${fn:length(pb.list)==0 }">
					<tr>
						<td class="tdwhite" colspan="5" align="center" style="padding:30px 0 30px 0; border-right:none;">검색결과가 존재하지 않습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="b" items="${pb.list}" varStatus="status">
						<tr class="tr_over">
							<td>${b.row_no}</td>
							<td>${b.dept_cd }</td>
							<td>${b.admin_no }</td>
							<td><a href="${pageContext.request.contextPath}/muniv/info/admin_view?user_no=${b.admin_no }">${b.admin_name }</a></td>
							<td>${b.hp_no }</td>
							<td>${b.admin_level_name }</td>
							<td>${b.admin_sts_name }</td>
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
	<!--
	<div class="btn_area">
		<a href="${pageContext.request.contextPath}/muniv/info/admin_member_join">
			<img src="${pageContext.request.contextPath}/resources/images/admin/register_button.png" width="61" height="27" alt="등록버튼" />
		</a>
	</div>
	-->		
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
			            <option value="name"
						<c:if test="${param.item=='name'}">
							selected
						</c:if>
						>관리자명</option>
						<option value="code"
						<c:if test="${param.item=='code'}">
							selected
						</c:if>
						>사번</option>
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
<!-- //관리자목록 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

