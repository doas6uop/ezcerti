

$(function(){
	
	
	//----------------------
	//--- Snapshot  
	//----------------------
	
	$("#btn_snapshot").click(function(e){
		 	
			var stdno = $("#stdno").val(); // 학번 
			var dept_cd = $("#dept_cd").val(); // 단과코드 
		    var targetUrl = "/muniv/snapshot/" + dept_cd + "/" + stdno; 
		    
		    $.colorbox({
			     href:targetUrl,
			     iframe:true, 
			     open:true, 
			     scrolling:false,
			     width:340, 
			     height:517,
			     onLoad:function() {
			     },  
			     onComplete:function() {
			     },
			     onClosed:function() {
				 }
			});
		    
		    e.preventDefault();
	});
	

	//----------------------
	//--- uploader   
	//----------------------

	$("#btn_uploadPhoto").click(function(e){
		 	
			var stdno = $("#stdno").val();
			var dept_cd = $("#dept_cd").val(); // 단과코드 
			var targetUrl = "/muniv/photouploader/" + dept_cd + "/" + stdno;  
		    
		    $.colorbox({
			     href:targetUrl,
			     iframe:true, 
			     open:true, 
			     scrolling:false,
			     width:500, 
			     height:181,
			     onLoad:function() {
			     },  
			     onComplete:function() {
				 },
			     onClosed:function() {
				 }
			});
		    
		    e.preventDefault();
	});
	
});


//----------------------
//--- 이미지 교체 
//----------------------

function setStudentPhoto( filePath ) {
	filePath += '?' + new Date().getTime();
	$(".stdPhotoPanel").attr("src", filePath );
}


function setStudentPhotoFromStdNo( stdno, viewPath ) {
	var filePath = '/muniv/photo/viewer/' + stdno + '?' + new Date().getTime();
	$(".stdPhotoPanel").attr("src", filePath );
}
