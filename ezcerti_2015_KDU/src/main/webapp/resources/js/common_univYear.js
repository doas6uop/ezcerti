
	function getContextPath(){
	     var offset=location.href.indexOf(location.host)+location.host.length;
	     var ctxPath=location.href.substring(offset,location.href.indexOf('/',offset+1));

	     if(ctxPath.indexOf("prof") >= 0 || ctxPath.indexOf("student") >= 0 || ctxPath.indexOf("muniv") >= 0) {
	    	 ctxPath = "";
	     }

	     return ctxPath;
	}

	$(function() {

 		$('#term_start_date').datepicker();
 		$('#term_start_date').datepicker("option", "maxDate", $("#term_end_date").val());
 		$('#term_start_date').datepicker("option", "onClose", function ( selectedDate ) {
     		$("#term_end_date").datepicker( "option", "minDate", selectedDate );
     	});

 		$('#term_end_date').datepicker();
 		$('#term_end_date').datepicker("option", "minDate", $("#term_start_date").val());
 		$('#term_end_date').datepicker("option", "onClose", function ( selectedDate ) {
 			$("#term_start_date").datepicker( "option", "maxDate", selectedDate );
 		});

 		$('#bogang_start').datepicker();
 		$('#bogang_start').datepicker("option", "maxDate", $("#bogang_end").val());
 		$('#bogang_start').datepicker("option", "onClose", function ( selectedDate ) {
     		$("#bogang_end").datepicker( "option", "minDate", selectedDate );
     	});

 		$('#bogang_end').datepicker();
 		$('#bogang_end').datepicker("option", "minDate", $("#bogang_start").val());
 		$('#bogang_end').datepicker("option", "onClose", function ( selectedDate ) {
 			$("#bogang_start").datepicker( "option", "maxDate", selectedDate );
 		});

 		$('#noclass_start').datepicker();
 		$('#noclass_start').datepicker("option", "maxDate", $("#noclass_end").val());
 		$('#noclass_start').datepicker("option", "onClose", function ( selectedDate ) {
     		$("#noclass_end").datepicker( "option", "minDate", selectedDate );
     	});

 		$('#noclass_end').datepicker();
 		$('#noclass_end').datepicker("option", "minDate", $("#noclass_start").val());
 		$('#noclass_end').datepicker("option", "onClose", function ( selectedDate ) {
 			$("#noclass_start").datepicker( "option", "maxDate", selectedDate );
 		});

	    $('#lssn_admt_dt').datepicker();
	    // $('#chul_start_dt').datepicker();
	    // $('#chul_end_dt').datepicker();
	});

    $(document).on('change', '.datePickerEvent', function(){

    	var tmpCheckParam1 = $("#term_start_date").val().length + $("#term_end_date").val().length;
    	var tmpCheckParam2 = $("#bogang_start").val().length + $("#bogang_end").val().length
    							+ $("#noclass_start").val().length + $("#noclass_end").val().length;

		if(tmpCheckParam1 == 20) {

			if (tmpCheckParam2 == 0) {
				getDayofWeekCnt();
			} else if((tmpCheckParam2%20) == 0) {
				getDayofWeekCnt();
			}
		}
	});

    function getDayofWeekCnt() {

		var tmp_term_start_date = $('#term_start_date').val();
		var tmp_term_end_date = $('#term_end_date').val();
		var tmp_bogang_start = $('#bogang_start').val();
		var tmp_bogang_end = $('#bogang_end').val();
		var tmp_noclass_start = $('#noclass_start').val();
		var tmp_noclass_end = $('#noclass_end').val();

		$.ajax({
			type: "POST",
			url: getContextPath() + "/muniv/info/univyear_get_day_of_week_cnt",
			data: {
					  term_start_date : tmp_term_start_date
					, term_end_date : tmp_term_end_date
					, bogang_start : tmp_bogang_start == '' ? "0001-01-01" : tmp_bogang_start
					, bogang_end : tmp_bogang_end == '' ? "0001-01-01" : tmp_bogang_end
					, noclass_start : tmp_noclass_start == '' ? "0001-01-01" : tmp_noclass_start
					, noclass_end : tmp_noclass_end == '' ? "0001-01-01" : tmp_noclass_end
				  },
			dataType : 'json',
			success: function(data) {

				//통신이 완료된 후 처리
				$('.spinner_layer').fadeOut('fast', function(){

					// 초기화
					$('#dayOfweekCntDiv').html("");
		        	var tmpText = "";

		        	if(data.dayOfWeekList == ""){
		        		tmpText += "<td colspan='7'>표시할 데이터가 없습니다.</td>";
		        	} else {

			        	// 주차별 요일수 초기화
			        	var tmpArr = [0, 0, 0, 0, 0, 0, 0];

			        	// 갯수 세팅
			        	$.each(data.dayOfWeekList, function(key, value){
							/*
			        		if(value.DAY_NUM == 1) {
			        			tmpArr[6] = value.CNT;
			        		} else {
			        			tmpArr[value.DAY_NUM-2] = value.CNT;
			        		}
			        		*/
			        		tmpArr[value.DAY_NUM-1] = value.CNT;
			        	});

			        	for(var i=0; i < tmpArr.length; i++) {
			        		tmpText += "<td>" + tmpArr[i] + "</td>";
		    			}
		        	}

		        	$('#dayOfweekCntDiv').append(tmpText);
				});
			},
			beforeSend: function() {
				$('.spinner_layer').show().fadeIn('fast');
			},
			error: function(msg){
				$('.spinner_layer').fadeOut('fast', function(){
					alert(msg);
				});
			}
		});
	}

	function save(param) {

		var tmp_year = $('#year').val();
		var tmp_term_start_date = $('#term_start_date').val();
		var tmp_term_end_date = $('#term_end_date').val();
		var tmp_bogang_start = $('#bogang_start').val();
		var tmp_bogang_end = $('#bogang_end').val();
		var tmp_noclass_start = $('#noclass_start').val();
		var tmp_noclass_end = $('#noclass_end').val();

		if(tmp_year == "") {
			alert("연도를 입력하시기 바랍니다.");
			$('#year').focus();
			return;
		}
		if(tmp_term_start_date == "") {
			alert("학기시작일을 입력하시기 바랍니다.");
			$('#term_start_date').focus();
			return;
		}
		if(tmp_term_end_date == "") {
			alert("학기종료일을 입력하시기 바랍니다.");
			$('#term_end_date').focus();
			return;
		}
		if(tmp_bogang_start == "") {
			alert("보강시작일을 입력하시기 바랍니다.");
			$('#bogang_start').focus();
			return;
		}
		if(tmp_bogang_end == "") {
			alert("보강종료일을 입력하시기 바랍니다.");
			$('#bogang_end').focus();
			return;
		}
		if(tmp_noclass_start == "") {
			alert("강의생성제외시작일을 입력하시기 바랍니다.");
			$('#noclass_start').focus();
			return;
		}
		if(tmp_noclass_end == "") {
			alert("강의생성제외종료일을 입력하시기 바랍니다.");
			$('#noclass_end').focus();
			return;
		}

		var dd = $("#lssn_admt_dt").val();

		// var cs = $("#chul_start_dt").val();
		// var ce = $("#chul_end_dt").val();
		// var tmp_chul_term = $("#chul_term").val();
/*
		if(Number(cs.length) + Number(ce.length) + Number(tmp_chul_term.length) < 1) {
			alert("출결처리기간 시작/종료일 또는\n\n출결처리기간(일지정)을 입력 바랍니다.");
			$('#chul_start_dt').focus();
			return;
		} else if(Number(cs.length) + Number(ce.length) > 0
				&& Number(cs.length) + Number(ce.length) < 20) {

			alert("출결처리기간 시작/종료일 모두 입력 바랍니다.");

			if(Number(cs.length) == 10) {
				$('#chul_end_dt').focus();
			} else {
				$('#chul_start_dt').focus();
			}

			return;
		}
*/

		$("#lssn_admt_dt").val( dd.replace(/-/gi, "") );
		// $("#chul_start_dt").val( cs.replace(/-/gi, "") );
		// $("#chul_end_dt").val( ce.replace(/-/gi, "") );

	    if($('#term_start_date').val() == ''){
	    	$("#term_start_date").val("0001-01-01");
	    }
	    if($('#term_end_date').val() == ''){
	    	$("#term_end_date").val("0001-01-01");
	    }
	    if($('#bogang_start').val() == ''){
	    	$("#bogang_start").val("0001-01-01");
	    }
	    if($('#bogang_end').val() == ''){
	    	$("#bogang_end").val("0001-01-01");
	    }
	    if($('#noclass_start').val() == ''){
	    	$("#noclass_start").val("0001-01-01");
	    }
	    if($('#noclass_end').val() == ''){
	    	$("#noclass_end").val("0001-01-01");
	    }
	    if($('#lssn_admt_dt').val() == ''){
	    	$("#lssn_admt_dt").val("0001-01-01");
	    }
/*
	    if($('#chul_start_dt').val() == ''){
	    	$('#chul_start_dt').datepicker('option', 'disabled', false);
	    	$("#chul_start_dt").val("0001-01-01");
	    }
	    if($('#chul_end_dt').val() == ''){
    		$('#chul_end_dt').datepicker('option', 'disabled', false);
	    	$("#chul_end_dt").val("0001-01-01");
	    }
	    if($('#chul_term').val() == ''){
    		$('#chul_term').attr("disabled", false);
	    	$("#chul_term").val("");
	    }
*/

		var postString = $("#saveForm").serialize();

		$.ajax({
			type: "POST",
			url: getContextPath() + "/muniv/info/" + param,
			data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
			success: function(msg) {
				alert("저장이 완료 되었습니다.");
				$("#myModal1").modal('hide');
				location.href = location.href;
			},
			error: function(msg){
				alert(msg);
			}
		});
	}

	function inputInit(param) {

		$('#' +  param).val('');

		if(param == "chul_start_dt" || param == "chul_end_dt" || param == "chul_term") {
			chkInputData();
		}
	}

    $(document).on('change', '.chkInputData', function(){
    	chkInputData();
	});

    function chkInputData() {

    	/*
    	 * 현재 관련사항은 쓰이지 않음

    	var tmpCheckParam = $("#chul_start_dt").val().length + $("#chul_end_dt").val().length;
    	var tmpCheckParam2 = $("#chul_term").val().length;
    	// console.log("chkInputData");

    	if(Number(tmpCheckParam) + Number(tmpCheckParam2) > 0) {

    		if(tmpCheckParam > 0) {
        		$('#chul_term').attr("disabled", true);
        	} else {
        		$('#chul_start_dt').datepicker('option', 'disabled', true);
        		$('#chul_end_dt').datepicker('option', 'disabled', true);
        	}
    	} else {
    		$('#chul_term').attr("disabled", false);
    		$('#chul_start_dt').datepicker('option', 'disabled', false);
    		$('#chul_end_dt').datepicker('option', 'disabled', false);
    	}
    	*/
    }

	function deleteUnivTerm() {

		var tmp_year = $('#year').val();
		var tmp_term_cd = $('#term_cd').val();
		var tmp_term_name = $('#term_name').val();
		// alert(tmp_year + " , " + tmp_term_cd + " , " + tmp_term_name);

		if(confirm("삭제하시겠습니까?") == true) {

			$.ajax({
				type: "GET",
				url: getContextPath() + "/muniv/info/univyear_delete_ok?year=" + tmp_year + "&term_cd=" + tmp_term_cd,
				success: function(msg) {
					alert("삭제처리가 완료 되었습니다.");
					$("#myModal1").modal('hide');
					location.href = location.href;
				},
				error: function(msg){
					alert(msg);
				}
			});
		}
	}




