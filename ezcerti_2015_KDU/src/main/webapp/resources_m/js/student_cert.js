function getContextPath(){
     var offset=location.href.indexOf(location.host)+location.host.length;
     var ctxPath=location.href.substring(offset,location.href.indexOf('/',offset+1));
     
     if(ctxPath.indexOf("prof") >= 0 || ctxPath.indexOf("student") >= 0 || ctxPath.indexOf("muniv") >= 0) {
    	 ctxPath = "";
     }
     
     return ctxPath;
}

function certLecture(class_cd, classday, classhour_start_time, attend_sts_cd){
	if(attend_sts_cd=='G023C001'){
		$("#dialog_cert_lecture1").load(getContextPath()+'/m/student/attend/attend_cert',{class_cd:class_cd, classday:classday, classhour_start_time:classhour_start_time});
		$("#dialog_cert_lecture1").dialog("open");
	}else{
		$("#dialog_cert_lecture2").load(getContextPath()+'/m/student/attend/attend_cert_confirm',{class_cd:class_cd, classday:classday, classhour_start_time:classhour_start_time});
		$("#dialog_cert_lecture2").dialog("open");
	}
}
$(function() {
	  $( "#dialog_cert_lecture1" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    width:280,
	    height:150,
	    modal: true,
	    buttons: {
	      "확인": function() {
	        $( this ).dialog( "close" );
	        var class_cd = $("#cert_lecture1 [name='class_cd']").val();
	        var classday = $("#cert_lecture1 [name='classday']").val();
	        var classhour_start_time = $("#cert_lecture1 [name='classhour_start_time']").val();
	        var cert_code = $("#cert_lecture1 [name='cert_code']").val();
	        $("#dialog_cert_lecture2").load(getContextPath()+'/m/student/attend/attend_cert_confirm',{class_cd:class_cd, classday:classday, classhour_start_time:classhour_start_time, cert_code:cert_code});
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
	    width:280,
	    height : 150,
		modal : true,
	    beforeClose : function(){
	    	location.reload();
	    },
	    buttons: {
		      "닫기": function() {
		        $( this ).dialog( "close" );
		      }
	    }
	});
});
