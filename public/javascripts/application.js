$(document).ready(function() {
  $("#content ol li img").hide();
  $("#content ol li.active img").fadeIn();
  
  $("#content ol li").hover(function() {
    $(this).addClass("active").find("img").fadeIn();
    $(this).siblings().removeClass("active").find("img").fadeOut();
  });
});