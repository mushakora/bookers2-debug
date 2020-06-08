$(function() {
  $('#back a').on('click',function(){
    $('body, html').animate({
      scrollTop:0
    }, 500);
      return false;
  });
});

$(function(){
  $('#back a').mouseover(function(){
      $('#back a').addClass('back-btn');
  });

  $('#back a').mouseout(function(){
      $('#back a').removeClass('back-btn');
  });
});

$(function() {
 
  $('.menu-trigger').on('click', function() {
    $(this).toggleClass('active');
    $('#sp-menu').fadeToggle();
    return false;
  });
 
 });