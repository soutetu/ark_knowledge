$(function() {
	$(".confirm").on("click", function(){
		if (confirm("ok?")) {
			return true;
		} else {
			return false;
		};
	});
});