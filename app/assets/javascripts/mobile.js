'use strict'
function mobileMenuOpen() {
  $(".mob-menu").addClass("mob-menu_visible")
}

function mobileMenuClose() {
  $(".mob-menu").removeClass("mob-menu_visible")
}

function mobOtherFiltersToggle(){
  const mobOtherFilters = $('.mob-filter__others')
  const btn = $('.mob-filter__btn')
  if($(mobOtherFilters[0]).hasClass('mob-filter__others_hide')){
    mobOtherFilters.removeClass("mob-filter__others_hide")
    $(btn).text("Скрыть остальные фильтры");
  } else {
    mobOtherFilters.addClass("mob-filter__others_hide")
    btn.text("Показать остальные фильтры");
  }
}