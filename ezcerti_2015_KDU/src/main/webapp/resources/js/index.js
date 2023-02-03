$(document).ready(function(){
	
	//alert('현재 데이터베이스를 정비중에 있어서 출결시스템을 사용하실 수 없습니다.\n사용상에 불편을 드려 죄송합니다.\n잠시만 기다려 주세요.');
	
	// HTTP프로토콜 HTTPS로 변경
/* 	
	if (document.location.protocol == 'http:' && '${chk_local }' == 'N') {
		location.href = 'https://attend.kduniv.ac.kr/';
	}
 */	
});

//window.open("popup", "공지사항", "width=400,height=500,menubar=no,status=no,toolbar=no");
$(function() {
  $( "#lost_password" ).dialog({
    autoOpen: false,
    resizable: false,
    draggable: false,
    width:260,
    height:230,
    modal: true,
    buttons: {
   	  "확인": function() {
   		var email_regx=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
   		if($("input:radio[name='rdo_type']:checked").length < 1){
   			alert("회원유형을 선택해주세요.");
   			return false;
   		}else if($("#lost_id").val() == ""){
   			alert("학번 / 사번을 입력해주세요.");
   			$("#lost_id").focus();
   			return false;
   		}else if($("#lost_name").val() == ""){
   			alert("이름을 입력해주세요.");
   			$("#lost_name").focus();
   			return false;
   		}else if($("#lost_email").val() == ""){
   			alert("이메일을 입력해주세요.");
   			$("#lost_email").focus();
   			return false;
   	    }else if(!email_regx.test($("#lost_email").val())){
   	    	alert("잘못된 이메일 형식입니다.");
   	    	$("#lost_email").focus();
   	    	return false;
   	    }
   		var rdo_type = $("#lost_password :radio[name='rdo_type']:checked").val();
		var postString = {lost_type: rdo_type, lost_id: $("#lost_id").val(), lost_name: $("#lost_name").val(), lost_email: $("#lost_email").val()};
		
	    $.ajax({
	        type: "POST",
	
	        url: "${pageContext.request.contextPath }/password_lost",
	
	        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
	
	        success: function(msg) {
	        	alert(msg);
	        	window.location.reload(true);
	        	},
	        beforeSend: function() {
	            //통신을 시작할때 처리
	         jQuery('.ui-dialog button:nth-child(1)').button('disable');
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
         },    	
      "취소": function() {
        $( this ).dialog( "close" );
      }
    }
  });
});