class Forms::NewMachine
  include ActiveModel::Model

  attr_accessor :hostname
  attr_accessor :image_type
  attr_writer :plan_id, :iso_distro_id, :iso_image_id

  validates :hostname, presence: true
  validates :plan_id, presence: true, numericality: {only_integer: true}
  validates :iso_distro_id, presence: true, numericality: {only_integer: true}

  attr_reader :machine
  attr_accessor :current_user


  def save
    return if invalid?

    machine = Wvm::Machine.create self
    current_user.meta_machines.create! \
        hostname: hostname,
        libvirt_machine_name: hostname,
        libvirt_hypervisor_id: 1 # TODO: support for multiple hypervisors
    machine
  end

  def plan_id
    @plan_id ? @plan_id.to_i : nil
  end

  def iso_distro_id
    @iso_distro_id ? @iso_distro_id.to_i : nil
  end

  def iso_image_id
    @iso_image_id ? @iso_image_id.to_i : nil
  end

  def plan
    Defaults::MachinePlan.find plan_id if @plan_id
  end

  def iso_distro
    Plans::IsoDistro.find iso_distro_id if @iso_distro_id
  end

  def iso_image
    Plans::IsoImage.find iso_image_id if @iso_image_id
  end

  def self.check_params params, current_user
    params = params.require(:machine).permit(:hostname, :image_type, :plan_id, :iso_distro_id, :iso_image_id)
    params[:current_user] = current_user
    params
  end
end
