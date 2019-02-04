# Single responsibility object with a single class method entrypoint but instance-based implementation.
class Service
  class << self
    def call(*args)
      send(:new, *args).call
    end
  end

  private_class_method :new

  # Abstract
  def call
    raise NotImplementedError, "define this method on your subclass."
  end
end
