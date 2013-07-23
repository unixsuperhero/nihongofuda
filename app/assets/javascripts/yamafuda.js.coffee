# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:change', ->
  show_scroll_loading = false
  $(document).on 'scroll', ->
    return if $('.show_link').length == 0
    return if show_scroll_loading == true
    return if (window.scrollY + window.innerHeight) / document.body.scrollHeight < 0.8

    show_scroll_loading = true
    $.get [$('.show_link').text(), '?page=', parseInt($('.show_page').text()) + 1].join(''), (data) ->
      return if data.replace(/^\s*/, '').replace(/\s*$/, '').length == 0

      show_scroll_loading = false
      $('.show_page').text parseInt($('.show_page').text()) + 1
      $('.main_container').append data

