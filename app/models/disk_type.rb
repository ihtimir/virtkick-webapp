require 'active_hash'

class DiskType < Base
  attr_accessor :id, :name
  attr_accessor :enabled

  def self.all
    Wvm::StoragePool.all
  end

  def id
    name
  end
end
