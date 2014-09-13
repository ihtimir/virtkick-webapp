require 'active_hash'

class Network < Base
  attr_accessor :mac
  attr_accessor :ip4, :ip6
  attr_accessor :pool_name
end
