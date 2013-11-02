# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:change', ->
  window.reset_page_loader = ->
    window.autoload_next_page = true
  window.reset_page_loader()

  $(document).on 'scroll', ->
    return if $('.show_link').length == 0
    return if window.autoload_next_page == false
    return if (window.scrollY + window.innerHeight) / document.body.scrollHeight < 0.8

    window.autoload_next_page = false
    $.get [$('.show_link').text(), '?page=', parseInt($('.show_page').text()) + 1].join(''), (data) ->
      console.log(data)
      $('.show_page').text parseInt($('.show_page').text()) + 1
      $('.main_container').append data.content
      if(data.last_page != true)
        setTimeout(window.reset_page_loader, 1000)

