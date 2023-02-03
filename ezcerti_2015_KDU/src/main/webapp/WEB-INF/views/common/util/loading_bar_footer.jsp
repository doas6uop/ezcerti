<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="spinner_layer" >
	<div id="foo"></div>
	<div class="layer"><p><b>잠시만 기다려 주십시요.</b></p></div>
</div>

<script type="text/javascript">

	var opts = {
					  lines: 12 // The number of lines to draw
					, length: 20 // The length of each line
					, width: 12 // The line thickness
					, radius: 46 // The radius of the inner circle
					, scale: 1 // Scales overall size of the spinner
					, corners: 1 // Corner roundness (0..1)
					, color: '#ff0' // #rgb or #rrggbb or array of colors
					, opacity: 0.25 // Opacity of the lines
					, rotate: 0 // The rotation offset
					, direction: 1 // 1: clockwise, -1: counterclockwise
					, speed: 1 // Rounds per second
					, trail: 60 // Afterglow percentage
					, fps: 20 // Frames per second when using setTimeout() as a fallback for CSS
					, zIndex: 2e9 // The z-index (defaults to 2000000000)
					, className: 'spinner' // The CSS class to assign to the spinner
					, top: '49%' // Top position relative to parent
					, left: '50%' // Left position relative to parent
					, shadow: false // Whether to render a shadow
					, hwaccel: false // Whether to use hardware acceleration
					, position: 'absolute' // Element positioning
				};

	var target = document.getElementById('foo');
	var spinner = new Spinner(opts).spin(target);

</script>
