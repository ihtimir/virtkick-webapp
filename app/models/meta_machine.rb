class MetaMachine < ActiveRecord::Base
  belongs_to :user

  def machine
    Infra::Machine.find libvirt_machine_name
  end
end
