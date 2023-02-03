<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<script type="text/javascript" src="//select-box.googlecode.com/svn/tags/0.2/jquery.selectbox-0.2.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery.jqplot.min.js"></script>
<link class="include" rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/jquery.jqplot.min.css" />

<script type="text/javascript" src="${pageContext.request.contextPath }/resources/jqplot/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/jqplot/jqplot.barRenderer.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/jqplot/jqplot.pointLabels.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_style.css">

<script>
$(document).ready(function(){
	$(".menu1 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_01.gif");
	
$(function(){
		
		drawChart();
		
		function drawChart() {
			
			/*
				결강현황 그래프
				
				필요 인자
				1. 강의 완료된 강의수
				2. 강의 완료된 강의중 결강수
				3. 오늘날짜의 전체 강의수
				4. 오늘날짜의 전체 강의중 결강 수
			*/
			
			var allClassCnt = [Number('${allClassCnt }')];
			var allClassAbCnt = [Number('${cancelClassCnt }')];
			var todayClassCnt = [Number('${todayClassCnt }')];
			var todayClassAbCnt = [Number('${todayClassAbCnt }')];
			
			// chart data
			var dataArray1 = [allClassCnt, allClassAbCnt];
			var dataArray2 = [todayClassCnt, todayClassAbCnt];
			
			// x-axis ticks
			var ticks1 = ['결강현황'];
			 
			// chart rendering options
			var options1 = {
				width:260,
				animate: true,                          //animation 설정
	            animateReplot: true,
	            legend:{
                      renderer: $.jqplot.EnhancedLegendRenderer,
                      show:true,
                      location: 'en',
                      placement: 'outside'
                },
                series: [{label: '강의수'}, {label: '결강수'}],
				seriesDefaults: {
				  renderer:$.jqplot.BarRenderer,
				  pointLabels: { 
				    show: true, 
				    location: 'n'
				  }
				},
				axesDefaults: {
		            tickRenderer: $.jqplot.CanvasAxisTickRenderer,
		            tickOptions: {
		                fontSize: '10pt'
		            }
		        },
				axes: {
				  xaxis: {
				    renderer: $.jqplot.CategoryAxisRenderer,
				    ticks: ticks1
				  },
			      yaxis: {
			    	min:0, 
			    	pad:1.5
			      }
				}
			};
			
			// draw the chart
			$.jqplot('graph1', dataArray1, options1);
			$.jqplot('graph2', dataArray2, options1);
		}
	});
});

function doView(board_no){
	var f = document.getElementById('mainForm');
	f.method = 'post';
	f.board_no.value = board_no;
	f.board_type.value = 'QNA';
	f.action = '${pageContext.request.contextPath}/comm/board/board_view';
	f.submit();
}
</script>

<style>
	.main_box_detail {
		width: 42%;
		display: inline-block;
		margin: 0 3px;
	}
	
	.main_box {
		text-align: center;
		vertical-align: middle;
	}
	
	.graph_style {
		display:inline-block; 
		width:260px; 
		height:270px;
		margin: 5px 15px;
	}
	
	.jqplot-point-label {
	  padding: 1px 3px;
	  font-size: 15px;
	}
	
	table.jqplot-table-legend {
	  font-size: 11px;
	  top: -40px;
	  right: -3px;
	  left: 181px;
	}
	
	.tit_h4 {padding-bottom: 7px; font-size: 13px;}
	.srch_common{border:3px solid #eee;border-radius:15px;padding:24px;margin-bottom:30px;}
</style>

</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">


<h4 class="mg_b10 mg_t80"><img src="${pageContext.request.contextPath}/resources/images/admin/main_h4_01.gif" alt="통합현황" /></h4>
<div class="srch_common type_stats main_box">
	<div style="display: inline-block; padding-top: 12px;">
		<h4>전체 현황</h4>
		<div id="graph1" class="graph_style"></div>
	</div>
	<div style="display: inline-block; padding-top: 12px;">
		<h4>${currentDate } 현황</h4>
		<div id="graph2" class="graph_style"></div>
	</div>
</div>

<div class="srch_common">
	<h4 class="tit_h4">강의완료 현황</h4>
	<table border="0" cellspacing="0" cellpadding="0" class="tstyle_logm2" style="width: 100%; margin-bottom: 15px;">
		<tr>
			<th style="width: 33%;">강의수</th>
			<th style="width: 33%;">결강수</th>
			<th style="width: 33%;">결석 학생수</th>
		</tr>
		<tr>
			<td>
				<fmt:formatNumber type="currency" value="${allClassCnt }" pattern="###,###" />
			</td>
			<td>
				<c:if test="${cancelClassCnt > 0}">
					<a href='${pageContext.request.contextPath}/muniv/stats/stats_cancel_class'>
						<fmt:formatNumber type="currency" value="${cancelClassCnt}" pattern="###,###" />
					</a>
				</c:if>    		
				<c:if test="${cancelClassCnt <= 0}">
					${cancelClassCnt}
				</c:if>
			</td>
			<td>
				<c:if test="${absentClassCnt > 0}">
					<a href='${pageContext.request.contextPath}/muniv/stats/stats_absence'>
						<fmt:formatNumber type="currency" value="${absentClassCnt}" pattern="###,###" />
					</a>
				</c:if>    		
				<c:if test="${absentClassCnt <= 0}">
					${absentClassCnt}
				</c:if>
			</td>
		</tr>
	</table>
	<h4 class="tit_h4">${currentDate } 현황</h4>
	<table border="0" cellspacing="0" cellpadding="0" class="tstyle_logm2" style="width: 100%;">
		<tr>
			<th style="width: 33%;">강의수</th>
			<th style="width: 33%;">결강수</th>
			<th style="width: 33%;">결석 학생수</th>
		</tr>
		<tr>
			<td>
				<fmt:formatNumber type="currency" value="${todayClassCnt }" pattern="###,###" />
			</td>
			<td>
				<c:if test="${todayClassAbCnt > 0}">
					<a href='${pageContext.request.contextPath}/muniv/stats/stats_cancel_class?current_date=${currentDate }'>
						<fmt:formatNumber type="currency" value="${todayClassAbCnt}" pattern="###,###" />
					</a>
				</c:if>    		
				<c:if test="${todayClassAbCnt <= 0}">
					${todayClassAbCnt}
				</c:if>
			</td>
			<td>
				<c:if test="${todayAttendAbCnt > 0}">
					<a href='${pageContext.request.contextPath}/muniv/stats/stats_absence?current_date=${currentDate }'>
						<fmt:formatNumber type="currency" value="${todayAttendAbCnt}" pattern="###,###" />
					</a>
				</c:if>    		
				<c:if test="${todayAttendAbCnt <= 0}">
					${todayAttendAbCnt}
				</c:if>
			</td>
		</tr>
	</table>
	<div style="padding-top: 11px; color: red; font-size: 11px;">※ 결석 학생수는 수업당 결석수(총결석수/시수)가 2회 이상인 학생수를 말합니다.</div>
</div>

<div class="srch_common">
	<h4 class="tit_h4">결강교수 Top3</h4>
	<table border="0" cellspacing="0" cellpadding="0" class="tstyle_logm2" style="width: 100%; margin-bottom: 15px;">
		<tr>
			<th style="width: 33%;">번호</th>
			<th style="width: 33%;">이름</th>
			<th style="width: 33%;">전체 결강수</th>
		</tr>
		<c:forEach var="list" items="${prof_top3 }" varStatus="status">
			<tr style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/muniv/stats/stats_cancel_class?item=prof_name&value=' + encodeURIComponent('${list.prof_name }')">
				<td scope="row">${status.count}</td>
				<td>${list.prof_name } (${list.prof_no })</td>
				<td>${list.prof_ab_cnt }</td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(prof_top3) <= 0}">
			<tr>
				<td colspan="3">결강정보가 없습니다.</td>
			</tr>
		</c:if>
	</table>
	<h4 class="tit_h4">결강과목 Top3</h4>
	<table border="0" cellspacing="0" cellpadding="0" class="tstyle_logm2" style="width: 100%;">
		<tr>
			<th style="width: 33%;">번호</th>
			<th style="width: 33%;">과목명</th>
			<th style="width: 33%;">결강수</th>
		</tr>
		<c:forEach var="list" items="${class_top3 }" varStatus="status">
			<tr style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/muniv/stats/stats_cancel_class?item=class_name&value=' + encodeURIComponent('${list.class_name }')">
				<td scope="row">${status.count}</td>
				<td>${list.class_name }</td>
				<td>${list.class_name_ab_cnt }</td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(class_top3) <= 0}">
			<tr>
				<td colspan="3">결강정보가 없습니다.</td>
			</tr>
		</c:if>
	</table>
</div>

<%-- 
<!--관리자 로그인 메인 페이지 시작-->
<h4 class="mg_b10 mg_t80"><img src="${pageContext.request.contextPath}/resources/images/admin/main_h4_01.gif" alt="휴강신청" /></h4>
<div class="main_info">
	<ul>
    <li>
    	<p class="info_title"><img src="${pageContext.request.contextPath}/resources/images/admin/info_title02.gif" alt="결강신청" /></p>
    	<p class="info_num">
			<c:if test="${cancelClassCnt > 0}">
				<a href='${pageContext.request.contextPath}/muniv/stats/stats_cancel_class'><font color='white'><fmt:formatNumber type="currency" value="${cancelClassCnt}" pattern="###,###" /> 건</font></a>
			</c:if>    		
			<c:if test="${cancelClassCnt <= 0}">
				${cancelClassCnt} 건
			</c:if>    		
    	</p>
    </li>
    <li>
    	<p class="info_title"><img src="${pageContext.request.contextPath}/resources/images/admin/info_title03.gif" alt="결석신청" /></p>
    	<p class="info_num">
			<c:if test="${absentClassCnt > 0}">
				<a href='${pageContext.request.contextPath}/muniv/stats/stats_absence'><font color='white'><fmt:formatNumber type="currency" value="${absentClassCnt}" pattern="###,###" /> 건</font></a>
			</c:if>
			<c:if test="${absentClassCnt <= 0}">
				${absentClassCnt} 건
			</c:if>    		
    	</p>
    </li>
  </ul>
</div>

<h4 class="mg_b10 mg_t80"><img src="${pageContext.request.contextPath}/resources/images/admin/main_h4_02.gif" alt="문의신청" /></h4>
<table border="0" cellspacing="0" cellpadding="0" class="tstyle_logm">
	<tr>
		<th width="10%">번호</th>
		<th>제목</th>
		<th width="15%">작성자</th>
		<th width="15%">등록일</th>
	</tr>
	<c:if test="${fn:length(board) > 0}">
		<c:forEach var="list" items="${board}" varStatus="status">
		<tr>
			<td>${status.count}</td>
			<td class="title_left"><a href="javascript:doView('${list.board_no}')">${list.title}</a></td>
			<td>${list.reg_user_name}</td>
			<td>${list.reg_date}</td>
		</tr>	
		</c:forEach>
	</c:if>

	<c:if test="${fn:length(board) <= 0}">
	<tr>
		<td colspan="4">등록된 정보가 없습니다</td>
	</tr>
	</c:if>
</table>
<!--관리자 로그인 메인 페이지 끝-->

<form id="mainForm" method="post">
	<input type="hidden" id="board_no" name="board_no"/>
	<input type="hidden" id="board_type" name="board_type"/>
</form>
 --%>
 
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>