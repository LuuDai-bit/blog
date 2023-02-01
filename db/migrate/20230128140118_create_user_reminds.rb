class CreateUserReminds < ActiveRecord::Migration[6.1]
  def change
    create_table :user_reminders do |t|
      t.references :user, foreign_key: true
      t.references :reminder, foreign_key: true

      t.timestamps
    end
  end
end
