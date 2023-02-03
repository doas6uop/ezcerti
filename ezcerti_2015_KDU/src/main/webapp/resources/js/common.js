function getContextPath(){
     var offset=location.href.indexOf(location.host)+location.host.length;
     var ctxPath=location.href.substring(offset,location.href.indexOf('/',offset+1));
     
     if(ctxPath.indexOf("prof") >= 0 || ctxPath.indexOf("student") >= 0 || ctxPath.indexOf("muniv") >= 0) {
    	 ctxPath = "";
     }
     
     return ctxPath;
}

(function($) {
	$.ajaxSetup({
	       beforeSend: function(xhr) {
	        xhr.setRequestHeader("AJAX", true);
	    },
	    error: function(xhr, status, err) {
	        if (xhr.status == 401) {
	               alert(xhr.status+" 오류가 발생했습니다. 관리자에게 문의해주세요.");
	        } else if (xhr.status == 403) {
	               alert("세션이 만료되었습니다. 다시 로그인해주세요.");
	               window.location.href=getContextPath()+'/';
	        //} else {
	        //    alert(xhr.status+" 오류가 발생했습니다. 관리자에게 문의해주세요.");
	        }
	    }
	});
})(jQuery);

function checkAttendAuth(classday, checkDate, nowDate) {
	
	var now = new Date(nowDate); 
	var specificDate = new Date(classday);
	
	var days = Math.floor((now.getTime() - specificDate.getTime())/ (1000*60*60*24));
	
	//if(days == 0 || (days == 1 && now.getHours() < checkTime)) {
	/*
	if(checkDate == 0 || days <= checkDate) {	
		return true;
	} else {
		return false;
	}
	*/
	return true;
}