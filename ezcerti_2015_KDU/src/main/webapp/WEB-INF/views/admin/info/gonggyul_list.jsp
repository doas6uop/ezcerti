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
	f.action = '${pageContext.request.contextPath}/muniv/info/gonggyul_list';
	f.submit();
}

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/muniv/info/gonggyul_list';
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

function validationCheck() {
	
	if(!$("input[name=chk_no]:checked").prop('checked')) {
		alert("삭제할 리스트를 체크해 주시기 바랍니다.");
		return;
	}
	
	if (confirm($('input:checkbox:checked').length + "건의 리스트를 삭제하시겠습니까?") == true){    //확인
	    
		// 체크 되어 있는 값 추출
    	var chk_no = "";
    	var idx = 0;
    	
		$("input[name=chk_no]:checked").each(function() {
			
			idx++;
			
			if(idx == 1){
				chk_no = $(this).val();
				return true; // continue;
			}
			chk_no += "," + $(this).val();
        });
		
		$(function(){
			
			$.ajax({
				
			       type: "POST",
			       url: getContextPath()+'/muniv/info/gonggyul_delete',
			       data: { 
			    	   		chk_no : chk_no
			    	     },
			       success: function(msg) {
					
			    	alert("삭제처리가 완료 되었습니다.");
			        location.href = getContextPath()+'/muniv/info/gonggyul_list';
				       	
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

function searchAction() {
	
	var f = document.getElementById('searchForm');
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
	
	f.submit();
}

function doExcelDownload() {
	
	var f = document.getElementById('searchForm');
	$("#type").val('EXCEL');
	f.method = 'post';
	f.action = '${pageContext.request.contextPath}/muniv/info/gonggyul_list';
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
					  <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/sub_admin_title_04.gif"  alt="공결관리" /></td>
					  <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;관리자 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp;공결관리</td>
				    </tr>
				  </table>
				</div>
				
				<form id="searchForm" method="get" action="${pageContext.request.contextPath}/muniv/info/gonggyul_list" autocomplete="off">
				 
					<table width="699" border="0" cellpadding="0" cellspacing="0" class="listcheckbg">
					  <tr>
					    <td align="center" valign="middle"><table width="665" border="0" cellspacing="0" cellpadding="0">
					      
					      <tr>
					        <td width="66" height="33" align="left">검색조건 :</td>
					        <td width="220" height="33" align="left">
						        <select name="search_type" id="lst_term" style="width: 60px;" class="searchlistbox">
						        	<option value="student_name" <c:if test="${param.search_type eq 'student_name'}"> selected </c:if>>
						        		이름
						        	</option>
									<option value="student_no" <c:if test="${param.search_type eq 'student_no'}"> selected </c:if>>
										학번
									</option>
									<option value="class_name" <c:if test="${param.search_type eq 'class_name'}"> selected </c:if>>
										과목
									</option>
						        </select>
						        <input type="text" name="search_value" value="${param.search_value}" class="searchtextbox" style="padding-top: 0px; width: 120px; height: 18px;">
					        </td>
					        
					        <td height="33">학기 :</td>
					        <td height="33">
						        <select name="term_cd" id="lst_classroom" class="searchlistbox" style="width:150px;">
									<option value="all" <c:if test="${param.term_cd eq 'all'}"> selected </c:if>>
						        		전체
						        	</option>
									<option value="G002C001" <c:if test="${param.term_cd eq 'G002C001'}"> selected </c:if>>
						        		1학기
						        	</option>
									<option value="G002C002" <c:if test="${param.term_cd eq 'G002C002'}"> selected </c:if>>
										2학기
									</option>
						        </select>
					        </td>
					        
					        <td width="112" rowspan="2">
					        	<button type="button" onclick="searchAction()"><img src="${pageContext.request.contextPath}/resources/images/prof/check_button.png" width="111" height="53" alt="조회버튼" /></button>
					       	</td>
					      </tr>
					      
					      <tr align="left">
					        <td width="66" height="33" align="left">공결일자 :</td>
					        <td width="220" height="33" align="left">
					        	<input type="text" id="sdate" name="sdate" class="searchtextbox" value="${sdate }" style="width:80px;" readonly="readonly"> ~ <input type="text" id="edate" name="edate" value="${edate }" class="searchtextbox" style="width:80px;" readonly="readonly">
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
								        <th width="8%" class="bg_left" scope="col"></th>
								        <th width="5%" scope="col">NO</th>
								        <th width="10%" scope="col"><a href="javascript:changeOrder('STUDENT_NO')">학번</a></th>
								        <th width="10%" scope="col"><a href="javascript:changeOrder('STUDENT_NAME')">이름</a></th>
								        <th width="7%" scope="col"><a href="javascript:changeOrder('TERM_CD')">학기</a></th>
								        <th width="15%" scope="col"><a href="javascript:changeOrder('GONG_ILJA_START')">공결기간</a></th>
								        <th width="20%" scope="col">과목</th>
								        <th width="10%" scope="col">공결시간</th>
								        <th width="auto" scope="col">사유</th>
								        <th width="10%" scope="col">제출</th>
									</tr>
								</thead>
								<tbody>
								<c:choose>
									<c:when test="${fn:length(pb.list)==0 }">
										<tr>
											<td class="tdwhite" colspan="9" align="center" style="padding:15px 0 15px 0; border-right:none;">검색결과가 존재하지 않습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="list" items="${pb.list}" varStatus="status">
											<tr class="tr_over">
												<td>
													<!-- 
														- 삭제조건
														: 현재일이 공결기간에 포함되어 있으면 (이미 공결처리 중이면)삭제 불가 (체크박스 나타나지 않도록 처리)
														: 현재일이 공결기간을 지난 경우도 삭제 불가 (이미 공결처리를 했기 때문)
														: 현재일이 공결기간 이전의 경우에만 삭제 가능
													 -->
												 	<c:if test="${list.checkbox_flag == 'Y'}">
														<input type="checkbox" name="chk_no" id="chk_no" value="${list.gonggyul_no}">
													</c:if>
												</td>
												<td>${list.row_no}</td>
												<td>${list.student_no}</td>
												<td><a href="${pageContext.request.contextPath}/muniv/info/gonggyul_view?gonggyul_no=${list.gonggyul_no}">${list.student_name}</a></td>
												<td>
													<c:choose>
														<c:when test="${list.term_cd == 'G002C001'}">
															1학기
														</c:when>
														<c:otherwise>
															2학기
														</c:otherwise>
													</c:choose>
												</td>
												<td>${list.gong_ilja_start} ~ ${list.gong_ilja_end}</td>
												<td>
													<c:forEach var="list_subject" items="${list.gonggyulSubjectList}">
														<p style="text-align: left;">${list_subject.class_name}(${list_subject.classday_name})${list_subject.classhour_start_time}</p>
													</c:forEach>
												</td>
												<td>
													<c:forEach var="list_subject" items="${list.gonggyulSubjectList}">
														<p>${list_subject.class_real_cnt}/${list_subject.class_total_cnt}</p>
													</c:forEach>
												</td>
												<td>${list.gong_sayu}</td>
												<td>${list.submit_date}</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose> 
								</tbody>
							</table>
						</div> <!-- board_list -->
						
						<c:if test="${ not empty sessionScope.USER_TYPE and sessionScope.USER_TYPE eq '[ROLE_ADMIN]' }">
							<div class="btn_area">
								<span style="float: left;">
									<a href="javascript:validationCheck()"><img src="${pageContext.request.contextPath}/resources/images/board/del_btn.gif" alt="삭제" /></a>
									<a href="javascript:doExcelDownload()">
										<img src="${pageContext.request.contextPath }/resources/images/admin/excel_btn.png" style="height: 25px;" alt="엑셀다운로드">
									</a>
								</span>
								<span>
									<a href="/muniv/info/gonggyul_insert_form"><img src="${pageContext.request.contextPath}/resources/images/admin/insert_btn.gif" alt="등록" /></a>
								</span>
							</div>
						</c:if>		
						
						<div class="pagination">
							<div class="page_num"> 
								<my:pageGroup/>
							</div>
						</div>
					<!-- 
					<span style="font-size:12px; font-weight:bold;">
					[공결처리 전제 조건 및 보완사항]<br/>
					- 삭제조건<br/>
					  : 현재일이 공결기간에 포함되어 있으면 (이미 공결처리 중이면)삭제 불가 (체크박스 나타나지 않도록 처리)<br/>
					  : 현재일이 공결기간을 지난 경우도 삭제 불가 (이미 공결처리를 했기 때문)<br/>
					  : 현재일이 공결기간 이전의 경우에만 삭제 가능<br/><br/>
					- 수행조건<br/>
					  : 강의가 완료된 강의에 대해서 모든 공결자의 공결 처리 진행 (일일 배치로만 수행)<br/> 
					</span>
					 -->
					</div>
					<input type="hidden" id="currentPage" name="currentPage">
					<input type="hidden" id="sortField" name="sortField" value="${param.sortField}">
					<input type="hidden" id="sortOrder" name="sortOrder" value="${param.sortOrder}">
					<input type="hidden" id="type" name="type" value="${param.type}">
					
				</form>
			</div>
		</div>
		<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
		<div style="clear: both;"></div>
		<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
	</div>
</body>

</html>


