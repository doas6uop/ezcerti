<%@ page contentType="text/html; charset=UTF-8"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prof_style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">

<spring:eval expression="@config['makeup_lesson_approval']" var="makeup_lesson_approval"/>

<script>
$(document).ready(function(){
	<sec:authorize ifAnyGranted="ROLE_ADMIN,ROLE_SYSTEM">
		$(".menu3 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_03.gif");
		$(".menu3 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_03.gif");
		$("#in_topmenu3").css("display","block");
		$("#in_menu3").css("display","block");
	</sec:authorize>
	<sec:authorize ifAnyGranted="ROLE_PROF">
		$(".menu12 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_attend_on.gif");
		$(".menu12 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_attend_on.gif");
		showElementTop(12);
		showElement(12);
	</sec:authorize>
	
	var termVal = $("#lst_term option:selected").val();
	splitTerm(termVal);
});

function doChangeTerm(obj) {
	var termVal = $("#lst_term").val();
	
	splitTerm(termVal);
}

function splitTerm(termVal) {
	if(termVal != "") {
		var arrTermVal = termVal.split(":");
		
		$("#curr_year").val(arrTermVal[0]);
		$("#curr_term_cd").val(arrTermVal[1]);
	}	
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
    
    $('#add_sdate').datepicker();
    $('#add_sdate').datepicker("option", "maxDate", $("#add_edate").val());
    $('#add_sdate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#add_edate").datepicker( "option", "minDate", selectedDate );
    });
 
    $('#add_edate').datepicker();
    $('#add_edate').datepicker("option", "minDate", $("#add_sdate").val());
    
    $('#add_edate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#add_sdate").datepicker( "option", "maxDate", selectedDate );
    });
});

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'post';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/muniv/main/classoff_list';
	f.submit();
}

function doSearch(type){
	var f = document.getElementById('searchForm');
	
	if(type != "") {
		f.type.value = type;		
	}
	
	f.method = 'post';
	f.currentPage.value = 1;
	//f.searchValue = "";
	f.action = '${pageContext.request.contextPath}/muniv/main/classoff_list';
	f.submit();
}

function doView(req_no) {
	var targetURL = "${pageContext.request.contextPath}/muniv/main/classoff_view?req_no="+req_no+"&view_type=VIEW";
	
	window.open(targetURL,'classOffPop','width=700, height=460,top=0,left=0,toolbar=no, menubar=no, scrollbars=yes')
}

function doApproval_old() {
	var checkedReqNo = $(':radio[name="req_no"]:checked').val();
	
	if(checkedReqNo != null && checkedReqNo != "") {
		var targetURL = "${pageContext.request.contextPath}/muniv/main/classoff_view?req_no="+checkedReqNo+"&view_type=APPROVAL";
		
		window.open(targetURL,'classOffPop','width=700, height=460,top=0,left=0,toolbar=no, menubar=no, scrollbars=yes')	
	} else {
		alert("처리할 항목을 선택하시기 바랍니다.");
	}	
}

function doApproval(proc_type) {
	approvalProc(proc_type);
}

function approvalProc(proc_type) {
	
	if(!$("input[name=req_no]:checked").prop('checked')) {
		alert("처리할 항목을 선택하시기 바랍니다.");
		return;
	}
	
	if (confirm($('input:checkbox:checked').length + "건의 신청건을 처리하시겠습니까??") == true){    //확인
	    
		// 체크 되어 있는 값 추출
    	var req_no = "";
    	var idx = 0;
		$("input[name=req_no]:checked").each(function() {
			
			idx++;
			tmp = $(this).val().split("||");	
			
			if(idx == 1){
				req_no = tmp[0];
				return true; // continue;
			}
			
			req_no += "," + tmp[0];
        });
		
		$(function(){
			
			$.ajax({
				
			       type: "POST",
			       url: getContextPath()+'/muniv/main/classoff_multi_proc',
			       data: { 
			    	   		req_no : req_no,
			    	   		proc_type : proc_type
			    	     },
			       success: function(msg) {
					
			    	alert(msg);
			        location.href = getContextPath()+'/muniv/main/classoff_list';
				       	
			       },
			       error: function(msg){
			       	alert(msg);
			       }
				       
			});
			
		});
		
	}else{   //취소
	    return;
	}
}

function changeOrder(sortField) {
	if($("#sortOrder").val() == "DESC") {
		$("#sortOrder").val("ASC");
	} else {
		$("#sortOrder").val("DESC");
	}
	$("#sortField").val(sortField);

	doSearch();
}

function doExcelDownload() {
	var searchItem = $("#searchItem").val();
	var searchValue = $("#searchValue").val();

	location.href = '${pageContext.request.contextPath}/muniv/main/classoff_approve_list?type=EXCEL&searchItem='+searchItem+'&searchValue='+searchValue;
}

function doExcelDownload2() {
	var searchItem = $("#searchItem").val();
	var searchValue = $("#searchValue").val();

	location.href = '${pageContext.request.contextPath}/muniv/main/classoff_approve_list?type=EXCEL2&searchItem='+searchItem+'&searchValue='+searchValue+'&curr_year=${year}&curr_term_cd=${term_cd}';
}

function doRunFlag(type) {
	
	if(!$("input[name=chk_no]:checked").prop('checked')) {
		alert("처리할 항목을 선택하시기 바랍니다.");
		return;
	}
	
	if (confirm($('input[name=chk_no]:checked').length + "건의 데이터를 처리하시겠습니까??") == true){    //확인
	    
		// 체크 되어 있는 값 추출
    	var chk_no = "";
		var classoff_flag = "";
		var sayu = "";
    	var idx = 0;
    	
		$("input[name=chk_no]:checked").each(function() {
			
			idx++;
			
			if(idx == 1){
				chk_no = $(this).val();
				return true; // continue;
			}
			
			chk_no += "," + $(this).val();
        });
		
		if(type == 'Y') { // 실시처리
			
			classoff_flag = "Y";
			sayu = "";
			
			$(function(){
				
				$.ajax({
					
				       type: "POST",
				       url: getContextPath()+'/muniv/main/classoff_change_flag',
				       data: { 
				    	   		chk_no : chk_no,
				    	   		classoff_flag : classoff_flag,
				    	   		sayu : sayu
				    	     },
				       success: function(msg) {
						
				    	alert(msg);
				        location.href = getContextPath()+'/muniv/main/classoff_list';
					       	
				       },
				       error: function(msg){
				       	alert(msg);
				       }
					       
				});
				
			});
			
		} else { // 미실시 처리, 사유입력 팝업호출
			
			$("#dialog_classoff_run_flage_form").load(getContextPath()+'/muniv/main/classoff_change_flag_popup',{chk_no : chk_no});
			$('#dialog_classoff_run_flage_form').dialog('open');
			$('#ajax_indicator1').show().fadeIn('fast');
		}
		
	}else{   //취소
	    return;
	}
	
}

$(function() {

  $( "#dialog_classoff_run_flage_form" ).dialog({
    autoOpen: false,
    resizable: false,
    draggable: false,
    width:250,
    height:213,
    modal: true,
    buttons: {
      "등록": function() {
    	  
			$( this ).dialog( "close" );
			
			var chk_no = $("#classoff_form [name='chk_no']").val();
			var classoff_flag = $("#classoff_form [name='classoff_flag']").val();
			var sayu = $("#classoff_form [name='sayu']").val();
			
			$(function(){
			
				$.ajax({
					
				       type: "POST",
				       url: getContextPath()+'/muniv/main/classoff_change_flag',
				       data: { 
				    	   		chk_no : chk_no,
				    	   		classoff_flag : classoff_flag,
				    	   		sayu : sayu
				    	     },
				       success: function(msg) {
						
				    	alert(msg);
				        location.href = getContextPath()+'/muniv/main/classoff_list';
					       	
				       },
				       error: function(msg){
				       	alert(msg);
				       }
					       
				});
					
			});
    	  
      },
      "취소": function() {
        $( this ).dialog( "close" );
      }
    }
  });
});

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
							<td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/title_03_01.gif"  alt="휴강 신청 내역" /></td>
							<td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;휴.보강처리&nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp;휴강 신청 내역</td>
						</tr>
					</table>
				</div>

				<form id="searchForm" onsubmit="javascript:doSearch(); return false;" method="post" autocomplete="off">

					<table width="699" border="0" cellpadding="0" cellspacing="0" class="listcheckbg">
					  <tr>
					    <td align="center" valign="middle">
						    <table width="675" border="0" cellspacing="0" cellpadding="0">
						      <tr>
						        <td width="60" height="33" align="left">검색조건 :</td>
						        <td width="240" height="33" align="left">
						        	<select name="term_cd" id="lst_term" class="searchlistbox" onChange="javascript:doChangeTerm(this)">
							        	<c:forEach var="term" items="${termList }">
							        		<c:choose>
							        			<c:when test="${year eq term.year and term_cd eq term.term_cd}">
							        				<option value="${term.year}:${term.term_cd }" selected="selected">${term.term_name }</option>
							        			</c:when>
							        			<c:otherwise>
							        				<option value="${term.year}:${term.term_cd }">${term.term_name }</option>
							        			</c:otherwise>
							        		</c:choose>
							        	</c:forEach>
							        </select>
							        <select name="searchItem" id="searchItem" style="width: 60px;" class="searchlistbox">
							        	<option value="class_name" <c:if test="${param.searchItem eq 'class_name'}"> selected </c:if>>
							        		과목명
							        	</option>
										<option value="prof_name" <c:if test="${param.searchItem eq 'prof_name'}"> selected </c:if>>
											신청인
										</option>
										<%-- <option value="proc_status" <c:if test="${param.searchItem eq 'proc_status'}"> selected </c:if>>
											처리상태
										</option> --%>
							        </select>
							        <input type="text" id="searchValue" name="searchValue" value="${param.searchValue}" class="searchtextbox" style="padding-top: 0px; width: 80px; height: 20px;">
						        </td>
						        <td width="60" height="33" align="left">처리상태 :
						        <td width="165" height="33" align="left">
							        <select name="procStatus" id="procStatus" style="width: 60px;" class="searchlistbox">
										<option value="" <c:if test="${procStatus eq ''}"> selected </c:if> ${varStatusEnable}>전체</option>
										<option value="G030C001" <c:if test="${procStatus eq 'G030C001'}"> selected </c:if> ${varStatusEnable}>신청</option>
							        	<option value="G030C002" <c:if test="${procStatus eq 'G030C002'}"> selected </c:if> ${varStatusEnable}>승인</option>
										<option value="G030C004" <c:if test="${procStatus eq 'G030C004'}"> selected </c:if> ${varStatusEnable}>취소신청</option>
										<option value="G030C005" <c:if test="${procStatus eq 'G030C005'}"> selected </c:if> ${varStatusEnable}>취소승인</option>
							        </select>
						        </td>
						        <td width="80" rowspan="2">
						        	<button onclick="javascript:doSearch('');"><img src="${pageContext.request.contextPath}/resources/images/prof/check_button.png" width="111" height="53" alt="조회버튼" /></button>
						       	</td>
						      </tr>
						      
						      <tr align="left">
						        <td width="56" height="33" align="left">휴강일자 :</td>
						        <td width="33" align="left">
						        	<input type="text" id="sdate" name="sdate" class="searchtextbox" value="${startDate }" style="width:70px;" readonly="readonly"> ~ <input type="text" id="edate" name="edate" value="${endDate }" class="searchtextbox" style="width:70px;" readonly="readonly">
							    </td>
							    <td width="56" height="33" align="left">보강일자 :</td>
						        <td height="33" align="left">
						        	<input type="text" id="add_sdate" name="add_sdate" class="searchtextbox" value="${addStartDate }" style="width:70px;" readonly="readonly"> ~ <input type="text" id="add_edate" name="add_edate" value="${addEndDate }" class="searchtextbox" style="width:70px;" readonly="readonly">
							    </td>
						      </tr>
						      
						    </table>
					    </td>
					  </tr>
					</table>
			
					<div id="board" class="mg_t40">
			
						<p class="pd_r5 bold t_right mg_b5">[총 ${pb.allCnt }건]</p>
						<div id="board_list">
							<table border="0" cellspacing="0" summary="메모 목록 - 보낸사람, 받는사람, 내용, 보낸날짜, 확인날짜">
								<caption>게시판 목록</caption>
								<thead>
									<tr>
										<th width="73px;" scope="col" ><!-- <a href="javascript:changeOrder('REQ_NO')"> -->신청번호<!-- </a> --></th>
										<th width="40px;" scope="col"><a href="javascript:changeOrder('PROF_NAME')">교수</a></th>
										<th width="75px;" scope="col"><a href="javascript:changeOrder('CLASS_NAME')">과목</a></th>
										<th width="30px;" scope="col"><a href="javascript:changeOrder('CLASSDAY')">휴강</a></th>
										<th width="30px;" scope="col"><a href="javascript:changeOrder('ADD_CLASSDAY')">보강</a></th>
										<th width="50px;" scope="col"><a href="javascript:changeOrder('REQ_REASON')">사유</a></th>
										<th width="40px;" scope="col"><a href="javascript:changeOrder('REQ_DATE')">신청일</a></th>
										<th width="40px;" scope="col"><!-- <a href="javascript:changeOrder('PROC_STATUS')"> -->처리상태<!-- </a> --></th>
										<th width="45px;" scope="col"><!-- <a href="javascript:changeOrder('PROC_STATUS')"> -->실시여부<!-- </a> --></th>
										<!-- <th width="50px;" scope="col"><a href="javascript:changeOrder('PROC_STATUS')">사유</a></th> -->
										<!-- th scope="col">상세내역</th-->
									</tr>
								</thead>
								<tbody>
									<c:if test="${fn:length(pb.list) <= 0}">
									<tr>
										<td colspan="9" align="center">검색된 내용이 없습니다.</td>
									</tr>
									</c:if>
									<c:if test="${fn:length(pb.list) > 0}">
										<c:set var="procStatusFlag" value="" />
										<c:forEach var="list" items="${pb.list}">
										<tr>
											<td>
												<c:if test="${sessionScope.USER_TYPE eq '[ROLE_ADMIN]' || sessionScope.USER_TYPE eq '[ROLE_SYSTEM]'}">
													<c:choose>
														<c:when test="${list.proc_status eq 'G030C001' or list.proc_status eq 'G030C004'}">
															<c:set var="procStatusFlag" value="" />
														</c:when>
														<c:otherwise>
															<c:set var="procStatusFlag" value="disabled" />
														</c:otherwise>
													</c:choose>
														<label for="chek_box" class="alternate">휴강신청 선택</label>
														<input type="checkbox" id="req_no" name="req_no" style="margin:-4px -1px 0 0; vertical-align:middle;" value="${list.req_no}" ${procStatusFlag} />
												</c:if>
												${list.req_no}
											</td>
											<td>${list.prof_name}</td>
											<td title="사유 : ${list.sayu}"><a href="javascript:doView('${list.req_no}')">${list.class_name}<br/>(${list.add_classroom_no})</a></td>
											<td>${list.classday}<br/>(${list.classhour_start_time}~${list.classhour_end_time})</td>
											<td>${list.add_classday}<br/>(${list.add_classhour_start_time}~${list.add_classhour_end_time})</td>
											<td>${list.req_reason}</td>
											<td><fmt:formatDate value="${list.req_date}" type="both" pattern="YY/MM/dd"/><%-- ${list.req_date} --%></td>
											<td>${list.proc_status_nm}</td>
											<td title="사유 : ${list.sayu}">
												<label for="chek_box" class="alternate">보강실시여부 선택</label>
												<input type="checkbox" id="chk_no" name="chk_no" style="margin:-4px -1px 0 0; vertical-align:middle;" value="${list.req_no}" />
												
												<c:choose>
													<c:when test="${list.classoff_flag eq 'Y' }">
														실시
													</c:when>
													<c:otherwise>
														미실시
													</c:otherwise>
												</c:choose>
											</td>
											<!-- <td>이것저것등</td> -->
										</tr>
										</c:forEach>					
									</c:if>
								</tbody>
							</table>
						</div>

						<c:if test="${ not empty sessionScope.USER_TYPE and (sessionScope.USER_TYPE eq '[ROLE_ADMIN]' or sessionScope.USER_TYPE eq '[ROLE_SYSTEM]')}">
							<c:if test="${fn:length(pb.list) > 0}">
								<div class="btn_area">
									<div style="text-align: left; float: left;">
										<a href="javascript:doApproval('APPROVAL')"><img src="${pageContext.request.contextPath}/resources/images/admin/conf_btn.gif" alt="승인처리" /></a>
										<a href="javascript:doApproval('REJECT')"><img src="${pageContext.request.contextPath}/resources/images/admin/return_btn.gif" alt="반려처리" /></a>
										<%--
										<a href="javascript:doExcelDownload()">
											<img src="${pageContext.request.contextPath }/resources/images/admin/excel_btn.png">
										</a>
										--%>
										<a href="javascript:doExcelDownload2()">
											<img src="${pageContext.request.contextPath }/resources/images/admin/excel_btn.png" alt="엑셀다운로드">
										</a>
									</div>
									<div style="text-align: right;">
										<a href="javascript:doRunFlag('Y')">
											<img src="${pageContext.request.contextPath}/resources/images/admin/classoff_exec_btn.jpg" alt="실시" />
										</a>
										<a href="javascript:doRunFlag('N')">
											<img src="${pageContext.request.contextPath }/resources/images/admin/classoff_noexec_btn.jpg" alt="미실시">
										</a>
									</div>
								</div>
							</c:if>
						</c:if>		

						<div class="pagination" style="padding:10px 0 10px 0">
							<table width="700" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td height="18" align="center" class="paginggrayfont"><my:pageGroup/></td>
								</tr>
							</table>	
						</div>
	
					</div>
	
					<input type="hidden" id="currentPage" name="currentPage" value="${param.currentPage}">
					<input type="hidden" id="curr_year" name="curr_year">
					<input type="hidden" id="curr_term_cd" name="curr_term_cd">
					<input type="hidden" id="sortField" name="sortField" value="${param.sortField}">
					<input type="hidden" id="sortOrder" name="sortOrder" value="${param.sortOrder}">
					<input type="hidden" id="type" name="type" value="${param.type}">
				</form>

			</div>
		</div>
		<div id="dialog_classoff_run_flage_form" title="보강미실시 사유등록"></div>
		
		<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
		<div style="clear: both;"></div>
		<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
	</div>
</body>
</html>