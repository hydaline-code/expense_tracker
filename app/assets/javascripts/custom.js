document.addEventListener("DOMContentLoaded", function() {
  const hamburgerBtn = document.getElementById("hamburger-btn");
  const menuList = document.getElementById("menu-list");

  hamburgerBtn.addEventListener("click", function() {
    menuList.classList.toggle("hidden");
  });
});
