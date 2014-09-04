class Wvm::StoragePool < Wvm::Base
  def self.all
    response = call :get, 'storages'

    response.storages.map do |storage_pool|
      DiskType.new \
          name: storage_pool.name,
          enabled: storage_pool.enabled
    end
  end
end
