class DisksController < ApplicationController
  include FindMachine
  find_machine_before_action :machine_id


  def index
    redirect_to machine_path @machine, anchor: 'storage'
  end

  def show
    index
  end

  def create
    disk_params = params.require(:disk).permit(:size_plan, :type)
    DiskCreateJob.perform_later @meta_machine.id, disk_params
    index
  end

  def destroy
    DiskDeleteJob.perform_later @meta_machine.id, params[:id]
    index
  end
end
