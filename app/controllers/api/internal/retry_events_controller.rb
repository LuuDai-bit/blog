module Api
  module Internal
    class RetryEventsController < Api::Internal::ApplicationController
      def create
        raise ActiveRecord::RecordNotFound unless valid_event_id?

        retry_event = RetryEvent.find_by(event_id: params[:event_id])
        retry_event = RetryEvent.new(event_id: params[:event_id]) if retry_event.blank?

        if retry_event.retry_count >= Settings.models.retry_event.max_retry
          render json: { message: 'Max retry limit reached'}, status: :unprocessable_entity
          return
        end

        retry_event.increase_retry_count
        RedisModel::Event.create(queue: 'default_jobs', params: params_string)

        render json: { message: 'Success', event_id: params[:event_id] }
      end

      private

      def params_string
        params[:original_params]
      end

      def valid_event_id?
        JobLog.exists?(event_id: params[:event_id])
      end
    end
  end
end
