class NextDeviceName
  def next *current
    candidates = current.map &:succ
    available_names = candidates - current
    available_names.sort.first
  end
end