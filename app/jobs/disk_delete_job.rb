class DiskDeleteJob < BaseRepeatableJob
  def perform meta_machine_id, disk_id
    machine = MetaMachine.find(meta_machine_id).machine
    disk = machine.disks.find disk_id
    machine.delete_disk disk
  end
end
