require 'active_hash'

class Defaults::MachinePlan < ActiveHash::Base
  plans = [[0.5, 20, 1], [1, 30, 1], [2, 50, 2], [4, 70, 2], [8, 90, 3]]

  self.data = plans.map.with_index do |plan, i|
    {id: i + 1, memory: plan[0], storage: plan[1].gigabytes, cpu: plan[2]}
  end
end
