class DiskCreateJob < BaseRepeatableJob
  def perform meta_machine_id, disk_params
    machine = MetaMachine.find(meta_machine_id).machine
    disk = Infra::Disk.new disk_params
    machine.create_disk disk
  end
end
