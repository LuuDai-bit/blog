class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.string :ip_address
      t.bigint :access_count, default: 0

      t.timestamps

      t.index :ip_address
    end
  end
end
