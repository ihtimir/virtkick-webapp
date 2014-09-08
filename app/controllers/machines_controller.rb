class MachinesController < ApplicationController
  def index
    @machines = Machine.all
  end

  def new
    @machine ||= Forms::NewMachine.new
    @plans ||= Defaults::MachinePlan.all
    @isos ||= Plans::IsoDistro.all
  end

  def create
    machine_params = Forms::NewMachine.check_params params
    @machine = Forms::NewMachine.new machine_params

    if @machine.save
      redirect_to @machine.machine
    else
      new
      render 'new'
    end
  end

  def show
    @machine = Machine.find params[:id]
    @disk_types = DiskType.all
    @disk = Disk.new
  end

  %w(start pause resume stop force_stop restart force_restart).each do |operation|
    define_method operation do
      @machine = Machine.find params[:id]
      begin
        @machine.send operation
      rescue Errors => e
        flash[:power] = {error: e.errors.dup}
      end
      redirect_to machine_path(@machine)
    end
  end
end
