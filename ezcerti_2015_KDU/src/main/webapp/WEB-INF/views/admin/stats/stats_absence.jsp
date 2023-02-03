<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prof_style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">

<script>
$(document).ready(function(){
	$(".menu6_admin .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_06.gif");
	$(".menu6_admin .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_06.gif");
	$("#in_topmenu6").css("display","block");
	$("#in_menu6").css("display","block");
});

$(function() {
	
	$.datepicker.regional['ko'] = {
	        closeText: '닫기',
	        prevText: '이전달',
	        nextText: '다음달',
	        currentText: '오늘',
	        monthNames: ['1월(JAN)','2월(FEB)','3월(MAR)','4월(APR)','5월(MAY)','6월(JUN)',
	        '7월(JUL)','8월(AUG)','9월(SEP)','10월(OCT)','11월(NOV)','12월(DEC)'],
	        monthNamesShort: ['1월','2월','3월','4월','5월','6월',
	        '7월','8월','9월','10월','11월','12월'],
	        dayNames: ['일','월','화','수','목','금','토'],
	        dayNamesShort: ['일','월','화','수','목','금','토'],
	        dayNamesMin: ['일','월','화','수','목','금','토'],
	        weekHeader: 'Wk',
	        dateFormat: 'yy-mm-dd',
	        firstDay: 0,
	        isRTL: false,
	        showMonthAfterYear: true,
	        yearSuffix: '',
	        showOn: 'focus',
	        changeMonth: true,
	        changeYear: false,
	        showButtonPanel: false,
	        yearRange: 'c-1:c+1'
	};
	
    $.datepicker.setDefaults($.datepicker.regional['ko']);
 
    $('#sdate').datepicker();
    $('#sdate').datepicker("option", "maxDate", $("#edate").val());
    $('#sdate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#edate").datepicker( "option", "minDate", selectedDate );
    });
 
    $('#edate').datepicker();
    $('#edate').datepicker("option", "minDate", $("#sdate").val());
    
    $('#edate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#sdate").datepicker( "option", "maxDate", selectedDate );
    });

});

function changeOrder(sortField) {
	if($("#sortOrder").val() == "DESC") {
		$("#sortOrder").val("ASC");
	} else {
		$("#sortOrder").val("DESC");
	}
	$("#sortField").val(sortField);

	doSearch();
}

function doSearch(type){
	
	var sdate = $('#sdate').val();
	var edate = $('#edate').val();
	
	if((sdate != '' && sdate != null) || (edate != '' && edate != null)){
		
		if(sdate == '' || sdate == null){
			alert('시작일자를 입력하시기 바랍니다.');
			$("#sdate").focus();
			return;
		}
		
		if(edate == '' || edate == null){
			alert('종료일자를 입력하시기 바랍니다.');
			$("#edate").focus();
			return;
		}
	}
	
	var f = document.getElementById('searchForm');
	
	if(type != "") {
		f.type.value = type;		
	}
	
	f.method = 'post';
	f.currentPage.value = 1;
	//f.searchValue = "";
	f.action = '${pageContext.request.contextPath}/muniv/stats/stats_absence';
	f.submit();
}

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/muniv/stats/stats_absence';
	f.submit();
}

function doExcelDownload() {
	
	var f = document.getElementById('searchForm');
	$("#type").val('EXCEL');
	f.method = 'post';
	f.action = '${pageContext.request.contextPath}/muniv/stats/stats_absence_excel';
	f.submit();
	
	// 폼정보 초기화
	$("#type").val('');
	f.action = '${pageContext.request.contextPath}/muniv/stats/stats_absence';
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
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/absence_title.gif"  alt="결석현황" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;통계 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;결석현황</td>
    </tr>
  </table>
</div>
<br />

<form id="searchForm" onsubmit="javascript:doSearch(''); return false;" method="get" action="${pageContext.request.contextPath}/muniv/stats/stats_absence" autocomplete="off">

	<table width="699" border="0" cellpadding="0" cellspacing="0" class="listcheckbg">
	  <tr>
	    <td align="center" valign="middle"><table width="665" border="0" cellspacing="0" cellpadding="0">
	      
	      <tr>
	        <td width="66" height="33" align="left">학과 :</td>
	        <td width="200" height="33" align="left">
		        <input type="text" name="dept_name" value="${param.dept_name}" class="searchtextbox" style="padding-top: 0px; width: 120px; height: 18px;">
	        </td>
	        
	        <td height="33">학년 :</td>
	        <td height="33">
		        <select name="student_grade" id="lst_classroom" class="searchlistbox" style="width:150px;">
					<option value="all" <c:if test="${param.student_grade eq 'all'}"> selected </c:if>>
		        		전체
		        	</option>
					<option value="1" <c:if test="${param.student_grade eq '1'}"> selected </c:if>>
		        		1학년
		        	</option>
					<option value="2" <c:if test="${param.student_grade eq '2'}"> selected </c:if>>
						2학년
					</option>
					<option value="3" <c:if test="${param.student_grade eq '3'}"> selected </c:if>>
						3학년
					</option>
					<option value="4" <c:if test="${param.student_grade eq '4'}"> selected </c:if>>
						4학년
					</option>
		        </select>
	        </td>
	        
	        <td width="112" rowspan="2">
	        	<button><img src="${pageContext.request.contextPath}/resources/images/prof/check_button.png" width="111" height="53" alt="조회버튼" /></button>
	       	</td>
	      </tr>
	      
	      <tr align="left">
	        <td width="66" height="33" align="left">학번 :</td>
	        <td width="200" height="33" align="left">
	        	<input type="text" name="student_no" value="${param.student_no}" class="searchtextbox" style="padding-top: 0px; width: 120px; height: 18px;">
		    </td>
		    <td width="66" height="33" align="left">기간검색 :</td>
	        <td width="200" height="33" align="left">
	        	<input type="text" id="sdate" name="sdate" class="searchtextbox" value="${startDate }" style="width:70px;" readonly="readonly"> ~ <input type="text" id="edate" name="edate" value="${endDate }" class="searchtextbox" style="width:70px;" readonly="readonly">
		    </td>
	      </tr>
	      
	    </table></td>
	  </tr>
	</table>
	<br>
	
	<div id="board">
		<p class="pd_r5 bold t_right mg_b5"><span style="color: red;">결석수는 수업당 결석수(총결석수/시수)가 2회 이상인 강의의 총 결석수를 말합니다.</span> [총 ${pb.allCnt }건]</p>
	
		<div id="board_list">	
			
			<table width="700" border="0" cellspacing="0" cellpadding="0">
				<caption>목록</caption>
				<thead>
					<tr>
				        <th width="32" class="bg_left" scope="col">NO</th>
				        <th width="110" scope="col">단과</th>
				        <th width="150" scope="col"><a href="javascript:changeOrder('DEPT_NAME')">학과</a></th>
				        <th width="50" scope="col"><a href="javascript:changeOrder('STUDENT_GRADE')">학년</a></th>
				        <th width="90" scope="col"><a href="javascript:changeOrder('STUDENT_NO')">학번</a></th>
				        <th width="90" scope="col"><a href="javascript:changeOrder('STUDENT_NAME')">이름</a></th>
				        <th width="125" scope="col">연락처</th>
				        <th width="50" scope="col"><a href="javascript:changeOrder('STUDENT_STS_CD')">상태</a></th>
				        <th width="50" scope="col"><a href="javascript:changeOrder('ABSENCE_CNT')">결석수</a></th>
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
								<td>${b.coll_name }</td>
								<td>${b.dept_name }</td>
								<td>${b.student_grade }학년</td>
								<td><a href="${pageContext.request.contextPath}/muniv/student/student_view?class_type=ABSENCE&student_no=${b.student_no}">${b.student_no }</a></td>
								<td><a href="${pageContext.request.contextPath}/muniv/student/student_view?class_type=ABSENCE&student_no=${b.student_no}">${b.student_name }</a></td>
								<td>${b.hp_no }</td>
								<td>${b.student_sts_name }</td>
								<td>${b.absence_cnt }</td>
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
			<a href="javascript:doExcelDownload()">
				<img src="${pageContext.request.contextPath }/resources/images/common/e_down_button.png">
			</a>	
		</div>
		
		<%-- <div class="search_area">
			<div class="search">
				<h4 class="float_left mg_t3">
					<img src="${pageContext.request.contextPath}/resources/images/board/search_title.gif" alt="search" />
				</h4>
				<div class="float_left pd_l15">
					<fieldset>
					<legend>통합검색</legend>
					<label class="alternate" for="fmSearch4">검색목록</label>
						<select id="item" name="item">
				            <option value="student_no" <c:if test="${param.item=='student_no'}">selected</c:if>>학번</option>
							<option value="student_name" <c:if test="${param.item=='student_name'}">selected</c:if>>학생명</option>
				            <option value="dept_name" <c:if test="${param.item=='dept_name'}">selected</c:if>>학과명</option>
						</select>
					<label class="alternate" for="fmString2">검색어 입력</label>
					<input type="text" id="value" name="value" value="${param.value}" class="search_txt" />
					<label class="alternate" for="btnSearch">검색</label>
					<input name="btnSearch" type="image" src="${pageContext.request.contextPath}/resources/images/board/search_btn.gif" alt="검색" id="btnSearch" />
					</fieldset>
				</div>
			</div>
		</div> --%>
	</div> <!-- board -->
	
	<input type="hidden" id="current_date" name="current_date" value="${param.current_date }">
	<input type="hidden" id="currentPage" name="currentPage">
	<input type="hidden" id="sortField" name="sortField" value="${param.sortField}">
	<input type="hidden" id="sortOrder" name="sortOrder" value="${param.sortOrder}">
	<input type="hidden" id="type" name="type" value="${param.type}">
	
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

