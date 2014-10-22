define(function(require) {
  var $ = require('jquery');

  var handleProgress = require('./handleProgress');

  // ISO image change (Console & Settings Tabs)

  $('.iso_dropdown').change(function() {
    var form = $(this).closest('form');
    form.submit();
    var spinner = form.find('.fa-spinner');
    spinner.removeClass('hidden');
    form.on('ajax:success', function(e, data) {
      handleProgress(data.progress_id, function() {
        spinner.addClass('hidden');

        var tick = form.find('.fa-check');
        tick.removeClass('hidden');
        setTimeout(function() {
          tick.fadeOut('slow', function() {
            tick.addClass('hidden');
            tick.show();
          });
        }, 500);

      }, function(error) {
        spinner.addClass('hidden');
        form.find('fa-warning').removeClass('hidden');
      })
    })
  });

  // Power Tab

  var actions = {
    'start': ['Starting', 'icon fa fa-spinner fa-spin'],
    'pause': ['Paused', 'icon fa fa-pause'],
    'resume': ['Running', 'icon fa fa-play'],
    'stop': ['Stopping', 'icon fa fa-spinner fa-spin'],
    'restart': ['Restart requested', 'icon fa fa-play'],
    'hard-stop': ['Hard stopping', 'icon fa fa-spinner fa-spin'],
    'hard-reset': ['Resetting', 'icon fa fa-spinner fa-spin']
  };

  var $powerState = $('.power-state');

  var reloadButtonState = function() {
    var state = $powerState.text().trim();
    if (state === 'Running') {
      $('.only-on').removeClass('disabled');
      $('.start, .resume').addClass('disabled');
    } else if (state == 'Paused') {
      $('.only-on, .start').addClass('disabled');
      $('.start').addClass('disabled');
      $('.resume').removeClass('disabled');
    } else {
      $('.only-on').addClass('disabled');
      $('.start').removeClass('disabled');
    }
  };

  reloadButtonState();

  $('.controls a.action').click(function () {
    var $this = $(this);
    var action = $this.text().toLowerCase().trim();
    var actionUrl = $this.attr('href');

    var tempState = actions[action][0];
    var tempClasses = actions[action][1];

    var $powerState = $('.power-state');
    var $icon = $powerState.find('.icon');
    var $status = $powerState.find('.status');

    $icon.attr('class', tempClasses);
    $status.text(tempState);

    reloadButtonState();

    var handleProgress = require('pages/handleProgress');

    var getCurrentState = function() {
      $.ajax(window.location.pathname + '/state').success(function(data) {
        $icon.attr('class', 'icon ' + data.icon);
        $status.text(data.name);
        $powerState.data('running', data.running);
        reloadButtonState();
      });
    };

    $.post(actionUrl).success(function(data) {
      handleProgress(data.progress_id, function() {
        getCurrentState();
      }, function(error) {
        var alert = '<div class="alert alert-danger fade in">' +
          '<button class="close" data-dismiss="alert">×</button>' +
          error +
          '</div>';
        $('.controls').prepend($(alert));
        getCurrentState();
      });
    });

    return false;
  });
});
