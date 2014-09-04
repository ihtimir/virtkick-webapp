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
          type: disk.storage
    end
    Disks.new array
  end

  def self.create disk, machine
    raise unless disk.type =~ /\A[a-z]+\Z/

    device = machine.disks.next_device_name
    name = machine.uuid + '_' + device # TODO: introduce subdirectory per VM


    gigabytes = disk.size / 1.gigabytes
    format = disk.format || 'qcow2'
    meta_prealloc = format == 'qcow2'

    call :post, "storage/#{disk.type}", add_volume: '',
        name: name, size: gigabytes, format: format, meta_prealloc: meta_prealloc
  end
end
