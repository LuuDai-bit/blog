module ErrorHandler
  def self.included(klass)
    klass.class_eval do
      rescue_from StandardError, with: :internal_server_error_message
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_message
    end
  end

  private

  def internal_server_error_message(error)
    Rails.logger.info("Internal server error: #{error.message}")
    render json: { message: 'Something went wrong. Please check the log or contact admin' }, status: :internal_server_error
  end

  def record_not_found_message(error)
    Rails.logger.info("Record not found: #{error.message}")
    render json: { message: 'Record not found' }, status: :not_found
  end
end
