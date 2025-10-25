class Statistic::AnnuallyPostProgressService < BaseService
  MAX_PROGRESS = 100

  def run
    current_day = Date.current
    start_day = current_day.beginning_of_year
    end_day = current_day.end_of_year
    posts_count = Post.count_post_by_time(start_day, end_day)
    target = Settings.target.annually_posts_count

    return MAX_PROGRESS if posts_count > target

    ((posts_count * 1.0 / target) * 100)
      .round(Settings.statistic.default_statistic_decimal_place)
  end
end
