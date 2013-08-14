#= require vendor/jquery.isotope
#= require vendor/jquery.ba-bbq

$ ->
  $("#thegrid").isotope masonry:
    columnWidth: 190

  $("#filter a.category").click (e) ->
    # $("#thegrid").isotope filter: selector
    # false

  $(window).bind "hashchange", (e) ->
    selector = $.param.fragment()
    if (selector != '')
      selector = '.'+selector
    $("#thegrid").isotope filter: selector

  $(window).trigger "hashchange"