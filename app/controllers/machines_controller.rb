class MachinesController < ApplicationController
  def index
    @machines = Machine.all
  end

  def show
    @machine = Machine.find params[:id]
    raise if @machine.nil?
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
