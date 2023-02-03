<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<%
    response.setHeader("Content-Disposition", "attachment; filename=AcademicProfClassStat.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");
%>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=10; IE=9; IE=8; IE=7; IE=EDGE" />
<meta charset="utf-8">
<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
</head>
<body>

<div>

<table border="1" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" colspan="2">학과</td>
		<td colspan="2" align="center">${lectureDetail.class_name }</td>
		<td align="center"  colspan="2">강의시간</td>
		<td colspan="6" align="center">${lectureDetail.classday_name }요일 ${classhour_name } ${lectureDetail.classhour_start_time } ~ ${lectureDetail.classhour_end_time }</td>
	</tr>
	<tr>
		<td align="center"  colspan="2">과목코드</td>
		<td colspan="2" align="center">${lectureDetail.subject_cd }-${lectureDetail.subject_div_cd }</td>
		<td align="center" colspan="2">개설학과</td>
		<td colspan="2" align="center">${lectureDetail.prof_dept_name }</td>
		<td align="center" colspan="2">수강생수</td>
		<td colspan="2" align="center">${lectureDetail.attendee_cnt }명</td>
	</tr>
</table>

<br>

<div>
<c:choose>
	<c:when test="${empty batchList}">
		강의정보가 없습니다.
	</c:when>
	<c:otherwise>
		<table cellpadding="0" cellspacing="0" border="1"> 
		  <tr> 
		    <td> 
		      <table cellspacing="0" cellpadding="0" border="1"> 
		        <tr> 
		            <td align="center">NO</td> 
		            <td align="center">학생명</td> 
		            <td align="center">학번</td> 
		        </tr> 
		      </table> 
		    </td> 
		    <td> 
		      <div id="topLine"> 
		        <table cellspacing="0" cellpadding="0" border="1"> 
		          <tr height="30">
		<c:forEach var="batch" items="${batchList}">           
		              <td align="center" valign="middle" style="mso-number-format:\@">
		              	<fmt:formatDate value="${batch.classday}" type="both" pattern="MM-dd"/>
		              </td> 
		</c:forEach>               
		          </tr> 
		        </table> 
		      </div> 
		    </td> 
		  </tr> 
		  <tr> 
		    <td width="160"  valign="top"> 
		        <table cellspacing="0" cellpadding="0" border="1"> 
					<c:forEach var="attendeeList" items="${batchList[0].attenddethist }" >        
						<tr height="25" id="attendee_${attendeeList.row_no }"> 
						  <td width="27" align="center" valign="middle" class="tdwhite">${attendeeList.row_no }</td> 
						  <td width="80" align="center" valign="middle" class="tdwhite">${attendeeList.student_name }</td> 
						  <td width="63" align="center" valign="middle" class="tdwhite">${attendeeList.student_no }</td> 
						</tr>
					</c:forEach>
		        </table> 
		    </td> 
		    <td> 
		        <table cellspacing="0" cellpadding="0" border="1">
					<c:forEach var="attendeeList" items="${batchList[0].attenddethist }" >
						<tr height="25">
							<c:forEach var="bList" items="${batchList }" >      
				    
								<c:if test="${bList.class_type_cd=='G019C002' }">
									<td align="center" style="background-color: #e7e7e7;">휴강</td> 
								</c:if>          
								
								<c:if test="${bList.class_type_cd!='G019C002' }">    

									<%-- 변수 초기화 --%>
									<c:set var="attend_sts_text" value="" />
									<c:set var="attend_sts_bg" value="" />

									<c:if test="${bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C001'||bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C002'||bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C003'||bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C004'}">
										
										<c:if test="${bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C002'}">
											<c:set var="attend_sts_text" value="출석" />
										</c:if>
									    <c:if test="${bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C003'}">
									    	<c:set var="attend_sts_text" value="지각" />
									    </c:if>
									    <c:if test="${bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C004'}">
									    	<c:set var="attend_sts_text" value="결석" />
											<c:set var="attend_sts_bg" value='style="color:red;"' />
									    </c:if>
									    
									</c:if>
									
									<c:if test="${bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C005'}">
										<c:set var="attend_sts_text" value="휴학" />
									</c:if>				       
									
									<c:if test="${bList.attenddethist[attendeeList.row_no-1].attend_sts_cd=='G023C007'}">
										<c:set var="attend_sts_text" value="제적" />
									</c:if>		
								     
						            <td align="center" ${attend_sts_bg}>
						            	${attend_sts_text}
						            </td>
						            
								</c:if>
							
							</c:forEach>             
						</tr>
					</c:forEach>
		        </table> 
		    </td> 
		  </tr> 
		</table> 	
	</c:otherwise>
</c:choose> 
</div>

<!-- //교수 출결일괄처리 -->
</div>
</body>
</html>

