<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
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

function doList(){
	var f = document.getElementById('memo');
	f.method = 'post';
	f.action = '${pageContext.request.contextPath}/comm/memo/memo_list';
	f.submit();
}

function doDelete(){
	var postString = $("#memo").serialize();
	var r = confirm("삭제하시겠습니까?");
	if(r==true){
		$.ajax({
	        type: "POST",
	
	        url: "${pageContext.request.contextPath}/comm/memo/memo_delete",
	
	        data: postString,
	
	        success: function(msg) {
	        	alert(msg);
	        	document.location.replace('${pageContext.request.contextPath}/comm/memo/memo_list');
	        },
	        error: function(msg){
	        	alert("실패");
	        }
	    });
	}
} 

</script>
</head>

<% pageContext.setAttribute("lineChar", "\r"); %>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
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

<form:form commandName="memo">  
<div id="board" class="mg_t20">
	<div id="board_write">
		<table border="0" cellpadding="0" cellspacing="0" summary="글쓰기">
			<caption>메모보기</caption>
			<tr>
				<th>보낸사람</th>
				<td>${memo.from_user_name}</td>
			</tr>
			<tr>
				<th>보낸날짜</th>
				<td><fmt:formatDate value="${memo.reg_date}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${fn:replace(memo.message, lineChar, "<br/>")}</td>
			</tr>
		</table>
	</div>
	<div class="btn_area">
		<span>
			<a href="javascript:doList()">
				<img src="${pageContext.request.contextPath}/resources/images/board/list_btn.gif" alt="목록" />
			</a>
		</span>
		<span class="pd_r10">
			<sec:authorize ifAnyGranted="ROLE_SYSTEM, ROLE_ADMIN, ROLE_PROF">
			<a href="javascript:doDelete()">
				<img src="${pageContext.request.contextPath}/resources/images/board/del_btn.gif" alt="삭제" />
			</a>
			</sec:authorize>
		</span>
	</div>
</div>

<input type="hidden" id="currentPage" name="currentPage" value="${param.currentPage}">
<input type="hidden" id="searchItem" name="searchItem" value="${param.searchItem}">
<input type="hidden" id="searchValue" name="searchValue" value="${param.searchValue}">

<input type="hidden" id="memo_no" name="memo_no" value="${memo.memo_no}">

</form:form>

</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

