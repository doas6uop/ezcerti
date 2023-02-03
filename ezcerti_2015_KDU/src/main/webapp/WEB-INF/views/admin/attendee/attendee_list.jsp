<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
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
	f.action = '${pageContext.request.contextPath}/muniv/attendee/attendee_list';
	f.submit();
}
</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
	<!-- 수강생목록 -->
	<c:set var="pb" value="${pageBean }"/>
	<div class="titlebg">
	  <table width="670" border="0" cellpadding="0" cellspacing="0" >
	    <tr>
	      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/sub_attendee_title_01.png"  alt="수강생목록타이틀" /></td>
	      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;수강생 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;수강생목록 </td>
	    </tr>
	  </table>
	</div>
    <form id="searchForm" method="get" action="${pageContext.request.contextPath}/muniv/attendee/attendee_list" autocomplete="off">
	<table width="699" border="0" cellpadding="0" cellspacing="0" class="checkbg">
	  <tr>
	    <td align="center" valign="middle"><table width="645" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="40" align="left">학 기 : </td>
	        <td width="180" align="left">
	        <select name="term_cd" class="searchlistbox">
	        	<c:forEach var="term" items="${termList }">
	        		<c:choose>
	        			<c:when test="${term_cd==term.term_cd }">
	        				<option value="${term.term_cd }" selected="selected">${term.term_name }</option>
	        			</c:when>
	        			<c:otherwise>
	        				<option value="${term.term_cd }">${term.term_name }</option>
	        			</c:otherwise>
	        		</c:choose>
	        	</c:forEach>
	        </select>
	        </td>
	        <td width="240" align="left">
	        	<select id="item" name="item" size="1" class="searchlistbox" id="list">
	            <option value="classname"
				<c:if test="${param.item=='classname'}">
					selected
				</c:if>
				>과목명</option>
				<option value="profname"
				<c:if test="${param.item=='profname'}">
					selected
				</c:if>
				>교수명</option>
	          	</select>
	        	<input type="text" id="value" name="value" value="${param.value}" class="searchtextbox" style="width:150px;"/>
	        </td>
	        <td width="111">
	        	<button><img src="${pageContext.request.contextPath}/resources/images/admin/check_button.png" width="111" height="53" alt="조회버튼" /></button>
	        </td>
	      </tr>
	    </table></td>
	  </tr>
	</table>
	<br />
	<br />
	
<div id="board">
	<p class="pd_r5 bold t_right mg_b5">[총 ${pb.allCnt }건]</p>

	<div id="board_list">	
		<form id="searchForm" onsubmit="javascript:doSearch(); return false;" method="post" autocomplete="off">
		<table width="700" border="0" cellspacing="0" cellpadding="0">
			<caption>목록</caption>
			<thead>
				<tr>
			        <th width="37" class="bg_left" scope="col">NO</td>
			        <th width="102" scope="col">단과</td>
			        <th width="107" scope="col">학과</td>
			        <th width="165" scope="col">과목명</td>
			        <th width="89" scope="col">교수명</td>
			        <th width="50" scope="col">요일</td>
			        <th width="60" scope="col">교시</td>
			        <th width="80" scope="col">수강생보기</td>
				</tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${fn:length(pb.list)==0 }">
					<tr>
						<td class="tdwhite" colspan="8" align="center" style="padding:30px 0 30px 0; border-right:none;">검색결과가 존재하지 않습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="b" items="${pb.list}" varStatus="status">
						<tr class="tr_over">
							<td>${b.row_no}</td>
							<td>${b.prof_coll_name }</td>
							<td>${b.prof_dept_name }</td>
							<td>${b.class_name }</td>
							<td>${b.prof_name }</td>
							<td>${b.classday_name }</td>
							<td>${b.classhour_name }</td>
							<td><a href="${pageContext.request.contextPath}/muniv/attendee/attendee_view?subject_cd=${b.subject_cd }&subject_div_cd=${b.subject_div_cd }&term_cd=${b.term_cd}&class_cd=${b.class_cd }">수강생보기</a></td>
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
	
</form>
<p>&nbsp;</p>
	<!-- //수강생목록조회 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

