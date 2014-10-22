require 'ipaddress'

class Wvm::Setup < Wvm::Base
  def self.setup
    response = call :post, '/servers', host_ssh_add: '',
        name: hypervisor[:name],
        hostname: hypervisor[:host],
        login: hypervisor[:login]
    # TODO: save response.id

    # network
    # storage pools
    # download ISO
  end
end
