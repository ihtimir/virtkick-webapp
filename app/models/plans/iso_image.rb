class Plans::IsoImage < ActiveYaml::Base
  include ActiveHash::Associations
  set_root_path 'app/models'

  field :id
  field :file
  field :pool_name
  field :bit
  field :short_name
  field :full_name
  field :enabled, default: true

  belongs_to :iso_distro, class_name: 'Plans::IsoDistro'


  def path
    DiskType.find(pool_name).path + '/' + file
  end
end
