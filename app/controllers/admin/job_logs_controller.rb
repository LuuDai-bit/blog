class Admin::JobLogsController < Admin::AdminController
  def index
    @pagy, @job_logs = pagy(JobLog.by_name(params[:job_name]).order(id: :desc))
  end
end
