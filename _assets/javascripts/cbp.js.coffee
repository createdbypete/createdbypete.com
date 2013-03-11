#= require vendor/jquery.isotope

$ ->
  $("#thegrid").isotope masonry:
    columnWidth: 190

  $("#filter a.category").click (e) ->
    e.preventDefault
    selector = $(this).attr("data-filter")
    $("#thegrid").isotope filter: selector