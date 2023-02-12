class Statistic::PostStatisticService < BaseService
  def initialize(target_day, statistic_type)
    @target_day = target_day
    @statistic_type = statistic_type
  end

  def run
    Post.count_post_by_time(start_time, end_time)
  end

  private
  attr_reader :target_day, :statistic_type

  def start_time
    case statistic_type
    when Settings.models.post.statistic.post_per_week
      target_day.beginning_of_week
    when Settings.models.post.statistic.post_per_month
      target_day.beginning_of_month
    else
      target_day.beginning_of_day
    end
  end

  def end_time
    case statistic_type
    when Settings.models.post.statistic.post_per_week
      target_day.end_of_week
    when Settings.models.post.statistic.post_per_month
      target_day.end_of_month
    else
      target_day.end_of_day
    end
  end
end
