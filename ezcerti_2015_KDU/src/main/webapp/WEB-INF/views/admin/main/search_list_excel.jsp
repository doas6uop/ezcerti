<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<%
    response.setHeader("Content-Disposition", "attachment; filename=AcademicStat.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");
%>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<meta charset="utf-8">
<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
</head>

<body>
<div id="wrap">
	<div id="article">
		<div id="contents">
			<c:set var="pb" value="${pageBean }"/>	
			
			<c:choose>
				<c:when test="${searchType eq 'PROF'}">
				
					<table width="690" border="0" cellpadding="0" cellspacing="0" >
					  <tr>
					    <td colspan="4" align="left" valign="bottom">통합검색 - 교수</td>
					    <td colspan="4" align="right" valign="bottom">[총 ${pb.allCnt }건]</td>
					  </tr>
					</table>
				
					<table width="700" border="1" cellspacing="0" cellpadding="0">
						<tr>
							<td width="32" align="center" valign="middle">NO</td>
							<td width="110" align="center" valign="middle">단과</td>
							<td width="150" align="center" valign="middle">학과</td>
							<td width="50" align="center" valign="middle">사번</td>
							<td width="90" align="center" valign="middle">교수명</td>
							<td width="90" align="center" valign="middle">연락처</td>
							<td width="50" align="center" valign="middle">상태</td>
						</tr>
						<c:choose>
							<c:when test="${fn:length(pb.list)==0 }">
								<tr>
									<td class="tdwhite" colspan="7" align="center" style="padding:30px 0 30px 0; border-right:none;">
										검색결과가 존재하지 않습니다.
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="b" items="${pb.list}" varStatus="status">
									<tr class="tr_over">
										<td>${b.row_no}</td>
										<td>${b.coll_name }</td>
										<td>${b.dept_name }</td>
										<td>${b.prof_no }</td>
										<td>${b.prof_name }</td>
										<td style="mso-number-format:'\@'">${b.hp_no }</td>
										<td>${b.prof_sts_cd }</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose> 
					</table>
					
				</c:when>
				<c:when test="${searchType eq 'STUDENT'}">
				
					<table width="690" border="0" cellpadding="0" cellspacing="0" >
					  <tr>
					    <td colspan="4" align="left" valign="bottom">통합검색 - 학생</td>
					    <td colspan="4" align="right" valign="bottom">[총 ${pb.allCnt }건]</td>
					  </tr>
					</table>
				
					<table width="700" border="1" cellspacing="0" cellpadding="0">
						<tr>
							<td width="32" align="center" valign="middle">NO</td>
							<td width="110" align="center" valign="middle">단과</td>
							<td width="150" align="center" valign="middle">학과</td>
							<td width="50" align="center" valign="middle">학년</td>
							<td width="90" align="center" valign="middle">학번</td>
							<td width="90" align="center" valign="middle">이름</td>
							<td width="50" align="center" valign="middle">연락처</td>
							<td width="50" align="center" valign="middle">상태</td>
							<td width="50" align="center" valign="middle">인증횟수</td>
						</tr>
						<c:choose>
							<c:when test="${fn:length(pb.list)==0 }">
								<tr>
									<td class="tdwhite" colspan="9" align="center" style="padding:30px 0 30px 0; border-right:none;">
										검색결과가 존재하지 않습니다.
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="b" items="${pb.list}" varStatus="status">
									<tr class="tr_over">
										<td>${b.row_no}</td>
										<td>${b.coll_name }</td>
										<td>${b.dept_name }</td>
										<td>${b.student_grade }학년</td>
										<td>${b.student_no }</td>
										<td>${b.student_name }</td>
										<td style="mso-number-format:'\@'">${b.hp_no }</td>
										<td>${b.student_sts_name }</td>
										<td>${b.cert_count }</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose> 
					</table>
					
				</c:when>
				<c:otherwise>
					
					<table width="690" border="0" cellpadding="0" cellspacing="0" >
					  <tr>
					    <td colspan="4" align="left" valign="bottom">통합검색 - 과목</td>
					    <td colspan="4" align="right" valign="bottom">[총 ${pb.allCnt }건]</td>
					  </tr>
					</table>
					
					<table width="700" border="1" cellspacing="0" cellpadding="0">
						<tr>
							<td width="32" align="center" valign="middle">NO</td>
							<td width="110" align="center" valign="middle">강의일</td>
							<td width="150" align="center" valign="middle">학과</td>
							<td width="200" align="center" valign="middle">과목</td>
							<td width="150" align="center" valign="middle">교수</td>
							<td width="90" align="center" valign="middle">연락처</td>
							<td width="90" align="center" valign="middle">수강인원</td>
							<td width="50" align="center" valign="middle">상태</td>
						</tr>
						<c:choose>
							<c:when test="${fn:length(pb.list)==0 }">
								<tr>
									<td class="tdwhite" colspan="9" align="center" style="padding:30px 0 30px 0; border-right:none;">
										검색결과가 존재하지 않습니다.
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="b" items="${pb.list}" varStatus="status">
									<c:set var="varClassStatus" value="${list.class_type_name }(${list.class_sts_name })" />
								
									<c:if test="${list.class_type_cd ne 'G019C002' and list.class_sts_cd eq 'G020C003' and empty list.cert_type}">
										<c:set var="varClassStatus" value="결강(출결미처리)" />
									</c:if>								
									<tr class="tr_over">
										<td>${b.row_no}</td>
										<td>${b.classday } <fmt:formatDate value="${b.classday }" type="time" pattern="(E)"/> ${b.classhour_start_time } ~ ${b.classhour_end_time }</td>
										<td>${b.prof_dept_name }</td>
										<td>${b.class_name }</td>
										<td>${b.prof_name }(${b.prof_no })</td>
										<td style="mso-number-format:'\@'">${b.hp_no }</td>
										<td>${b.attendee_cnt }</td>
										<td>${varClassStatus}</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose> 
					</table>
					
				</c:otherwise>
			</c:choose>
			<br>
		</div>
	</div>
</div>
</body>
</html>