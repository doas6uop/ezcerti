<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
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
	$(".menu3 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_attendee_on.gif");
	$(".menu3 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_attendee_on.gif");
});
function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/muniv/attendee/attendee_view';
	f.submit();
}
</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
	<!-- 학생상세정보조회 -->
	<c:set var="pb" value="${pageBean }"/>
	<div class="titlebg">
	  <table width="670" border="0" cellpadding="0" cellspacing="0" >
	    <tr>
	      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/sub_attendee_title_02.png"  alt="수강생상세정보타이틀" /></td>
	      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;수강생 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;수강생상세정보 </td>
	    </tr>
	  </table>
	</div>
	<table width="699" border="0" cellpadding="0" cellspacing="0" class="checkbg">
	  <tr>
	    <td align="center" valign="middle" class="attendeetablebg"><table width="658" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="339" height="27" align="left"><img src="${pageContext.request.contextPath}/resources/images/admin/cross_icon.png" width="9" height="9" alt="아이콘" />&nbsp; 개설단과 : ${lecture.prof_coll_name }</td>
	        <td width="319" align="left"><img src="${pageContext.request.contextPath}/resources/images/admin/cross_icon.png" width="9" height="9" alt="아이콘" />&nbsp; 교수명 : ${lecture.prof_name }</td>
	      </tr>
	      <tr>
	        <td height="27" colspan="2" align="left"><img src="${pageContext.request.contextPath}/resources/images/admin/cross_icon.png" width="9" height="9" alt="아이콘" />&nbsp; 개설학과 : ${lecture.prof_dept_name }</td>
	        </tr>
	      <tr>
	        <td height="27" align="left"><img src="${pageContext.request.contextPath}/resources/images/admin/cross_icon.png" width="9" height="9" alt="아이콘" />&nbsp; 과목명 : ${lecture.class_name }</td>
	        <td height="28" align="left"><a href="${pageContext.request.contextPath}/muniv/attend/class_attend_list?class_cd=${lecture.class_cd}"><img src="${pageContext.request.contextPath}/resources/images/admin/info_view_button.png"  alt="출결정보보기" /></a></td>
	        </tr>
	    </table>
	      <table width="662" border="0" cellpadding="0" cellspacing="0" class="attendeegraytable">
	        <tr>
	          <td width="167" align="center">· 총 : ${pb.allCnt } 명</td>
	          <td width="165" align="center">· 재학 : ${attendee.attend.COUNT_NORMAL } 명</td>
	          <td width="165" align="center">· 휴학 : ${attendee.attend.COUNT_OFF } 명</td>
	          <td width="165" align="center">· 자퇴 : ${attendee.attend.COUNT_QUIT } 명</td>
	        </tr>
	    </table></td>
	  </tr>
	</table>
	<br />
	<br />
	
<form id="searchForm" method="get" action="${pageContext.request.contextPath}/muniv/attendee/attendee_view" autocomplete="off">
<div id="board">
	<p class="pd_r5 bold t_right mg_b5">[총 ${pb.allCnt }건]</p>
	<div id="board_list">	
		<form id="searchForm" onsubmit="javascript:doSearch(); return false;" method="post" autocomplete="off">
		<table width="700" border="0" cellspacing="0" cellpadding="0">
			<caption>목록</caption>
			<thead>
				<tr>
			        <th width="43" class="bg_left" scope="col">NO</td>
			        <th width="121" scope="col">수강생학과</td>
			        <th width="110" scope="col">학번</td>
			        <th width="123" scope="col">이름</td>
			        <th width="127" scope="col">연락처</td>
			        <th width="63" scope="col">국적</td>
			        <th width="103" scope="col">상태</td>
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
						<tr class="tr_over">
							<td>${b.row_no}</td>
							<td>${b.dept_name }</td>
							<td><a href="${pageContext.request.contextPath}/muniv/student/student_view?student_no=${b.student_no }">${b.student_no }</a></td>
							<td><a href="${pageContext.request.contextPath}/muniv/student/student_view?student_no=${b.student_no }">${b.student_name }</a></td>
							<td>${b.hp_no }</td>
							<td>${b.nation_cd }</td>
							<td>${b.student_sts_cd }</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose> 
			</tbody>
		</table>
	</div> <!-- board_list -->
	<div class="btn_area">
		<a href="attendee_list"><img src="${pageContext.request.contextPath}/resources/images/admin/list_button.png" width="61" height="27" alt="목록버튼" /></a>
	</div>
	
	<div class="pagination">
		<div class="page_num"> 
			<my:pageGroup/>
		</div>
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
						<option value="name"
						<c:if test="${param.item eq 'name'}">
							selected
						</c:if>
						>이름</option>
						<option value="code"
						<c:if test="${param.item eq 'code'}">
							selected
						</c:if>
						>학번</option>
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
	
<input type="hidden" name="subject_cd" value="${attendee.subject_cd}">
<input type="hidden" name="subject_div_cd" value="${attendee.subject_div_cd}">
<input type="hidden" name="class_cd" value="${attendee.class_cd}">
<input type="hidden" name="term_cd" value="${attendee.term_cd}">
<input type="hidden" id="currentPage" name="currentPage">
</form>
<p>&nbsp;</p>
<!-- //수강생상세정보 -->

</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

