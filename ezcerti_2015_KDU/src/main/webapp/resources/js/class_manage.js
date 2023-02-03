
	// ========================================================================
	// 검색 관련(공통)
	// ========================================================================

	// 그리드 초기화
	function resetGridTableArea(list, tableArea, pager)
	{
		$("#" + list).clearGridData();
		$("#" + list).remove();
		$("#" + tableArea).empty();
		var a = $("<table>").attr("id", list);
		$("#" + tableArea).append(a);
		a = $("<div>").attr("id", pager);
		$("#" + tableArea).append(a);
	}

	// 한글 인코딩
	function encodingValue(value)
	{
		var ua = window.navigator.userAgent;

		var va = "";
	    // 윈도우라면 ?
	    if (ua.indexOf('MSIE') > 0 || ua.indexOf('Trident') > 0) {
	    	va = encodeURI(value);
	    } else {
	    	va = value;
	    }

	    return va;
	}

	// 정렬 함수
	function sortByKey(array, key) {

		return array.sort(

			function(a, b) {
				var x = a[key];
				var y = b[key];
				return ((x < y) ? -1 : ((x > y) ? 1 : 0));
			}
		);
	}

	function fn_search(tmpFunc) {

		var sv = $("#searchValue").val();
		var checkedData_param = $("#checkedData_select option:selected").val();

		switch (tmpFunc) {
		  case "class_manage_univ_term": classManageUnivTerm(sv); break;
		  case "class_manage_target_view_chk": classManageTargetViewChk(sv); break;
		  case "class_manage_target_view": classManageTargetView(sv); break;
		  case "class_manage_checked_data": if(checkedData_param == 0) {alert("값을 선택해주세요"); return;} classManageCheckedData(checkedData_param); break;
		  case "class_manage_close_check": classManageCloseCheck(sv); break;
		  case "class_manage_close_check_2": classManageCloseCheck(365); break;
		  case "term_end_manage": termEndManage(sv); break;
		  default: ""; break;
		}
	}

	function fn_key(tmpFunc) {
		if(event.keyCode == '13') {
			fn_search(tmpFunc);
		}
	}

	// ========================================================================
	// 검색 관련(신규학기 강의생성 관련)
	// ========================================================================

	// 학기테이블 조회
	function classManageUnivTerm(value) {

		gridLoading = true;
		resetGridTableArea("classManageUnivTermList" , "tableArea", "classManageUnivTermPager");

		var va = encodingValue(value);
		var url = "/muniv/class_manage/class_manage_univ_term_list?searchValue="+va;

		$("#classManageUnivTermList").jqGrid({
		   	url:url,
			datatype: "json",
			mtype : 'post',
			width : 960,
			shrinkToFit : false,
			colNames:[
						  '학기상태'
						, '학교코드'
						, '학교명'
						, '연도'
						, '학기코드'
						, '학기명'
						, '학기시작일'
						, '학기종료일'
						, '보강주 시작일'
						, '보강주 종료일'
						, '강의생성제외 시작일'
						, '강의생성제외 종료일'
						, '수업인정일자(성적인정)'
						// , '출결처리기간 시작일'
						// , '출결처리기간 종료일'
						// , '출결처리기간(일지정)'
					 ],
		   	colModel:[
		   				{name:'UNIV_STS_NM', width:60, align:"center"},
		   				{name:'UNIV_CD', width:10, align:"center", hidden:true},
				   		{name:'UNIV_NAME', width:95, align:"center"},
				   		{name:'YEAR', width:50, align:"center"},
				   		{name:'TERM_CD', width:10, align:"center", hidden:true},
						{name:'TERM_NAME', width:95, align:"center"},
						{name:'TERM_START_DATE', width:100, align:"center"},
						{name:'TERM_END_DATE', width:100, align:"center"},
						{name:'BOGANG_START', width:100, align:"center"},
						{name:'BOGANG_END', width:100, align:"center"},
						{name:'NOCLASS_START', width:125, align:"center"},
						{name:'NOCLASS_END', width:125, align:"center"},
						{name:'LSSN_ADMT_DT', width:140, align:"center"},
						// {name:'CHUL_START_DT', width:125, align:"center"},
						// {name:'CHUL_END_DT', width:125, align:"center"},
						// {name:'CHUL_TERM', width:130, align:"center"}
					 ],
		   	loadComplete : function(data){

		   	    // Row Color Change Event
				var selarrrow = (''+$("#classManageUnivTermList").jqGrid("getDataIDs")).split(',');
				var value = "";

				$(selarrrow).each(function(i){
					value = $("#classManageUnivTermList").getCell(selarrrow[0], 'YEAR') + $("#classManageUnivTermList").getCell(selarrrow[0], 'TERM_CD');
				});

				if(value != '') {
					classManageClassday(value);
				}
		   	},
		   	rowNum:100,
		   	rowList: [100, 500, 1000],
		   	pager: '#classManageUnivTermPager',
			pagerpos:'center',
			pgbuttons : true,
		   	sortname: 'date',
		    viewrecords: true,
		    sortorder: "desc",
		    id: 'ITEM',
		    jsonReader:{
				repeatitems:false,
				page: function (obj) { return obj.page; },
		        total: function (obj) { return obj.total; },
		        records: function (obj) { return obj.ITEM.length; },
		        root: function (obj) { return obj.ITEM; }
			},
		    caption:"※ 연도학기관리",
		    //multiselect: true,
	    	rownumbers: true,
	    	height: 120,
	    	hidegrid: false,
	    	onCellSelect : function(rowid, index, contents, event){

				var selarrrow = (''+$("#classManageUnivTermList").jqGrid("getDataIDs")).split(',');

				$(selarrrow).each(function(i){
					$("#classManageUnivTermList").setRowData(i+1, false, {background: "#FFF"});
				});
				$("#classManageUnivTermList").setRowData(rowid, false, {background: "#D6F0FF"});

				var year = $(this).jqGrid("getRowData", rowid).YEAR;
				var term_cd = $(this).jqGrid("getRowData", rowid).TERM_CD;
				var val = String(year) + String(term_cd);

				classManageClassday(val);
	    	},
			ondblClickRow: function (rowid, iRow, iCol, e) {

				var univ_cd = $(this).jqGrid("getRowData", rowid).UNIV_CD;
				var year = $(this).jqGrid("getRowData", rowid).YEAR;
				var term_cd = $(this).jqGrid("getRowData", rowid).TERM_CD;

				doView(univ_cd, year, term_cd);
			}
		});
	}

	function classManageClassday(value) {

		resetGridTableArea("classManageClassdayList" , "tableArea2", "classManageClassdayPager");

		var va = encodingValue(value);
		var url = "/muniv/class_manage/class_manage_classday_list?searchValue="+va;

		$("#classManageClassdayList").jqGrid({
		   	url:url,
			datatype: "json",
			mtype : 'post',
			width : 960,
			shrinkToFit : true,
			colNames:[
						  '년도'
						, '학기'
						, '일자'
						, '요일'
						, '요일명'
						// , '요일구분'
						// , '요일구분코드'
					 ],
		   	colModel:[
						{name:'YEAR', width:50, align:"center"},
						{name:'TERM_NM', width:50, align:"center"},
						{name:'CLASSDAY', width:100, align:"center"},
						{name:'CLASSDAY_NO', width:80, align:"center"},
						{name:'CLASSDAY_NAME', width:110, align:"center"},
						// {name:'CLASSDAY_NM', width:60, align:"center"},
						// {name:'CLASSDAY_CD', width:60, align:"center", hidden:true}
				     ],
		   	loadComplete : function(data){
		   	    // Row Color Change Event
		   	    var ids = $("#classManageClassdayList").getDataIDs();
		   	    // Grid Data Get!
		   	    $.each(
		   	        ids,function(idx, rowId){
		   	        var rowData = $("#classManageClassdayList").getRowData(rowId);
		   	        // 만약 rowName 컬럼의 데이터가 공백이라면 해당 Row의 색상을 변경!
		   	        if (rowData.CLASSDAY_CD == 'G035C002' || rowData.CLASSDAY_CD == 'G035C004') {
		   	            $("#classManageClassdayList").setRowData(rowId, false, {     color: "#FF0000" });
		   	        }
		   	        else if(rowData.CLASSDAY_CD == 'G035C003')
		   	        {
		   	        	$("#classManageClassdayList").setRowData(rowId, false, {     color: "#0100FF" });
		   	        }
		   	        else
		   	        {
		   	        	//$("#classManageClassdayList").setRowData(rowId, false, {     color: "#721c24", background:"#f8d7da" });
		   	        }
		   	    }
		   	    );

		   	},
		   	rowNum:100,
		   	rowList: [100, 500, 1000],
		   	pager: '#classManageClassdayPager',
			pagerpos:'center',
			pgbuttons : true,
		   	sortname: 'date',
		    viewrecords: true,
		    sortorder: "desc",
		    id: 'ITEM',
		    jsonReader:{
				repeatitems:false,
				page: function (obj) { return obj.page; },
		        total: function (obj) { return obj.total; },
		        records: function (obj) { return obj.ITEM.length; },
		        root: function (obj) { return obj.ITEM; }
			},
		    caption:"※ 강의일자관리",
		    //multiselect: true,
	    	rownumbers: true,
	    	height: 150,
	    	hidegrid: false,
	    	cmTemplate:{sortable:false},
	    	onCellSelect : function(rowid, index, contents, event){
				var selarrrow = (''+$("#classManageClassdayList").jqGrid("getDataIDs")).split(',');

				$(selarrrow).each(function(i){
					$("#classManageClassdayList").setRowData(i+1, false, {     background: "#FFF" });
				});
				$("#classManageClassdayList").setRowData(rowid, false, {     background: "#D6F0FF" });
			}
		});
	}

	// 학교 뷰데이터 조회
	function classManageTargetView(value) {

		resetGridTableArea("classManageTargetViewList" , "tableArea3", "classManageTargetViewPager");
		resetGridTableArea("classManageCopyDataList" , "tableArea4", "classManageCopyDataPager");
		resetGridTableArea("classManageSyncDataList" , "tableArea5", "classManageSyncDataPager");

		$('#execute2_1').attr('style', 'display: none; float: left;');
		$('#execute2_2').attr('style', 'display: none; float: left;');
		$('#execute2_3').attr('style', 'display: none; float: right; margin-right:2px;');

		var va = encodingValue(value);
		var url = "/muniv/class_manage/class_manage_target_view_list?searchValue="+va;

		$("#classManageTargetViewList").jqGrid({
		   	url:url,
			datatype: "json",
			mtype : 'post',
			width : 960,
			shrinkToFit : true,
			colNames:[
						  '연도'
						, '학기코드'
						, '학기명'
						, '대상명'
						, '대상뷰정보'
						, '데이터수'
					 ],
		   	colModel:[
						{name:'YEAR', width:50, align:"center"},
				   		{name:'TERM_CD', width:10, zalign:"center", hidden:true},
						{name:'TERM_NM', width:50, align:"center"},
						{name:'TBL_NM', width:110, align:"center"},
						{name:'TBL', width:110, align:"center"},
						{name:'CNT', width:110, align:"center"}
				     ],
		   	loadComplete : function(data){

		   	    // Row Color Change Event
				var selarrrow = (''+$("#classManageTargetViewList").jqGrid("getDataIDs")).split(',');
				var value = "";

				$(selarrrow).each(function(i){
					value = $("#classManageTargetViewList").getCell(selarrrow[0], 'YEAR');
				});


				if(value != '') {
					$('#execute2_1').show();
					classManageCopyData();
				}

				if(value != '') {
					$('#execute2_2').show();
					$('#execute2_3').show();
					classManageSyncData();
				}

		   	},
		   	rowNum:100,
		   	rowList: [100, 500, 1000],
		   	pager: '#classManageTargetViewPager',
			pagerpos:'center',
			pgbuttons : true,
		   	sortname: 'date',
		    viewrecords: true,
		    sortorder: "desc",
		    id: 'ITEM',
		    jsonReader:{
				repeatitems:false,
				page: function (obj) { return obj.page; },
		        total: function (obj) { return obj.total; },
		        records: function (obj) { return obj.ITEM.length; },
		        root: function (obj) { return obj.ITEM; }
			},
		    caption:"※ 학교뷰데이터조회",
		    //multiselect: true,
	    	rownumbers: true,
	    	height: 160,
	    	hidegrid: false,
	    	cmTemplate:{sortable:false},
	    	onCellSelect : function(rowid, index, contents, event){

				var selarrrow = (''+$("#classManageTargetViewList").jqGrid("getDataIDs")).split(',');

				$(selarrrow).each(function(i){
					$("#classManageTargetViewList").setRowData(i+1, false, {     background: "#FFF" });
				});
				$("#classManageTargetViewList").setRowData(rowid, false, {     background: "#D6F0FF" });
			}
		});
	}

	// 학교 뷰정보 이관 테이블 조회
	function classManageCopyData() {

		resetGridTableArea("classManageCopyDataList" , "tableArea4", "classManageCopyDataPager");

		var url = "/muniv/class_manage/class_manage_copy_data_list";

		$("#classManageCopyDataList").jqGrid({
		   	url:url,
			datatype: "json",
			mtype : 'post',
			width : 477,
			shrinkToFit : true,
			colNames:[
						  '대상명'
						, '대상테이블정보'
						, '데이터수'
					 ],
		   	colModel:[
						{name:'TBL_NM', width:75, align:"center"},
						{name:'TBL', width:130, align:"center"},
						{name:'CNT', width:75, align:"center"}
				     ],
		   	loadComplete : function(data){

		   	    // Row Color Change Event
				var selarrrow = (''+$("#classManageCopyDataList").jqGrid("getDataIDs")).split(',');
				var value = "";

				$(selarrrow).each(function(i){
					value = $("#classManageCopyDataList").getCell(selarrrow[0], 'TBL_NM');
				});

				if(value != '') {
					$('#execute2_2').show();
					$('#execute2_3').show();
					classManageSyncData();
				}
		   	},
		   	rowNum:100,
		   	rowList: [100, 500, 1000],
		   	pager: '#classManageCopyDataPager',
			pagerpos:'center',
			pgbuttons : true,
		   	sortname: 'date',
		    viewrecords: true,
		    sortorder: "desc",
		    id: 'ITEM',
		    jsonReader:{
				repeatitems:false,
				page: function (obj) { return obj.page; },
		        total: function (obj) { return obj.total; },
		        records: function (obj) { return obj.ITEM.length; },
		        root: function (obj) { return obj.ITEM; }
			},
		    caption:"※ 이관테이블조회",
		    //multiselect: true,
	    	rownumbers: true,
	    	height: 160,
	    	hidegrid: false,
	    	cmTemplate:{sortable:false},
	    	onCellSelect : function(rowid, index, contents, event){

				var selarrrow = (''+$("#classManageCopyDataList").jqGrid("getDataIDs")).split(',');

				$(selarrrow).each(function(i){
					$("#classManageCopyDataList").setRowData(i+1, false, {     background: "#FFF" });
				});
				$("#classManageCopyDataList").setRowData(rowid, false, {     background: "#D6F0FF" });
			}
		});
	}

	// 출결시스템 관련 데이터 생성 테이블 조회
	function classManageSyncData() {

		resetGridTableArea("classManageSyncDataList" , "tableArea5", "classManageSyncDataPager");

		var url = "/muniv/class_manage/class_manage_sync_data_list?searchValue=";

		$("#classManageSyncDataList").jqGrid({
		   	url:url,
			datatype: "json",
			mtype : 'post',
			width : 477,
			shrinkToFit : true,
			colNames:[
						  '대상명'
						, '대상테이블정보'
						, '데이터수'
					 ],
		   	colModel:[
						{name:'TBL_NM', width:75, align:"center"},
						{name:'TBL', width:130, align:"center"},
						{name:'CNT', width:75, align:"center"}
				     ],
		   	rowNum:100,
		   	rowList: [100, 500, 1000],
		   	pager: '#classManageSyncDataPager',
			pagerpos:'center',
			pgbuttons : true,
		   	sortname: 'date',
		    viewrecords: true,
		    sortorder: "desc",
		    id: 'ITEM',
		    jsonReader:{
				repeatitems:false,
				page: function (obj) { return obj.page; },
		        total: function (obj) { return obj.total; },
		        records: function (obj) { return obj.ITEM.length; },
		        root: function (obj) { return obj.ITEM; }
			},
		    caption:"※ 출결시스템데이터조회",
		    //multiselect: true,
	    	rownumbers: true,
	    	height: 160,
	    	hidegrid: false,
	    	cmTemplate:{sortable:false},
	    	onCellSelect : function(rowid, index, contents, event){

				var selarrrow = (''+$("#classManageSyncDataList").jqGrid("getDataIDs")).split(',');

				$(selarrrow).each(function(i){
					$("#classManageSyncDataList").setRowData(i+1, false, {     background: "#FFF" });
				});
				$("#classManageSyncDataList").setRowData(rowid, false, {     background: "#D6F0FF" });
			}
		});
	}

	// 출결시스템 생성 데이터 검증(이상데이터 확인)
	function classManageCheckedData(checkedData_param) {

		resetGridTableArea("classManageCheckedDataList" , "tableArea6", "classManageCheckedDataPager");

		var url = "/muniv/class_manage/class_manage_checked_data_list?searchValue=" + checkedData_param;

		$("#classManageCheckedDataList").jqGrid({
		   	url:url,
			datatype: "json",
			mtype : 'post',
			width : 960,
			shrinkToFit : true,
			colNames:[
						  '연도'
						, '학기명'
						, '과목코드'
						, '분반'
						, '과목명'
						, '교번'
						, '이름'
						, '강의수'
					 ],
		   	colModel:[
						  {name:'YEAR', width:50, align:"center"}
						, {name:'TERM_NAME', width:70, align:"center"}
						, {name:'SUBJECT_CD', width:80, align:"center"}
						, {name:'SUBJECT_DIV_CD', width:80, align:"center"}
						, {name:'CLASS_NAME', width:110, align:"center"}
						, {name:'PROF_NO', width:70, align:"center"}
						, {name:'PROF_NAME', width:70, align:"center"}
						, {name:'CNT', width:40, align:"center"}
				     ],
		   	rowNum:100,
		   	rowList: [100, 500, 1000],
		   	pager: '#classManageCheckedDataPager',
			pagerpos:'center',
			pgbuttons : true,
		   	sortname: 'date',
		    viewrecords: true,
		    sortorder: "desc",
		    id: 'ITEM',
		    jsonReader:{
				repeatitems:false,
				page: function (obj) { return obj.page; },
		        total: function (obj) { return obj.total; },
		        records: function (obj) { return obj.ITEM.length; },
		        root: function (obj) { return obj.ITEM; }
			},
		    caption:"※ 이상강의조회",
		    //multiselect: true,
	    	rownumbers: true,
	    	height: 160,
	    	hidegrid: false,
	    	cmTemplate:{sortable:false},
	    	onCellSelect : function(rowid, index, contents, event){

				var selarrrow = (''+$("#classManageCheckedDataList").jqGrid("getDataIDs")).split(',');

				$(selarrrow).each(function(i){
					$("#classManageCheckedDataList").setRowData(i+1, false, {     background: "#FFF" });
				});
				$("#classManageCheckedDataList").setRowData(rowid, false, {     background: "#D6F0FF" });
			}
		});
	}

	// 출결시스템 생성 데이터 검증(이상데이터 확인)
	function classManageCloseCheck(tmpParam) {

		// 교수 마감현황 조회
		resetGridTableArea("classManageProfList" , "tableArea7", "classManageProfPager");
		var url = "/muniv/class_manage/class_manage_close_check_prof_list?searchValue=";

		var tmpWidth = tmpParam != "" ? tmpParam : 477;

		$('#execute4_2').attr('style', 'float: right;');

		$("#classManageProfList").jqGrid({
		   	url:url,
			datatype: "json",
			mtype : 'post',
			width : tmpWidth,
			shrinkToFit : true,
			colNames:[
						  '전체'
						, '정상'
						, '마감'
					 ],
		 	colModel:[
		 				  {name:'ADM_TOTAL', width:150, align:"center"}
						, {name:'ADM_1', width:150, align:"center"}
						, {name:'ADM_2', width:150, align:"center"}
				     ],
		   	rowNum:100,
		   	rowList: [100, 500, 1000],
		   	pager: '#classManageProfPager',
			pagerpos:'center',
			pgbuttons : true,
		   	sortname: 'date',
		    viewrecords: true,
		    sortorder: "desc",
		    id: 'ITEM',
		    jsonReader:{
				repeatitems:false,
				page: function (obj) { return obj.page; },
		        total: function (obj) { return obj.total; },
		        records: function (obj) { return obj.ITEM.length; },
		        root: function (obj) { return obj.ITEM; }
			},
		    caption:"※ 교수마감상태조회",
		    //multiselect: true,
	    	rownumbers: true,
	    	height: 160,
	    	hidegrid: false,
	    	cmTemplate:{sortable:false},
	    	onCellSelect : function(rowid, index, contents, event){

				var selarrrow = (''+$("#classManageProfList").jqGrid("getDataIDs")).split(',');

				$(selarrrow).each(function(i){
					$("#classManageProfList").setRowData(i+1, false, {     background: "#FFF" });
				});
				$("#classManageProfList").setRowData(rowid, false, {     background: "#D6F0FF" });
			}
		});

		// 강의 마감현황 조회
		resetGridTableArea("classManageClassDataList" , "tableArea8", "classManageClassDataPager");
		var url2 = "/muniv/class_manage/class_manage_close_check_class_list?searchValue=";

		$('#execute4_3').attr('style', 'float: left;');

		$("#classManageClassDataList").jqGrid({
		   	url:url2,
			datatype: "json",
			mtype : 'post',
			width : tmpWidth,
			shrinkToFit : true,
			colNames:[
						  '연도'
						, '학기코드'
						, '학기명'
						, '전체'
						, '정상'
						, '마감'
					 ],
		   	colModel:[
						  {name:'YEAR', width:70, align:"center"}
						, {name:'TERM_CD', width:10, align:"center", hidden:true}
						, {name:'TERM_NM', width:70, align:"center"}
						, {name:'CLASS_ADM_TOTAL', width:70, align:"center"}
						, {name:'CLASS_ADM_1', width:70, align:"center"}
						, {name:'CLASS_ADM_2', width:70, align:"center"}
				     ],
		   	rowNum:100,
		   	rowList: [100, 500, 1000],
		   	pager: '#classManageClassDataPager',
			pagerpos:'center',
			pgbuttons : true,
		   	sortname: 'date',
		    viewrecords: true,
		    sortorder: "desc",
		    id: 'ITEM',
		    jsonReader:{
				repeatitems:false,
				page: function (obj) { return obj.page; },
		        total: function (obj) { return obj.total; },
		        records: function (obj) { return obj.ITEM.length; },
		        root: function (obj) { return obj.ITEM; }
			},
		    caption:"※ 강의마감상태조회",
		    //multiselect: true,
	    	rownumbers: true,
	    	height: 160,
	    	hidegrid: false,
	    	cmTemplate:{sortable:false},
	    	onCellSelect : function(rowid, index, contents, event){

				var selarrrow = (''+$("#classManageClassDataList").jqGrid("getDataIDs")).split(',');

				$(selarrrow).each(function(i){
					$("#classManageClassDataList").setRowData(i+1, false, {     background: "#FFF" });
				});
				$("#classManageClassDataList").setRowData(rowid, false, {     background: "#D6F0FF" });
			}
		});
	}

	// 학교뷰 데이터 검증
	function classManageTargetViewChk() {

		resetGridTableArea("classManageTargetViewChkList" , "tableArea9", "classManageTargetViewChkPager");
		resetGridTableArea("classManageTargetViewSelectList" , "tableArea10", "classManageTargetViewSelectPager");

		var url = "/muniv/class_manage/class_manage_target_view_chk_list?searchValue=";

		$("#classManageTargetViewChkList").jqGrid({
		   	url:url,
			datatype: "json",
			mtype : 'post',
			width : 960,
			shrinkToFit : true,
			colNames:[
						  '연도'
						, '학기코드'
						, '학기명'
						, '대상명'
						, '대상뷰정보'
						, '이상 데이터수'
					 ],
		   	colModel:[
						{name:'YEAR', width:50, align:"center"},
				   		{name:'TERM_CD', width:10, zalign:"center", hidden:true},
						{name:'TERM_NM', width:70, align:"center"},
						{name:'TBL_NM', width:110, align:"center"},
						{name:'TBL', width:110, align:"center"},
						{name:'CNT', width:110, align:"center"}
				     ],
		   	loadComplete : function(data){

		   	},
		   	rowNum:100,
		   	rowList: [100, 500, 1000],
		   	pager: '#classManageTargetViewChkPager',
			pagerpos:'center',
			pgbuttons : true,
		   	sortname: 'date',
		    viewrecords: true,
		    sortorder: "desc",
		    id: 'ITEM',
		    jsonReader:{
				repeatitems:false,
				page: function (obj) { return obj.page; },
		        total: function (obj) { return obj.total; },
		        records: function (obj) { return obj.ITEM.length; },
		        root: function (obj) { return obj.ITEM; }
			},
		    caption:"※ 학교뷰데이터조회(이상데이터확인)",
		    //multiselect: true,
	    	rownumbers: true,
	    	height: 160,
	    	hidegrid: false,
	    	cmTemplate:{sortable:false},
	    	onCellSelect : function(rowid, index, contents, event){

				var selarrrow = (''+$("#classManageTargetViewChkList").jqGrid("getDataIDs")).split(',');

				$(selarrrow).each(function(i){
					$("#classManageTargetViewChkList").setRowData(i+1, false, {     background: "#FFF" });
				});
				$("#classManageTargetViewChkList").setRowData(rowid, false, {     background: "#D6F0FF" });

				var year = $(this).jqGrid("getRowData", rowid).YEAR;
				var term_cd = $(this).jqGrid("getRowData", rowid).TERM_CD;
				var tbl = $(this).jqGrid("getRowData", rowid).TBL;

				classManageTargetViewSelect(year, term_cd, tbl);
			}
		});
	}


	// 학교뷰 데이터 검증(선택 데이터 조회)
	function classManageTargetViewSelect(year, term_cd, tbl) {

		resetGridTableArea("classManageTargetViewSelectList" , "tableArea10", "classManageTargetViewSelectPager");

		var url = "/muniv/class_manage/class_manage_target_view_select_list?tbl=" + tbl;

		var arrTitle = [];
		var arrColumn = [];
		if(tbl == "V_UNIV_VW_CLASSROOM"){
			arrTitle = [
						  	  '연도'
							, '학기코드'
							, '학기명'
							, '강의실번호'
							, '강의실명'
					   ];
			arrColumn = [
							{name:'YEAR', width:50, align:"center"},
					   		{name:'TERM_CD', width:10, zalign:"center", hidden:true},
							{name:'TERM_NM', width:110, align:"center"},
							{name:'CLASSROOM_NO', width:110, align:"center"},
							{name:'CLASSROOM_NAME', width:110, align:"center"}
					   ];
		} else if(tbl == "V_UNIV_VW_CLASS"){
			arrTitle = [
						  	  '연도'
							, '학기코드'
							, '학기명'
							, '과목코드'
							, '분반'
							, '강의명'
							, '교수번호'
							, '교수명'
							, '시작시간'
							, '종료시간'
							, '강의실번호'
					   ];
			arrColumn = [
							{name:'YEAR', width:50, align:"center"},
					   		{name:'TERM_CD', width:10, zalign:"center", hidden:true},
							{name:'TERM_NM', width:110, align:"center"},
							{name:'SUBJECT_CD', width:110, align:"center"},
							{name:'SUBJECT_DIV_CD', width:110, align:"center"},
							{name:'CLASS_NAME', width:160, align:"center"},
							{name:'PROF_NO', width:110, align:"center"},
							{name:'PROF_NAME', width:110, align:"center"},
							{name:'CLASSHOUR_START_TIME', width:110, align:"center"},
							{name:'CLASSHOUR_END_TIME', width:110, align:"center"},
							{name:'CLASSROOM_NO', width:110, align:"center"}
					   ];
		} else if(tbl == "V_UNIV_VW_SUBJECT"){
			arrTitle = [
						  	  '연도'
							, '학기코드'
							, '학기명'
							, '과목코드'
							, '분반'
					   ];
			arrColumn = [
							{name:'YEAR', width:50, align:"center"},
					   		{name:'TERM_CD', width:10, zalign:"center", hidden:true},
							{name:'TERM_NM', width:110, align:"center"},
							{name:'SUBJECT_CD', width:110, align:"center"},
							{name:'SUBJECT_DIV_CD', width:110, align:"center"}
					   ];
		} else if(tbl == "V_UNIV_VW_COLL"){
			arrTitle = [
						  	  '연도'
							, '학기코드'
							, '학기명'
							, '단과코드'
							, '단과명'
					   ];
			arrColumn = [
							{name:'YEAR', width:50, align:"center"},
					   		{name:'TERM_CD', width:10, zalign:"center", hidden:true},
							{name:'TERM_NM', width:110, align:"center"},
							{name:'COLL_CD', width:110, align:"center"},
							{name:'COLL_NAME', width:110, align:"center"}
					   ];
		} else if(tbl == "V_UNIV_VW_ATTENDEE"){
			arrTitle = [
						  	  '연도'
							, '학기코드'
							, '학기명'
							, '과목코드'
							, '분반'
							, '학번'
					   ];
			arrColumn = [
							{name:'YEAR', width:50, align:"center"},
					   		{name:'TERM_CD', width:10, zalign:"center", hidden:true},
							{name:'TERM_NM', width:110, align:"center"},
							{name:'SUBJECT_CD', width:110, align:"center"},
							{name:'SUBJECT_DIV_CD', width:110, align:"center"},
							{name:'STUDENT_NO', width:110, align:"center"}
					   ];
		} else if(tbl == "V_UNIV_VW_CLASSHOUR"){
			arrTitle = [
						  	  '연도'
							, '학기코드'
							, '학기명'
							, '교시코드'
							, '교시'
							, '시작시간'
							, '종료시간'
					   ];
			arrColumn = [
							{name:'YEAR', width:50, align:"center"},
					   		{name:'TERM_CD', width:10, zalign:"center", hidden:true},
							{name:'TERM_NM', width:110, align:"center"},
							{name:'CLASSHOUR', width:110, align:"center"},
							{name:'CLASSHOUR_NAME', width:110, align:"center"},
							{name:'CLASSHOUR_START_TIME', width:110, align:"center"},
							{name:'CLASSHOUR_END_TIME', width:110, align:"center"}
					   ];
		} else if(tbl == "V_UNIV_VW_DEPT"){
			arrTitle = [
						  	  '연도'
							, '학기코드'
							, '학기명'
							, '단과코드'
							, '학과코드'
							, '학과명'
					   ];
			arrColumn = [
							{name:'YEAR', width:50, align:"center"},
					   		{name:'TERM_CD', width:10, zalign:"center", hidden:true},
							{name:'TERM_NM', width:110, align:"center"},
							{name:'COLL_CD', width:110, align:"center"},
							{name:'DEPT_CD', width:110, align:"center"},
							{name:'DEPT_NAME', width:140, align:"center"}
					   ];
		}

		$("#classManageTargetViewSelectList").jqGrid({
		   	url:url,
			datatype: "json",
			mtype : 'post',
			width : 960,
			shrinkToFit : false,
			colNames: arrTitle,
		   	colModel: arrColumn,
		   	loadComplete : function(data){

		   	},
		   	rowNum:100,
		   	rowList: [100, 500, 1000],
		   	pager: '#classManageTargetViewSelectPager',
			pagerpos:'center',
			pgbuttons : true,
		   	sortname: 'date',
		    viewrecords: true,
		    sortorder: "desc",
		    id: 'ITEM',
		    jsonReader:{
				repeatitems:false,
				page: function (obj) { return obj.page; },
		        total: function (obj) { return obj.total; },
		        records: function (obj) { return obj.ITEM.length; },
		        root: function (obj) { return obj.ITEM; }
			},
		    caption:"※ 이상데이터 상세확인",
		    //multiselect: true,
	    	rownumbers: true,
	    	height: 160,
	    	hidegrid: false,
	    	cmTemplate:{sortable:false},
	    	onCellSelect : function(rowid, index, contents, event){

				var selarrrow = (''+$("#classManageTargetViewSelectList").jqGrid("getDataIDs")).split(',');

				$(selarrrow).each(function(i){
					$("#classManageTargetViewSelectList").setRowData(i+1, false, {     background: "#FFF" });
				});
				$("#classManageTargetViewSelectList").setRowData(rowid, false, {     background: "#D6F0FF" });
			}
		});
	}

	// ========================================================================
	// 학기마감관련
	// ========================================================================

	function executeCloseDataChange(param1, param2, obj, tmpParam) {

		// 강의마감시 그리드 선택 필수
		var year = "";
		var term_cd = "";

		if(param1 == "class") {

			var id = $("#classManageClassDataList").getGridParam("selrow");
			var row = $("#classManageClassDataList").getRowData(id);

			if(id == null) {
				alert("마감 및 해제 대상 강의년도를 선택 해 주세요.");
				return;
			}

			year = row.YEAR;
			term_cd = row.TERM_CD;
		}

		if(confirm($(obj).text() + "을(를) 실행 하시겠습니까?")) {

			$.ajax({
				type: "POST",
				url: "/muniv/class_manage/executeCloseDataChange",
				data : {
					   	    type1 : param1
					   	  , type2 : param2
					   	  , year : year
					   	  , term_cd : term_cd
					   },
				success: function(msg) {
					//통신이 완료된 후 처리
					$('.spinner_layer').fadeOut('fast', function(){

						alert("작업이 완료 되었습니다.");

						if(tmpParam != "") {
							fn_search('class_manage_close_check_2');
						} else {
							fn_search('class_manage_close_check');
						}

					});
				},
				beforeSend: function() {
					//통신을 시작할때 처리
					$('.spinner_layer').show().fadeIn('fast');
				},
				error: function(msg){ // 예상치 못한 에러

					$('.spinner_layer').fadeOut('fast', function(){
						alert(msg);
					});
				}
			});
		}
	}

	// 학기마감관련 대상 조회
	function termEndManage(value) {

		gridLoading = true;
		resetGridTableArea("standTermEndList" , "tableArea", "standTermEndPager");

		var va = "";
		va = encodingValue(value);

		var url = "/muniv/stand/term_end_manage_list?searchValue="+va;

		$("#standTermEndList").jqGrid({
		   	url:url,
			datatype: "json",
			mtype : 'post',
			autowidth : true,
			shrinkToFit : true,
			colNames:['교번', '이름','총강의','완료강의','결강수','미처리강의'],
		   	colModel:[
				{name:'PROF_NO', width:70},
				{name:'PROF_NAME', width:70, align:"center"},
				{name:'TOT_CNT', width:70, align:"left"},
				{name:'PROC_CNT', width:70, align:"left"},
				{name:'NOT_PROC_CNT', width:70, align:"left"},
				{name:'UN_CHK_ATTENDDATA', width:70, align:"center"},

		   	],loadComplete : function(data){
		   		$('#execute_1').attr('style', 'float: left;');
		   		$('#execute_1').show();
		   		$('#execute_2').show();
		   	},
		   	rowNum:100,
		   	rowList: [100, 500, 1000],
		   	pager: '#standTermEndPager',
			pagerpos:'center',
			pgbuttons : true,
		   	sortname: 'date',
		    viewrecords: true,
		    sortorder: "desc",
		    id: 'ITEM',
		    jsonReader:{
				repeatitems:false,
				page: function (obj) { return obj.page; },
		        total: function (obj) { return obj.total; },
		        records: function (obj) { return obj.ITEM.length; },
		        root: function (obj) { return obj.ITEM; }
			},
		    caption:"※ 학기마감관련",
		    //multiselect: true,
	    	rownumbers: true,
	    	height: 150,
	    	hidegrid: false,
	    	cmTemplate:{sortable:false},
	    	onCellSelect : function(rowid, index, contents, event){
				var selarrrow = (''+$("#standTermEndList").jqGrid("getDataIDs")).split(',');

				$(selarrrow).each(function(i){
					$("#standTermEndList").setRowData(i+1, false, {     background: "#FFF" });
				});
				$("#standTermEndList").setRowData(rowid, false, {     background: "#D6F0FF" });
	        },
			gridComplete:function() {
				$('.spinner_layer').fadeOut('fast');
				gridLoading = false;
			}
		});
	}


















