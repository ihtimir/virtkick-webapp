require 'active_hash'

class Defaults::DiskSize < ActiveHash::Base
  self.data = [10, 25, 50, 100, 250, 500, 1000].map.with_index do |gigabytes, i|
    {id: i, name: gigabytes, size: gigabytes.gigabytes}
  end
end