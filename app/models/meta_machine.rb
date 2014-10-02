class MetaMachine < ActiveRecord::Base
  belongs_to :user


  before_destroy do
    machine.delete
  end

  def machine
    Infra::Machine.find libvirt_machine_name
  end
end
