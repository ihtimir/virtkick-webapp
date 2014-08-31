class Disks < Elements
  def usage
    used / size
  end

  def size
    sum &:size
  end

  def used
    sum &:used
  end
end
