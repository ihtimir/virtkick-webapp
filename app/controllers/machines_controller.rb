class MachinesController < ApplicationController
  def index
    @machines = Machine.all.sort_by &:name

    memory = @machines.map(&:memory).inject(0, &:+).megabytes
    storage = @machines.map(&:storage).flatten.map(&:capacity).inject(0, &:+)

    @sum = {
      memory: memory > 0 ? memory : 'N/A',
      storage: storage > 0 ? storage : 'N/A',
    }
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
