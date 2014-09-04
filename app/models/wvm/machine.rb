class Wvm::Machine < Wvm::Base
  def self.all
    response = call :get, 'instances'
    machines = build_all_instances response

    Elements.new machines
  end

  def self.find id
    response = call :get, "instance/#{id}"

    status = determine_status response

    Machine.new \
        hostname: response[:name],
        uuid: response[:uuid],
        memory: response[:cur_memory],
        processors: response[:vcpu],
        status: status,
        vnc_password: response[:vnc_password],
        disks: Wvm::Disk.array_of(response.disks)
  end

  OPERATIONS = {
      start: :start,
      pause: :suspend,
      resume: :resume,
      stop: :shutdown,
      force_stop: :destroy,
      restart: :restart
  }

  OPERATIONS.each do |operation_name, libvirt_name|
    define_singleton_method operation_name do |id|
      operation libvirt_name, id
    end
  end

  def self.force_restart id
    operation :destroy, id
    operation :start, id
  end

  def self.add_disk disk, machine
    disk.device = machine.disks.next_device_name
    Wvm::Disk.create disk, machine.uuid

    call :post, "instance/#{machine.id}", assign_volume: '',
        file: disk.path, device: disk.device
  end

  private
  def self.sum_up object, &property
    object.map(&property).inject(0, &:+)
  end

  def self.operation operation, id
    call :post, 'instances', operation => '', name: id
  end

  def self.determine_status response
    status = case response[:status]
      when 1
        :running
      when 3
        :suspended
      when 5
        response[:has_managed_save_image] == 1 ? :saved : :stopped
      else
        :unknown
    end
    Machine::Status.find status
  end

  def self.build_all_instances response
    machines = response.instances.map do |machine|
      Machine.new \
          hostname: machine[:name],
          memory: machine[:memory],
          disks: Wvm::Disk.array_of(machine.storage)
    end
    machines.sort_by &:hostname
  end
end
