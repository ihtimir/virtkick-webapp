# Bring ActiveJob syntax to native Delayed Job class.
# Overcome the limitations of ActiveJob while retaining its API.
class BaseRepeatableJob < BaseJob
  def max_attempts
    5
  end
end
