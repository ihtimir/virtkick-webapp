require 'active_hash'

class Elements < Array
  include Enumerable

  def deep_sum *properties
    obj = self
    while property = properties.shift
      proc = property.to_proc
      obj = obj.map(&proc).flatten.compact
    end

    puts obj.sum
    obj ? obj.sum : 0
  end
end
