require 'httparty'
require 'recursive_open_struct'

class Wvm::Base
  include ActiveModel::Model
  include ActiveModel::Validations

  include HTTParty
  base_uri 'http://0.0.0.0:8000/'


  def self.call method, url, **body
    params = {headers: {'Accept' => 'application/json'}}
    if method == :post
      params[:headers]['Content-Type'] = 'application/x-www-form-urlencoded'
      params[:body] = body
    end

    response = send method, "/1/#{url}", params

    errors = response['errors']
    if errors.size > 0
      raise Errors, errors
    end

    RecursiveOpenStruct.new(response['response'].to_hash, recurse_over_arrays: true)
  end
end
