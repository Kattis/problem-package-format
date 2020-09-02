function unified() {
	var divs = document.getElementsByClassName("markdown-body");
	for(var i = 0; i < divs.length; ++i) {
		divs[i].classList.remove('clics_view');
		divs[i].classList.remove('problemarchive_view');
		divs[i].classList.add('unified_view');
	}
}
function clics() {
	var divs = document.getElementsByClassName("markdown-body");
	for(var i = 0; i < divs.length; ++i) {
		divs[i].classList.remove('unified_view');
		divs[i].classList.remove('problemarchive_view');
		divs[i].classList.add('clics_view');
	}
}
function problemarchive() {
	var divs = document.getElementsByClassName("markdown-body");
	for(var i = 0; i < divs.length; ++i) {
		divs[i].classList.remove('unified_view');
		divs[i].classList.remove('clics_view');
		divs[i].classList.add('problemarchive_view');
	}
}
unified()
