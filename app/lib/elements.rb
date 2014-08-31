require 'active_hash'

class Elements < Array
  include Enumerable

  def deep_sum *properties
    obj = self
    while property = properties.shift
      proc = property.to_proc
      obj = obj.map(&proc).flatten
    end
    obj.sum
  end
end
