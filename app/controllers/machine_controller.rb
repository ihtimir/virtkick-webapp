class MachineController < ApplicationController
  def index
    @machines = Machine.all.sort_by &:name

    memory = @machines.map(&:memory).inject(0, &:+).megabytes
    storage = @machines.map(&:storage).flatten.map(&:capacity).inject(0, &:+)

    @sum = {
      memory: memory > 0 ? memory : 'N/A',
      storage: storage > 0 ? storage : 'N/A',
    }
  end
end
