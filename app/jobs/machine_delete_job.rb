class MachineDeleteJob < BaseRepeatableJob
  def perform meta_machine_id
    machine = MetaMachine.find meta_machine_id
    machine.destroy
  end
end
