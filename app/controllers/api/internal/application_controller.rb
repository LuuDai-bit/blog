module Api
  module Internal
    class ApplicationController < ApplicationController
      # Implement authorization
      include ErrorHandler
    end
  end
end
