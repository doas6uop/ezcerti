
		  
$(function(){ 
	
	$(".closeForm").click(function(){
	   parent.$('#closebox').colorbox.close()			
	});
	
	$(":file").filestyle({
		buttonName: "btn-primary"
	});
	
	$(":file").filestyle('buttonText', '&nbsp; 사진선택');
	
	$(":file").change(function(){
		//-- 이미지 확인처리 

		var format = "\.(jpeg|jpg|gif|bmp)$";
		if(!(new RegExp(format, "i")).test($(this).val())) {
		  alert('jpeg,jpg,gif,bmp 만 업로드가 가능합니다.');
		  return;
		}
		
		uploadPhoto();
	});
	
});
  
  
function uploadPhoto() {
	 
	 $('#frm').ajaxForm({
		 dataType : 'json',
         beforeSubmit: function (data,form,option) {
           	Loading(true);
         },
         success: function(data,status){
        	 
	         if( data.isError ) {
	        	  alert("사진 저장 중 오류가 발생하였습니다.\n" + data.message);
	        	  //console.log(data.message);
	          } else {
	        	  parent.setStudentPhotoFromStdNo($("#stdNo").val());
	          }
	
	          setTimeout(function () {
		    		Loading(false);
			        $(".closeForm").click();
		      }, 1000);
	            
	         
         },
         error: function(){
           	  alert('서버 에러가 발생하였습니다.\n관리자에게 문의해 주십시오.');
	          $(".closeForm").click();
	     },                               
     });

	 $("#frm").attr("action", "/muniv/photo/upload"); 
	 $("#frm").attr("method", "post"); 
	 $('#frm').submit();
}
  
 
    