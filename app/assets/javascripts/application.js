//= require jquery
//= require jquery_ujs
//= require vendor/jquery.ajaxchimp-1.3.0.js
//= require bootstrap
//= require twitter/bootstrap/rails/confirm


$(function() {
  $('.newsletter form').ajaxChimp({
    callback: function(response, element) {
      resultElement = $('.newsletter .result');

      if (response.result == 'error') {
        resultElement.text(response.msg);
      } else {
        resultElement.text(resultElement.data('success'));
        ga('send', 'event', 'newsletter_proto', 'subscribe');
      }
    }
  });
});
