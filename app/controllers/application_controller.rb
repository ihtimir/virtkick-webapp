class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def handle_errors category = nil, redirect_method = nil
    yield
  rescue Errors => e
    if category
      flash[category] = {error: e.errors.dup}
    else
      flash[:error] = e.errors.dup
    end
  ensure
    send redirect_method if redirect_method
  end
end
