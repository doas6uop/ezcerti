<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale1.0,user-scalable=no">

<link rel="stylesheet" href="resources/css/style.css">
<script type="text/javascript" src="resources/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<link rel="stylesheet" href="resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<!--[if lt IE 9]>
<script type="text/javascript" src="resources/js/respond.min.js"></script>
<script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>
<![endif]-->
  <script>
  $(function() {

	    $( "#datepicker" ).datepicker();
	    $( "#datepicker2" ).datepicker();

	  });
  
  $(document).ready(function(){
	  $("#testtest").click(function(){
	    $("#not_visible").css("display","block");
	    $(body).css("background-color","white");
	    $("#not_visible").load("lessonDetail");
	  });
	  
	  
	  
	}); 

  </script>
</head>

<body>
	<div id="wrap">
		<header></header>
		<article>
			<section>
				<div id="today_class">
					<h5>■오늘의 강의</h5>
					강의일<input type="text" id="datepicker" size="7" readonly="readonly"> ~ <input type="text" id="datepicker2" size="7" readonly="readonly">  
					<button id="testtest" onclick="testtest">검색</button>
					<br><br>
					<table style="width: 100%;">
						<tr>
							<td align="left"><button>◀이전</button></td>
							<td align="center"><a href="lessonDetail">2013-04-06(목)</a></td>
							<td align="right"><button>다음▶</button></td>
						</tr>
					</table>
					<br>
					<div class="t_class">
						<div class="t_class_left">
							<div style="position: relative;">
								<div class="type_cd">정상</div>
								<div class="sts_cd">강의전</div>
								<div class="attendee_cnt">42명</div>
							</div>
							<div style="clear: both;">2013-04-06 (목) 15:00 5225CC</div>
							<div style="width: 100%;word-break:break-all;">Seminar on Comparative Analysis of
								Asian Economics</div>
						</div>
						<div class="t_class_right">
							<div class="off_class_btn">휴강<br>처리</div>
							<div class="class_cert_btn">강의<br>인증</div>
						</div>
					</div>
					<div class="t_class">
						<div class="t_class_left">
							<div style="position: relative;">
								<div class="type_cd">정상</div>
								<div class="sts_cd">강의전</div>
								<div class="attendee_cnt">42명</div>
							</div>
							<div style="clear: both;">2013-04-06 (목) 15:00 5225CC</div>
							<div style="width: 100%;word-break:break-all;">Seminar on Comparative Analysis of
								Asian Economics</div>
						</div>
						<div class="t_class_right">
							<div class="off_class_btn">휴강<br>처리</div>
							<div class="class_cert_btn">강의<br>인증</div>
						</div>
					</div>
				</div>

				<div id="class_list">
					<h5>■강의목록</h5>
					<table style="width:100%;">
						<tr>
							<td class="list_num" align="left">1</td>
							<td style="width:75%;">
								<table style="width:100%;">
									<tr>
										<td align="left">화요일 14:00</td>
										<td>305010</td>
										<td align="right">15명</td>
									</tr>
									<tr>
										<td colspan="3" class="list_subject">Seminar on Comparative Analysis of Asian Economics</td>
									</tr>
								</table>
							</td>
							<td style="width:12%;" align="right">▶</td>
						</tr>
					</table>
					<table style="width:100%;">
						<tr>
							<td class="list_num" align="left">1</td>
							<td style="width:75%;">
								<table style="width:100%;">
									<tr>
										<td align="left">화요일 14:00</td>
										<td>305010</td>
										<td align="right">15명</td>
									</tr>
									<tr>
										<td colspan="3" class="list_subject">Seminar on Comparative Analysis of Asian Economics</td>
									</tr>
								</table>
							</td>
							<td style="width:12%;" align="right">▶</td>
						</tr>
					</table>
					<table style="width:100%;">
						<tr>
							<td class="list_num" align="left">1</td>
							<td style="width:75%;">
								<table style="width:100%;">
									<tr>
										<td align="left">화요일 14:00</td>
										<td>305010</td>
										<td align="right">15명</td>
									</tr>
									<tr>
										<td colspan="3" class="list_subject">Seminar on Comparative Analysis of Asian Economics</td>
									</tr>
								</table>
							</td>
							<td style="width:12%;" align="right">▶</td>
						</tr>
					</table>
				</div>
				
				
				<div id="not_visible"></div>

			</section>
		</article>
		<aside></aside>
		<div style="clear: both;"></div>
		<footer></footer>
	</div>
</body>
</html>

