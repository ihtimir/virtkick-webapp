class GuestsController < ApplicationController
  layout 'raw'

  before_action do
    redirect_to machines_path if user_signed_in?
  end


  def index
  end

  def create
    email = "guest_#{SecureRandom.uuid}@alpha.virtkick.io"
    user = User.new email: email
    user.save validate: false
    sign_in user
    redirect_to machines_path
  end
end
