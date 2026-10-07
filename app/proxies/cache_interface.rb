module CacheInterface
  def show(id, options = {})
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end
end
