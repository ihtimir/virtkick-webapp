class MachineProgressController < ApplicationController
  before_action :authenticate_user!

  def progress
    new_machine = current_user.new_machines.find params[:id]
    render json: new_machine
  end
end
