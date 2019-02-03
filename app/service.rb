# Single responsibility object
class Service
  class << self
    def call(*args)
      send(:new, args).call
    end
  end

  private_class_method :initialize

  # Abstract
  def call
    raise NotImplementedError, "define this method on your subclass."
  end
end
