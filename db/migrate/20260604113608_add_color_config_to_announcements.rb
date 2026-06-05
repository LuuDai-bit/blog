class AddColorConfigToAnnouncements < ActiveRecord::Migration[8.1]
  def change
    add_column :announcements, :color_config, :string, default: "default", null: false
  end
end
