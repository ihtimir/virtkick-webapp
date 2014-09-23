class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable

  has_many :meta_machines


  def machines
    Infra::Elements.new self.meta_machines.map &:machine
  end
end
