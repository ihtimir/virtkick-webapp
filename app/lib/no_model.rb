class NoModel < ActiveHash::Base
  def persisted?
    true
  end
end