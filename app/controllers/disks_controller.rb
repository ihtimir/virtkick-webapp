class DisksController < ApplicationController
  before_filter do
    @machine = Infra::Machine.find params[:machine_id]
  end


  def index
    redirect_to machine_path @machine, anchor: 'storage'
  end

  def show
    index
  end

  def create
    handle_errors :storage, :index do
      disk = params.require(:disk).permit(:size_plan, :type)
      @disk = Infra::Disk.new disk
      @machine.create_disk @disk
    end
  end

  def destroy
    handle_errors :storage, :index do
      disk = @machine.disks.find params[:id]
      @machine.delete_disk disk
    end
  end
end
