class MachinesController < ApplicationController
  def index
    machines = Machine.all
    @machines = machines[:machines]
    @totals= machines[:totals]
  end

  def show
    @machine = Machine.find params[:id]
    raise if @machine.nil?
  end

  %w(start pause resume stop force_stop restart force_restart).each do |operation|
    define_method operation do
      @machine = Machine.find params[:id]
      @machine.send operation
      redirect_to machine_path(@machine)
    end
  end
end
