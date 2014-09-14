require 'active_hash'

class Defaults::MachinePlan < ActiveHash::Base
  plans = [
      [0.5, 20, 'SSD', 1],
      [1, 30, 'SSD', 1],
      [2, 50, 'SSD', 2],
      [4, 70, 'SSD', 2],
      [8, 90, 'SSD', 3]
  ]

  self.data = plans.map.with_index do |plan, i|
    {
      id: i + 1, memory: plan[0], cpu: plan[3],
      storage: plan[1].gigabytes, storage_type: plan[2]
    }
  end
end
