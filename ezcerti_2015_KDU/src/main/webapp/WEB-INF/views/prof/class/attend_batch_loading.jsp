<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
	<meta charset="utf-8">
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui-1.10.3.custom.min.js"></script>
</head>
<script type="text/javascript">
	$(function() {
	    $.ajax({
	        type: "GET",
	        url: "${pageContext.request.contextPath}/prof/class/attend_batch",
	        data: { class_cd : '${class_cd}'},   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
	        success: function(msg) {
	        	$("#test").html(msg);
	        	//$("#attend_reason_popup").dialog( "close" );
	        	//window.location.reload(true);
	        	},
	        beforeSend: function() {
	            //통신을 시작할때 처리
	         //jQuery('.ui-dialog button').button('disable');
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
	});
</script>
<body id="test">
	<div id="ajax_indicator" style="display: none;">
	   <p style="text-align:center; padding:16px 0 0 0; left:43%; top:43%; position:absolute;">
	   	출석부를 조회 중입니다. <img src="${pageContext.request.contextPath }/resources/images/ajax-loader.gif" />
	   </p>
	</div>
</body>

</html>

