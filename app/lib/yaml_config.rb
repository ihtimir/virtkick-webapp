require 'active_support/hash_with_indifferent_access'

class YamlConfig
  def initialize config_name
    config_file = File.join Rails.root, 'config', "#{config_name}.yml"
    config = YAML.load_file(config_file)[Rails.env]

    @config = if config.is_a? Array
      config.map &:deep_symbolize_keys
    else
      config.deep_symbolize_keys
    end
  end

  def method_missing method, *args
    @config.public_send method, *args
  end
end
