<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>신규학기 강의생성</title>

		<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-ui-1.10.3.custom.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jqgrid/jquery.jqGrid.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jqgrid/i18n/grid.locale-kr.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/class_manage.js"></script>

		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/axicon/axicon.min.css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/sub.css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/media_sub.css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/js/jqgrid/css/jquery-ui-1.10.4.custom.min.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/jquery-ui-1.10.3.custom.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/js/jqgrid/css/ui.jqgrid.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/default.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css">

		<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common_loading_bar.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common_loading_bar_style.css">
	</head>

<script type="text/javascript">

	$(document).ready(function(){

		// 최초로딩 시
		fn_search('class_manage_univ_term');

		$("a[data-toggle='tab']").on("show.bs.tab", function(e) {

			var tmpParam = String(e.target).split("#");

			switch (tmpParam[1]) {
			  case "menu0": fn_search('class_manage_univ_term'); break;
			  case "menu1": fn_search('class_manage_target_view_chk'); break;
			  case "menu2": fn_search('class_manage_target_view'); break;
			  case "menu3": $("#checkedData_select").val('0');
			  				resetGridTableArea("classManageCheckedDataList" , "tableArea6", "classManageCheckedDataPager");
			  				break;
			  case "menu4": fn_search('class_manage_close_check'); break;
			  	   default: break;
			}
		});

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
	});

	function doView(univ_cd, year, term_cd){

		$.ajax({
			type: "GET",
			cache: false,
			url: "${pageContext.request.contextPath}/muniv/info/univyear_view?univ_cd=" +univ_cd+ "&year=" +year+ "&term_cd=" +term_cd,
			success: function(msg) {
				$("#myModal1").html(msg);
				$("#myModal1").modal('show');
			},
			error: function(msg){
				alert(msg);
			}
		});
	}

	function fn_insert(){

		$.ajax({
			type: "GET",
			cache: false,
			url: "${pageContext.request.contextPath}/muniv/info/univyear_insert_form",
			success: function(msg) {
				$("#myModal1").html(msg);
				$("#myModal1").modal('show');
			},
			error: function(msg){
				alert(msg);
			}
		});
	}

	function startProc(proType, obj) {

		if(confirm($(obj).text() + "을 실행 하시겠습니까?")) {

			$.ajax({
				type: "POST",
				url: "${pageContext.request.contextPath}/comm/scheduleProc?procType="+proType,
				success: function(msg) {
					//통신이 완료된 후 처리
					$('.spinner_layer').fadeOut('fast', function(){
						alert("작업이 완료 되었습니다.");
						fn_search('class_manage_target_view');
					});
				},
				beforeSend: function() {
					//통신을 시작할때 처리
					$('.spinner_layer').show().fadeIn('fast');
				},
				error: function(msg){ // 예상치 못한 에러

					$('.spinner_layer').fadeOut('fast', function(){
						alert(msg);
					});
				}
			});
		}
	}

	function initSyncData(obj) {

		if(confirm($(obj).text() + "을 실행 하시겠습니까?")) {

			$.ajax({
				type: "POST",
				url: "${pageContext.request.contextPath}/muniv/class_manage/initSyncData",
				success: function(msg) {
					//통신이 완료된 후 처리
					$('.spinner_layer').fadeOut('fast', function(){
						alert("작업이 완료 되었습니다.");
						fn_search('class_manage_target_view');
					});
				},
				beforeSend: function() {
					//통신을 시작할때 처리
					$('.spinner_layer').show().fadeIn('fast');
				},
				error: function(msg){ // 예상치 못한 에러

					$('.spinner_layer').fadeOut('fast', function(){
						alert(msg);
					});
				}
			});
		}
	}

</script>

<style type="text/css">

	html{height: 100%; }

	.t_color_red{color: #900; vertical-align: top; }
	.t_color_blue{color: #1266FF; vertical-align: top; }
	.c_vertical_top{vertical-align: top; }
	.c_margin_bottom_2{margin-bottom : 2px; }
	.c_margin_bottom_4{margin-bottom : 4px; }

	.tab{margin-top: 10px; }
	.tab li{width: auto; }
	.tab_panel {height: auto; border-bottom: 0px; }

	.fl {float: left; }
	table th{font-size: 11px; }
	table td{font-size: 11px; }
	.list_common * {font-size: 11px; }

</style>

	<body>
		<header>
			<nav>
				<ul class="nav nav-pills tab">
					<li class="nav-item active">
						<a class="nav-link" data-toggle="tab" href="#menu0">01. 신규학기생성</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-toggle="tab" href="#menu1">02. 데이터검증(학교제공데이터)</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-toggle="tab" href="#menu2">03. 동기화처리</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-toggle="tab" href="#menu3">04. 이상강의체크</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-toggle="tab" href="#menu4">05. 마감관련(교수/강의)</a>
					</li>
				</ul>
			</nav>
		</header>
		<section>
			<div class="tab-content tab_panel" style="margin: 0;">
				<div id="menu0" class="tab-pane fade in active">
					<section class="listarea ico_none">
						<content>
							<div style="width: 80%; margin: 30px auto 5px auto;">
								<div>
									<section class="srch_common">
										<p>01. 신규학기생성</p>
										<p>- 학기데이터생성을 위해서 <b class="t_color_red c_vertical_top">신규학기정보 입력</b> 필요</p>
										<p>- 입력된 학기기간 정보를 토대로 학기 데이터 생성 및 강의일자 데이터 생성 처리</p>
										<p>- 신규학기 등록 시 <b class="t_color_red c_vertical_top">[등록]</b> 버튼 클릭</p>
										<p>- <b class="t_color_red c_vertical_top">[수정/삭제]</b>는 조회리스트(연도학기관리) 데이터 더블클릭 후 상세페이지에서 처리</p>
										<p>
											<b class="t_color_red c_vertical_top">※ 01. 신규학기생성 > 03. 동기화처리까지 끝난 경우</b> 이미 강의데이터가 생성 처리 되었기 때문에</br>
											<span style="padding-left: 13px;">학기기간 수정 시 <b class="t_color_red c_vertical_top">생성된 강의데이터 삭제 및 동기화처리를 재처리</b> 해주셔야 합니다.</span>
										</p>
									</section>
								</div>
								<div>
									<section class="srch_common">
										<label class="standLabel">연도</label>
										<input type="text" id="searchValue" name="searchValue" onkeyup="fn_key('class_manage_univ_term')"/>
										<div class="srch_btnarea"  style="width: 67%">
											<div class="srch_btnarea">
												<button type="button" class="btn btn-primary" onclick="fn_search('class_manage_univ_term')">조회</button>
											</div>
											<div class="srch_btnarea" style="float: right;">
												<button type="button" class="btn btn-primary" onclick="fn_insert()">등록</button>
											</div>
										</div>
									</section>
								</div>
								<div style="margin-bottom: 30px;">
									<div class="jqGrid_wrapper" id="tableArea" style="margin-bottom: 10px;">
										<table id="classManageUnivTermList"></table>
										<div id="classManageUnivTermPager"></div>
									</div>
									<div class="jqGrid_wrapper2" id="tableArea2">
										<table id="classManageClassdayList"></table>
										<div id="classManageClassdayPager"></div>
									</div>
								</div>
							</div>
						</content>
					</section>
				</div>
				<div id="menu1" class="tab-pane">
					<section class="listarea ico_none">
						<content>
							<div style="width: 80%; margin: 30px auto 5px auto;">
								<div>
									<section class="srch_common">
										<p>02. 데이터검증(학교제공데이터)</p>
										<p>- 아래 조회 데이터는 <b class="t_color_red c_vertical_top">[01. 신규학기생성]</b>에서 <b class="t_color_red c_vertical_top">학기상태가 정상</b>인 데이터를 조회(학교뷰데이터조회(이상데이터확인))</p>
										<p>- 학교제공데이터 중 <b class="t_color_red c_vertical_top">이상 데이터</b> 확인(출결시스템 사용불가 데이터)</p>
										<p>※ 이상 데이터는 <b class="t_color_red c_vertical_top">학교측 제공데이터 중 값이 없는 데이터로</b> 해당 값이 없으면 출결 시스템에서 <b class="t_color_red c_vertical_top">생성이 불가</b> 합니다.</p>
									</section>
								</div>
								<div>
									<div style="margin-bottom: 30px;">
										<div class="jqGrid_wrapper" id="tableArea9" style="margin-bottom: 10px;">
											<table id="classManageTargetViewChkList"></table>
											<div id="classManageTargetViewChkPager"></div>
										</div>
										<div class="jqGrid_wrapper2" id="tableArea10">
											<table id="classManageTargetViewSelectList"></table>
											<div id="classManageTargetViewSelectPager"></div>
										</div>
									</div>
								</div>
							</div>
						</content>
					</section>
				</div>
				<div id="menu2" class="tab-pane">
					<section class="listarea ico_none">
						<content>
							<div style="width: 80%; margin: 30px auto 5px auto;">
								<div>
									<section class="srch_common">
										<p>03. 동기화처리</p>
										<p>- <b class="t_color_red c_vertical_top">동기화처리란?</b> 출결시스템을 사용하기 위한 <b class="t_color_red c_vertical_top">초기 데이터 생성</b> 작업</p>
										<p>- 아래 조회 데이터는 <b class="t_color_red c_vertical_top">[01. 신규학기생성]</b>에서 <b class="t_color_red c_vertical_top">학기상태가 정상</b>인 데이터를 조회(학교뷰데이터조회, 이관테이블조회, 출결시스템데이터조회)</p>
										<p>
											- 학교뷰데이터조회(학교측 제공 데이터), 이관테이블조회(출결시스템 이관 자료), 출결시스템데이터조회(출결시스템 실사용 데이터)<br/>
											<span style="padding-left: 11px;">1) <b class="t_color_red c_vertical_top">학교뷰데이터조회</b>를 통해 <b class="t_color_red c_vertical_top">학교 측 제공 데이터 입력 여부</b> 확인</span><br/>
											<span style="padding-left: 11px;">2) <b class="t_color_red c_vertical_top">[데이터이관]</b> 실행 후 <b class="t_color_red c_vertical_top">이관테이블조회</b>를 통해 이관 데이터 확인</span><br/>
											<span style="padding-left: 29px;">- <b>데이터이관</b>은 학교 뷰 데이터를 출결시스템쪽으로 복사하는 작업입니다. (매번 실행 시 복사대상학기 삭제 후 이관 작업/<b class="t_color_red c_vertical_top">초기화 필요 없음</b>)</span><br/>
											<span style="padding-left: 11px;">3) <b class="t_color_red c_vertical_top">[출결시스템데이터생성]</b> 실행 후 <b class="t_color_red c_vertical_top">출결시스템데이터조회</b>를 통해 실사용 데이터 확인</span><br/>
											<span style="padding-left: 29px;">- <b>출결시스템 실 사용자료</b> 생성작업(기간및 정보변경에 따른 강의 재생성시 <b class="t_color_red c_vertical_top">출결시스템데이터초기화 필요</b>)</span><br/>
											<span style="padding-left: 36px;"><b class="t_color_red c_vertical_top">[출결시스템생성]</b> 실행 후 <b>강의정보(CHUL_TB_ATTENDMASTER_ADDINFO)</b> 테이블에 데이터가 생성처리되면 정상 처리</span>
										</p>
										<p><b class="t_color_red c_vertical_top">※ 본 작업(생성 및 초기화)은 학기 초 강의생성시에만 사용</b> 해야 합니다. 학기 중 <b class="t_color_red c_vertical_top">강제 사용 시 데이터 오류</b>를 발생시킬 수 있습니다.</p>
									</section>
								</div>
								<div>
									<div style="margin-bottom: 30px;">
										<div class="jqGrid_wrapper" id="tableArea3" style="margin-bottom: 10px;">
											<table id="classManageTargetViewList"></table>
											<div id="classManageTargetViewPager"></div>
										</div>
<!-- 
										<div class="jqGrid_wrapper2" id="tableArea5">
											<table id="classManageSyncDataList"></table>
											<div id="classManageSyncDataPager"></div>
										</div>
										<div>
											<button type="button" style="display: none;" id="execute2_2" class="btn btn-warning" onclick="startProc('SYNC', this)">출결시스템데이터생성</button>
											<button type="button" style="display: none;" id="execute2_3" class="btn btn-success" onclick="initSyncData(this)">출결시스템데이터초기화</button>
										</div>
 -->
										<div>
											<table style="width: 100%">
												<tr>
													<td style="width: 49%" valign="top" align="left">
														<div class="jqGrid_wrapper2" id="tableArea4">
															<table id="classManageCopyDataList"></table>
															<div id="classManageCopyDataPager"></div>
														</div>
														<button type="button" style="display: none;" id="execute2_1" class="btn btn-warning" onclick="startProc('COPYDATA', this)">데이터이관</button>
													</td>
													<td style="width: 49%" valign="top" align="right">
														<div class="jqGrid_wrapper2" id="tableArea5">
															<table id="classManageSyncDataList"></table>
															<div id="classManageSyncDataPager"></div>
														</div>
														<div style="padding-left: 3px;">
															<button type="button" style="display: none;" id="execute2_2" class="btn btn-warning" onclick="startProc('SYNC', this)">출결시스템데이터생성</button>
															<button type="button" style="display: none;" id="execute2_3" class="btn btn-success" onclick="initSyncData(this)">출결시스템데이터초기화</button>
														</div>
													</td>
												</tr>
											</table>
										</div>

									</div>
								</div>
							</div>
						</content>
					</section>
				</div>
				<div id="menu3" class="tab-pane">
					<section class="listarea ico_none">
						<content>
							<div style="width: 80%; margin: 30px auto 5px auto;">
								<div>
									<section class="srch_common">
										<p>04. 이상강의체크</p>
										<p>- 생성강의 이상체크(기간설정에 따른 <b class="t_color_red c_vertical_top">강의갯수</b> 체크)</p>
										<p>
											- 세팅값(강의수)의 배수로 이상강의 체크<br/>
											<span style="padding-left: 11px;">- 15입력 시 15의 배수로 생성되지 않은 강의 목록 표시<br/>
										</p>
										<p><b class="t_color_red c_vertical_top">※ 입력된 강의의 갯수가 맞지 않는 경우</b> <b>[01. 신규학기생성]</b> 시 설정한 기간정보 및 학기기간중 요일별 강의 수를 확인 바랍니다.</p>
									</section>
								</div>
								<div>
									<section class="srch_common">
										<label class="standLabel">강의수</label>
										<select id="checkedData_select">
											<option selected="selected" value="0">선택</option>
											<option value="7">7</option>
											<option value="8">8</option>
											<option value="9">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
											<option value="13">13</option>
											<option value="14">14</option>
											<option value="15">15</option>
											<option value="16">16</option>
										</select>
										<div class="srch_btnarea"  style="width: 67%">
											<div class="srch_btnarea">
												<button type="button" class="btn btn-primary" onclick="fn_search('class_manage_checked_data')">조회</button>
											</div>
										</div>
									</section>
								</div>
								<div>
									<div style="margin-bottom: 30px;">
										<div class="jqGrid_wrapper" id="tableArea6" style="margin-bottom: 10px;">
											<table id="classManageCheckedDataList"></table>
											<div id="classManageCheckedDataPager"></div>
										</div>
									</div>
								</div>
							</div>
						</content>
					</section>
				</div>
				<div id="menu4" class="tab-pane">
					<section class="listarea ico_none">
						<content>
							<div style="width: 80%; margin: 30px auto 5px auto;">
								<div>
									<section class="srch_common">
										<p>05. 마감관련(교수/강의)</p>
										<p>- <b class="t_color_red c_vertical_top">교수의 출결체크 및 휴보강 제한</b>을 위해 사용</p>
										<p>- 교수마감/해제 : <b class="t_color_red c_vertical_top">교수상태코드가 마감/해제</b>로 변경 되며, 마감 시 <b class="t_color_red c_vertical_top">휴보강 관련 기능 제한</b></p>
										<p>- 강의마감/해제 : <b class="t_color_red c_vertical_top">강의상태코드가 마감/해제</b>로 변경 되며, <b class="t_color_red c_vertical_top">교수화면(출결버튼관련제한), 학생화면(이의신청제한)</b></>
										<p>- 학기기간 종료 후 출결상태변경 제한을 위해 <b class="t_color_red c_vertical_top">교수 및 강의 상태 마감처리</b>를 하시는 것이 좋습니다.</p>
										<p>
											<b class="t_color_red c_vertical_top">※ 새 학기 생성 시</b> 교수의 출결처리를 위해서는 <b class="t_color_red c_vertical_top">교수상태는 마감해제</b>를 해야 하며, <b class="t_color_red c_vertical_top">&lt;&lt;&lt;신규생성 강의는 마감처리를 하지 않습니다.&gt;&gt;&gt;</b><br/>
											<span style="padding-left: 11px;"><b class="t_color_red c_vertical_top">새학기 강의는 학기기간 종료 후 마감</b> 처리를 하셔야 합니다.</span>
										</p>
									</section>
								</div>
								<div>
									<table style="width: 100%">
										<tr>
											<td style="width: 49%" valign="top" align="left">
												<div class="jqGrid_wrapper" id="tableArea7">
													<table id="classManageProfList"></table>
													<div id="classManageProfPager"></div>
												</div>
												<div style="padding-right: 3px;">
													<button type="button" id="execute4_1" class="btn btn-warning" onclick="executeCloseDataChange('prof', '1', this, '')">마감</button>
													<button type="button" id="execute4_2" class="btn btn-success" onclick="executeCloseDataChange('prof', '2', this, '')">마감해제</button>
												</div>
											</td>
											<td style="width: 49%" valign="top" align="right">
												<div class="jqGrid_wrapper2" id="tableArea8">
													<table id="classManageClassDataList"></table>
													<div id="classManageClassDataPager"></div>
												</div>
												<div style="padding-left: 3px;">
													<button type="button" id="execute4_3" class="btn btn-warning" onclick="executeCloseDataChange('class', '1', this, '')">강의마감</button>
													<button type="button" id="execute4_4" class="btn btn-success" onclick="executeCloseDataChange('class', '2', this, '')">강의마감해제</button>
												</div>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</content>
					</section>
				</div>
			</div>
		</section>

		<div id="myModal1" class="modal fade popup" role="dialog"></div>
		<jsp:include page="/WEB-INF/views/common/util/loading_bar_footer.jsp"></jsp:include>
	</body>
</html>