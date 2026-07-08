module Api
  module Internal
    class RetryEventsController < Api::Internal::ApplicationController
      def retry_failed_job
        retry_event = RetryEvent.find_by(event_id: params[:event_id])
        if retry_event.retry_count >= Settings.models.retry_event.max_retry
          render json: { message: 'Max retry limit reached'}
        end

        retry_event.increase_retry_count
        RedisModel::Event.create(queue: 'default_jobs', params: params_string)
      end

      private

      def params_string
        params[:original_params]
      end
    end
  end
end
