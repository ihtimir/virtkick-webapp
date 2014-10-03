# Bring ActiveJob syntax to native Delayed Job class.
# Overcome the limitations of ActiveJob while retaining its API.
class BaseJob
  def self.perform_later *args
    if Rails.configuration.active_job.queue_adapter == :inline
      self.new.perform *args
    else
      self.new.delay.perform *args
    end
  end

  def error job, e
    puts e.message
    puts e.backtrace.map { |e| '    ' + e }.join "\n"
    Bugsnag.notify_or_ignore e
  end
end
