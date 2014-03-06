$(document).ready ->
  $(".container").on "click", ".close", ->
    $(this).parent().remove();

  setActiveNavLink = ->
    url = window.location.pathname
    if /filter_movies/.test(url)
      $("#nav-theater").removeClass("active")
      $("#nav-search").addClass("active")
    else if /movies/.test(url)
      $("#nav-search").removeClass("active")
    else
      $("#nav-theater").removeClass("active")

  setActiveNavLink()

