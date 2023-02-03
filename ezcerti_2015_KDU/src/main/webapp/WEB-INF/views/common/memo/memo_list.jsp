<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

<jsp:useBean id="to_day" class="java.util.Date" />
<fmt:formatDate value="${to_day}" pattern="yyyyMMdd" var="toDay" />

<script>
$(document).ready(function(){
	<sec:authorize ifAnyGranted="ROLE_ADMIN,ROLE_SYSTEM">
		$(".menu4 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_04.gif");
		$(".menu4 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_04.gif");
		$("#in_topmenu4").css("display","block");
		$("#in_menu4").css("display","block");
	</sec:authorize>
	<sec:authorize ifAnyGranted="ROLE_PROF">
		$(".menu16 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_04.gif");
		$(".menu16 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_04.gif");
		$("#in_topmenu16").css("display","block");
		$("#in_menu16").css("display","block");
	</sec:authorize>
});

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'post';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/comm/memo/memo_list';
	f.submit();
}

function doSearch(){
	var f = document.getElementById('searchForm');
	f.method = 'post';
	f.currentPage.value = 1;
	f.searchValue = "";
	f.action = '${pageContext.request.contextPath}/comm/memo/memo_list';
	f.submit();
}

function doView(memo_no){
	var f = document.getElementById('searchForm');
	f.method = 'post';
	f.memo_no.value = memo_no;
	f.action = '${pageContext.request.contextPath}/comm/memo/memo_view';
	f.submit();
}

</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
	<c:set var="pb" value="${pageBean }"/>
	<div class="titlebg">
	  <table width="670" border="0" cellpadding="0" cellspacing="0" >
	    <tr>
	      <td width="320" height="75" align="left" valign="bottom">
			<img src="${pageContext.request.contextPath}/resources/images/board/memo_title.png" />
		  </td>
	      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;커뮤니티 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp;메모</td>
	    </tr>
	  </table>
	</div>
	<br />
  
<div id="board">
	<p class="pd_r5 bold t_right mg_b5">[총 ${pb.allCnt }건]</p>
	<div id="board_list">
		<form id="searchForm" onsubmit="javascript:doSearch(); return false;" method="post" autocomplete="off">
		<table border="0" cellspacing="0" summary="게시판 목록에 따른 번호, 작성자, 첨부파일, 조회 테이블">
			<caption>게시판 목록</caption>
			<thead>
			<tr>
				<th width="8%" class="bg_left" scope="col">번호</th>
				<th width="10%" scope="col">보낸사람</th>
				<th width="10%" scope="col">받는사람</th>
				<th scope="col">내용</th>
				<th width="15%" scope="col">보낸날짜</th>
				<th width="15%" scope="col">확인날짜</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach var="b" items="${pb.list}">
			<tr>
				<td>${b.row_no }</td>
				<td>${b.from_user_name }</td>
				<td>${b.to_user_name }</td>
				<td>
					<a href="javascript:doView('${b.memo_no}')">
					<c:choose>
						<c:when test="${fn:length(b.message) > 25}">
							${fn:substring(b.message,0,25)}...
						</c:when>
						<c:otherwise>
							${b.message}
						</c:otherwise>
					</c:choose>
					<c:if test="${fn:length(b.message) > 25}">
					</c:if>
					</a>
				</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${b.reg_date}" /></td>
				<td>
					<fmt:formatDate pattern="yyyyMMdd" value="${b.receive_date}" var="receiveDate" />
					<c:choose>
						<c:when test="${toDay eq receiveDate}">
							<fmt:formatDate pattern="HH:mm:ss" value="${b.receive_date}" var="receiveFormatDate" />
						</c:when>
						<c:otherwise>
							<fmt:formatDate pattern="yyyy-MM-dd" value="${b.receive_date}" var="receiveFormatDate" />
						</c:otherwise>
					</c:choose>
					${receiveFormatDate}	        
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="btn_area">
		<sec:authorize ifAnyGranted="ROLE_SYSTEM, ROLE_ADMIN, ROLE_PROF">
			<a href="${pageContext.request.contextPath}/comm/memo/memo_form">
				<!-- UNIV_IMAGE -->
				<img src="${pageContext.request.contextPath}/resources/images/board/memowrite_btn.gif" alt="메모쓰기" />
			</a>
		</sec:authorize>		
	</div>
	<div class="pagination">
		<div class="page_num">
			<my:pageGroup/>
				<!--span><a href="/"><img src="${pageContext.request.contextPath}/resources/images/board/first_btn.gif" alt="처음" /></a></span><span><a href="/"><img src="${pageContext.request.contextPath}/resources/images/board/pre_btn.gif" alt="이전" /></a></span><span class="select">1</span><span><a href="/">2</a></span><span><a href="/">3</a></span><span><a href="/">4</a></span><span><a href="/">5</a></span><span><a href="/">6</a></span><span><a href="/">7</a></span><span><a href="/">8</a></span><span><a href="/">9</a></span><span><a href="/">10</a></span><span><a href="/"><img src="${pageContext.request.contextPath}/resources/images/board/next_btn.gif" alt="다음" /></a></span><span class="page_end"><a href="/"><img src="${pageContext.request.contextPath}/resources/images/board/end_btn.gif" alt="끝" /></a></span-->
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
					<select id="searchItem" name="searchItem">
						<option value="message"
						<c:if test="${param.searchItem eq 'message'}">
							selected
						</c:if>
						>내용</option>
						<option value="sender"
						<c:if test="${param.searchItem eq 'sender'}">
							selected
						</c:if>
						>보낸사람</option>
						<option value="receiver"
						<c:if test="${param.searchItem eq 'receiver'}">
							selected
						</c:if>
						>받는사람</option>
					</select>
				<label class="alternate" for="fmString2">검색어 입력</label>
				<input type="text" id="searchValue" name="searchValue" value="${param.searchValue}"class="search_txt" />
				<label class="alternate" for="btnSearch">검색</label>
				<input name="btnSearch" type="image" src="${pageContext.request.contextPath}/resources/images/board/search_btn.gif" alt="검색" id="btnSearch" />
				</fieldset>
			</div>
		</div>
	</div>
</div>

<input type="hidden" id="currentPage" name="currentPage" value="${param.currentPage}">
<input type="hidden" id="memo_no" name="memo_no">
</form>

</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

