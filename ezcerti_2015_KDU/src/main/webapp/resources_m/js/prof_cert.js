function getContextPath(){
     var offset=location.href.indexOf(location.host)+location.host.length;
     var ctxPath=location.href.substring(offset,location.href.indexOf('/',offset+1));
     
     if(ctxPath.indexOf("prof") >= 0 || ctxPath.indexOf("student") >= 0 || ctxPath.indexOf("muniv") >= 0) {
    	 ctxPath = "";
     }
     
     return ctxPath;
}

function skipLecture(class_cd, classday, classhour_start_time, class_prog_cd, classroom_no){
	if(class_prog_cd == "G018C003") {
		alert("이미 휴강신청이 되어있습니다.");
	} else {
		$("#dialog_skip_lecture1").load(getContextPath()+'/prof/class/class_off',{class_cd:class_cd, classday:classday, classhour_start_time:classhour_start_time, classroom_no:classroom_no});
		$('#dialog_skip_lecture1').dialog('open');
		$('#ajax_indicator1').show().fadeIn('fast');
	}
}

function certType(class_cd, classday, classhour_start_time, cert_sts_cd){
	$("#dialog_cert_lecture0").load(getContextPath()+'/prof/class/class_cert_type',{class_cd:class_cd, classday:classday, classhour_start_time:classhour_start_time, cert_sts_cd:cert_sts_cd});
	$('#dialog_cert_lecture0').dialog('open');
}

function certLectureWithType(class_cd, classday, classhour_start_time, cert_sts_cd, cert_type){
	if(cert_sts_cd=='G021C001'){
		$("#dialog_cert_lecture1").load(getContextPath()+'/prof/class/class_cert',{class_cd:class_cd, classday:classday, classhour_start_time:classhour_start_time, cert_sts_cd:cert_sts_cd, cert_type:cert_type});
		$('#dialog_cert_lecture1').dialog('open');
	}else if(cert_sts_cd=='G021C002'){
		$("#dialog_cert_lecture3").load(getContextPath()+'/prof/class/class_cert_view',{class_cd:class_cd, classday:classday, classhour_start_time:classhour_start_time, cert_sts_cd:cert_sts_cd});
		$('#dialog_cert_lecture3').dialog('open');
	}
}

function certLecture(class_cd, classday, classhour_start_time, cert_sts_cd){
	if(cert_sts_cd=='G021C001'){
		$("#dialog_cert_lecture1").load(getContextPath()+'/prof/class/class_cert',{class_cd:class_cd, classday:classday, classhour_start_time:classhour_start_time, cert_sts_cd:cert_sts_cd});
		$('#dialog_cert_lecture1').dialog('open');
	}else if(cert_sts_cd=='G021C002'){
		$("#dialog_cert_lecture3").load(getContextPath()+'/prof/class/class_cert_view',{class_cd:class_cd, classday:classday, classhour_start_time:classhour_start_time, cert_sts_cd:cert_sts_cd});
		$('#dialog_cert_lecture3').dialog('open');
	}
}
$(function() {
	  $( "#dialog_skip_lecture1" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    width:300,
	    height:330,
	    modal: true,
	    buttons: {
	      "확인": function() {
	    	  if($("#skip_lecture1 :radio[name='rdo_alter']:checked").length <1){
	    		  alert("대체수업 지정여부를 선택해주십시오.");
	    		  return false;
	    	  }else{
	    		  if($("#skip_lecture1 :radio[name='rdo_alter']:checked").val()=="ok"){
	    			  if(!$("#alter_classday").val()){
	    				  alert("대체수업일을 지정해주십시오.");
	    				  return false;
	    			  }
	    		  }
	    	  }
	    	  $( this ).dialog( "close" );
	    	  var rdo_alter = $("#skip_lecture1 :radio[name='rdo_alter']:checked").val();
	    	  var alter_classday = $("#skip_lecture1 [name='alter_classday']").val();
	    	  var alter_classhour = $("#skip_lecture1 [name='alter_classhour']").val();
	    	  var alter_classroom = $("#skip_lecture1 [name='alter_classroom']").val();
	    	  var alter_classoff_reason = $("#skip_lecture1 [name='alter_classoff_reason']").val();
	          var class_cd=$("#skip_lecture1 [name='class_cd']").val();
	          var classday=$("#skip_lecture1 [name='classday']").val();
	          var classhour_start_time=$("#skip_lecture1 [name='classhour_start_time']").val();
	    	  
	    	  $("#dialog_skip_lecture2").load(getContextPath()+'/prof/class/class_off_confirm_request',
	    			  {rdo_alter:rdo_alter, alter_classday:alter_classday, alter_classhour:alter_classhour, alter_classroom:alter_classroom, alter_classoff_reason:alter_classoff_reason, class_cd:class_cd, classday:classday, classhour_start_time:classhour_start_time});
	    	  $('#dialog_skip_lecture2').dialog('open');
	      },
	      "취소": function() {
	        $( this ).dialog( "close" );
	      }
	    }
	  });
	});
$(function() {
	$( "#dialog_skip_lecture2" ).dialog({
		autoOpen: false,
		resizable: false,
		draggable: false,
		width:300,
		height:150,
		modal : true,
	    beforeClose : function(){
	    	location.reload();
	    },
		buttons : {
			"닫기" : function() {
				$(this).dialog("close");
			}
		}
	});
});
$(function() {
	  $( "#dialog_cert_lecture0" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    width:310,
	    height:250,
	    modal: true,
	    buttons: {
	      "확인": function() {
	        $( this ).dialog( "close" );
	        var cert_type=$("#cert_lecture0 [name='cert_type']").val();
	        var cert_sts_cd=$("#cert_lecture0 [name='cert_sts_cd']").val();
	        var class_cd=$("#cert_lecture0 [name='class_cd']").val();
	        var classday=$("#cert_lecture0 [name='classday']").val();
	        var classhour_start_time=$("#cert_lecture0 [name='classhour_start_time']").val();
	        
	        if(cert_type == 'CERT_NUM' || cert_type == 'BEACON_AUTH') {
	        	certLectureWithType(class_cd, classday, classhour_start_time, cert_sts_cd, cert_type);
	        } else {
	        	
	    		$.ajax({
	    			
	  		       type: "POST",
	  		       url: getContextPath()+'/prof/class/class_view_cert_type_update',
	  		       data: { 
	  		    	   		class_cd:class_cd, 
	  		    	   		classday:classday, 
	  		    	   		classhour_start_time:classhour_start_time,
	  		    	   		cert_type:cert_type
	  		    	     },   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
	  		       success: function(msg) {

	  		        	location.href = getContextPath()+'/prof/class/class_view?classday='+classday
	  		        					+'&class_cd='+class_cd+'&classhour_start_time='+classhour_start_time;
	  			       	
	  		       },
	  		       error: function(msg){
	  		       	alert(msg);
	  		       }
		  			       
		     	});
	    		
	        	// location.href=getContextPath()+'/prof/class/class_view?cert_type='+cert_type+'&classday='+classday+'&class_cd='+class_cd+'&classhour_start_time='+classhour_start_time;
	        }
	      },
	      "취소": function() {
	        $( this ).dialog( "close" );
	      }
	    }
	  });
	});
$(function() {
	  $( "#dialog_cert_lecture1" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    width:310,
	    height:250,
	    modal: true,
	    buttons: {
	      "확인": function() {
	        $( this ).dialog( "close" );
	        var cert_type=$("#cert_lecture1 [name='cert_type']").val();
	        var class_cd=$("#cert_lecture1 [name='class_cd']").val();
	        var classday=$("#cert_lecture1 [name='classday']").val();
	        var classhour_start_time=$("#cert_lecture1 [name='classhour_start_time']").val();
	        var cert_time=$("#cert_lecture1 [name='cert_time']").val();
	        var cert_sts_cd=$("#cert_lecture1 [name='cert_sts_cd']").val();
	        $("#dialog_cert_lecture2").load(getContextPath()+'/prof/class/class_cert_confirm',{class_cd:class_cd, classday:classday, classhour_start_time:classhour_start_time, cert_time:cert_time, cert_sts_cd:cert_sts_cd, cert_type:cert_type});
	        $('#dialog_cert_lecture2').dialog('open');
	      },
	      "취소": function() {
	        $( this ).dialog( "close" );
	      }
	    }
	  });
	});
$(function() {
	  $( "#dialog_cert_lecture2" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    width:310,
	    height:250,
	    modal: true,
	    buttons: {
	      "확인": function() {
	        $( this ).dialog( "close" );
	        var cert_type=$("#cert_lecture1 [name='cert_type']").val();
	        var class_cd=$("#cert_lecture2 [name='class_cd']").val();
	        var classday=$("#cert_lecture2 [name='classday']").val();
	        var classhour_start_time=$("#cert_lecture2 [name='classhour_start_time']").val();
	        var cert_time=$("#cert_lecture2 [name='cert_time']").val();
	        var cert_sts_cd=$("#cert_lecture2 [name='cert_sts_cd']").val();
	        $("#dialog_cert_lecture3").load(getContextPath()+'/prof/class/class_cert_view',{class_cd:class_cd, classday:classday, classhour_start_time:classhour_start_time, cert_time:cert_time, cert_sts_cd:cert_sts_cd, cert_type:cert_type});
	        $('#dialog_cert_lecture3').dialog('open');
	      },
	      "취소": function() {
	        $( this ).dialog( "close" );
	      }
	    }
	  });
	});
$(function() {
	  $( "#dialog_cert_lecture3" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    width:310,
	    height:250,
	    modal: true,
	    beforeClose : function(){
	    	location.reload();
	    },
	    buttons: {
	      "닫기": function() {
	        $( this ).dialog( "close" );
	        
	        var class_cd=$("#cert_lecture3 [name='class_cd']").val();
	        var classday=$("#cert_lecture3 [name='classday']").val();
	        var classhour_start_time=$("#cert_lecture3 [name='classhour_start_time']").val();
	        
      	location.href=getContextPath()+'/prof/class/class_view?classday='+classday+'&class_cd='+class_cd+'&classhour_start_time='+classhour_start_time;	        
	      }
	    }
	  });
	});