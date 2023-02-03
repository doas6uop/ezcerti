$(function(){ 
		
		var is_chrome = /chrome/i.test( navigator.userAgent );
		
		if(is_chrome) { //-- 크롬인 경우 browser 에서 막는경우가 있음..

	    	Webcam.set({
				width: 330,
				height: 390,
				force_flash: true,
				image_format: 'jpeg',
				jpeg_quality: 100
			});
		
		} else {

	    	Webcam.set({
				width: 330,
				height: 390,
				image_format: 'jpeg',
				jpeg_quality: 100
			});
		   
		}

        Webcam.on( 'error', function(err) {
        	alert("웹캠이 필요한 서비스 입니다.");
        	$(".closeForm").click();
        });
        

		Webcam.attach( '#p-camera' );
		
		
		$("#btnSnapShop").click(function(){
			Webcam.freeze();
			$("#panelBeforeSnapShop").hide();
			$("#panelAfterSnapShop").show();
		});
		
		$("#btnRetake").click(function(){
			Webcam.unfreeze();
			$("#panelBeforeSnapShop").show();
			$("#panelAfterSnapShop").hide();
		});
		
		$("#btnSave").click(function(){

			Webcam.snap( function(data_uri) {
			   var raw_image_data = data_uri.replace(/^data\:image\/\w+\;base64\,/, '');
			   $("#stdPicture").val(raw_image_data);
			   imageUpload(); 
			   $("#panelBeforeSnapShop").show();
			   $("#panelAfterSnapShop").hide();
			});
		});
		
		$(".closeForm").click(function(){
			parent.$('#closebox').colorbox.close()			
 		});
		
				
});
		  
		  
//-- Ajax Image Upload 
function imageUpload() {
		    	
	var formData = $("#frm").serialize();
	
	$.ajax({
		  	type: 'post',
            data: formData,
            url: '/muniv/snapsave',
            //dataType: "json",
            success: function (data) {
            	
            	if( data.isError ) {
            	  alert("사진 저장 중 오류가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.");
            	  console.log(data.message);
            	} else {
 	    		   //parent.setStudentPhoto(data.result);
  	        	  parent.setStudentPhotoFromStdNo($("#stdNo").val());
            	}
            	
            },
            error: function (xhr, textStatus) {
            	alert('서버 에러가 발생하였습니다.\n관리자에게 문의해 주십시오.');
            },
            beforeSend: function () {
            	Loading(true);
            },
            complete: function () {

                setTimeout(function () {
    	    		Loading(false);
    		        $(".closeForm").click();
    	    	}, 1000);
                
            }	
		
	});
		    	
}
		    