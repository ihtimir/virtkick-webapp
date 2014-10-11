//= require jquery
//= require jquery_ujs
//= require vendor/jquery.ajaxchimp-1.3.0.js
//= require bootstrap
//= require twitter/bootstrap/rails/confirm
//= require novnc
//= require_tree ./pages

$(function() {
  $('.newsletter form').ajaxChimp({
    callback: function(response, element) {
      resultElement = $('.newsletter .result');

      if (response.result == 'error') {
        if (response.msg.indexOf('is already subscribed') != -1) {
          resultElement.text("Nothing to do. You're already subscribed!");
        } else {
          resultElement.text(response.msg);
        }
      } else {
        resultElement.text(resultElement.data('success'));
        ga('send', 'event', 'newsletter_alpha', 'subscribe');
      }
    }
  });
});

window.handleProgress = function(progressId, onSuccess, onError) {
  var id = setInterval(function() {
    return $.ajax('/progress/' + progressId).success(function(data) {
      if (!data.finished) {
        return;
      }
      clearInterval(id);

      data.error === null ? onSuccess() : onError(data.error);
    });
  }, 500);
};
