<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common_univYear.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		getDayofWeekCnt();
		chkInputData();
	});
</script>

<div class="modal-dialog" style="width: 700px;">

	<!-- Modal content-->
	<div class="modal-content popup">
	  <div class="modal-header">
		<h3 class="modal-title">학기관리</h3>
		<button type="button" class="btn btn-rb pop_close" data-dismiss="modal">&times;</button>
	  </div>
	  <div class="modal-body">
		<section class="list_common list_full" style="margin-bottom: 0px;">
			<form id="saveForm" name="saveForm">
				<div style="display: inline-block; width: 45%; margin-top: 2px; vertical-align: top; text-align: left;">
					<section class="srch_common" style="margin-bottom: 2px; height: 272px; overflow-y: scroll;">
						<p>* 입력관련 상세설명 <b class="t_color_blue c_vertical_top">(푸른색 표시 필수 값)</b><br/>
						   	<span style="padding-left: 11px;"><b class="t_color_red c_vertical_top">- 1 ~ 4번 필수 값</b> 모두 입력 필요</span><br/>
<!--
						   	<span style="padding-left: 11px;"><b class="t_color_red c_vertical_top">- 6, 8번</b>은 2개중 1개 필수 입력</span><br/>
 -->
						   	<span style="padding-left: 11px;"><b class="t_color_red c_vertical_top">- 3, 4번</b> 입력 시 보강주가 없는 경우 학기기간외</span><br/>
						   	<span style="padding-left: 20px;">날짜지정 (학기종료일 다음날 지정)</span>
						</p>
						<p class="c_margin_bottom_4"><b class="t_color_blue c_vertical_top">1. 연도/학기</b> - 생성할 연도 및 학기 입력</p>
						<p class="c_margin_bottom_4"><b class="t_color_blue c_vertical_top">2. 학기시작/종료일</b> - 학기기간 입력</p>
						<p class="c_margin_bottom_4"><b class="t_color_blue c_vertical_top">3. 보강주 시작/종료일</b> - 보강주 기간 입력</p>
						<p class="c_margin_bottom_4"><b class="t_color_blue c_vertical_top">4. 강의생성제외 시작/종료일</b> - 강의생성제외기간<br/>
						   	<span style="padding-left: 11px;">입력 (<b class="t_color_red c_vertical_top">미사용 시 보강주(3번)</b>와 동일하게 입력)</span>
						</p>
						<p class="c_margin_bottom_4">5. 수업인정일자(성적인정) - 성적부여인정일자 입력</p>
<!--
						<p class="c_margin_bottom_4"><b class="t_color_blue c_vertical_top">6. 출결처리기간 시작/종료일</b> - 출결처리기간 입력<br/>
							<span style="padding-left: 11px;">입력된 기간만 출결처리가능(고정형)</span><br/>
					  		<span style="padding-left: 11px;">특별한 제한이 없으면 학기기간과 동일하게 입력</span><br/>
						</p>
 -->
						<p class="c_margin_bottom_4">6. 학기상태 - 정상/학기마감</p>
<!--
						<p class="c_margin_bottom_4"><b class="t_color_blue c_vertical_top">8. 출결처리기간(일지정)</b> - 현재일자부터 일 지정값<br/>
							<span style="padding-left: 11px;"> 까지 출결처리 가능(유동형 / 현재일 - 지정값)</span><br/>
							<span style="padding-left: 11px;"> 0 = 오늘강의만 처리가능(이전강의처리불가)</span><br/>
							<span style="padding-left: 11px;"> 1 = 오늘부터 1일전까지</span><br/>
							<span style="padding-left: 11px;"> 2 = 오늘부터 2일전까지... 등등</span>
						</p>
 -->
					</section>
					<section class="srch_common" style="margin-bottom: 0px;">
						<p class="c_margin_bottom_2">* 학기기간중 요일별 강의 수</p>
						<p><b class="t_color_red c_vertical_top">※ 지정 데이터 따른 요일별 주차 수</b> 확인 필요</p>
						<table class="table table-hover">
							<colgroup>
								<col style="width: auto;">
								<col style="width: auto;">
								<col style="width: auto;">
								<col style="width: auto;">
								<col style="width: auto;">
								<col style="width: auto;">
								<col style="width: auto;">
							</colgroup>
							<thead>
								<tr>
									<th>일</th>
									<th>월</th>
									<th>화</th>
									<th>수</th>
									<th>목</th>
									<th>금</th>
									<th>토</th>
								</tr>
							</thead>
							<tbody>
								<tr id="dayOfweekCntDiv">
									<td colspan="7">표시할 데이터가 없습니다.</td>
								</tr>
							</tbody>
						</table>
					</section>
				</div>
				<table class="table table-hover" style="display: inline-block; width: 54%">
					<colgroup>
						<col style="width:150px;;" />
						<col style="width:*;" />
					</colgroup>
					<tbody>
						<tr class="tr_over">
							<th>학교명</th>
							<td style="text-align: left;">${univyear.univ_name }
							</td>
						</tr>
						<tr class="tr_over">
							<th>학기명</th>
							<td style="text-align: left;">
								${univyear.term_name }
								<input type="hidden" id="year" name="year" value="${univyear.year }"/>
								<input type="hidden" id="term_cd" name="term_cd" value="${univyear.term_cd }"/>
								<input type="hidden" id="term_name" value="${univyear.term_name }"/>
							</td>
						</tr>
						<tr class="tr_over">
							<th>학기시작일</th>
							<td style="text-align: left;"><input type="text" style="width: 90%;" class="datePickerEvent" id="term_start_date" name="term_start_date" value="${univyear.term_start_date }" placeholder="학기시작일" />
							<span class="axi axi-calendar"></span></td>
						</tr>
						<tr class="tr_over">
							<th>학기종료일</th>
							<td style="text-align: left;"><input type="text" style="width: 90%;" class="datePickerEvent" id="term_end_date" name="term_end_date" value="${univyear.term_end_date }" placeholder="학기종료일" />
							<span class="axi axi-calendar"></span></td>
						</tr>
						<tr class="tr_over">
							<th>보강주 시작일</th>
							<td style="text-align: left;"><input type="text" style="width: 90%;" class="datePickerEvent" id="bogang_start" name="bogang_start" value="${univyear.bogang_start }" placeholder="보강시작일" />
							<span class="axi axi-calendar"></span></td>
						</tr>
						<tr class="tr_over">
							<th>보강주 종료일</th>
							<td style="text-align: left;"><input type="text" style="width: 90%;" class="datePickerEvent" id="bogang_end" name="bogang_end" value="${univyear.bogang_end }" placeholder="보강종료일" />
							<span class="axi axi-calendar"></span></td>
						</tr>
						<tr class="tr_over">
							<th>강의생성제외 시작일</th>
							<td style="text-align: left;"><input type="text" style="width: 90%;" class="datePickerEvent" id="noclass_start" name="noclass_start" value="${univyear.noclass_start }" placeholder="출결처리제외시작일" />
							<span class="axi axi-calendar"></span></td>
						</tr>
						<tr class="tr_over">
							<th>강의생성제외 종료일</th>
							<td style="text-align: left;"><input type="text" style="width: 90%;" class="datePickerEvent" id="noclass_end" name="noclass_end" value="${univyear.noclass_end }" placeholder="출결처리제외종료일" />
							<span class="axi axi-calendar"></span></td>
						</tr>
						<tr class="tr_over">
							<th>수업인정일자(성적인정)</th>
							<td style="text-align: left;">
								<input type="text" style="width: 52%;" id="lssn_admt_dt" name="lssn_admt_dt" value="${univyear.lssn_admt_dt }" placeholder="수업인정일자" />
								<span class="axi axi-calendar"></span>
								<div style="display: inline-block;">
									<button style="margin: -4px 0 0 6px; padding: 0 12px;" type="button" onclick="inputInit('lssn_admt_dt')" class="btn btn-list">초기화</button>
								</div>
							</td>
						</tr>
<%--
						<tr class="tr_over">
							<th>출결처리기간 시작일</th>
							<td style="text-align: left;">
								<input type="text" style="width: 52%;" id="chul_start_dt" name="chul_start_dt" value="${univyear.chul_start_dt }" class="chkInputData" placeholder="출결처리제외시작일" />
								<span class="axi axi-calendar"></span>
								<div style="display: inline-block;">
									<button style="margin: -4px 0 0 6px; padding: 0 12px;" type="button" onclick="inputInit('chul_start_dt')" class="btn btn-list">초기화</button>
								</div>
							</td>
						</tr>
						<tr class="tr_over">
							<th>출결처리기간 종료일</th>
							<td style="text-align: left;">
								<input type="text" style="width: 52%;" id="chul_end_dt" name="chul_end_dt" value="${univyear.chul_end_dt }" class="chkInputData" placeholder="출결처리제외종료일" />
								<span class="axi axi-calendar"></span>
								<div style="display: inline-block;">
									<button style="margin: -4px 0 0 6px; padding: 0 12px;" type="button" onclick="inputInit('chul_end_dt')" class="btn btn-list">초기화</button>
								</div>
							</td>
						</tr>
 --%>
						<tr class="tr_over">
							<th>학기상태</th>
							<td style="text-align: left;">
								<select id="univ_sts_cd" name="univ_sts_cd" style="width: 116px; height: 21px;">
									<option value="G004C001" <c:if test="${univyear.univ_sts_cd eq 'G004C001' }">selected="selected"</c:if> >정상</option>
									<option value="G004C002" <c:if test="${univyear.univ_sts_cd eq 'G004C002' }">selected="selected"</c:if> >학기종료</option>
								</select>
							</td>
						</tr>
<%--
						<tr class="tr_over">
							<th>출결처리기간(일지정)</th>
							<td style="text-align: left;">
								<input type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="width: 58%;" class="chkInputData" id="chul_term" name="chul_term" placeholder="숫자만 입력" value="${univyear.chul_term }"/>
								<div style="display: inline-block;">
									<button style="margin: -4px 0 0 6px; padding: 0 12px;" type="button" onclick="inputInit('chul_term')" class="btn btn-list">초기화</button>
								</div>
							</td>
						</tr>
 --%>
					</tbody>
				</table>
			</form>
		</section>
		<div style="text-align: right; margin-top: 10px;">
			<button type="button" id="save" onclick="deleteUnivTerm()" class="btn btn-write" style="float: left;">삭제</button>
			<button type="button" id="save" onclick="save('univyear_modify_ok')" class="btn btn-nv">저장</button>
		</div>
	  </div> <!--//modal-body -->
	</div> <!--//modal-content -->
  </div> <!--//modal-dialog -->
  <jsp:include page="/WEB-INF/views/common/util/loading_bar_footer.jsp"></jsp:include>