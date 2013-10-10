$(function(){	
	$.easy.navigation();
	$.easy.tooltip();
	$.easy.popup({
		closeText: 'x',
	});
	$("a.largePopup").click(function () {
		$('#easy_popup_close').addClass('large');
	});
	$.easy.external();
	$.easy.rotate();
	$.easy.cycle();
	$.easy.forms();
	$.easy.showhide();
	$.easy.jump();
	$.easy.tabs();
	$.easy.accordion();	
});