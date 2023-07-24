function unified() {
  var divs = document.getElementsByClassName("not-icpc");
  for (var i = 0; i < divs.length; ++i) {
    divs[i].classList.remove("icpc_view");
    divs[i].classList.remove("full_view");
  }
}
function icpc() {
  var divs = document.getElementsByClassName("not-icpc");
  for (var i = 0; i < divs.length; ++i) {
    divs[i].classList.remove("full_view");
    divs[i].classList.add("icpc_view");
  }
}
function full() {
  var divs = document.getElementsByClassName("not-icpc");
  for (var i = 0; i < divs.length; ++i) {
    divs[i].classList.remove("icpc_view");
    divs[i].classList.add("full_view");
  }
}
