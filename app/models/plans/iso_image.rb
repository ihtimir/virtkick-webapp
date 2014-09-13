class Plans::IsoImage < ActiveYaml::Base
  include ActiveHash::Associations
  set_root_path 'app/models'

  field :id
  field :path
  field :bit
  field :short_name
  field :full_name
  field :enabled, default: true

  belongs_to :iso_distro, class_name: 'Plans::IsoDistro'
end
