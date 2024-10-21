class AddEndAtToAnnouncements < ActiveRecord::Migration[7.1]
  def change
    add_column :announcements, :end_at, :datetime
  end
end
