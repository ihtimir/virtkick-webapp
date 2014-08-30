require 'active_resource'

class ApiBase < ActiveResource::Base
  self.site = Rails.configuration.x.api_url
end
