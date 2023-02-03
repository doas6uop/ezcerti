	
	var openspeed = 100; // 레이어 펼침 속도
	var wrap_margin = 200; // 본문 좌측 여백
	var wrap_margin_return = 0; // 본문 원래 위치
	var category_margin = 0; // 레이어 펼침 위치
	var category_margin_return = -201; // 레이어 원래 위치
	var category_view_yn = false;

	$(document).ready(function() {	

		$('#category-open').click(function() {
			category_show();		
		});

		$('#category-close').click(function() {
			category_hide();
		});

		setInterval( layout_interval,1 );

		var cateist = $('div.cateist');
		var cateist_i = cateist.find('>ul>li');
		var cateist_ii = cateist.find('>ul>li>ul>li');
		cateist_i.find('>ul').hide();
		cateist.find('>ul>li>ul>li[class=active]').parents('li').attr('class','active');
		cateist.find('>ul>li[class=active]').find('>ul').show();
		function cateistToggle(event){
			var t = $(this);
			if (t.next('ul').is(':hidden')) {
				cateist_i.find('>ul').slideUp(100);
				t.next('ul').slideDown(100);
			} else if (t.next('ul').is(':visible')){
				t.next('ul').show();
			} else if (!t.next('ul').langth) {
				cateist_i.find('>ul').slideUp(100);
			}
			cateist_i.removeClass('active');
			t.parent('li').addClass('active');
			return false;
		}
		//cateist_i.find('>a[href=#]').click(cateistToggle).focus(cateistToggle);
		cateist_i.find('>a[href=#]').click(cateistToggle).focus(cateistToggle);
		function cateistActive(){
			cateist_ii.removeClass('active');
			$(this).parent(cateist_ii).addClass('active');
			return false;
		}; 
		//cateist_ii.find('>a[href=#]').click(cateistActive).focus(cateistActive);
		cateist_ii.find('>a[href=#]').click(cateistActive).focus(cateistActive);
		cateist.find('>ul>li>ul').prev('a').append('<span class="i"></span>');

		
	});

	function layout_interval() {
		$('.slidelm').height($(document).height());
	}

	function category_show() {
		$('.sviewer').show();
		//$('#wrap').animate({"margin-left":+wrap_margin+"px"},openspeed);
		$('.slidelm').animate({"left":+category_margin+"px"},openspeed);						
		category_view_yn = true;
	}

	function category_hide() {
		$('.sviewer').hide();
		//$('#wrap').animate({"margin-left":+wrap_margin_return+"px"},openspeed);
		$('.slidelm').animate({"left":+category_margin_return+"px"},openspeed);								
		category_view_yn = false;
	}
