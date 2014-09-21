class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :trackable, :validatable

  has_many :meta_machines


  def machines
    Infra::Elements.new self.meta_machines.map &:machine
  end

  def find_meta_machine id
    self.meta_machines.find_by!(libvirt_machine_name: id)
  end

  def find_machine id
    find_meta_machine(id).machine
  end
end
