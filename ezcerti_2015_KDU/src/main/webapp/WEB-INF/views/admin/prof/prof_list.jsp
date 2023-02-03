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
	$(".menu1 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_prof_on.gif");
	$(".menu1 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_prof_on.gif");
	
	
	if($("select#lst_coll").val()>1){
		$.getJSON("<c:url value='/muniv/info/getdept'/>",{coll_cd: $('#lst_coll').val()}, function(j){
			var options = '<option value="">전체</option>';
			for (var i = 0; i < j.length; i++) 
			{
				if(j[i].dept_cd=='<c:out value="${dept_cd}"/>'){
					options += '<option value="' + j[i].dept_cd + '" selected="selected">' + j[i].dept_name+' ('+j[i].dept_cd+')'+'</option>';
				}else{
					options += '<option value="' + j[i].dept_cd + '">' + j[i].dept_name+' ('+j[i].dept_cd+')'+'</option>';
				}
				
			}
			$("#lst_dept").html(options);
			//$('#lst_dept option:first').attr('selected', 'selected');
		});
	}
});

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/muniv/prof/prof_list';
	f.submit();
}
$(function(){
	$("select#lst_coll").change(function(){
		$.getJSON("<c:url value='/muniv/info/getdept'/>",{coll_cd: $('#lst_coll').val()}, function(j){
			var options = '<option value="">전체</option>';
			for (var i = 0; i < j.length; i++) 
			{
				options += '<option value="' + j[i].dept_cd + '">' + j[i].dept_name+' ('+j[i].dept_cd+')'+'</option>';
				
			}
			$("#lst_dept").html(options);
			$('#lst_dept option:first').attr('selected', 'selected');
		});
	}); 	
});

function doPopupProfSession(prof_no) {
	var targetURL = "${pageContext.request.contextPath}/muniv/prof/prof_session?prof_no="+prof_no;
	
	window.open(targetURL,'classStatPop','width=1000, height=800,top=0,left=0, toolbar=no, menubar=no, scrollbars=yes')
}

</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
	<!-- 교수목록조회 -->
	<c:set var="pb" value="${pageBean }"/>	
	<div class="titlebg">
	  <table width="670" border="0" cellpadding="0" cellspacing="0" >
	    <tr>
	      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/sub_professor_title_01.png"  alt="교수목록타이틀" /></td>
	      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;교수&nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp;교수목록 </td>
	    </tr>
	  </table>
	</div>
    <form id="searchForm" method="get" action="${pageContext.request.contextPath}/muniv/prof/prof_list" autocomplete="off">
	<table width="699" border="0" cellpadding="0" cellspacing="0" class="checkbg">
	  <tr>
	    <td align="center" valign="middle"><table width="630" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="68" align="left">단과대학 : </td>
	        <td width="175" align="left">
	        <select name="coll_cd" id="lst_coll" class="searchlistbox">
	        	<option value="">전체</option>
	        <c:forEach var="c" items="${collList}" >
	        	<c:choose>
	        		<c:when test="${coll_cd==c.coll_cd }">
	        			<option value="${c.coll_cd }" selected="selected">${c.coll_name }</option>
	        		</c:when>
	        		<c:otherwise>
	        			<option value="${c.coll_cd}">${c.coll_name}</option>
	        		</c:otherwise>
	        	</c:choose>
	        </c:forEach>
	        </select></td>
	        <td width="49" align="left">학 과 : </td>
	        <td width="227" align="left">	        
	        <select name="dept_cd" id="lst_dept" class="searchlistbox">
	        	<option value="">전체</option>
	        </select></td>
	        <td width="111"><button id="search_btn"><img src="${pageContext.request.contextPath}/resources/images/admin/check_button.png" width="111" height="53" alt="조회버튼" /></button></td>
	      </tr>
	    </table></td>
	  </tr>
	</table>
	<br />
	<br />

<c:set var="pageNum" value="${param.currentPage }" />

<c:if test="${param.currentPage eq '' or param.currentPage eq null}" >
	<c:set var="pageNum" value="1" />
</c:if>

<div id="board">
	<p class="pd_r5 bold t_right mg_b5">[총 ${pb.allCnt }건]</p>

	<div id="board_list">	
		<table width="700" border="0" cellspacing="0" cellpadding="0">
			<caption>목록</caption>
			<thead>
				<tr>
			        <th width="42" class="bg_left" scope="col">NO</td>
			        <th width="102" scope="col">단과</td>
			        <th width="162" scope="col">학과</td>
			        <th width="100" scope="col">사번</td>
			        <th width="92" scope="col">교수명</td>
			        <th width="122" scope="col">연락처</td>
			        <th width="70" scope="col">교수상태</td>					
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
							<td>${((pageNum - 1) * 10) + status.count }</td>
							<td>${b.coll_name }</td>
							<td>${b.dept_name }</td>
							<td><a href="${pageContext.request.contextPath}/muniv/prof/prof_view?prof_no=${b.prof_no }">${b.prof_no }</a></td>
							<td><a href="${pageContext.request.contextPath}/muniv/prof/prof_view?prof_no=${b.prof_no }">${b.prof_name }</a></td>
							<td>${b.hp_no }</td>
							<td>${b.prof_sts_cd }</td>
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
						>교수명</option>
						<option value="code"
						<c:if test="${param.item eq 'code'}">
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
	
<input type="hidden" id="currentPage" name="currentPage" value="${param.currentPage}">
</form>
<p>&nbsp;</p>
<!-- //교수목록조회 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

