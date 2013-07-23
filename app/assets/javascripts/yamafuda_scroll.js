
$(document).on('ready page:change', function() {
  var show_scroll_loading = false;
  $(document).on('scroll', function() {
    if($('.show_link').length == 0) return;
    if(show_scroll_loading == true) return;
    if((window.scrollY + window.innerHeight) / document.body.scrollHeight < 0.8) return;

    show_scroll_loading = true;
    $.get([$('.show_link').text(), '?page=', parseInt($('.show_page').text()) + 1].join(''), function(data) {
      if(data.length == 0) return;

      show_scroll_loading = false;
      $('.show_page').text( parseInt($('.show_page').text()) + 1 );
      $('.main_container').append(data);
    });
  });
});

