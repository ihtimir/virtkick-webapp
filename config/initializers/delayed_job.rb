Delayed::Worker.destroy_failed_jobs = Rails.env.development?
Delayed::Worker.sleep_delay = 0.5
Delayed::Worker.max_attempts = 1

if Rails.configuration.active_job.queue_adapter == :inline
  Delayed::Worker.delay_jobs = false
end
