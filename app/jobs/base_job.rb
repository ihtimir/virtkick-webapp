# Bring ActiveJob syntax to native Delayed Job class.
# Overcome the limitations of ActiveJob while retaining its API.
class BaseJob
  include Bugsnagable

  def self.perform_later *args
    if Rails.configuration.active_job.queue_adapter == :inline
      self.new.perform *args
    else
      self.new.delay.perform *args
    end
  end

  def self.set_max_attempts attempts, reschedule_interval = nil
    def self.max_attempts
      attempts
    end

    set_reschedule_interval reschedule_interval if reschedule_interval
  end

  def self.set_reschedule_interval interval
    def self.reschedule_at current_time, attempts
      current_time + interval
    end
  end

  def self.run_once
    self.set_max_attempts 1
  end
end
