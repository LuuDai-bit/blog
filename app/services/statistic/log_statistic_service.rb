class Statistic::LogStatisticService < BaseService
  def run
    total_access_in_month = logs_in_month.length
    total_request_in_month = logs_in_month.inject(0) do |total, log|
      total + log.access_count if log.access_count.present?
    end
    highest_request_in_month = logs_in_month.pluck(:access_count).max

    access_object(total_access_in_month, total_request_in_month, highest_request_in_month)
  end

  private
  def logs_in_month
    @logs_in_month ||= Log.where("date_part('month', created_at) = #{current_time.month}")
  end

  def current_time
    @current_time ||= Time.current
  end

  def access_object(total_access_in_month, total_request_in_month, highest_request_in_month)
    {
      total_access_in_month: total_access_in_month,
      total_request_in_month: total_request_in_month,
      highest_request_in_month: highest_request_in_month
    }
  end
end
