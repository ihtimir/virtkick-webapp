class MachineActionJob < BaseJob
  def perform meta_machine_id, action
    machine = MetaMachine.find(meta_machine_id).machine
    machine.public_send action
  end
end
