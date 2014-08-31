class Errors < StandardError
  attr_reader :errors

  def initialize errors
    @errors = errors
  end

  def message
    @errors.map(&:to_s).to_s
  end
end
