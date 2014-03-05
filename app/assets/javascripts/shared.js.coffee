$(document).ready ->
  $(".container").on "click", ".close", ->
    $(this).parent().remove();