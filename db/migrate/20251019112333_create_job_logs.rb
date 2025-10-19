class CreateJobLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :job_logs do |t|
      t.string :job_name, null: false

      t.timestamps
    end
  end
end
