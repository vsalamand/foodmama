const navbarPerso = document.getElementById('navbar-perso');

function debounce(func, wait, immediate) {
  var timeout;
  return function() {
    var context = this, args = arguments;
    var later = function() {
      timeout = null;
      if (!immediate) func.apply(context, args);
    };
    var callNow = immediate && !timeout;
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
    if (callNow) func.apply(context, args);
  };
};

function showHeader() {
  if (window.scrollY >= 71) {
    navbarPerso.classList.add("activ");
  } else {
    navbarPerso.classList.remove("activ");
  }
}
document.addEventListener("scroll", debounce(showHeader));

