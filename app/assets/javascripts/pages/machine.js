$(function() {
  return $('.iso_dropdown').change(function() {
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
});
