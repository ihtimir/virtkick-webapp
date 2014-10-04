# https://doorbell.io - gather in-app feedback.
# App Key - take from the snippet hash key "appKey".
# App ID - take it from the project URL.

if ENV['DOORBELL_APP_KEY'] and ENV['DOORBELL_APP_ID']
  Rails.application.configure do
    config.x.doorbell.app_key = ENV['DOORBELL_APP_KEY']
    config.x.doorbell.app_id = ENV['DOORBELL_APP_ID']
  end
end
