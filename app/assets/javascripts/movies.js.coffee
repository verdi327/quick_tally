$(document).ready ->
  $(".movie").on "click", ->
    id = $(this).data("id")
    window.location = "/movies/" + id
    false

  $("#positive").on "click", ->
    $("#neutral").removeClass("btn-warning selected")
    $("#negative").removeClass("btn-danger selected")
    if $(this).hasClass("selected")
      $(this).removeClass("btn-success selected")
      $("#submit-vote").addClass("disabled")
    else
      $(this).addClass("btn-success selected")
      $("#submit-vote").removeClass("disabled")
      $("#viewer-vote").val("See At Theater")
    false

  $("#neutral").on "click", ->
    $("#positive").removeClass("btn-success selected")
    $("#negative").removeClass("btn-danger selected")
    if $(this).hasClass("selected")
      $(this).removeClass("btn-warning selected")
      $("#submit-vote").addClass("disabled")
    else
      $(this).addClass("btn-warning selected")
      $("#submit-vote").removeClass("disabled")
      $("#viewer-vote").val("Wait For NetFlix")
    false

  $("#negative").on "click", ->
    $("#positive").removeClass("btn-success selected")
    $("#neutral").removeClass("btn-warning selected")
    if $(this).hasClass("selected")
      $(this).removeClass("btn-danger selected")
      $("#submit-vote").addClass("disabled")
    else
      $(this).addClass("btn-danger selected")
      $("#submit-vote").removeClass("disabled")
      $("#viewer-vote").val("Don't Waste Your Time")
    false