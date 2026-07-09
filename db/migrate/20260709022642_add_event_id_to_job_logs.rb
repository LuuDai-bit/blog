class AddEventIdToJobLogs < ActiveRecord::Migration[8.1]
  def change
    add_column :job_logs, :event_id, :string
  end
end
