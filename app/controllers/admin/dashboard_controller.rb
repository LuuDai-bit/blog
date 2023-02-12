class Admin::DashboardController < Admin::AdminController
  def index
    target_day = params[:target_day] || Time.current
    @post_per_week = Statistic::PostStatisticService.run(target_day, Settings.models.post.statistic.post_per_week)
    @post_per_month = Statistic::PostStatisticService.run(target_day, Settings.models.post.statistic.post_per_month)
    @server_cost = Statistic::CalculateServerCostService.run
  end
end
