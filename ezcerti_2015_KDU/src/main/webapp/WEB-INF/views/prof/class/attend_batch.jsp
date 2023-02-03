<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" uri="/my-taglib"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=10; IE=9; IE=8; IE=7; IE=EDGE" />
<meta charset="utf-8">

<title><spring:eval expression="@config['univ_title']" /> :: 온라인출석부</title>

<spring:eval expression="@config['attend_authority_period']" var="attend_authority_period"/>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prof_style.css">
<!--[if lte IE 8]><![endif]-->
<!--[if gte IE 9]>  
<style type="text/css">
/*
  Hide radio button (the round disc)
  we will use just the label to create pushbutton effect
*/
input[type=radio] {
    display:none; 
    margin:10px;
}
 
/*
  Change the look'n'feel of labels (which are adjacent to radiobuttons).
  Add some margin, padding to label
*/
input[type=radio] + label {
    display:inline-block;
    margin:-2px;
    padding: 4px 11px;
    background-color: #fdfdfd;
    border:1px solid #eee;
    cursor: pointer;
}
/*
 Change background color for label next to checked radio button
 to make it look like highlighted button
*/
input[type=radio][id*=present]:checked + label { 
   background-image: none;
   color: #fff;
   background-color:#3a8bb9;
}
input[type=radio][id*=late]:checked + label { 
   background-image: none;
   color: #fff;
   background-color:#c5a051;
}
input[type=radio][id*=absent]:checked + label { 
   background-image: none;
   color: #fff;
   background-color:#b83943;
}

</style>
<![endif]-->
<!--[if !IE]><!-->
<style type="text/css">
/*
  Hide radio button (the round disc)
  we will use just the label to create pushbutton effect
*/
input[type=radio] {
	display: none;
	margin: 10px;
}

/*
  Change the look'n'feel of labels (which are adjacent to radiobuttons).
  Add some margin, padding to label
*/
input[type=radio]+label {
	display: inline-block;
	margin: -3px;
	padding: 4px 4px;
	/* padding: 4px 11px; */
	background-color: #fdfdfd;
	border: 1px solid #eee;
	cursor: pointer;
}
/*
 Change background color for label next to checked radio button
 to make it look like highlighted button
*/
input[type=radio][id*=present]:checked+label {
	background-image: none;
	color: #fff;
	background-color: #3a8bb9;
}

input[type=radio][id*=late]:checked+label {
	background-image: none;
	color: #fff;
	background-color: #c5a051;
}

input[type=radio][id*=absent]:checked+label {
	background-image: none;
	color: #fff;
	background-color: #b83943;
}

.gonggyul_sts_div {
	display: inline-block;
	margin: -3px;
	padding: 4px 4px;
	/* padding: 4px 11px; */
	background-color: #AB65D1;
	border: 1px solid #eee;
	cursor: pointer;
	color: #fff;
}

.attend_sts_label {
	background-color: #fdfdfd;
	padding: 7px 7px;
	border: 1px solid #eee;
}

.attend_01 {
	color: #fff;
	background-color: #3a8bb9;
}

.attend_02 {
	color: #fff;
	background-color: #c5a051;
}

.attend_03 {
	color: #fff;
	background-color: #b83943;
}

.attend_04 {
	color: #fff;
	background-color: #AB65D1;
}

</style>
<!--<![endif]-->
<script>

	var statusClassday = 0;
	var statusClasshour = 0;
	$(document).ready(function() {});
	
	 <%
	 	SimpleDateFormat  formatter1 = new SimpleDateFormat("yyyy-MM-dd");
		    String nowDate =  formatter1.format(new Date());
	 %>
	 var nowDate = <%="'" + nowDate + "'"%>;
	
	function statusCheck(classday, classhour_start_time) {
	
	<%
		Calendar oCalendar = Calendar.getInstance();
		
		// 현재 날짜/시간 등의 각종 정보 얻기
		String currentDate = "";
		currentDate = String.valueOf(oCalendar.get(Calendar.YEAR)) + "-";
		currentDate += (oCalendar.get(Calendar.MONTH) + 1) > 9 ? "" + String.valueOf(oCalendar.get(Calendar.MONTH) + 1) : '0' + String.valueOf(oCalendar.get(Calendar.MONTH) + 1);
		currentDate += "-" + ((oCalendar.get(Calendar.DAY_OF_MONTH)) > 9 ? "" + String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH)) : '0' + String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH)));
	%>
	
	var currentDate = <%="'" + currentDate + "'"%>;

		if (classday > currentDate) {
			alert("출결처리 시간이 아닙니다.");
			return false;
		}

		if (statusClassday == 0 && statusClasshour == 0) {
			statusClassday = classday;
			statusClasshour = classhour_start_time;
		} else if (statusClassday != 0 && statusClasshour != 0) {
			if (statusClassday == classday
					&& statusClasshour == classhour_start_time) {
				return true;
			} else {
				alert("수정중인 데이터가 존재합니다.\r\n먼저 " + statusClassday + " "
						+ classhour_start_time + "일의 출결정보를 변경해주세요.");
				return false;
			}
		}
	}

	function scrollAll() {
		document.all.leftDisplay.scrollTop = document.all.mainDisplay.scrollTop;
		document.all.topLine.scrollLeft = document.all.mainDisplay.scrollLeft;
	}
	
	function chgAttend(classday, classhour_start_time) {

		if ((statusClassday == 0 && statusClasshour == 0)
				|| (statusClassday == classday && statusClasshour == classhour_start_time)) {
			statusClassday = classday;
			statusClasshour = classhour_start_time;
			var classhour = classhour_start_time.replace(":", "\\:");
			$("." + classday + "_" + classhour + "Present").prop("checked",
					true);
		} else {
			statusCheck(classday, classhour_start_time);
		}
	}
	
	function checkSubmit(classday, classhour_start_time) {
		<c:choose>
			<c:when test="${sessionScope.PROF_INFO.prof_adm_cd=='G026C002' }">
				alert("학기가 마감되어 변경이 불가능합니다.");
				window.location.reload(true);
			</c:when>
			<c:otherwise>
		    
				if (checkAttendAuth(classday, "${attend_authority_period}", nowDate)) {
					
					if ((statusClassday == 0 && statusClasshour == 0)
							|| (statusClassday == classday && statusClasshour == classhour_start_time)) {
						var classhour = classhour_start_time.replace(":", "\\:");
						var attendeeCnt = ($("input[type=radio][id*=" + classday + "_"
								+ classhour + "]").length / 3);
						var checkedAttendeeCnt = $("input[type=radio][id*=" + classday
								+ "_" + classhour + "]:checked").length;
						if (checkedAttendeeCnt == attendeeCnt) {
							$("#attend_reason_popup").data("classday", classday).data(
									"classhour_start_time", classhour).dialog("open");
						} else {
							alert("변경되지 않은 학생이 " + (attendeeCnt - checkedAttendeeCnt)
									+ "명 존재합니다.");
						}
					} else {
						statusCheck(classday, classhour_start_time);
					}
				} else {
					alert("출결처리 시간이 아닙니다.");
				}
			</c:otherwise>
		</c:choose>
	}
	
	$(function() {
		$("#attend_reason_popup")
				.dialog(
						{
							autoOpen : false,
							resizable : false,
							draggable : false,
							height : 180,
							modal : true,
							buttons : {
								"변경완료" : function() {
									var classday = $(this).data("classday");
									var classhour_start_time = $(this).data(
											"classhour_start_time");
									var checkList = new Array();
									var postString = new Array();
									checkList = $("input[type=radio][id*="
											+ classday + "_"
											+ classhour_start_time
											+ "]:checked");
									for (var i = 0; i < checkList.length; i++) {
										postString[i] = checkList[i].value
												+ "|"
												+ $("#select_reason_code")
														.val();
									}
									$
											.ajax({
												type : "POST",
												url : "${pageContext.request.contextPath}/prof/class/attend_batch",
												data : {
													attendStatus : postString,
													class_cd : '${lectureDetail.class_cd}'
												}, //post 형식 전송형태 data: {인자명 : 데이터, num:num},
												success : function(msg) {
													alert(msg);
													$("#attend_reason_popup")
															.dialog("close");

													// 선택관련 인자 초기화
													statusClassday = 0;
													statusClasshour = 0;

													//window.location.reload(true);
												},
												beforeSend : function() {
													//통신을 시작할때 처리
													//jQuery('.ui-dialog button').button('disable');
													$('#ajax_indicator').show()
															.fadeIn('fast');
												},
												complete : function() {
													//통신이 완료된 후 처리
													$('#ajax_indicator')
															.fadeOut();
												},
												error : function(msg) {
													alert(msg);
												}
											});

								},
								"취소" : function() {
									$(this).dialog("close");
								}
							}
						});
	});
	
</script>
</head>
<body>
	<div style="padding: 10px;">
		<!-- 교수 출결일괄처리 -->
		<div class="titlebg">
			<table width="670" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="320" height="75" align="left" valign="bottom"><img
						src="${pageContext.request.contextPath}/resources/images/prof/professor_batch_title.png"
						alt="출결일괄처리  타이틀" /></td>
					<td width="340" align="right" valign="bottom"><img
						src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png"
						width="22" height="12" alt="홈아이콘" /> &nbsp;출결관리 &nbsp; <img
						src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png"
						width="4" height="12" alt="화살표" /> &nbsp;출결 일괄 처리</td>
				</tr>
			</table>
		</div>
		<table width="699" border="0" cellpadding="0" cellspacing="0"
			class="listcheckbg">
			<tr>
				<td align="center" valign="middle"><table width="665"
						border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="600" height="30" align="left" colspan="4">·
								${lectureDetail.class_name }</td>
						</tr>
						<tr align="left">
							<td align="left">· ${lectureDetail.classday_name }요일
								${classhour_name } ${lectureDetail.classhour_start_time } ~
								${lectureDetail.classhour_end_time }</td>
							<td height="30">· 과목코드 : ${lectureDetail.subject_cd }-${lectureDetail.subject_div_cd }</td>
							<td>· 개설학과 : ${lectureDetail.prof_dept_name }</td>
							<td>· 수강생수 : ${lectureDetail.attendee_cnt }명</td>
						</tr>
					</table></td>
			</tr>
		</table>

		<div style="margin-top: 5px; width: 699px;">
			<div style="margin: 7px 3px; display: inline-block; float: left;">
				<label class="attend_sts_label">출결전</label> 
				<label class="attend_sts_label attend_01">출석</label> 
				<label class="attend_sts_label attend_02">지각</label> 
				<label class="attend_sts_label attend_03">결석</label>
				<label class="attend_sts_label attend_04">공결</label>
			</div>
			<div style="text-align: right;">
				<a href="${pageContext.request.contextPath}/prof/class/attend_batch?class_cd=${lectureDetail.class_cd }&type=EXCEL">
					<img src="${pageContext.request.contextPath }/resources/images/common/e_down_button.png">
				</a>
			</div>
		</div>

		<div style="margin-top: 5px; width: 100%;">

			<c:choose>
				<c:when test="${empty batchList}">
					강의정보가 없습니다.
				</c:when>
				<c:otherwise>
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td width="160">
								<table cellspacing="0" cellpadding="0" border="0">
									<tr height="30">
										<td width="26" align="center" valign="middle" class="tdgray">NO</td>
										<td width="74" align="center" valign="middle" class="tdgray">학생명</td>
										<td width="62" align="center" valign="middle" class="tdgray" style="border-right: 2px solid #999;">학번</td>
									</tr>
								</table>
							</td>
							<td width="983">
								<div id="topLine"
									style="width: 983px; height: 35px; overflow: hidden;">
									<table width=auto; cellspacing="0" cellpadding="0" border="0">
										<tr height="30">
											<c:forEach var="batch" items="${batchList}">
												<td align="center" valign="middle" class="tdgray" style="width: 65px;">
													<fmt:formatDate value="${batch.classday}" type="both" pattern="MM-dd" />
												</td>
											</c:forEach>
										</tr>
										<tr>
											<c:forEach var="batch" items="${batchList}">
												<td class="tdwhite" valign="middle"
													style="padding: 4px 3px 0 3px;"><img
													src="${pageContext.request.contextPath}/resources/images/prof/attendbatch_button.png"
													width="58" height="24" alt="일괄출석버튼"
													style="cursor: pointer;" /></td>
											</c:forEach>
										</tr>
									</table>
								</div>
							</td>
						</tr>
						<tr>
							<td width="160" valign="top">
								<div id="leftDisplay"
									style="width: 164px; height: 627px; overflow: hidden;">
									<table cellspacing="0" cellpadding="0" border="0">

										<c:forEach var="attendeeList" items="${batchList[0].attenddethist }">
											<tr height="25" id="attendee_${attendeeList.row_no }">
												<td width="27" align="center" valign="middle"
													class="tdwhite">${attendeeList.row_no }
												</td>
												<td width="80" align="center" valign="middle"
													class="tdwhite">${attendeeList.student_name }
												</td>
												<td width="63" align="center" valign="middle"
													class="tdwhite" style="border-right: 2px solid #999;">${attendeeList.student_no }
												</td>
											</tr>
										</c:forEach>

										<tr height="61">
											<td class="tdwhite" colspan="3"
												style="border-right: 2px solid #999;">&nbsp;</td>
										</tr>
									</table>
								</div>
							</td>
							<td width="983" valign="top">
								<div id="mainDisplay"
									style="width: 1000px; height: 644px; overflow: scroll"
									onscroll="scrollAll()">
									<table width=auto; cellspacing="0" cellpadding="0" border="0">
										<c:forEach var="attendeeList" items="${batchList[0].attenddethist }">
											<tr height="25">
												<c:forEach var="bList" items="${batchList }" varStatus="status">
													<c:if test="${bList.class_type_cd=='G019C002' }">
														<td class="tdwhite" style="width: 65px;">휴강</td>
													</c:if>
													<c:if test="${bList.class_type_cd!='G019C002' }">
														<td class="tdwhite" style="width: 65px;"
															onmouseover="$('#attendee_${bList.attenddethist[attendeeList.row_no-1].row_no}').css('background-color','#ccddee')"
															onmouseout="$('#attendee_${bList.attenddethist[attendeeList.row_no-1].row_no}').css('background-color','#fff')">
															<form id="form_${bList.classday}_${bList.classhour_start_time}">
																<c:choose>
																	<c:when test="${bList.attenddethist[attendeeList.row_no-1].reg_etc=='GONGGYUL'}">
																		<div class="gonggyul_sts_div">공결</div>
																	</c:when>
																	<c:otherwise>
																		<c:if test="${bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C001'||bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C002'||bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C003'||bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C004'}">
																			<input type="radio" class="${bList.classday}_${bList.classhour_start_time }Present"
																				id="radio_${bList.classday}_${bList.classhour_start_time }_${bList.attenddethist[attendeeList.row_no-1].row_no}_present"
																				name="radios" value="${bList.attenddethist[attendeeList.row_no-1].classday}|${bList.attenddethist[attendeeList.row_no-1].classhour_start_time}|${bList.attenddethist[attendeeList.row_no-1].student_no}|G023C002"
																				<c:if test="${bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C002'}"> checked="checked"</c:if>>
																			<label for="radio_${bList.classday}_${bList.classhour_start_time }_${bList.attenddethist[attendeeList.row_no-1].row_no}_present"
																				onclick="return statusCheck('${bList.classday}','${bList.classhour_start_time }')">출</label>
																			<input type="radio" class="${bList.classday}_${bList.classhour_start_time }Late"
																				id="radio_${bList.classday}_${bList.classhour_start_time}_${bList.attenddethist[attendeeList.row_no-1].row_no}_late"
																				name="radios" value="${bList.attenddethist[attendeeList.row_no-1].classday}|${bList.attenddethist[attendeeList.row_no-1].classhour_start_time}|${bList.attenddethist[attendeeList.row_no-1].student_no}|G023C003"
																				<c:if test="${bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C003'}"> checked="checked"</c:if>>
																			<label for="radio_${bList.classday}_${bList.classhour_start_time }_${bList.attenddethist[attendeeList.row_no-1].row_no}_late"
																				onclick="return statusCheck('${bList.classday}','${bList.classhour_start_time }')">지</label>
																			<input type="radio" class="${bList.classday}_${bList.classhour_start_time }Absent"
																				id="radio_${bList.classday}_${bList.classhour_start_time}_${bList.attenddethist[attendeeList.row_no-1].row_no}_absent"
																				name="radios" value="${bList.attenddethist[attendeeList.row_no-1].classday}|${bList.attenddethist[attendeeList.row_no-1].classhour_start_time}|${bList.attenddethist[attendeeList.row_no-1].student_no}|G023C004"
																				<c:if test="${bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C004'}"> checked="checked"</c:if>>
																			<label for="radio_${bList.classday}_${bList.classhour_start_time }_${bList.attenddethist[attendeeList.row_no-1].row_no}_absent"
																				onclick="return statusCheck('${bList.classday}','${bList.classhour_start_time }')">결</label>
																		</c:if>
																		<c:if test="${bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C005'}">휴학</c:if>
																		<c:if test="${bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C007'}">제적</c:if>
																		
																	</c:otherwise>
																</c:choose>
															</form>
														</td>
													</c:if>
												</c:forEach>
											</tr>
										</c:forEach>

										<tr height="35">

											<c:forEach var="button" items="${batchList}">

												<td class="tdwhite" valign="middle"
													style="padding: 4px 3px 0 3px;"><c:if
														test="${button.class_sts_cd=='G020C001' }">
														<img
															src="${pageContext.request.contextPath}/resources/images/prof/attendbatch_button.png"
															width="58" height="24" alt="일괄출석버튼"
															onclick="alert('완료되지 않은 강의입니다.')"
															style="cursor: pointer;" />
														<a href="javascript:alert('완료되지 않은 강의입니다.')"><img
															src="${pageContext.request.contextPath}/resources/images/prof/table_change_button.png"
															width="58" height="24" alt="변경완료버튼" /></a>
													</c:if> <c:if test="${button.class_sts_cd=='G020C002' }">
														<img
															src="${pageContext.request.contextPath}/resources/images/prof/attendbatch_button.png"
															width="58" height="24" alt="일괄출석버튼"
															onclick="return chgAttend('${button.classday }','${button.classhour_start_time }')"
															style="cursor: pointer;" />
														<a
															href="javascript:checkSubmit('${button.classday }','${button.classhour_start_time }')"><img
															src="${pageContext.request.contextPath}/resources/images/prof/table_change_button.png"
															width="58" height="24" alt="변경완료버튼" /></a>
													</c:if> <c:if test="${button.class_sts_cd=='G020C003' }">
														<img
															src="${pageContext.request.contextPath}/resources/images/prof/attendbatch_button.png"
															width="58" height="24" alt="일괄출석버튼"
															onclick="return chgAttend('${button.classday }','${button.classhour_start_time }')"
															style="cursor: pointer;" />
														<a
															href="javascript:checkSubmit('${button.classday }','${button.classhour_start_time }')"><img
															src="${pageContext.request.contextPath}/resources/images/prof/table_change_button.png"
															width="58" height="24" alt="변경완료버튼" /></a>
													</c:if></td>

											</c:forEach>

										</tr>
									</table>
								</div>
							</td>
						</tr>
					</table>
				</c:otherwise>
			</c:choose>


		</div>
		<div id="attend_reason_popup" title="출결상태 직권변경">
			<table style="width: 100%;">
				<tr>
					<td align="center" style="margin-bottom: 20px;">처리사유를 선택해주십시오.</td>
				</tr>
				<tr>
					<td align="center" style="height: 30px;"><select
						id="select_reason_code">
							<c:forEach var="code" items="${codeListG024 }">
								<option value="${code.code}">${code.code_name}</option>
							</c:forEach>
					</select></td>
				</tr>
			</table>
			<div id="ajax_indicator" style="display: none">
				<p
					style="text-align: center; padding: 16px 0 0 0; left: 50%; top: 50%; position: absolute;">
					<img
						src="${pageContext.request.contextPath }/resources/images/ajax-loader.gif" />
				</p>
			</div>
		</div>
		<!-- //교수 출결일괄처리 -->
	</div>
</body>
</html>

