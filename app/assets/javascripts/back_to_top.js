$(function() {
  $('#back a').on('click',function(){
    $('body, html').animate({
      scrollTop:0
    }, 500);
      return false;
  });
});