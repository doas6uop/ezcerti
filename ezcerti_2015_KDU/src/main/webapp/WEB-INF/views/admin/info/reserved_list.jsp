<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<meta charset="utf-8">
<title><spring:eval expression="@config['univ_title']"/> :: 강의실</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prof_style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">
<spring:eval expression="@config['makeup_lesson']" var="makeup_lesson"/>

<script>
$(document).ready(function(){
	$(".menu12 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_attend_on.gif");
	$(".menu12 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_attend_on.gif");
	$("#in_topmenu5").css("display","block");
	$("#in_menu5").css("display","block");
	
	$("#lst_term").change(function() {
		
		<%--
			연도 및 학기 id값 (ex : 2016_G002C002) 20160825
			학기 조회시 연도 조건이 없으면 연도에 따른 학기 구분을 할수 없기때문에
			selectbox 선택시 연도 값 param에 세팅
		 --%>
		var tmpTextArr = $('#lst_term option:selected').attr('id').split('_');
		
		$('#year').val(tmpTextArr[0]);
		
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
	var f = document.getElementById('searchForm');
	
	if(type != "") {
		f.type.value = type;		
	}
	
	f.method = 'post';
	f.currentPage.value = 1;
	//f.searchValue = "";
	f.action = '${pageContext.request.contextPath}/muniv/info/reserved_list';
	f.submit();
}

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/muniv/info/reserved_list';
	f.submit();
}

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
	
function doReserve(){
	var term_cd = $("#lst_term").val(); 
	var reserve_date = $("#sdate").val(); 
	var classroom_no = $("#lst_classroom").val(); 
	
	$("#dialog_classroom_reserve").load('${pageContext.request.contextPath}/muniv/info/classroom_reserve',{term_cd:term_cd, reserve_date:reserve_date, classroom_no:classroom_no});
	$("#dialog_classroom_reserve").dialog("open");
}

$(function() {
	  $( "#dialog_classroom_reserve" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    width:300,
	    height:260,
	    modal: true,
	    buttons: {
	      "확인": function() {			
	        $( this ).dialog( "close" );

	        var postString = {
	    			year:$("#year").val(), 
	    			term_cd:$("#term_cd").val(), 
	    			reserve_date:$("#reserve_date").val(), 
	    			classroom_no:$("#classroom_no").val(),
	    			reserve_time:$("#reserve_time").val(),
	    			reason:$("#reason").val()
  			};
	        
		    $.ajax({
		        type: "POST",
		
		        url: "${pageContext.request.contextPath}/muniv/info/reserve_confirm",
		
		        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
		
		        success: function(msg) {
		        	$('#resultDIV').append(msg);   
		        	alert(msg);
		        	location.reload();
		        },
		        beforeSend: function() {
		            //통신을 시작할때 처리
		         	$('.ui-dialog button:nth-child(1)').button('disable');
		         	$('#ajax_indicator').show().fadeIn('fast');
		        }, 
		        complete: function() {
		            //통신이 완료된 후 처리
		            $('#ajax_indicator').fadeOut();
		        },
		        error: function(msg){
		        	alert(msg);
		        }
		
		    });	 	        
	      },
	      "취소": function() {
	        $( this ).dialog( "close" );
	      }
	    }
	  });
	});
	
function doDeleteReserveInfo() {
	var reserveInfo = $(':radio[name="reserve_info"]:checked').val();	
	var postString = {reserve_info : reserveInfo};
	
	if(typeof reserveInfo == "undefined") {
		alert("삭제하실 예약정보를 선택하시기 바랍니다.");
		return false;
	}
	
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/muniv/info/reserve_delete",
        data: postString,  
        dataType : "html",
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        success: function(msg) {
        	$('#resultDIV').append(msg);   
        	alert(msg);
        	location.reload();
        },
	        beforeSend: function() {
         	$('#ajax_indicator1').show().fadeIn('fast');
    	}, 
        complete: function() {
            $('#ajax_indicator1').fadeOut();
        },      
        error: function(msg){
        	alert(msg);
        }
    });	        	
}

function doExcelDownload() {
	
	var f = document.getElementById('searchForm');
	$("#type").val('EXCEL');
	f.method = 'post';
	f.action = '${pageContext.request.contextPath}/muniv/info/reserved_list';
	f.submit();
	
	// 폼정보 초기화
	$("#type").val('');
}

</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">

<c:set var="pb" value="${pageBean }"/>

<div id="ajax_indicator1" style="display:none">
   <p style="text-align:center; padding:16px 0 0 0; left:50%; top:50%; position:absolute;">
   	<img src="${pageContext.request.contextPath }/resources/images/ajax-loader.gif" />
   </p>
</div>

<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom">
      <img src="${pageContext.request.contextPath}/resources/images/admin/notice_title_re2.gif"  alt="강의실관리  타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;정보관리 &nbsp; <img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp; 강의실관리</td>
    </tr>
  </table>
</div>

<form id="searchForm" method="get" onsubmit="javascript:doSearch(); return false;" action="${pageContext.request.contextPath}/muniv/info/reserved_list" autocomplete="off">

	<table width="699" border="0" cellpadding="0" cellspacing="0" class="listcheckbg">
	  <tr>
	    <td align="center" valign="middle"><table width="665" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="66" height="33" align="left">학기 :</td>
	        <td width="130" height="33" align="left">
	        
	        <select name="term_cd" id="lst_term" class="searchlistbox">
	        	<c:forEach var="term" items="${termList }">
	        		<c:choose>
	        			<c:when test="${(term_cd eq term.term_cd && year eq term.year)}">
	        				<option id="${term.year}_${term.term_cd }" value="${term.term_cd }" selected>${term.term_name }</option>
	        			</c:when>
	        			<c:otherwise>
	        				<option id="${term.year}_${term.term_cd }" value="${term.term_cd }">${term.term_name }</option>
	        			</c:otherwise>
	        		</c:choose>
	        	</c:forEach>
	        </select>
	        
	        </td>
	        <td height="33">일자 :</td>
	        <td height="33">
	        <input type="text" id="sdate" name="sdate" class="searchtextbox" value="${sdate }" style="width:80px;" readonly="readonly"> ~ <input type="text" id="edate" name="edate" value="${edate }" class="searchtextbox" style="width:80px;" readonly="readonly"> 
	        </td>
	        <td width="112" rowspan="2">
	        	<button><img src="${pageContext.request.contextPath}/resources/images/prof/check_button.png" width="111" height="53" alt="조회버튼" /></button></td>
	      </tr>
	      <tr align="left">
	        <td width="66" height="33" align="left">강의실 :</td>
	        <td width="250" height="33" align="left" colspan="3">
	        <select name="classroom_no" id="lst_classroom" class="searchlistbox" style="width:300px;">
	        	<option value="">전체</option>
	        	<c:forEach var="list" items="${classroomList }">
	        		<c:choose>
	        			<c:when test="${classroom_no eq list.classroom_no}">
							<option value="${list.classroom_no }" selected>${list.classroom_name }</option>
	        			</c:when>
	        			<c:otherwise>
							<option value="${list.classroom_no }">${list.classroom_name }</option>
	        			</c:otherwise>
	        		</c:choose>
	        	</c:forEach>        	
	        </select>
		    </td>
	      </tr>
	    </table></td>
	  </tr>
	</table>
	<br>
	
	<div id="board">
		<p class="pd_r5 bold t_right mg_b5">[총 ${pb.allCnt }건]</p>
	
		<div id="board_list">	
			<table width="700" border="0" cellspacing="0" cellpadding="0">
				<caption>목록</caption>
				<thead>
					<tr>
				        <th width="52" class="bg_left" scope="col">NO</th>
				        <th width="137" scope="col"><a href="javascript:changeOrder('RESERVE_DATE')">일자</a></th>
				        <th width="98" scope="col"><a href="javascript:changeOrder('CLASSROOM_NO')">강의실</a></th>
				        <th width="97" scope="col"><a href="javascript:changeOrder('START_TIME')">시작시간</a></th>
				        <th width="122" scope="col"><a href="javascript:changeOrder('END_TIME')">종료시간</a></th>
				        <th width="122" scope="col"><a href="javascript:changeOrder('PROF_NAME')">교수</a></th>
					</tr>
				</thead>
				<tbody>
				<c:choose>
					<c:when test="${fn:length(pb.list)==0 }">
						<tr>
							<td class="tdwhite" colspan="6" align="center" style="padding:30px 0 30px 0; border-right:none;">검색결과가 존재하지 않습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="list" items="${pb.list}" varStatus="status">
							<tr class="tr_over">
								<td>
									<input type="radio" id="reserve_info" name="reserve_info" value="${list.univ_cd}|${list.year}|${list.term_cd}|${list.classroom_no}|${list.reserve_date}|${list.start_time}|${list.end_time}" />
									&nbsp;${list.row_no}
								</td>
								<td>${list.reserve_date}</td>
								<td>${list.classroom_no}</td>
								<td>${list.start_time}</td>
								<td>${list.end_time}</td>
								<td>
									<c:choose>
										<c:when test="${list.prof_name ne null}">
											${list.prof_name}(${list.prof_no})
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose> 
				</tbody>
			</table>
		</div> <!-- board_list -->
		
		<c:if test="${ not empty sessionScope.USER_TYPE and sessionScope.USER_TYPE eq '[ROLE_ADMIN]' }">
			<c:if test="${fn:length(pb.list) > 0}">
				<div class="btn_area">
					<div style="text-align: left; float: left;">
						<a href="javascript:doExcelDownload()">
							<img src="${pageContext.request.contextPath }/resources/images/admin/excel_btn.png" alt="엑셀다운로드">
						</a>
					</div>
					<div style="text-align: right;">
						<a href="javascript:doDeleteReserveInfo()"><img src="${pageContext.request.contextPath}/resources/images/admin/reserve_delete_btn.jpg" alt="강의실예약삭제" /></a>
						<a href="javascript:doReserve()"><img src="${pageContext.request.contextPath}/resources/images/admin/reserve_insert_btn.jpg" alt="강의실예약" /></a>
					</div>
				</div>
			</c:if>
		</c:if>		
		
		<div class="pagination">
			<div class="page_num"> 
				<my:pageGroup/>
			</div>
		</div>
	
	</div>
	
	<input type="hidden" id="year" name="year" value="${year }">
	<input type="hidden" id="currentPage" name="currentPage">
	<input type="hidden" id="sortField" name="sortField" value="${param.sortField}">
	<input type="hidden" id="sortOrder" name="sortOrder" value="${param.sortOrder}">
	<input type="hidden" id="type" name="type" value="${param.type}">
					
</form>

<div id="dialog_classroom_reserve" title="강의실예약"></div>	

</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

