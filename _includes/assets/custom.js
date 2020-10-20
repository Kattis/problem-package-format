function unified() {
	var divs = document.getElementsByClassName("markdown-body");
	for(var i = 0; i < divs.length; ++i) {
		divs[i].classList.remove('icpc_view');
		divs[i].classList.remove('kattis_view');
		divs[i].classList.add('unified_view');
	}
}
function icpc() {
	var divs = document.getElementsByClassName("markdown-body");
	for(var i = 0; i < divs.length; ++i) {
		divs[i].classList.remove('unified_view');
		divs[i].classList.remove('kattis_view');
		divs[i].classList.add('icpc_view');
	}
}
function kattis() {
	var divs = document.getElementsByClassName("markdown-body");
	for(var i = 0; i < divs.length; ++i) {
		divs[i].classList.remove('unified_view');
		divs[i].classList.remove('icpc_view');
		divs[i].classList.add('kattis_view');
	}
}
unified()
