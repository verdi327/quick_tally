$(document).ready ->
  $(".container").on "click", ".close", ->
    $(this).parent().remove();

  setActiveNavLink = ->
    url = window.location.pathname
    if /filter_movies/.test(url)
      $("#nav-theater").removeClass("active")
      $("#nav-search").addClass("active")

  setActiveNavLink()

