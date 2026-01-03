module NotificationServices
  class Base
    def initialize(destination)
      @destination = destination
    end

    def send_notification(destination, recipient, message)
      raise NotImplementedError, "This #{self.class} cannot respond to:"
    end

    private

    attr_reader :destination
  end
end
