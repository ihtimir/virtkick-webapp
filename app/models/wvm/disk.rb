class Wvm::Disk < Wvm::Base
  def self.array_of disks
    array = disks.map do |disk|
      ::Disk.new \
          used: disk.allocation,
          size: disk.capacity,
          device: disk.dev,
          path: disk.path,
          name: disk.image,
          format: disk.format,
          pool: disk.storage
    end
    Disks.new array
  end
end
