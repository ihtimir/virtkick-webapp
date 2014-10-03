Delayed::Worker.destroy_failed_jobs = Rails.env.development?
Delayed::Worker.sleep_delay = 0.5
Delayed::Worker.max_attempts = 1
