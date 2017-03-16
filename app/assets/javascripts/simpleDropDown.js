function openMobileCatalog() {
  document.getElementById("mob-header__catalog-content").classList.toggle("mob-header__catalog_show");
}


window.onclick = function(event) {
  if (!event.target.matches('.mob-header__catalog-btn')) {
    var dropdowns = document.getElementsByClassName("mob-header__catalog-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('mob-header__catalog_show')) {
        openDropdown.classList.remove('mob-header__catalog_show');
      }
    }
  }
}